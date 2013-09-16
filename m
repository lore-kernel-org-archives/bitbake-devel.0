Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 17FDC6102D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:56:59 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2013 04:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="396295382"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2013 04:56:59 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B6481560537; Mon, 16 Sep 2013 12:57:00 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:52 +0100
Message-Id: <ac5fe2cb5237f54c439328ac7b33f2b23b07c8ea.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/8] bitbake: event: send the task dependency tree to UI
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

We add an event that will send the dependency tree
graph to the UI client once it is computed.

This will allow the clients to display dependency
data in an efficient manner, and not redo the runqueue
computation specifically to get the dependency data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cooker.py    | 3 +++
 bitbake/lib/bb/runqueue.py  | 3 +++
 bitbake/lib/bb/ui/knotty.py | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 3bfeefb..68a3c01 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -415,7 +415,10 @@ class BBCooker:
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
index 25f1ab5..aa2f147 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -999,6 +999,9 @@ class RunQueue:
             else:
                 self.state = runQueueSceneInit
 
+                depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
+                bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
+
         if self.state is runQueueSceneInit:
             if self.cooker.configuration.dump_signatures:
                 self.dump_signatures()
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 35590a2..0211b50 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -472,6 +472,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
+            if isinstance(event, bb.event.DepTreeGenerated):
+                continue
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.StampUpdate,
-- 
1.8.1.2


