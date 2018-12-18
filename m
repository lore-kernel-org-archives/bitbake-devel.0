Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f194.google.com (mail-it1-f194.google.com
	[209.85.166.194])
	by mail.openembedded.org (Postfix) with ESMTP id 5C1117C04B;
	Tue, 18 Dec 2018 15:31:16 +0000 (UTC)
Received: by mail-it1-f194.google.com with SMTP id x124so8524360itd.1;
	Tue, 18 Dec 2018 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=NLvfXcDM6A8chacW0MmtbQ4la3gZyzGbxNIqbLDYMcE=;
	b=Jeg1/KZ8rTGAcs6q1yYPukfwZ8v4OvbWk4aozwuoeIbK//ZyHhe7FqCEeAy9e+RnZ7
	6PwGFtWSB7HUKo/jICvdknCmHZm8wAYyxdzoiVkY2s/d5gzrAjfbk4ca3Jo0QoFi9nbB
	yV1Y7mvmVfXX43Chsnpqlv1X5A5xPOKpHAQCVZG1ohuCnxVNPmotdEYrQlr/NMI7FF/+
	eZA2QyriA8gfnJYCWJm9BG8pmPygKAq6feB/M/0lTk8U3DJ5dSjrOT6glc46sOBxTv8w
	ttXT85ksdAfZlqz+B3wHOon/Kg4Ry4HqGETxpe7fpgFJOGY63dqFyZV5dLUtOj95dkuc
	hF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NLvfXcDM6A8chacW0MmtbQ4la3gZyzGbxNIqbLDYMcE=;
	b=kqNUNV9JJrb/ESd4X8kOMrScJ4BpDHYVwlMMxhytMJqqBQxJwKEnFgPTyovZ323uBA
	rNsLGPxzYotqWRDwZSQtVXuDSjJLNL66l+23bZbfAIBze+mjWJGoKKORthcfppwRvOwG
	OyAd2pPhecaauyXdNTS1DL/dSfJdO1BuJPROfzoszjj6svSg68wOG0dC0XWEgedYfv5S
	kMi0UlNZoTs1T05Pr+ToFkKD5Y5A0yuuS0DMsnkUNjqCk5C4VRj3lMTAlBcifUQ2I2Zq
	VPCScriRGzJzCuBn3GqMAwaV0GzHYZNYMcLGvkpNnRZ4hF5puK13UAoQUmB5tDCK6wOy
	xJOQ==
X-Gm-Message-State: AA+aEWbml4yqHy8DtqpDIJAX4H/v3WeDycx1s9xoFbYuVlKPNSr5U+jV
	JGK2kUC15hP+2jxVz+juVjOSW1JW
X-Google-Smtp-Source: AFSGD/Wye4X4WUpWYSzM4gVdlK0ZJI4a5ES6DWCwIPkX5/La/JPXcJzZPW04YOVzGp4+K8tinrF/6Q==
X-Received: by 2002:a24:2912:: with SMTP id p18mr3259733itp.16.1545147075992; 
	Tue, 18 Dec 2018 07:31:15 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:15 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:57 -0600
Message-Id: <20181218153101.9212-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 06/10] bitbake: runqueue: Pass unique hash to task
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:16 -0000
Content-Transfer-Encoding: 8bit

The unique hash is now passed to the task in the BB_UNIHASH variable

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  7 ++++---
 bitbake/lib/bb/runqueue.py | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 41ef6d848ac..7b1884a7f88 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -136,7 +136,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
+def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -235,6 +235,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
 
                 the_data = bb_cache.loadDataFull(fn, appends)
                 the_data.setVar('BB_TASKHASH', taskhash)
+                the_data.setVar('BB_UNIHASH', unihash)
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
@@ -425,10 +426,10 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, taskhash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
+        fn, task, taskname, taskhash, unihash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 27b188256dd..de57dcb37b8 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2034,6 +2034,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
+            unihash = self.rqdata.get_task_unihash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2043,10 +2044,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2462,13 +2463,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             taskhash = self.rqdata.get_task_hash(task)
+            unihash = self.rqdata.get_task_unihash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
-- 
2.19.2


