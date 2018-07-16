Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail.openembedded.org (Postfix) with ESMTP id A32F378870;
	Mon, 16 Jul 2018 20:38:07 +0000 (UTC)
Received: by mail-it0-f52.google.com with SMTP id 188-v6so23421216ita.5;
	Mon, 16 Jul 2018 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=n9cdZUm5yHaKvll9kGcfuvsSw23Kkku3aonqt7afep4=;
	b=q9gB1PjF1FVIM9qPdY+sYVFZ95HQTOk7zF5ovnvcDlGOQNTdfqqexzHkUwoO1MnwRy
	+7BZECyhSXLhDeY9AhPhkX8NjwskQVrsLVIBdMzwVnjVmvrmdNtsCKL6LG51rkKGB/QY
	MkkX5w+uWfIYyTetPMjeu7XvDoYGU22myW1+6xSsMbiwiv7qdP2mvHGrSWZZiMEk4vPU
	oRhSa99mJUmyJgZCZRx20+8cdde8rWmp9FEP3vO63rZEgz9z0MurP3XorvZH0FrvySmW
	+Vx9fB3itNBGD+f8BkDVWLUdCzO06emiijkjIwJT7MZivGyYDuAOXeqYYeYCLhgGgK+D
	/myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=n9cdZUm5yHaKvll9kGcfuvsSw23Kkku3aonqt7afep4=;
	b=Oh1ICKYzYveA1+T9n/k3irVDepIJGz9ZBHCilHezI+a7Sa5HRBecoQ0CCs4b0fMR9M
	DbJnCGT6+6djDBR4KbKDtXkEfkNc4t3egH6vhaZj82mys0YUp9gin9stOC9yG4bRhpPJ
	tQwupVV1/t+G/C6rH6XQAoc4MsteQiq/ibLSP9H8L9FC3LcjJpJelW1ZUqYo0cnajC/O
	uP05s0lO73MW92Xfv2OlLvH0sZhN9ZXpvnWfvUoiHhb6SB3onOItni0YLrCWX6kmDDzV
	xQ6qeLYspfXWIg6OpyfkKDFjmdZQgMBczIy4xydIEU5DYlZ10D8FRs6LNjd35s4tKfZK
	OONg==
X-Gm-Message-State: AOUpUlG5IL94kKAFLL0eUBYamvo/P41QZAcslpDe3P8KP+3JZNK890W9
	2eYWbqYs9+BSQ1BZu33w3UwpXzoa
X-Google-Smtp-Source: AAOMgpcwwoYIuH6PVbkMVVbN/sH/k7EywHQNR6PqeUT1o2GKxpMtMZG826L7OpPljFRg3NyyKlDd5w==
X-Received: by 2002:a24:ddd3:: with SMTP id
	t202-v6mr13394912itf.91.1531773488648; 
	Mon, 16 Jul 2018 13:38:08 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:24 -0500
Message-Id: <20180716203728.23078-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 5/9] runqueue: Pass dependency ID to task
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:07 -0000

The dependency ID is now passed to the task in the BB_DEPID variable

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  7 ++++---
 bitbake/lib/bb/runqueue.py | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index cd687e6e433..37cbcdb369a 100755
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
index 97cc8a948af..5922431bbe1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2011,6 +2011,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
+            depid = self.rqdata.get_task_depid(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2020,10 +2021,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
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
@@ -2433,13 +2434,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
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


