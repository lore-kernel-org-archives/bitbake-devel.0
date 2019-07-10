Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail.openembedded.org (Postfix) with ESMTP id 58E197F005
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:27 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id s3so3904167wms.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=dOjPsRx82Q1CqI6vUh/RwU7gbOBSbqfnPWLRtSJ2dA4=;
	b=fFfrxVmy29VFD9IZs4KQZ+REr0MP81EtO33TrSu7bsqcMrUKMlsH6rtKv+JSEnwWQz
	LBHVJlPdipZs/J7BiKw7FYbfvcnIDH9GxZiV5m/8um+w4wbRQXArDHo8+Rlv1RzNAuW8
	nfhx0EsRU/IDQf6rb9Pfcoh+nxvP8Qj9+Yhds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dOjPsRx82Q1CqI6vUh/RwU7gbOBSbqfnPWLRtSJ2dA4=;
	b=VMMXAcwM1cYz3HE8/IqEWDOTsi5jhkyHrJIpTF9jXfkWzpOt0UFaeZQ7O0fHXLDopf
	hp56pjDVSSj03LJfncKaUU7Ras3wVxCLyZoJlvehhWmHJryL1Isj7AIrLwLrQM0Q0S0E
	VxzxGzQ88q9kJhy4mUwNf82/4UBJnNR6Lwr4HuHp3n+cwowtfK/GIZnTnNs7W0l3X897
	iNddgEzUs7qFo0hyhiAD2nl7/ZclZefaTn1HLkfrwNNlY1WeoPspzHTesKZaYIi1tK88
	aZ41A1HwiMdyRW0XKcJP75fjFisMbfXIZC9OoJ+m1ERj7y41Zvq4jMGjMMoFoGjYH3eU
	lwow==
X-Gm-Message-State: APjAAAUJsowDg4r2px5am8ijQCbZkdY5chNDIFD2dmphcqMyke8rBfEt
	xLFhC24gqYbqpmOSCnf4uolWxd3ng/g=
X-Google-Smtp-Source: APXvYqzGgsE7hCh1KfHHxQY0J5tUiTHSmLqV34jWeFGOVoLwrcD49n3PhUL9GBWoTQEr3j21TQY8WA==
X-Received: by 2002:a1c:3883:: with SMTP id f125mr287416wma.18.1562802867865; 
	Wed, 10 Jul 2019 16:54:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:01 +0100
Message-Id: <20190710235420.23825-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 07/26] runqueue: Uniquely namespace the scenequeue functions
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:29 -0000
Content-Transfer-Encoding: 8bit

In preparation for merging the setscene and normal task execution,
uniquely namespace the scenequeue specific functions.

For the one shared function, add the "sq_live" variable so we know
which functions to send the results to.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 86 +++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b8b35ecabe..c512920a6d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1452,7 +1452,7 @@ class RunQueue:
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state is runQueueSceneRun:
-            retval = self.rqexe.execute()
+            retval = self.rqexe.sq_execute()
 
         if self.state is runQueueRunInit:
             if self.cooker.configuration.setsceneonly:
@@ -1734,6 +1734,10 @@ class RunQueueExecute:
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
 
+        self.sq_buildable = set()
+        self.sq_running = set()
+        self.sq_live = set()
+
         self.runq_buildable = set()
         self.runq_running = set()
         self.runq_complete = set()
@@ -1759,10 +1763,17 @@ class RunQueueExecute:
             self.build_stamps2.remove(self.build_stamps[task])
             del self.build_stamps[task]
 
-        if status != 0:
-            self.task_fail(task, status)
+        if task in self.sq_live:
+            if status != 0:
+                self.sq_task_fail(task, status)
+            else:
+                self.sq_task_complete(task)
+            self.sq_live.remove(task)
         else:
-            self.task_complete(task)
+            if status != 0:
+                self.task_fail(task, status)
+            else:
+                self.task_complete(task)
         return True
 
     def finish_now(self):
@@ -2260,7 +2271,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     for tid in sqdata.sq_revdeps:
         if len(sqdata.sq_revdeps[tid]) == 0:
-            sqrq.runq_buildable.add(tid)
+            sqrq.sq_buildable.add(tid)
 
     rqdata.init_progress_reporter.finish()
 
@@ -2281,20 +2292,20 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
                 noexec.append(tid)
-                sqrq.task_skip(tid)
+                sqrq.sq_task_skip(tid)
                 bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
                 continue
 
             if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
                 logger.debug(2, 'Setscene stamp current for task %s', tid)
                 stamppresent.append(tid)
-                sqrq.task_skip(tid)
+                sqrq.sq_task_skip(tid)
                 continue
 
             if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
                 logger.debug(2, 'Normal stamp current for task %s', tid)
                 stamppresent.append(tid)
-                sqrq.task_skip(tid)
+                sqrq.sq_task_skip(tid)
                 continue
 
             sq_fn.append(fn)
@@ -2356,9 +2367,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 continue
             self.sqdata.sq_revdeps2[dep].remove(task)
             if len(self.sqdata.sq_revdeps2[dep]) == 0:
-                self.runq_buildable.add(dep)
+                self.sq_buildable.add(dep)
 
-    def task_completeoutright(self, task):
+    def sq_task_completeoutright(self, task):
         """
         Mark a task as completed
         Look at the reverse dependencies and mark any task with
@@ -2369,7 +2380,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_covered.add(task)
         self.scenequeue_updatecounters(task)
 
-    def check_taskfail(self, task):
+    def sq_check_taskfail(self, task):
         if self.rqdata.setscenewhitelist is not None:
             realtask = task.split('_setscene')[0]
             (mc, fn, taskname, taskfn) = split_tid_mcfn(realtask)
@@ -2378,34 +2389,34 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
                 self.rq.state = runQueueCleanUp
 
-    def task_complete(self, task):
+    def sq_task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
-        self.task_completeoutright(task)
+        self.sq_task_completeoutright(task)
 
-    def task_fail(self, task, result):
+    def sq_task_fail(self, task, result):
         self.stats.taskFailed()
         bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
-        self.check_taskfail(task)
+        self.sq_check_taskfail(task)
 
-    def task_failoutright(self, task):
-        self.runq_running.add(task)
-        self.runq_buildable.add(task)
+    def sq_task_failoutright(self, task):
+        self.sq_running.add(task)
+        self.sq_buildable.add(task)
         self.stats.taskSkipped()
         self.stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
-    def task_skip(self, task):
-        self.runq_running.add(task)
-        self.runq_buildable.add(task)
-        self.task_completeoutright(task)
+    def sq_task_skip(self, task):
+        self.sq_running.add(task)
+        self.sq_buildable.add(task)
+        self.sq_task_completeoutright(task)
         self.stats.taskSkipped()
         self.stats.taskCompleted()
 
-    def execute(self):
+    def sq_execute(self):
         """
         Run the tasks in a queue prepared by prepare_runqueue
         """
@@ -2416,7 +2427,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.can_start_task():
             # Find the next setscene to run
             for nexttask in self.rqdata.runq_setscene_tids:
-                if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
+                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask in self.sqdata.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
@@ -2427,11 +2438,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                             foundtarget = True
                         if not foundtarget:
                             logger.debug(2, "Skipping setscene for task %s" % nexttask)
-                            self.task_skip(nexttask)
+                            self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
                     if nexttask in self.sqdata.outrightfail:
-                        self.task_failoutright(nexttask)
+                        self.sq_task_failoutright(nexttask)
                         return True
                     task = nexttask
                     break
@@ -2440,28 +2451,28 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             taskname = taskname + "_setscene"
             if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
                 logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
-                self.task_failoutright(task)
+                self.sq_task_failoutright(task)
                 return True
 
             if self.cooker.configuration.force:
                 if task in self.rqdata.target_tids:
-                    self.task_failoutright(task)
+                    self.sq_task_failoutright(task)
                     return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
                 logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
-                self.task_skip(task)
+                self.sq_task_skip(task)
                 return True
 
             if self.cooker.configuration.skipsetscene:
                 logger.debug(2, 'No setscene tasks should be executed. Skipping %s', task)
-                self.task_failoutright(task)
+                self.sq_task_failoutright(task)
                 return True
 
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            taskdepdata = self.build_taskdepdata(task)
+            taskdepdata = self.sq_build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
@@ -2477,7 +2488,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
             self.build_stamps2.append(self.build_stamps[task])
-            self.runq_running.add(task)
+            self.sq_running.add(task)
+            self.sq_live.add(task)
             self.stats.taskActive()
             if self.can_start_task():
                 return True
@@ -2487,8 +2499,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             return self.rq.active_fds()
 
         #for tid in self.sqdata.sq_revdeps:
-        #    if tid not in self.runq_running:
-        #        buildable = tid in self.runq_buildable
+        #    if tid not in self.sq_running:
+        #        buildable = tid in self.sq_buildable
         #        revdeps = self.sqdata.sq_revdeps[tid]
         #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
 
@@ -2504,11 +2516,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         return True
 
-    def runqueue_process_waitpid(self, task, status):
-        RunQueueExecute.runqueue_process_waitpid(self, task, status)
-
-
-    def build_taskdepdata(self, task):
+    def sq_build_taskdepdata(self, task):
         def getsetscenedeps(tid):
             deps = set()
             (mc, fn, taskname, _) = split_tid_mcfn(tid)
-- 
2.20.1


