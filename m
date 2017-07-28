Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id F08AF784B9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 14:55:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6SEtUTV005840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 28 Jul 2017 15:55:31 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1db6fq-0005c6-Sy; Fri, 28 Jul 2017 15:55:30 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Jul 2017 15:55:27 +0100
Message-Id: <1501253729-21511-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1501253729-21511-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 28 Jul 2017 15:55:32 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 5/7] process/cooker: Allow UI process to know if the cooker was started successfully
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
X-List-Received-Date: Fri, 28 Jul 2017 14:55:33 -0000

Currently if the server fails to start, the user sees no error message and
the server will be repeatedly attempted to be started until some longer
timeouts expire. There are error messages in the cookerdeamon log but
nobody thinks to look there.

Add in a pipe which can be used to tell the starting process whether the cooker
did actually start or not. If it fails to start, no further attempts can be
made and if present, the log file can be shown to the user.

[YOCTO #11834]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         |  6 +++++-
 lib/bb/server/process.py | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d6e6919..1a5e003 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -165,7 +165,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, featureSet=None):
+    def __init__(self, configuration, featureSet=None, readypipe=None):
         self.recipecaches = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
@@ -237,6 +237,10 @@ class BBCooker:
         # Let SIGHUP exit as SIGTERM
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
+        if readypipe:
+            os.write(readypipe, b"ready")
+            os.close(readypipe)
+
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index fb96804..b9bde46 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -355,6 +355,7 @@ class BitBakeServer(object):
         self.featureset = featureset
         self.sockname = sockname
         self.bitbake_lock = lock
+        self.readypipe, self.readypipein = os.pipe()
 
         # Create server control socket
         if os.path.exists(sockname):
@@ -363,6 +364,8 @@ class BitBakeServer(object):
         self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
         # AF_UNIX has path length issues so chdir here to workaround
         cwd = os.getcwd()
+        logfile = os.path.join(cwd, "bitbake-cookerdaemon.log")
+
         try:
             os.chdir(os.path.dirname(sockname))
             self.sock.bind(os.path.basename(sockname))
@@ -371,10 +374,23 @@ class BitBakeServer(object):
         self.sock.listen(1)
 
         os.set_inheritable(self.sock.fileno(), True)
-        bb.daemonize.createDaemon(self._startServer, "bitbake-cookerdaemon.log")
+        bb.daemonize.createDaemon(self._startServer, logfile)
         self.sock.close()
         self.bitbake_lock.close()
 
+        ready = ConnectionReader(self.readypipe)
+        r = ready.wait(3)
+        if not r:
+            ready.close()
+            bb.error("Unable to start bitbake server")
+            if os.path.exists(logfile):
+                with open(logfile, "r") as f:
+                    logs=f.readlines()
+                bb.error("Last 10 lines of server log %s:\n%s" % (logfile, "".join(logs[-10:])))
+            raise SystemExit(1)
+        ready.close()
+        os.close(self.readypipein)
+
     def _startServer(self):
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
@@ -385,7 +401,7 @@ class BitBakeServer(object):
             if value:
                 setattr(self.configuration, "%s_server" % param, value)
 
-        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, self.readypipein)
         server.cooker = self.cooker
         server.server_timeout = self.configuration.server_timeout
         server.xmlrpcinterface = self.configuration.xmlrpcinterface
-- 
2.7.4


