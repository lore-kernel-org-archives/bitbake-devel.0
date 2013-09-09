Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 49E636BE34
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Sep 2013 09:41:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="398854312"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2013 09:41:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 72B455605B9; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:53 +0100
Message-Id: <f563c67ca531573081338b958982e719f370cee6.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/13] bitbake: runqueue: Add runQueueTaskSkipped event
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a runQueueTaskSkipped to notify all listeners
about the tasks that are not run either because they
are set-scened or they don't need an update (timestamps
are ok)

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/runqueue.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a868332..f084407 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -217,6 +217,12 @@ class RunQueueData:
             ret.extend([nam])
         return ret
 
+    def get_task_name(self, task):
+        return self.runq_task[task]
+
+    def get_task_package(self, task):
+        return self.taskData.fn_index[self.runq_fnid[task]]
+
     def get_user_idstring(self, task, task_name_suffix = ""):
         fn = self.taskData.fn_index[self.runq_fnid[task]]
         taskname = self.runq_task[task] + task_name_suffix
@@ -1328,6 +1334,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
     def task_skip(self, task):
         self.runq_running[task] = 1
         self.runq_buildable[task] = 1
+        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq), self.cfgData)
         self.task_completeoutright(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
@@ -1828,6 +1835,15 @@ class runQueueTaskCompleted(runQueueEvent):
     Event notifing a task completed
     """
 
+class runQueueTaskSkipped(runQueueEvent):
+    """
+    Event notifing a task was skipped
+    """
+    def __init__(self, task, stats, rq):
+        runQueueEvent.__init__(self, task, stats, rq)
+        self._package = rq.rqdata.get_task_package(task)
+        self._task = rq.rqdata.get_task_name(task)
+
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
-- 
1.8.1.2


