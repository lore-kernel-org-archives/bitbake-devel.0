Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id C663C78E83;
	Thu,  9 Aug 2018 22:10:49 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id h20-v6so156037itf.2;
	Thu, 09 Aug 2018 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=LOK3KL+h7rbgepHfdcTl1FpcFJG2pe+LahcEXgHoW9k=;
	b=HUETPcqeTe9i6C29oLum/wRvoKKeEZqQ3NHcJf++sCZUe5Ozs/khhIEppTi8rkQT5m
	nE3UP+cJuqunyiE8JF83vthTRT62l5ZbakaNy+bAyhBYq/OzJG3bx5EY22/itQTOdzxl
	IMElVhjXn/dEdit2a4l0QyQaSN6mw7J13zUp4SAT9BwP7XM6Mhz+kHur4NOfwaOrGdwd
	M51nS92kPP09sbMxApd52WvmJTyVuDcdCk1+KQw9tSYYW9Q+hnB+Zizpzg/30mZAK9HD
	oSss5vRZOxtozUZmbeOHcsG9schR91JPwbElUmd3q4xQAVK6X1/7AXJLJDTBkkTdEAyC
	eZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=LOK3KL+h7rbgepHfdcTl1FpcFJG2pe+LahcEXgHoW9k=;
	b=f6YGtF0yT26eGs73mkpf1u+1zXDFRg5ULh5seqaD3wrwsJvfKrOEIfCavRtug0JikY
	6cNplIkD4cMCyUpZfdmcFtGJuwMgwIEOnw3m03P86KQXiE+Y7tiBMTH0twhYYZskYuNP
	a3vugDbOtz9aezK1Wvsl90ANdUvlRnzcI+ziG8GeOAlE5RUfhc/AzVVtoosBvzJflZWO
	NXvwMbNgze5ZdHBY471c1VMootvWD93MVeAIhJMzx7xjy5EabltYp36M1RITtyATIcG8
	VAWIS8vYb/kpnkJqsm9ydAac3N/8sO+DTqzSoVQrCAoxezyFVXKw+PYPU6KqcJjLtpqq
	dhug==
X-Gm-Message-State: AOUpUlGA82X/zrPfknMGO+ujNJcshfdYdzlrXGCwZ5eB8IAR6FD55HnK
	mnOdl72ECXtVDtzXc0Hsn52WR7jZ
X-Google-Smtp-Source: AA+uWPyMs8DfPK/ueUEO7BoeeNiR2H0h/Oj8uydUzkqh9gkdSs4KP07T0991C175++pg4TyrcRoyRw==
X-Received: by 2002:a02:3d58:: with SMTP id
	n85-v6mr3403954jan.99.1533852650704; 
	Thu, 09 Aug 2018 15:10:50 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:32 -0500
Message-Id: <20180809220840.26697-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 08/16] bitbake: bitbake-worker: Pass taskhash as runtask parameter
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:50 -0000

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
index 400709c1601..b173cc0a951 100644
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
@@ -2025,6 +2020,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            taskhash = self.rqdata.get_task_hash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2034,10 +2030,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
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
@@ -2450,13 +2446,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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


