Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 5A6B96BF68
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:07 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="393133534"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2013 09:41:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 758C35606B6; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:54 +0100
Message-Id: <838cce5be7f3e4c5e0ddb941a742bfa733e8bb8b.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/13] bitbake: runqueue: added prebuild detailed information
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adds why the prebuild tasks were skipped,
as to distinguish about covered/existing tasks.

Adds task name and task package to all runQueue
and sceneQueue events.
---
 bitbake/lib/bb/runqueue.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f084407..002bf76 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1331,10 +1331,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
         if self.rqdata.taskData.abort:
             self.rq.state = runQueueCleanUp
 
-    def task_skip(self, task):
+    def task_skip(self, task, skip_reason = ""):
         self.runq_running[task] = 1
         self.runq_buildable[task] = 1
-        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq), self.cfgData)
+        bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, skip_reason), self.cfgData)
         self.task_completeoutright(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
@@ -1359,13 +1359,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
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
@@ -1786,6 +1786,8 @@ class runQueueEvent(bb.event.Event):
     def __init__(self, task, stats, rq):
         self.taskid = task
         self.taskstring = rq.rqdata.get_user_idstring(task)
+        self.taskname = rq.rqdata.get_task_name(task)
+        self.taskpackage = rq.rqdata.get_task_package(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
@@ -1797,6 +1799,8 @@ class sceneQueueEvent(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         realtask = rq.rqdata.runq_setscene[task]
         self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
+        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
+        self.taskpackage = rq.rqdata.get_task_package(realtask)
 
 class runQueueTaskStarted(runQueueEvent):
     """
@@ -1839,10 +1843,11 @@ class runQueueTaskSkipped(runQueueEvent):
     """
     Event notifing a task was skipped
     """
-    def __init__(self, task, stats, rq):
+    def __init__(self, task, stats, rq, skip_reason):
         runQueueEvent.__init__(self, task, stats, rq)
         self._package = rq.rqdata.get_task_package(task)
         self._task = rq.rqdata.get_task_name(task)
+        self._skip = skip_reason
 
 class runQueuePipe():
     """
-- 
1.8.1.2


