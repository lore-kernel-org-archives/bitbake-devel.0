Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5902C738AE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 11:00:09 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 04:00:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723879194"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 04:00:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:11 +1200
Message-Id: <0448133e60f2ee7b6ff13d1e81d6c84a72f8b046.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 09/10] runqueue: add ability to enforce that tasks are setscened
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
X-List-Received-Date: Thu, 23 Jun 2016 11:00:09 -0000

Add the ability to enter a mode where only a specified whitelist of
tasks can be executed outright; everything else must be successfully
provided in the form of a setscene task (or covered by a setscene task).
Any setscene failure outside of the whitelist will cause the build to
fail immediately instead of running the real task, and any real tasks
that would execute outside of the whitelist cause an immediate build
failure when it comes to executing the runqueue as well.

The mode is enabled by setting BB_SETSCENE_ENFORCE="1", and the
whitelist is specified through BB_SETSCENE_ENFORCE_WHITELIST, consisting
of pn:taskname pairs. A single % character can be substituted for the pn
value to match any target explicitly specified on the bitbake command
line. Wildcards * and ? can also be used as per standard unix file name
matching for both pn and taskname.

Part of the implementation of [YOCTO #9367].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/runqueue.py | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c9b6b84..b62a28a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -240,6 +240,7 @@ class RunQueueData:
 
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
+        self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
 
         self.reset()
 
@@ -1596,8 +1597,51 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        self.rq.read_workers()
+        if self.rqdata.setscenewhitelist:
+            # Check tasks that are going to run against the whitelist
+            def check_norun_task(tid, showerror=False):
+                fn = fn_from_tid(tid)
+                taskname = taskname_from_tid(tid)
+                # Ignore covered tasks
+                if tid in self.rq.scenequeue_covered:
+                    return False
+                # Ignore stamped tasks
+                if self.rq.check_stamp_task(tid, taskname, cache=self.stampcache):
+                    return False
+                # Ignore noexec tasks
+                taskdep = self.rqdata.dataCache.task_deps[fn]
+                if 'noexec' in taskdep and taskname in taskdep['noexec']:
+                    return False
 
+                pn = self.rqdata.dataCache.pkg_fn[fn]
+                if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+                    if showerror:
+                        if tid in self.rqdata.runq_setscene_tids:
+                            logger.error('Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname))
+                        else:
+                            logger.error('Task %s.%s attempted to execute unexpectedly' % (pn, taskname))
+                    return True
+                return False
+            # Look to see if any tasks that we think shouldn't run are going to
+            unexpected = False
+            for tid in self.rqdata.runtaskentries:
+                if check_norun_task(tid):
+                    unexpected = True
+                    break
+            if unexpected:
+                # Run through the tasks in the rough order they'd have executed and print errors
+                # (since the order can be useful - usually missing sstate for the last few tasks
+                # is the cause of the problem)
+                task = self.sched.next()
+                while task is not None:
+                    check_norun_task(task, showerror=True)
+                    self.task_skip(task, 'Setscene enforcement check')
+                    task = self.sched.next()
+
+                self.rq.state = runQueueCleanUp
+                return True
+
+        self.rq.read_workers()
 
         if self.stats.total == 0:
             # nothing to do
@@ -1940,6 +1984,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_covered.add(task)
         self.scenequeue_updatecounters(task)
 
+    def check_taskfail(self, task):
+        if self.rqdata.setscenewhitelist:
+            realtask = task.split('_setscene')[0]
+            fn = fn_from_tid(realtask)
+            taskname = taskname_from_tid(realtask)
+            pn = self.rqdata.dataCache.pkg_fn[fn]
+            if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+                logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
+                self.rq.state = runQueueCleanUp
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
@@ -1950,6 +2004,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
+        self.check_taskfail(task)
 
     def task_failoutright(self, task):
         self.runq_running.add(task)
@@ -2231,3 +2286,27 @@ class runQueuePipe():
         if len(self.queue) > 0:
             print("Warning, worker left partial message: %s" % self.queue)
         self.input.close()
+
+def get_setscene_enforce_whitelist(d):
+    if d.getVar('BB_SETSCENE_ENFORCE', True) != '1':
+        return None
+    whitelist = (d.getVar("BB_SETSCENE_ENFORCE_WHITELIST", True) or "").split()
+    outlist = []
+    for item in whitelist[:]:
+        if item.startswith('%:'):
+            for target in sys.argv[1:]:
+                if not target.startswith('-'):
+                    outlist.append(target.split(':')[0] + ':' + item.split(':')[1])
+        else:
+            outlist.append(item)
+    return outlist
+
+def check_setscene_enforce_whitelist(pn, taskname, whitelist):
+    import fnmatch
+    if whitelist:
+        item = '%s:%s' % (pn, taskname)
+        for whitelist_item in whitelist:
+            if fnmatch.fnmatch(item, whitelist_item):
+                return True
+        return False
+    return True
-- 
2.5.5


