Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 23BFC6111E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:56:59 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2013 04:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="403929786"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 16 Sep 2013 04:56:59 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B399756045D; Mon, 16 Sep 2013 12:57:00 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:51 +0100
Message-Id: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/8] bitbake: cooker: clean up code and avoid duplication
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
X-List-Received-Date: Mon, 16 Sep 2013 11:56:59 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Clean-up to avoid duplication and promote code reuse.
We're using the prepareTreeData in all instances where
this needs to be done.

bb.event.BuildStarted now contains unexpanded package names,
since the UI will show the original target names.

When we're only testing target image contents, we do not abort
with an error if the target is unbuildable.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cooker.py | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a07615b..3bfeefb 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -345,13 +345,7 @@ class BBCooker:
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-            localdata = data.createCopy(self.data)
-            bb.data.update_data(localdata)
-            bb.data.expandKeys(localdata)
-
-            taskdata = bb.taskdata.TaskData(self.configuration.abort)
-            taskdata.add_provider(localdata, self.recipecache, pkgs_to_build[0])
-            taskdata.add_unresolved(localdata, self.recipecache)
+            runlist, taskdata = self.prepareTreeData(pkgs_to_build, None)
 
             targetid = taskdata.getbuild_id(pkgs_to_build[0])
             fnid = taskdata.build_targets[targetid][0]
@@ -398,9 +392,7 @@ class BBCooker:
         localdata = data.createCopy(self.data)
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
-        # We set abort to False here to prevent unbuildable targets raising
-        # an exception when we're just generating data
-        taskdata = bb.taskdata.TaskData(False, skiplist=self.skiplist)
+        taskdata = bb.taskdata.TaskData(self.configuration.abort, skiplist=self.skiplist)
 
         runlist = []
         current = 0
@@ -492,7 +484,12 @@ class BBCooker:
         """
         Create a dependency tree of pkgs_to_build, returning the data.
         """
+
+        # We set abort to False here to prevent unbuildable targets raising
+        # an exception when we're just generating data
+        self.configuration.abort = False
         _, taskdata = self.prepareTreeData(pkgs_to_build, task)
+
         tasks_fnid = []
         if len(taskdata.tasks_name) != 0:
             for task in xrange(len(taskdata.tasks_name)):
@@ -1073,13 +1070,6 @@ class BBCooker:
         Attempt to build the targets specified
         """
 
-        # If we are told to do the NULL task then query the default task
-        if (task == None):
-            task = self.configuration.cmd
-
-        universe = ('universe' in targets)
-        targets = self.checkPackages(targets)
-
         def buildTargetsIdle(server, rq, abort):
             if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
@@ -1106,21 +1096,13 @@ class BBCooker:
         self.buildSetVars()
 
         buildname = self.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.data)
-
-        localdata = data.createCopy(self.data)
-        bb.data.update_data(localdata)
-        bb.data.expandKeys(localdata)
 
-        taskdata = bb.taskdata.TaskData(self.configuration.abort, skiplist=self.skiplist)
+        bb.event.fire(bb.event.BuildStarted(buildname, targets), self.data)
 
-        runlist = []
-        for k in targets:
-            taskdata.add_provider(localdata, self.recipecache, k)
-            runlist.append([k, "do_%s" % task])
-        taskdata.add_unresolved(localdata, self.recipecache)
+        runlist, taskdata = self.prepareTreeData(targets, task)
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
+        universe = ('universe' in targets)
         if universe:
             rq.rqdata.warn_multi_bb = True
 
-- 
1.8.1.2


