Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail.openembedded.org (Postfix) with ESMTP id A3D4C7F023
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id l2so3919114wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Ic9BBntaZgGTzpgC4ZzoZzUG10vK9wict8VSWqztdLo=;
	b=TE7mTy60B4jsX+iuztnKasjiMTTJCvQTkbtGpiZ66EqJVJTVnkq1aHactYIhD21IL2
	N5r6+yI6XjiCyWaLWb4MyGVdmtGD3Clidyhh+p3GMFUffvdCtHV+9n0dsodJKMHSrY+d
	Pl22zBEN5eEQqv6jZUr160DJvsFPmdeWjYHEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ic9BBntaZgGTzpgC4ZzoZzUG10vK9wict8VSWqztdLo=;
	b=bve0IjPF9pmwhy9TZG7cqmMxaXR4HA8nEAyH3dg7N/eOyeEkEBm9WCI94E+6etTZQD
	WVWM78eoaNtpxieHoxvU93d85VcFxBzw3DANK8wGkvg058FcHsJujAd0VrIhHh/k9E7s
	zXrQeZPYxk0ipCFMMnxC0HKIBpl7a6jCBOrpOEnd8qnVSCHFJ2PuL1rfE7HSYWf7ppiv
	Gn94fKuwcFf+kmEwnefmHFzPaaV2Tq3V7iWX6AXomlyn1GU6m5fs1Hw9J6IXU7xkpPcR
	j0FJLf2G1OoEicldLpmoC8A097td+qZaqDQjtpiDzoouwulUEQJmEztLLxcUD9wqv1uf
	vbeA==
X-Gm-Message-State: APjAAAXXt+6f0MDL1rl2K2kKucHhxzM9OAcEd/OMYHhf13O9KEKZL/nL
	8IcgwdG0P55AoECO59E6Znk6agqML/8=
X-Google-Smtp-Source: APXvYqx4+uTEZEuSmb7soyUDldQjtOiMcJBgkn2rLLcqBJlfPxdrtdrNrMo8OH1u905ylpA1Fxi+ag==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr312814wmb.112.1562802874037;
	Wed, 10 Jul 2019 16:54:34 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:07 +0100
Message-Id: <20190710235420.23825-13-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 13/26] runqueue: Fold remains of the scenequeue setup into RunQueueExecute
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:33 -0000
Content-Transfer-Encoding: 8bit

Also move the scheduler init over, apart for the builtable tasks part which need
to remain called later.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 89 ++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 47 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a19fb61fe7..46146466fc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -196,6 +196,11 @@ class RunQueueScheduler(object):
         if self.rq.can_start_task():
             return self.next_buildable_task()
 
+    def initbuildable(self):
+        for tid in self.rqdata.runtaskentries:
+            if tid in self.rq.runq_buildable:
+                self.buildable.append(tid)
+
     def newbuildable(self, task):
         self.buildable.append(task)
 
@@ -1451,7 +1456,14 @@ class RunQueue:
             self.start_worker()
             self.rqdata.init_progress_reporter.next_stage()
             self.rqexe = RunQueueExecute(self)
-            start_scenequeue_tasks(self.rqexe)
+
+            # If we don't have any setscene functions, skip execution
+            if len(self.rqdata.runq_setscene_tids) == 0:
+                self.rqdata.init_progress_reporter.finish()
+                self.state = runQueueRunInit
+            else:
+                logger.info('Executing SetScene Tasks')
+                self.state = runQueueSceneRun
 
         if self.state is runQueueSceneRun:
             retval = self.rqexe.sq_execute()
@@ -1461,11 +1473,7 @@ class RunQueue:
                 self.state = runQueueComplete
 
         if self.state is runQueueRunInit:
-            # Just in case we didn't setscene
-            self.rqdata.init_progress_reporter.finish()
             logger.info("Executing RunQueue Tasks")
-            if not self.rqexe:
-                self.rqexe = RunQueueExecute(self)
             start_runqueue_tasks(self.rqexe)
             self.state = runQueueRunning
 
@@ -1690,7 +1698,7 @@ def process_setscene_whitelist(rq, rqdata, stampcache, sched, rqex):
     def check_norun_task(tid, showerror=False):
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
         # Ignore covered tasks
-        if tid in rq.scenequeue_covered:
+        if tid in rqex.scenequeue_covered:
             return False
         # Ignore stamped tasks
         if rq.check_stamp_task(tid, taskname, cache=stampcache):
@@ -1765,6 +1773,24 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        self.scenequeue_covered = set()
+        self.scenequeue_notcovered = set()
+        self.scenequeue_notneeded = set()
+
+        if len(self.rqdata.runq_setscene_tids) > 0:
+            self.sqdata = SQData()
+            build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
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
     def runqueue_process_waitpid(self, task, status):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
@@ -1937,7 +1963,7 @@ class RunQueueExecute:
         if task is not None:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
 
-            if task in self.rq.scenequeue_covered:
+            if task in self.scenequeue_covered:
                 logger.debug(2, "Setscene covered task %s", task)
                 self.task_skip(task, "covered")
                 return True
@@ -2194,10 +2220,7 @@ class RunQueueExecute:
         #        revdeps = self.sqdata.sq_revdeps[tid]
         #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
 
-        self.rq.scenequeue_covered = self.scenequeue_covered
-        self.rq.scenequeue_notcovered = self.scenequeue_notcovered
-
-        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.rq.scenequeue_covered)))
+        logger.debug(1, 'We can skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
         self.rq.state = runQueueRunInit
 
@@ -2479,29 +2502,28 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqdata.outrightfail.append(tid)
 
 def start_runqueue_tasks(rqexec):
-
         # Mark initial buildable tasks
         for tid in rqexec.rqdata.runtaskentries:
             if len(rqexec.rqdata.runtaskentries[tid].depends) == 0:
                 rqexec.runq_buildable.add(tid)
-            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.rq.scenequeue_covered):
-                rqexec.rq.scenequeue_covered.add(tid)
+            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.scenequeue_covered):
+                rqexec.scenequeue_covered.add(tid)
 
         found = True
         while found:
             found = False
             for tid in rqexec.rqdata.runtaskentries:
-                if tid in rqexec.rq.scenequeue_covered:
+                if tid in rqexec.scenequeue_covered:
                     continue
                 logger.debug(1, 'Considering %s: %s' % (tid, str(rqexec.rqdata.runtaskentries[tid].revdeps)))
 
-                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.rq.scenequeue_covered):
-                    if tid in rqexec.rq.scenequeue_notcovered:
+                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.scenequeue_covered):
+                    if tid in rqexec.scenequeue_notcovered:
                         continue
                     found = True
-                    rqexec.rq.scenequeue_covered.add(tid)
+                    rqexec.scenequeue_covered.add(tid)
 
-        logger.debug(1, 'Skip list %s', sorted(rqexec.rq.scenequeue_covered))
+        logger.debug(1, 'Skip list %s', sorted(rqexec.scenequeue_covered))
 
         for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
@@ -2514,35 +2536,8 @@ def start_runqueue_tasks(rqexec):
                     target_pairs.append((fn, taskname))
 
             event.fire(bb.event.StampUpdate(target_pairs, rqexec.rqdata.dataCaches[mc].stamp), rqexec.cfgData)
+        rqexec.sched.initbuildable()
 
-        schedulers = rqexec.get_schedulers()
-        for scheduler in schedulers:
-            if rqexec.scheduler == scheduler.name:
-                rqexec.sched = scheduler(rqexec, rqexec.rqdata)
-                logger.debug(1, "Using runqueue scheduler '%s'", scheduler.name)
-                break
-        else:
-            bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
-                     (rqexec.scheduler, ", ".join(obj.name for obj in schedulers)))
-
-def start_scenequeue_tasks(rqexec):
-        rqexec.scenequeue_covered = set()
-        rqexec.scenequeue_notcovered = set()
-        rqexec.scenequeue_notneeded = set()
-
-        # If we don't have any setscene functions, skip this step
-        if len(rqexec.rqdata.runq_setscene_tids) == 0:
-            rqexec.rq.scenequeue_covered = set()
-            rqexec.rq.scenequeue_notcovered = set()
-            rqexec.rq.state = runQueueRunInit
-            return
-
-        rqexec.sqdata = SQData()
-        build_scenequeue_data(rqexec.sqdata, rqexec.rqdata, rqexec.rq, rqexec.cooker, rqexec.stampcache, rqexec)
-
-        logger.info('Executing SetScene Tasks')
-
-        rqexec.rq.state = runQueueSceneRun
 
 class TaskFailure(Exception):
     """
-- 
2.20.1


