Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C6F1573DF0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 12:50:59 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Aug 2015 05:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,416,1437462000"; d="scan'208";a="755743230"
Received: from tlomotow-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.18.45])
	by orsmga001.jf.intel.com with ESMTP; 26 Aug 2015 05:50:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 13:50:47 +0100
Message-Id: <d98b3a6a91d8cd513ef5b7d8ab609220906570fc.1440593403.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1440593403.git.paul.eggleton@linux.intel.com>
References: <cover.1440593403.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1440593403.git.paul.eggleton@linux.intel.com>
References: <cover.1440593403.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/cooker: add interrupted flag to BuildCompleted event
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
X-List-Received-Date: Wed, 26 Aug 2015 12:50:59 -0000

Allow any listeners for this event (such as buildhistory.bbclass in
OpenEmbedded) to find out if the build was interrupted rather than
completing normally. The value will be 0 if not interrupted, 1 if
interrupted waiting for remaining tasks to complete, or 2 if force
interrupted (stopping any running tasks immediately).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 10 ++++++++--
 lib/bb/event.py  |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6dc9f19..99c4785 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1319,12 +1319,15 @@ class BBCooker:
         def buildFileIdle(server, rq, abort):
 
             msg = None
+            interrupted = 0
             if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
                 msg = "Forced shutdown"
+                interrupted = 2
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
                 msg = "Stopped build"
+                interrupted = 1
             failures = 0
             try:
                 retval = rq.execute_runqueue()
@@ -1336,7 +1339,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.expanded_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures, interrupted), self.expanded_data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1352,12 +1355,15 @@ class BBCooker:
 
         def buildTargetsIdle(server, rq, abort):
             msg = None
+            interrupted = 0
             if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
                 msg = "Forced shutdown"
+                interrupted = 2
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
                 msg = "Stopped build"
+                interrupted = 1
             failures = 0
             try:
                 retval = rq.execute_runqueue()
@@ -1369,7 +1375,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures, interrupted), self.data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 0e18110..3f96bca 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -370,11 +370,12 @@ class BuildStarted(BuildBase, OperationStarted):
 
 class BuildCompleted(BuildBase, OperationCompleted):
     """bbmake build run completed"""
-    def __init__(self, total, n, p, failures = 0):
+    def __init__(self, total, n, p, failures=0, interrupted=0):
         if not failures:
             OperationCompleted.__init__(self, total, "Building Succeeded")
         else:
             OperationCompleted.__init__(self, total, "Building Failed")
+        self._interrupted = interrupted
         BuildBase.__init__(self, n, p, failures)
 
 class DiskFull(Event):
-- 
2.1.0


