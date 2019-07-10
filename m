Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail.openembedded.org (Postfix) with ESMTP id C83627F061
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:43 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id s15so3904989wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=pcZlez3gvQGkwNIdszdywS8e7dbjrRSgvZLPrsal+kY=;
	b=gGRRA1zSSk6ztkhqqpl0kv7TuZh1s7EajRNg6oBp6ck8N16j4H0rl1apgv1dXvIESt
	Bq8BlcJti7Jh2hJTr0S2Rk1TGrJiwtULwJg4kEN1P8HlEhmZkbXRVBbB3lPbH8+oLVxY
	KpmzlYLUY594zJvD162bIYV8CQlBEm0UNGbSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=pcZlez3gvQGkwNIdszdywS8e7dbjrRSgvZLPrsal+kY=;
	b=mXFK5ktbaDbCZeUos6hKwc6erhc5WwVwgTbZAMh5D/RVXw/xpcI3e4NstHBZ9c4PYT
	qFczPJdXWYfvHkUDUuOjBgspn0saKO+5twNhkuSZtGTonlNULJUqtmPXW8QSUDYT9IR5
	nQ5yHt86bJu3yxy3njVt5uKbxqG9b5DTUCgQ77UGDPUzH86oKC4gYEHt49kwLaEZ1h5R
	XTaxvYWlKrMfpKoO/ILO0VOLCBNgt3rn5USFWMPp4mEEbJ/OPapYKLiNpJ4n0td3vMbn
	lNR7fr7dP0VpRJxtDPMXjrxBpJs0QPR5SYc/8KXHnQQe3ZHUNklVD0XZgd0/7tNQjQdL
	BcTw==
X-Gm-Message-State: APjAAAX8IgePkACFCcqdV3Nxx0/iRA37AfmdBoZW3Es+Kn2mKNKXDv+d
	OMej+QuKRqNTkPl65DkRq4Vmq5jJyxE=
X-Google-Smtp-Source: APXvYqz03YRqIlCajSCwdQ0ZHXzIiXsEUK9VrlUg8+2o+exZYqSEtpFEJWSh2LHTHmYiyx4RP8AJjw==
X-Received: by 2002:a1c:e009:: with SMTP id x9mr281960wmg.5.1562802884081;
	Wed, 10 Jul 2019 16:54:44 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.42
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:18 +0100
Message-Id: <20190710235420.23825-24-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 24/26] runqueue: Complete the merge of scenequeue and normal task execution
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:44 -0000
Content-Transfer-Encoding: 8bit

This combines the scqenequeue and normal task execution into one function
and simplifies the state engine accordingly.

This is the final set of cleanup to fully merge things without adding the
extra noise to the previous commits.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 226 ++++++++++++++++++++++-----------------------
 1 file changed, 109 insertions(+), 117 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e7ba610723..3eaaf51b35 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -102,8 +102,6 @@ class RunQueueStats:
 # runQueue state machine
 runQueuePrepare = 2
 runQueueSceneInit = 3
-runQueueSceneRun = 4
-runQueueRunInit = 5
 runQueueRunning = 6
 runQueueFailed = 7
 runQueueCleanUp = 8
@@ -1202,7 +1200,7 @@ class RunQueue:
         # Invoked at regular time intervals via the bitbake heartbeat event
         # while the build is running. We generate a unique name for the handler
         # here, just in case that there ever is more than one RunQueue instance,
-        # start the handler when reaching runQueueSceneRun, and stop it when
+        # start the handler when reaching runQueueSceneInit, and stop it when
         # done with the build.
         self.dm = monitordisk.diskMonitor(cfgData)
         self.dm_event_handler_name = '_bb_diskmonitor_' + str(id(self))
@@ -1432,7 +1430,7 @@ class RunQueue:
 
             if not self.dm_event_handler_registered:
                  res = bb.event.register(self.dm_event_handler_name,
-                                         lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
+                                         lambda x: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
                                          ('bb.event.HeartbeatEvent',))
                  self.dm_event_handler_registered = True
 
@@ -1464,8 +1462,6 @@ class RunQueue:
             self.state = runQueueRunning
 
         if self.state is runQueueRunning:
-            retval = self.rqexe.sq_execute()
-            # FIXME revtal
             retval = self.rqexe.execute()
 
         if self.state is runQueueCleanUp:
@@ -1898,19 +1894,118 @@ class RunQueueExecute:
 
     def execute(self):
         """
-        Run the tasks in a queue prepared by rqdata.prepare()
+        Run the tasks in a queue prepared by prepare_runqueue
         """
 
-        if self.cooker.configuration.setsceneonly:
-            return True
-
         self.rq.read_workers()
 
-        if self.stats.total == 0:
-            # nothing to do
-            self.rq.state = runQueueCleanUp
+        task = None
+        if not self.sqdone and self.can_start_task():
+            # Find the next setscene to run
+            for nexttask in self.rqdata.runq_setscene_tids:
+                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
+                    if nexttask in self.sqdata.unskippable:
+                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
+                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
+                        fn = fn_from_tid(nexttask)
+                        foundtarget = False
 
-        task = self.sched.next()
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
+
+            if self.cooker.configuration.force:
+                if task in self.rqdata.target_tids:
+                    self.sq_task_failoutright(task)
+                    return True
+
+            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
+                logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
+                self.sq_task_skip(task)
+                return True
+
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
+        if not self.sq_live and not self.sqdone:
+            logger.info("Setscene tasks completed")
+            logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
+
+            completeevent = sceneQueueComplete(self.sq_stats, self.rq)
+            bb.event.fire(completeevent, self.cfgData)
+
+            err = False
+            for x in self.rqdata.runtaskentries:
+                if x not in self.tasks_covered and x not in self.tasks_notcovered:
+                    logger.error("Task %s was never moved from the setscene queue" % x)
+                    err = True
+                if x not in self.tasks_scenequeue_done:
+                    logger.error("Task %s was never processed by the setscene code" % x)
+                    err = True
+                if len(self.rqdata.runtaskentries[x].depends) == 0 and x not in self.runq_buildable:
+                    logger.error("Task %s was never marked as buildable by the setscene code" % x)
+                    err = True
+            if err:
+                self.rq.state = runQueueFailed
+                return True
+
+            if self.cooker.configuration.setsceneonly:
+                self.rq.state = runQueueComplete
+                return True
+            self.sqdone = True
+
+            if self.stats.total == 0:
+                # nothing to do
+                self.rq.state = runQueueComplete
+                return True
+
+        if self.cooker.configuration.setsceneonly:
+            task = None
+        else:
+            task = self.sched.next()
         if task is not None:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
 
@@ -2172,109 +2267,6 @@ class RunQueueExecute:
         self.sq_stats.taskSkipped()
         self.sq_stats.taskCompleted()
 
-    def sq_execute(self):
-        """
-        Run the tasks in a queue prepared by prepare_runqueue
-        """
-
-        if self.sqdone:
-            return True
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
-        if self.stats.active > 0 or self.sq_stats.active > 0:
-            self.rq.read_workers()
-            return self.rq.active_fds()
-
-        #for tid in self.sqdata.sq_revdeps:
-        #    if tid not in self.sq_running:
-        #        buildable = tid in self.sq_buildable
-        #        revdeps = self.sqdata.sq_revdeps[tid]
-        #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
-
-        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
-
-        completeevent = sceneQueueComplete(self.sq_stats, self.rq)
-        bb.event.fire(completeevent, self.cfgData)
-
-        if self.cooker.configuration.setsceneonly:
-            self.rq.state = runQueueComplete
-
-        self.sqdone = True
-
-        return True
-
     def sq_build_taskdepdata(self, task):
         def getsetscenedeps(tid):
             deps = set()
-- 
2.20.1


