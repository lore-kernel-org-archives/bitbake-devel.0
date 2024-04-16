Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19894C4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 17:20:35 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.27169.1713288029883508788
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Apr 2024 10:20:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dQp20IYy;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C93B2240003;
	Tue, 16 Apr 2024 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713288028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAVCR34fY9T4tS0P9OHNq1KAyZM7hWfTARMo3Jggx1o=;
	b=dQp20IYylc/okUJRIoG/KIrVgSv/Kn0ygqvnQk8C+g7HF/21uYOiKjQhqrZemLF7Tth7Qv
	saUNBsP7ZvAf/6FOL+IkKrCZT+nwrOLBZe3172BlpGr8TCqtS/OMgjJL23IVJN9vY1tDZ8
	qbInspv/DqTO0kpEPZDT/1Xb7FS9DDM6ZJbTY/Je+rTyJ1RHVryj/067sd0Xz5w0Do6Ag9
	6hLIvJBjSj9zhTPCvYxkhSZMCa/tVqRgDqYeuMUPmWj0j3b1gxmRXZd5yKwkYM9eIgvR1W
	B7TB9BkoLIsrugWViRL4aqY2lCO9IwdgJlGwvOofCK8ziFpUFfeaESBFP1e0NA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [RFC][PATCH 2/3] prserv: add "history" argument to "get-pr" request
Date: Tue, 16 Apr 2024 19:19:44 +0200
Message-Id: <20240416171945.3799445-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Apr 2024 17:20:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16100

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


