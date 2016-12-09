Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 6645271C6F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 02:26:41 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 08 Dec 2016 18:26:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,322,1477983600"; d="scan'208";a="200673381"
Received: from sng18-mobl3.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.190.78])
	by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2016 18:26:40 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 15:26:33 +1300
Message-Id: <6f5ad2f33c662feb54375f26b0de2f37ba1d353d.1481250376.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481250376.git.paul.eggleton@linux.intel.com>
References: <cover.1481250376.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1481250376.git.paul.eggleton@linux.intel.com>
References: <cover.1481250376.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] runqueue: dry-run real tasks when BB_SETSCENE_ENFORCE is set
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
X-List-Received-Date: Fri, 09 Dec 2016 02:26:43 -0000

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
 bin/bitbake-worker | 6 ++++--
 lib/bb/runqueue.py | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 97b32c3..9d8f004 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -152,8 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
         except TypeError:
              umask = taskdep['umask'][taskname]
 
+    dry_run = cfg.dry_run or workerdata['dry_run_exec']
+
     # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
-    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not cfg.dry_run:
+    if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
         envvars = (workerdata["fakerootenv"][fn] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
@@ -260,7 +262,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, append
                     logger.critical(traceback.format_exc())
                 os._exit(1)
             try:
-                if cfg.dry_run:
+                if dry_run:
                     return 0
                 return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
             except:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 389df4f..6d786f8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -266,6 +266,7 @@ class RunQueueData:
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST") or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
         self.setscenewhitelist_checked = False
+        self.setscene_enforce = cfgData.getVar('BB_SETSCENE_ENFORCE') or False
         self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
 
         self.reset()
@@ -1033,6 +1034,7 @@ class RunQueue:
             "buildname" : self.cfgData.getVar("BUILDNAME"),
             "date" : self.cfgData.getVar("DATE"),
             "time" : self.cfgData.getVar("TIME"),
+            "dry_run_exec" : bool(self.rqdata.setscene_enforce),
         }
 
         worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
@@ -1789,7 +1791,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 bb.event.fire(startevent, self.cfgData)
                 self.runq_running.add(task)
                 self.stats.taskActive()
-                if not self.cooker.configuration.dry_run:
+                if not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                     bb.build.make_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
                 self.task_complete(task)
                 return True
@@ -1800,7 +1802,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             taskdepdata = self.build_taskdepdata(task)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not self.rq.fakeworker:
                     try:
                         self.rq.start_fakeworker(self)
-- 
2.5.5


