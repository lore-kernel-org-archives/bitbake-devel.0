Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A65C04FFE
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.42604.1712912573430602650
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BW+k1mj4;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFD0EFF806;
	Fri, 12 Apr 2024 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5k/BEDMv9ApMbsVgOA4DZUlF+i54NuQkfvdm/XCpGI=;
	b=BW+k1mj4uvqXPOr3fvVv4XZmzcHM95n4M0q8yhbYMmwnvxjc9zTfXc1Y0ISQbdD2oU1Z6A
	Ju4xt3T2Gz2tF4rwOunduwybc4VEn5jT3Kbwv61WuGaUpbsbu/mBWpluSP3efuT3aRETgu
	5z45RsmKxeqPZQiReH6g3xb/JL8IQRaW5fzorhdo53YjpaK0l6FQlMsOZYh2cdUpk3kJI5
	6e1x9bcPpQt///go0wdbq/Mu19UiRZv8CBuSekWtCJCl9CuahvIvqOJiOTOPqzRlxK9rIZ
	MyI6f/6vTbufykCfpFh3203TWfuTl570qMuVrnGKEWcpJ1iqf6j/EwfKWK2Ojg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 07/12] prserv: add extra requests
Date: Fri, 12 Apr 2024 11:02:29 +0200
Message-Id: <20240412090234.4110915-8-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16081

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Useful for connecting a PR server to an upstream one

- "test-package" checks whether the specified package
  version and arch is known in the database.

- "test-pr" checks a specified output hash is found in the database.
  Otherwise it returns 'None' instead of a new value.

- "max-package-pr" returns the highest PR number for
  (version, arch) entries in the database, and None if not found

Add new DB functions supporting the above, plus test_value()
which tells whether a given value is available for the specified
package and architecture.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/client.py | 23 +++++++++++++++++++++-
 lib/prserv/db.py     | 46 ++++++++++++++++++++++++++++++++++++++++++++
 lib/prserv/serv.py   | 28 +++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

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
index 7bc2b2dc2d..7c200602ed 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -78,6 +78,52 @@ class PRTable(object):
             self.sync()
             self.dirty = False
 
+    def test_package(self, version, pkgarch):
+        """Returns whether the specified package version is found in the database for the specified architecture"""
+
+        # Just returns the value if found or None otherwise
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
+        # Just returns the value if found or None otherwise
+        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? and value=?;" % self.table,
+                           (version, pkgarch, value))
+        row=data.fetchone()
+        if row is not None:
+            return True
+        else:
+            return False
+
+    def find_value(self, version, pkgarch, checksum):
+        """Returns the value for the specified checksum if found or None otherwise."""
+
+        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                           (version, pkgarch, checksum))
+        row=data.fetchone()
+        if row is not None:
+            return row[0]
+        else:
+            return None
+
+    def find_max_value(self, version, pkgarch):
+        """Returns the greatest value for (version, pkgarch), or None if not found. Doesn't create a new value"""
+
+        data = self._execute("SELECT max(value) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                             (version, pkgarch))
+        row = data.fetchone()
+        if row is not None:
+            return row[0]
+        else:
+            return None
+
     def _get_value_hist(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index efb2e0cf93..86bd3bb75f 100644
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
+        '''Finds the greatest PR value for (version, pkgarch) in the db. Returns None if no entry was found'''
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


