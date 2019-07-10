Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 73F907F010
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:28 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id p17so4197711wrf.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ArbwX4gXGeQuK9W7CD4lOqbP4YLPSJr6YE/3US4qnns=;
	b=WSs1fq7R75NcnN5ZAsa5qU9p9N9hmyLjfv7rJlOW2tNxNNSGZyXpIRcCQqJZeCxRbT
	m3ol+XPL2E18uxs2FfjqfCv1xgh2cIeYHUc1/3sUvzS9Wcpy8VkQJMsA/baTxmBRSGQe
	7oeN3fl32bbfmrELxj1ypaeCQUNejAa7u7YR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ArbwX4gXGeQuK9W7CD4lOqbP4YLPSJr6YE/3US4qnns=;
	b=kUwKFA4jAojAsAxUCr4W+jjDKouSK/rs8iMJyAPjPSGC4ysyJHS83uPlPN6DdDEEjL
	K/wZ4hDNSIzm3bCNhhDxQe8Srmtm3kWccPLHvC967GJR1xptmY+FO2vv3eO4kvn7QlV/
	iaO6Gt7wxurXVOb885y+6dg17WTwn4yCPEo4JcPuKccCfw50p8tRm3wriqzgWcUF1Sa5
	goY6KtubXFp9hqU7tqJ4FLzywI7xkqD6cE5bIrBk2s1fB0jMNl4/rztLl+ivwPP5T7PO
	5oJV6CjqGdYp3WMKZgZ5/ZmhkSjb0NQeOUCVPlj3ukssSHh2Pm7oekuD7VG6KIb6QNVB
	Te1A==
X-Gm-Message-State: APjAAAXvkR3m6cTsavHH0L52RzD3FL7y+3GMmBBhPMRTMHQ8EWlj8NwF
	PNG2QY2Y4p/XyOKjVdBwi6wPxkv+d3I=
X-Google-Smtp-Source: APXvYqw7L6FPxpWTCVcklRUkxahFq+3nPeb2GAyPRBmz2ZWrInDSJEe23Cilx8gof68hZt0Yv07huw==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr220193wrv.19.1562802869119;
	Wed, 10 Jul 2019 16:54:29 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.27
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:02 +0100
Message-Id: <20190710235420.23825-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 08/26] runqueue: Merge stats handling together for setscene/real tasks
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

Use a seperate stats class for scenequeue tasks and move the setup
into the base class. Update references accordingly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c512920a6d..7de27ec315 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1748,6 +1748,9 @@ class RunQueueExecute:
 
         self.stampcache = {}
 
+        self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
+        self.sq_stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
+
         for mc in rq.worker:
             rq.worker[mc].pipe.setrunqueueexec(self)
         for mc in rq.fakeworker:
@@ -1802,8 +1805,9 @@ class RunQueueExecute:
     def finish(self):
         self.rq.state = runQueueCleanUp
 
-        if self.stats.active > 0:
-            bb.event.fire(runQueueExitWait(self.stats.active), self.cfgData)
+        active = self.stats.active + self.sq_stats.active
+        if active > 0:
+            bb.event.fire(runQueueExitWait(active), self.cfgData)
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -1831,7 +1835,8 @@ class RunQueueExecute:
         return valid
 
     def can_start_task(self):
-        can_start = self.stats.active < self.number_tasks
+        active = self.stats.active + self.sq_stats.active
+        can_start = active < self.number_tasks
         return can_start
 
 class RunQueueExecuteDummy(RunQueueExecute):
@@ -1847,8 +1852,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
     def __init__(self, rq):
         RunQueueExecute.__init__(self, rq)
 
-        self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
-
         self.stampcache = {}
 
         # Mark initial buildable tasks
@@ -2347,8 +2350,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             rq.state = runQueueRunInit
             return
 
-        self.stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
-
         self.sqdata = SQData()
         build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
@@ -2390,13 +2391,13 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.rq.state = runQueueCleanUp
 
     def sq_task_complete(self, task):
-        self.stats.taskCompleted()
-        bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
+        self.sq_stats.taskCompleted()
+        bb.event.fire(sceneQueueTaskCompleted(task, self.sq_stats, self.rq), self.cfgData)
         self.sq_task_completeoutright(task)
 
     def sq_task_fail(self, task, result):
-        self.stats.taskFailed()
-        bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
+        self.sq_stats.taskFailed()
+        bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
@@ -2404,8 +2405,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
     def sq_task_failoutright(self, task):
         self.sq_running.add(task)
         self.sq_buildable.add(task)
-        self.stats.taskSkipped()
-        self.stats.taskCompleted()
+        self.sq_stats.taskSkipped()
+        self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
@@ -2413,8 +2414,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.sq_running.add(task)
         self.sq_buildable.add(task)
         self.sq_task_completeoutright(task)
-        self.stats.taskSkipped()
-        self.stats.taskCompleted()
+        self.sq_stats.taskSkipped()
+        self.sq_stats.taskCompleted()
 
     def sq_execute(self):
         """
@@ -2469,7 +2470,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.sq_task_failoutright(task)
                 return True
 
-            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
+            startevent = sceneQueueTaskStarted(task, self.sq_stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
             taskdepdata = self.sq_build_taskdepdata(task)
@@ -2490,11 +2491,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.build_stamps2.append(self.build_stamps[task])
             self.sq_running.add(task)
             self.sq_live.add(task)
-            self.stats.taskActive()
+            self.sq_stats.taskActive()
             if self.can_start_task():
                 return True
 
-        if self.stats.active > 0:
+        if self.sq_stats.active > 0:
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -2511,7 +2512,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         self.rq.state = runQueueRunInit
 
-        completeevent = sceneQueueComplete(self.stats, self.rq)
+        completeevent = sceneQueueComplete(self.sq_stats, self.rq)
         bb.event.fire(completeevent, self.cfgData)
 
         return True
-- 
2.20.1


