Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3670E7BDB7;
	Wed, 19 Dec 2018 03:10:41 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id m19so14488378ioh.3;
	Tue, 18 Dec 2018 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=BeSaMtwf+vdgiAIIz0HsX+3ga+UxPl4xz3DL7Z/cr/M=;
	b=u1Rob9VCbMw+Z0atQGmq9U0r2RpCBbi3DeROhUmO2CCuFCnjx9pht14wpkMnQb7+Zn
	yMwNLv23vSb6UYzCZ/81UA6+Uw7eEtDvraidmqUwW3YbE6sAoF2dLvXYazEouYTkYPlY
	vZLVhbdr6NuuJAiENXdQJrNL8Y/8A3/nfYTcHcB89Z4iTGft6j1jLQ4zMIx2/vcJvaQt
	7RbMwrSKEp3iCEJpeAqaPVQTqhZkhe5GiArpAnZTiRrRCic0LdjNFFIsdzQwk81gWbKB
	LRgjBtX5J2XzGATNTDcybxxpwe2N42reH9EaKNfGw5/kjk701DBSvZl1NXyXowY2TR0p
	M77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=BeSaMtwf+vdgiAIIz0HsX+3ga+UxPl4xz3DL7Z/cr/M=;
	b=OYBqUxNQj02lzkeGU50w7DuR6PGfZMyHh3Gl6tE7FLJSszQxQ79hi2LdJLND53IEth
	sh8A873eFnr69LuaRhDoc3VL3ICYfdXtNdaxer84lM1t+JU9pWjsOIwiw5q+KVwqI1hb
	mYUOnI1sOunMKGPSQz/lg3KPesOmCd6iSRGzaRz+l54h2Hr4BpKO1gIozr8r3V/VV0EU
	/lqqhatF/MX9hzNkZ5D1bV5kaKu2iQ8wpiplr8agQnZf1WYk6CjrEWajyuN887OY3bZC
	NLSz+WtyTe0JfoI2qIywfF1vI0b0J2ITUN+bMJNxtY1K5tKBscs0ieLQYoIh0eGWXNmW
	un3Q==
X-Gm-Message-State: AA+aEWZor77uAmayJFHn0Jf2h0q/XWX13Z5dmTRrVcWfpin9mmiSDiNd
	hAwWuZy/py4xWfB8vOPO+1j7vcmB
X-Google-Smtp-Source: AFSGD/WUe3uRf6Mi+tEcbqF2RC/AkRk6ZzCfU5YLODZtyurpGHpfTXyZxPsF8MqqQ7C/lwvl9iwh2A==
X-Received: by 2002:a5d:959a:: with SMTP id a26mr16670072ioo.278.1545189042090;
	Tue, 18 Dec 2018 19:10:42 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.41
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:41 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:29 -0600
Message-Id: <20181219031033.28045-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 4/8] bitbake: runqueue: Pass unique hash to task
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:41 -0000
Content-Transfer-Encoding: 8bit

The unique hash is now passed to the task in the BB_UNIHASH variable

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker |  7 ++++---
 bitbake/lib/bb/runqueue.py | 10 ++++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index cd687e6e433..a9e997e1f63 100755
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


