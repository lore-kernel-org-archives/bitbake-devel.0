Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QlLgZ-0001bS-Js
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 15:59:08 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jul 2011 06:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,261,1309762800"; d="scan'208";a="34207814"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.240])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2011 06:54:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 14:54:41 +0100
Message-Id: <3130923c998635aea23d38f423c6827527ec4243.1311601628.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1311601628.git.paul.eggleton@linux.intel.com>
References: <cover.1311601628.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake: show more information for NoProvider errors
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
X-List-Received-Date: Mon, 25 Jul 2011 13:59:08 -0000

"Nothing PROVIDES" errors often come up when a recipe has been skipped
for some reason, and therefore it is useful to print out that reason
information when showing the error so that the user understands why the
error has occurred.

Given that we already feed the reason information into the skiplist for
various situations (COMMERCIAL_LICENSE, COMPATIBLE_MACHINE etc.) this
should now output a useful error message for skipped recipes.

Fixes [YOCTO #846], [YOCTO #1127]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cache.py     |    3 ++-
 bitbake/lib/bb/cooker.py    |    6 ++++--
 bitbake/lib/bb/event.py     |    3 ++-
 bitbake/lib/bb/taskdata.py  |   28 +++++++++++++++++++++++-----
 bitbake/lib/bb/ui/knotty.py |    3 +++
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index bcadc27..cb89d88 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "141"
+__cache_version__ = "142"
 
 def getCacheFile(path, filename):
     return os.path.join(path, filename)
@@ -99,6 +99,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
+            self.pn = self.getvar('PN', metadata) or bb.parse.BBHandler.vars_from_file(filename,metadata)[0]
             self.skipped = True
             self.provides  = self.depvar('PROVIDES', metadata)
             self.rprovides = self.depvar('RPROVIDES', metadata)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7cf43a0..efcbf1b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -59,11 +59,13 @@ class state:
 
 class SkippedPackage:
     def __init__(self, info = None, reason = None):
+        self.pn = None
         self.skipreason = None
         self.provides = None
         self.rprovides = None
 
         if info:
+            self.pn = info.pn
             self.skipreason = info.skipreason
             self.provides = info.provides
             self.rprovides = info.rprovides
@@ -313,7 +315,7 @@ class BBCooker:
         bb.data.expandKeys(localdata)
         # We set abort to False here to prevent unbuildable targets raising
         # an exception when we're just generating data
-        taskdata = bb.taskdata.TaskData(False)
+        taskdata = bb.taskdata.TaskData(False, skiplist=self.skiplist)
 
         runlist = []
         for k in pkgs_to_build:
@@ -1038,7 +1040,7 @@ class BBCooker:
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
 
-        taskdata = bb.taskdata.TaskData(self.configuration.abort)
+        taskdata = bb.taskdata.TaskData(self.configuration.abort, skiplist=self.skiplist)
 
         runlist = []
         for k in targets:
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 93c04ba..9dd7b66 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -287,11 +287,12 @@ class BuildCompleted(BuildBase):
 class NoProvider(Event):
     """No Provider for an Event"""
 
-    def __init__(self, item, runtime=False, dependees=None):
+    def __init__(self, item, runtime=False, dependees=None, reasons=[]):
         Event.__init__(self)
         self._item = item
         self._runtime = runtime
         self._dependees = dependees
+        self._reasons = reasons
 
     def getItem(self):
         return self._item
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 81a42b7..e857f9a 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -41,7 +41,7 @@ class TaskData:
     """
     BitBake Task Data implementation
     """
-    def __init__(self, abort = True, tryaltconfigs = False):
+    def __init__(self, abort = True, tryaltconfigs = False, skiplist = None):
         self.build_names_index = []
         self.run_names_index = []
         self.fn_index = []
@@ -70,6 +70,8 @@ class TaskData:
         self.abort = abort
         self.tryaltconfigs = tryaltconfigs
 
+        self.skiplist = skiplist
+
     def getbuild_id(self, name):
         """
         Return an ID number for the build target name.
@@ -348,6 +350,22 @@ class TaskData:
                 dependees.append(self.fn_index[fnid])
         return dependees
 
+    def get_reasons(self, item, runtime=False):
+        """
+        Get the reason(s) for an item not being provided, if any
+        """
+        reasons = []
+        if self.skiplist:
+            for fn in self.skiplist:
+                skipitem = self.skiplist[fn]
+                if skipitem.pn == item:
+                    reasons.append("%s was skipped: %s" % (skipitem.pn, skipitem.skipreason))
+                elif runtime and item in skipitem.rprovides:
+                    reasons.append("%s RPROVIDES %s but was skipped: %s" % (skipitem.pn, item, skipitem.skipreason))
+                elif not runtime and item in skipitem.provides:
+                    reasons.append("%s PROVIDES %s but was skipped: %s" % (skipitem.pn, item, skipitem.skipreason))
+        return reasons
+
     def add_provider(self, cfgData, dataCache, item):
         try:
             self.add_provider_internal(cfgData, dataCache, item)
@@ -369,7 +387,7 @@ class TaskData:
             return
 
         if not item in dataCache.providers:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_rdependees_str(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_rdependees_str(item), reasons=self.get_reasons(item)), cfgData)
             raise bb.providers.NoProvider(item)
 
         if self.have_build_target(item):
@@ -381,7 +399,7 @@ class TaskData:
         eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
 
         if not eligible:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=["No eligible PROVIDERs exist for '%s'" % item]), cfgData)
             raise bb.providers.NoProvider(item)
 
         if len(eligible) > 1 and foundUnique == False:
@@ -418,14 +436,14 @@ class TaskData:
         all_p = bb.providers.getRuntimeProviders(dataCache, item)
 
         if not all_p:
-            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item), reasons=self.get_reasons(item, True)), cfgData)
             raise bb.providers.NoRProvider(item)
 
         eligible, numberPreferred = bb.providers.filterProvidersRunTime(all_p, item, cfgData, dataCache)
         eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
 
         if not eligible:
-            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item), reasons=["No eligible RPROVIDERs exist for '%s'" % item]), cfgData)
             raise bb.providers.NoRProvider(item)
 
         if len(eligible) > 1 and numberPreferred == 0:
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a4deb46..b7abdf8 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -208,6 +208,9 @@ def main(server, eventHandler):
                     logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)", r, event._item, ", ".join(event._dependees), r)
                 else:
                     logger.error("Nothing %sPROVIDES '%s'", r, event._item)
+                if event._reasons:
+                    for reason in event._reasons:
+                        logger.error("%s", reason)
                 continue
 
             if isinstance(event, bb.runqueue.runQueueTaskStarted):
-- 
1.7.4.1



