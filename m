Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kNo-0005ci-LI
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:19:56 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:11:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113068249"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:11:15 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:19 +0800
Message-Id: <e78d0c3a15df7d064e9db5accfd921f89e619dac.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 22/32] cooker: fix calculating of depends and rdepends
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
X-List-Received-Date: Wed, 29 Feb 2012 14:19:56 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

Remove part of the original logic that stores pkg dependency and pkg
recomends, which will not be used in Hob.

Add the judgement for preferred fn provider of a certain package,
which maps package name to its providing recipe name.

The above approaches correct the build dependency calculation,
and they also reduced the total depend_tree size, which speed up the
tree data generation time.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/cooker.py |   45 ++++++++++-----------------------------------
 1 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b23b569..e71f72b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -438,19 +438,6 @@ class BBCooker:
 
         return depend_tree
 
-    def append_package(self, taskdata, depend_tree_package, package):
-        if package not in depend_tree_package:
-            targetid = taskdata.getrun_id(package)
-            if targetid in taskdata.run_targets and taskdata.run_targets[targetid]:
-                fnid = taskdata.run_targets[targetid][0]
-                fn = taskdata.fn_index[fnid]
-                pn = self.status.pkg_fn[fn]
-                version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
-                depend_tree_package[package] = {}
-                depend_tree_package[package]["pn"] = pn
-                depend_tree_package[package]["filename"] = fn
-                depend_tree_package[package]["version"] = version
-
     def generatePkgDepTreeData(self, pkgs_to_build, task):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
@@ -466,7 +453,6 @@ class BBCooker:
         depend_tree["depends"] = {}
         depend_tree["pn"] = {}
         depend_tree["rdepends-pn"] = {}
-        depend_tree["packages"] = {}
         depend_tree["rdepends-pkg"] = {}
         depend_tree["rrecs-pkg"] = {}
 
@@ -493,7 +479,6 @@ class BBCooker:
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
-                packages = []
 
                 depend_tree["depends"][pn] = []
                 for dep in taskdata.depids[fnid]:
@@ -510,26 +495,16 @@ class BBCooker:
 
                 depend_tree["rdepends-pn"][pn] = []
                 for rdep in taskdata.rdepids[fnid]:
-                    depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
-
-                for package in rdepends:
-                    depend_tree["rdepends-pkg"][package] = []
-                    for rdepend in rdepends[package]:
-                        depend_tree["rdepends-pkg"][package].append(rdepend)
-                        self.append_package(taskdata, depend_tree["packages"], rdepend)
-                    if not package in packages:
-                        packages.append(package)
-
-                for package in rrecs:
-                    depend_tree["rrecs-pkg"][package] = []
-                    for rrec in rrecs[package]:
-                        depend_tree["rrecs-pkg"][package].append(rrec)
-                        self.append_package(taskdata, depend_tree["packages"], rrec)
-                    if not package in packages:
-                        packages.append(package)
-
-                for package in packages:
-                    self.append_package(taskdata, depend_tree["packages"], package)
+                    item = taskdata.run_names_index[rdep]
+                    pn_rprovider = ""
+                    targetid = taskdata.getrun_id(item)
+                    if targetid in taskdata.run_targets and taskdata.run_targets[targetid]:
+                        id = taskdata.run_targets[targetid][0]
+                        fn_rprovider = taskdata.fn_index[id]
+                        pn_rprovider = self.status.pkg_fn[fn_rprovider]
+                    else:
+                        pn_rprovider = item
+                    depend_tree["rdepends-pn"][pn].append(pn_rprovider)
 
         return depend_tree
 
-- 
1.7.6



