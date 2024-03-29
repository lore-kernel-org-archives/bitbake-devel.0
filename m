Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A279BCD128D
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.24.1711723224594854424
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CIRRFbBL;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D2466000A;
	Fri, 29 Mar 2024 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gk2MT6ALXSNZC0oA0Fc4TEPpn/zjL+x3k7mpM+0C/Zk=;
	b=CIRRFbBLoZSZMX7N8StKMuc5I8wpKvGv0ry+XNNl3KfU5jfmzrvgUxRCyPuIVbAP0SABbl
	n6Tdvla1cx0NI8KqewNz+lYzLB4KZXTdpB3MeQXmIzdPEBBnsljXPuGFfQCY7B2Ib8xuQe
	Hl3jd0jioFcIK55x0Ien34xkIKoFz2+C5LUqAMkopiJNr19TnzA2VTMvg7aJCnhjt6dMto
	c39aKJRH+uk8ZYMeWAIa42MP0wDku0/NUhH6tzt3rmf4eR7BPZvmBpGUxGKGW2HAin0ShE
	oJFkgdISme34riR8ond9LiLLZe7MqQ6eQ0JFLy6FI85yGDN9+C1CZgNM8/4dEQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 02/12] prserv: use double quotes by default
Date: Fri, 29 Mar 2024 15:39:46 +0100
Message-Id: <20240329143956.1602707-3-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16024

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

To aligh with the hashserv code

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 bin/bitbake-prserv     |  4 +--
 lib/prserv/__init__.py |  4 +--
 lib/prserv/client.py   | 20 ++++++-------
 lib/prserv/db.py       | 32 ++++++++++-----------
 lib/prserv/serv.py     | 64 +++++++++++++++++++++---------------------
 5 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 5be42f3ce5..8c3808fb20 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -11,14 +11,14 @@ import optparse
 import warnings
 warnings.simplefilter("default")
 
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),'lib'))
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib"))
 
 import prserv
 import prserv.serv
 
 __version__="1.0.0"
 
-PRHOST_DEFAULT='0.0.0.0'
+PRHOST_DEFAULT="0.0.0.0"
 PRPORT_DEFAULT=8585
 
 def main():
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
index 38ced818ad..5790a8db1e 100644
--- a/lib/prserv/__init__.py
+++ b/lib/prserv/__init__.py
@@ -12,8 +12,8 @@ import sys,logging
 def init_logger(logfile, loglevel):
     numeric_level = getattr(logging, loglevel.upper(), None)
     if not isinstance(numeric_level, int):
-        raise ValueError('Invalid log level: %s' % loglevel)
-    FORMAT = '%(asctime)-15s %(message)s'
+        raise ValueError("Invalid log level: %s" % loglevel)
+    FORMAT = "%(asctime)-15s %(message)s"
     logging.basicConfig(level=numeric_level, filename=logfile, format=FORMAT)
 
 class NotFoundError(Exception):
diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 6b81356fac..7bc5188c53 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -11,40 +11,40 @@ logger = logging.getLogger("BitBake.PRserv")
 
 class PRAsyncClient(bb.asyncrpc.AsyncClient):
     def __init__(self):
-        super().__init__('PRSERVICE', '1.0', logger)
+        super().__init__("PRSERVICE", "1.0", logger)
 
     async def getPR(self, version, pkgarch, checksum):
         response = await self.invoke(
-            {'get-pr': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum}}
+            {"get-pr": {"version": version, "pkgarch": pkgarch, "checksum": checksum}}
         )
         if response:
-            return response['value']
+            return response["value"]
 
     async def importone(self, version, pkgarch, checksum, value):
         response = await self.invoke(
-            {'import-one': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'value': value}}
+            {"import-one": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "value": value}}
         )
         if response:
-            return response['value']
+            return response["value"]
 
     async def export(self, version, pkgarch, checksum, colinfo):
         response = await self.invoke(
-            {'export': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'colinfo': colinfo}}
+            {"export": {"version": version, "pkgarch": pkgarch, "checksum": checksum, "colinfo": colinfo}}
         )
         if response:
-            return (response['metainfo'], response['datainfo'])
+            return (response["metainfo"], response["datainfo"])
 
     async def is_readonly(self):
         response = await self.invoke(
-            {'is-readonly': {}}
+            {"is-readonly": {}}
         )
         if response:
-            return response['readonly']
+            return response["readonly"]
 
 class PRClient(bb.asyncrpc.Client):
     def __init__(self):
         super().__init__()
-        self._add_methods('getPR', 'importone', 'export', 'is_readonly')
+        self._add_methods("getPR", "importone", "export", "is_readonly")
 
     def _get_async_client(self):
         return PRAsyncClient()
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index b4bda7078c..0859cf4f2c 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -64,7 +64,7 @@ class PRTable(object):
             try:
                 return self.conn.execute(*query)
             except sqlite3.OperationalError as exc:
-                if 'is locked' in str(exc) and end > time.time():
+                if "is locked" in str(exc) and end > time.time():
                     continue
                 raise exc
 
@@ -220,18 +220,18 @@ class PRTable(object):
         metainfo = {}
         #column info 
         if colinfo:
-            metainfo['tbl_name'] = self.table
-            metainfo['core_ver'] = prserv.__version__
-            metainfo['col_info'] = []
+            metainfo["tbl_name"] = self.table
+            metainfo["core_ver"] = prserv.__version__
+            metainfo["col_info"] = []
             data = self._execute("PRAGMA table_info(%s);" % self.table)
             for row in data:
                 col = {}
-                col['name'] = row['name']
-                col['type'] = row['type']
-                col['notnull'] = row['notnull']
-                col['dflt_value'] = row['dflt_value']
-                col['pk'] = row['pk']
-                metainfo['col_info'].append(col)
+                col["name"] = row["name"]
+                col["type"] = row["type"]
+                col["notnull"] = row["notnull"]
+                col["dflt_value"] = row["dflt_value"]
+                col["pk"] = row["pk"]
+                metainfo["col_info"].append(col)
 
         #data info
         datainfo = []
@@ -261,12 +261,12 @@ class PRTable(object):
         else:
             data = self._execute(sqlstmt)
         for row in data:
-            if row['version']:
+            if row["version"]:
                 col = {}
-                col['version'] = row['version']
-                col['pkgarch'] = row['pkgarch']
-                col['checksum'] = row['checksum']
-                col['value'] = row['value']
+                col["version"] = row["version"]
+                col["pkgarch"] = row["pkgarch"]
+                col["checksum"] = row["checksum"]
+                col["value"] = row["value"]
                 datainfo.append(col)
         return (metainfo, datainfo)
 
@@ -275,7 +275,7 @@ class PRTable(object):
         for line in self.conn.iterdump():
             writeCount = writeCount + len(line) + 1
             fd.write(line)
-            fd.write('\n')
+            fd.write("\n")
         return writeCount
 
 class PRData(object):
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 8b1bdc0250..874edd7069 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -21,14 +21,14 @@ singleton = None
 
 class PRServerClient(bb.asyncrpc.AsyncServerConnection):
     def __init__(self, socket, server):
-        super().__init__(socket, 'PRSERVICE', server.logger)
+        super().__init__(socket, "PRSERVICE", server.logger)
         self.server = server
 
         self.handlers.update({
-            'get-pr': self.handle_get_pr,
-            'import-one': self.handle_import_one,
-            'export': self.handle_export,
-            'is-readonly': self.handle_is_readonly,
+            "get-pr": self.handle_get_pr,
+            "import-one": self.handle_import_one,
+            "export": self.handle_export,
+            "is-readonly": self.handle_is_readonly,
         })
 
     def validate_proto_version(self):
@@ -44,14 +44,14 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             self.server.table.sync_if_dirty()
 
     async def handle_get_pr(self, request):
-        version = request['version']
-        pkgarch = request['pkgarch']
-        checksum = request['checksum']
+        version = request["version"]
+        pkgarch = request["pkgarch"]
+        checksum = request["checksum"]
 
         response = None
         try:
             value = self.server.table.getValue(version, pkgarch, checksum)
-            response = {'value': value}
+            response = {"value": value}
         except prserv.NotFoundError:
             logger.error("can not find value for (%s, %s)",version, checksum)
         except sqlite3.Error as exc:
@@ -62,22 +62,22 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
     async def handle_import_one(self, request):
         response = None
         if not self.read_only:
-            version = request['version']
-            pkgarch = request['pkgarch']
-            checksum = request['checksum']
-            value = request['value']
+            version = request["version"]
+            pkgarch = request["pkgarch"]
+            checksum = request["checksum"]
+            value = request["value"]
 
             value = self.server.table.importone(version, pkgarch, checksum, value)
             if value is not None:
-                response = {'value': value}
+                response = {"value": value}
 
         return response
 
     async def handle_export(self, request):
-        version = request['version']
-        pkgarch = request['pkgarch']
-        checksum = request['checksum']
-        colinfo = request['colinfo']
+        version = request["version"]
+        pkgarch = request["pkgarch"]
+        checksum = request["checksum"]
+        colinfo = request["colinfo"]
 
         try:
             (metainfo, datainfo) = self.server.table.export(version, pkgarch, checksum, colinfo)
@@ -85,10 +85,10 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             logger.error(str(exc))
             metainfo = datainfo = None
 
-        return {'metainfo': metainfo, 'datainfo': datainfo}
+        return {"metainfo": metainfo, "datainfo": datainfo}
 
     async def handle_is_readonly(self, request):
-        return {'readonly': self.server.read_only}
+        return {"readonly": self.server.read_only}
 
 class PRServer(bb.asyncrpc.AsyncServer):
     def __init__(self, dbfile, read_only=False):
@@ -135,7 +135,7 @@ class PRServSingleton(object):
         if not self.prserv.address:
             raise PRServiceConfigError
         if not self.port:
-            self.port = int(self.prserv.address.rsplit(':', 1)[1])
+            self.port = int(self.prserv.address.rsplit(":", 1)[1])
 
 def run_as_daemon(func, pidfile, logfile):
     """
@@ -171,12 +171,12 @@ def run_as_daemon(func, pidfile, logfile):
     # stdout/stderr or it could be 'real' unix fd forking where we need
     # to physically close the fds to prevent the program launching us from
     # potentially hanging on a pipe. Handle both cases.
-    si = open('/dev/null', 'r')
+    si = open("/dev/null", "r")
     try:
         os.dup2(si.fileno(),sys.stdin.fileno())
     except (AttributeError, io.UnsupportedOperation):
         sys.stdin = si
-    so = open(logfile, 'a+')
+    so = open(logfile, "a+")
     try:
         os.dup2(so.fileno(),sys.stdout.fileno())
     except (AttributeError, io.UnsupportedOperation):
@@ -200,7 +200,7 @@ def run_as_daemon(func, pidfile, logfile):
 
     # write pidfile
     pid = str(os.getpid())
-    with open(pidfile, 'w') as pf:
+    with open(pidfile, "w") as pf:
         pf.write("%s\n" % pid)
 
     func()
@@ -245,12 +245,12 @@ def stop_daemon(host, port):
         # so at least advise the user which ports the corresponding server is listening
         ports = []
         portstr = ""
-        for pf in glob.glob(PIDPREFIX % (ip,'*')):
+        for pf in glob.glob(PIDPREFIX % (ip, "*")):
             bn = os.path.basename(pf)
             root, _ = os.path.splitext(bn)
-            ports.append(root.split('_')[-1])
+            ports.append(root.split("_")[-1])
         if len(ports):
-            portstr = "Wrong port? Other ports listening at %s: %s" % (host, ' '.join(ports))
+            portstr = "Wrong port? Other ports listening at %s: %s" % (host, " ".join(ports))
 
         sys.stderr.write("pidfile %s does not exist. Daemon not running? %s\n"
                          % (pidfile,portstr))
@@ -284,7 +284,7 @@ def is_running(pid):
     return True
 
 def is_local_special(host, port):
-    if (host == 'localhost' or host == '127.0.0.1') and not port:
+    if (host == "localhost" or host == "127.0.0.1") and not port:
         return True
     else:
         return False
@@ -295,7 +295,7 @@ class PRServiceConfigError(Exception):
 def auto_start(d):
     global singleton
 
-    host_params = list(filter(None, (d.getVar('PRSERV_HOST') or '').split(':')))
+    host_params = list(filter(None, (d.getVar("PRSERV_HOST") or "").split(":")))
     if not host_params:
         # Shutdown any existing PR Server
         auto_shutdown()
@@ -304,7 +304,7 @@ def auto_start(d):
     if len(host_params) != 2:
         # Shutdown any existing PR Server
         auto_shutdown()
-        logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
+        logger.critical("\n".join(["PRSERV_HOST: incorrect format",
                 'Usage: PRSERV_HOST = "<hostname>:<port>"']))
         raise PRServiceConfigError
 
@@ -357,8 +357,8 @@ def connect(host, port):
 
     global singleton
 
-    if host.strip().lower() == 'localhost' and not port:
-        host = 'localhost'
+    if host.strip().lower() == "localhost" and not port:
+        host = "localhost"
         port = singleton.port
 
     conn = client.PRClient()
-- 
2.34.1


