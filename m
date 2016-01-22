Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3E9676E6B1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 11:52:50 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Jan 2016 03:52:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,330,1449561600"; d="scan'208";a="896028987"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga002.jf.intel.com with ESMTP; 22 Jan 2016 03:52:50 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jan 2016 00:52:21 +1300
Message-Id: <df370186975d8c614bc0e72a4be8b6b70669f470.1453463510.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1453463510.git.paul.eggleton@linux.intel.com>
References: <cover.1453463510.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1453463510.git.paul.eggleton@linux.intel.com>
References: <cover.1453463510.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] taskdata: add the ability to access world targets list
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
X-List-Received-Date: Fri, 22 Jan 2016 11:52:53 -0000

In certain circumstances it can be useful to get access to the world
targets list from a recipe in order to add dependencies on some or all
of the items in it. If a special function, 'calculate_extra_depends' is
defined in the recipe, and the recipe is to be built, then call it at
the right point before we calculate which tasks should be run. The
function can append items to the "deps" list in order to add
dependencies. This is not as tidy a solution as I would have liked, but
it does at least do the job.

As part of this change, the buildWorldTargets function was moved to
bb.providers to make it possible to call from taskdata.

Part of the implementation of [YOCTO #8600].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cache.py     |  5 ++++-
 lib/bb/cooker.py    | 24 +-----------------------
 lib/bb/providers.py | 26 ++++++++++++++++++++++++++
 lib/bb/taskdata.py  | 17 +++++++++++++++++
 4 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 10b0853..c70b82e 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "148"
+__cache_version__ = "149"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
@@ -144,6 +144,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
         self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
+        self.extradepsfunc    = self.getvar('calculate_extra_depends', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -179,6 +180,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootenv = {}
         cachedata.fakerootnoenv = {}
         cachedata.fakerootdirs = {}
+        cachedata.extradepsfunc = {}
 
     def add_cacheData(self, cachedata, fn):
         cachedata.task_deps[fn] = self.task_deps
@@ -245,6 +247,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootenv[fn] = self.fakerootenv
         cachedata.fakerootnoenv[fn] = self.fakerootnoenv
         cachedata.fakerootdirs[fn] = self.fakerootdirs
+        cachedata.extradepsfunc[fn] = self.extradepsfunc
 
 
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 74190ec..9c58d95 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1109,28 +1109,6 @@ class BBCooker:
         tree = self.generatePkgDepTreeData(pkgs, 'build')
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.data)
 
-    def buildWorldTargetList(self):
-        """
-         Build package list for "bitbake world"
-        """
-        parselog.debug(1, "collating packages for \"world\"")
-        for f in self.recipecache.possible_world:
-            terminal = True
-            pn = self.recipecache.pkg_fn[f]
-
-            for p in self.recipecache.pn_provides[pn]:
-                if p.startswith('virtual/'):
-                    parselog.debug(2, "World build skipping %s due to %s provider starting with virtual/", f, p)
-                    terminal = False
-                    break
-                for pf in self.recipecache.providers[p]:
-                    if self.recipecache.pkg_fn[pf] != pn:
-                        parselog.debug(2, "World build skipping %s due to both us and %s providing %s", f, pf, p)
-                        terminal = False
-                        break
-            if terminal:
-                self.recipecache.world_target.add(pn)
-
     def interactiveMode( self ):
         """Drop off into a shell"""
         try:
@@ -1591,7 +1569,7 @@ class BBCooker:
                 parselog.warn("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
 
         if 'world' in pkgs_to_build:
-            self.buildWorldTargetList()
+            bb.providers.buildWorldTargetList(self.recipecache)
             pkgs_to_build.remove('world')
             for t in self.recipecache.world_target:
                 pkgs_to_build.append(t)
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 637e1fa..68c8d59 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -379,3 +379,29 @@ def getRuntimeProviders(dataCache, rdepend):
             logger.debug(1, "Assuming %s is a dynamic package, but it may not exist" % rdepend)
 
     return rproviders
+
+
+def buildWorldTargetList(dataCache):
+    """
+    Build package list for "bitbake world"
+    """
+    if dataCache.world_target:
+        return
+
+    logger.debug(1, "collating packages for \"world\"")
+    for f in dataCache.possible_world:
+        terminal = True
+        pn = dataCache.pkg_fn[f]
+
+        for p in dataCache.pn_provides[pn]:
+            if p.startswith('virtual/'):
+                logger.debug(2, "World build skipping %s due to %s provider starting with virtual/", f, p)
+                terminal = False
+                break
+            for pf in dataCache.providers[p]:
+                if dataCache.pkg_fn[pf] != pn:
+                    logger.debug(2, "World build skipping %s due to both us and %s providing %s", f, pf, p)
+                    terminal = False
+                    break
+        if terminal:
+            dataCache.world_target.add(pn)
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index b083870..12e8caf 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -172,6 +172,8 @@ class TaskData:
         if fnid in self.tasks_fnid:
             return
 
+        self.add_extra_deps(fn, dataCache)
+
         for task in task_deps['tasks']:
 
             # Work out task dependencies
@@ -242,6 +244,21 @@ class TaskData:
                 self.fail_fnid(fnid)
                 return
 
+    def add_extra_deps(self, fn, dataCache):
+        func = dataCache.extradepsfunc.get(fn, None)
+        if func:
+            bb.providers.buildWorldTargetList(dataCache)
+            pn = dataCache.pkg_fn[fn]
+            params = {'deps': dataCache.deps[fn],
+                      'world_target': dataCache.world_target,
+                      'pkg_pn': dataCache.pkg_pn,
+                      'self_pn': pn}
+            funcname = '_%s_calculate_extra_depends' % pn.replace('-', '_')
+            paramlist = ','.join(params.keys())
+            func = 'def %s(%s):\n%s\n\n%s(%s)' % (funcname, paramlist, func, funcname, paramlist)
+            bb.utils.better_exec(func, params)
+
+
     def have_build_target(self, target):
         """
         Have we a build target matching this name?
-- 
2.5.0


