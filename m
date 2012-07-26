Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SuKiT-0004LV-PR
	for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jul 2012 11:50:46 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q6Q9dEJk014648
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 26 Jul 2012 02:39:14 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 26 Jul 2012 02:39:13 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Thu, 26 Jul 2012 17:39:07 +0800
Message-ID: <29b7d71a66994a626bcbcfce87e9279cb0da7961.1343295453.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343295453.git.kai.kang@windriver.com>
References: <cover.1343295453.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/3] cooker: send event when terminated by disk monitor
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
X-List-Received-Date: Thu, 26 Jul 2012 09:50:46 -0000
Content-Type: text/plain

Part of [Yocto #2168]

Add a event DiskFull to descript the termination by disk monitor.

According to the return info from function diskMonitor.check, runqueue
pass it to cooker. The cooker check the info and send event DiskFull
when runqueue terminated by disk monitor.

The UIs could get the infomation from the event DiskFull.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/cooker.py   |   14 ++++++++++++--
 bitbake/lib/bb/event.py    |    8 ++++++++
 bitbake/lib/bb/runqueue.py |    9 +++++----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5d01af3..d8341b9 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1095,7 +1095,7 @@ class BBCooker:
                 rq.finish_runqueue(False)
             failures = 0
             try:
-                retval = rq.execute_runqueue()
+                retval, dmdata = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
@@ -1103,6 +1103,11 @@ class BBCooker:
                 self.command.finishAsyncCommand()
                 return False
 
+            if 'terminated' in dmdata and dmdata['terminated']:
+                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.event_data)
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
+                retval, dmdata = rq.execute_runqueue()
             except runqueue.TaskFailure as exc:
                 failures += len(exc.args)
                 retval = False
@@ -1143,6 +1148,11 @@ class BBCooker:
                 self.command.finishAsyncCommand()
                 return False
 
+            if 'terminated' in dmdata and dmdata['terminated']:
+                bb.event.fire(bb.event.DiskFull(dmdata['dev'], dmdata['type'], dmdata['freespace'], dmdata['mountpoint']), self.configuration.event_data)
+                self.command.finishAsyncCommand()
+                return False
+
             if not retval:
                 bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 1116c0a..20923b5 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -312,6 +312,14 @@ class BuildCompleted(BuildBase, OperationCompleted):
             OperationCompleted.__init__(self, total, "Building Failed")
         BuildBase.__init__(self, n, p, failures)
 
+class DiskFull(Event):
+    """Disk full case build aborted"""
+    def __init__(self, dev, type, freespace, mountpoint):
+        Event.__init__(self)
+        self._dev = dev
+        self._type = type
+        self._free = freespace
+        self._mountpoint = mountpoint
 
 class NoProvider(Event):
     """No Provider for an Event"""
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0a8c723..233e6a9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -867,6 +867,7 @@ class RunQueue:
         """
 
         retval = 0.5
+        dmdata = {}
 
         if self.state is runQueuePrepare:
             self.rqexe = RunQueueExecuteDummy(self)
@@ -882,7 +883,7 @@ class RunQueue:
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
-            self.dm.check(self)
+            dmdata = self.dm.check(self)
 
         if self.state is runQueueSceneRun:
             retval = self.rqexe.execute()
@@ -914,14 +915,14 @@ class RunQueue:
 
         if self.state is runQueueComplete:
             # All done
-            return False
+            return False, dmdata
 
         if self.state is runQueueChildProcess:
             print("Child process, eeek, shouldn't happen!")
-            return False
+            return False, dmdata
 
         # Loop
-        return retval
+        return retval, dmdata
 
     def finish_runqueue(self, now = False):
         if not self.rqexe:
-- 
1.7.5.4



