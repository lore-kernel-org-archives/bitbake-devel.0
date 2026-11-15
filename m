Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5872.1794742430001758845
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Nov 2026 03:33:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lgtFkinF;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D7ED1A1672
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C36160238
	for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C06B11BC1864;
	Sun, 15 Nov 2026 12:33:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794742427; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=U/cujteS6aPTmq+pXpC8plHFWbmbQHOulknXQEPWVVE=;
	b=lgtFkinFgQ2JXPtV3WZdDkVxTTTNpcK54BhFWXODIZBVcxDbFeFF5VCsz4L1Ncte1cqb6u
	nQHiDCCTYK+f6DwQ8yHR7u98UkyTZ4PlK4AoLl7yj2NICBO5gB+hBUh/iEKt4kNBFofaSV
	GeispuM5yaTvnkzmFd5rJXNqPs7B47oK9jBAPXiVVO9Ppp1GGgEchJXuZ/3vQdC7WDa9pC
	BiTFKTUMqK7fF8871Js9Y2Dt8zswl1pH74X1LKl2b0Ry2uRJ6DkDKxE39aPhL/D2jsuZce
	JNKqC7pWRjjQ5l01epc71QZjRgRGtsGgLLnKu+kllj8gCFODyB8wNOzjoSLUEQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 15 Nov 2026 12:33:41 +0100
Subject: [PATCH RFC v2 3/3] runqueue: Hand each covered task's log to a
 single setscene task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mathieu-debug-replay-v4-v2-3-ad7d3c5cc213@bootlin.com>
References: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
In-Reply-To: <20261115-mathieu-debug-replay-v4-v2-0-ad7d3c5cc213@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794742425; l=3174;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=WRk2l9urlrfG6XYZN456L0iRLr8CIMScVRk8Z5BWgl8=;
 b=hvhW8GoV5ybgW6qpPILYb3QwQ/eZXc6/aS89nqnfir8azPc/NgL60ErYxYgsLjB46JnRIvn00
 eQGf6cxbwfBDdJIRGr9Rvim30Js0j8k9zRi+vqssrrA1EFkoWPDBbNw
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sun, 15 Nov 2026 11:33:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20436

When a setscene task starts, hand it the covered tasks of any recipe
which were not yet handed to another setscene task, and pass their tids
to the task through BB_SETSCENE_CLAIMED_TASKS. Several setscene tasks
can cover the same task (e.g. do_populate_sysroot and do_package both
cover do_compile), so this lets metadata replay the log of each covered
task exactly once when restoring it from the sstate cache.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 bin/bitbake-worker |  1 +
 lib/bb/runqueue.py | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 61484a5c2522..8e0ff1a4f2c4 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,6 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
+                the_data.setVar("BB_SETSCENE_CLAIMED_TASKS", " ".join(runtask.get('claimedtasks', [])))
                 the_data.setVar('BB_CURRENTTASK', taskname.replace("do_", ""))
                 if cfg.limited_deps:
                     the_data.setVar("BB_LIMITEDDEPS", "1")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46bf95..84ad41da12eb 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1939,6 +1939,8 @@ class RunQueueExecute:
         self.scenequeue_notcovered = set()
         self.tasks_notcovered = set()
         self.scenequeue_notneeded = set()
+        # Covered tasks already handed to a setscene task for log replay
+        self.sq_replay_assigned = set()
 
         self.setscene_tids_generator = None
 
@@ -2297,6 +2299,14 @@ class RunQueueExecute:
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
+            # Each covered task of any recipe is claimed by exactly one setscene
+            # task across the build, so its log is replayed only once. Tasks
+            # explicitly requested as targets run natively, so don't replay them.
+            claimedtasks = (self.sqdata.sq_covered_tasks[task]
+                            - self.sq_replay_assigned
+                            - self.sqdata.cantskip)
+            self.sq_replay_assigned |= claimedtasks
+
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             realfn = bb.cache.virtualfn2realfn(taskfn)[0]
             runtask = {
@@ -2305,6 +2315,7 @@ class RunQueueExecute:
                 'taskname' : taskname,
                 'taskhash' : self.rqdata.get_task_hash(task),
                 'unihash' : self.rqdata.get_task_unihash(task),
+                'claimedtasks' : sorted(claimedtasks),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
                 'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],

-- 
2.47.3

