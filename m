Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 3E159772E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Dec 2016 18:09:28 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 15 Dec 2016 10:09:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,353,1477983600"; d="scan'208";a="1072495201"
Received: from weipengl-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.182.212])
	by orsmga001.jf.intel.com with ESMTP; 15 Dec 2016 10:09:27 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Dec 2016 07:09:13 +1300
Message-Id: <971801f85cdf460a5f6bc645844cdc08148a885f.1481825296.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481825296.git.paul.eggleton@linux.intel.com>
References: <cover.1481825296.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v3 1/1] runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set
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
X-List-Received-Date: Thu, 15 Dec 2016 18:09:28 -0000

For the purposes BB_SETSCENE_ENFORCE is designed for (in OE, it is used
by the installation process for the extensible SDK), we don't actually
need the whitelisted real tasks to execute - we just need to have them
in the dependency tree so that we get all of the setscene tasks they
depend on to run. Therefore we can actually dry-run those real tasks
i.e. they won't be run (and thus we won't waste a significant amount of
time doing so) and won't be stamped as having run either. We do already
have a dry-run mode in BitBake (activated by the -n or --dry-run command
line option), but it dry-runs the setscene tasks as well which we don't
want here.

Note that this has no effect on the checking we are doing with
BB_SETSCENE_ENFORCE to ensure that only whitelisted real tasks are
scheduled to run - that's handled separately.

Fixes [YOCTO #10369].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-worker | 12 +++++++-----
 lib/bb/runqueue.py | 13 +++++++------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 4dbd681..5010bad 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -136,7 +136,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, extraconfigdata, quieterrors=False):
+def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -152,8 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
         except TypeError:
              umask = taskdep['umask'][taskname]
 
+    dry_run = cfg.dry_run or dry_run_exec
+
     # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
-    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not cfg.dry_run:
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
         envvars = (workerdata["fakerootenv"][fn] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
@@ -263,7 +265,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                     logger.critical(traceback.format_exc())
                 os._exit(1)
             try:
-                if cfg.dry_run:
+                if dry_run:
                     return 0
                 return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
             except:
@@ -421,10 +423,10 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
+        fn, task, taskname, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, self.extraconfigdata, quieterrors)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2ad8aad..d305bb1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -266,6 +266,7 @@ class RunQueueData:
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST") or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
         self.setscenewhitelist_checked = False
+        self.setscene_enforce = (cfgData.getVar('BB_SETSCENE_ENFORCE') == "1")
         self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
 
         self.reset()
@@ -1790,7 +1791,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 bb.event.fire(startevent, self.cfgData)
                 self.runq_running.add(task)
                 self.stats.taskActive()
-                if not self.cooker.configuration.dry_run:
+                if not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                     bb.build.make_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
                 self.task_complete(task)
                 return True
@@ -1801,7 +1802,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not self.rq.fakeworker:
                     try:
                         self.rq.start_fakeworker(self)
@@ -1810,10 +1811,10 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2219,10 +2220,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.runq_running.add(task)
-- 
2.5.5


