Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtT-0007r2-CS
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:59 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321724"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:55 -0700
Message-Id: <34bac6c42501b0834fafe72a340eaef5ad80a340.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 09/10] cooker: remove code duplication in non trivial functions
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:59 -0000

The generateTargetsTreeData() and generateDepTreeData() functions perform
are essentially the same function only creating slightly different data
structures. Instead of duplicating non-trivial code drop
generateTargetsTreeData and instead have an optional boolean argument which
defaults to False for generateDepTreeData() which has it include the extra
fields required for the targets tree.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   56 +++++++++++------------------------------------------
 1 files changed, 12 insertions(+), 44 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6682551..3f6edc4 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -325,9 +325,11 @@ class BBCooker:
 
         return taskdata, rq
 
-    def generateDepTreeData(self, pkgs_to_build, task):
+    def generateDepTreeData(self, pkgs_to_build, task, more_meta=False):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
+        When more_meta is set to True include summary, license and group
+        information in the returned tree.
         """
         taskdata, rq = self.prepareTreeData(pkgs_to_build, task)
 
@@ -347,10 +349,18 @@ class BBCooker:
             fn = taskdata.fn_index[fnid]
             pn = self.status.pkg_fn[fn]
             version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
+            if more_meta:
+                summary = self.status.summary[fn]
+                lic = self.status.license[fn]
+                section = self.status.section[fn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
+                if more_meta:
+                    depend_tree["pn"][pn]["summary"] = summary
+                    depend_tree["pn"][pn]["license"] = lic
+                    depend_tree["pn"][pn]["section"] = section
             for dep in rq.rqdata.runq_depends[task]:
                 depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
                 deppn = self.status.pkg_fn[depfn]
@@ -577,48 +587,6 @@ class BBCooker:
 
         return pkg_list
 
-    def generateTargetsTreeData(self, pkgs_to_build, task):
-        """
-        Create a tree of pkgs_to_build metadata, returning the data.
-        """
-        taskdata, rq = self.prepareTreeData(pkgs_to_build, task)
-
-        seen_fnids = []
-        target_tree = {}
-        target_tree["depends"] = {}
-        target_tree["pn"] = {}
-        target_tree["rdepends-pn"] = {}
-
-        for task in xrange(len(rq.rqdata.runq_fnid)):
-            taskname = rq.rqdata.runq_task[task]
-            fnid = rq.rqdata.runq_fnid[task]
-            fn = taskdata.fn_index[fnid]
-            pn = self.status.pkg_fn[fn]
-            version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
-            summary = self.status.summary[fn]
-            license = self.status.license[fn]
-            section = self.status.section[fn]
-            if pn not in target_tree["pn"]:
-                target_tree["pn"][pn] = {}
-                target_tree["pn"][pn]["filename"] = fn
-                target_tree["pn"][pn]["version"] = version
-                target_tree["pn"][pn]["summary"] = summary
-                target_tree["pn"][pn]["license"] = license
-                target_tree["pn"][pn]["section"] = section
-            if fnid not in seen_fnids:
-                seen_fnids.append(fnid)
-                packages = []
-
-                target_tree["depends"][pn] = []
-                for dep in taskdata.depids[fnid]:
-                    target_tree["depends"][pn].append(taskdata.build_names_index[dep])
-
-                target_tree["rdepends-pn"][pn] = []
-                for rdep in taskdata.rdepids[fnid]:
-                    target_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
-
-        return target_tree
-
     def generateTargetsTree(self, klass=None, pkgs=[]):
         """
         Generate a dependency tree of buildable targets
@@ -634,7 +602,7 @@ class BBCooker:
             pkgs = pkgs + extra_pkgs
 
         # generate a dependency tree for all our packages
-        tree = self.generateTargetsTreeData(pkgs, 'build')
+        tree = self.generateDepTreeData(pkgs, 'build', more_meta=True)
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
 
     def buildWorldTargetList(self):
-- 
1.7.5.4



