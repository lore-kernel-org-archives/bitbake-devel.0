Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.7443.1619705490634298280
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Apr 2021 07:11:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AtOopI61;
 spf=pass (domain: konsulko.com, ip: 209.85.128.49, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f49.google.com with SMTP id s82so899959wmf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Apr 2021 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dx918HNJC2MLC8flm/DfH4QVAsdtHfJDM7WOrdvdSMY=;
        b=AtOopI615uOxRcTnj4glN4q8r/nnhSmISjbqeqV9xi0Dvnq0GIAlM0ezO6clJeFl+r
         PvTYSQIWUeMCIWLGh5ZA67tMZs593jb0Vczs4vg77Wc/DZ5IUcvmwD5ysabQj39RJEw0
         xdtjNTrsSeTlwjzeNGM7mYk8aI2qgBKYi5ZkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dx918HNJC2MLC8flm/DfH4QVAsdtHfJDM7WOrdvdSMY=;
        b=Np0szPArzJ0f3QNw/aZdzUkLS1XFMWoIdccm1bxTm6zG4TRjd4l0WMkLbKIn2XlNr6
         c8G9qD930bDx+XU1rS57qG1veNrbDLhnrZXYDOmCZG/PTeGVIN14DFA+cMMJlPlIIvVJ
         wzO749bHLWXqz98tmv2KD9FoZbkuaGbyiTLm4wGx8EcsDApwdILzdApDfSRSh8rE+vaE
         xM3ONIZxyMeZo3yTy39WjDJWZpO45/6OnU+PecJulXhM639RoY/5Qp1ItXjyOCEq8qgN
         PafgNGtzdEeGPT6yY7JZPe/n+NYnTHkf3A6PlBIimSkR95FLu6Lz8odJc7d2BPJyuIIm
         R6mQ==
X-Gm-Message-State: AOAM533K2wo0q9q2XNxDUY72vVJrSbUOIhMr8eGUJ6yZVmXV9J5b3gqF
	0afCzwdXrPoz9Xl0rpVVMMEr6KM2YXPajQ==
X-Google-Smtp-Source: ABdhPJw4G/Q0J52T6JIv5kQQ68lGotyriKTx/74qPc5FQbvGgsEHwh7nyofn9Y392yfXIVBa2DJ4cQ==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr10564010wmp.144.1619705488938;
        Thu, 29 Apr 2021 07:11:28 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y16sm5282636wrp.78.2021.04.29.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:11:28 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 3/4] prserv: Handle requests in main thread
Date: Thu, 29 Apr 2021 15:11:12 +0100
Message-Id: <20210429141113.27974-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210429141113.27974-1-pbarker@konsulko.com>
References: <20210429141113.27974-1-pbarker@konsulko.com>
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
index 24a8c4bac..5e322bf83 100644
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
@@ -48,54 +45,17 @@ class PRServer(SimpleXMLRPCServer):
 
         self.dbfile=dbfile
         self.logfile=logfile
-        self.working_thread=None
         self.host, self.port = self.socket.getsockname()
-        self.pidfile=PIDPREFIX % (self.host, self.port)
 
         self.register_function(self.getPR, "getPR")
-        self.register_function(self.quit, "quit")
         self.register_function(self.ping, "ping")
         self.register_function(self.export, "export")
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
@@ -104,11 +64,30 @@ class PRServer(SimpleXMLRPCServer):
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
@@ -121,7 +100,7 @@ class PRServer(SimpleXMLRPCServer):
         return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
-        return not self.quitflag
+        return True
 
     def getinfo(self):
         return (self.host, self.port)
@@ -136,45 +115,6 @@ class PRServer(SimpleXMLRPCServer):
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
@@ -185,7 +125,7 @@ class PRServSingleton(object):
 
     def start(self):
         self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
-        self.process = multiprocessing.Process(target=self.prserv.work_forever)
+        self.process = multiprocessing.Process(target=self.prserv.serve_forever)
         self.process.start()
 
         self.host, self.port = self.prserv.getinfo()
@@ -201,13 +141,6 @@ class PRServerConnection(object):
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
 
@@ -308,7 +241,7 @@ def start_daemon(dbfile, host, port, logfile):
         return 1
 
     server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (ip,port))
-    run_as_daemon(server.work_forever, pidfile, os.path.abspath(logfile))
+    run_as_daemon(server.serve_forever, pidfile, os.path.abspath(logfile))
 
     # Sometimes, the port (i.e. localhost:0) indicated by the user does not match with
     # the one the server actually is listening, so at least warn the user about it
@@ -345,25 +278,13 @@ def stop_daemon(host, port):
         return 1
 
     try:
-        PRServerConnection(ip, port).terminate()
-    except:
-        logger.critical("Stop PRService %s:%d failed" % (host,port))
+        if is_running(pid):
+            print("Sending SIGTERM to pr-server.")
+            os.kill(pid, signal.SIGTERM)
+            time.sleep(0.1)
 
-    try:
-        if pid:
-            wait_timeout = 0
-            print("Waiting for pr-server to exit.")
-            while is_running(pid) and wait_timeout < 50:
-                time.sleep(0.1)
-                wait_timeout += 1
-
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
@@ -439,17 +360,9 @@ def auto_start(d):
 
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

