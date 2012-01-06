Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mR-0007OA-1c
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:08 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 06 Jan 2012 01:00:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="53852708"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by AZSMGA002.ch.intel.com with ESMTP; 06 Jan 2012 01:00:44 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:26 +0800
Message-Id: <6c64340b39e458e9359df1e68e25f690a4a11102.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/16] Bitbake: change for adding progress bar in Hob2.
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:08 -0000

From: Shane Wang <shane.wang@intel.com>

The changes include:
- Clean some events in event.py
- Fire essential events for Hob2 to handle with more information.
- knotty changes

Signed-off-by: Shane Wang <shane.wang@intel.com>
Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cache.py     |    2 +-
 lib/bb/cooker.py    |   12 +++++--
 lib/bb/event.py     |   83 ++++++++++++++++++++++++++++++++++++--------------
 lib/bb/ui/knotty.py |    5 ++-
 4 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 955b6df..c268fe6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -345,7 +345,7 @@ class Cache(object):
                         current_percent = 100 * current_progress / cachesize
                         if current_percent > previous_percent:
                             previous_percent = current_percent
-                            bb.event.fire(bb.event.CacheLoadProgress(current_progress),
+                            bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
                                           self.data)
 
                     previous_progress += current_progress
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1e944b8..b495eef 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -344,6 +344,7 @@ class BBCooker:
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
+        bb.event.fire(bb.event.TreeDataPreparationStarted(), self.configuration.data)
         # Need files parsed
         self.updateCache()
         # If we are told to do the None task then query the default task
@@ -360,11 +361,14 @@ class BBCooker:
         taskdata = bb.taskdata.TaskData(False, skiplist=self.skiplist)
 
         runlist = []
+        current = 0
         for k in pkgs_to_build:
             taskdata.add_provider(localdata, self.status, k)
             runlist.append([k, "do_%s" % task])
+            current += 1
+            bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(pkgs_to_build)), self.configuration.data)
         taskdata.add_unresolved(localdata, self.status)
-
+        bb.event.fire(bb.event.TreeDataPreparationCompleted(len(pkgs_to_build)), self.configuration.data)
         return runlist, taskdata
 
     def generateTaskDepTreeData(self, pkgs_to_build, task):
@@ -1093,7 +1097,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(buildname, item, failures), self.configuration.event_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.configuration.event_data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1134,7 +1138,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(buildname, targets, failures), self.configuration.data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.configuration.data)
                 self.command.finishAsyncCommand()
                 return False
             if retval is True:
@@ -1550,7 +1554,7 @@ class CookerParser(object):
         if parsed:
             self.parsed += 1
             if self.parsed % self.progress_chunk == 0:
-                bb.event.fire(bb.event.ParseProgress(self.parsed),
+                bb.event.fire(bb.event.ParseProgress(self.parsed, self.toparse),
                               self.cfgdata)
         else:
             self.cached += 1
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 67543e7..d120ba5 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -204,6 +204,27 @@ def getName(e):
     else:
         return e.__name__
 
+class OperationStarted(Event):
+    """An operation has begun"""
+    def __init__(self, msg = "Operation Started"):
+        Event.__init__(self)
+        self.msg = msg
+
+class OperationCompleted(Event):
+    """An operation has completed"""
+    def __init__(self, total, msg = "Operation Completed"):
+        Event.__init__(self)
+        self.total = total
+        self.msg = msg
+
+class OperationProgress(Event):
+    """An operation is in progress"""
+    def __init__(self, current, total, msg = "Operation in Progress"):
+        Event.__init__(self)
+        self.current = current
+        self.total = total
+        self.msg = msg + ": %s/%s (%.0f%%)" % (current, total, (current*1.0/total)*100);
+
 class ConfigParsed(Event):
     """Configuration Parsing Complete"""
 
@@ -276,14 +297,20 @@ class BuildBase(Event):
 
 
 
-class BuildStarted(BuildBase):
+class BuildStarted(BuildBase, OperationStarted):
     """bbmake build run started"""
+    def __init__(self, n, p, failures = 0):
+        OperationStarted.__init__(self, "Building Started")
+        BuildBase.__init__(self, n, p, failures)
 
-
-class BuildCompleted(BuildBase):
+class BuildCompleted(BuildBase, OperationCompleted):
     """bbmake build run completed"""
-
-
+    def __init__(self, total, n, p, failures = 0):
+        if not failures:
+            OperationCompleted.__init__(self, total, "Building Succeeded")
+        else:
+            OperationCompleted.__init__(self, total, "Building Failed")
+        BuildBase.__init__(self, n, p, failures)
 
 
 class NoProvider(Event):
@@ -329,17 +356,16 @@ class MultipleProviders(Event):
         """
         return self._candidates
 
-class ParseStarted(Event):
+class ParseStarted(OperationStarted):
     """Recipe parsing for the runqueue has begun"""
     def __init__(self, total):
-        Event.__init__(self)
+        OperationStarted.__init__(self, "Recipe parsing Started")
         self.total = total
 
-class ParseCompleted(Event):
+class ParseCompleted(OperationCompleted):
     """Recipe parsing for the runqueue has completed"""
-
     def __init__(self, cached, parsed, skipped, masked, virtuals, errors, total):
-        Event.__init__(self)
+        OperationCompleted.__init__(self, total, "Recipe parsing Completed")
         self.cached = cached
         self.parsed = parsed
         self.skipped = skipped
@@ -347,33 +373,44 @@ class ParseCompleted(Event):
         self.masked = masked
         self.errors = errors
         self.sofar = cached + parsed
-        self.total = total
 
-class ParseProgress(Event):
+class ParseProgress(OperationProgress):
     """Recipe parsing progress"""
+    def __init__(self, current, total):
+        OperationProgress.__init__(self, current, total, "Recipe parsing")
 
-    def __init__(self, current):
-        self.current = current
 
-class CacheLoadStarted(Event):
+class CacheLoadStarted(OperationStarted):
     """Loading of the dependency cache has begun"""
     def __init__(self, total):
-        Event.__init__(self)
+        OperationStarted.__init__(self, "Loading cache Started")
         self.total = total
 
-class CacheLoadProgress(Event):
+class CacheLoadProgress(OperationProgress):
     """Cache loading progress"""
-    def __init__(self, current):
-        Event.__init__(self)
-        self.current = current
+    def __init__(self, current, total):
+        OperationProgress.__init__(self, current, total, "Loading cache")
 
-class CacheLoadCompleted(Event):
+class CacheLoadCompleted(OperationCompleted):
     """Cache loading is complete"""
     def __init__(self, total, num_entries):
-        Event.__init__(self)
-        self.total = total
+        OperationCompleted.__init__(self, total, "Loading cache Completed")
         self.num_entries = num_entries
 
+class TreeDataPreparationStarted(OperationStarted):
+    """Tree data preparation started"""
+    def __init__(self):
+        OperationStarted.__init__(self, "Preparing tree data Started")
+
+class TreeDataPreparationProgress(OperationProgress):
+    """Tree data preparation is in progress"""
+    def __init__(self, current, total):
+        OperationProgress.__init__(self, current, total, "Preparing tree data")
+
+class TreeDataPreparationCompleted(OperationCompleted):
+    """Tree data preparation completed"""
+    def __init__(self, total):
+        OperationCompleted.__init__(self, total, "Preparing tree data Completed")
 
 class DepTreeGenerated(Event):
     """
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 38acb47..fcb6311 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -246,7 +246,10 @@ def main(server, eventHandler):
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
                                   bb.runqueue.runQueueEvent,
-                                  bb.runqueue.runQueueExitWait)):
+                                  bb.runqueue.runQueueExitWait,
+                                  bb.event.OperationStarted,
+                                  bb.event.OperationCompleted,
+                                  bb.event.OperationProgress)):
                 continue
 
             logger.error("Unknown event: %s", event)
-- 
1.7.0.4



