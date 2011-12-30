Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RgTcP-0003zi-IZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Dec 2011 04:58:58 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 29 Dec 2011 19:50:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="91435058"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by orsmga001.jf.intel.com with ESMTP; 29 Dec 2011 19:50:36 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Dec 2011 11:49:07 +0800
Message-Id: <8c6833d69d93051e7d21f962d8b9881a6a3d5f66.1325213895.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <4b7c60fcff831d944abc7bffda05a2daedfb55a7.1325213895.git.lianhao.lu@intel.com>
References: <4b7c60fcff831d944abc7bffda05a2daedfb55a7.1325213895.git.lianhao.lu@intel.com>
In-Reply-To: <cover.1325213895.git.lianhao.lu@intel.com>
References: <cover.1325213895.git.lianhao.lu@intel.com>
Subject: [PRService/bitbake 2/2] bitbake: Automatically start local PR service.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 30 Dec 2011 03:58:58 -0000

[YOCTO #1126]
A local PR service will be started and stopped automatically along
with the bitbake invocation/ternimation.

This local PR service will be started only and if only when the
PRSERV_HOST is set to 'localhost' and PRSERV_PORT is set to '0'.

When started, the sqlite3 database is stored at
"${PERSISTEN_DIR}/prserv.sqlite3" or "${CACHE}/prserv.sqlite3".

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/bin/bitbake-prserv |    9 +--
 bitbake/lib/bb/cooker.py   |    3 +
 bitbake/lib/prserv/db.py   |   12 ++--
 bitbake/lib/prserv/serv.py |  144 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 123 insertions(+), 45 deletions(-)

diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
index a7ab55f..a8d7acb 100755
--- a/bitbake/bin/bitbake-prserv
+++ b/bitbake/bin/bitbake-prserv
@@ -10,7 +10,7 @@ import prserv.serv
 
 __version__="1.0.0"
 
-PRHOST_DEFAULT=''
+PRHOST_DEFAULT='0.0.0.0'
 PRPORT_DEFAULT=8585
 
 def main():
@@ -18,8 +18,8 @@ def main():
         version="Bitbake PR Service Core version %s, %%prog version %s" % (prserv.__version__, __version__),
         usage = "%prog < --start | --stop > [options]")
 
-    parser.add_option("-f", "--file", help="database filename(default: prserv.db)", action="store",
-                      dest="dbfile", type="string", default="prserv.db")
+    parser.add_option("-f", "--file", help="database filename(default: prserv.sqlite3)", action="store",
+                      dest="dbfile", type="string", default="prserv.sqlite3")
     parser.add_option("-l", "--log", help="log filename(default: prserv.log)", action="store",
                       dest="logfile", type="string", default="prserv.log")
     parser.add_option("--loglevel", help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
@@ -37,8 +37,7 @@ def main():
     prserv.init_logger(os.path.abspath(options.logfile),options.loglevel)
 
     if options.start:
-        ret=prserv.serv.start_daemon(dbfile=options.dbfile, interface=(options.host, options.port),
-                      logfile=os.path.abspath(options.logfile))
+        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile))
     elif options.stop:
         ret=prserv.serv.stop_daemon(options.host, options.port)
     else:
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 15243f2..a421f5f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -36,6 +36,7 @@ from functools import wraps
 from collections import defaultdict
 import bb, bb.exceptions
 from bb import utils, data, parse, event, cache, providers, taskdata, command, runqueue
+import prserv.serv
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -1290,9 +1291,11 @@ class BBCooker:
         # Empty the environment. The environment will be populated as
         # necessary from the data store.
         #bb.utils.empty_environment()
+        prserv.serv.auto_start(self.configuration.data)
         return
 
     def post_serve(self):
+        prserv.serv.auto_shutdown(self.configuration.data)
         bb.event.fire(CookerExit(), self.configuration.event_data)
 
     def shutdown(self):
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index f267dae..9d8e9db 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -8,6 +8,8 @@ try:
 except ImportError:
     from pysqlite2 import dbapi2 as sqlite3
 
+logger = logging.getLogger("BitBake.PRserv")
+
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
     raise Exception("sqlite3 version 3.3.0 or later is required.")
@@ -55,7 +57,7 @@ class PRTable():
                            (version,pkgarch, checksum,version, pkgarch))
                 self.conn.commit()
             except sqlite3.IntegrityError as exc:
-                logging.error(str(exc))
+                logger.error(str(exc))
 
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                                (version, pkgarch, checksum))
@@ -83,7 +85,7 @@ class PRTable():
                                (version, pkgarch, checksum, version, pkgarch))
                 self.conn.commit()
             except sqlite3.IntegrityError as exc:
-                logging.error(str(exc))
+                logger.error(str(exc))
                 self.conn.rollback()
 
             data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
@@ -115,7 +117,7 @@ class PRTable():
                            (version, pkgarch, checksum, value))
                 self.conn.commit()
             except sqlite3.IntegrityError as exc:
-                logging.error(str(exc))
+                logger.error(str(exc))
 
             data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
@@ -140,7 +142,7 @@ class PRTable():
                                (value,version,pkgarch,checksum,value))
                 self.conn.commit()
             except sqlite3.IntegrityError as exc:
-                logging.error(str(exc))
+                logger.error(str(exc))
 
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
                             (version,pkgarch,checksum,value))
@@ -241,5 +243,5 @@ class PRData(object):
     def __delitem__(self, tblname):
         if tblname in self._tables:
             del self._tables[tblname]
-        logging.info("drop table %s" % (tblname))
+        logger.info("drop table %s" % (tblname))
         self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname) 
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 7bcffa7..fa980de 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -1,5 +1,5 @@
 import os,sys,logging
-import signal,time, atexit
+import signal, time, atexit, threading
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import xmlrpclib,sqlite3
 
@@ -7,6 +7,8 @@ import bb.server.xmlrpc
 import prserv
 import prserv.db
 
+logger = logging.getLogger("BitBake.PRserv")
+
 if sys.hexversion < 0x020600F0:
     print("Sorry, python 2.6 or later is required.")
     sys.exit(1)
@@ -22,9 +24,9 @@ class Handler(SimpleXMLRPCRequestHandler):
         return value
 
 PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
+singleton = None
 
 class PRServer(SimpleXMLRPCServer):
-    pidfile="/tmp/PRServer.pid"
     def __init__(self, dbfile, logfile, interface, daemon=True):
         ''' constructor '''
         SimpleXMLRPCServer.__init__(self, interface,
@@ -33,10 +35,11 @@ class PRServer(SimpleXMLRPCServer):
         self.dbfile=dbfile
         self.daemon=daemon
         self.logfile=logfile
+        self.working_thread=None
         self.host, self.port = self.socket.getsockname()
         self.db=prserv.db.PRData(dbfile)
         self.table=self.db["PRMAIN"]
-        self.pidfile=PIDPREFIX % interface
+        self.pidfile=PIDPREFIX % (self.host, self.port)
 
         self.register_function(self.getPR, "getPR")
         self.register_function(self.quit, "quit")
@@ -44,12 +47,12 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.export, "export")
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
-        
+
     def export(self, version=None, pkgarch=None, checksum=None, colinfo=True):
         try:
             return self.table.export(version, pkgarch, checksum, colinfo)
         except sqlite3.Error as exc:
-            logging.error(str(exc))
+            logger.error(str(exc))
             return None
 
     def importone(self, version, pkgarch, checksum, value):
@@ -58,45 +61,47 @@ class PRServer(SimpleXMLRPCServer):
     def ping(self):
         return not self.quit
 
+    def getinfo(self):
+        return (self.host, self.port)
+
     def getPR(self, version, pkgarch, checksum):
         try:
             return self.table.getValue(version, pkgarch, checksum)
         except prserv.NotFoundError:
-            logging.error("can not find value for (%s, %s)",version, checksum)
+            logger.error("can not find value for (%s, %s)",version, checksum)
             return None
         except sqlite3.Error as exc:
-            logging.error(str(exc))
+            logger.error(str(exc))
             return None
 
     def quit(self):
         self.quit=True
         return
 
-    def _serve_forever(self):
+    def work_forever(self,):
         self.quit = False
         self.timeout = 0.5
+        logger.info("PRServer: started! DBfile: %s, IP: %s, PORT: %s, PID: %s" % 
+                     (self.dbfile, self.host, self.port, str(os.getpid())))
+
         while not self.quit:
             self.handle_request()
 
-        logging.info("PRServer: stopping...")
+        logger.info("PRServer: stopping...")
         self.server_close()
         return
 
     def start(self):
         if self.daemon is True:
-            logging.info("PRServer: try to start daemon...")
+            logger.info("PRServer: try to start daemon...")
             self.daemonize()
         else:
             atexit.register(self.delpid)
             pid = str(os.getpid()) 
             pf = file(self.pidfile, 'w+')
             pf.write("%s\n" % pid)
-            pf.write("%s\n" % self.host)
-            pf.write("%s\n" % self.port)
             pf.close()
-            logging.info("PRServer: start success! DBfile: %s, IP: %s, PORT: %d" % 
-                     (self.dbfile, self.host, self.port))
-            self._serve_forever()
+            self.work_forever()
 
     def delpid(self):
         os.remove(self.pidfile)
@@ -144,17 +149,40 @@ class PRServer(SimpleXMLRPCServer):
         pf.write("%s\n" % pid)
         pf.close()
 
-        logging.info("PRServer: starting daemon success! DBfile: %s, IP: %s, PORT: %s, PID: %s" % 
-                     (self.dbfile, self.host, self.port, pid))
+        self.work_forever()
+        sys.exit(0)
+
+class PRServSingleton():
+    def __init__(self, dbfile, logfile, interface):
+        self.dbfile = dbfile
+        self.logfile = logfile
+        self.interface = interface
+        self.host = None
+        self.port = None
+        self.event = threading.Event()
+
+    def _work(self):
+        self.prserv = PRServer(self.dbfile, self.logfile, self.interface, False)
+        self.host, self.port = self.prserv.getinfo()
+        self.event.set()
+        self.prserv.work_forever()
+        del self.prserv.db
+
+    def start(self):
+        self.working_thread = threading.Thread(target=self._work)
+        self.working_thread.start()
 
-        self._serve_forever()
-        exit(0)
+    def getinfo(self):
+        self.event.wait()
+        return (self.host, self.port)
 
 class PRServerConnection():
     def __init__(self, host, port):
-        self.connection = bb.server.xmlrpc._create_server(host, port)
+        if is_local_special(host, port):
+            host, port = singleton.getinfo()
         self.host = host
         self.port = port
+        self.connection = bb.server.xmlrpc._create_server(self.host, self.port)
 
     def terminate(self):
         # Don't wait for server indefinitely
@@ -173,13 +201,14 @@ class PRServerConnection():
 
     def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
         return self.connection.export(version, pkgarch, checksum, colinfo)
-    
+
     def importone(self, version, pkgarch, checksum, value):
         return self.connection.importone(version, pkgarch, checksum, value)
 
-def start_daemon(dbfile, logfile, interface):
+def start_daemon(dbfile, host, port, logfile):
+    pidfile = PIDPREFIX % (host, port)
     try:
-        pf = file(PRServer.pidfile,'r')
+        pf = file(pidfile,'r')
         pid = int(pf.readline().strip())
         pf.close()
     except IOError:
@@ -187,10 +216,10 @@ def start_daemon(dbfile, logfile, interface):
 
     if pid:
         sys.stderr.write("pidfile %s already exist. Daemon already running?\n"
-                            % PRServer.pidfile)
+                            % pidfile)
         return 1
 
-    server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), interface)
+    server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), (host,port))
     server.start()
     return 0
 
@@ -206,25 +235,70 @@ def stop_daemon(host, port):
     if not pid:
         sys.stderr.write("pidfile %s does not exist. Daemon not running?\n"
                         % pidfile)
-        return 1
 
-    PRServerConnection(host, port).terminate()
+    try:
+        PRServerConnection(host, port).terminate()
+    except:
+        logger.critical("Stop PRService %s:%d failed" % (host,port))
     time.sleep(0.5)
 
     try:
-        while 1:
+        if pid:
+            if os.path.exists(pidfile):
+                os.remove(pidfile)
             os.kill(pid,signal.SIGTERM)
             time.sleep(0.1)
     except OSError as e:
         err = str(e)
-        if err.find("No such process") > 0:
-            if os.path.exists(PRServer.pidfile):
-                os.remove(PRServer.pidfile)
-        else:
-            raise Exception("%s [%d]" % (e.strerror, e.errno))
+        if err.find("No such process") <= 0:
+            raise e
 
     return 0
 
+def is_local_special(host, port):
+    if host.strip().upper() == 'localhost'.upper() and (not port):
+        return True
+    else:
+        return False
+
+def auto_start(d):
+    global singleton 
+    if d.getVar('USE_PR_SERV', True) == '0':
+        return True
+
+    if is_local_special(d.getVar('PRSERV_HOST', True), int(d.getVar('PRSERV_PORT', True))) and not singleton:
+        import bb.utils
+        cachedir = (d.getVar("PERSISTENT_DIR", True) or d.getVar("CACHE", True))
+        if not cachedir:
+            logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
+            sys.exit(1)
+        bb.utils.mkdirhier(cachedir)
+        dbfile = os.path.join(cachedir, "prserv.sqlite3")
+        logfile = os.path.join(cachedir, "prserv.log")
+        singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), ("localhost",0))
+        singleton.start()
+    if singleton:
+        host, port = singleton.getinfo()
+    else:
+        host = d.getVar('PRSERV_HOST', True)
+        port = int(d.getVar('PRSERV_PORT', True))
+
+    try:
+        return PRServerConnection(host,port).ping()
+    except Exception:
+        logger.critical("PRservice %s:%d not available" % (host, port))
+    return False
+
+def auto_shutdown(d=None):
+    global singleton
+    if singleton:
+        host, port = singleton.getinfo()
+        try:
+            PRServerConnection(host, port).terminate()
+        except:
+            logger.critical("Stop PRService %s:%d failed" % (host,port))
+        singleton = None
+
 def ping(host, port):
-    print PRServerConnection(host,port).ping()
-    return 0
+    conn=PRServerConnection(host, port)
+    return conn.ping()
-- 
1.7.0.4



