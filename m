Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D17CD1290
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:39 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.26.1711723229560428464
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=OOu3Ap28;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 103D01BF20A;
	Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YjOPBd+p/2Vclb251ml6/lEjMRJpb8URJLtbdkm7X4=;
	b=OOu3Ap28eWq1svBD9kqhQQtbpkSd3Bikxlj0dHU/xnsNON4McmrzxF5+/KLqQureNSs6So
	7NO0VfvBk9dMk1lTMxT7nDHutpXuu2UQTWhS1V/1O1lxA5USSKtGlxSLtIyyVxfcS4yW7P
	Ps8dvgilgPwTWQAiTfWZEkMIve7M9OJ4DvmxaDXwVVmb9GubOPuYbLbnSpJTUkvWicUrau
	voSNRbtKY8D7bvqg+rjZWV9jt84ha2Pof82mCHVHUNgjJ4s1blZffL4gZxe7hW7zEtLn4t
	4UDfI6QSQsiWrduh2O4mX//cOk33lsdsFozUJHZsPcBzHwZJOUSkl6LFGNHRjQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 12/12] prserv: add "upstream" server support
Date: Fri, 29 Mar 2024 15:39:56 +0100
Message-Id: <20240329143956.1602707-13-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16034

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Introduce a PRSERVER_UPSTREAM variable that makes the
local PR server connect to an "upstream" one.

This makes it possible to implement local fixes to an
upstream package (revision "x", in a way that gives the local
update priority (revision "x.y").

Set the comments in the handle_get_pr() function in serv.py
for details about the calculation of the local revision.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 bin/bitbake-prserv     |  15 +++++-
 lib/prserv/__init__.py |  15 ++++++
 lib/prserv/client.py   |   1 +
 lib/prserv/db.py       |  30 ++++++++++++
 lib/prserv/serv.py     | 106 ++++++++++++++++++++++++++++++++++++-----
 5 files changed, 154 insertions(+), 13 deletions(-)

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
index fddea923de..b581bbf072 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -124,6 +124,36 @@ class PRTable(object):
         else:
             return "0"
 
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
+    def find_new_subvalue(self, version, pkgarch, base):
+        """Returns the greatest "<base>.y" value for (version, pkgarch), or "<base>.1" if not found. Doesn't store a new value"""
+	# The code doesn't propose "<base>.0" because it would store it as "<base>" was declared as an integer
+
+        data = self._execute("SELECT ifnull(max(value)+0.1, %s.1) FROM %s where version=? AND pkgarch=? AND value LIKE '%s.%%';" % (base, self.table, base),
+                             (version, pkgarch))
+        return data.fetchone()[0]
+
+    def store_value(self, version, pkgarch, checksum, value):
+        '''Store new value in the database'''
+
+        try:
+            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                       (version, pkgarch, checksum, value))
+        except sqlite3.IntegrityError as exc:
+            logger.error(str(exc))
+
+        self.dirty = True
+
     def _get_value_hist(self, version, pkgarch, checksum):
 
         val = find_value(self, version, pkgarch, checksum)
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 604df6ce61..1461e27ad2 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -12,6 +12,7 @@ import sqlite3
 import prserv
 import prserv.db
 import errno
+from . import create_async_client
 import bb.asyncrpc
 
 logger = logging.getLogger("BitBake.PRserv")
@@ -77,13 +78,86 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         checksum = request["checksum"]
 
         response = None
-        try:
-            value = self.server.table.get_value(version, pkgarch, checksum)
-            response = {"value": value}
-        except prserv.NotFoundError:
-            self.logger.error("failure storing value in database for (%s, %s)",version, checksum)
 
-        return response
+        if self.upstream_client is None:
+            try:
+                value = self.server.table.get_value(version, pkgarch, checksum)
+                response = {"value": value}
+            except prserv.NotFoundError:
+                self.logger.error("failure storing value in database for (%s, %s)", version, checksum)
+
+            return response
+
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
+            try:
+                value = self.server.table.get_value(version, pkgarch, checksum)
+                response = {"value": value}
+            except prserv.NotFoundError:
+                self.logger.error("failure storing value in database for (%s, %s)", version, checksum)
+
+            return response
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
+        upstream_max_value = await self.upstream_client.max_package_pr(version, pkgarch)
+        subvalue = self.server.table.find_new_subvalue(version, pkgarch, upstream_max_value)
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
@@ -117,11 +191,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
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
@@ -134,6 +209,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
         self.logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
                      (self.dbfile, self.address, str(os.getpid())))
 
+        if self.upstream is not None:
+            self.logger.info("And upstream PRServer: %s " % (self.upstream))
+
         return tasks
 
     async def stop(self):
@@ -147,14 +225,15 @@ class PRServer(bb.asyncrpc.AsyncServer):
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
 
@@ -233,7 +312,7 @@ def run_as_daemon(func, pidfile, logfile):
     os.remove(pidfile)
     os._exit(0)
 
-def start_daemon(dbfile, host, port, logfile, read_only=False):
+def start_daemon(dbfile, host, port, logfile, read_only=False, upstream=None):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
@@ -249,7 +328,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
 
     dbfile = os.path.abspath(dbfile)
     def daemon_main():
-        server = PRServer(dbfile, read_only=read_only)
+        server = PRServer(dbfile, read_only=read_only, upstream=upstream)
         server.start_tcp_server(ip, port)
         server.serve_forever()
 
@@ -336,6 +415,9 @@ def auto_start(d):
 
     host = host_params[0].strip().lower()
     port = int(host_params[1])
+
+    upstream = d.getVar("PRSERV_UPSTREAM") or None
+
     if is_local_special(host, port):
         import bb.utils
         cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
@@ -350,7 +432,7 @@ def auto_start(d):
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


