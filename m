Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id C46D97F00E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:31 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id n4so4241929wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=BZGufDE9LoblyHKqqshzuF+JxzDMFrLLkX5Fsf1bzAk=;
	b=Ju4ob4GwaOzVwgXx8z0TzbC3DFUF0gqsZgQ7IdzoDNSM73EVzKPWXQEbtzEAE+Rny6
	8RQRA1vUUSTz2yYAMf5CDzYpepiqLDwDaAeCrb+zp3eKbvyxlh4oSaxT+u3P5AfSC/ji
	PAY8embRSf4VrzxMdzUvdHe0evbQDeXNTSGko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BZGufDE9LoblyHKqqshzuF+JxzDMFrLLkX5Fsf1bzAk=;
	b=GB4UsmuUADxJMc6lpDTLYhX8Q8DqCcPBfiq3BmdPhgK4z/5fFvJnW/D8J0FOPEf71r
	ztG9SZGr34MKlXl9DHCF53vRlj+AhYiyP7Kg+mY2RrFt/MSLACdNTzQBX1LeV2bdAD7y
	iAwSsQRW8qs6mrimNLxSkC8mS86HHJplI6iYJ9QnqQN2yiCS7mgGb1xaTmjU8rCtLm9C
	JPjeAdf4hH4VLehuxRTPJUslV+QsBmIU9/Ani7rB88ef9Hk0mc1uAgQtLWrpASOtQJa/
	HkPIWWCG5asRIdPSedEZsAle8wFHaLpdSitFK4VJmB4wvn6MhUfeE1mbIH/ofGp3hbcQ
	biFg==
X-Gm-Message-State: APjAAAU9CU1oqvSwVhb40/QvkrsSWLUIMxjoCzNMyS+ZDJHGOF8wQjWy
	VXImbe8JOuqtP208ghg6e3Os8tkohI0=
X-Google-Smtp-Source: APXvYqzu5MkpebW6lBk62PWQ7TqM3i8UCZ4mzniIKb5Q/ATkDV/B3xbDzblmtCokdFVKwR3a07cLFg==
X-Received: by 2002:adf:deca:: with SMTP id i10mr222751wrn.313.1562802872247; 
	Wed, 10 Jul 2019 16:54:32 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:05 +0100
Message-Id: <20190710235420.23825-11-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 11/26] runqueue: Remove RunQueueExecuteScenequeue and RunQueueExecuteTasks
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:32 -0000
Content-Transfer-Encoding: 8bit

Replace the remains of the Tasks and Scenequeue Tasks classes with simple
function calls. Also drop the dummy version of the execution class to
simplify further changes as its not needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 99 ++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 56 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 54dce83737..3456fd976b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1407,7 +1407,6 @@ class RunQueue:
         retval = True
 
         if self.state is runQueuePrepare:
-            self.rqexe = RunQueueExecuteDummy(self)
             # NOTE: if you add, remove or significantly refactor the stages of this
             # process then you should recalculate the weightings here. This is quite
             # easy to do - just change the next line temporarily to pass debug=True as
@@ -1449,7 +1448,9 @@ class RunQueue:
                 self.rqdata.init_progress_reporter.next_stage()
                 self.start_worker()
                 self.rqdata.init_progress_reporter.next_stage()
-                self.rqexe = RunQueueExecuteScenequeue(self)
+                if not self.rqexe:
+                    self.rqexe = RunQueueExecute(self)
+                start_scenequeue_tasks(self.rqexe)
 
         if self.state is runQueueSceneRun:
             retval = self.rqexe.sq_execute()
@@ -1461,7 +1462,9 @@ class RunQueue:
                 # Just in case we didn't setscene
                 self.rqdata.init_progress_reporter.finish()
                 logger.info("Executing RunQueue Tasks")
-                self.rqexe = RunQueueExecuteTasks(self)
+                if not self.rqexe:
+                    self.rqexe = RunQueueExecute(self)
+                start_runqueue_tasks(self.rqexe)
                 self.state = runQueueRunning
 
         if self.state is runQueueRunning:
@@ -1478,11 +1481,12 @@ class RunQueue:
 
         if build_done and self.rqexe:
             self.teardown_workers()
-            if self.rqexe.stats.failed:
-                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
-            else:
-                # Let's avoid the word "failed" if nothing actually did
-                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
+            if self.rqexe:
+                if self.rqexe.stats.failed:
+                    logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
+                else:
+                    # Let's avoid the word "failed" if nothing actually did
+                    logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
 
         if self.state is runQueueFailed:
             raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
@@ -2472,88 +2476,71 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 logger.debug(2, 'No package found, so skipping setscene task %s', tid)
                 sqdata.outrightfail.append(tid)
 
-
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
+def start_runqueue_tasks(rqexec):
 
         # Mark initial buildable tasks
-        for tid in self.rqdata.runtaskentries:
-            if len(self.rqdata.runtaskentries[tid].depends) == 0:
-                self.runq_buildable.add(tid)
-            if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
-                self.rq.scenequeue_covered.add(tid)
+        for tid in rqexec.rqdata.runtaskentries:
+            if len(rqexec.rqdata.runtaskentries[tid].depends) == 0:
+                rqexec.runq_buildable.add(tid)
+            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.rq.scenequeue_covered):
+                rqexec.rq.scenequeue_covered.add(tid)
 
         found = True
         while found:
             found = False
-            for tid in self.rqdata.runtaskentries:
-                if tid in self.rq.scenequeue_covered:
+            for tid in rqexec.rqdata.runtaskentries:
+                if tid in rqexec.rq.scenequeue_covered:
                     continue
-                logger.debug(1, 'Considering %s: %s' % (tid, str(self.rqdata.runtaskentries[tid].revdeps)))
+                logger.debug(1, 'Considering %s: %s' % (tid, str(rqexec.rqdata.runtaskentries[tid].revdeps)))
 
-                if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
-                    if tid in self.rq.scenequeue_notcovered:
+                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.rq.scenequeue_covered):
+                    if tid in rqexec.rq.scenequeue_notcovered:
                         continue
                     found = True
-                    self.rq.scenequeue_covered.add(tid)
+                    rqexec.rq.scenequeue_covered.add(tid)
 
-        logger.debug(1, 'Skip list %s', sorted(self.rq.scenequeue_covered))
+        logger.debug(1, 'Skip list %s', sorted(rqexec.rq.scenequeue_covered))
 
         for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
 
-        for mc in self.rqdata.dataCaches:
+        for mc in rqexec.rqdata.dataCaches:
             target_pairs = []
-            for tid in self.rqdata.target_tids:
+            for tid in rqexec.rqdata.target_tids:
                 (tidmc, fn, taskname, _) = split_tid_mcfn(tid)
                 if tidmc == mc:
                     target_pairs.append((fn, taskname))
 
-            event.fire(bb.event.StampUpdate(target_pairs, self.rqdata.dataCaches[mc].stamp), self.cfgData)
+            event.fire(bb.event.StampUpdate(target_pairs, rqexec.rqdata.dataCaches[mc].stamp), rqexec.cfgData)
 
-        schedulers = self.get_schedulers()
+        schedulers = rqexec.get_schedulers()
         for scheduler in schedulers:
-            if self.scheduler == scheduler.name:
-                self.sched = scheduler(self, self.rqdata)
+            if rqexec.scheduler == scheduler.name:
+                rqexec.sched = scheduler(rqexec, rqexec.rqdata)
                 logger.debug(1, "Using runqueue scheduler '%s'", scheduler.name)
                 break
         else:
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
-                     (self.scheduler, ", ".join(obj.name for obj in schedulers)))
-
-class RunQueueExecuteScenequeue(RunQueueExecute):
-    def __init__(self, rq):
-        RunQueueExecute.__init__(self, rq)
+                     (rqexec.scheduler, ", ".join(obj.name for obj in schedulers)))
 
-        self.scenequeue_covered = set()
-        self.scenequeue_notcovered = set()
-        self.scenequeue_notneeded = set()
+def start_scenequeue_tasks(rqexec):
+        rqexec.scenequeue_covered = set()
+        rqexec.scenequeue_notcovered = set()
+        rqexec.scenequeue_notneeded = set()
 
         # If we don't have any setscene functions, skip this step
-        if len(self.rqdata.runq_setscene_tids) == 0:
-            rq.scenequeue_covered = set()
-            rq.scenequeue_notcovered = set()
-            rq.state = runQueueRunInit
+        if len(rqexec.rqdata.runq_setscene_tids) == 0:
+            rqexec.rq.scenequeue_covered = set()
+            rqexec.rq.scenequeue_notcovered = set()
+            rqexec.rq.state = runQueueRunInit
             return
 
-        self.sqdata = SQData()
-        build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+        rqexec.sqdata = SQData()
+        build_scenequeue_data(rqexec.sqdata, rqexec.rqdata, rqexec.rq, rqexec.cooker, rqexec.stampcache, rqexec)
 
         logger.info('Executing SetScene Tasks')
 
-        self.rq.state = runQueueSceneRun
+        rqexec.rq.state = runQueueSceneRun
 
 class TaskFailure(Exception):
     """
-- 
2.20.1


