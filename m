Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail.openembedded.org (Postfix) with ESMTP id 7BE427600F;
	Mon, 16 Jul 2018 20:38:04 +0000 (UTC)
Received: by mail-it0-f52.google.com with SMTP id j185-v6so23459794ite.1;
	Mon, 16 Jul 2018 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MydlIxSrp7HT1rcgirWLTUptf+mmxeyU62XxWN9Q4kk=;
	b=iHPpAKvSlrAHkhPL0MctbBvQGuzXksfXqBUpq85bLGCDH//PEgjGVPZf3y3eRwH+GU
	TooqGBpkyFvU3eqvKkUZAk/yLIr7gM0rsWRMSiGZZ4ITDirtC3nTcrvBnl0ZX4/w1UaP
	DFG7yE8lxy1tesBRBNiSb6xru5iOKTDkyZF17tZExUYTQrZki+GiKZXbs/QB9nFL2egb
	3UhHRNFvygf5RAgy5Wi36pULGRBizCg3dI0SEUOXvAsgg9VvsczeAwomd468r8ig8B3M
	9ZCNJSOqC0+hrD/iW1aCMH5BalB5fHIYTXYPXZC3E+W3ZdEHgWpBU3OpubknmV/uP3Aq
	IyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MydlIxSrp7HT1rcgirWLTUptf+mmxeyU62XxWN9Q4kk=;
	b=o/J8LBwklDds4Dg8Qy1TOgjcdMlATv/lzVEiA4yKEPTW+HLTNJA76pGZjnrIFW3A0u
	iB0uFGDFI/mHrv1Ak+fwAzt4QbbePXhWiZ9fiBr80RNLKAmlB+fL3aJLi+Sgq1iEym7A
	a8uRTtq4YZ6P5KaKErwolb0HajLLyn+0VazuPUoU54UZAV6dRTxOecz8U58a0VqKGk8T
	csXEUB6+zwD8WlTImggu9flzK5JOGw/NqzZTibYX7Fmou25L99rLYAh8ffU3QLUXM5wx
	TDOMtU/eagTtODj3FXKb0dtc6eVo+GjhrTvrFGVDbmjD1bHz99hM1RIvtmALJ2N8tz28
	JHQw==
X-Gm-Message-State: AOUpUlEWzFzdJMKH+AnVVLyQy4wVRJZzPpYJAZagWOBBD8Gu33B/R3pE
	Ls0UKHNajxpZVVUMw8jjhbAzvGOW
X-Google-Smtp-Source: AAOMgpcpiRsB23Qw0JDCLCJTVAhFtxKavul6EdRuj0j7px1e8BYgR1p29m2uD06GRiaQZTCCenxCKg==
X-Received: by 2002:a02:8895:: with SMTP id
	n21-v6mr15590244jaj.21.1531773485344; 
	Mon, 16 Jul 2018 13:38:05 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:04 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:20 -0500
Message-Id: <20180716203728.23078-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 1/9] bitbake-worker: Pass taskhash as runtask parameter
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:04 -0000

Pass the task hash as a parameter to the 'runtask' message instead of
passing the entire dictionary of hashes when the worker is setup. This
is possible less efficient, but prevents the worker taskhashes from
being out of sync with the runqueue in the event that the taskhashes in
the runqueue change.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  8 ++++----
 bitbake/lib/bb/runqueue.py | 15 ++++++---------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index e925054b7f9..cd687e6e433 100755
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
index ba9bebebcfe..f655614d1ce 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1207,17 +1207,12 @@ class RunQueue:
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
@@ -2008,6 +2003,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            taskhash = self.rqdata.get_task_hash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2017,10 +2013,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
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
@@ -2428,13 +2424,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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
2.17.1


