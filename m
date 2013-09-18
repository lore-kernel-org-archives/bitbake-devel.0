Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5DFFA61DDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:54 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 18 Sep 2013 05:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="379998510"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 18 Sep 2013 05:15:55 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A093756087C; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:49 +0100
Message-Id: <a79d7539281ca944f9cc5df83c54337c057445a0.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/7] bitbake: build, runqueue: adds info to the *runQueue* events
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

This patch adds task identifying information for all
runQueue and sceneQueue events, and for bb.build.Task* events.
This will allow matching event to specific tasks in the UI
handlers processing these events.

Adds RunQueueData functions to get the task name and task
file for usage with the runQueue* events.

Adds taskfile and taskname properties to bb.build.TaskBase.

Adds taskfile and taskname properties to the *runQueue* events

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/build.py    |  2 ++
 bitbake/lib/bb/runqueue.py | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 7ee5007..8aec699 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -72,6 +72,8 @@ class TaskBase(event.Event):
     def __init__(self, t, logfile, d):
         self._task = t
         self._package = d.getVar("PF", True)
+        self.taskfile = d.getVar("FILE", True)
+        self.taskname = self._task
         self.logfile = logfile
         event.Event.__init__(self)
         self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 472509f..19e89e9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -217,6 +217,12 @@ class RunQueueData:
             ret.extend([nam])
         return ret
 
+    def get_task_name(self, task):
+        return self.runq_task[task]
+
+    def get_task_file(self, task):
+        return self.taskData.fn_index[self.runq_fnid[task]]
+
     def get_user_idstring(self, task, task_name_suffix = ""):
         fn = self.taskData.fn_index[self.runq_fnid[task]]
         taskname = self.runq_task[task] + task_name_suffix
@@ -1786,6 +1792,8 @@ class runQueueEvent(bb.event.Event):
     def __init__(self, task, stats, rq):
         self.taskid = task
         self.taskstring = rq.rqdata.get_user_idstring(task)
+        self.taskname = rq.rqdata.get_task_name(task)
+        self.taskfile = rq.rqdata.get_task_file(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
@@ -1797,6 +1805,8 @@ class sceneQueueEvent(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         realtask = rq.rqdata.runq_setscene[task]
         self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
+        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
+        self.taskfile = rq.rqdata.get_task_file(realtask)
 
 class runQueueTaskStarted(runQueueEvent):
     """
-- 
1.8.1.2


