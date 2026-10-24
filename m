Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5424.1792845245570256248
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 24 Oct 2026 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=weI9x5dH;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E24FF1A1317
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B80C560769
	for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0347A1032902C;
	Sat, 24 Oct 2026 14:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792845243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+KLpa4IXHQLvBptLW9hu9SJ9MUs9VGgXXsywQeuQD2Y=;
	b=weI9x5dHrQulfjp62dtQT3FnwQEjqdD9wqXd523uPVVyL8Jrx1AlTQLIwnSInN9p0csNop
	vmcZxJEplMs2ajoMcZ9Lmgbu03xOjH2fNlxFb7k9bS9PQkoEIE8ix5RwaoyNDUSiRX1RI3
	wGVxwauGBswNgYWpQnZGpBf1ZruNReKYWu03KOwPtprnCVoAsxFuUQPh1+KZcl1XXhGNfk
	ZY6VCncVRx39u1ubVMesuE8A6Eo9WEurMAlMt+XRaM2PuyAUK3OX79+s7r21+JfFQMVQiH
	yiFL9njipps2UYwtqdBB/K2gkUU4AG+rrA9IOpuG7Pq6GfU+WcamlVzbxD2Pcw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sat, 24 Oct 2026 14:33:34 +0200
Subject: [PATCH RFC 3/3] runqueue: Hand each covered task's log to a single
 setscene task
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-mathieu-debug-replay-v4-v1-3-3f7f52a3b8e6@bootlin.com>
References: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
In-Reply-To: <20261024-mathieu-debug-replay-v4-v1-0-3f7f52a3b8e6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792845239; l=3079;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=/jp3DSDXTwmpUy5ISVhbFiy/CGC2vA5VmpD6YQqIWhI=;
 b=Av1SO2FqyxJy21AlCCBmY/I1rNC5j5ATKX6V8zkwJUR42DGDMMrUu4thuPd85i7Q5YsKn4Lw2
 H/hQmnP6GNxAy6is1VZkIgZmfk7m9rK5YsXU6GVE169TFIzcpGu0LEI
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Sat, 24 Oct 2026 12:34:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20374

When a setscene task starts, hand it the covered tasks of the same recipe
which were not yet handed to another setscene task, and pass their names
to the task through BB_SETSCENE_REPLAY_TASKS. Several setscene tasks can
cover the same task (e.g. do_populate_sysroot and do_package both cover
do_compile), so this lets metadata replay the log of each covered task
exactly once when restoring it from the sstate cache.

AI-Generated: Uses opencode (DeepSeek V4 Flash)
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 bin/bitbake-worker | 1 +
 lib/bb/runqueue.py | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 61484a5c2522..0a46eea3ccb5 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,6 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
                 the_data = databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
+                the_data.setVar("BB_SETSCENE_REPLAY_TASKS", " ".join(runtask.get('replaytasks', [])))
                 the_data.setVar('BB_CURRENTTASK', taskname.replace("do_", ""))
                 if cfg.limited_deps:
                     the_data.setVar("BB_LIMITEDDEPS", "1")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ef95eb46bf95..8bb1cb1a6e72 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1939,6 +1939,8 @@ class RunQueueExecute:
         self.scenequeue_notcovered = set()
         self.tasks_notcovered = set()
         self.scenequeue_notneeded = set()
+        # Covered tasks already handed to a setscene task for log replay
+        self.sq_replay_assigned = set()
 
         self.setscene_tids_generator = None
 
@@ -2297,6 +2299,12 @@ class RunQueueExecute:
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
+            # Each covered task of this recipe is assigned to exactly one
+            # setscene task, so its log is replayed only once.
+            replaytasks = {t for t in self.sqdata.sq_covered_tasks[task]
+                           if fn_from_tid(t) == taskfn} - self.sq_replay_assigned
+            self.sq_replay_assigned |= replaytasks
+
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             realfn = bb.cache.virtualfn2realfn(taskfn)[0]
             runtask = {
@@ -2305,6 +2313,7 @@ class RunQueueExecute:
                 'taskname' : taskname,
                 'taskhash' : self.rqdata.get_task_hash(task),
                 'unihash' : self.rqdata.get_task_unihash(task),
+                'replaytasks' : sorted(taskname_from_tid(t) for t in replaytasks),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
                 'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],

-- 
2.47.3

