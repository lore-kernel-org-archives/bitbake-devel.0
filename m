Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com
	[209.85.166.50])
	by mail.openembedded.org (Postfix) with ESMTP id 530B26C520;
	Tue,  4 Dec 2018 03:46:28 +0000 (UTC)
Received: by mail-io1-f50.google.com with SMTP id v10so12370852ios.13;
	Mon, 03 Dec 2018 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=DEjFnYWETxNz97yNXrIuuAPgBfUMsFpRiRJxMR5qvzs=;
	b=OVLMD03x46l6az8qV/B5tLVTIfXMqF4HrVakJBq3GnnfFfHunh8BpBtXtQbt2lB3k/
	8nodFNE73FsxQBaHBM1Zf337HPuhYjPsYHJ1nYmUd13bYqD7vc1d2hBTEST+DQ9jW4QS
	SbL7mXNNySHQhqh1BVZpnKo1yzdUq7DHFld0d1UVKdAccvGzrCqkmruiFtUSxJ7M7SfS
	tNyVZ9Qp6HX03GR9OmcGT8O2dfUzG6pDh9DOyOAJE0lEb1D6iHmNRNpxk1v4BcaFVqVu
	48MpwMc5DQN1RLSLl8HWe0RgpIVnRb5mafRwY9SUmfCu7yiCS5LFILxiY9alNd3lTTPM
	YQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=DEjFnYWETxNz97yNXrIuuAPgBfUMsFpRiRJxMR5qvzs=;
	b=CHY9I0MGoWliGt8nfU16uIxFJ/uMe1FUik6cADV/ikzlPI7MeyR/UwICCDLLNwdQm0
	LA0BnYunoa26J49PEJHbqBRsNHTPF4GTV2QBWNN8mVEnHbyypkal7HO+7+iJ2+7E1I8N
	0v0cxtirIMOnH64ubX3ekR8iGqo59nciPBIfWfIOUl7dBgHK3NVTUhc8hJXqpX4r2xw0
	vhDatHV+SLeSlseGkYPZy8Vfd8ugu7njlZyZNTL++7p2Kj1dAXQcExDxjBNHPr7huait
	pooDJZ4LAx8Ppi/iUZlFj/fsnX3dhKkfPwDqo4BSNoRSCWYKk+pgQ6E9YjGwY2jGYw2h
	HOnQ==
X-Gm-Message-State: AA+aEWai58dz9ZXCiVHNA0hh3ApWp2kI8bcsn82BhaYqfC6hYUwfTtlH
	psqCA0HNxllfNtAmqZX51ZKULz1J75U=
X-Google-Smtp-Source: AFSGD/WoU810obpWR2K3z5PE6H8ENCKpTup7rh/VJpJQrABSg1V5YgZQL71xwGEDq9AHoZKHEhrBsg==
X-Received: by 2002:a6b:6604:: with SMTP id a4mr15956857ioc.10.1543895188835; 
	Mon, 03 Dec 2018 19:46:28 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:28 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:36 -0600
Message-Id: <20181204034245.25461-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 08/17] bitbake: bitbake-worker: Pass taskhash as runtask parameter
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:28 -0000
Content-Transfer-Encoding: 8bit

Pass the task hash as a parameter to the 'runtask' message instead of
passing the entire dictionary of hashes when the worker is setup. This
is possible less efficient, but prevents the worker taskhashes from
being out of sync with the runqueue in the event that the taskhashes in
the runqueue change.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  8 ++++----
 bitbake/lib/bb/runqueue.py | 15 ++++++---------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index baa1a84e6dd..41ef6d848ac 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -136,7 +136,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
+def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -234,7 +234,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                 ret = 0
 
                 the_data = bb_cache.loadDataFull(fn, appends)
-                the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
+                the_data.setVar('BB_TASKHASH', taskhash)
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
@@ -425,10 +425,10 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
+        fn, task, taskname, taskhash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 4d5d8767973..f2b95a9829b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1224,17 +1224,12 @@ class RunQueue:
         bb.utils.nonblockingfd(worker.stdout)
         workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
 
-        runqhash = {}
-        for tid in self.rqdata.runtaskentries:
-            runqhash[tid] = self.rqdata.runtaskentries[tid].hash
-
         workerdata = {
             "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
             "fakerootenv" : self.rqdata.dataCaches[mc].fakerootenv,
             "fakerootdirs" : self.rqdata.dataCaches[mc].fakerootdirs,
             "fakerootnoenv" : self.rqdata.dataCaches[mc].fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
-            "runq_hash" : runqhash,
             "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
             "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
@@ -2031,6 +2026,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            taskhash = self.rqdata.get_task_hash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2040,10 +2036,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2457,13 +2453,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            taskhash = self.rqdata.get_task_hash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
-- 
2.19.1


