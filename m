Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2F8F261590
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:56:59 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2013 04:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="403929788"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 16 Sep 2013 04:56:59 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B90AB56062D; Mon, 16 Sep 2013 12:57:00 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:53 +0100
Message-Id: <8a649ee0aa5cd852e54078b3d980b99d37ecad7b.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/8] bitbake: runqueue: add runQueueTaskSkipped event
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

Adding a runQueueTaskSkipped to notify all listeners
about the tasks that are not run either because they
are set-scened or they don't need an update (timestamps
are ok)

Adds RunQueueData functions to get the task name and task
file for usage with the runQueue* events.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/build.py    |  3 +++
 bitbake/lib/bb/runqueue.py | 27 ++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index a53aba9..1265bdc 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -72,6 +72,9 @@ class TaskBase(event.Event):
     def __init__(self, t, d ):
         self._task = t
         self._package = d.getVar("PF", True)
+        self._file = d.getVar("FILE", True)
+        self.taskfile = self._file
+        self.taskname = self._task
         event.Event.__init__(self)
         self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index aa2f147..2ab4405 100644
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
@@ -1328,9 +1334,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
         if self.rqdata.taskData.abort:
             self.rq.state = runQueueCleanUp
 
-    def task_skip(self, task):
+    def task_skip(self, task, skip_reason = ""):
         self.runq_running[task] = 1
         self.runq_buildable[task] = 1
+        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, skip_reason), self.cfgData)
         self.task_completeoutright(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
@@ -1355,13 +1362,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
             if task in self.rq.scenequeue_covered:
                 logger.debug(2, "Setscene covered task %s (%s)", task,
                                 self.rqdata.get_user_idstring(task))
-                self.task_skip(task)
+                self.task_skip(task, "covered")
                 return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
                 logger.debug(2, "Stamp current task %s (%s)", task,
                                 self.rqdata.get_user_idstring(task))
-                self.task_skip(task)
+                self.task_skip(task, "existing")
                 return True
 
             taskdep = self.rqdata.dataCache.task_deps[fn]
@@ -1783,6 +1790,8 @@ class runQueueEvent(bb.event.Event):
     def __init__(self, task, stats, rq):
         self.taskid = task
         self.taskstring = rq.rqdata.get_user_idstring(task)
+        self.taskname = rq.rqdata.get_task_name(task)
+        self.taskfile = rq.rqdata.get_task_file(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
@@ -1794,6 +1803,8 @@ class sceneQueueEvent(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         realtask = rq.rqdata.runq_setscene[task]
         self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
+        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
+        self.taskfile = rq.rqdata.get_task_file(realtask)
 
 class runQueueTaskStarted(runQueueEvent):
     """
@@ -1837,6 +1848,16 @@ class sceneQueueTaskCompleted(sceneQueueEvent):
     Event notifing a setscene task completed
     """
 
+class runQueueTaskSkipped(runQueueEvent):
+    """
+    Event notifing a task was skipped
+    """
+    def __init__(self, task, stats, rq, skip_reason):
+        runQueueEvent.__init__(self, task, stats, rq)
+        self._file = rq.rqdata.get_task_file(task)
+        self._task = rq.rqdata.get_task_name(task)
+        self._skip = skip_reason
+
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
-- 
1.8.1.2


