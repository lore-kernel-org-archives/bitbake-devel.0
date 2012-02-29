Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kLV-0005X3-N9
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:17:34 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116105208"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Feb 2012 06:08:03 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:17 +0800
Message-Id: <d1b14159a9d93a3858340ce838e6a857aa3040e6.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 20/32] command.py: remove the resolve parameter in generateTargetsTree
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
X-List-Received-Date: Wed, 29 Feb 2012 14:17:34 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

Remove the "resolve" parameter since the original resolve=False
option is no longer be used.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/command.py                   |   14 +---------
 bitbake/lib/bb/cooker.py                    |   33 +++++++++++---------------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 3 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 06e8869..1799f1c 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -242,21 +242,11 @@ class CommandsAsync:
         included in the package list.
         If pkg_list provided use that list (plus any extras brought in by
         klass) rather than generating a tree for all packages.
-
-        Add a new option "resolve" to indicate if we need to resolve the
-        replacement for "virtual/xxx" like pn.
         """
         klass = params[0]
-        resolve = False
-        if len(params) > 2:
-            pkg_list = params[1]
-            resolve = params[2]
-        elif len(params) > 1:
-            pkg_list = params[1]
-        else:
-            pkg_list = []
+        pkg_list = params[1]
 
-        command.cooker.generateTargetsTree(klass, pkg_list, resolve)
+        command.cooker.generateTargetsTree(klass, pkg_list)
         command.finishAsyncCommand()
     generateTargetsTree.needcache = True
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 12b526b..2e4a1ba 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -451,7 +451,7 @@ class BBCooker:
                 depend_tree_package[package]["filename"] = fn
                 depend_tree_package[package]["version"] = version
 
-    def generatePkgDepTreeData(self, pkgs_to_build, task, resolve=False):
+    def generatePkgDepTreeData(self, pkgs_to_build, task):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
         """
@@ -497,19 +497,16 @@ class BBCooker:
 
                 depend_tree["depends"][pn] = []
                 for dep in taskdata.depids[fnid]:
-                    if resolve:
-                        item = taskdata.build_names_index[dep]
-                        pn_provider = ""
-                        targetid = taskdata.getbuild_id(item)
-                        if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
-                            fnid = taskdata.build_targets[targetid][0]
-                            fn_provider = taskdata.fn_index[fnid]
-                            pn_provider = self.status.pkg_fn[fn_provider]
-                        else:
-                            pn_provider = item
-                        depend_tree["depends"][pn].append(pn_provider)
+                    item = taskdata.build_names_index[dep]
+                    pn_provider = ""
+                    targetid = taskdata.getbuild_id(item)
+                    if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
+                        fnid = taskdata.build_targets[targetid][0]
+                        fn_provider = taskdata.fn_index[fnid]
+                        pn_provider = self.status.pkg_fn[fn_provider]
                     else:
-                        depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
+                        pn_provider = item
+                    depend_tree["depends"][pn].append(pn_provider)
 
                 depend_tree["rdepends-pn"][pn] = []
                 for rdep in taskdata.rdepids[fnid]:
@@ -519,8 +516,7 @@ class BBCooker:
                     depend_tree["rdepends-pkg"][package] = []
                     for rdepend in rdepends[package]:
                         depend_tree["rdepends-pkg"][package].append(rdepend)
-                        if resolve:
-                            self.append_package(taskdata, depend_tree["packages"], rdepend)
+                        self.append_package(taskdata, depend_tree["packages"], rdepend)
                     if not package in packages:
                         packages.append(package)
 
@@ -528,8 +524,7 @@ class BBCooker:
                     depend_tree["rrecs-pkg"][package] = []
                     for rrec in rrecs[package]:
                         depend_tree["rrecs-pkg"][package].append(rrec)
-                        if resolve:
-                            self.append_package(taskdata, depend_tree["packages"], rrec)
+                        self.append_package(taskdata, depend_tree["packages"], rrec)
                     if not package in packages:
                         packages.append(package)
 
@@ -780,7 +775,7 @@ class BBCooker:
 
         return pkg_list
 
-    def generateTargetsTree(self, klass=None, pkgs=[], resolve=False):
+    def generateTargetsTree(self, klass=None, pkgs=[]):
         """
         Generate a dependency tree of buildable targets
         Generate an event with the result
@@ -795,7 +790,7 @@ class BBCooker:
             pkgs = pkgs + extra_pkgs
 
         # generate a dependency tree for all our packages
-        tree = self.generatePkgDepTreeData(pkgs, 'build', resolve)
+        tree = self.generatePkgDepTreeData(pkgs, 'build')
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
 
     def buildWorldTargetList(self):
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 2bf4ed8..6c109fc 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -148,7 +148,7 @@ class HobHandler(gobject.GObject):
         elif next_command == self.PARSE_BBFILES:
             self.server.runCommand(["parseFiles"])
         elif next_command == self.GENERATE_TGTS:
-            self.server.runCommand(["generateTargetsTree", "classes/image.bbclass", [], True])
+            self.server.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.GENERATE_PACKAGEINFO:
             self.server.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
         elif next_command == self.BUILD_TARGET_RECIPES:
-- 
1.7.6



