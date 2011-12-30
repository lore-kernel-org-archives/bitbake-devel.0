Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RgTcN-0003zP-9k
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Dec 2011 04:58:56 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 29 Dec 2011 19:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="107167050"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by fmsmga002.fm.intel.com with ESMTP; 29 Dec 2011 19:50:34 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Dec 2011 11:49:06 +0800
Message-Id: <4b7c60fcff831d944abc7bffda05a2daedfb55a7.1325213895.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325213895.git.lianhao.lu@intel.com>
References: <cover.1325213895.git.lianhao.lu@intel.com>
Subject: [PRService/bitbake 1/2] bitbake/PRservice: Added no_hist mode and export/import.
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
X-List-Received-Date: Fri, 30 Dec 2011 03:58:56 -0000

[YOCTO #1556]
1. Added the package_arch into the index to the DB table. Because the
change in PACKAGE_ARCH will results in different checksum, and it is
better to have seperate PR value domains for differnt PACKAGE_ARCH of
the same pakcage.

2. Changed the PR service to operate in no history mode. In this mode,
the for a given query tuple (version, pkgarch, checksum), the returned
value will be the largest among all the values of the same (version,
pkgarch). This means the PR value returned can NOT be decremented.

3. Added export function. For each (version, pkgarch) tuple, only the
record with the maximum value will be exported.

4. Added import function. The record will only be imported if the
imported value is larger than the value stored in the DB with the same
(version, pkgarch, checksum) tuple.

Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
---
 bitbake/bin/bitbake-prserv     |   23 +++--
 bitbake/lib/prserv/__init__.py |    5 +-
 bitbake/lib/prserv/db.py       |  209 ++++++++++++++++++++++++++++++++++------
 bitbake/lib/prserv/serv.py     |  106 +++++++++++++-------
 4 files changed, 263 insertions(+), 80 deletions(-)
 mode change 100644 => 100755 bitbake/bin/bitbake-prserv

diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
old mode 100644
new mode 100755
index 14073ca..a7ab55f
--- a/bitbake/bin/bitbake-prserv
+++ b/bitbake/bin/bitbake-prserv
@@ -16,31 +16,34 @@ PRPORT_DEFAULT=8585
 def main():
     parser = optparse.OptionParser(
         version="Bitbake PR Service Core version %s, %%prog version %s" % (prserv.__version__, __version__),
-        usage = "%prog [options]")
+        usage = "%prog < --start | --stop > [options]")
 
-    parser.add_option("-f", "--file", help="database filename(default prserv.db)", action="store",
+    parser.add_option("-f", "--file", help="database filename(default: prserv.db)", action="store",
                       dest="dbfile", type="string", default="prserv.db")
-    parser.add_option("-l", "--log", help="log filename(default prserv.log)", action="store",
+    parser.add_option("-l", "--log", help="log filename(default: prserv.log)", action="store",
                       dest="logfile", type="string", default="prserv.log")
     parser.add_option("--loglevel", help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
-                      action = "store", type="string", dest="loglevel", default = "WARNING")
+                      action = "store", type="string", dest="loglevel", default = "INFO")
     parser.add_option("--start", help="start daemon",
-                      action="store_true", dest="start", default="True")
+                      action="store_true", dest="start")
     parser.add_option("--stop", help="stop daemon",
-                      action="store_false", dest="start")
+                      action="store_true", dest="stop")
     parser.add_option("--host", help="ip address to bind", action="store",
                       dest="host", type="string", default=PRHOST_DEFAULT)
-    parser.add_option("--port", help="port number(default 8585)", action="store",
+    parser.add_option("--port", help="port number(default: 8585)", action="store",
                       dest="port", type="int", default=PRPORT_DEFAULT)
 
     options, args = parser.parse_args(sys.argv)
-
     prserv.init_logger(os.path.abspath(options.logfile),options.loglevel)
 
     if options.start:
-        prserv.serv.start_daemon(options)
+        ret=prserv.serv.start_daemon(dbfile=options.dbfile, interface=(options.host, options.port),
+                      logfile=os.path.abspath(options.logfile))
+    elif options.stop:
+        ret=prserv.serv.stop_daemon(options.host, options.port)
     else:
-        prserv.serv.stop_daemon()
+        ret=parser.print_help()
+    return ret
 
 if __name__ == "__main__":
     try:
diff --git a/bitbake/lib/prserv/__init__.py b/bitbake/lib/prserv/__init__.py
index 2837e13..c27fffe 100644
--- a/bitbake/lib/prserv/__init__.py
+++ b/bitbake/lib/prserv/__init__.py
@@ -7,5 +7,8 @@ def init_logger(logfile, loglevel):
     numeric_level = getattr(logging, loglevel.upper(), None)
     if not isinstance(numeric_level, int):
         raise ValueError('Invalid log level: %s' % loglevel)
-    logging.basicConfig(level=numeric_level, filename=logfile)
+    FORMAT = '%(asctime)-15s %(message)s'
+    logging.basicConfig(level=numeric_level, filename=logfile, format=FORMAT)
 
+class NotFoundError(StandardError):
+    pass
\ No newline at end of file
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index bbee931..f267dae 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -1,9 +1,7 @@
 import logging
 import os.path
 import errno
-import sys
-import warnings
-import sqlite3
+import prserv
 
 try:
     import sqlite3
@@ -14,73 +12,220 @@ sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
     raise Exception("sqlite3 version 3.3.0 or later is required.")
 
-class NotFoundError(StandardError):
-    pass
-
 class PRTable():
-    def __init__(self,cursor,table):
-        self.cursor = cursor
-        self.table = table
+    def __init__(self, conn, table, nohist):
+        self.conn = conn
+        self.nohist = nohist
+        if nohist:
+            self.table = "%s_nohist" % table 
+        else:
+            self.table = "%s_hist" % table 
 
-        #create the table
         self._execute("CREATE TABLE IF NOT EXISTS %s \
                     (version TEXT NOT NULL, \
+                    pkgarch TEXT NOT NULL,  \
                     checksum TEXT NOT NULL, \
                     value INTEGER, \
-                    PRIMARY KEY (version,checksum));"
-                      % table)
+                    PRIMARY KEY (version, pkgarch, checksum));" % self.table)
 
     def _execute(self, *query):
         """Execute a query, waiting to acquire a lock if necessary"""
         count = 0
         while True:
             try:
-                return self.cursor.execute(*query)
+                return self.conn.execute(*query)
             except sqlite3.OperationalError as exc:
                 if 'database is locked' in str(exc) and count < 500:
                     count = count + 1
                     continue
-                raise
-            except sqlite3.IntegrityError as exc:
-                print "Integrity error %s" % str(exc)
-                break
+                raise exc
 
-    def getValue(self, version, checksum):
-        data=self._execute("SELECT value FROM %s WHERE version=? AND checksum=?;" % self.table,
-                           (version,checksum))
+    def _getValueHist(self, version, pkgarch, checksum):
+        data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                           (version, pkgarch, checksum))
         row=data.fetchone()
         if row != None:
             return row[0]
         else:
             #no value found, try to insert
-            self._execute("INSERT INTO %s VALUES (?, ?, (select ifnull(max(value)+1,0) from %s where version=?));" 
+            try:
+                self._execute("BEGIN")
+                self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
                            % (self.table,self.table),
-                           (version,checksum,version))
-            data=self._execute("SELECT value FROM %s WHERE version=? AND checksum=?;" % self.table,
-                               (version,checksum))
+                           (version,pkgarch, checksum,version, pkgarch))
+                self.conn.commit()
+            except sqlite3.IntegrityError as exc:
+                logging.error(str(exc))
+
+            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                               (version, pkgarch, checksum))
+            row=data.fetchone()
+            if row != None:
+                return row[0]
+            else:
+                raise prserv.NotFoundError
+
+    def _getValueNohist(self, version, pkgarch, checksum):
+        data=self._execute("SELECT value FROM %s \
+                            WHERE version=? AND pkgarch=? AND checksum=? AND \
+                            value >= (select max(value) from %s where version=? AND pkgarch=?);" 
+                            % (self.table, self.table),
+                            (version, pkgarch, checksum, version, pkgarch))
+        row=data.fetchone()
+        if row != None:
+            return row[0]
+        else:
+            #no value found, try to insert
+            try:
+                self._execute("BEGIN")
+                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
+                               % (self.table,self.table),
+                               (version, pkgarch, checksum, version, pkgarch))
+                self.conn.commit()
+            except sqlite3.IntegrityError as exc:
+                logging.error(str(exc))
+                self.conn.rollback()
+
+            data=self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                               (version, pkgarch, checksum))
             row=data.fetchone()
             if row != None:
                 return row[0]
             else:
-                raise NotFoundError
+                raise prserv.NotFoundError
+
+    def getValue(self, version, pkgarch, checksum):
+        if self.nohist:
+            return self._getValueNohist(version, pkgarch, checksum)
+        else:
+            return self._getValueHist(version, pkgarch, checksum)
+
+    def _importHist(self, version, pkgarch, checksum, value):
+        val = None 
+        data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                           (version, pkgarch, checksum))
+        row = data.fetchone()
+        if row != None:
+            val=row[0]
+        else:
+            #no value found, try to insert
+            try:
+                self._execute("BEGIN")
+                self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                           (version, pkgarch, checksum, value))
+                self.conn.commit()
+            except sqlite3.IntegrityError as exc:
+                logging.error(str(exc))
+
+            data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
+                           (version, pkgarch, checksum))
+            row = data.fetchone()
+            if row != None:
+                val = row[0]
+        return val
+
+    def _importNohist(self, version, pkgarch, checksum, value):
+        try:
+            #try to insert
+            self._execute("BEGIN")
+            self._execute("INSERT OR ROLLBACK INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
+                           (version, pkgarch, checksum,value))
+            self.conn.commit()
+        except sqlite3.IntegrityError as exc:
+            #already have the record, try to update
+            try:
+                self._execute("BEGIN")
+                self._execute("UPDATE %s SET value=? WHERE version=? AND pkgarch=? AND checksum=? AND value<?"  
+                              % (self.table),
+                               (value,version,pkgarch,checksum,value))
+                self.conn.commit()
+            except sqlite3.IntegrityError as exc:
+                logging.error(str(exc))
+
+        data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=? AND value>=?;" % self.table,
+                            (version,pkgarch,checksum,value))
+        row=data.fetchone()
+        if row != None:
+            return row[0]
+        else:
+            return None
+
+    def importone(self, version, pkgarch, checksum, value):
+        if self.nohist:
+            return self._importNohist(version, pkgarch, checksum, value)
+        else:
+            return self._importHist(version, pkgarch, checksum, value)
+
+    def export(self, version, pkgarch, checksum, colinfo):
+        metainfo = {}
+        #column info 
+        if colinfo:
+            metainfo['tbl_name'] = self.table
+            metainfo['core_ver'] = prserv.__version__
+            metainfo['col_info'] = []
+            data = self._execute("PRAGMA table_info(%s);" % self.table)
+            for row in data:
+                col = {}
+                col['name'] = row['name']
+                col['type'] = row['type']
+                col['notnull'] = row['notnull']
+                col['dflt_value'] = row['dflt_value']
+                col['pk'] = row['pk']
+                metainfo['col_info'].append(col)
+
+        #data info
+        datainfo = []
+
+        if self.nohist:
+            sqlstmt = "SELECT T1.version, T1.pkgarch, T1.checksum, T1.value FROM %s as T1, \
+                    (SELECT version,pkgarch,max(value) as maxvalue FROM %s GROUP BY version,pkgarch) as T2 \
+                    WHERE T1.version=T2.version AND T1.pkgarch=T2.pkgarch AND T1.value=T2.maxvalue " % (self.table, self.table)
+        else:
+            sqlstmt = "SELECT * FROM %s as T1 WHERE 1=1 " % self.table
+        sqlarg = []
+        where = ""
+        if version:
+            where += "AND T1.version=? "
+            sqlarg.append(str(version))
+        if pkgarch:
+            where += "AND T1.pkgarch=? "
+            sqlarg.append(str(pkgarch))
+        if checksum:
+            where += "AND T1.checksum=? "
+            sqlarg.append(str(checksum))
+
+        sqlstmt += where + ";"
+
+        if len(sqlarg):
+            data = self._execute(sqlstmt, tuple(sqlarg))
+        else:
+            data = self._execute(sqlstmt)
+        for row in data:
+            if row['version']:
+                col = {}
+                col['version'] = row['version']
+                col['pkgarch'] = row['pkgarch']
+                col['checksum'] = row['checksum']
+                col['value'] = row['value']
+                datainfo.append(col)
+        return (metainfo, datainfo)
 
 class PRData(object):
     """Object representing the PR database"""
-    def __init__(self, filename):
+    def __init__(self, filename, nohist=True):
         self.filename=os.path.abspath(filename)
+        self.nohist=nohist
         #build directory hierarchy
         try:
             os.makedirs(os.path.dirname(self.filename))
         except OSError as e:
             if e.errno != errno.EEXIST:
                 raise e
-        self.connection=sqlite3.connect(self.filename, timeout=5,
-                                          isolation_level=None)
-        self.cursor=self.connection.cursor()
+        self.connection=sqlite3.connect(self.filename, isolation_level="DEFERRED")
+        self.connection.row_factory=sqlite3.Row
         self._tables={}
 
     def __del__(self):
-        print "PRData: closing DB %s" % self.filename
         self.connection.close()
 
     def __getitem__(self,tblname):
@@ -90,11 +235,11 @@ class PRData(object):
         if tblname in self._tables:
             return self._tables[tblname]
         else:
-            tableobj = self._tables[tblname] = PRTable(self.cursor, tblname)
+            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist)
             return tableobj
 
     def __delitem__(self, tblname):
         if tblname in self._tables:
             del self._tables[tblname]
         logging.info("drop table %s" % (tblname))
-        self.cursor.execute("DROP TABLE IF EXISTS %s;" % tblname) 
+        self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname) 
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 2f488f4..7bcffa7 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -21,6 +21,8 @@ class Handler(SimpleXMLRPCRequestHandler):
             raise
         return value
 
+PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
+
 class PRServer(SimpleXMLRPCServer):
     pidfile="/tmp/PRServer.pid"
     def __init__(self, dbfile, logfile, interface, daemon=True):
@@ -34,20 +36,33 @@ class PRServer(SimpleXMLRPCServer):
         self.host, self.port = self.socket.getsockname()
         self.db=prserv.db.PRData(dbfile)
         self.table=self.db["PRMAIN"]
+        self.pidfile=PIDPREFIX % interface
 
         self.register_function(self.getPR, "getPR")
         self.register_function(self.quit, "quit")
         self.register_function(self.ping, "ping")
+        self.register_function(self.export, "export")
+        self.register_function(self.importone, "importone")
         self.register_introspection_functions()
+        
+    def export(self, version=None, pkgarch=None, checksum=None, colinfo=True):
+        try:
+            return self.table.export(version, pkgarch, checksum, colinfo)
+        except sqlite3.Error as exc:
+            logging.error(str(exc))
+            return None
+
+    def importone(self, version, pkgarch, checksum, value):
+        return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
         return not self.quit
- 
-    def getPR(self, version, checksum):
+
+    def getPR(self, version, pkgarch, checksum):
         try:
-            return self.table.getValue(version,checksum)
+            return self.table.getValue(version, pkgarch, checksum)
         except prserv.NotFoundError:
-            logging.error("can not find value for (%s, %s)",version,checksum)
+            logging.error("can not find value for (%s, %s)",version, checksum)
             return None
         except sqlite3.Error as exc:
             logging.error(str(exc))
@@ -69,28 +84,34 @@ class PRServer(SimpleXMLRPCServer):
 
     def start(self):
         if self.daemon is True:
-            logging.info("PRServer: starting daemon...")
+            logging.info("PRServer: try to start daemon...")
             self.daemonize()
         else:
-            logging.info("PRServer: starting...")
+            atexit.register(self.delpid)
+            pid = str(os.getpid()) 
+            pf = file(self.pidfile, 'w+')
+            pf.write("%s\n" % pid)
+            pf.write("%s\n" % self.host)
+            pf.write("%s\n" % self.port)
+            pf.close()
+            logging.info("PRServer: start success! DBfile: %s, IP: %s, PORT: %d" % 
+                     (self.dbfile, self.host, self.port))
             self._serve_forever()
 
     def delpid(self):
-        os.remove(PRServer.pidfile)
+        os.remove(self.pidfile)
 
     def daemonize(self):
         """
         See Advanced Programming in the UNIX, Sec 13.3
         """
-        os.umask(0)
-
         try:
             pid = os.fork()
-            if pid > 0: 
-                sys.exit(0)
+            if pid > 0:
+                #parent return instead of exit to give control 
+                return
         except OSError as e:
-            sys.stderr.write("1st fork failed: %d %s\n" % (e.errno, e.strerror))
-            sys.exit(1)
+            raise Exception("%s [%d]" % (e.strerror, e.errno))
 
         os.setsid()
         """
@@ -102,9 +123,9 @@ class PRServer(SimpleXMLRPCServer):
             if pid > 0: #parent
                 sys.exit(0)
         except OSError as e:
-            sys.stderr.write("2nd fork failed: %d %s\n" % (e.errno, e.strerror))
-            sys.exit(1)
+            raise Exception("%s [%d]" % (e.strerror, e.errno))
 
+        os.umask(0)
         os.chdir("/")
 
         sys.stdout.flush()
@@ -119,13 +140,15 @@ class PRServer(SimpleXMLRPCServer):
         # write pidfile
         atexit.register(self.delpid)
         pid = str(os.getpid()) 
-        pf = file(PRServer.pidfile, 'w+')
+        pf = file(self.pidfile, 'w')
         pf.write("%s\n" % pid)
-        pf.write("%s\n" % self.host)
-        pf.write("%s\n" % self.port)
         pf.close()
 
+        logging.info("PRServer: starting daemon success! DBfile: %s, IP: %s, PORT: %s, PID: %s" % 
+                     (self.dbfile, self.host, self.port, pid))
+
         self._serve_forever()
+        exit(0)
 
 class PRServerConnection():
     def __init__(self, host, port):
@@ -139,16 +162,22 @@ class PRServerConnection():
         socket.setdefaulttimeout(2)
         try:
             self.connection.quit()
-        except:
-            pass
+        except Exception as exc:
+            sys.stderr.write("%s\n" % str(exc))
 
-    def getPR(self, version, checksum):
-        return self.connection.getPR(version, checksum)
+    def getPR(self, version, pkgarch, checksum):
+        return self.connection.getPR(version, pkgarch, checksum)
 
     def ping(self):
         return self.connection.ping()
 
-def start_daemon(options):
+    def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
+        return self.connection.export(version, pkgarch, checksum, colinfo)
+    
+    def importone(self, version, pkgarch, checksum, value):
+        return self.connection.importone(version, pkgarch, checksum, value)
+
+def start_daemon(dbfile, logfile, interface):
     try:
         pf = file(PRServer.pidfile,'r')
         pid = int(pf.readline().strip())
@@ -159,40 +188,43 @@ def start_daemon(options):
     if pid:
         sys.stderr.write("pidfile %s already exist. Daemon already running?\n"
                             % PRServer.pidfile)
-        sys.exit(1)
+        return 1
 
-    server = PRServer(options.dbfile, interface=(options.host, options.port),
-                      logfile=os.path.abspath(options.logfile))
+    server = PRServer(os.path.abspath(dbfile), os.path.abspath(logfile), interface)
     server.start()
+    return 0
 
-def stop_daemon():
+def stop_daemon(host, port):
+    pidfile = PIDPREFIX % (host, port)
     try:
-        pf = file(PRServer.pidfile,'r')
+        pf = file(pidfile,'r')
         pid = int(pf.readline().strip())
-        host = pf.readline().strip()
-        port = int(pf.readline().strip())
         pf.close()
     except IOError:
         pid = None
 
     if not pid:
         sys.stderr.write("pidfile %s does not exist. Daemon not running?\n"
-                        % PRServer.pidfile)
-        sys.exit(1)
+                        % pidfile)
+        return 1
 
-    PRServerConnection(host,port).terminate()
+    PRServerConnection(host, port).terminate()
     time.sleep(0.5)
 
     try:
         while 1:
             os.kill(pid,signal.SIGTERM)
             time.sleep(0.1)
-    except OSError as err:
-        err = str(err)
+    except OSError as e:
+        err = str(e)
         if err.find("No such process") > 0:
             if os.path.exists(PRServer.pidfile):
                 os.remove(PRServer.pidfile)
         else:
-            print err
-            sys.exit(1)
+            raise Exception("%s [%d]" % (e.strerror, e.errno))
+
+    return 0
 
+def ping(host, port):
+    print PRServerConnection(host,port).ping()
+    return 0
-- 
1.7.0.4



