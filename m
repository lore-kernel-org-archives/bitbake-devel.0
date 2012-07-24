Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1StZLW-00063j-88
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 09:15:54 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6O74O90001998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 24 Jul 2012 00:04:24 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Tue, 24 Jul 2012 00:04:24 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Tue, 24 Jul 2012 15:04:15 +0800
Message-ID: <0c6e89f1ac8abee8be17f821bda9b193b1761f6c.1343113295.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343113295.git.kai.kang@windriver.com>
References: <cover.1343113295.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/2] cooker: treat termination by disk monitor as failure
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
X-List-Received-Date: Tue, 24 Jul 2012 07:15:54 -0000
Content-Type: text/plain

[Yocto #2168]

Check the return value of function diskMonitor.check() in runqueue then
pass it to cooker. The cooker treats that runqueue terminated by disk
monitor as failure, then increase the build failure count if the return
value is true.

The UIs could check the failure count accordingly, and this will helpful
for UIs such as Hob.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
 bitbake/lib/bb/event.py    |    5 +++--
 bitbake/lib/bb/runqueue.py |    9 +++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 361bc88..58a10f7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1095,7 +1095,7 @@ class BBCooker:
                 rq.finish_runqueue(False)
             failures = 0
             try:
-                retval = rq.execute_runqueue()
+                retval, termedbydm = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
@@ -1103,6 +1103,11 @@ class BBCooker:
                 self.command.finishAsyncCommand()
                 return False
 
+            if termedbydm:
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures, bymonitor=True), self.configuration.event_data)
+                self.command.finishAsyncCommand()
+                return False
+
             if not retval:
                 bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.configuration.event_data)
                 self.command.finishAsyncCommand()
@@ -1135,7 +1140,7 @@ class BBCooker:
                 rq.finish_runqueue(False)
             failures = 0
             try:
-                retval = rq.execute_runqueue()
+                retval, termedbydm = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
@@ -1143,6 +1148,11 @@ class BBCooker:
                 self.command.finishAsyncCommand()
                 return False
 
+            if termedbydm:
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures, bymonitor=True), self.configuration.data)
+                self.command.finishAsyncCommand()
+                return False
+
             if not retval:
                 bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 1116c0a..d719105 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -305,14 +305,15 @@ class BuildStarted(BuildBase, OperationStarted):
 
 class BuildCompleted(BuildBase, OperationCompleted):
     """bbmake build run completed"""
-    def __init__(self, total, n, p, failures = 0):
+    def __init__(self, total, n, p, failures = 0, bymonitor = False):
+        if bymonitor:
+            failures += 1
         if not failures:
             OperationCompleted.__init__(self, total, "Building Succeeded")
         else:
             OperationCompleted.__init__(self, total, "Building Failed")
         BuildBase.__init__(self, n, p, failures)
 
-
 class NoProvider(Event):
     """No Provider for an Event"""
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0a8c723..efe3623 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -867,6 +867,7 @@ class RunQueue:
         """
 
         retval = 0.5
+        termedbydm = False
 
         if self.state is runQueuePrepare:
             self.rqexe = RunQueueExecuteDummy(self)
@@ -882,7 +883,7 @@ class RunQueue:
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
-            self.dm.check(self)
+            termedbydm = self.dm.check(self)
 
         if self.state is runQueueSceneRun:
             retval = self.rqexe.execute()
@@ -914,14 +915,14 @@ class RunQueue:
 
         if self.state is runQueueComplete:
             # All done
-            return False
+            return False, termedbydm
 
         if self.state is runQueueChildProcess:
             print("Child process, eeek, shouldn't happen!")
-            return False
+            return False, termedbydm
 
         # Loop
-        return retval
+        return retval, termedbydm
 
     def finish_runqueue(self, now = False):
         if not self.rqexe:
-- 
1.7.5.4



