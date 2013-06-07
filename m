Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9521F6A88F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:13:50 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HItda002079 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:18:55 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id YAUX3V7PfYN8 for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:18:55 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HIn6f002071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:18:50 +0100
Message-ID: <1370625214.6864.55.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:13:34 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] prserv: Adapt autostart to bitbake-worker
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2013 17:13:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 8edf8dd..6580078 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -280,6 +280,7 @@ class BitbakeWorker(object):
         bb.msg.loggerDefaultVerbose = self.workerdata["logdefaultverbose"]
         bb.msg.loggerVerboseLogs = self.workerdata["logdefaultverboselogs"]
         bb.msg.loggerDefaultDomains = self.workerdata["logdefaultdomain"]
+        self.data.setVar("PRSERV_HOST", self.workerdata["prhost"])
 
     def handle_ping(self, _):
         workerlog_write("Handling ping\n")
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 77273dc..f375a6f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1177,7 +1177,7 @@ class BBCooker:
         # necessary from the data store.
         #bb.utils.empty_environment()
         try:
-            prserv.serv.auto_start(self.data)
+            self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
             bb.event.fire(CookerExit(), self.event_data)
         return
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 577f04a..bd42538 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -831,6 +831,7 @@ class RunQueue:
             "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
+            "prhost" : self.cooker.prhost,
         }
 
         worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index d7ab9ee..7f9331d 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -207,6 +207,9 @@ class PRServerConnection():
     def importone(self, version, pkgarch, checksum, value):
         return self.connection.importone(version, pkgarch, checksum, value)
 
+    def getinfo(self):
+        return self.host, self.port
+
 def start_daemon(dbfile, host, port, logfile):
     pidfile = PIDPREFIX % (host, port)
     try:
@@ -271,7 +274,7 @@ def auto_start(d):
 
     host_params = filter(None, (d.getVar('PRSERV_HOST', True) or '').split(':'))
     if not host_params:
-        return True
+        return None
 
     if len(host_params) != 2:
         logger.critical('\n'.join(['PRSERV_HOST: incorrect format',
@@ -296,7 +299,11 @@ def auto_start(d):
         port = int(host_params[1])
 
     try:
-        return PRServerConnection(host,port).ping()
+        connection = PRServerConnection(host,port)
+        connection.ping()
+        realhost, realport = connection.getinfo()
+        return str(realhost) + ":" + str(realport)
+        
     except Exception:
         logger.critical("PRservice %s:%d not available" % (host, port))
         raise PRServiceConfigError



