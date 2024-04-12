Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E18C4345F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.42610.1712912577471693501
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XVpn6Ytl;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E87561BF20F;
	Fri, 12 Apr 2024 09:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAVCR34fY9T4tS0P9OHNq1KAyZM7hWfTARMo3Jggx1o=;
	b=XVpn6YtlarXeTz6eovqiPWmo2uXgz/61OsMgFrP9tb29cPzXtRGSlhEsWRJKKEQ1kp0aAc
	jD0c71E0Gux2A3bi4OonQWpEv60VSH++GF3fjYowbf3TmTZocwOCE0Xc6cVPzFcL7CDL7A
	Gdld80dnK+AQhUe31CBchzPiXV9RSlFK4pxGSKr7q6Y1WFYYu+TMK7ObJd8M4t6LyNw73a
	Z2jcUnncO+J5aViFHMx/sJj8vZHtD+EdAVPbSIKHzfIaNu2wpdC4vJnnhvRCeLo1N56ucT
	S7dNrWkeniUdX6pqAKDFefcS0uiHccUkGwNm+Aot9JcbFlbqgQFzRwGfx1z+dg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 12/12] prserv: add "history" argument to "get-pr" request
Date: Fri, 12 Apr 2024 11:02:34 +0200
Message-Id: <20240412090234.4110915-13-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 09:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16087

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to test the "history" mode in the
future bitbake selftests, to make sure that both "history"
and "no history" modes work as expected.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/client.py |  4 ++--
 lib/prserv/db.py     | 16 ++++++++--------
 lib/prserv/serv.py   |  5 +++--
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 89760b6f74..389172f055 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -14,9 +14,9 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
     def __init__(self):
         super().__init__("PRSERVICE", "1.0", logger)
 
-    async def getPR(self, version, pkgarch, checksum):
+    async def getPR(self, version, pkgarch, checksum, history=False):
         response = await self.invoke(
-            {"get-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum}}
+            {"get-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "history": history}}
         )
         if response:
             return response["value"]
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 8305238f7a..d41b781622 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -163,7 +163,7 @@ class PRTable(object):
 
         self.dirty = True
 
-    def _get_value(self, version, pkgarch, checksum):
+    def _get_value(self, version, pkgarch, checksum, history):
 
         max_value = self.find_max_value(version, pkgarch)
 
@@ -177,7 +177,11 @@ class PRTable(object):
             # version, pkgarch found but not checksum. Create a new value from the maximum one
             return increase_revision(max_value)
 
-        if self.nohist:
+        if history:
+            # "history" mode: we found an existing value. We can return it
+            # whether it's the maximum one or not.
+            return value
+        else:
             # "no-history" mode: only return a value if that's the maximum one for
             # the version and architecture, otherwise create a new one.
             # This means that the value cannot decrement.
@@ -185,13 +189,9 @@ class PRTable(object):
                 return value
             else:
                 return increase_revision(max_value)
-        else:
-            # "hist" mode: we found an existing value. We can return it
-            # whether it's the maximum one or not.
-            return value
 
-    def get_value(self, version, pkgarch, checksum):
-        value = self._get_value(version, pkgarch, checksum)
+    def get_value(self, version, pkgarch, checksum, history):
+        value = self._get_value(version, pkgarch, checksum, history)
         self.store_value(version, pkgarch, checksum, value)
         return value
 
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 9e07a34445..f692d050b8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -76,9 +76,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         version = request["version"]
         pkgarch = request["pkgarch"]
         checksum = request["checksum"]
+        history = request["history"]
 
         if self.upstream_client is None:
-            value = self.server.table.get_value(version, pkgarch, checksum)
+            value = self.server.table.get_value(version, pkgarch, checksum, history)
             return {"value": value}
 
         # We have an upstream server.
@@ -105,7 +106,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             # The package is not known upstream, must be a local-only package
             # Let's compute the PR number using the local-only method
 
-            value = self.server.table.get_value(version, pkgarch, checksum)
+            value = self.server.table.get_value(version, pkgarch, checksum, history)
             return {"value": value}
 
         # The package is known upstream, let's ask the upstream server
-- 
2.34.1


