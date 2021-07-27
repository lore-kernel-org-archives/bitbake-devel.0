Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.web09.6271.1627353491245093741
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nqTzjr+e;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id c18so11019349qke.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0s8hwzOhP4v23CHznJ3xdxWsVcHXXEMH40bv3IETgkI=;
        b=nqTzjr+eAMjUBBJiV1ovl5TP/oI7QgDRkG9CqHydz+5x2gMdppk0AJ99FMLlqJD2jV
         hWQ32lQkPcqHb1OIglhhtHQgP4Ahc2VkNYaFb3NghvZAbx5YSpbZwCd2iQ0y6DpMwzBL
         KpalasQVvIsm3zVOt3t90zhLOJrWVQkKfVj/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0s8hwzOhP4v23CHznJ3xdxWsVcHXXEMH40bv3IETgkI=;
        b=S6xhiyKqAU0DMbAsvGrYm+Lx6lyfWkszdP65Oyf0jHCE6l2Hc9VAUZQM5SDXqrZARJ
         Vw7x+7fQFHFb0w4l1WiwwI7x6YDWxh5D/GeuRSbze3vG38PWpNeemidG3joV6R4K2a7U
         EgLCDHKkzdNpWLdFl8MzlLRb0Eb4pAve7IntJprQ0zNmWy2E/ZHNckQ81g87cjb42joR
         sjm/bPLR07CyFspbcxJVusclCgzBZ9X7+WOgCJDWitYUOlrfSJypYBnLTXqI1zmM0XbH
         YkfokMyt2Juw6eXjy7txzFhvb1mP2Ud+CdhnEDOHVZ8oGkG0ovHWqbss2OSfc/10ae7e
         /C1g==
X-Gm-Message-State: AOAM533x0XqEgj1nAJc7Gr/TaAE2UhfDDh15wU4Mik1l9cGxuhS7Dy9q
	C56oYWT0qiFMs5jWvxUP1Lca7/Xm/nwHTg==
X-Google-Smtp-Source: ABdhPJzj7Ior1d5i65hixOGa1nLAHJ8p2RDkyhB819+yaAso/9MHCbMSGOfssQYZb8FiAXCLjVHGlQ==
X-Received: by 2002:ae9:f805:: with SMTP id x5mr20054067qkh.373.1627353489970;
        Mon, 26 Jul 2021 19:38:09 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:09 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 4/5] prserv: Replace XML RPC with modern asyncrpc implementation
Date: Mon, 26 Jul 2021 22:37:55 -0400
Message-Id: <19bef87bf80fb782cf0aa67fc900e6c58396e84d.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

Update the prserv client and server classes to use the modern json and
asyncio based RPC system implemented by the asyncrpc module.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
[updated for asyncrpc SIGTERM handling changes]
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/prserv/serv.py | 265 +++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 129 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5e322bf8..2c572e0f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -4,157 +4,158 @@
 
 import os,sys,logging
 import signal, time
-from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import socket
 import io
 import sqlite3
-import bb.server.xmlrpcclient
 import prserv
 import prserv.db
 import errno
-import multiprocessing
+import bb.asyncrpc
 
 logger = logging.getLogger("BitBake.PRserv")
 
-class Handler(SimpleXMLRPCRequestHandler):
-    def _dispatch(self,method,params):
-        try:
-            value=self.server.funcs[method](*params)
-        except:
-            import traceback
-            traceback.print_exc()
-            raise
-        return value
-
 PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
 singleton = None
 
+class PRServerClient(bb.asyncrpc.AsyncServerConnection):
+    def __init__(self, reader, writer, table):
+        super().__init__(reader, writer, 'PRSERVICE', logger)
+        self.handlers.update({
+            'get-pr': self.handle_get_pr,
+            'import-one': self.handle_import_one,
+            'export': self.handle_export,
+        })
+        self.table = table
 
-class PRServer(SimpleXMLRPCServer):
-    def __init__(self, dbfile, logfile, interface):
-        ''' constructor '''
-        try:
-            SimpleXMLRPCServer.__init__(self, interface,
-                                        logRequests=False, allow_none=True)
-        except socket.error:
-            ip=socket.gethostbyname(interface[0])
-            port=interface[1]
-            msg="PR Server unable to bind to %s:%s\n" % (ip, port)
-            sys.stderr.write(msg)
-            raise PRServiceConfigError
-
-        self.dbfile=dbfile
-        self.logfile=logfile
-        self.host, self.port = self.socket.getsockname()
-
-        self.register_function(self.getPR, "getPR")
-        self.register_function(self.ping, "ping")
-        self.register_function(self.export, "export")
-        self.register_function(self.importone, "importone")
-        self.register_introspection_functions()
-
-        self.iter_count = 0
-        # 60 iterations between syncs or sync if dirty every ~30 seconds
-        self.iterations_between_sync = 60
-
-    def sigint_handler(self, signum, stack):
-        if self.table:
-            self.table.sync()
-
-    def sigterm_handler(self, signum, stack):
-        if self.table:
-            self.table.sync()
-        raise(SystemExit)
+    def validate_proto_version(self):
+        return (self.proto_version == (1, 0))
 
-    def process_request(self, request, client_address):
-        if request is None:
-            return
+    async def dispatch_message(self, msg):
         try:
-            self.finish_request(request, client_address)
-            self.shutdown_request(request)
-            self.iter_count = (self.iter_count + 1) % self.iterations_between_sync
-            if self.iter_count == 0:
-                self.table.sync_if_dirty()
+            await super().dispatch_message(msg)
         except:
-            self.handle_error(request, client_address)
-            self.shutdown_request(request)
             self.table.sync()
-        self.table.sync_if_dirty()
+            raise
 
-    def serve_forever(self, poll_interval=0.5):
-        signal.signal(signal.SIGINT, self.sigint_handler)
-        signal.signal(signal.SIGTERM, self.sigterm_handler)
+        self.table.sync_if_dirty()
 
-        self.db = prserv.db.PRData(self.dbfile)
-        self.table = self.db["PRMAIN"]
-        return super().serve_forever(poll_interval)
+    async def handle_get_pr(self, request):
+        version = request['version']
+        pkgarch = request['pkgarch']
+        checksum = request['checksum']
 
-    def export(self, version=None, pkgarch=None, checksum=None, colinfo=True):
+        response = None
         try:
-            return self.table.export(version, pkgarch, checksum, colinfo)
+            value = self.table.getValue(version, pkgarch, checksum)
+            response = {'value': value}
+        except prserv.NotFoundError:
+            logger.error("can not find value for (%s, %s)",version, checksum)
         except sqlite3.Error as exc:
             logger.error(str(exc))
-            return None
 
-    def importone(self, version, pkgarch, checksum, value):
-        return self.table.importone(version, pkgarch, checksum, value)
+        self.write_message(response)
 
-    def ping(self):
-        return True
+    async def handle_import_one(self, request):
+        version = request['version']
+        pkgarch = request['pkgarch']
+        checksum = request['checksum']
+        value = request['value']
+
+        value = self.table.importone(version, pkgarch, checksum, value)
+        if value is not None:
+            response = {'value': value}
+        else:
+            response = None
+        self.write_message(response)
 
-    def getinfo(self):
-        return (self.host, self.port)
+    async def handle_export(self, request):
+        version = request['version']
+        pkgarch = request['pkgarch']
+        checksum = request['checksum']
+        colinfo = request['colinfo']
 
-    def getPR(self, version, pkgarch, checksum):
         try:
-            return self.table.getValue(version, pkgarch, checksum)
-        except prserv.NotFoundError:
-            logger.error("can not find value for (%s, %s)",version, checksum)
-            return None
+            (metainfo, datainfo) = self.table.export(version, pkgarch, checksum, colinfo)
         except sqlite3.Error as exc:
             logger.error(str(exc))
-            return None
+            metainfo = datainfo = None
 
-class PRServSingleton(object):
-    def __init__(self, dbfile, logfile, interface):
-        self.dbfile = dbfile
-        self.logfile = logfile
-        self.interface = interface
-        self.host = None
-        self.port = None
+        response = {'metainfo': metainfo, 'datainfo': datainfo}
+        self.write_message(response)
 
-    def start(self):
-        self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
-        self.process = multiprocessing.Process(target=self.prserv.serve_forever)
-        self.process.start()
+class PRServer(bb.asyncrpc.AsyncServer):
+    def __init__(self, dbfile, loop=None):
+        super().__init__(logger, loop)
+        self.dbfile = dbfile
+        self.table = None
 
-        self.host, self.port = self.prserv.getinfo()
+    def accept_client(self, reader, writer):
+        return PRServerClient(reader, writer, self.table)
 
-    def getinfo(self):
-        return (self.host, self.port)
+    def serve_forever(self):
+        self.db = prserv.db.PRData(self.dbfile)
+        self.table = self.db["PRMAIN"]
 
-class PRServerConnection(object):
-    def __init__(self, host, port):
-        if is_local_special(host, port):
-            host, port = singleton.getinfo()
-        self.host = host
-        self.port = port
-        self.connection, self.transport = bb.server.xmlrpcclient._create_server(self.host, self.port)
+        logger.debug("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
+                     (self.dbfile, self.address, str(os.getpid())))
 
-    def getPR(self, version, pkgarch, checksum):
-        return self.connection.getPR(version, pkgarch, checksum)
+        super().serve_forever()
 
-    def ping(self):
-        return self.connection.ping()
+        self.table.sync_if_dirty()
+        self.db.disconnect()
 
-    def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
-        return self.connection.export(version, pkgarch, checksum, colinfo)
+    def signal_handler(self):
+        super().signal_handler()
+        if self.table:
+            self.table.sync()
 
-    def importone(self, version, pkgarch, checksum, value):
-        return self.connection.importone(version, pkgarch, checksum, value)
+class PRServSingleton(object):
+    def __init__(self, dbfile, logfile, host, port):
+        self.dbfile = dbfile
+        self.logfile = logfile
+        self.host = host
+        self.port = port
 
-    def getinfo(self):
-        return self.host, self.port
+    def start(self):
+        self.prserv = PRServer(self.dbfile)
+        self.prserv.start_tcp_server(self.host, self.port)
+        self.process = self.prserv.serve_as_process()
+
+        if not self.port:
+            self.port = int(self.prserv.address.rsplit(':', 1)[1])
+
+class PRAsyncClient(bb.asyncrpc.AsyncClient):
+    def __init__(self):
+        super().__init__('PRSERVICE', '1.0', logger)
+
+    async def getPR(self, version, pkgarch, checksum):
+        response = await self.send_message(
+            {'get-pr': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum}}
+        )
+        if response:
+            return response['value']
+
+    async def importone(self, version, pkgarch, checksum, value):
+        response = await self.send_message(
+            {'import-one': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'value': value}}
+        )
+        if response:
+            return response['value']
+
+    async def export(self, version, pkgarch, checksum, colinfo):
+        response = await self.send_message(
+            {'export': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'colinfo': colinfo}}
+        )
+        if response:
+            return (response['metainfo'], response['datainfo'])
+
+class PRClient(bb.asyncrpc.Client):
+    def __init__(self):
+        super().__init__()
+        self._add_methods('getPR', 'importone', 'export')
+
+    def _get_async_client(self):
+        return PRAsyncClient()
 
 def run_as_daemon(func, pidfile, logfile):
     """
@@ -240,15 +241,13 @@ def start_daemon(dbfile, host, port, logfile):
                             % pidfile)
         return 1
 
-    server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (ip,port))
-    run_as_daemon(server.serve_forever, pidfile, os.path.abspath(logfile))
+    dbfile = os.path.abspath(dbfile)
+    def daemon_main():
+        server = PRServer(dbfile)
+        server.start_tcp_server(host, port)
+        server.serve_forever()
 
-    # Sometimes, the port (i.e. localhost:0) indicated by the user does not match with
-    # the one the server actually is listening, so at least warn the user about it
-    _,rport = server.getinfo()
-    if port != rport:
-        sys.stdout.write("Server is listening at port %s instead of %s\n"
-                         % (rport,port))
+    run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
     return 0
 
 def stop_daemon(host, port):
@@ -302,7 +301,7 @@ def is_running(pid):
     return True
 
 def is_local_special(host, port):
-    if host.strip().upper() == 'localhost'.upper() and (not port):
+    if host.strip().lower() == 'localhost' and not port:
         return True
     else:
         return False
@@ -340,20 +339,19 @@ def auto_start(d):
                auto_shutdown()
         if not singleton:
             bb.utils.mkdirhier(cachedir)
-            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), ("localhost",0))
+            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), "localhost", 0)
             singleton.start()
     if singleton:
-        host, port = singleton.getinfo()
+        host = singleton.host
+        port = singleton.port
     else:
         host = host_params[0]
         port = int(host_params[1])
 
     try:
-        connection = PRServerConnection(host,port)
-        connection.ping()
-        realhost, realport = connection.getinfo()
-        return str(realhost) + ":" + str(realport)
-        
+        ping(host, port)
+        return str(host) + ":" + str(port)
+
     except Exception:
         logger.critical("PRservice %s:%d not available" % (host, port))
         raise PRServiceConfigError
@@ -366,8 +364,17 @@ def auto_shutdown():
         singleton = None
 
 def ping(host, port):
-    conn=PRServerConnection(host, port)
+    conn=PRClient()
+    conn.connect_tcp(host, port)
     return conn.ping()
 
 def connect(host, port):
-    return PRServerConnection(host, port)
+    global singleton
+
+    if host.strip().lower() == 'localhost' and not port:
+        host = 'localhost'
+        port = singleton.port
+
+    conn = PRClient()
+    conn.connect_tcp(host, port)
+    return conn
-- 
2.31.1

