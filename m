Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id 3D2C77E58B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 15:14:21 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id 31so104930454wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Aug 2019 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=RoqkLvB1jDiLmwR55EPjfOJHovmbbNxoXtv0zbfCtxA=;
	b=bGIWEXrOruJtc9ox/VIIVWRXKwnGldy0qz3CA1Z/UwzY+ywwRt6FUhjlnpVeUVsEBL
	GBgYAD/o4wV0fXLgmvuXfIQzUreGs8FCmx/A+ei4h5uHHO2wjN2FtA1xOtP2en0ehFJJ
	ElI0hRIj5ntxwRFeY2g47lFDAbQIoSzPhNa1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=RoqkLvB1jDiLmwR55EPjfOJHovmbbNxoXtv0zbfCtxA=;
	b=Ij3tt0fIullKV/GRDG03rhr6e3Ve+GMxqTGy5mb9xHsmkaQ828Yr8pItL1nl+Dxjv7
	BVUmutoEPXJyKlgLLa2Oqo9gj0kjNUX3wqpFQKMPM6hT+rPWP+msrlm5cmY8s33OyuQ8
	oik1qp3va6OdhVUQIYu/hkqUAZD07L1WbI/in6r8Xo9g40NGWLe2PPqgdYaH6Jr7Zqr8
	i04rP7hTXQncqpfs43wPUOB8dDfr3PVkJAQXltFWVIL2/8gjeYmsUAE+HjP9istwn3gg
	eYFI2KLxOq9NC40pYe8BIqtvV09pAefIyifYiQWF3wK/RabY6YxPMJcCGntna5nhO+gt
	RFWA==
X-Gm-Message-State: APjAAAUHTTNMx4Gx+rd+2YpjW2gzsXhWXAq/ImKdw7058xSgzJwG5XbP
	VoJwkcYRdjdBd3hksU4DpgIBzBRXq6TltA==
X-Google-Smtp-Source: APXvYqx6p/ylr7kff1VqejRLvijUik2UWlPvx2sm4RDgGKwjEf7xd4N3LiCXJkzrqV/h/Q4MjcBtkw==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr40789554wrw.323.1565622861568;
	Mon, 12 Aug 2019 08:14:21 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	b2sm12029638wrf.94.2019.08.12.08.14.20
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 12 Aug 2019 08:14:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Aug 2019 16:14:16 +0100
Message-Id: <20190812151418.31307-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812151418.31307-1-richard.purdie@linuxfoundation.org>
References: <20190812151418.31307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] runqueue: Improve setscene task handling logic
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
X-List-Received-Date: Mon, 12 Aug 2019 15:14:21 -0000
Content-Transfer-Encoding: 8bit

The previous tasks_covered and tasks_notcovered were basically unstable
data structures. We couldn't always tell whether tasks should be covered
or not when trying to repair the sturcture if sstate tasks reran.

In the end its simpler to throw the lists away and rebuild them based upon
current data rather than trying to patch it adhoc. This turns out to be
simpler and much more reliable and I've much more confidence in this code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 109 ++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 75 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2bf19b9778..bda8a4baee 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1730,7 +1730,9 @@ class RunQueueExecute:
         self.tasks_notcovered = set()
         self.scenequeue_notneeded = set()
 
-        self.coveredtopocess = set()
+        # We can't skip specified target tasks which aren't setscene tasks
+        self.cantskip = set(self.rqdata.target_tids)
+        self.cantskip.difference_update(self.rqdata.runq_setscene_tids)
 
         schedulers = self.get_schedulers()
         for scheduler in schedulers:
@@ -2237,10 +2239,9 @@ class RunQueueExecute:
 
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep not in self.runq_complete:
-                    if dep in self.tasks_scenequeue_done:
+                    if dep in self.tasks_scenequeue_done and dep not in self.sqdata.unskippable:
+                        logger.debug(1, "Removing to done %s" % dep)
                         self.tasks_scenequeue_done.remove(dep)
-                    if dep in self.tasks_notcovered:
-                        self.tasks_notcovered.remove(dep)
 
             if tid in self.sq_buildable:
                 self.sq_buildable.remove(tid)
@@ -2254,6 +2255,8 @@ class RunQueueExecute:
                 self.sqdata.outrightfail.remove(tid)
             if tid in self.scenequeue_notcovered:
                 self.scenequeue_notcovered.remove(tid)
+            if tid in self.scenequeue_covered:
+                self.scenequeue_covered.remove(tid)
 
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
             self.sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2269,41 +2272,8 @@ class RunQueueExecute:
         if changes:
             self.update_holdofftasks()
 
-    def scenequeue_process_notcovered(self, task):
-        if len(self.rqdata.runtaskentries[task].depends) == 0:
-            self.setbuildable(task)
-        notcovered = set([task])
-        while notcovered:
-            new = set()
-            for t in sorted(notcovered):
-                for deptask in sorted(self.rqdata.runtaskentries[t].depends):
-                    if deptask in notcovered or deptask in new or deptask in self.rqdata.runq_setscene_tids or deptask in self.tasks_notcovered:
-                        continue
-                    logger.debug(1, 'Task %s depends on non-setscene task %s so not skipping' % (t, deptask))
-                    new.add(deptask)
-                    self.tasks_notcovered.add(deptask)
-                    if len(self.rqdata.runtaskentries[deptask].depends) == 0:
-                        self.setbuildable(deptask)
-            notcovered = new
-
-    def scenequeue_process_unskippable(self, task):
-        # Look up the dependency chain for non-setscene things which depend on this task
-        # and mark as 'done'/notcovered
-        ready = set([task])
-        while ready:
-            new = set()
-            for t in sorted(ready):
-                for deptask in sorted(self.rqdata.runtaskentries[t].revdeps):
-                    if deptask in ready or deptask in new or deptask in self.tasks_scenequeue_done or deptask in self.rqdata.runq_setscene_tids:
-                        continue
-                    if deptask in self.sqdata.unskippable:
-                        new.add(deptask)
-                        self.tasks_scenequeue_done.add(deptask)
-                        self.tasks_notcovered.add(deptask)
-                        #logger.warning("Up: " + str(deptask))
-            ready = new
-
     def scenequeue_updatecounters(self, task, fail=False):
+
         for dep in sorted(self.sqdata.sq_deps[task]):
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
@@ -2325,39 +2295,31 @@ class RunQueueExecute:
                         continue
                     if self.rqdata.runtaskentries[dep].revdeps.issubset(self.tasks_scenequeue_done):
                         new.add(dep)
-                        #logger.warning(" Down: " + dep)
             next = new
 
-        if task in self.sqdata.unskippable:
-            self.scenequeue_process_unskippable(task)
-
-        if task in self.scenequeue_notcovered:
-            logger.debug(1, 'Not skipping setscene task %s', task)
-            self.scenequeue_process_notcovered(task)
-        elif task in self.scenequeue_covered:
-            logger.debug(1, 'Queued setscene task %s', task)
-            self.coveredtopocess.add(task)
-
-        for task in sorted(self.coveredtopocess.copy()):
-            if self.sqdata.sq_covered_tasks[task].issubset(self.tasks_scenequeue_done):
-                logger.debug(1, 'Processing setscene task %s', task)
-                covered = self.sqdata.sq_covered_tasks[task]
-                covered.add(task)
-
-                # If a task is in target_tids and isn't a setscene task, we can't skip it.
-                cantskip = covered.intersection(self.rqdata.target_tids).difference(self.rqdata.runq_setscene_tids)
-                for tid in sorted(cantskip):
-                    self.tasks_notcovered.add(tid)
-                    self.scenequeue_process_notcovered(tid)
-                covered.difference_update(cantskip)
-
-                # Remove notcovered tasks
-                covered.difference_update(self.tasks_notcovered)
-                self.tasks_covered.update(covered)
-                self.coveredtopocess.remove(task)
-                for tid in sorted(covered):
-                    if self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
-                        self.setbuildable(tid)
+        notcovered = set(self.scenequeue_notcovered)
+        notcovered |= self.cantskip
+        for tid in self.scenequeue_notcovered:
+            notcovered |= self.sqdata.sq_covered_tasks[tid]
+        notcovered |= self.sqdata.unskippable.difference(self.rqdata.runq_setscene_tids)
+        notcovered.intersection_update(self.tasks_scenequeue_done)
+
+        covered = set(self.scenequeue_covered)
+        for tid in self.scenequeue_covered:
+            covered |= self.sqdata.sq_covered_tasks[tid]
+        covered.difference_update(notcovered)
+        covered.intersection_update(self.tasks_scenequeue_done)
+
+        for tid in notcovered:
+            if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                self.setbuildable(tid)
+        for tid in covered:
+             if self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
+                 self.setbuildable(tid)
+
+        self.tasks_covered = covered
+        self.tasks_notcovered = notcovered
+
         self.update_holdofftasks()
 
     def sq_task_completeoutright(self, task):
@@ -2369,7 +2331,6 @@ class RunQueueExecute:
 
         logger.debug(1, 'Found task %s which could be accelerated', task)
         self.scenequeue_covered.add(task)
-        self.tasks_covered.add(task)
         self.scenequeue_updatecounters(task)
 
     def sq_check_taskfail(self, task):
@@ -2390,7 +2351,6 @@ class RunQueueExecute:
         self.sq_stats.taskFailed()
         bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
-        self.tasks_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
 
@@ -2400,7 +2360,6 @@ class RunQueueExecute:
         self.sq_stats.taskSkipped()
         self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
-        self.tasks_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
     def sq_task_skip(self, task):
@@ -2564,6 +2523,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     for tid in rqdata.runtaskentries:
         if len(rqdata.runtaskentries[tid].revdeps) == 0:
             sqdata.unskippable.add(tid)
+    sqdata.unskippable |= sqrq.cantskip
     while new:
         new = False
         orig = sqdata.unskippable.copy()
@@ -2572,14 +2532,13 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 continue
             if len(rqdata.runtaskentries[tid].depends) == 0:
                 # These are tasks which have no setscene tasks in their chain, need to mark as directly buildable
-                sqrq.tasks_notcovered.add(tid)
-                sqrq.tasks_scenequeue_done.add(tid)
                 sqrq.setbuildable(tid)
-            sqrq.scenequeue_process_unskippable(tid)
             sqdata.unskippable |= rqdata.runtaskentries[tid].depends
             if sqdata.unskippable != orig:
                 new = True
 
+    sqrq.tasks_scenequeue_done |= sqdata.unskippable.difference(rqdata.runq_setscene_tids)
+
     rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
 
     # Sanity check all dependencies could be changed to setscene task references
-- 
2.20.1


