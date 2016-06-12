Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 31A6D6014F
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 22:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5CMtD48016071 for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:13 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27FI5Bp0X6Lf for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:13 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5CMt8lu016066
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:10 +0100
Message-ID: <1465772108.13979.191.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 12 Jun 2016 23:55:08 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Change buildable/running lists to sets
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
X-List-Received-Date: Sun, 12 Jun 2016 22:55:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Using positions in lists for flags is an odd choice and makes the code
hard to maintain. Maintaining a list is slow since list searches are 
slow (watch bitbake -n slow massively with it) but we can use a set() 
instead.

This patch uses python sets to maintain the lists of tasks in each state
and this prepares for changing the task IDs from being integers.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 38e77e5..e55b0c4 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -108,7 +108,7 @@ class RunQueueScheduler(object):
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
             taskname = self.rqdata.runq_task[taskid]
             self.stamps[taskid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-            if self.rq.runq_buildable[taskid] == 1:
+            if taskid in self.rq.runq_buildable:
                 self.buildable.append(taskid)
 
         self.rev_prio_map = None
@@ -117,7 +117,7 @@ class RunQueueScheduler(object):
         """
         Return the id of the first task we find that is buildable
         """
-        self.buildable = [x for x in self.buildable if not self.rq.runq_running[x] == 1]
+        self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
         if not self.buildable:
             return None
         if len(self.buildable) == 1:
@@ -1361,9 +1361,9 @@ class RunQueueExecute:
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS", True) or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER", True) or "speed"
 
-        self.runq_buildable = []
-        self.runq_running = []
-        self.runq_complete = []
+        self.runq_buildable = set()
+        self.runq_running = set()
+        self.runq_complete = set()
 
         self.build_stamps = {}
         self.build_stamps2 = []
@@ -1464,12 +1464,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         # Mark initial buildable tasks
         for task in range(self.stats.total):
-            self.runq_running.append(0)
-            self.runq_complete.append(0)
             if len(self.rqdata.runq_depends[task]) == 0:
-                self.runq_buildable.append(1)
-            else:
-                self.runq_buildable.append(0)
+                self.runq_buildable.add(task)
             if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
                 self.rq.scenequeue_covered.add(task)
 
@@ -1574,7 +1570,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         return schedulers
 
     def setbuildable(self, task):
-        self.runq_buildable[task] = 1
+        self.runq_buildable.add(task)
         self.sched.newbuilable(task)
 
     def task_completeoutright(self, task):
@@ -1583,15 +1579,15 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Look at the reverse dependencies and mark any task with
         completed dependencies as buildable
         """
-        self.runq_complete[task] = 1
+        self.runq_complete.add(task)
         for revdep in self.rqdata.runq_revdeps[task]:
-            if self.runq_running[revdep] == 1:
+            if revdep in self.runq_running:
                 continue
-            if self.runq_buildable[revdep] == 1:
+            if revdep in self.runq_buildable:
                 continue
             alldeps = 1
             for dep in self.rqdata.runq_depends[revdep]:
-                if self.runq_complete[dep] != 1:
+                if dep not in self.runq_complete:
                     alldeps = 0
             if alldeps == 1:
                 self.setbuildable(revdep)
@@ -1617,7 +1613,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             self.rq.state = runQueueCleanUp
 
     def task_skip(self, task, reason):
-        self.runq_running[task] = 1
+        self.runq_running.add(task)
         self.setbuildable(task)
         bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, reason), self.cfgData)
         self.task_completeoutright(task)
@@ -1658,7 +1654,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent = runQueueTaskStarted(task, self.stats, self.rq,
                                                  noexec=True)
                 bb.event.fire(startevent, self.cfgData)
-                self.runq_running[task] = 1
+                self.runq_running.add(task)
                 self.stats.taskActive()
                 if not self.cooker.configuration.dry_run:
                     bb.build.make_stamp(taskname, self.rqdata.dataCache, fn)
@@ -1687,7 +1683,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
             self.build_stamps2.append(self.build_stamps[task]) 
-            self.runq_running[task] = 1
+            self.runq_running.add(task)
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
@@ -1702,11 +1698,11 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         # Sanity Checks
         for task in range(self.stats.total):
-            if self.runq_buildable[task] == 0:
+            if task not in self.runq_buildable:
                 logger.error("Task %s never buildable!", task)
-            if self.runq_running[task] == 0:
+            if task not in self.runq_running:
                 logger.error("Task %s never ran!", task)
-            if self.runq_complete[task] == 0:
+            if task not in self.runq_complete:
                 logger.error("Task %s never completed!", task)
         self.rq.state = runQueueComplete
 
@@ -1759,11 +1755,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # therefore aims to collapse the huge runqueue dependency tree into a smaller one
         # only containing the setscene functions.
 
-        for task in range(self.stats.total):
-            self.runq_running.append(0)
-            self.runq_complete.append(0)
-            self.runq_buildable.append(0)
-
         # Build a lits of non-setscene task endpoints
         # Also populate sq_revdeps{,_new}
         endpoints = {}
@@ -1918,7 +1909,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         for task in range(len(self.sq_revdeps)):
             if len(self.sq_revdeps[task]) == 0:
-                self.runq_buildable[task] = 1
+                self.runq_buildable.add(task)
 
         self.outrightfail = []
         if self.rq.hashvalidate:
@@ -1990,7 +1981,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 continue
             self.sq_revdeps2[dep].remove(task)
             if len(self.sq_revdeps2[dep]) == 0:
-                self.runq_buildable[dep] = 1
+                self.runq_buildable.add(dep)
 
     def task_completeoutright(self, task):
         """
@@ -2018,8 +2009,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_updatecounters(task, True)
 
     def task_failoutright(self, task):
-        self.runq_running[task] = 1
-        self.runq_buildable[task] = 1
+        self.runq_running.add(task)
+        self.runq_buildable.add(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
         index = self.rqdata.runq_setscene[task]
@@ -2027,8 +2018,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_updatecounters(task, True)
 
     def task_skip(self, task):
-        self.runq_running[task] = 1
-        self.runq_buildable[task] = 1
+        self.runq_running.add(task)
+        self.runq_buildable.add(task)
         self.task_completeoutright(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
@@ -2044,7 +2035,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
             for nexttask in range(self.stats.total):
-                if self.runq_buildable[nexttask] == 1 and self.runq_running[nexttask] != 1:
+                if nexttask in self.runq_buildable and nexttask not in self.runq_running:
                     if nexttask in self.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))                      
                     if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
@@ -2101,7 +2092,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
                 self.rq.worker.stdin.flush()
 
-            self.runq_running[task] = 1
+            self.runq_running.add(task)
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
                 return True
@@ -2111,8 +2102,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             return self.rq.active_fds()
 
         #for task in range(self.stats.total):
-        #    if self.runq_running[task] != 1:
-        #        buildable = self.runq_buildable[task]
+        #    if task not in self.runq_running:
+        #        buildable = task in self.runq_buildable
         #        revdeps = self.sq_revdeps[task]
         #        bb.warn("Found we didn't run %s %s %s %s" % (task, buildable, str(revdeps), self.rqdata.get_user_idstring(self.rqdata.runq_setscene[task])))
 



