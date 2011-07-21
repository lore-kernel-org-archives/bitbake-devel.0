Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QjmNA-0007Ta-5b
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 08:04:36 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 20 Jul 2011 23:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,239,1309762800"; d="scan'208";a="28395000"
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.53])
	by orsmga002.jf.intel.com with ESMTP; 20 Jul 2011 23:00:27 -0700
From: Ke Liping <liping.ke@intel.com>
To: yocto@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 13:50:21 +0800
Message-Id: <6ac3109c3cf221687a96606685fb209cb5d68556.1310696828.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1310696828.git.liping.ke@intel.com>
References: <cover.1310696828.git.liping.ke@intel.com>
In-Reply-To: <cover.1310696828.git.liping.ke@intel.com>
References: <cover.1310696828.git.liping.ke@intel.com>
Subject: [PATCH 1/1][Image Creator] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 06:04:36 -0000

From: Liping Ke <liping.ke@intel.com>

Since Hob only needes package dependency information, we can
create a new version of package information retrieving methods,
remove task dependency information, so that we can greatly
reduce data loading time for Hob

Signed-off-by: Liping Ke <liping.ke@intel.com>
---
 bitbake/lib/bb/cooker.py |   96 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 77 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8badd2d..26ed2ae 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -296,13 +296,12 @@ class BBCooker:
             if data.getVarFlag( e, 'python', envdata ):
                 logger.plain("\npython %s () {\n%s}\n", e, data.getVar(e, envdata, 1))
 
-    def prepareTreeData(self, pkgs_to_build, task):
+    def prepareTreeData(self, pkgs_to_build, task, runqueue=True):
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
         # Need files parsed
         self.updateCache()
-
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
@@ -322,12 +321,22 @@ class BBCooker:
             runlist.append([k, "do_%s" % task])
         taskdata.add_unresolved(localdata, self.status)
 
-        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.status, taskdata, runlist)
-        rq.rqdata.prepare()
-
-        return taskdata, rq
-
-    def generateDepTreeData(self, pkgs_to_build, task, more_meta=False):
+        # For some users, take Hob as example, we only need less dependency data
+        # mark this kind of user as "less_meta" data requesterG
+        if (runqueue):
+            rq = bb.runqueue.RunQueue(self, self.configuration.data, self.status, taskdata, runlist)
+            rq.rqdata.prepare()
+            return taskdata, rq
+        else: 
+            tasks_fnid = []
+            if len(taskdata.tasks_name) == 0:
+            # Nothing to do
+                return
+            for task in xrange(len(taskdata.tasks_name)):
+                tasks_fnid.append(taskdata.tasks_fnid[task])
+            return taskdata, tasks_fnid
+    
+    def generateTaskDepTreeData(self, pkgs_to_build, task):
         """
         Create a dependency tree of pkgs_to_build, returning the data.
         When more_meta is set to True include summary, license and group
@@ -351,18 +360,10 @@ class BBCooker:
             fn = taskdata.fn_index[fnid]
             pn = self.status.pkg_fn[fn]
             version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
-            if more_meta:
-                summary = self.status.summary[fn]
-                lic = self.status.license[fn]
-                section = self.status.section[fn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
-                if more_meta:
-                    depend_tree["pn"][pn]["summary"] = summary
-                    depend_tree["pn"][pn]["license"] = lic
-                    depend_tree["pn"][pn]["section"] = section
             for dep in rq.rqdata.runq_depends[task]:
                 depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
                 deppn = self.status.pkg_fn[depfn]
@@ -407,12 +408,69 @@ class BBCooker:
         return depend_tree
 
 
+    def generatePkgDepTreeData(self, pkgs_to_build, task):
+        """
+        Create a dependency tree of pkgs_to_build, returning the data.
+        When more_meta is set to True include summary, license and group
+        information in the returned tree.
+        """
+        taskdata, tasks_fnid = self.prepareTreeData(pkgs_to_build, task, False)
+
+        seen_fnids = []
+        depend_tree = {}
+        depend_tree["depends"] = {}
+        depend_tree["pn"] = {}
+        depend_tree["rdepends-pn"] = {}
+        depend_tree["packages"] = {}
+        depend_tree["rdepends-pkg"] = {}
+
+        for task in xrange(len(tasks_fnid)):
+            fnid = tasks_fnid[task]
+            fn = taskdata.fn_index[fnid]
+            pn = self.status.pkg_fn[fn]
+            version  = "%s:%s-%s" % self.status.pkg_pepvpr[fn]
+            summary = self.status.summary[fn]
+            lic = self.status.license[fn]
+            section = self.status.section[fn]
+            if pn not in depend_tree["pn"]:
+                depend_tree["pn"][pn] = {}
+                depend_tree["pn"][pn]["filename"] = fn
+                depend_tree["pn"][pn]["version"] = version
+                depend_tree["pn"][pn]["summary"] = summary
+                depend_tree["pn"][pn]["license"] = lic
+                depend_tree["pn"][pn]["section"] = section
+
+            if fnid not in seen_fnids:
+                seen_fnids.append(fnid)
+                packages = []
+
+                depend_tree["depends"][pn] = []
+                for dep in taskdata.depids[fnid]:
+                    depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
+
+                depend_tree["rdepends-pn"][pn] = []
+                for rdep in taskdata.rdepids[fnid]:
+                    depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
+
+                rdepends = self.status.rundeps[fn]
+                for package in rdepends:
+                    packages.append(package)
+
+                for package in packages:
+                    if package not in depend_tree["packages"]:
+                        depend_tree["packages"][package] = {}
+                        depend_tree["packages"][package]["pn"] = pn
+                        depend_tree["packages"][package]["filename"] = fn
+                        depend_tree["packages"][package]["version"] = version
+
+        return depend_tree
+    
     def generateDepTreeEvent(self, pkgs_to_build, task):
         """
         Create a task dependency graph of pkgs_to_build.
         Generate an event with the result
         """
-        depgraph = self.generateDepTreeData(pkgs_to_build, task)
+        depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
         bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.configuration.data)
 
     def generateDotGraphFiles(self, pkgs_to_build, task):
@@ -421,7 +479,7 @@ class BBCooker:
         Save the result to a set of .dot files.
         """
 
-        depgraph = self.generateDepTreeData(pkgs_to_build, task)
+        depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
 
         # Prints a flattened form of package-depends below where subpackages of a package are merged into the main pn
         depends_file = file('pn-depends.dot', 'w' )
@@ -628,7 +686,7 @@ class BBCooker:
             pkgs = pkgs + extra_pkgs
 
         # generate a dependency tree for all our packages
-        tree = self.generateDepTreeData(pkgs, 'build', more_meta=True)
+        tree = self.generatePkgDepTreeData(pkgs, 'build')
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
 
     def buildWorldTargetList(self):
-- 
1.7.0.4



