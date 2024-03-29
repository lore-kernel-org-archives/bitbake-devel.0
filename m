Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE646C6FD1F
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:38 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.33.1711723228392570366
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PTkCyWwn;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CE7840007;
	Fri, 29 Mar 2024 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4as4J5FGN4ALjb2DmyYWNX4DfULaVSrsMwFglLUpe14=;
	b=PTkCyWwnYRIIqDAGL8ULmm5H2RSgVUQBb7hxquQzfmGvksv/cyMge1mD/ZES2haXvpX7QU
	mp0JBa6JHZ+l5p7ERJIBGgoVMlpDiJcqXpeUkS7jaG8sSVB/f0R0WPdYIoo1e840DPU0go
	gVg1PG3MkWGaqMnFm8enBWylT74+Yz7lPSDJJLd1d7XhCbNG7QebBJB26HYG0Djk3oCgIw
	69kC4hLxxok0HoAmpVeSczC73qBBu3CnRnMwQq6TsKkF4CFa2c7gnXCkLPkcOfFsWhxhSy
	0WhOwaNXOS6OGZJ3DmfFutCqRvJ70Sok4C2ZExVYqSs09FQkM65EYXgkfB/gaA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 08/12] prserv: add extra requests
Date: Fri, 29 Mar 2024 15:39:52 +0100
Message-Id: <20240329143956.1602707-9-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16031

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Useful for connecting a PR server to an upstream one

- "test-package" checks whether the specified package
  version and arch is known in the database.

- "test-pr" checks a specified output hash is found in the database.
  Otherwise it returns 'None' instead of a new value.

- "max-package-pr" returns the highest PR number for
  (version, arch) entries in the database, and 0 if not found

Add new DB functions supporting the above, plus test_value()
which tells whether a given value is available for the specified
package and architecture.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/client.py | 23 ++++++++++++++++++++-
 lib/prserv/db.py     | 48 +++++++++++++++++++++++++++++++++++++++++++-
 lib/prserv/serv.py   | 28 ++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 7bc5188c53..8471ee3046 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -20,6 +20,27 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
         if response:
             return response["value"]
 
+    async def test_pr(self, version, pkgarch, checksum):
+        response = await self.invoke(
+            {"test-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum}}
+        )
+        if response:
+            return response["value"]
+
+    async def test_package(self, version, pkgarch):
+        response = await self.invoke(
+            {"test-package": {"version": version, "pkgarch": pkgarch}}
+        )
+        if response:
+            return response["value"]
+
+    async def max_package_pr(self, version, pkgarch):
+        response = await self.invoke(
+            {"max-package-pr": {"version": version, "pkgarch": pkgarch}}
+        )
+        if response:
+            return response["value"]
+
     async def importone(self, version, pkgarch, checksum, value):
         response = await self.invoke(
             {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value}}
@@ -44,7 +65,7 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
 class PRClient(bb.asyncrpc.Client):
     def __init__(self):
         super().__init__()
-        self._add_methods("getPR", "importone", "export", "is_readonly")
+        self._add_methods("getPR", "test_pr", "test_package", "importone", "export", "is_readonly")
 
     def _get_async_client(self):
         return PRAsyncClient()
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 7bc2b2dc2d..14b36ea6c9 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -78,12 +78,58 @@ class PRTable(object):
             self.sync()
             self.dirty = False
 
-    def _get_value_hist(self, version, pkgarch, checksum):
+    def test_package(self, version, pkgarch):
+        """Returns whether the specified package version is found in the database for the specified architecture"""
+
+	# Just returns the value if found or None otherwise
+        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=?;" % self.table,
+                           (version, pkgarch))
+        row=data.fetchone()
+        if row is not None:
+            return True
+        else:
+            return False
+
+    def test_value(self, version, pkgarch, value):
+        """Returns whether the specified value is found in the database for the specified package and architecture"""
+
+	# Just returns the value if found or None otherwise
+        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? and value=?;" % self.table,
+                           (version, pkgarch, value))
+        row=data.fetchone()
+        if row is not None:
+            return True
+        else:
+            return False
+
+    def find_value(self, version, pkgarch, checksum):
+        """Unlike get_value, just returns the value if found or None otherwise. Doesn't create a new value"""
+
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
         row=data.fetchone()
         if row is not None:
             return row[0]
+        else:
+            return None
+
+    def find_max_value(self, version, pkgarch):
+        """Returns the greatest value for (version, pkgarch), or "0" if not found. Doesn't create a new value"""
+
+        data = self._execute("SELECT max(value) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                             (version, pkgarch))
+        row = data.fetchone()
+        if row is not None:
+            return row[0]
+        else:
+            return "0"
+
+    def _get_value_hist(self, version, pkgarch, checksum):
+
+        val = find_value(self, version, pkgarch, checksum)
+
+        if val is not None:
+            return val
         else:
             #no value found, try to insert
             if self.read_only:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index efb2e0cf93..473dfa790c 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -26,6 +26,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
 
         self.handlers.update({
             "get-pr": self.handle_get_pr,
+            "test-pr": self.handle_test_pr,
+            "test-package": self.handle_test_package,
+            "max-package-pr": self.handle_max_package_pr,
             "import-one": self.handle_import_one,
             "export": self.handle_export,
             "is-readonly": self.handle_is_readonly,
@@ -43,6 +46,31 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         else:
             self.server.table.sync_if_dirty()
 
+    async def handle_test_pr(self, request):
+        '''Finds the PR value corresponding to the request. If not found, returns None and doesn't insert a new value'''
+        version = request["version"]
+        pkgarch = request["pkgarch"]
+        checksum = request["checksum"]
+
+        value = self.server.table.find_value(version, pkgarch, checksum)
+        return {"value": value}
+
+    async def handle_test_package(self, request):
+        '''Tells whether there are entries for (version, pkgarch) in the db. Returns True or False'''
+        version = request["version"]
+        pkgarch = request["pkgarch"]
+
+        value = self.server.table.test_package(version, pkgarch)
+        return {"value": value}
+
+    async def handle_max_package_pr(self, request):
+        '''Finds the greatest PR value for (version, pkgarch) in the db. Returns 0 if no entry was found'''
+        version = request["version"]
+        pkgarch = request["pkgarch"]
+
+        value = self.server.table.find_max_value(version, pkgarch)
+        return {"value": value}
+
     async def handle_get_pr(self, request):
         version = request["version"]
         pkgarch = request["pkgarch"]
-- 
2.34.1


