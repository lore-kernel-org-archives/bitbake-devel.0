Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id DBCAD78E90;
	Thu,  9 Aug 2018 22:10:52 +0000 (UTC)
Received: by mail-io0-f169.google.com with SMTP id l7-v6so6109790ioj.1;
	Thu, 09 Aug 2018 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=PiJalsKjdFq0FgqjxbwNfbwWKOEz0HCLzqa4psguAeI=;
	b=kkBfzzz8w7knJqtKYkacgz0SuFc+8BXTmvpNTHTSgusqrcrtso5yBwQD5eU8k42mRv
	2pWzeno+6k70UyZWx/PO56cvOmnfGLgorewHiLTE1prO/GtInvF1dWZeweCZ1fYmieUL
	IRwhOH85PwsjmoZjJ/LkTcvQYV4lBFQK6dFb/OJjr7T0AWJA1Ovw/2ng04wgrgPWDjt6
	q593RsbjAXNO75762y3Nsi5k+4Jtbs//tu9YH4STYU3bx91m5pwSCQb527R2VfhvjwsO
	1wnX0DvsS8kg70JIhGFF+cGitiQfYyjl9Tfv3AmzdiBH2Kj9R31nVL6n3Q1ZoiZPlPE2
	U9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=PiJalsKjdFq0FgqjxbwNfbwWKOEz0HCLzqa4psguAeI=;
	b=NSG2OEoDmSCnZ8ZBqkFrSWNwZ7BJKS+ud/48plUTm53fokHWQHp3fBsopxIpVnjqn3
	GOFNNITx/9PGOxjv2rqak3Ais7aRqxssbAEtsyR0rLbVlBNrnuT5QfqHzjeaF1ugj9WE
	TiSO4s7i/y6oMqmDoUV+KTF/6fTs9KqYzzkHzNh6+ikN2ReGPm+2a6zdWcrXLxKXjyKB
	mpHHZBbZX0i2UghES1gPkmMD6YSonrNP3eBcb07WPomS5MGnQAu6cion6w8qX23wvuLc
	QnqRVPWAEH2pG8yfmZWYXt649FcKevdMzrxE4mAT3oEwSFrJq4WqtumS56kQfl2GNb9D
	dkHA==
X-Gm-Message-State: AOUpUlHjNaV2cJyFw7ID7NiJnQllLL7tB2B2jUgM8pHtkN+OUspcv97K
	xGDmEv+b9uT2orF/bFGCWQxxDFYf
X-Google-Smtp-Source: AA+uWPxHZdwg2+baMDRaFleY/7rnfyoafD53UA6Xp8jfEd2ZngQQJ5wSe15SfLtr9yGDKjnyhsZu4A==
X-Received: by 2002:a6b:c744:: with SMTP id
	x65-v6mr3340748iof.208.1533852653749; 
	Thu, 09 Aug 2018 15:10:53 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:36 -0500
Message-Id: <20180809220840.26697-13-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 12/16] bitbake: runqueue: Pass dependency ID to task
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:53 -0000

The dependency ID is now passed to the task in the BB_DEPID variable

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  7 ++++---
 bitbake/lib/bb/runqueue.py | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 41ef6d848ac..9650c954359 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -136,7 +136,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
+def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, depid, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -235,6 +235,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
                 the_data = bb_cache.loadDataFull(fn, appends)
                 the_data.setVar('BB_TASKHASH', taskhash)
+                the_data.setVar('BB_DEPID', depid)
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
@@ -425,10 +426,10 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, taskhash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
+        fn, task, taskname, taskhash, depid, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, depid, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3ae12d8e69f..909fa3aec22 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2028,6 +2028,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
+            depid = self.rqdata.get_task_depid(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2037,10 +2038,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, depid, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, depid, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2455,13 +2456,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
+            depid = self.rqdata.get_task_depid(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, depid, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, depid, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
-- 
2.17.1


