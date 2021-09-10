Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.13636.1631300355587850104
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 11:59:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fvquyGQX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id d6so3987805wrc.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zYCjfG/8H0ECJZd+ksLlxCliVYM2mC9N0NYdu9vEh4=;
        b=fvquyGQXDNqrpu8JWUSDmC8waLxOcHGRxSNF1ayFdTI9MczlTxsrPyMPyXAU1YhSvX
         Eqq+q6HROEAZr2J6hNvdjoy/1abV3fg8LDxM0E9ZdfyO+gwDpBcq2XMe7H7f2KZa+Aou
         BkzcVoUTy/DTK59Nqj1RdpnbE8S7+v7A6EY+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zYCjfG/8H0ECJZd+ksLlxCliVYM2mC9N0NYdu9vEh4=;
        b=jvnPHf8t51eeouQt6/cseRGrSnGGyfaqJHBVWDDUp+PiQksvj8pGjkfvkC5hsJnJt9
         5S2DEugcLWgR30JK+MOlaNcRtpSTT9+Izeid7oIrzWxLc6qrlWg/69+Cn6AMSrb491l+
         +4IV0JYEeNKO3enVIR1Dd+z3GrNyCXrxTGuVzO3umExGmDZ5Lsmr3LkphjednH6kWKGq
         Rqd1JUq6ixjfb6OuCOUg+BDRLtN6tpN2klf8sGBVffBG4VtNOFayfRH2G1Gr49qrxczt
         dcthrLvB+L3DvhuIDeOJJo/NWjy5moPYKbsui1z6IeGzbRje5ZUpVKvTxUIBWe1tnT2r
         9lJA==
X-Gm-Message-State: AOAM531I7H6ZVBk0zyEcOr7dz16J1b5YOnpvrOi9f4M5GIMk3NAf35dT
	jcxiQClEQDIJhDqV/yoyxx5mb75F74TsOw==
X-Google-Smtp-Source: ABdhPJw8Cp+XdF4d8t5FoUNiFMMgZqsKt7R7MEnFeLlr1Wghc9ZVXjzOq5X/JlJKfn09SZr25ckmfw==
X-Received: by 2002:adf:e408:: with SMTP id g8mr2895425wrm.138.1631300353837;
        Fri, 10 Sep 2021 11:59:13 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.config (5751ab90.skybroadband.com. [87.81.171.144])
        by smtp.gmail.com with ESMTPSA id i27sm4932443wmb.40.2021.09.10.11.59.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:59:13 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Clean up task stats handling
Date: Fri, 10 Sep 2021 19:59:12 +0100
Message-Id: <20210910185912.1267679-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 lib/bb/runqueue.py    | 22 +++++++---------------
 lib/bb/ui/uihelper.py |  2 +-
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5ccf755f1a..6ce0ce80f6 100644
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
index 48d808ae28..40c7c5a5ef 100644
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
2.32.0

