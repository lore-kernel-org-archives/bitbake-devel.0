Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A3C25B5F
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:15 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.12292.1715425392496049331
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bZQ8MPbs;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 147F0C0002;
	Sat, 11 May 2024 11:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JnAyTYs4YAapjKqoVSrW1H27wfA076ofoRN/O5Qoes=;
	b=bZQ8MPbsC9R0XTMBAbRt6nfPiwXQKG1wrdoExnHIEoICnGs5wxG/HVLqkWIeD+WZ1IF1eu
	EcFnz2g0YIoo6ox10fpwAXFv71Zmj6cnNxoVzJGEJ0K6cnGzAwtTXmWV4obiniOO23LGgo
	w86VeO34ydsgHW+27bvDqNEcuZuYanTH9+RlHAiTrD1O2SnznibNC6DoPSDczO2SBTW6J2
	YjRmLQHbAbwNdS8N2ze5pW5eMYmB92hg7Z/YEUf8/3/f39YXwHmERAXGBbmw5hUy5nbSg/
	dRBkIS+HD1tZKrLsDfJeJzZP12HChgwgc34iQfkjZ8qLMAuTgmQALIM4yFOn1A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 3/8] prserv: add "upstream" server support
Date: Sat, 11 May 2024 16:31:30 +0530
Message-Id: <20240511110135.1887578-4-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
References: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 May 2024 11:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16202

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Introduce a PRSERVER_UPSTREAM variable that makes the
local PR server connect to an "upstream" one.

This makes it possible to implement local fixes to an
upstream package (revision "x", in a way that gives the local
update priority (revision "x.y").

Update the calculation of the new revisions to support the
case when prior revisions are not integers, but have
an "x.y..." format."

Set the comments in the handle_get_pr() function in serv.py
for details about the calculation of the local revision.

This is done by going on supporting the "history" mode that
wasn't used so far (revisions can return to a previous historical value),
in addition to the default "no history" mode (revisions can never decrease).

Rather than storing the history mode in the database table
itself (i.e. "PRMAIN_hist" and "PRMAIN_nohist"), the history mode
is now passed through the client requests. As a consequence, the
table name is now "PRMAIN", which is incompatible with what
was generated before, but avoids confusion if we kept the "PRMAIN_nohist"
name for both "history" and "no history" modes.

Update the server version to "2.0.0".

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 bin/bitbake-prserv     |  17 +++-
 lib/prserv/__init__.py |  90 +++++++++++++++++-
 lib/prserv/client.py   |  17 ++--
 lib/prserv/db.py       | 205 ++++++++++++++++++++++-------------------
 lib/prserv/serv.py     | 134 +++++++++++++++++++++++----
 5 files changed, 338 insertions(+), 125 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 920663a1d8..580e021fda 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -16,7 +16,7 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib
 import prserv
 import prserv.serv
 
-VERSION = "1.1.0"
+VERSION = "2.0.0"
 
 PRHOST_DEFAULT="0.0.0.0"
 PRPORT_DEFAULT=8585
@@ -77,12 +77,25 @@ def main():
         action="store_true",
         help="open database in read-only mode",
     )
+    parser.add_argument(
+        "-u",
+        "--upstream",
+        default=os.environ.get("PRSERVER_UPSTREAM", None),
+        help="Upstream PR service (host:port)",
+    )
 
     args = parser.parse_args()
     init_logger(os.path.abspath(args.log), args.loglevel)
 
     if args.start:
-        ret=prserv.serv.start_daemon(args.file, args.host, args.port, os.path.abspath(args.log), args.read_only)
+        ret=prserv.serv.start_daemon(
+            args.file,
+            args.host,
+            args.port,
+            os.path.abspath(args.log),
+            args.read_only,
+            args.upstream
+        )
     elif args.stop:
         ret=prserv.serv.stop_daemon(args.host, args.port)
     else:
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 94658b815d..a817b03c1e 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -4,4 +4,92 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-__version__ = "1.0.0"
+
+__version__ = "2.0.0"
+
+import logging
+logger = logging.getLogger("BitBake.PRserv")
+
+from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
+
+def create_server(addr, dbpath, upstream=None, read_only=False):
+    from . import serv
+
+    s = serv.PRServer(dbpath, upstream=upstream, read_only=read_only)
+    host, port = addr.split(":")
+    s.start_tcp_server(host, int(port))
+
+    return s
+
+def increase_revision(ver):
+    """Take a revision string such as "1" or "1.2.3" or even a number and increase its last number
+    This fails if the last number is not an integer"""
+
+    fields=str(ver).split('.')
+    last = fields[-1]
+
+    try:
+         val = int(last)
+    except Exception as e:
+         logger.critical("Unable to increase revision value %s: %s" % (ver, e))
+         raise e
+
+    return ".".join(fields[0:-1] + list(str(val + 1)))
+
+def _revision_greater_or_equal(rev1, rev2):
+    """Compares x.y.z revision numbers, using integer comparison
+    Returns True if rev1 is greater or equal to rev2"""
+
+    fields1 = rev1.split(".")
+    fields2 = rev2.split(".")
+    l1 = len(fields1)
+    l2 = len(fields2)
+
+    for i in range(l1):
+       val1 = int(fields1[i])
+       if i < l2:
+           val2 = int(fields2[i])
+           if val2 < val1:
+              return True
+           elif val2 > val1:
+              return False
+       else:
+          return True
+    return True
+
+def revision_smaller(rev1, rev2):
+    """Compares x.y.z revision numbers, using integer comparison
+    Returns True if rev1 is strictly smaller than rev2"""
+    return not(_revision_greater_or_equal(rev1, rev2))
+
+def revision_greater(rev1, rev2):
+    """Compares x.y.z revision numbers, using integer comparison
+    Returns True if rev1 is strictly greater than rev2"""
+    return _revision_greater_or_equal(rev1, rev2) and (rev1 != rev2)
+
+def create_client(addr):
+    from . import client
+
+    c = client.PRClient()
+
+    try:
+        (typ, a) = parse_address(addr)
+        c.connect_tcp(*a)
+        return c
+    except Exception as e:
+        c.close()
+        raise e
+
+async def create_async_client(addr):
+    from . import client
+
+    c = client.PRAsyncClient()
+
+    try:
+        (typ, a) = parse_address(addr)
+        await c.connect_tcp(*a)
+        return c
+
+    except Exception as e:
+        await c.close()
+        raise e
diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 99fc4e0f7f..565c6f3872 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -6,6 +6,7 @@
 
 import logging
 import bb.asyncrpc
+from . import create_async_client
 
 logger = logging.getLogger("BitBake.PRserv")
 
@@ -13,16 +14,16 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
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
 
-    async def test_pr(self, version, pkgarch, checksum):
+    async def test_pr(self, version, pkgarch, checksum, history=False):
         response = await self.invoke(
-            {"test-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum}}
+            {"test-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "history": history}}
         )
         if response:
             return response["value"]
@@ -41,16 +42,16 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
         if response:
             return response["value"]
 
-    async def importone(self, version, pkgarch, checksum, value):
+    async def importone(self, version, pkgarch, checksum, value, history=False):
         response = await self.invoke(
-            {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value}}
+            {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value, "history": history}}
         )
         if response:
             return response["value"]
 
-    async def export(self, version, pkgarch, checksum, colinfo):
+    async def export(self, version, pkgarch, checksum, colinfo, history=False):
         response = await self.invoke(
-            {"export": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "colinfo": colinfo}}
+            {"export": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "colinfo": colinfo, "history": history}}
         )
         if response:
             return (response["metainfo"], response["datainfo"])
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index eb41508198..b2520f3158 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -10,6 +10,8 @@ import errno
 import prserv
 import time
 
+from . import increase_revision, revision_greater, revision_smaller
+
 try:
     import sqlite3
 except ImportError:
@@ -32,15 +34,11 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 #
 
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
@@ -53,8 +51,8 @@ class PRTable(object):
                         (version TEXT NOT NULL, \
                         pkgarch TEXT NOT NULL,  \
                         checksum TEXT NOT NULL, \
-                        value INTEGER, \
-                        PRIMARY KEY (version, pkgarch, checksum));" % self.table)
+                        value TEXT, \
+                        PRIMARY KEY (version, pkgarch, checksum, value));" % self.table)
 
     def _execute(self, *query):
         """Execute a query, waiting to acquire a lock if necessary"""
@@ -68,6 +66,28 @@ class PRTable(object):
                     continue
                 raise exc
 
+    def _extremum_value(self, rows, is_max):
+        value = None
+
+        for row in rows:
+            current_value = row[0]
+            if value is None:
+                value = current_value
+            else:
+                if is_max:
+                    is_new_extremum = revision_greater(current_value, value)
+                else:
+                    is_new_extremum = revision_smaller(current_value, value)
+                if  is_new_extremum:
+                    value = current_value
+        return value
+
+    def _max_value(self, rows):
+        return self._extremum_value(rows, True)
+
+    def _min_value(self, rows):
+        return self._extremum_value(rows, False)
+
     def sync(self):
         if not self.read_only:
             self.conn.commit()
@@ -102,101 +122,93 @@ class PRTable(object):
         else:
             return False
 
-    def find_value(self, version, pkgarch, checksum):
+
+    def find_package_max_value(self, version, pkgarch):
+        """Returns the greatest value for (version, pkgarch), or None if not found. Doesn't create a new value"""
+
+        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=?;" % (self.table),
+                             (version, pkgarch))
+        rows = data.fetchall()
+        value = self._max_value(rows)
+        return value
+
+    def find_value(self, version, pkgarch, checksum, history=False):
         """Returns the value for the specified checksum if found or None otherwise."""
 
-        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
+        if history:
+            return self.find_min_value(version, pkgarch, checksum)
         else:
-            return None
+            return self.find_max_value(version, pkgarch, checksum)
 
-    def find_max_value(self, version, pkgarch):
-        """Returns the greatest value for (version, pkgarch), or None if not found. Doesn't create a new value"""
 
-        data = self._execute("SELECT max(value) FROM %s where version=? AND pkgarch=?;" % (self.table),
+    def _find_extremum_value(self, version, pkgarch, checksum, is_max):
+        """Returns the maximum (if is_max is True) or minimum (if is_max is False) value
+           for (version, pkgarch, checksum), or None if not found. Doesn't create a new value"""
+
+        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=? AND checksum=?;" % (self.table),
+                             (version, pkgarch, checksum))
+        rows = data.fetchall()
+        return self._extremum_value(rows, is_max)
+
+    def find_max_value(self, version, pkgarch, checksum):
+        return self._find_extremum_value(version, pkgarch, checksum, True)
+
+    def find_min_value(self, version, pkgarch, checksum):
+        return self._find_extremum_value(version, pkgarch, checksum, False)
+
+    def find_new_subvalue(self, version, pkgarch, base):
+        """Take and increase the greatest "<base>.y" value for (version, pkgarch), or return "<base>.0" if not found.
+        This doesn't store a new value."""
+
+        data = self._execute("SELECT value FROM %s where version=? AND pkgarch=? AND value LIKE '%s.%%';" % (self.table, base),
                              (version, pkgarch))
-        row = data.fetchone()
-        if row is not None:
-            return row[0]
-        else:
-            return None
+        rows = data.fetchall()
+        value = self._max_value(rows)
 
-    def _get_value_hist(self, version, pkgarch, checksum):
-        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                           (version, pkgarch, checksum))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
+        if value is not None:
+            return increase_revision(value)
         else:
-            #no value found, try to insert
-            if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
-                                   (version, pkgarch))
-                row = data.fetchone()
-                if row is not None:
-                    return row[0]
-                else:
-                    return 0
+            return base + ".0"
 
-            try:
-                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-                           % (self.table, self.table),
-                           (version, pkgarch, checksum, version, pkgarch))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
+    def store_value(self, version, pkgarch, checksum, value):
+        """Store new value in the database"""
 
-            self.dirty = True
+        try:
+            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                       (version, pkgarch, checksum, value))
+        except sqlite3.IntegrityError as exc:
+            logger.error(str(exc))
 
-            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                               (version, pkgarch, checksum))
-            row=data.fetchone()
-            if row is not None:
-                return row[0]
-            else:
-                raise prserv.NotFoundError
+        self.dirty = True
 
-    def _get_value_no_hist(self, version, pkgarch, checksum):
-        data=self._execute("SELECT value FROM %s \
-                            WHERE version=? AND pkgarch=? AND checksum=? AND \
-                            value >= (select max(value) from %s where version=? AND pkgarch=?);"
-                            % (self.table, self.table),
-                            (version, pkgarch, checksum, version, pkgarch))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
-        else:
-            #no value found, try to insert
-            if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
-                                   (version, pkgarch))
-                return data.fetchone()[0]
+    def _get_value(self, version, pkgarch, checksum, history):
 
-            try:
-                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-                               % (self.table, self.table),
-                               (version, pkgarch, checksum, version, pkgarch))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
-                self.conn.rollback()
+        max_value = self.find_package_max_value(version, pkgarch)
 
-            self.dirty = True
+        if max_value is None:
+            # version, pkgarch completely unknown. Return initial value.
+            return "0"
 
-            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                               (version, pkgarch, checksum))
-            row=data.fetchone()
-            if row is not None:
-                return row[0]
-            else:
-                raise prserv.NotFoundError
+        value = self.find_value(version, pkgarch, checksum, history)
 
-    def get_value(self, version, pkgarch, checksum):
-        if self.nohist:
-            return self._get_value_no_hist(version, pkgarch, checksum)
+        if value is None:
+            # version, pkgarch found but not checksum. Create a new value from the maximum one
+            return increase_revision(max_value)
+
+        if history:
+            return value
+
+        # "no history" mode - If the value is not the maximum value for the package, need to increase it.
+        if max_value > value:
+            return increase_revision(max_value)
         else:
-            return self._get_value_hist(version, pkgarch, checksum)
+            return value
+
+    def get_value(self, version, pkgarch, checksum, history):
+        value = self._get_value(version, pkgarch, checksum, history)
+        if not self.read_only:
+            self.store_value(version, pkgarch, checksum, value)
+        return value
 
     def _import_hist(self, version, pkgarch, checksum, value):
         if self.read_only:
@@ -252,13 +264,13 @@ class PRTable(object):
         else:
             return None
 
-    def importone(self, version, pkgarch, checksum, value):
-        if self.nohist:
-            return self._import_no_hist(version, pkgarch, checksum, value)
-        else:
+    def importone(self, version, pkgarch, checksum, value, history=False):
+        if history:
             return self._import_hist(version, pkgarch, checksum, value)
+        else:
+            return self._import_no_hist(version, pkgarch, checksum, value)
 
-    def export(self, version, pkgarch, checksum, colinfo):
+    def export(self, version, pkgarch, checksum, colinfo, history=False):
         metainfo = {}
         #column info
         if colinfo:
@@ -278,12 +290,12 @@ class PRTable(object):
         #data info
         datainfo = []
 
-        if self.nohist:
+        if history:
+            sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
+        else:
             sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
                     (SELECT version, pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
                     WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
-        else:
-            sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
         sqlarg = []
         where = ""
         if version:
@@ -322,9 +334,8 @@ class PRTable(object):
 
 class PRData(object):
     """Object representing the PR database"""
-    def __init__(self, filename, nohist=True, read_only=False):
+    def __init__(self, filename, read_only=False):
         self.filename=os.path.abspath(filename)
-        self.nohist=nohist
         self.read_only = read_only
         #build directory hierarchy
         try:
@@ -351,7 +362,7 @@ class PRData(object):
         if tblname in self._tables:
             return self._tables[tblname]
         else:
-            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist, self.read_only)
+            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.read_only)
             return tableobj
 
     def __delitem__(self, tblname):
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index dc4be5b620..05573d06cc 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -12,6 +12,7 @@ import sqlite3
 import prserv
 import prserv.db
 import errno
+from . import create_async_client, revision_smaller, increase_revision
 import bb.asyncrpc
 
 logger = logging.getLogger("BitBake.PRserv")
@@ -51,8 +52,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         version = request["version"]
         pkgarch = request["pkgarch"]
         checksum = request["checksum"]
+        history = request["history"]
 
-        value = self.server.table.find_value(version, pkgarch, checksum)
+        value = self.server.table.find_value(version, pkgarch, checksum, history)
         return {"value": value}
 
     async def handle_test_package(self, request):
@@ -68,22 +70,110 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         version = request["version"]
         pkgarch = request["pkgarch"]
 
-        value = self.server.table.find_max_value(version, pkgarch)
+        value = self.server.table.find_package_max_value(version, pkgarch)
         return {"value": value}
 
     async def handle_get_pr(self, request):
         version = request["version"]
         pkgarch = request["pkgarch"]
         checksum = request["checksum"]
+        history = request["history"]
 
-        response = None
-        try:
-            value = self.server.table.get_value(version, pkgarch, checksum)
-            response = {"value": value}
-        except prserv.NotFoundError:
-            self.logger.error("failure storing value in database for (%s, %s)",version, checksum)
+        if self.upstream_client is None:
+            value = self.server.table.get_value(version, pkgarch, checksum, history)
+            return {"value": value}
 
-        return response
+        # We have an upstream server.
+        # Check whether the local server already knows the requested configuration.
+        # If the configuration is a new one, the generated value we will add will
+        # depend on what's on the upstream server. That's why we're calling find_value()
+        # instead of get_value() directly.
+
+        value = self.server.table.find_value(version, pkgarch, checksum, history)
+        upstream_max = await self.upstream_client.max_package_pr(version, pkgarch)
+
+        if value is not None:
+
+            # The configuration is already known locally.
+
+            if history:
+                value = self.server.table.get_value(version, pkgarch, checksum, history)
+            else:
+                existing_value = value
+                # In "no history", we need to make sure the value doesn't decrease
+                # and is at least greater than the maximum upstream value
+                # and the maximum local value
+
+                local_max = self.server.table.find_package_max_value(version, pkgarch)
+                if revision_smaller(value, local_max):
+                    value = increase_revision(local_max)
+
+                if revision_smaller(value, upstream_max):
+                    # Ask upstream whether it knows the checksum
+                    upstream_value = await self.upstream_client.test_pr(version, pkgarch, checksum)
+                    if upstream_value is None:
+                        # Upstream doesn't have our checksum, let create a new one
+                        value = upstream_max + ".0"
+                    else:
+                        # Fine to take the same value as upstream
+                        value = upstream_max
+
+                if not value == existing_value and not self.server.read_only:
+                    self.server.table.store_value(version, pkgarch, checksum, value)
+
+            return {"value": value}
+
+        # The configuration is a new one for the local server
+        # Let's ask the upstream server whether it knows it
+
+        known_upstream = await self.upstream_client.test_package(version, pkgarch)
+
+        if not known_upstream:
+
+            # The package is not known upstream, must be a local-only package
+            # Let's compute the PR number using the local-only method
+
+            value = self.server.table.get_value(version, pkgarch, checksum, history)
+            return {"value": value}
+
+        # The package is known upstream, let's ask the upstream server
+        # whether it knows our new output hash
+
+        value = await self.upstream_client.test_pr(version, pkgarch, checksum)
+
+        if value is not None:
+
+            # Upstream knows this output hash, let's store it and use it too.
+
+            if not self.server.read_only:
+                self.server.table.store_value(version, pkgarch, checksum, value)
+            # If the local server is read only, won't be able to store the new
+            # value in the database and will have to keep asking the upstream server
+            return {"value": value}
+
+        # The output hash doesn't exist upstream, get the most recent number from upstream (x)
+        # Then, we want to have a new PR value for the local server: x.y
+
+        upstream_max = await self.upstream_client.max_package_pr(version, pkgarch)
+        # Here we know that the package is known upstream, so upstream_max can't be None
+        subvalue = self.server.table.find_new_subvalue(version, pkgarch, upstream_max)
+
+        if not self.server.read_only:
+            self.server.table.store_value(version, pkgarch, checksum, subvalue)
+
+        return {"value": subvalue}
+
+    async def process_requests(self):
+        if self.server.upstream is not None:
+            self.upstream_client = await create_async_client(self.server.upstream)
+        else:
+            self.upstream_client = None
+
+        try:
+            await super().process_requests()
+        finally:
+            if self.upstream_client is not None:
+                await self.upstream_client.close()
 
     async def handle_import_one(self, request):
         response = None
@@ -92,8 +182,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             pkgarch = request["pkgarch"]
             checksum = request["checksum"]
             value = request["value"]
+            history = request["history"]
 
-            value = self.server.table.importone(version, pkgarch, checksum, value)
+            value = self.server.table.importone(version, pkgarch, checksum, value, history)
             if value is not None:
                 response = {"value": value}
 
@@ -104,9 +195,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         pkgarch = request["pkgarch"]
         checksum = request["checksum"]
         colinfo = request["colinfo"]
+        history = request["history"]
 
         try:
-            (metainfo, datainfo) = self.server.table.export(version, pkgarch, checksum, colinfo)
+            (metainfo, datainfo) = self.server.table.export(version, pkgarch, checksum, colinfo, history)
         except sqlite3.Error as exc:
             self.logger.error(str(exc))
             metainfo = datainfo = None
@@ -117,11 +209,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         return {"readonly": self.server.read_only}
 
 class PRServer(bb.asyncrpc.AsyncServer):
-    def __init__(self, dbfile, read_only=False):
+    def __init__(self, dbfile, read_only=False, upstream=None):
         super().__init__(logger)
         self.dbfile = dbfile
         self.table = None
         self.read_only = read_only
+        self.upstream = upstream
 
     def accept_client(self, socket):
         return PRServerClient(socket, self)
@@ -134,6 +227,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
         self.logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
                      (self.dbfile, self.address, str(os.getpid())))
 
+        if self.upstream is not None:
+            self.logger.info("And upstream PRServer: %s " % (self.upstream))
+
         return tasks
 
     async def stop(self):
@@ -147,14 +243,15 @@ class PRServer(bb.asyncrpc.AsyncServer):
             self.table.sync()
 
 class PRServSingleton(object):
-    def __init__(self, dbfile, logfile, host, port):
+    def __init__(self, dbfile, logfile, host, port, upstream):
         self.dbfile = dbfile
         self.logfile = logfile
         self.host = host
         self.port = port
+        self.upstream = upstream
 
     def start(self):
-        self.prserv = PRServer(self.dbfile)
+        self.prserv = PRServer(self.dbfile, upstream=self.upstream)
         self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
         self.process = self.prserv.serve_as_process(log_level=logging.WARNING)
 
@@ -233,7 +330,7 @@ def run_as_daemon(func, pidfile, logfile):
     os.remove(pidfile)
     os._exit(0)
 
-def start_daemon(dbfile, host, port, logfile, read_only=False):
+def start_daemon(dbfile, host, port, logfile, read_only=False, upstream=None):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
@@ -249,7 +346,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
 
     dbfile = os.path.abspath(dbfile)
     def daemon_main():
-        server = PRServer(dbfile, read_only=read_only)
+        server = PRServer(dbfile, read_only=read_only, upstream=upstream)
         server.start_tcp_server(ip, port)
         server.serve_forever()
 
@@ -336,6 +433,9 @@ def auto_start(d):
 
     host = host_params[0].strip().lower()
     port = int(host_params[1])
+
+    upstream = d.getVar("PRSERV_UPSTREAM") or None
+
     if is_local_special(host, port):
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
@@ -350,7 +450,7 @@ def auto_start(d):
                auto_shutdown()
         if not singleton:
             bb.utils.mkdirhier(cachedir)
-            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), host, port)
+            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), host, port, upstream)
             singleton.start()
     if singleton:
         host = singleton.host
-- 
2.34.1


