Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AC2CD6BD80
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 22:44:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMvYHt008601 for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:57:35 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gk9Yqq_l4gKi for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:57:34 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7VMvWce008595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 31 Aug 2013 23:57:33 +0100
Message-ID: <1377989082.1059.134.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 31 Aug 2013 23:44:42 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] prserv/serv: Settle on two threads for optimal performance
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 31 Aug 2013 22:44:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Using the threading mixin class resulted in large amounts of memory
being used by the PR server for no good reason. Using a receiver thread
and a thread to do the actual database operations on a single connection
gives the same performance with a much saner memory overhead so
switch to this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 3677f77..a9c7ed1 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -2,6 +2,8 @@ import os,sys,logging
 import signal, time, atexit, threading
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import xmlrpclib
+import threading
+import Queue
 
 try:
     import sqlite3
@@ -31,14 +33,11 @@ class Handler(SimpleXMLRPCRequestHandler):
 PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
 singleton = None
 
-import SocketServer
-class SimpleThreadedXMLRPCServer(SocketServer.ThreadingMixIn, SimpleXMLRPCServer):
-    pass
 
-class PRServer(SimpleThreadedXMLRPCServer):
+class PRServer(SimpleXMLRPCServer):
     def __init__(self, dbfile, logfile, interface, daemon=True):
         ''' constructor '''
-        SimpleThreadedXMLRPCServer.__init__(self, interface,
+        SimpleXMLRPCServer.__init__(self, interface,
                                     logRequests=False, allow_none=True)
         self.dbfile=dbfile
         self.daemon=daemon
@@ -54,19 +53,41 @@ class PRServer(SimpleThreadedXMLRPCServer):
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
+        self.db = prserv.db.PRData(self.dbfile)
+        self.table = self.db["PRMAIN"]
+
+        self.requestqueue = Queue.Queue()
+        self.handlerthread = threading.Thread(target = self.process_request_thread)
+        self.handlerthread.daemon = False
+
+    def process_request_thread(self):
+        """Same as in BaseServer but as a thread.
+
+        In addition, exception handling is done here.
+
+        """
+        while True:
+            (request, client_address) = self.requestqueue.get()
+            try:
+                self.finish_request(request, client_address)
+                self.shutdown_request(request)
+            except:
+                self.handle_error(request, client_address)
+                self.shutdown_request(request)
+
+
+    def process_request(self, request, client_address):
+        self.requestqueue.put((request, client_address))
+
     def export(self, version=None, pkgarch=None, checksum=None, colinfo=True):
         try:
-            db = prserv.db.PRData(self.dbfile)
-            table = db["PRMAIN"]
-            return table.export(version, pkgarch, checksum, colinfo)
+            return self.table.export(version, pkgarch, checksum, colinfo)
         except sqlite3.Error as exc:
             logger.error(str(exc))
             return None
 
     def importone(self, version, pkgarch, checksum, value):
-        db = prserv.db.PRData(self.dbfile)
-        table = db["PRMAIN"]
-        return table.importone(version, pkgarch, checksum, value)
+        return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
         return not self.quit
@@ -76,9 +97,7 @@ class PRServer(SimpleThreadedXMLRPCServer):
 
     def getPR(self, version, pkgarch, checksum):
         try:
-            db = prserv.db.PRData(self.dbfile)
-            table = db["PRMAIN"]
-            return table.getValue(version, pkgarch, checksum)
+            return self.table.getValue(version, pkgarch, checksum)
         except prserv.NotFoundError:
             logger.error("can not find value for (%s, %s)",version, checksum)
             return None
@@ -97,6 +116,7 @@ class PRServer(SimpleThreadedXMLRPCServer):
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
                      (self.dbfile, self.host, self.port, str(os.getpid())))
 
+        self.handlerthread.start()
         while not self.quit:
             self.handle_request()
 


