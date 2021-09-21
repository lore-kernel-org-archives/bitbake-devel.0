Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web11.4953.1632213334869589697
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 01:35:35 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="210390181"
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="210390181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.85,310,1624345200"; 
   d="scan'208";a="701611424"
Received: from marsalan-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 01:35:28 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [hardknott][PATCH 4/8] runqueue: Clean up task stats handling
Date: Tue, 21 Sep 2021 16:35:12 +0800
Message-Id: <f28205fddf22513319f2143a09c93b39f1989e30.1632212181.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632212181.git.anuj.mittal@intel.com>
References: <cover.1632212181.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

When we parallelised normal and setscene tasks, the task stats
handling was left separate pending further thought. We had to remove
handling of the setscene tasks from the UI in order to maintain
consistent task numbering.

Currently, "0 of 0" tasks can be shown as setscene tasks execute
until the first normal task runs.

The only use left for sq_stats is in the active task numbers which
we can use the length of sq_ive for instead. We can therefore
drop it and return stats in all cases. This removes the "0 of 0" task
problem since the stats in all normal and setscene tasks matches.

[YOCTO #14479]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit eae6e947e37e18cded053814bd2a268b44fb25cd)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py    | 22 +++++++---------------
 lib/bb/ui/uihelper.py |  2 +-
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5ccf755f1..6ce0ce80f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1736,7 +1736,6 @@ class RunQueueExecute:
         self.sqdone = False
 
         self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
-        self.sq_stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
 
         for mc in rq.worker:
             rq.worker[mc].pipe.setrunqueueexec(self)
@@ -1820,7 +1819,7 @@ class RunQueueExecute:
     def finish(self):
         self.rq.state = runQueueCleanUp
 
-        active = self.stats.active + self.sq_stats.active
+        active = self.stats.active + len(self.sq_live)
         if active > 0:
             bb.event.fire(runQueueExitWait(active), self.cfgData)
             self.rq.read_workers()
@@ -1853,7 +1852,7 @@ class RunQueueExecute:
         return valid
 
     def can_start_task(self):
-        active = self.stats.active + self.sq_stats.active
+        active = self.stats.active + len(self.sq_live)
         can_start = active < self.number_tasks
         return can_start
 
@@ -1956,7 +1955,7 @@ class RunQueueExecute:
         err = False
         if not self.sqdone:
             logger.debug('We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
-            completeevent = sceneQueueComplete(self.sq_stats, self.rq)
+            completeevent = sceneQueueComplete(self.stats, self.rq)
             bb.event.fire(completeevent, self.cfgData)
         if self.sq_deferred:
             logger.error("Scenequeue had deferred entries: %s" % pprint.pformat(self.sq_deferred))
@@ -2067,7 +2066,7 @@ class RunQueueExecute:
                 self.sq_task_failoutright(task)
                 return True
 
-            startevent = sceneQueueTaskStarted(task, self.sq_stats, self.rq)
+            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
             taskdepdata = self.sq_build_taskdepdata(task)
@@ -2088,7 +2087,6 @@ class RunQueueExecute:
             self.build_stamps2.append(self.build_stamps[task])
             self.sq_running.add(task)
             self.sq_live.add(task)
-            self.sq_stats.taskActive()
             if self.can_start_task():
                 return True
 
@@ -2178,7 +2176,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if self.stats.active > 0 or self.sq_stats.active > 0:
+        if self.stats.active > 0 or len(self.sq_live) > 0:
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -2520,13 +2518,11 @@ class RunQueueExecute:
                 self.rq.state = runQueueCleanUp
 
     def sq_task_complete(self, task):
-        self.sq_stats.taskCompleted()
-        bb.event.fire(sceneQueueTaskCompleted(task, self.sq_stats, self.rq), self.cfgData)
+        bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
         self.sq_task_completeoutright(task)
 
     def sq_task_fail(self, task, result):
-        self.sq_stats.taskFailed()
-        bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
+        bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
@@ -2534,8 +2530,6 @@ class RunQueueExecute:
     def sq_task_failoutright(self, task):
         self.sq_running.add(task)
         self.sq_buildable.add(task)
-        self.sq_stats.taskSkipped()
-        self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
@@ -2543,8 +2537,6 @@ class RunQueueExecute:
         self.sq_running.add(task)
         self.sq_buildable.add(task)
         self.sq_task_completeoutright(task)
-        self.sq_stats.taskSkipped()
-        self.sq_stats.taskCompleted()
 
     def sq_build_taskdepdata(self, task):
         def getsetscenedeps(tid):
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 48d808ae2..40c7c5a5e 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -49,7 +49,7 @@ class BBUIHelper:
             tid = event._fn + ":" + event._task
             removetid(event.pid, tid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
-        elif isinstance(event, bb.runqueue.runQueueTaskStarted):
+        elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
-- 
2.31.1

