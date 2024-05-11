Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E237BC41513
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:25 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.12403.1715425397140969634
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=izuDNN/t;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DC4E240003;
	Sat, 11 May 2024 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODdu5QRdd+SzcgKWLKuta/ecvYz3eNeGEG0ZNYDUBRY=;
	b=izuDNN/tcu2jdazZ7YZhiZ+r+WMFLYZN7cKiLJMQN5oOT/ryQ4Rt6/4inVJE1FJtVA4tE5
	gjKHd6oOKqBkP3gY6CxGZeqSHcFaKMomrVsktUK2Q79yXAti5Dyrizfyzjw7TCg2Aaqyll
	w23AyrJhY3+dgg3bvysxYw+eK4GjGSLu0Z2jiwu/BiHoX42yw0UlUi+O1FHsb+Gs1rHzKH
	mm6EDk5xAvLWFo/ecKqQdIRb30Q072zv4AfzbGnI2twWMMaCzdTWN4+hM+3NhBUAO3EP/T
	+XEwgSlmQDBJXLganAJ233VPGFOfa+5wAFxKDJWnbZyRNuMrrqSyekA/fr/wXQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 4/8] prserv: enable database sharing
Date: Sat, 11 May 2024 16:31:31 +0530
Message-Id: <20240511110135.1887578-5-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
References: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 May 2024 11:03:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16203

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

sqlite3 can allow multiple processes to access the database
simultaneously, but it must be opened correctly. The key change is that
the database is no longer opened in "exclusive" mode (defaulting to
shared mode). In addition, the journal is set to "WAL" mode, as this is
the most efficient for dealing with simultaneous access between
different processes. In order to keep the database performance,
synchronous mode is set to "off". The WAL journal will protect against
incomplete transactions in any given client, however the database will
not be protected against unexpected power loss from the OS (which is a
fine trade off for performance, and also the same as the previous
implementation).

The use of a database cursor enabled to remove the _execute() wrapper.
The cursor automatically makes sure that the query happens in an atomic
transaction and commits when finished.

This also removes the need for a "dirty" flag for the database and
for explicit database syncing, which simplifies the code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/db.py   | 322 +++++++++++++++++++++------------------------
 lib/prserv/serv.py |   9 --
 2 files changed, 151 insertions(+), 180 deletions(-)

diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index b2520f3158..f430586d73 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -8,21 +8,13 @@ import logging
 import os.path
 import errno
 import prserv
-import time
+import sqlite3
 
+from contextlib import closing
 from . import increase_revision, revision_greater, revision_smaller
 
-try:
-    import sqlite3
-except ImportError:
-    from pysqlite2 import dbapi2 as sqlite3
-
 logger = logging.getLogger("BitBake.PRserv")
 
-sqlversion = sqlite3.sqlite_version_info
-if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
-    raise Exception("sqlite3 version 3.3.0 or later is required.")
-
 #
 # "No History" mode - for a given query tuple (version, pkgarch, checksum),
 # the returned value will be the largest among all the values of the same
@@ -31,40 +23,28 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 # "History" mode - Return a new higher value for previously unseen query
 # tuple (version, pkgarch, checksum), otherwise return historical value.
 # Value can decrement if returning to a previous build.
-#
 
 class PRTable(object):
     def __init__(self, conn, table, read_only):
         self.conn = conn
         self.read_only = read_only
-        self.dirty = False
         self.table = table
 
-        if self.read_only:
-            table_exists = self._execute(
-                        "SELECT count(*) FROM sqlite_master \
-                        WHERE type='table' AND name='%s'" % (self.table))
-            if not table_exists:
-                raise prserv.NotFoundError
-        else:
-            self._execute("CREATE TABLE IF NOT EXISTS %s \
-                        (version TEXT NOT NULL, \
-                        pkgarch TEXT NOT NULL,  \
-                        checksum TEXT NOT NULL, \
-                        value TEXT, \
-                        PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
-
-    def _execute(self, *query):
-        """Execute a query, waiting to acquire a lock if necessary"""
-        start = time.time()
-        end = start + 20
-        while True:
-            try:
-                return self.conn.execute(*query)
-            except sqlite3.OperationalError as exc:
-                if "is locked" in str(exc) and end > time.time():
-                    continue
-                raise exc
+        with closing(self.conn.cursor()) as cursor:
+            if self.read_only:
+                table_exists = cursor.execute(
+                            "SELECT count(*) FROM sqlite_master \
+                            WHERE type='table' AND name='%s'" % (self.table))
+                if not table_exists:
+                    raise prserv.NotFoundError
+            else:
+                cursor.execute("CREATE TABLE IF NOT EXISTS %s \
+                            (version TEXT NOT NULL, \
+                            pkgarch TEXT NOT NULL,  \
+                            checksum TEXT NOT NULL, \
+                            value TEXT, \
+                            PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
+                self.conn.commit()
 
     def _extremum_value(self, rows, is_max):
         value = None
@@ -88,49 +68,42 @@ class PRTable(object):
     def _min_value(self, rows):
         return self._extremum_value(rows, False)
 
-    def sync(self):
-        if not self.read_only:
-            self.conn.commit()
-            self._execute("BEGIN EXCLUSIVE TRANSACTION")
-
-    def sync_if_dirty(self):
-        if self.dirty:
-            self.sync()
-            self.dirty = False
-
     def test_package(self, version, pkgarch):
         """Returns whether the specified package version is found in the database for the specified architecture"""
 
         # Just returns the value if found or None otherwise
-        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=?;" % self.table,
-                           (version, pkgarch))
-        row=data.fetchone()
-        if row is not None:
-            return True
-        else:
-            return False
+        with closing(self.conn.cursor()) as cursor:
+            data=cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=?;" % self.table,
+                               (version, pkgarch))
+            row=data.fetchone()
+            if row is not None:
+                return True
+            else:
+                return False
 
     def test_value(self, version, pkgarch, value):
         """Returns whether the specified value is found in the database for the specified package and architecture"""
 
         # Just returns the value if found or None otherwise
-        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? and value=?;" % self.table,
-                           (version, pkgarch, value))
-        row=data.fetchone()
-        if row is not None:
-            return True
-        else:
-            return False
+        with closing(self.conn.cursor()) as cursor:
+            data=cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? and value=?;" % self.table,
+                               (version, pkgarch, value))
+            row=data.fetchone()
+            if row is not None:
+                return True
+            else:
+                return False
 
 
     def find_package_max_value(self, version, pkgarch):
         """Returns the greatest value for (version, pkgarch), or None if not found. Doesn't create a new value"""
 
-        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=?;" % (self.table),
-                             (version, pkgarch))
-        rows = data.fetchall()
-        value = self._max_value(rows)
-        return value
+        with closing(self.conn.cursor()) as cursor:
+            data = cursor.execute("SELECT value FROM %s where version=? AND pkgarch=?;" % (self.table),
+                                 (version, pkgarch))
+            rows = data.fetchall()
+            value = self._max_value(rows)
+            return value
 
     def find_value(self, version, pkgarch, checksum, history=False):
         """Returns the value for the specified checksum if found or None otherwise."""
@@ -145,10 +118,11 @@ class PRTable(object):
         """Returns the maximum (if is_max is True) or minimum (if is_max is False) value
            for (version, pkgarch, checksum), or None if not found. Doesn't create a new value"""
 
-        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=? AND checksum=?;" % (self.table),
-                             (version, pkgarch, checksum))
-        rows = data.fetchall()
-        return self._extremum_value(rows, is_max)
+        with closing(self.conn.cursor()) as cursor:
+            data = cursor.execute("SELECT value FROM %s where version=? AND pkgarch=? AND checksum=?;" % (self.table),
+                                 (version, pkgarch, checksum))
+            rows = data.fetchall()
+            return self._extremum_value(rows, is_max)
 
     def find_max_value(self, version, pkgarch, checksum):
         return self._find_extremum_value(version, pkgarch, checksum, True)
@@ -160,26 +134,27 @@ class PRTable(object):
         """Take and increase the greatest "<base>.y" value for (version, pkgarch), or return "<base>.0" if not found.
         This doesn't store a new value."""
 
-        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=? AND value LIKE '%s.%%';" % (self.table, base),
-                             (version, pkgarch))
-        rows = data.fetchall()
-        value = self._max_value(rows)
+        with closing(self.conn.cursor()) as cursor:
+            data = cursor.execute("SELECT value FROM %s where version=? AND pkgarch=? AND value LIKE '%s.%%';" % (self.table, base),
+                                 (version, pkgarch))
+            rows = data.fetchall()
+            value = self._max_value(rows)
 
-        if value is not None:
-            return increase_revision(value)
-        else:
-            return base + ".0"
+            if value is not None:
+                return increase_revision(value)
+            else:
+                return base + ".0"
 
     def store_value(self, version, pkgarch, checksum, value):
         """Store new value in the database"""
 
-        try:
-            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                       (version, pkgarch, checksum, value))
-        except sqlite3.IntegrityError as exc:
-            logger.error(str(exc))
-
-        self.dirty = True
+        with closing(self.conn.cursor()) as cursor:
+            try:
+                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                           (version, pkgarch, checksum, value))
+            except sqlite3.IntegrityError as exc:
+                logger.error(str(exc))
+            self.conn.commit()
 
     def _get_value(self, version, pkgarch, checksum, history):
 
@@ -215,54 +190,56 @@ class PRTable(object):
             return None
 
         val = None
-        data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+        with closing(self.conn.cursor()) as cursor:
+            data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
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
+            row = data.fetchone()
+            if row is not None:
+                val=row[0]
+            else:
+                #no value found, try to insert
+                try:
+                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                               (version, pkgarch, checksum, value))
+                except sqlite3.IntegrityError as exc:
+                    logger.error(str(exc))
 
-            self.dirty = True
+                self.conn.commit()
 
-            data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
-            row = data.fetchone()
-            if row is not None:
-                val = row[0]
+                row = data.fetchone()
+                if row is not None:
+                    val = row[0]
         return val
 
     def _import_no_hist(self, version, pkgarch, checksum, value):
         if self.read_only:
             return None
 
-        try:
-            #try to insert
-            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
-                           (version, pkgarch, checksum, value))
-        except sqlite3.IntegrityError as exc:
-            #already have the record, try to update
+        with closing(self.conn.cursor()) as cursor:
             try:
-                self._execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"
-                              % (self.table),
-                               (value, version, pkgarch, checksum, value))
+                #try to insert
+                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                               (version, pkgarch, checksum, value))
             except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
+                #already have the record, try to update
+                try:
+                    cursor.execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"
+                                  % (self.table),
+                                   (value, version, pkgarch, checksum, value))
+                except sqlite3.IntegrityError as exc:
+                    logger.error(str(exc))
 
-        self.dirty = True
+                self.conn.commit()
 
-        data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
+            data = cursor.execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
                             (version, pkgarch, checksum, value))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
-        else:
-            return None
+            row=data.fetchone()
+            if row is not None:
+                return row[0]
+            else:
+                return None
 
     def importone(self, version, pkgarch, checksum, value, history=False):
         if history:
@@ -272,56 +249,57 @@ class PRTable(object):
 
     def export(self, version, pkgarch, checksum, colinfo, history=False):
         metainfo = {}
-        #column info
-        if colinfo:
-            metainfo["tbl_name"] = self.table
-            metainfo["core_ver"] = prserv.__version__
-            metainfo["col_info"] = []
-            data = self._execute("PRAGMA table_info(%s);" % self.table)
+        with closing(self.conn.cursor()) as cursor:
+            #column info
+            if colinfo:
+                metainfo["tbl_name"] = self.table
+                metainfo["core_ver"] = prserv.__version__
+                metainfo["col_info"] = []
+                data = cursor.execute("PRAGMA table_info(%s);" % self.table)
+                for row in data:
+                    col = {}
+                    col["name"] = row["name"]
+                    col["type"] = row["type"]
+                    col["notnull"] = row["notnull"]
+                    col["dflt_value"] = row["dflt_value"]
+                    col["pk"] = row["pk"]
+                    metainfo["col_info"].append(col)
+
+            #data info
+            datainfo = []
+
+            if history:
+                sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
+            else:
+                sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
+                        (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
+                        WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
+            sqlarg = []
+            where = ""
+            if version:
+                where += "AND T1.version=? "
+                sqlarg.append(str(version))
+            if pkgarch:
+                where += "AND T1.pkgarch=? "
+                sqlarg.append(str(pkgarch))
+            if checksum:
+                where += "AND T1.checksum=? "
+                sqlarg.append(str(checksum))
+
+            sqlstmt += where + ";"
+
+            if len(sqlarg):
+                data = cursor.execute(sqlstmt, tuple(sqlarg))
+            else:
+                data = cursor.execute(sqlstmt)
             for row in data:
-                col = {}
-                col["name"] = row["name"]
-                col["type"] = row["type"]
-                col["notnull"] = row["notnull"]
-                col["dflt_value"] = row["dflt_value"]
-                col["pk"] = row["pk"]
-                metainfo["col_info"].append(col)
-
-        #data info
-        datainfo = []
-
-        if history:
-            sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
-        else:
-            sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
-                    (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
-                    WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
-        sqlarg = []
-        where = ""
-        if version:
-            where += "AND T1.version=? "
-            sqlarg.append(str(version))
-        if pkgarch:
-            where += "AND T1.pkgarch=? "
-            sqlarg.append(str(pkgarch))
-        if checksum:
-            where += "AND T1.checksum=? "
-            sqlarg.append(str(checksum))
-
-        sqlstmt += where + ";"
-
-        if len(sqlarg):
-            data = self._execute(sqlstmt, tuple(sqlarg))
-        else:
-            data = self._execute(sqlstmt)
-        for row in data:
-            if row["version"]:
-                col = {}
-                col["version"] = row["version"]
-                col["pkgarch"] = row["pkgarch"]
-                col["checksum"] = row["checksum"]
-                col["value"] = row["value"]
-                datainfo.append(col)
+                if row["version"]:
+                    col = {}
+                    col["version"] = row["version"]
+                    col["pkgarch"] = row["pkgarch"]
+                    col["checksum"] = row["checksum"]
+                    col["value"] = row["value"]
+                    datainfo.append(col)
         return (metainfo, datainfo)
 
     def dump_db(self, fd):
@@ -345,14 +323,15 @@ class PRData(object):
                 raise e
         uri = "file:%s%s" % (self.filename, "?mode=ro" if self.read_only else "")
         logger.debug("Opening PRServ database '%s'" % (uri))
-        self.connection=sqlite3.connect(uri, uri=True, isolation_level="EXCLUSIVE", check_same_thread = False)
+        self.connection=sqlite3.connect(uri, uri=True)
         self.connection.row_factory=sqlite3.Row
-        if not self.read_only:
-            self.connection.execute("pragma synchronous = off;")
-            self.connection.execute("PRAGMA journal_mode = MEMORY;")
+        self.connection.execute("PRAGMA synchronous = OFF;")
+        self.connection.execute("PRAGMA journal_mode = WAL;")
+        self.connection.commit()
         self._tables={}
 
     def disconnect(self):
+        self.connection.commit()
         self.connection.close()
 
     def __getitem__(self, tblname):
@@ -370,3 +349,4 @@ class PRData(object):
             del self._tables[tblname]
         logger.info("drop table %s" % (tblname))
         self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname)
+        self.connection.commit()
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 05573d06cc..3992056f88 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -42,10 +42,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         try:
             return await super().dispatch_message(msg)
         except:
-            self.server.table.sync()
             raise
-        else:
-            self.server.table.sync_if_dirty()
 
     async def handle_test_pr(self, request):
         '''Finds the PR value corresponding to the request. If not found, returns None and doesn't insert a new value'''
@@ -233,15 +230,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
         return tasks
 
     async def stop(self):
-        self.table.sync_if_dirty()
         self.db.disconnect()
         await super().stop()
 
-    def signal_handler(self):
-        super().signal_handler()
-        if self.table:
-            self.table.sync()
-
 class PRServSingleton(object):
     def __init__(self, dbfile, logfile, host, port, upstream):
         self.dbfile = dbfile
-- 
2.34.1


