Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.6921.1624853646450259092
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jun 2021 21:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=o3eL9NwV;
 spf=pass (domain: konsulko.com, ip: 209.85.128.46, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f46.google.com with SMTP id l21-20020a05600c1d15b02901e7513b02dbso7330650wms.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Jun 2021 21:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZNvPpH+xJhOxW+CRtZ3h5fy+MHMB4uYFWYqc4fYdMSo=;
        b=o3eL9NwV2dzrqWgLpW7seFChv1qVsc5fmuaR0iPc5lo4r6V/ehtbWCKU5kR+A6Auwj
         I5YNz76sX5qnK9H5vsgQmCTJQCSejjP2qtieSOa7pA2RFEFAWjE1eOSACrA6grlBsbbI
         T6YMqbWhARq0QNona9W/ZI4Fru0LWpsxQMAC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNvPpH+xJhOxW+CRtZ3h5fy+MHMB4uYFWYqc4fYdMSo=;
        b=Xya0mB7xrU6T38SIv3BsyOF3KK/N10sfMGn0MgrxF4k96fuiT6hD+4D+kKsRJ8cLre
         wEm+rA/lcfWtESx0N+ORbo2O8WrsX4yCFOBwCV9NFO1bi817CVAbWYs/XQ1ikv8yYtWO
         PQpQJ6Q1nhjeZZlF6s7CUyBd2fPL48yJMpjKK4Qd6NmxIQNr+85+2lVFVQT37YE0Hi+0
         E5ZgtDU/qsDkCfCwn8Yj2WwpsxeLJv8cbJaOCsCifVVlXP8qDMEdG0gMph2Ux82cY2lm
         g9t+GaUrzFI+gK9CBP7KmdmX4tRe4X4HIPxBdlM9y+pd92hz9bCNIIz6Bt6k4gvt8OYf
         VPwQ==
X-Gm-Message-State: AOAM532BSMrvUItjBL5tw8LY+Weg6yuX1MIOm2UZWjHo4YUxPjXWnyVo
	lcmAuqlIxCp21EoQ0lEcKjXTUCYbWPJZ4Q==
X-Google-Smtp-Source: ABdhPJznFv0EO8NH+Y4sfX4jss9VsP5OmveDuUqYRWI6xCJrRAG7YXGxMSGNZDI+mtZCUxAgo/eDjg==
X-Received: by 2002:a05:600c:2e53:: with SMTP id q19mr24307044wmf.147.1624853644673;
        Sun, 27 Jun 2021 21:14:04 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from owl.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id b187sm2874590wmh.32.2021.06.27.21.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:14:04 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v3 4/4] prserv: Replace XML RPC with modern asyncrpc implementation
Date: Mon, 28 Jun 2021 05:13:56 +0100
Message-Id: <20210628041356.2676-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210628041356.2676-1-pbarker@konsulko.com>
References: <20210628041356.2676-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the prserv client and server classes to use the modern json and
asyncio based RPC system implemented by the asyncrpc module.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 263 +++++++++++++++++++++++----------------------
 1 file changed, 136 insertions(+), 127 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5e322bf83..124d6b1fc 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -4,157 +4,160 @@
 
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
 import multiprocessing
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
 
-    def getinfo(self):
-        return (self.host, self.port)
+        value = self.table.importone(version, pkgarch, checksum, value)
+        if value is not None:
+            response = {'value': value}
+        else:
+            response = None
+        self.write_message(response)
+
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
+        response = {'metainfo': metainfo, 'datainfo': datainfo}
+        self.write_message(response)
+
+class PRServer(bb.asyncrpc.AsyncServer):
+    def __init__(self, dbfile, loop=None):
+        super().__init__(logger, loop)
         self.dbfile = dbfile
-        self.logfile = logfile
-        self.interface = interface
-        self.host = None
-        self.port = None
+        self.table = None
 
-    def start(self):
-        self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
-        self.process = multiprocessing.Process(target=self.prserv.serve_forever)
-        self.process.start()
+    def accept_client(self, reader, writer):
+        return PRServerClient(reader, writer, self.table)
 
-        self.host, self.port = self.prserv.getinfo()
+    def serve_forever(self):
+        self.db = prserv.db.PRData(self.dbfile)
+        self.table = self.db["PRMAIN"]
 
-    def getinfo(self):
-        return (self.host, self.port)
+        logger.debug("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
+                     (self.dbfile, self.address, str(os.getpid())))
 
-class PRServerConnection(object):
-    def __init__(self, host, port):
-        if is_local_special(host, port):
-            host, port = singleton.getinfo()
-        self.host = host
-        self.port = port
-        self.connection, self.transport = bb.server.xmlrpcclient._create_server(self.host, self.port)
+        super().serve_forever()
 
-    def getPR(self, version, pkgarch, checksum):
-        return self.connection.getPR(version, pkgarch, checksum)
+        self.table.sync_if_dirty()
+        self.db.disconnect()
 
-    def ping(self):
-        return self.connection.ping()
+    def signal_handler(self):
+        super().signal_handler()
+        if self.table:
+            self.table.sync()
 
-    def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
-        return self.connection.export(version, pkgarch, checksum, colinfo)
+class PRServSingleton(object):
+    def __init__(self, dbfile, logfile, host, port):
+        self.dbfile = dbfile
+        self.logfile = logfile
+        self.host = host
+        self.port = port
 
-    def importone(self, version, pkgarch, checksum, value):
-        return self.connection.importone(version, pkgarch, checksum, value)
+    def start(self):
+        self.prserv = PRServer(self.dbfile)
+        self.prserv.start_tcp_server(self.host, self.port)
+        self.process = multiprocessing.Process(target=self.prserv.serve_forever)
+        self.process.start()
 
-    def getinfo(self):
-        return self.host, self.port
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
@@ -240,15 +243,13 @@ def start_daemon(dbfile, host, port, logfile):
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
@@ -302,7 +303,7 @@ def is_running(pid):
     return True
 
 def is_local_special(host, port):
-    if host.strip().upper() == 'localhost'.upper() and (not port):
+    if host.strip().lower() == 'localhost' and not port:
         return True
     else:
         return False
@@ -340,20 +341,19 @@ def auto_start(d):
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
@@ -366,8 +366,17 @@ def auto_shutdown():
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
2.26.2

