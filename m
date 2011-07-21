Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjybv-00061F-Ji
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 21:08:40 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Jul 2011 12:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28664014"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 12:04:30 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 12:08:58 -0700
Message-Id: <5d04db12a7cbc14fc0cd34c5a2ae9d9d72a7757b.1311275221.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311275221.git.josh@linux.intel.com>
References: <cover.1311275221.git.josh@linux.intel.com>
In-Reply-To: <cover.1311275221.git.josh@linux.intel.com>
References: <cover.1311275221.git.josh@linux.intel.com>
Subject: [PATCH 1/1] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 19:08:40 -0000

From: Liping Ke <liping.ke@intel.com>

Since Hob only needes package dependency information, we can
create a new version of package information retrieving methods,
remove task dependency information, so that we can greatly
reduce data loading time for Hob

Signed-off-by: Liping Ke <liping.ke@intel.com>
Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   89 +++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 23f2c76..0326b8c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -299,7 +299,6 @@ class BBCooker:
         """
         # Need files parsed
         self.updateCache()
-
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
@@ -319,18 +318,16 @@ class BBCooker:
             runlist.append([k, "do_%s" % task])
         taskdata.add_unresolved(localdata, self.status)
 
-        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.status, taskdata, runlist)
-        rq.rqdata.prepare()
-
-        return taskdata, rq
+        return runlist, taskdata
 
-    def generateDepTreeData(self, pkgs_to_build, task, more_meta=False):
+    def generateTaskDepTreeData(self, pkgs_to_build, task):
         """
-        Create a dependency tree of pkgs_to_build, returning the data.
-        When more_meta is set to True include summary, license and group
-        information in the returned tree.
+        Create a dependency graph of pkgs_to_build including reverse dependency
+        information.
         """
-        taskdata, rq = self.prepareTreeData(pkgs_to_build, task)
+        runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
+        rq = bb.runqueue.RunQueue(self, self.configuration.data, self.status, taskdata, runlist)
+        rq.rqdata.prepare()
 
         seen_fnids = []
         depend_tree = {}
@@ -348,18 +345,10 @@ class BBCooker:
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
@@ -403,13 +392,71 @@ class BBCooker:
 
         return depend_tree
 
+    def generatePkgDepTreeData(self, pkgs_to_build, task):
+        """
+        Create a dependency tree of pkgs_to_build, returning the data.
+        """
+        _, taskdata = self.prepareTreeData(pkgs_to_build, task)
+        tasks_fnid = []
+        if len(taskdata.tasks_name) != 0:
+            for task in xrange(len(taskdata.tasks_name)):
+                tasks_fnid.append(taskdata.tasks_fnid[task])
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
 
     def generateDepTreeEvent(self, pkgs_to_build, task):
         """
         Create a task dependency graph of pkgs_to_build.
         Generate an event with the result
         """
-        depgraph = self.generateDepTreeData(pkgs_to_build, task)
+        depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
         bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.configuration.data)
 
     def generateDotGraphFiles(self, pkgs_to_build, task):
@@ -418,7 +465,7 @@ class BBCooker:
         Save the result to a set of .dot files.
         """
 
-        depgraph = self.generateDepTreeData(pkgs_to_build, task)
+        depgraph = self.generateTaskDepTreeData(pkgs_to_build, task)
 
         # Prints a flattened form of package-depends below where subpackages of a package are merged into the main pn
         depends_file = file('pn-depends.dot', 'w' )
@@ -625,7 +672,7 @@ class BBCooker:
             pkgs = pkgs + extra_pkgs
 
         # generate a dependency tree for all our packages
-        tree = self.generateDepTreeData(pkgs, 'build', more_meta=True)
+        tree = self.generatePkgDepTreeData(pkgs, 'build')
         bb.event.fire(bb.event.TargetsTreeGenerated(tree), self.configuration.data)
 
     def buildWorldTargetList(self):
-- 
1.7.6



