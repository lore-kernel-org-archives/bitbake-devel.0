Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web08.17234.1618227724682554755
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fpW2NW+b;
 spf=pass (domain: konsulko.com, ip: 209.85.128.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f50.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so7839984wmq.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKw2kGd+zds6PXHNRKDs4G2vZnBbP6FlFqH765wCUE8=;
        b=fpW2NW+bUQb1gAtoy2NHwNdl8jsoMo+r90YS1PNmRNHivqOJ9j7r1/avhHQc2RyfwL
         OYpeWd5Otpc5XH2MOJY5j6Ep/qWv0d9QSOQ4/PEK3EF2xNdGYmyjjf3izZ2ZezB5fV9+
         gcSWZABjFWtYYx9ROyVIFcm82e/HNOiV60hg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKw2kGd+zds6PXHNRKDs4G2vZnBbP6FlFqH765wCUE8=;
        b=gZA/IONlU8WNH3IpXmSkfaRkCcfUTS5eTMwj+lB0HpzsKJh2pgcJAH7tmDRlk7XWxm
         lCyvz5Y8izioQj3baOZAYUFR8EZ2cpIJyYuqJtB0IKT8vr+mc2qEix4IZJd5qcE3kcBh
         GbMZis/CJq4jf7FxBzMzdvlEX5lNF4sBbdFPsmKddGP/03GFEtl9DJzls5MYqj3IuxlY
         u1p2+R3YgM4oVa9oCtd00xURqP0NwB5fLapH/3K7IvH07xxjZWDOdvV3QQggvUIlLzW+
         1RCxX/tMpenO5rTTi9OZDuu6iYHNI5VpoS6m6EggVR7YCAEAHx6tK0vPeESlLXOcWonu
         ns3A==
X-Gm-Message-State: AOAM533U3n2ZzyKz7sTebT31mNWZjkHTWbXFjz+Bso4AK2D+Lmm36Ok1
	7E1lyWBFVtgPcsUq29rKb/v69lBbzwaROA==
X-Google-Smtp-Source: ABdhPJwydDEohFZriKj86ePmSRT5gHi19A6o0YnjLqHYyszV1cHsGpmaq9GGrrALstjNMcjUggbJzQ==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr6504546wmk.104.1618227722946;
        Mon, 12 Apr 2021 04:42:02 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:02 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 08/11] prserv: Handle requests in main thread
Date: Mon, 12 Apr 2021 12:41:46 +0100
Message-Id: <20210412114149.4750-9-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prserver process is cleanly separated from the main bitbake process
so requests can be handled in the main thread. This removes the need for
a request queue and a separate request handling thread.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 159 ++++++++++-----------------------------------
 1 file changed, 36 insertions(+), 123 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 74bfdc1bb..0c61c6bf7 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -5,8 +5,6 @@
 import os,sys,logging
 import signal, time
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
-import threading
-import queue
 import socket
 import io
 import sqlite3
@@ -14,7 +12,6 @@ import bb.server.xmlrpcclient
 import prserv
 import prserv.db
 import errno
-import select
 import multiprocessing
 
 logger = logging.getLogger("BitBake.PRserv")
@@ -48,55 +45,18 @@ class PRServer(SimpleXMLRPCServer):
 
         self.dbfile=dbfile
         self.logfile=logfile
-        self.working_thread=None
         self.host, self.port = self.socket.getsockname()
-        self.pidfile=PIDPREFIX % (self.host, self.port)
 
         self.register_function(self.getPR, "getPR")
-        self.register_function(self.quit, "quit")
         self.register_function(self.ping, "ping")
         self.register_function(self.export, "export")
         self.register_function(self.dump_db, "dump_db")
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
-        self.quitpipein, self.quitpipeout = os.pipe()
-
-        self.requestqueue = queue.Queue()
-        self.handlerthread = threading.Thread(target = self.process_request_thread)
-        self.handlerthread.daemon = False
-
-    def process_request_thread(self):
-        """Same as in BaseServer but as a thread.
-
-        In addition, exception handling is done here.
-
-        """
-        iter_count = 1
+        self.iter_count = 0
         # 60 iterations between syncs or sync if dirty every ~30 seconds
-        iterations_between_sync = 60
-
-        bb.utils.set_process_name("PRServ Handler")
-
-        while not self.quitflag:
-            try:
-                (request, client_address) = self.requestqueue.get(True, 30)
-            except queue.Empty:
-                self.table.sync_if_dirty()
-                continue
-            if request is None:
-                continue
-            try:
-                self.finish_request(request, client_address)
-                self.shutdown_request(request)
-                iter_count = (iter_count + 1) % iterations_between_sync
-                if iter_count == 0:
-                    self.table.sync_if_dirty()
-            except:
-                self.handle_error(request, client_address)
-                self.shutdown_request(request)
-                self.table.sync()
-            self.table.sync_if_dirty()
+        self.iterations_between_sync = 60
 
     def sigint_handler(self, signum, stack):
         if self.table:
@@ -105,11 +65,30 @@ class PRServer(SimpleXMLRPCServer):
     def sigterm_handler(self, signum, stack):
         if self.table:
             self.table.sync()
-        self.quit()
-        self.requestqueue.put((None, None))
+        raise(SystemExit)
 
     def process_request(self, request, client_address):
-        self.requestqueue.put((request, client_address))
+        if request is None:
+            return
+        try:
+            self.finish_request(request, client_address)
+            self.shutdown_request(request)
+            self.iter_count = (self.iter_count + 1) % self.iterations_between_sync
+            if self.iter_count == 0:
+                self.table.sync_if_dirty()
+        except:
+            self.handle_error(request, client_address)
+            self.shutdown_request(request)
+            self.table.sync()
+        self.table.sync_if_dirty()
+
+    def serve_forever(self, poll_interval=0.5):
+        signal.signal(signal.SIGINT, self.sigint_handler)
+        signal.signal(signal.SIGTERM, self.sigterm_handler)
+
+        self.db = prserv.db.PRData(self.dbfile)
+        self.table = self.db["PRMAIN"]
+        return super().serve_forever(poll_interval)
 
     def export(self, version=None, pkgarch=None, checksum=None, colinfo=True):
         try:
@@ -142,7 +121,7 @@ class PRServer(SimpleXMLRPCServer):
         return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
-        return not self.quitflag
+        return True
 
     def getinfo(self):
         return (self.host, self.port)
@@ -157,45 +136,6 @@ class PRServer(SimpleXMLRPCServer):
             logger.error(str(exc))
             return None
 
-    def quit(self):
-        self.quitflag=True
-        os.write(self.quitpipeout, b"q")
-        os.close(self.quitpipeout)
-        return
-
-    def work_forever(self,):
-        self.quitflag = False
-        # This timeout applies to the poll in TCPServer, we need the select 
-        # below to wake on our quit pipe closing. We only ever call into handle_request
-        # if there is data there.
-        self.timeout = 0.01
-
-        signal.signal(signal.SIGINT, self.sigint_handler)
-        signal.signal(signal.SIGTERM, self.sigterm_handler)
-
-        bb.utils.set_process_name("PRServ")
-
-        # DB connection must be created after all forks
-        self.db = prserv.db.PRData(self.dbfile)
-        self.table = self.db["PRMAIN"]
-
-        logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
-                     (self.dbfile, self.host, self.port, str(os.getpid())))
-
-        self.handlerthread.start()
-        while not self.quitflag:
-            ready = select.select([self.fileno(), self.quitpipein], [], [], 30)
-            if self.quitflag:
-                break
-            if self.fileno() in ready[0]:
-                self.handle_request()
-        self.handlerthread.join()
-        self.db.disconnect()
-        logger.info("PRServer: stopping...")
-        self.server_close()
-        os.close(self.quitpipein)
-        return
-
 class PRServSingleton(object):
     def __init__(self, dbfile, logfile, interface):
         self.dbfile = dbfile
@@ -206,7 +146,7 @@ class PRServSingleton(object):
 
     def start(self):
         self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
-        self.process = multiprocessing.Process(target=self.prserv.work_forever)
+        self.process = multiprocessing.Process(target=self.prserv.serve_forever)
         self.process.start()
 
         self.host, self.port = self.prserv.getinfo()
@@ -222,13 +162,6 @@ class PRServerConnection(object):
         self.port = port
         self.connection, self.transport = bb.server.xmlrpcclient._create_server(self.host, self.port)
 
-    def terminate(self):
-        try:
-            logger.info("Terminating PRServer...")
-            self.connection.quit()
-        except Exception as exc:
-            sys.stderr.write("%s\n" % str(exc))
-
     def getPR(self, version, pkgarch, checksum):
         return self.connection.getPR(version, pkgarch, checksum)
 
@@ -332,7 +265,7 @@ def start_daemon(dbfile, host, port, logfile):
         return 1
 
     server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (ip,port))
-    run_as_daemon(server.work_forever, pidfile, os.path.abspath(logfile))
+    run_as_daemon(server.serve_forever, pidfile, os.path.abspath(logfile))
 
     # Sometimes, the port (i.e. localhost:0) indicated by the user does not match with
     # the one the server actually is listening, so at least warn the user about it
@@ -369,25 +302,13 @@ def stop_daemon(host, port):
         return 1
 
     try:
-        PRServerConnection(ip, port).terminate()
-    except:
-        logger.critical("Stop PRService %s:%d failed" % (host,port))
-
-    try:
-        if pid:
-            wait_timeout = 0
-            print("Waiting for pr-server to exit.")
-            while is_running(pid) and wait_timeout < 50:
-                time.sleep(0.1)
-                wait_timeout += 1
+        if is_running(pid):
+            print("Sending SIGTERM to pr-server.")
+            os.kill(pid, signal.SIGTERM)
+            time.sleep(0.1)
 
-            if is_running(pid):
-                print("Sending SIGTERM to pr-server.")
-                os.kill(pid,signal.SIGTERM)
-                time.sleep(0.1)
-
-            if os.path.exists(pidfile):
-                os.remove(pidfile)
+        if os.path.exists(pidfile):
+            os.remove(pidfile)
 
     except OSError as e:
         err = str(e)
@@ -463,17 +384,9 @@ def auto_start(d):
 
 def auto_shutdown():
     global singleton
-    if singleton:
-        host, port = singleton.getinfo()
-        try:
-            PRServerConnection(host, port).terminate()
-        except:
-            logger.critical("Stop PRService %s:%d failed" % (host,port))
-
-        try:
-            os.waitpid(singleton.prserv.pid, 0)
-        except ChildProcessError:
-            pass
+    if singleton and singleton.process:
+        singleton.process.terminate()
+        singleton.process.join()
         singleton = None
 
 def ping(host, port):
-- 
2.26.2

