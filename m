Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 65EFD78485
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Sep 2017 22:26:08 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v8BMQ7Wm002607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 11 Sep 2017 23:26:08 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1drX9b-0007Aa-N0; Mon, 11 Sep 2017 23:26:07 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Sep 2017 23:26:06 +0100
Message-Id: <1505168766-27521-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] process/cooker: Improve readypipe handling
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
X-List-Received-Date: Mon, 11 Sep 2017 22:26:09 -0000

Issues in start are not being correctly detected by the current readypipe
code. Change it to use specific "ready" or "fail" messages to correctly
determine the correct failure mode and avoid bitbake seeming to hang
(it does currently timeout eventually).

[YOCTO #12062]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         |  6 +-----
 lib/bb/server/process.py | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7d040dc..8fe36eb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -165,7 +165,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration, featureSet=None, readypipe=None):
+    def __init__(self, configuration, featureSet=None):
         self.recipecaches = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
@@ -233,10 +233,6 @@ class BBCooker:
         # Let SIGHUP exit as SIGTERM
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
-        if readypipe:
-            os.write(readypipe, b"ready")
-            os.close(readypipe)
-
     def process_inotify_updates(self):
         for n in [self.confignotifier, self.notifier]:
             if n.check_events(timeout=0):
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5c7dfae..6a12f01 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -388,8 +388,10 @@ class BitBakeServer(object):
         self.bitbake_lock.close()
 
         ready = ConnectionReader(self.readypipe)
-        r = ready.wait(30)
-        if not r:
+        r = ready.poll(30)
+        if r:
+            r = ready.get()
+        if not r or r != "ready":
             ready.close()
             bb.error("Unable to start bitbake server")
             if os.path.exists(logfile):
@@ -404,8 +406,15 @@ class BitBakeServer(object):
         print("Starting bitbake server pid %d" % os.getpid())
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
-
-        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset, self.readypipein)
+        writer = ConnectionWriter(self.readypipein)
+        try:
+            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+            writer.send("ready")
+        except:
+            writer.send("fail")
+            raise
+        finally:
+            os.close(self.readypipein)
         server.cooker = self.cooker
         server.server_timeout = self.configuration.server_timeout
         server.xmlrpcinterface = self.configuration.xmlrpcinterface
-- 
2.7.4


