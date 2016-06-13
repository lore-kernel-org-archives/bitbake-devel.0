Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5A08F6FFCC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:53:16 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120683010"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:53:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:25 +1200
Message-Id: <787bac60c4724c3b5528d211cc79e97b0d0680d9.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 09/10] runqueue: add ability to enforce that tasks are setscened
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
X-List-Received-Date: Mon, 13 Jun 2016 02:53:16 -0000

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
 lib/bb/runqueue.py | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 376c9f5..c68a3fe 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -224,6 +224,7 @@ class RunQueueData:
 
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
+        self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
 
         self.reset()
 
@@ -1629,8 +1630,35 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
+        if self.rqdata.setscenewhitelist:
+            # Check tasks that are going to run against the whitelist
+            unexpected = False
+            for taskid in range(len(self.rqdata.runq_fnid)):
+                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
+                taskname = self.rqdata.runq_task[taskid]
+                # Ignore covered tasks
+                if taskid in self.rq.scenequeue_covered:
+                    continue
+                # Ignore stamped tasks
+                if self.rq.check_stamp_task(taskid, taskname, cache=self.stampcache):
+                    continue
+                # Ignore noexec tasks
+                taskdep = self.rqdata.dataCache.task_deps[fn]
+                if 'noexec' in taskdep and taskname in taskdep['noexec']:
+                    continue
+
+                pn = self.rqdata.dataCache.pkg_fn[fn]
+                if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+                    unexpected = True
+                    if taskid in self.rqdata.runq_setscene:
+                        logger.error('Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname))
+                    else:
+                        logger.error('Task %s.%s attempted to execute unexpectedly' % (pn, taskname))
+            if unexpected:
+                self.rq.state = runQueueCleanUp
+                return True
+
         self.rq.read_workers()
-        
 
         if self.stats.total == 0:
             # nothing to do
@@ -1982,6 +2010,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_covered.add(task)
         self.scenequeue_updatecounters(task)
 
+    def check_taskfail(self, task):
+        if self.rqdata.setscenewhitelist:
+            realtask = self.rqdata.runq_setscene[task]
+            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
+            pn = self.rqdata.dataCache.pkg_fn[fn]
+            taskname = self.rqdata.runq_task[realtask]
+            if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+                logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
+                self.rq.state = runQueueCleanUp
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
@@ -1992,6 +2030,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
+        self.check_taskfail(task)
 
     def task_failoutright(self, task):
         self.runq_running[task] = 1
@@ -2001,6 +2040,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         index = self.rqdata.runq_setscene[task]
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
+        self.check_taskfail(task)
 
     def task_skip(self, task):
         self.runq_running[task] = 1
@@ -2282,3 +2322,27 @@ class runQueuePipe():
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


