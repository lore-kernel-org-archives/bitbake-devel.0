Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZAQ-0000bI-DY
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:57:06 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 23 Feb 2012 05:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="109911927"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 23 Feb 2012 05:48:43 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:47:14 +0800
Message-Id: <eb567a583a7dbf017e5ac114febb7584816a0265.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/9] command.py: add resolve option for generateTargetsTree API
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
X-List-Received-Date: Thu, 23 Feb 2012 13:57:06 -0000

Currently we have generateTargetsTree API, which is used to get
dependency information. However in that tree, there will be
"virtual/xxx" in depends fields. Therefore we add the resolve option
to replace it with its real providers.

Besides, for packages that provided by multiple recipes, we will find
their preverred provider.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |   11 ++++++++-
 lib/bb/cooker.py  |   58 ++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2a3a3af..05555c5 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -230,14 +230,21 @@ class CommandsAsync:
         included in the package list.
         If pkg_list provided use that list (plus any extras brought in by
         klass) rather than generating a tree for all packages.
+
+        Add a new option "resolve" to indicate if we need to resolve the
+        replacement for "virtual/xxx" like pn.
         """
         klass = params[0]
-        if len(params) > 1:
+        resolve = False
+        if len(params) > 2:
+            pkg_list = params[1]
+            resolve = params[2]
+        elif len(params) > 1:
             pkg_list = params[1]
         else:
             pkg_list = []
 
-        command.cooker.generateTargetsTree(klass, pkg_list)
+        command.cooker.generateTargetsTree(klass, pkg_list, resolve)
         command.finishAsyncCommand()
     generateTargetsTree.needcache = True
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index af91178..85e391b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -429,7 +429,20 @@ class BBCooker:
 
         return depend_tree
 
-    def generatePkgDepTreeData(self, pkgs_to_build, task):
+    def append_package(self, taskdata, depend_tree_package, package):
+        if package not in depend_tree_package:
+            targetid = taskdata.getrun_id(package)
+            if targetid in taskdata.run_targets and taskdata.run_targets[targetid]:
+                fnid = taskdata.run_targets[targetid][0]
+                fn = taskdata.fn_index[fnid]
+                pn = self.status.pkg_fn[fn]
+                version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
+                depend_tree_package[package] = {}
+                depend_tree_package[package]["pn"] = pn
+                depend_tree_package[package]["filename"] = fn
+                depend_tree_package[package]["version"] = version
+
+    def generatePkgDepTreeData(self, pkgs_to_build, task, resolve=False):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
         """
@@ -446,6 +459,7 @@ class BBCooker:
         depend_tree["rdepends-pn"] = {}
         depend_tree["packages"] = {}
         depend_tree["rdepends-pkg"] = {}
+        depend_tree["rrecs-pkg"] = {}
 
         for task in xrange(len(tasks_fnid)):
             fnid = tasks_fnid[task]
@@ -456,6 +470,8 @@ class BBCooker:
             lic = self.status.license[fn]
             section = self.status.section[fn]
             description = self.status.description[fn]
+            rdepends = self.status.rundeps[fn]
+            rrecs = self.status.runrecs[fn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
@@ -464,6 +480,7 @@ class BBCooker:
                 depend_tree["pn"][pn]["license"] = lic
                 depend_tree["pn"][pn]["section"] = section
                 depend_tree["pn"][pn]["description"] = description
+                depend_tree["pn"][pn]["packages"] = rdepends.keys()
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
@@ -471,25 +488,44 @@ class BBCooker:
 
                 depend_tree["depends"][pn] = []
                 for dep in taskdata.depids[fnid]:
-                    depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
+                    if resolve:
+                        item = taskdata.build_names_index[dep]
+                        pn_provider = ""
+                        targetid = taskdata.getbuild_id(item)
+                        if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
+                            fnid = taskdata.build_targets[targetid][0]
+                            fn_provider = taskdata.fn_index[fnid]
+                            pn_provider = self.status.pkg_fn[fn_provider]
+                        else:
+                            pn_provider = item
+                        depend_tree["depends"][pn].append(pn_provider)
+                    else:
+                        depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
 
                 depend_tree["rdepends-pn"][pn] = []
                 for rdep in taskdata.rdepids[fnid]:
                     depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
 
-                rdepends = self.status.rundeps[fn]
                 for package in rdepends:
                     depend_tree["rdepends-pkg"][package] = []
                     for rdepend in rdepends[package]:
                         depend_tree["rdepends-pkg"][package].append(rdepend)
-                    packages.append(package)
+                        if resolve:
+                            self.append_package(taskdata, depend_tree["packages"], rdepend)
+                    if not package in packages:
+                        packages.append(package)
+
+                for package in rrecs:
+                    depend_tree["rrecs-pkg"][package] = []
+                    for rrec in rrecs[package]:
+                        depend_tree["rrecs-pkg"][package].append(rrec)
+                        if resolve:
+                            self.append_package(taskdata, depend_tree["packages"], rrec)
+                    if not package in packages:
+                        packages.append(package)
 
                 for package in packages:
-                    if package not in depend_tree["packages"]:
-                        depend_tree["packages"][package] = {}
-                        depend_tree["packages"][package]["pn"] = pn
-                        depend_tree["packages"][package]["filename"] = fn
-                        depend_tree["packages"][package]["version"] = version
+                    self.append_package(taskdata, depend_tree["packages"], package)
 
         return depend_tree
 
@@ -735,7 +771,7 @@ class BBCooker:
 
         return pkg_list
 
-    def generateTargetsTree(self, klass=None, pkgs=[]):
+    def generateTargetsTree(self, klass=None, pkgs=[], resolve=False):
         """
         Generate a dependency tree of buildable targets
         Generate an event with the result
@@ -750,7 +786,7 @@ class BBCooker:
             pkgs = pkgs + extra_pkgs
 
         # generate a dependency tree for all our packages
-        tree = self.generatePkgDepTreeData(pkgs, 'build')
+        tree = self.generatePkgDepTreeData(pkgs, 'build', resolve)
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
 
     def buildWorldTargetList(self):
-- 
1.7.4.1



