Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC63CC05024
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.42605.1712912573436435911
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ZFj6q/Pv;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7004E1BF20A;
	Fri, 12 Apr 2024 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN31MXJ6x0z63HKFCHdAEI3fsKCSq29RWTQJuXJc+HE=;
	b=ZFj6q/Pvj+I32F+2pCWrBqnHqEX288FRc3QsunxiNx/5VgoKDrdnRQo9IV14DTf0UIj6nW
	EcOTl1bHGSI7Ygprb4ICwbBoUXgJ+OVtyjwUgHsR+in9Qt2UwGs6CD0g8TfeZnElxsjgdI
	7thVSlwBTAIQDM7oKBeLkKtu8iiHmccTCWhtJK3doItQAJ6JQMhA6V1/Nw73B3GQrPj9zG
	srTIlqhciK6pWPw83TkohbznLmqMT2eEA4ee3Xikbe4CzKJPabaFfU6fxAMt2jT37Gczjl
	Kz800yBZ2cmtIw0QYndvvxWtOLrrSwto2SDMlKIPIFwCpsCHrgBUVi5ucOZEIg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 06/12] prserv: capitalization and spacing improvements
Date: Fri, 12 Apr 2024 11:02:28 +0200
Message-Id: <20240412090234.4110915-7-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16082

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Choosing only one style of capitalization
Add extra space after some commas too
Remove idle spaces

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/__init__.py |  2 +-
 lib/prserv/db.py       | 56 +++++++++++++++++++++---------------------
 lib/prserv/serv.py     | 10 ++++----
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 5790a8db1e..0e0aa34d0e 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -7,7 +7,7 @@
 __version__ = "1.0.0"
 
 import os, time
-import sys,logging
+import sys, logging
 
 def init_logger(logfile, loglevel):
     numeric_level = getattr(logging, loglevel.upper(), None)
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 0859cf4f2c..7bc2b2dc2d 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -38,9 +38,9 @@ class PRTable(object):
         self.read_only = read_only
         self.dirty = False
         if nohist:
-            self.table = "%s_nohist" % table 
+            self.table = "%s_nohist" % table
         else:
-            self.table = "%s_hist" % table 
+            self.table = "%s_hist" % table
 
         if self.read_only:
             table_exists = self._execute(
@@ -78,7 +78,7 @@ class PRTable(object):
             self.sync()
             self.dirty = False
 
-    def _getValueHist(self, version, pkgarch, checksum):
+    def _get_value_hist(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
         row=data.fetchone()
@@ -87,7 +87,7 @@ class PRTable(object):
         else:
             #no value found, try to insert
             if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
                                    (version, pkgarch))
                 row = data.fetchone()
                 if row is not None:
@@ -96,9 +96,9 @@ class PRTable(object):
                     return 0
 
             try:
-                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
-                           % (self.table,self.table),
-                           (version,pkgarch, checksum,version, pkgarch))
+                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
+                           % (self.table, self.table),
+                           (version, pkgarch, checksum, version, pkgarch))
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
@@ -112,10 +112,10 @@ class PRTable(object):
             else:
                 raise prserv.NotFoundError
 
-    def _getValueNohist(self, version, pkgarch, checksum):
+    def _get_value_no_hist(self, version, pkgarch, checksum):
         data=self._execute("SELECT value FROM %s \
                             WHERE version=? AND pkgarch=? AND checksum=? AND \
-                            value >= (select max(value) from %s where version=? AND pkgarch=?);" 
+                            value >= (select max(value) from %s where version=? AND pkgarch=?);"
                             % (self.table, self.table),
                             (version, pkgarch, checksum, version, pkgarch))
         row=data.fetchone()
@@ -124,7 +124,7 @@ class PRTable(object):
         else:
             #no value found, try to insert
             if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
                                    (version, pkgarch))
                 row = data.fetchone()
                 if row is not None:
@@ -133,8 +133,8 @@ class PRTable(object):
                     return 0
 
             try:
-                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
-                               % (self.table,self.table),
+                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
+                               % (self.table, self.table),
                                (version, pkgarch, checksum, version, pkgarch))
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
@@ -150,17 +150,17 @@ class PRTable(object):
             else:
                 raise prserv.NotFoundError
 
-    def getValue(self, version, pkgarch, checksum):
+    def get_value(self, version, pkgarch, checksum):
         if self.nohist:
-            return self._getValueNohist(version, pkgarch, checksum)
+            return self._get_value_no_hist(version, pkgarch, checksum)
         else:
-            return self._getValueHist(version, pkgarch, checksum)
+            return self._get_value_hist(version, pkgarch, checksum)
 
-    def _importHist(self, version, pkgarch, checksum, value):
+    def _import_hist(self, version, pkgarch, checksum, value):
         if self.read_only:
             return None
 
-        val = None 
+        val = None
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
         row = data.fetchone()
@@ -183,27 +183,27 @@ class PRTable(object):
                 val = row[0]
         return val
 
-    def _importNohist(self, version, pkgarch, checksum, value):
+    def _import_no_hist(self, version, pkgarch, checksum, value):
         if self.read_only:
             return None
 
         try:
             #try to insert
             self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                           (version, pkgarch, checksum,value))
+                           (version, pkgarch, checksum, value))
         except sqlite3.IntegrityError as exc:
             #already have the record, try to update
             try:
-                self._execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"  
+                self._execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"
                               % (self.table),
-                               (value,version,pkgarch,checksum,value))
+                               (value, version, pkgarch, checksum, value))
             except sqlite3.IntegrityError as exc:
                 logger.error(str(exc))
 
         self.dirty = True
 
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
-                            (version,pkgarch,checksum,value))
+                            (version, pkgarch, checksum, value))
         row=data.fetchone()
         if row is not None:
             return row[0]
@@ -212,13 +212,13 @@ class PRTable(object):
 
     def importone(self, version, pkgarch, checksum, value):
         if self.nohist:
-            return self._importNohist(version, pkgarch, checksum, value)
+            return self._import_no_hist(version, pkgarch, checksum, value)
         else:
-            return self._importHist(version, pkgarch, checksum, value)
+            return self._import_hist(version, pkgarch, checksum, value)
 
     def export(self, version, pkgarch, checksum, colinfo):
         metainfo = {}
-        #column info 
+        #column info
         if colinfo:
             metainfo["tbl_name"] = self.table
             metainfo["core_ver"] = prserv.__version__
@@ -238,7 +238,7 @@ class PRTable(object):
 
         if self.nohist:
             sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
-                    (SELECT version,pkgarch,max(value) as maxvalue FROM %s GROUP BY version,pkgarch) as T2 \
+                    (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
                     WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
         else:
             sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
@@ -302,7 +302,7 @@ class PRData(object):
     def disconnect(self):
         self.connection.close()
 
-    def __getitem__(self,tblname):
+    def __getitem__(self, tblname):
         if not isinstance(tblname, str):
             raise TypeError("tblname argument must be a string, not '%s'" %
                             type(tblname))
@@ -316,4 +316,4 @@ class PRData(object):
         if tblname in self._tables:
             del self._tables[tblname]
         logger.info("drop table %s" % (tblname))
-        self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname) 
+        self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname)
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index ab9a0a66df..efb2e0cf93 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -50,7 +50,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
 
         response = None
         try:
-            value = self.server.table.getValue(version, pkgarch, checksum)
+            value = self.server.table.get_value(version, pkgarch, checksum)
             response = {"value": value}
         except prserv.NotFoundError:
             self.logger.error("can not find value for (%s, %s)",version, checksum)
@@ -173,16 +173,16 @@ def run_as_daemon(func, pidfile, logfile):
     # potentially hanging on a pipe. Handle both cases.
     si = open("/dev/null", "r")
     try:
-        os.dup2(si.fileno(),sys.stdin.fileno())
+        os.dup2(si.fileno(), sys.stdin.fileno())
     except (AttributeError, io.UnsupportedOperation):
         sys.stdin = si
     so = open(logfile, "a+")
     try:
-        os.dup2(so.fileno(),sys.stdout.fileno())
+        os.dup2(so.fileno(), sys.stdout.fileno())
     except (AttributeError, io.UnsupportedOperation):
         sys.stdout = so
     try:
-        os.dup2(so.fileno(),sys.stderr.fileno())
+        os.dup2(so.fileno(), sys.stderr.fileno())
     except (AttributeError, io.UnsupportedOperation):
         sys.stderr = so
 
@@ -253,7 +253,7 @@ def stop_daemon(host, port):
             portstr = "Wrong port? Other ports listening at %s: %s" % (host, " ".join(ports))
 
         sys.stderr.write("pidfile %s does not exist. Daemon not running? %s\n"
-                         % (pidfile,portstr))
+                         % (pidfile, portstr))
         return 1
 
     try:
-- 
2.34.1


