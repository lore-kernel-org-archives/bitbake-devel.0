Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 649C97F03B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:41 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id v15so3917646wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=9Q0/wC2uyRDr0XWR8Tl2xn2iMuXD8jt66C2OehWv7q8=;
	b=Uea/r1noDFeMIx5Dc4uorGCZf+yYF1rRPPbKw0ypKuKTEdLNnIA/7JtmipWLEGXFds
	tQNenjoe+EB3dzEGPCgcOVbaciDOr70zVUgq97V8sEyLUCMyDWp8zLYUAJkNncmM4ofG
	VzIHNjW2vZ3iVKhmulf/8+aQNkSCSYi30hgpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=9Q0/wC2uyRDr0XWR8Tl2xn2iMuXD8jt66C2OehWv7q8=;
	b=J0BDSSxjXL1mcWINSXOf1gtVZwxn9vbEJduUdaDIuEAsm/s0Zajskv5+XDR6GfpYFd
	6trXtTk8o+R8S7UCV1BCTI+GjQBBBjibGmWuC0uW9846PbKOSsslfaEKO4SXaJ4gVka4
	q9DVi4qqaRSkwYcmtVBEfVfBsOlKQfvCyPJRFm5hX3PNpflymKXm/c7bQK4Rjd7DIptX
	+fKqD4SBu7EV6kb7dRzvjb//PMOjPRdJQaLHjQAxi4lBo1pnF4QfbN1uAYSjF0ADsWNp
	sXMdqkSHGLPRU2cjUgTsSJQ9/6TquD6oQaBv38/KCCNH3nysebyH1bFBQ2+KgrcckIvj
	PoJw==
X-Gm-Message-State: APjAAAXi8445hLJJLlY1ChkHhO3EQOH7TNR/l9K5SSNi23WHWP5M3hX1
	gw5S3jwGxY1M85mLQ/pcFFXCxM9Pypk=
X-Google-Smtp-Source: APXvYqz36YF5Be7jgu2CQhzRbuMpWkB5elLfwM3AHvW4ua0usFbK2g72jPRq1jhL0AkGsaEpsPLTDQ==
X-Received: by 2002:a05:600c:389:: with SMTP id
	w9mr259214wmd.139.1562802881812; 
	Wed, 10 Jul 2019 16:54:41 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:16 +0100
Message-Id: <20190710235420.23825-22-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 22/26] runqueue: Merge the queues and execute setscene and normal tasks in parallel
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:41 -0000
Content-Transfer-Encoding: 8bit

This is the serious functionality change in this runqueue patch series of
changes.

Rather than two phases of execution, the scenequeue setscene phase, followed
by normal task exeuction, this change allows them to execute in parallel
together.

To do this we need to handle marking of tasks as covered/uncovered in a piecemeal
fashion on a task by task basis rather than in a single function.

The code will block normal task exeuction until any setcene task which could
cover that task is executed and its status is known. There is a slight
optimisation which could be possible here at the risk of races but that
doesn't seem worthwhile.

The state engine isn't entirely cleaned up in this commit (see FIXME) and
the setscenewhitelist functionality is broken by it (see following patches)
however its good enough to test with normal workflows.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 176 +++++++++++++++++++++++++++++++--------------
 1 file changed, 123 insertions(+), 53 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 53cf4c5c82..e4994f6c52 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -142,7 +142,7 @@ class RunQueueScheduler(object):
         Return the id of the first task we find that is buildable
         """
         self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
-        buildable = self.buildable
+        buildable = [x for x in self.buildable if (x in self.rq.tasks_covered or x in self.rq.tasks_notcovered)]
         if not buildable:
             return None
 
@@ -1454,25 +1454,18 @@ class RunQueue:
 
             # If we don't have any setscene functions, skip execution
             if len(self.rqdata.runq_setscene_tids) == 0:
-                self.rqdata.init_progress_reporter.finish()
-                self.state = runQueueRunInit
-            else:
-                logger.info('Executing SetScene Tasks')
-                self.state = runQueueSceneRun
-
-        if self.state is runQueueSceneRun:
-            retval = self.rqexe.sq_execute()
-
-        if self.state is runQueueRunInit:
-            if self.cooker.configuration.setsceneonly:
-                self.state = runQueueComplete
-
-        if self.state is runQueueRunInit:
-            logger.info("Executing RunQueue Tasks")
-            start_runqueue_tasks(self.rqexe)
+                logger.info('No setscene tasks')
+                for tid in self.rqdata.runtaskentries:
+                    if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                        self.rqexe.setbuildable(tid)
+                    self.rqexe.tasks_notcovered.add(tid)
+                self.rqexe.sqdone = True
+            logger.info('Executing Tasks')
             self.state = runQueueRunning
 
         if self.state is runQueueRunning:
+            retval = self.rqexe.sq_execute()
+            # FIXME revtal
             retval = self.rqexe.execute()
 
         if self.state is runQueueCleanUp:
@@ -1757,6 +1750,8 @@ class RunQueueExecute:
 
         self.stampcache = {}
 
+        self.sqdone = False
+
         self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
         self.sq_stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
 
@@ -1772,12 +1767,12 @@ class RunQueueExecute:
         self.scenequeue_covered = set()
         # List of tasks which are covered (including setscene ones)
         self.tasks_covered = set()
+        self.tasks_scenequeue_done = set()
         self.scenequeue_notcovered = set()
+        self.tasks_notcovered = set()
         self.scenequeue_notneeded = set()
 
-        if len(self.rqdata.runq_setscene_tids) > 0:
-            self.sqdata = SQData()
-            build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+        self.coveredtopocess = set()
 
         schedulers = self.get_schedulers()
         for scheduler in schedulers:
@@ -1789,6 +1784,10 @@ class RunQueueExecute:
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedulers)))
 
+        if len(self.rqdata.runq_setscene_tids) > 0:
+            self.sqdata = SQData()
+            build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+
     def runqueue_process_waitpid(self, task, status):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
@@ -1951,6 +1950,9 @@ class RunQueueExecute:
             if process_setscenewhitelist(self.rq, self.rqdata, self.stampcache, self.sched, self):
                 return True
 
+        if self.cooker.configuration.setsceneonly:
+            return True
+
         self.rq.read_workers()
 
         if self.stats.total == 0:
@@ -2014,7 +2016,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if self.stats.active > 0:
+        if self.stats.active > 0 or self.sq_stats.active > 0:
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -2026,9 +2028,9 @@ class RunQueueExecute:
         for task in self.rqdata.runtaskentries:
             if task not in self.runq_buildable:
                 logger.error("Task %s never buildable!", task)
-            if task not in self.runq_running:
+            elif task not in self.runq_running:
                 logger.error("Task %s never ran!", task)
-            if task not in self.runq_complete:
+            elif task not in self.runq_complete:
                 logger.error("Task %s never completed!", task)
         self.rq.state = runQueueComplete
 
@@ -2070,6 +2072,84 @@ class RunQueueExecute:
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
+    def scenequeue_process_notcovered(self, task):
+            logger.debug(1, 'Not skipping setscene task %s', task)
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
+            taskname = taskname + '_setscene'
+            bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
+            if len(self.rqdata.runtaskentries[task].depends) == 0:
+                self.setbuildable(task)
+            notcovered = set([task])
+            while notcovered:
+                new = set()
+                for t in notcovered:
+                    for deptask in self.rqdata.runtaskentries[t].depends:
+                        if deptask in notcovered or deptask in new or deptask in self.rqdata.runq_setscene_tids or deptask in self.tasks_notcovered:
+                            continue
+                        logger.debug(1, 'Task %s depends on non-setscene task %s so not skipping' % (t, deptask))
+                        new.add(deptask)
+                        self.tasks_notcovered.add(deptask)
+                        if len(self.rqdata.runtaskentries[deptask].depends) == 0:
+                            self.setbuildable(deptask)
+                notcovered = new
+
+    def scenequeue_process_unskippable(self, task):
+            # Look up the dependency chain for non-setscene things which depend on this task
+            # and mark as 'done'/notcovered
+            ready = set([task])
+            while ready:
+                new = set()
+                for t in ready:
+                    for deptask in self.rqdata.runtaskentries[t].revdeps:
+                        if deptask in ready or deptask in new or deptask in self.tasks_scenequeue_done or deptask in self.rqdata.runq_setscene_tids:
+                            continue
+                        if self.rqdata.runtaskentries[deptask].depends.issubset(self.tasks_scenequeue_done):
+                            new.add(deptask)
+                            self.tasks_scenequeue_done.add(deptask)
+                            self.tasks_notcovered.add(deptask)
+                            #logger.warning("Up: " + str(deptask))
+                ready = new
+
+
+    def scenequeue_donetask(self, task):
+
+        next = set([task])
+        while next:
+            new = set()
+            for t in next:
+                self.tasks_scenequeue_done.add(t)
+                # Look down the dependency chain for non-setscene things which this task depends on
+                # and mark as 'done'
+                for dep in self.rqdata.runtaskentries[t].depends:
+                    if dep in self.rqdata.runq_setscene_tids or dep in self.tasks_scenequeue_done:
+                        continue
+                    if self.rqdata.runtaskentries[dep].revdeps.issubset(self.tasks_scenequeue_done):
+                        new.add(dep)
+                        #logger.warning(" Down: " + dep)
+            next = new
+
+        if task in self.sqdata.unskippable:
+            self.scenequeue_process_unskippable(task)
+
+        if task in self.scenequeue_notcovered:
+            self.scenequeue_process_notcovered(task)
+        elif task in self.scenequeue_covered:
+            logger.debug(1, 'Queued setscene task %s', task)
+            self.coveredtopocess.add(task)
+
+        for task in self.coveredtopocess.copy():
+            if self.sqdata.sq_covered_tasks[task].issubset(self.tasks_scenequeue_done):
+                logger.debug(1, 'Processing setscene task %s', task)
+                covered = self.sqdata.sq_covered_tasks[task]
+                covered.add(task)
+                # Remove notcovered tasks
+                covered.difference_update(self.tasks_notcovered)
+                self.tasks_covered.update(covered)
+                self.coveredtopocess.remove(task)
+                for tid in covered:
+                    if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                        self.setbuildable(tid)
+
     def scenequeue_updatecounters(self, task, fail = False):
         for dep in self.sqdata.sq_deps[task]:
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
@@ -2083,6 +2163,9 @@ class RunQueueExecute:
             if len(self.sqdata.sq_revdeps2[dep]) == 0:
                 self.sq_buildable.add(dep)
 
+        self.scenequeue_donetask(task)
+
+
     def sq_task_completeoutright(self, task):
         """
         Mark a task as completed
@@ -2113,6 +2196,7 @@ class RunQueueExecute:
         self.sq_stats.taskFailed()
         bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
+        self.tasks_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
 
@@ -2122,6 +2206,7 @@ class RunQueueExecute:
         self.sq_stats.taskSkipped()
         self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
+        self.tasks_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
     def sq_task_skip(self, task):
@@ -2136,6 +2221,9 @@ class RunQueueExecute:
         Run the tasks in a queue prepared by prepare_runqueue
         """
 
+        if self.sqdone:
+            return True
+
         self.rq.read_workers()
 
         task = None
@@ -2209,7 +2297,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if self.sq_stats.active > 0:
+        if self.stats.active > 0 or self.sq_stats.active > 0:
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -2221,11 +2309,14 @@ class RunQueueExecute:
 
         logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
-        self.rq.state = runQueueRunInit
-
         completeevent = sceneQueueComplete(self.sq_stats, self.rq)
         bb.event.fire(completeevent, self.cfgData)
 
+        if self.cooker.configuration.setsceneonly:
+            self.rq.state = runQueueComplete
+
+        self.sqdone = True
+
         return True
 
     def sq_build_taskdepdata(self, task):
@@ -2353,6 +2444,12 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             if tid in rqdata.runq_setscene_tids:
                 continue
             sqdata.unskippable.remove(tid)
+            if len(rqdata.runtaskentries[tid].depends) == 0:
+                # These are tasks which have no setscene tasks in their chain, need to mark as directly buildable
+                sqrq.tasks_notcovered.add(tid)
+                sqrq.tasks_scenequeue_done.add(tid)
+                sqrq.setbuildable(tid)
+                sqrq.scenequeue_process_unskippable(tid)
             sqdata.unskippable |= rqdata.runtaskentries[tid].depends
             new = True
 
@@ -2488,33 +2585,6 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 logger.debug(2, 'No package found, so skipping setscene task %s', tid)
                 sqdata.outrightfail.append(tid)
 
-def start_runqueue_tasks(rqexec):
-        # Mark initial buildable tasks
-        for tid in rqexec.rqdata.runtaskentries:
-            if len(rqexec.rqdata.runtaskentries[tid].depends) == 0:
-                rqexec.setbuildable(tid)
-            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.tasks_covered):
-                rqexec.tasks_covered.add(tid)
-
-        found = True
-        while found:
-            found = False
-            for tid in rqexec.rqdata.runtaskentries:
-                if tid in rqexec.tasks_covered:
-                    continue
-                logger.debug(1, 'Considering %s: %s' % (tid, str(rqexec.rqdata.runtaskentries[tid].revdeps)))
-
-                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.tasks_covered):
-                    if tid in rqexec.scenequeue_notcovered:
-                        continue
-                    found = True
-                    rqexec.tasks_covered.add(tid)
-
-        logger.debug(1, 'Skip list %s', sorted(rqexec.tasks_covered))
-
-        for task in self.rq.scenequeue_notcovered:
-            logger.debug(1, 'Not skipping task %s', task)
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
-- 
2.20.1


