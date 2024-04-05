Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D4C67861
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:48 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.17410.1712335306539492346
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=phjSXFKW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05A06C0004;
	Fri,  5 Apr 2024 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJgvR4eAgy7LYMrTPzVTx3CrP/w7krZHAbt+61/4mF8=;
	b=phjSXFKWTxeAZymE+gIm1ebzKSN/oKYNmRFRypIltTPHo7V8IVGBc9x95VYLuTRjxreMiD
	lsDB7UjixcbMmmsHCTk04hxxUjHkXDcA05tgfQGYEsZPMnSF3x9ErBA1Eeb14CZFQXCR9v
	hdRIyAOVALpPiUwCmFGyS939BF5C/sjUIge3KUvC11hvhxaikbSDPI8XQjG5dY7ql+rmAq
	33kDfx2IcMc4lwDc9RxLjFcvQaTLpONZADlD76lE9uxvkgbb7RG5o7xujuACHWuppWbAYY
	GFR0Dh4l5TzxM7WndhQ7itWxEkHafmi5nWsjMSyaVrYIyMyLwmVm/GPBFBdILw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 12/12] prserv: add "upstream" server support
Date: Fri,  5 Apr 2024 18:41:25 +0200
Message-Id: <20240405164125.1652579-13-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16059

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

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 bin/bitbake-prserv     | 15 ++++++-
 lib/prserv/__init__.py | 15 +++++++
 lib/prserv/client.py   |  1 +
 lib/prserv/db.py       | 82 +++++++++++++++++++++++--------------
 lib/prserv/serv.py     | 93 +++++++++++++++++++++++++++++++++++++-----
 5 files changed, 165 insertions(+), 41 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index ad0a069401..e39d0fba87 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -70,12 +70,25 @@ def main():
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
     prserv.init_logger(os.path.abspath(args.log), args.loglevel)
 
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
index 0e0aa34d0e..2ee6a28c04 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -8,6 +8,7 @@ __version__ = "1.0.0"
 
 import os, time
 import sys, logging
+from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
 
 def init_logger(logfile, loglevel):
     numeric_level = getattr(logging, loglevel.upper(), None)
@@ -18,3 +19,17 @@ def init_logger(logfile, loglevel):
 
 class NotFoundError(Exception):
     pass
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
index 8471ee3046..89760b6f74 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -6,6 +6,7 @@
 
 import logging
 import bb.asyncrpc
+from . import create_async_client
 
 logger = logging.getLogger("BitBake.PRserv")
 
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index 7aad6a1576..d508fa19d4 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -21,6 +21,20 @@ sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
     raise Exception("sqlite3 version 3.3.0 or later is required.")
 
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
+
+    return ".".join(fields[0:-1] + list(str(val + 1)))
+
 class PRTable(object):
     def __init__(self, conn, table, read_only):
         self.conn = conn
@@ -39,7 +53,7 @@ class PRTable(object):
                         (version TEXT NOT NULL, \
                         pkgarch TEXT NOT NULL,  \
                         checksum TEXT NOT NULL, \
-                        value INTEGER, \
+                        value TEXT, \
                         PRIMARY KEY (version, pkgarch, checksum));" % self.table)
 
     def _execute(self, *query):
@@ -105,44 +119,52 @@ class PRTable(object):
         data = self._execute("SELECT max(value) FROM %s where version=? AND pkgarch=?;" % (self.table),
                              (version, pkgarch))
         row = data.fetchone()
-        if row is not None:
+        # With SELECT max() requests, you have an empty row when there are no values, therefore the test on row[0]
+        if row is not None and row[0] is not None:
             return row[0]
         else:
             return None
 
-    def get_value(self, version, pkgarch, checksum):
-        data=self._execute("SELECT value FROM %s \
-                            WHERE version=? AND pkgarch=? AND checksum=? AND \
-                            value >= (select max(value) from %s where version=? AND pkgarch=?);"
-                            % (self.table, self.table),
-                            (version, pkgarch, checksum, version, pkgarch))
-        row=data.fetchone()
-        if row is not None:
-            return row[0]
+    def find_new_subvalue(self, version, pkgarch, base):
+        """Take and increase the greatest "<base>.y" value for (version, pkgarch), or return "<base>.1" if not found.
+        This doesn't store a new value."""
+
+        data = self._execute("SELECT max(value) FROM %s where version=? AND pkgarch=? AND value LIKE '%s.%%';" % (self.table, base),
+                             (version, pkgarch))
+        row = data.fetchone()
+        # With SELECT max() requests, you have an empty row when there are no values, therefore the test on row[0]
+        if row is not None and row[0] is not None:
+            return increase_revision(row[0])
         else:
-            #no value found, try to insert
-            if self.read_only:
-                data = self._execute("SELECT ifnull(max(value)+1, 0) FROM %s where version=? AND pkgarch=?;" % (self.table),
-                                   (version, pkgarch))
-                return data.fetchone()[0]
+            return base + ".0"
 
-            try:
-                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s where version=? AND pkgarch=?));"
-                               % (self.table, self.table),
-                               (version, pkgarch, checksum, version, pkgarch))
-            except sqlite3.IntegrityError as exc:
-                logger.error(str(exc))
-                self.conn.rollback()
+    def store_value(self, version, pkgarch, checksum, value):
+        """Store new value in the database"""
 
-            self.dirty = True
+        try:
+            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                       (version, pkgarch, checksum, value))
+        except sqlite3.IntegrityError as exc:
+            logger.error(str(exc))
+
+        self.dirty = True
 
-            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
-                               (version, pkgarch, checksum))
-            row=data.fetchone()
-            if row is not None:
-                return row[0]
+    def get_value(self, version, pkgarch, checksum):
+        """Returns the matching value from the database or creates a new one if not found."""
+
+        value = self.find_value(version, pkgarch, checksum)
+
+        if value is None:
+            # Create a new value from the maximum one
+            max = self.find_max_value(version, pkgarch)
+
+            if max is None:
+                value = "0"
             else:
-                raise prserv.NotFoundError
+                value = increase_revision(max)
+            self.store_value(version, pkgarch, checksum, value)
+
+        return value
 
     def importone(self, version, pkgarch, checksum, value):
         if self.read_only:
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index dc4be5b620..91e2b13a31 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -12,6 +12,7 @@ import sqlite3
 import prserv
 import prserv.db
 import errno
+from . import create_async_client
 import bb.asyncrpc
 
 logger = logging.getLogger("BitBake.PRserv")
@@ -77,13 +78,77 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         checksum = request["checksum"]
 
         response = None
-        try:
+
+        if self.upstream_client is None:
             value = self.server.table.get_value(version, pkgarch, checksum)
             response = {"value": value}
-        except prserv.NotFoundError:
-            self.logger.error("failure storing value in database for (%s, %s)",version, checksum)
 
-        return response
+        # We have an upstream server.
+        # Check whether the local server already knows the requested configuration
+        # Here we use find_value(), not get_value(), because we don't want
+        # to unconditionally add a new generated value to the database. If the configuration
+        # is a new one, the generated value we will add will depend on what's on the upstream server.
+
+        value = self.server.table.find_value(version, pkgarch, checksum)
+
+        if value is not None:
+
+            # The configuration is already known locally. Let's use it.
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
+            value = self.server.table.get_value(version, pkgarch, checksum)
+            response = {"value": value}
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
+
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
@@ -117,11 +182,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
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
@@ -134,6 +200,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
         self.logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
                      (self.dbfile, self.address, str(os.getpid())))
 
+        if self.upstream is not None:
+            self.logger.info("And upstream PRServer: %s " % (self.upstream))
+
         return tasks
 
     async def stop(self):
@@ -147,14 +216,15 @@ class PRServer(bb.asyncrpc.AsyncServer):
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
 
@@ -233,7 +303,7 @@ def run_as_daemon(func, pidfile, logfile):
     os.remove(pidfile)
     os._exit(0)
 
-def start_daemon(dbfile, host, port, logfile, read_only=False):
+def start_daemon(dbfile, host, port, logfile, read_only=False, upstream=None):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
@@ -249,7 +319,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
 
     dbfile = os.path.abspath(dbfile)
     def daemon_main():
-        server = PRServer(dbfile, read_only=read_only)
+        server = PRServer(dbfile, read_only=read_only, upstream=upstream)
         server.start_tcp_server(ip, port)
         server.serve_forever()
 
@@ -336,6 +406,9 @@ def auto_start(d):
 
     host = host_params[0].strip().lower()
     port = int(host_params[1])
+
+    upstream = d.getVar("PRSERV_UPSTREAM") or None
+
     if is_local_special(host, port):
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
@@ -350,7 +423,7 @@ def auto_start(d):
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


