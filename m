Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 2DD2A6D959
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:12:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPNBmIx026218 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:12:37 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m5fRKnj-8Sa6 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:12:36 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPNCUi2026238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:12:31 GMT
Message-ID: <1385421147.24083.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 23:12:27 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Optimise next_buildable_task()
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
X-List-Received-Date: Mon, 25 Nov 2013 23:12:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This unlikely looking function was found to be eating a lot of CPU time
since it gets called once per trip through the idle loop if we're not
running a maximum number of processes. This was particularly true in
world builds of 13,000 tasks.

Calling the computation code is pretty pointless because until some
other task finishes nothing is going to become available to build.
We can know when things become available so this patch teaches the
scheduler this knowledge.

It also:

* skips any coputation when nothing can be built
* if there is only one available item to build, ignore the priority map
* precomputes the stamp filenames, rather than doing it every time
* saves the length of the array rather than calculating it each time
  (the extra function overhead is significant)

Timing wise, initially, 5000 iterations through here was 20s, with
the patch 200000 calls takes the same time. The end result is that
builds get up and running faster.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a320a64..f984119 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -98,26 +98,49 @@ class RunQueueScheduler(object):
         """
         self.rq = runqueue
         self.rqdata = rqdata
-        numTasks = len(self.rqdata.runq_fnid)
+        self.numTasks = len(self.rqdata.runq_fnid)
 
         self.prio_map = []
-        self.prio_map.extend(range(numTasks))
+        self.prio_map.extend(range(self.numTasks))
+
+        self.buildable = []
+        self.stamps = {}
+        for taskid in xrange(self.numTasks):
+            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
+            taskname = self.rqdata.runq_task[taskid]
+            self.stamps[taskid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            if self.rq.runq_buildable[taskid] == 1:
+                self.buildable.append(taskid)
+
+        self.rev_prio_map = None
 
     def next_buildable_task(self):
         """
         Return the id of the first task we find that is buildable
         """
-        for tasknum in xrange(len(self.rqdata.runq_fnid)):
-            taskid = self.prio_map[tasknum]
-            if self.rq.runq_running[taskid] == 1:
-                continue
-            if self.rq.runq_buildable[taskid] == 1:
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
-                taskname = self.rqdata.runq_task[taskid]
-                stamp = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-                if stamp in self.rq.build_stamps.values():
+        self.buildable = [x for x in self.buildable if not self.rq.runq_running[x] == 1]
+        if not self.buildable:
+            return None
+        if len(self.buildable) == 1:
+            return self.buildable[0]
+
+        if not self.rev_prio_map:
+            self.rev_prio_map = range(self.numTasks)
+            for taskid in xrange(self.numTasks):
+                self.rev_prio_map[self.prio_map[taskid]] = taskid
+
+        best = None
+        bestprio = None
+        for taskid in self.buildable:
+            prio = self.rev_prio_map[taskid]
+            if not bestprio or bestprio > prio:
+                stamp = self.stamps[taskid]
+                if stamp in self.rq.build_stamps.itervalues():
                     continue
-                return taskid
+                bestprio = prio
+                best = taskid
+
+        return best
 
     def next(self):
         """
@@ -126,6 +149,9 @@ class RunQueueScheduler(object):
         if self.rq.stats.active < self.rq.number_tasks:
             return self.next_buildable_task()
 
+    def newbuilable(self, task):
+        self.buildable.append(task)
+
 class RunQueueSchedulerSpeed(RunQueueScheduler):
     """
     A scheduler optimised for speed. The priority map is sorted by task weight,
@@ -137,9 +163,7 @@ class RunQueueSchedulerSpeed(RunQueueScheduler):
         """
         The priority map is sorted by task weight.
         """
-
-        self.rq = runqueue
-        self.rqdata = rqdata
+        RunQueueScheduler.__init__(self, runqueue, rqdata)
 
         sortweight = sorted(copy.deepcopy(self.rqdata.runq_weight))
         copyweight = copy.deepcopy(self.rqdata.runq_weight)
@@ -1116,6 +1140,7 @@ class RunQueueExecute:
         self.runq_complete = []
 
         self.build_stamps = {}
+        self.build_stamps2 = []
         self.failed_fnids = []
 
         self.stampcache = {}
@@ -1128,6 +1153,7 @@ class RunQueueExecute:
 
         # self.build_stamps[pid] may not exist when use shared work directory.
         if task in self.build_stamps:
+            self.build_stamps2.remove(self.build_stamps[task])
             del self.build_stamps[task]
 
         if status != 0:
@@ -1317,6 +1343,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     schedulers.add(getattr(module, name))
         return schedulers
 
+    def setbuildable(self, task):
+        self.runq_buildable[task] = 1
+        self.sched.newbuilable(task)
+
     def task_completeoutright(self, task):
         """
         Mark a task as completed
@@ -1334,7 +1364,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 if self.runq_complete[dep] != 1:
                     alldeps = 0
             if alldeps == 1:
-                self.runq_buildable[revdep] = 1
+                self.setbuildable(revdep)
                 fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[revdep]]
                 taskname = self.rqdata.runq_task[revdep]
                 logger.debug(1, "Marking task %s (%s, %s) as buildable", revdep, fn, taskname)
@@ -1358,7 +1388,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
     def task_skip(self, task, reason):
         self.runq_running[task] = 1
-        self.runq_buildable[task] = 1
+        self.setbuildable(task)
         bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, reason), self.cfgData)
         self.task_completeoutright(task)
         self.stats.taskCompleted()
@@ -1418,6 +1448,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            self.build_stamps2.append(self.build_stamps[task]) 
             self.runq_running[task] = 1
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:



