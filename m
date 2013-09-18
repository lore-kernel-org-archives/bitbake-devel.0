Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 8C5B661DDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="403549385"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2013 05:15:55 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 9DBDF560829; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:48 +0100
Message-Id: <97928e1d7425fd7e61427d7829330c4c482c6feb.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/7] bitbake: cooker, runqueue: send the task dependency tree
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
X-List-Received-Date: Wed, 18 Sep 2013 12:15:54 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a CookerFeature that allows UIs to enable
receving a dependency tree once the task data has been
computed and the runQueue is ready to start.

This will allow the clients to display dependency
data in an efficient manner, and not recompute the runqueue
specifically to get the dependency data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cooker.py   | 5 ++++-
 bitbake/lib/bb/runqueue.py | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8776e18..dd45ae8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -81,7 +81,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES] = range(1)
+    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE] = range(2)
 
     def __init__(self):
         self._features=set()
@@ -457,7 +457,10 @@ class BBCooker:
         runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
         rq.rqdata.prepare()
+        return self.buildDependTree(rq, taskdata)
 
+
+    def buildDependTree(self, rq, taskdata):
         seen_fnids = []
         depend_tree = {}
         depend_tree["depends"] = {}
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6346c77..472509f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -999,6 +999,11 @@ class RunQueue:
             else:
                 self.state = runQueueSceneInit
 
+                # we are ready to run, see if any UI client needs the dependency info
+                if bb.cooker.CookerFeatures.SEND_DEPENDS_TREE in self.cooker.featureset:
+                    depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
+                    bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
+
         if self.state is runQueueSceneInit:
             if self.cooker.configuration.dump_signatures:
                 self.dump_signatures()
-- 
1.8.1.2


