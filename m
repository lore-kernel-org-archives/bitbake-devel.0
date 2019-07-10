Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id 6BB567F005
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:30 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id v15so3917418wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=anLRAJeLBUwI4ZjLL2pFQiuUKEOvbYIZ27+QxWCffB8=;
	b=LEOTqAGIDxItc4dnIuqVFbeNru1on9xl5EYq7y45u7TO11CRXBGUY/Wl12YeQl5s1I
	dLo4C+6SjrOmoGNcA/p4Grwku+2gGitLixt9ZHpaQowIKdbKtdJs5MPaa144Ie1Jp1oa
	27IJaccRP7KKdPDlEARmzVMJZXl3VJ0nvLJBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=anLRAJeLBUwI4ZjLL2pFQiuUKEOvbYIZ27+QxWCffB8=;
	b=S1/wCRTSS9Pnj3TABILuTCPHV+amE9zhhBYYlZ+uqghoLvKNhCgEUR/q2eT3Lkbc9K
	oTOnIwfa/Uvnq8JibNtlAv/TAWVbIY2TA0CcI4bDn51cPmb6OM88dPifMdKKathls4Qs
	4ZHHKzjM8rvm9KuA90TkzZ6b/zX+T4ptPiVTDKE5sUFToBoCwg9Ix7hU5B2LMrkeip/w
	oVkMPOwXzQFE3UPLABQiPcdtTvMZupaAUuupjWpFMdUDH5TntZAUIrM2egVuWkObbbpK
	rt2iW8Ay8DC6sY75o5V/mvdJ9cowEpbuKhi5zU60k2QTonIeRqqJCp5gr7VFcW4SZSS7
	J2gw==
X-Gm-Message-State: APjAAAW/7nTwYfpiAzkn8XfbEgvqRMRvNr3mJg6Ge8DZy8yw8mRx6mA1
	/O/5T8D1V/7EcqAHiUGZCWx+uKqM0ds=
X-Google-Smtp-Source: APXvYqw4zJlld3EPeuDdKjM9wUC7RQovZ6kfJQtYQRG0GqYejjaxcG5mxvNnoDN1sHkY5HZLVuEI2g==
X-Received: by 2002:a7b:cb51:: with SMTP id v17mr294233wmj.20.1562802870407;
	Wed, 10 Jul 2019 16:54:30 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:29 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:03 +0100
Message-Id: <20190710235420.23825-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 09/26] runqueue: Merge scenequeue and real task queue code together
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:31 -0000
Content-Transfer-Encoding: 8bit

Merge the unique functions from the Tasks and Scenequeue Tasks classes
into the common base class.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 720 ++++++++++++++++++++++-----------------------
 1 file changed, 360 insertions(+), 360 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7de27ec315..9ec2f7d2d4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1839,66 +1839,6 @@ class RunQueueExecute:
         can_start = active < self.number_tasks
         return can_start
 
-class RunQueueExecuteDummy(RunQueueExecute):
-    def __init__(self, rq):
-        self.rq = rq
-        self.stats = RunQueueStats(0)
-
-    def finish(self):
-        self.rq.state = runQueueComplete
-        return
-
-class RunQueueExecuteTasks(RunQueueExecute):
-    def __init__(self, rq):
-        RunQueueExecute.__init__(self, rq)
-
-        self.stampcache = {}
-
-        # Mark initial buildable tasks
-        for tid in self.rqdata.runtaskentries:
-            if len(self.rqdata.runtaskentries[tid].depends) == 0:
-                self.runq_buildable.add(tid)
-            if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
-                self.rq.scenequeue_covered.add(tid)
-
-        found = True
-        while found:
-            found = False
-            for tid in self.rqdata.runtaskentries:
-                if tid in self.rq.scenequeue_covered:
-                    continue
-                logger.debug(1, 'Considering %s: %s' % (tid, str(self.rqdata.runtaskentries[tid].revdeps)))
-
-                if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
-                    if tid in self.rq.scenequeue_notcovered:
-                        continue
-                    found = True
-                    self.rq.scenequeue_covered.add(tid)
-
-        logger.debug(1, 'Skip list %s', sorted(self.rq.scenequeue_covered))
-
-        for task in self.rq.scenequeue_notcovered:
-            logger.debug(1, 'Not skipping task %s', task)
-
-        for mc in self.rqdata.dataCaches:
-            target_pairs = []
-            for tid in self.rqdata.target_tids:
-                (tidmc, fn, taskname, _) = split_tid_mcfn(tid)
-                if tidmc == mc:
-                    target_pairs.append((fn, taskname))
-
-            event.fire(bb.event.StampUpdate(target_pairs, self.rqdata.dataCaches[mc].stamp), self.cfgData)
-
-        schedulers = self.get_schedulers()
-        for scheduler in schedulers:
-            if self.scheduler == scheduler.name:
-                self.sched = scheduler(self, self.rqdata)
-                logger.debug(1, "Using runqueue scheduler '%s'", scheduler.name)
-                break
-        else:
-            bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
-                     (self.scheduler, ", ".join(obj.name for obj in schedulers)))
-
     def get_schedulers(self):
         schedulers = set(obj for obj in globals().values()
                              if type(obj) is type and
@@ -2100,122 +2040,320 @@ class RunQueueExecuteTasks(RunQueueExecute):
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
-class SQData(object):
-    def __init__(self):
-        self.sq_harddeps = {}
-        self.stamps = {}
-        self.unskippable = []
+    def scenequeue_updatecounters(self, task, fail = False):
+        for dep in self.sqdata.sq_deps[task]:
+            if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
+                self.scenequeue_updatecounters(dep, fail)
+                continue
+            if task not in self.sqdata.sq_revdeps2[dep]:
+                # May already have been removed by the fail case above
+                continue
+            self.sqdata.sq_revdeps2[dep].remove(task)
+            if len(self.sqdata.sq_revdeps2[dep]) == 0:
+                self.sq_buildable.add(dep)
 
-def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
+    def sq_task_completeoutright(self, task):
+        """
+        Mark a task as completed
+        Look at the reverse dependencies and mark any task with
+        completed dependencies as buildable
+        """
 
-    sq_revdeps = {}
-    sq_revdeps_new = {}
-    sq_revdeps_squash = {}
+        logger.debug(1, 'Found task %s which could be accelerated', task)
+        self.scenequeue_covered.add(task)
+        self.scenequeue_updatecounters(task)
 
-    # We need to construct a dependency graph for the setscene functions. Intermediate
-    # dependencies between the setscene tasks only complicate the code. This code
-    # therefore aims to collapse the huge runqueue dependency tree into a smaller one
-    # only containing the setscene functions.
+    def sq_check_taskfail(self, task):
+        if self.rqdata.setscenewhitelist is not None:
+            realtask = task.split('_setscene')[0]
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(realtask)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
+            if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+                logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
+                self.rq.state = runQueueCleanUp
 
-    rqdata.init_progress_reporter.next_stage()
+    def sq_task_complete(self, task):
+        self.sq_stats.taskCompleted()
+        bb.event.fire(sceneQueueTaskCompleted(task, self.sq_stats, self.rq), self.cfgData)
+        self.sq_task_completeoutright(task)
 
-    # First process the chains up to the first setscene task.
-    endpoints = {}
-    for tid in rqdata.runtaskentries:
-        sq_revdeps[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
-        sq_revdeps_new[tid] = set()
-        if (len(sq_revdeps[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
-            #bb.warn("Added endpoint %s" % (tid))
-            endpoints[tid] = set()
+    def sq_task_fail(self, task, result):
+        self.sq_stats.taskFailed()
+        bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
+        self.scenequeue_notcovered.add(task)
+        self.scenequeue_updatecounters(task, True)
+        self.sq_check_taskfail(task)
 
-    rqdata.init_progress_reporter.next_stage()
+    def sq_task_failoutright(self, task):
+        self.sq_running.add(task)
+        self.sq_buildable.add(task)
+        self.sq_stats.taskSkipped()
+        self.sq_stats.taskCompleted()
+        self.scenequeue_notcovered.add(task)
+        self.scenequeue_updatecounters(task, True)
 
-    # Secondly process the chains between setscene tasks.
-    for tid in rqdata.runq_setscene_tids:
-        #bb.warn("Added endpoint 2 %s" % (tid))
-        for dep in rqdata.runtaskentries[tid].depends:
-                if tid in sq_revdeps[dep]:
-                    sq_revdeps[dep].remove(tid)
-                if dep not in endpoints:
-                    endpoints[dep] = set()
-                #bb.warn("  Added endpoint 3 %s" % (dep))
-                endpoints[dep].add(tid)
+    def sq_task_skip(self, task):
+        self.sq_running.add(task)
+        self.sq_buildable.add(task)
+        self.sq_task_completeoutright(task)
+        self.sq_stats.taskSkipped()
+        self.sq_stats.taskCompleted()
 
-    rqdata.init_progress_reporter.next_stage()
+    def sq_execute(self):
+        """
+        Run the tasks in a queue prepared by prepare_runqueue
+        """
 
-    def process_endpoints(endpoints):
-        newendpoints = {}
-        for point, task in endpoints.items():
-            tasks = set()
-            if task:
-                tasks |= task
-            if sq_revdeps_new[point]:
-                tasks |= sq_revdeps_new[point]
-            sq_revdeps_new[point] = set()
-            if point in rqdata.runq_setscene_tids:
-                sq_revdeps_new[point] = tasks
-                tasks = set()
-                continue
-            for dep in rqdata.runtaskentries[point].depends:
-                if point in sq_revdeps[dep]:
-                    sq_revdeps[dep].remove(point)
-                if tasks:
-                    sq_revdeps_new[dep] |= tasks
-                if len(sq_revdeps[dep]) == 0 and dep not in rqdata.runq_setscene_tids:
-                    newendpoints[dep] = task
-        if len(newendpoints) != 0:
-            process_endpoints(newendpoints)
+        self.rq.read_workers()
 
-    process_endpoints(endpoints)
+        task = None
+        if self.can_start_task():
+            # Find the next setscene to run
+            for nexttask in self.rqdata.runq_setscene_tids:
+                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
+                    if nexttask in self.sqdata.unskippable:
+                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
+                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
+                        fn = fn_from_tid(nexttask)
+                        foundtarget = False
 
-    rqdata.init_progress_reporter.next_stage()
+                        if nexttask in self.rqdata.target_tids:
+                            foundtarget = True
+                        if not foundtarget:
+                            logger.debug(2, "Skipping setscene for task %s" % nexttask)
+                            self.sq_task_skip(nexttask)
+                            self.scenequeue_notneeded.add(nexttask)
+                            return True
+                    if nexttask in self.sqdata.outrightfail:
+                        self.sq_task_failoutright(nexttask)
+                        return True
+                    task = nexttask
+                    break
+        if task is not None:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
+            taskname = taskname + "_setscene"
+            if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
+                logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
+                self.sq_task_failoutright(task)
+                return True
 
-    # Build a list of setscene tasks which are "unskippable"
-    # These are direct endpoints referenced by the build
-    endpoints2 = {}
-    sq_revdeps2 = {}
-    sq_revdeps_new2 = {}
-    def process_endpoints2(endpoints):
-        newendpoints = {}
-        for point, task in endpoints.items():
-            tasks = set([point])
-            if task:
-                tasks |= task
-            if sq_revdeps_new2[point]:
-                tasks |= sq_revdeps_new2[point]
-            sq_revdeps_new2[point] = set()
-            if point in rqdata.runq_setscene_tids:
-                sq_revdeps_new2[point] = tasks
-            for dep in rqdata.runtaskentries[point].depends:
-                if point in sq_revdeps2[dep]:
-                    sq_revdeps2[dep].remove(point)
-                if tasks:
-                    sq_revdeps_new2[dep] |= tasks
-                if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in rqdata.runq_setscene_tids:
-                    newendpoints[dep] = tasks
-        if len(newendpoints) != 0:
-            process_endpoints2(newendpoints)
-    for tid in rqdata.runtaskentries:
-        sq_revdeps2[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
-        sq_revdeps_new2[tid] = set()
-        if (len(sq_revdeps2[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
-            endpoints2[tid] = set()
-    process_endpoints2(endpoints2)
-    for tid in rqdata.runq_setscene_tids:
-        if sq_revdeps_new2[tid]:
-            sqdata.unskippable.append(tid)
+            if self.cooker.configuration.force:
+                if task in self.rqdata.target_tids:
+                    self.sq_task_failoutright(task)
+                    return True
 
-    rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
+            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
+                logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
+                self.sq_task_skip(task)
+                return True
 
-    for taskcounter, tid in enumerate(rqdata.runtaskentries):
-        if tid in rqdata.runq_setscene_tids:
-            deps = set()
-            for dep in sq_revdeps_new[tid]:
-                deps.add(dep)
-            sq_revdeps_squash[tid] = deps
-        elif len(sq_revdeps_new[tid]) != 0:
-            bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
-        rqdata.init_progress_reporter.update(taskcounter)
+            if self.cooker.configuration.skipsetscene:
+                logger.debug(2, 'No setscene tasks should be executed. Skipping %s', task)
+                self.sq_task_failoutright(task)
+                return True
+
+            startevent = sceneQueueTaskStarted(task, self.sq_stats, self.rq)
+            bb.event.fire(startevent, self.cfgData)
+
+            taskdepdata = self.sq_build_taskdepdata(task)
+
+            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            taskhash = self.rqdata.get_task_hash(task)
+            unihash = self.rqdata.get_task_unihash(task)
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
+                if not mc in self.rq.fakeworker:
+                    self.rq.start_fakeworker(self, mc)
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.flush()
+            else:
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.flush()
+
+            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.build_stamps2.append(self.build_stamps[task])
+            self.sq_running.add(task)
+            self.sq_live.add(task)
+            self.sq_stats.taskActive()
+            if self.can_start_task():
+                return True
+
+        if self.sq_stats.active > 0:
+            self.rq.read_workers()
+            return self.rq.active_fds()
+
+        #for tid in self.sqdata.sq_revdeps:
+        #    if tid not in self.sq_running:
+        #        buildable = tid in self.sq_buildable
+        #        revdeps = self.sqdata.sq_revdeps[tid]
+        #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
+
+        self.rq.scenequeue_covered = self.scenequeue_covered
+        self.rq.scenequeue_notcovered = self.scenequeue_notcovered
+
+        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.rq.scenequeue_covered)))
+
+        self.rq.state = runQueueRunInit
+
+        completeevent = sceneQueueComplete(self.sq_stats, self.rq)
+        bb.event.fire(completeevent, self.cfgData)
+
+        return True
+
+    def sq_build_taskdepdata(self, task):
+        def getsetscenedeps(tid):
+            deps = set()
+            (mc, fn, taskname, _) = split_tid_mcfn(tid)
+            realtid = tid + "_setscene"
+            idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
+            for (depname, idependtask) in idepends:
+                if depname not in self.rqdata.taskData[mc].build_targets:
+                    continue
+
+                depfn = self.rqdata.taskData[mc].build_targets[depname][0]
+                if depfn is None:
+                     continue
+                deptid = depfn + ":" + idependtask.replace("_setscene", "")
+                deps.add(deptid)
+            return deps
+
+        taskdepdata = {}
+        next = getsetscenedeps(task)
+        next.add(task)
+        while next:
+            additional = []
+            for revdep in next:
+                (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
+                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
+                deps = getsetscenedeps(revdep)
+                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
+                taskhash = self.rqdata.runtaskentries[revdep].hash
+                unihash = self.rqdata.runtaskentries[revdep].unihash
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
+                for revdep2 in deps:
+                    if revdep2 not in taskdepdata:
+                        additional.append(revdep2)
+            next = additional
+
+        #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
+        return taskdepdata
+
+class SQData(object):
+    def __init__(self):
+        self.sq_harddeps = {}
+        self.stamps = {}
+        self.unskippable = []
+
+def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
+
+    sq_revdeps = {}
+    sq_revdeps_new = {}
+    sq_revdeps_squash = {}
+
+    # We need to construct a dependency graph for the setscene functions. Intermediate
+    # dependencies between the setscene tasks only complicate the code. This code
+    # therefore aims to collapse the huge runqueue dependency tree into a smaller one
+    # only containing the setscene functions.
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # First process the chains up to the first setscene task.
+    endpoints = {}
+    for tid in rqdata.runtaskentries:
+        sq_revdeps[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
+        sq_revdeps_new[tid] = set()
+        if (len(sq_revdeps[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
+            #bb.warn("Added endpoint %s" % (tid))
+            endpoints[tid] = set()
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # Secondly process the chains between setscene tasks.
+    for tid in rqdata.runq_setscene_tids:
+        #bb.warn("Added endpoint 2 %s" % (tid))
+        for dep in rqdata.runtaskentries[tid].depends:
+                if tid in sq_revdeps[dep]:
+                    sq_revdeps[dep].remove(tid)
+                if dep not in endpoints:
+                    endpoints[dep] = set()
+                #bb.warn("  Added endpoint 3 %s" % (dep))
+                endpoints[dep].add(tid)
+
+    rqdata.init_progress_reporter.next_stage()
+
+    def process_endpoints(endpoints):
+        newendpoints = {}
+        for point, task in endpoints.items():
+            tasks = set()
+            if task:
+                tasks |= task
+            if sq_revdeps_new[point]:
+                tasks |= sq_revdeps_new[point]
+            sq_revdeps_new[point] = set()
+            if point in rqdata.runq_setscene_tids:
+                sq_revdeps_new[point] = tasks
+                tasks = set()
+                continue
+            for dep in rqdata.runtaskentries[point].depends:
+                if point in sq_revdeps[dep]:
+                    sq_revdeps[dep].remove(point)
+                if tasks:
+                    sq_revdeps_new[dep] |= tasks
+                if len(sq_revdeps[dep]) == 0 and dep not in rqdata.runq_setscene_tids:
+                    newendpoints[dep] = task
+        if len(newendpoints) != 0:
+            process_endpoints(newendpoints)
+
+    process_endpoints(endpoints)
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # Build a list of setscene tasks which are "unskippable"
+    # These are direct endpoints referenced by the build
+    endpoints2 = {}
+    sq_revdeps2 = {}
+    sq_revdeps_new2 = {}
+    def process_endpoints2(endpoints):
+        newendpoints = {}
+        for point, task in endpoints.items():
+            tasks = set([point])
+            if task:
+                tasks |= task
+            if sq_revdeps_new2[point]:
+                tasks |= sq_revdeps_new2[point]
+            sq_revdeps_new2[point] = set()
+            if point in rqdata.runq_setscene_tids:
+                sq_revdeps_new2[point] = tasks
+            for dep in rqdata.runtaskentries[point].depends:
+                if point in sq_revdeps2[dep]:
+                    sq_revdeps2[dep].remove(point)
+                if tasks:
+                    sq_revdeps_new2[dep] |= tasks
+                if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in rqdata.runq_setscene_tids:
+                    newendpoints[dep] = tasks
+        if len(newendpoints) != 0:
+            process_endpoints2(newendpoints)
+    for tid in rqdata.runtaskentries:
+        sq_revdeps2[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
+        sq_revdeps_new2[tid] = set()
+        if (len(sq_revdeps2[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
+            endpoints2[tid] = set()
+    process_endpoints2(endpoints2)
+    for tid in rqdata.runq_setscene_tids:
+        if sq_revdeps_new2[tid]:
+            sqdata.unskippable.append(tid)
+
+    rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
+
+    for taskcounter, tid in enumerate(rqdata.runtaskentries):
+        if tid in rqdata.runq_setscene_tids:
+            deps = set()
+            for dep in sq_revdeps_new[tid]:
+                deps.add(dep)
+            sq_revdeps_squash[tid] = deps
+        elif len(sq_revdeps_new[tid]) != 0:
+            bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+        rqdata.init_progress_reporter.update(taskcounter)
 
     rqdata.init_progress_reporter.next_stage()
 
@@ -2335,6 +2473,66 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqdata.outrightfail.append(tid)
 
 
+class RunQueueExecuteDummy(RunQueueExecute):
+    def __init__(self, rq):
+        self.rq = rq
+        self.stats = RunQueueStats(0)
+
+    def finish(self):
+        self.rq.state = runQueueComplete
+        return
+
+class RunQueueExecuteTasks(RunQueueExecute):
+    def __init__(self, rq):
+        RunQueueExecute.__init__(self, rq)
+
+        self.stampcache = {}
+
+        # Mark initial buildable tasks
+        for tid in self.rqdata.runtaskentries:
+            if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                self.runq_buildable.add(tid)
+            if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
+                self.rq.scenequeue_covered.add(tid)
+
+        found = True
+        while found:
+            found = False
+            for tid in self.rqdata.runtaskentries:
+                if tid in self.rq.scenequeue_covered:
+                    continue
+                logger.debug(1, 'Considering %s: %s' % (tid, str(self.rqdata.runtaskentries[tid].revdeps)))
+
+                if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
+                    if tid in self.rq.scenequeue_notcovered:
+                        continue
+                    found = True
+                    self.rq.scenequeue_covered.add(tid)
+
+        logger.debug(1, 'Skip list %s', sorted(self.rq.scenequeue_covered))
+
+        for task in self.rq.scenequeue_notcovered:
+            logger.debug(1, 'Not skipping task %s', task)
+
+        for mc in self.rqdata.dataCaches:
+            target_pairs = []
+            for tid in self.rqdata.target_tids:
+                (tidmc, fn, taskname, _) = split_tid_mcfn(tid)
+                if tidmc == mc:
+                    target_pairs.append((fn, taskname))
+
+            event.fire(bb.event.StampUpdate(target_pairs, self.rqdata.dataCaches[mc].stamp), self.cfgData)
+
+        schedulers = self.get_schedulers()
+        for scheduler in schedulers:
+            if self.scheduler == scheduler.name:
+                self.sched = scheduler(self, self.rqdata)
+                logger.debug(1, "Using runqueue scheduler '%s'", scheduler.name)
+                break
+        else:
+            bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
+                     (self.scheduler, ", ".join(obj.name for obj in schedulers)))
+
 class RunQueueExecuteScenequeue(RunQueueExecute):
     def __init__(self, rq):
         RunQueueExecute.__init__(self, rq)
@@ -2357,204 +2555,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         self.rq.state = runQueueSceneRun
 
-    def scenequeue_updatecounters(self, task, fail = False):
-        for dep in self.sqdata.sq_deps[task]:
-            if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
-                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
-                self.scenequeue_updatecounters(dep, fail)
-                continue
-            if task not in self.sqdata.sq_revdeps2[dep]:
-                # May already have been removed by the fail case above
-                continue
-            self.sqdata.sq_revdeps2[dep].remove(task)
-            if len(self.sqdata.sq_revdeps2[dep]) == 0:
-                self.sq_buildable.add(dep)
-
-    def sq_task_completeoutright(self, task):
-        """
-        Mark a task as completed
-        Look at the reverse dependencies and mark any task with
-        completed dependencies as buildable
-        """
-
-        logger.debug(1, 'Found task %s which could be accelerated', task)
-        self.scenequeue_covered.add(task)
-        self.scenequeue_updatecounters(task)
-
-    def sq_check_taskfail(self, task):
-        if self.rqdata.setscenewhitelist is not None:
-            realtask = task.split('_setscene')[0]
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(realtask)
-            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-            if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
-                logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
-                self.rq.state = runQueueCleanUp
-
-    def sq_task_complete(self, task):
-        self.sq_stats.taskCompleted()
-        bb.event.fire(sceneQueueTaskCompleted(task, self.sq_stats, self.rq), self.cfgData)
-        self.sq_task_completeoutright(task)
-
-    def sq_task_fail(self, task, result):
-        self.sq_stats.taskFailed()
-        bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
-        self.scenequeue_notcovered.add(task)
-        self.scenequeue_updatecounters(task, True)
-        self.sq_check_taskfail(task)
-
-    def sq_task_failoutright(self, task):
-        self.sq_running.add(task)
-        self.sq_buildable.add(task)
-        self.sq_stats.taskSkipped()
-        self.sq_stats.taskCompleted()
-        self.scenequeue_notcovered.add(task)
-        self.scenequeue_updatecounters(task, True)
-
-    def sq_task_skip(self, task):
-        self.sq_running.add(task)
-        self.sq_buildable.add(task)
-        self.sq_task_completeoutright(task)
-        self.sq_stats.taskSkipped()
-        self.sq_stats.taskCompleted()
-
-    def sq_execute(self):
-        """
-        Run the tasks in a queue prepared by prepare_runqueue
-        """
-
-        self.rq.read_workers()
-
-        task = None
-        if self.can_start_task():
-            # Find the next setscene to run
-            for nexttask in self.rqdata.runq_setscene_tids:
-                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask in self.sqdata.unskippable:
-                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
-                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
-                        fn = fn_from_tid(nexttask)
-                        foundtarget = False
-
-                        if nexttask in self.rqdata.target_tids:
-                            foundtarget = True
-                        if not foundtarget:
-                            logger.debug(2, "Skipping setscene for task %s" % nexttask)
-                            self.sq_task_skip(nexttask)
-                            self.scenequeue_notneeded.add(nexttask)
-                            return True
-                    if nexttask in self.sqdata.outrightfail:
-                        self.sq_task_failoutright(nexttask)
-                        return True
-                    task = nexttask
-                    break
-        if task is not None:
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
-            taskname = taskname + "_setscene"
-            if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
-                logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
-                self.sq_task_failoutright(task)
-                return True
-
-            if self.cooker.configuration.force:
-                if task in self.rqdata.target_tids:
-                    self.sq_task_failoutright(task)
-                    return True
-
-            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
-                logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
-                self.sq_task_skip(task)
-                return True
-
-            if self.cooker.configuration.skipsetscene:
-                logger.debug(2, 'No setscene tasks should be executed. Skipping %s', task)
-                self.sq_task_failoutright(task)
-                return True
-
-            startevent = sceneQueueTaskStarted(task, self.sq_stats, self.rq)
-            bb.event.fire(startevent, self.cfgData)
-
-            taskdepdata = self.sq_build_taskdepdata(task)
-
-            taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-            taskhash = self.rqdata.get_task_hash(task)
-            unihash = self.rqdata.get_task_unihash(task)
-            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
-                if not mc in self.rq.fakeworker:
-                    self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
-                self.rq.fakeworker[mc].process.stdin.flush()
-            else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
-                self.rq.worker[mc].process.stdin.flush()
-
-            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
-            self.build_stamps2.append(self.build_stamps[task])
-            self.sq_running.add(task)
-            self.sq_live.add(task)
-            self.sq_stats.taskActive()
-            if self.can_start_task():
-                return True
-
-        if self.sq_stats.active > 0:
-            self.rq.read_workers()
-            return self.rq.active_fds()
-
-        #for tid in self.sqdata.sq_revdeps:
-        #    if tid not in self.sq_running:
-        #        buildable = tid in self.sq_buildable
-        #        revdeps = self.sqdata.sq_revdeps[tid]
-        #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
-
-        self.rq.scenequeue_covered = self.scenequeue_covered
-        self.rq.scenequeue_notcovered = self.scenequeue_notcovered
-
-        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.rq.scenequeue_covered)))
-
-        self.rq.state = runQueueRunInit
-
-        completeevent = sceneQueueComplete(self.sq_stats, self.rq)
-        bb.event.fire(completeevent, self.cfgData)
-
-        return True
-
-    def sq_build_taskdepdata(self, task):
-        def getsetscenedeps(tid):
-            deps = set()
-            (mc, fn, taskname, _) = split_tid_mcfn(tid)
-            realtid = tid + "_setscene"
-            idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
-            for (depname, idependtask) in idepends:
-                if depname not in self.rqdata.taskData[mc].build_targets:
-                    continue
-
-                depfn = self.rqdata.taskData[mc].build_targets[depname][0]
-                if depfn is None:
-                     continue
-                deptid = depfn + ":" + idependtask.replace("_setscene", "")
-                deps.add(deptid)
-            return deps
-
-        taskdepdata = {}
-        next = getsetscenedeps(task)
-        next.add(task)
-        while next:
-            additional = []
-            for revdep in next:
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
-                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-                deps = getsetscenedeps(revdep)
-                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
-                taskhash = self.rqdata.runtaskentries[revdep].hash
-                unihash = self.rqdata.runtaskentries[revdep].unihash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
-                for revdep2 in deps:
-                    if revdep2 not in taskdepdata:
-                        additional.append(revdep2)
-            next = additional
-
-        #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
-        return taskdepdata
-
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
-- 
2.20.1


