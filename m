Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E59CD129D
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:48 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.17406.1712335303784749590
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Qa7dObPy;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF3021C0007;
	Fri,  5 Apr 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kc1/iybPzPLhXi5jfyE4FbmtnulaZ7/i+rcd+Cu+gs=;
	b=Qa7dObPy9YWCRWsjNZ2Qd6I9MUm9KBe0FmragwDD51a0Kg5X6KMfKrhYHbQU0coqTPGoEI
	WOdqIjeGtTN/ED4wU5AOnMkNttEliZfwoEj/Y5RkgjoF0UTI7lrFjOfUHjVsRsEYZnRLUL
	USteX7Pn2Bb1zMi4PIGAPmGZw0IcNZS1f8M7M/3bGxQQMe8jSqIAGaD4bwaS/F71L73uPE
	ZLe91tqYspif9w4BpvJqMFFSppC+m7aTI73aFCNUhKxyeIjrFFNo0le6GVt2v8+diT3Fi8
	le8Pdc4y+VNoprD7No60msBDFiDkDACl7Lj165kZT5B3061s8pSTDE3WPNyiHQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2 07/12] prserv: remove unused "hist" mode in the database backend
Date: Fri,  5 Apr 2024 18:41:20 +0200
Message-Id: <20240405164125.1652579-8-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
References: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Apr 2024 16:41:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16055

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

The database was always created in "no_hist" mode.
Suppress the idle code to make db.py easier to maintain

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 lib/prserv/db.py | 109 ++++-------------------------------------------
 1 file changed, 9 insertions(+), 100 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 7bc2b2dc2d..5a7cb7e993 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -21,26 +21,12 @@ sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
     raise Exception("sqlite3 version 3.3.0 or later is required.")
 
-#
-# "No History" mode - for a given query tuple (version, pkgarch, checksum),
-# the returned value will be the largest among all the values of the same
-# (version, pkgarch). This means the PR value returned can NOT be decremented.
-#
-# "History" mode - Return a new higher value for previously unseen query
-# tuple (version, pkgarch, checksum), otherwise return historical value.
-# Value can decrement if returning to a previous build.
-#
-
 class PRTable(object):
-    def __init__(self, conn, table, nohist, read_only):
+    def __init__(self, conn, table, read_only):
         self.conn = conn
-        self.nohist = nohist
         self.read_only = read_only
         self.dirty = False
-        if nohist:
-            self.table = "%s_nohist" % table
-        else:
-            self.table = "%s_hist" % table
+        self.table = table
 
         if self.read_only:
             table_exists = self._execute(
@@ -78,41 +64,7 @@ class PRTable(object):
             self.sync()
             self.dirty = False
 
-    def _get_value_hist(self, version, pkgarch, checksum):
-        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
-        else:
-            #no value found, try to insert
-            if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
-                                   (version, pkgarch))
-                row = data.fetchone()
-                if row is not None:
-                    return row[0]
-                else:
-                    return 0
-
-            try:
-                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-                           % (self.table, self.table),
-                           (version, pkgarch, checksum, version, pkgarch))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
-
-            self.dirty = True
-
-            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                               (version, pkgarch, checksum))
-            row=data.fetchone()
-            if row is not None:
-                return row[0]
-            else:
-                raise prserv.NotFoundError
-
-    def _get_value_no_hist(self, version, pkgarch, checksum):
+    def get_value(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s \
                             WHERE version=? AND pkgarch=? AND checksum=? AND \
                             value >= (select max(value) from %s where version=? AND pkgarch=?);"
@@ -150,40 +102,7 @@ class PRTable(object):
             else:
                 raise prserv.NotFoundError
 
-    def get_value(self, version, pkgarch, checksum):
-        if self.nohist:
-            return self._get_value_no_hist(version, pkgarch, checksum)
-        else:
-            return self._get_value_hist(version, pkgarch, checksum)
-
-    def _import_hist(self, version, pkgarch, checksum, value):
-        if self.read_only:
-            return None
-
-        val = None
-        data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-        row = data.fetchone()
-        if row is not None:
-            val=row[0]
-        else:
-            #no value found, try to insert
-            try:
-                self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                           (version, pkgarch, checksum, value))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
-
-            self.dirty = True
-
-            data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-            row = data.fetchone()
-            if row is not None:
-                val = row[0]
-        return val
-
-    def _import_no_hist(self, version, pkgarch, checksum, value):
+    def importone(self, version, pkgarch, checksum, value):
         if self.read_only:
             return None
 
@@ -210,12 +129,6 @@ class PRTable(object):
         else:
             return None
 
-    def importone(self, version, pkgarch, checksum, value):
-        if self.nohist:
-            return self._import_no_hist(version, pkgarch, checksum, value)
-        else:
-            return self._import_hist(version, pkgarch, checksum, value)
-
     def export(self, version, pkgarch, checksum, colinfo):
         metainfo = {}
         #column info
@@ -236,12 +149,9 @@ class PRTable(object):
         #data info
         datainfo = []
 
-        if self.nohist:
-            sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
-                    (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
-                    WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
-        else:
-            sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
+        sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
+                (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
+                WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
         sqlarg = []
         where = ""
         if version:
@@ -280,9 +190,8 @@ class PRTable(object):
 
 class PRData(object):
     """Object representing the PR database"""
-    def __init__(self, filename, nohist=True, read_only=False):
+    def __init__(self, filename, read_only=False):
         self.filename=os.path.abspath(filename)
-        self.nohist=nohist
         self.read_only = read_only
         #build directory hierarchy
         try:
@@ -309,7 +218,7 @@ class PRData(object):
         if tblname in self._tables:
             return self._tables[tblname]
         else:
-            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist, self.read_only)
+            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.read_only)
             return tableobj
 
     def __delitem__(self, tblname):
-- 
2.34.1


