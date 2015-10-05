Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2D99C7704D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630434"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:26 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:14 +0100
Message-Id: <8c062543f0a733915cadf54d85bcfa51a182e026.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 2/6] event: add new parameter to Build* event APIs
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:26 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added 't'(task) parameter to BuildStarted and BuildCompleted
event APIs. Modified existing calls of above mentioned APIs:
passed bitbake task name as a parameter.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/cooker.py |  8 ++++----
 lib/bb/event.py  | 12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a0d7d59..ef81c3a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1313,7 +1313,7 @@ class BBCooker:
         taskdata.add_provider(self.data, self.recipecache, item)
 
         buildname = self.data.getVar("BUILDNAME", True)
-        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, [item], task), self.expanded_data)
 
         # Execute the runqueue
         if not task.startswith("do_"):
@@ -1345,7 +1345,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures, interrupted), self.expanded_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, task, failures, interrupted), self.expanded_data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1381,7 +1381,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures, interrupted), self.data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, task, failures, interrupted), self.data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1394,7 +1394,7 @@ class BBCooker:
         taskdata, runlist, fulltargetlist = self.buildTaskData(targets, task, self.configuration.abort)
 
         buildname = self.data.getVar("BUILDNAME", False)
-        bb.event.fire(bb.event.BuildStarted(buildname, fulltargetlist), self.data)
+        bb.event.fire(bb.event.BuildStarted(buildname, fulltargetlist, task), self.data)
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
         if 'universe' in targets:
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 68496e5..bf67ee9 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -328,10 +328,10 @@ class StampUpdate(Event):
 class BuildBase(Event):
     """Base class for bbmake run events"""
 
-    def __init__(self, n, p, failures = 0):
+    def __init__(self, n, p, t, failures = 0):
         self._name = n
         self._pkgs = p
-        self._task = None
+        self._task = t
         Event.__init__(self)
         self._failures = failures
 
@@ -376,19 +376,19 @@ class BuildBase(Event):
 
 class BuildStarted(BuildBase, OperationStarted):
     """bbmake build run started"""
-    def __init__(self, n, p, failures = 0):
+    def __init__(self, n, p, t, failures = 0):
         OperationStarted.__init__(self, "Building Started")
-        BuildBase.__init__(self, n, p, failures)
+        BuildBase.__init__(self, n, p, t, failures)
 
 class BuildCompleted(BuildBase, OperationCompleted):
     """bbmake build run completed"""
-    def __init__(self, total, n, p, failures=0, interrupted=0):
+    def __init__(self, total, n, p, t, failures=0, interrupted=0):
         if not failures:
             OperationCompleted.__init__(self, total, "Building Succeeded")
         else:
             OperationCompleted.__init__(self, total, "Building Failed")
         self._interrupted = interrupted
-        BuildBase.__init__(self, n, p, failures)
+        BuildBase.__init__(self, n, p, t, failures)
 
 class DiskFull(Event):
     """Disk full case build aborted"""
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


