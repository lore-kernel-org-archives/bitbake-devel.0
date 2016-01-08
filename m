Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A388B60290
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 18:25:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u08IPv96017082
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Jan 2016 18:25:57 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pST1ucC7Oc5l for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 18:25:57 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u08IPtpX017078
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Jan 2016 18:25:56 GMT
Message-ID: <1452277555.7598.141.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 08 Jan 2016 18:25:55 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] main/runqueue: Add --setscene-only option to bitbake
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
X-List-Received-Date: Fri, 08 Jan 2016 18:25:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its turning out that we really need a way to have bitbake just run
the setscene tasks but not any real tasks, particularly for SDK
operations.

Add an option for this since its pretty straight forward. This allows
various nasty workarounds in OE-Core to be removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index b47e7f3..9f40674 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -137,6 +137,7 @@ class CookerConfiguration(object):
         self.force = False
         self.profile = False
         self.nosetscene = False
+        self.setsceneonly = False
         self.invalidate_stamp = False
         self.dump_signatures = []
         self.dry_run = False
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index c0ae38a..bf59793 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -219,6 +219,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--no-setscene", help = "Do not run any setscene tasks. sstate will be ignored and everything needed, built.",
                    action = "store_true", dest = "nosetscene", default = False)
 
+        parser.add_option("", "--setscene-only", help = "Only run setscene tasks, don't run any real tasks.",
+                   action = "store_true", dest = "setsceneonly", default = False)
+
         parser.add_option("", "--remote-server", help = "Connect to the specified server.",
                    action = "store", dest = "remote_server", default = False)
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index ee06f0e..da7059b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1077,9 +1077,12 @@ class RunQueue:
             retval = self.rqexe.execute()
 
         if self.state is runQueueRunInit:
-            logger.info("Executing RunQueue Tasks")
-            self.rqexe = RunQueueExecuteTasks(self)
-            self.state = runQueueRunning
+            if self.cooker.configuration.setsceneonly:
+                self.state = runQueueComplete
+            else:
+                logger.info("Executing RunQueue Tasks")
+                self.rqexe = RunQueueExecuteTasks(self)
+                self.state = runQueueRunning
 
         if self.state is runQueueRunning:
             retval = self.rqexe.execute()



