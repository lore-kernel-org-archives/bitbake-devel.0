Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id CF2356FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:53:18 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120683031"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:53:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:26 +1200
Message-Id: <ea0b3c1b34818a2eb5f0beb998a4c4e63f334b19.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/10] runqueue: report progress for "Preparing RunQueue" step
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
X-List-Received-Date: Mon, 13 Jun 2016 02:53:19 -0000

When "Preparing RunQueue" shows up you can expect to wait up to 30
seconds while it works - which is a bit long to leave the user waiting
without any kind of output. Since the work being carried out during this
time is divided into stages such that it's practical to determine
internally how it's progressing, replace the message with a progress
bar.

Actually what happens during this time is two major steps rather than
just one - the runqueue preparation itself, followed by the
initialisation prior to running setscene tasks. I elected to have the
progress bar cover both as one (there doesn't appear to be much point in
doing otherwise from a user perspective). I did however describe it as
"initialising tasks".

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/progress.py | 42 +++++++++++++++++++++++++++++++++++
 lib/bb/runqueue.py | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 73e3f05..46574dd 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -222,3 +222,45 @@ class MultiStageProgressReporter(object):
                 else:
                     out.append('Up to finish: %d' % stage_weight)
             bb.warn('Stage times:\n  %s' % '\n  '.join(out))
+
+class MultiStageProcessProgressReporter(MultiStageProgressReporter):
+    """
+    Version of MultiStageProgressReporter intended for use with
+    standalone processes (such as preparing the runqueue)
+    """
+    def __init__(self, d, processname, stage_weights, debug=False):
+        self._processname = processname
+        MultiStageProgressReporter.__init__(self, d, stage_weights, debug)
+
+    def start(self):
+        bb.event.fire(bb.event.ProcessStarted(self._processname, 100), self._data)
+
+    def _fire_progress(self, taskprogress):
+        bb.event.fire(bb.event.ProcessProgress(self._processname, taskprogress), self._data)
+
+    def finish(self):
+        MultiStageProgressReporter.finish(self)
+        bb.event.fire(bb.event.ProcessFinished(self._processname), self._data)
+
+class DummyMultiStageProcessProgressReporter(MultiStageProgressReporter):
+    """
+    MultiStageProcessProgressReporter that takes the calls and does nothing
+    with them (to avoid a bunch of "if progress_reporter:" checks)
+    """
+    def __init__(self):
+        MultiStageProcessProgressReporter.__init__(self, "", None, [])
+
+    def _fire_progress(self, taskprogress, rate=None):
+        pass
+
+    def start(self):
+        pass
+
+    def next_stage(self, stage_total=None):
+        pass
+
+    def update(self, stage_progress):
+        pass
+
+    def finish(self):
+        pass
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c68a3fe..f83a651 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -225,6 +225,7 @@ class RunQueueData:
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
+        self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
 
         self.reset()
 
@@ -434,7 +435,8 @@ class RunQueueData:
             # Nothing to do
             return 0
 
-        logger.info("Preparing RunQueue")
+        self.init_progress_reporter.start()
+        self.init_progress_reporter.next_stage()
 
         # Step A - Work out a list of tasks to run
         #
@@ -567,8 +569,9 @@ class RunQueueData:
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
         # We need to do this separately since we need all of self.runq_depends to be complete before this is processed
+        self.init_progress_reporter.next_stage(len(recursivetasks))
         extradeps = {}
-        for task in recursivetasks:
+        for taskcounter, task in enumerate(recursivetasks):
             extradeps[task] = set(self.runq_depends[task])
             tasknames = recursivetasks[task]
             seendeps = set()
@@ -589,6 +592,7 @@ class RunQueueData:
             if task in recursiveitasks:
                 for dep in recursiveitasks[task]:
                     generate_recdeps(dep)
+            self.init_progress_reporter.update(taskcounter)
 
         # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
         for task in recursivetasks:
@@ -603,6 +607,8 @@ class RunQueueData:
                 logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], self.runq_depends[task])
                 self.runq_depends[task].remove(task)
 
+        self.init_progress_reporter.next_stage()
+
         # Step B - Mark all active tasks
         #
         # Start with the tasks we were asked to run and mark all dependencies
@@ -666,6 +672,8 @@ class RunQueueData:
             else:
                 mark_active(listid, 1)
 
+        self.init_progress_reporter.next_stage()
+
         # Step C - Prune all inactive tasks
         #
         # Once all active tasks are marked, prune the ones we don't need.
@@ -685,6 +693,8 @@ class RunQueueData:
                 delcount = delcount + 1
                 maps.append(-1)
 
+        self.init_progress_reporter.next_stage()
+
         #
         # Step D - Sanity checks and computation
         #
@@ -698,6 +708,8 @@ class RunQueueData:
 
         logger.verbose("Pruned %s inactive tasks, %s left", delcount, len(self.runq_fnid))
 
+        self.init_progress_reporter.next_stage()
+
         # Remap the dependencies to account for the deleted tasks
         # Check we didn't delete a task we depend on
         for listid in range(len(self.runq_fnid)):
@@ -711,11 +723,15 @@ class RunQueueData:
 
         logger.verbose("Assign Weightings")
 
+        self.init_progress_reporter.next_stage()
+
         # Generate a list of reverse dependencies to ease future calculations
         for listid in range(len(self.runq_fnid)):
             for dep in self.runq_depends[listid]:
                 self.runq_revdeps[dep].add(listid)
 
+        self.init_progress_reporter.next_stage()
+
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
         endpoints = []
@@ -730,10 +746,14 @@ class RunQueueData:
 
         logger.verbose("Compute totals (have %s endpoint(s))", len(endpoints))
 
+        self.init_progress_reporter.next_stage()
+
         # Calculate task weights
         # Check of higher length circular dependencies
         self.runq_weight = self.calculate_task_weights(endpoints)
 
+        self.init_progress_reporter.next_stage()
+
         # Sanity Check - Check for multiple tasks building the same provider
         prov_list = {}
         seen_fn = []
@@ -825,6 +845,8 @@ class RunQueueData:
                 else:
                     logger.error(msg)
 
+        self.init_progress_reporter.next_stage()
+
         # Create a whitelist usable by the stamp checks
         stampfnwhitelist = []
         for entry in self.stampwhitelist.split():
@@ -836,6 +858,8 @@ class RunQueueData:
             stampfnwhitelist.append(fn)
         self.stampfnwhitelist = stampfnwhitelist
 
+        self.init_progress_reporter.next_stage()
+
         # Iterate over the task list looking for tasks with a 'setscene' function
         self.runq_setscene = []
         if not self.cooker.configuration.nosetscene:
@@ -859,6 +883,8 @@ class RunQueueData:
                 logger.verbose("Invalidate task %s, %s", taskname, fn)
                 bb.parse.siggen.invalidate_task(taskname, self.dataCache, fn)
 
+        self.init_progress_reporter.next_stage()
+
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
             for (fn, target) in self.target_pairs:
@@ -872,6 +898,8 @@ class RunQueueData:
                         st = "do_%s" % st
                     invalidate_task(fn, st, True)
 
+        self.init_progress_reporter.next_stage()
+
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
         virtmap = taskData.get_providermap(prefix="virtual/")
         virtpnmap = {}
@@ -881,6 +909,8 @@ class RunQueueData:
         if hasattr(bb.parse.siggen, "tasks_resolved"):
             bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCache)
 
+        self.init_progress_reporter.next_stage()
+
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(range(len(self.runq_fnid)))
@@ -895,6 +925,7 @@ class RunQueueData:
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
 
         bb.parse.siggen.writeout_file_checksum_cache()
+
         return len(self.runq_fnid)
 
     def dump_data(self, taskQueue):
@@ -1119,14 +1150,19 @@ class RunQueue:
 
         if self.state is runQueuePrepare:
             self.rqexe = RunQueueExecuteDummy(self)
+            self.rqdata.init_progress_reporter = bb.progress.MultiStageProcessProgressReporter(self.cooker.data,
+                                                            "Initialising tasks",
+                                                            [27, 870, 3, 33, 1, 3, 3, 2, 3, 6, 1, 13, 1, 1, 132, 32, 1, 61, 1, 13, 2, 243, 151, 299, 81, 1, 15, 72])
             if self.rqdata.prepare() == 0:
                 self.state = runQueueComplete
             else:
                 self.state = runQueueSceneInit
+                self.rqdata.init_progress_reporter.next_stage()
 
                 # we are ready to run,  emit dependency info to any UI or class which
                 # needs it
                 depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
+                self.rqdata.init_progress_reporter.next_stage()
                 bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
         if self.state is runQueueSceneInit:
@@ -1139,7 +1175,9 @@ class RunQueue:
                     self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
             else:
+                self.rqdata.init_progress_reporter.next_stage()
                 self.start_worker()
+                self.rqdata.init_progress_reporter.next_stage()
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
@@ -1152,6 +1190,8 @@ class RunQueue:
             if self.cooker.configuration.setsceneonly:
                 self.state = runQueueComplete
             else:
+                # Just in case we didn't setscene
+                self.rqdata.init_progress_reporter.finish()
                 logger.info("Executing RunQueue Tasks")
                 self.rqexe = RunQueueExecuteTasks(self)
                 self.state = runQueueRunning
@@ -1792,6 +1832,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.runq_complete.append(0)
             self.runq_buildable.append(0)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # First process the chains up to the first setscene task.
         endpoints = {}
         for task in range(len(self.rqdata.runq_fnid)):
@@ -1800,6 +1842,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
                 endpoints[task] = set()
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # Secondly process the chains between setscene tasks.
         for task in self.rqdata.runq_setscene:
             for dep in self.rqdata.runq_depends[task]:
@@ -1807,6 +1851,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                         endpoints[dep] = set()
                     endpoints[dep].add(task)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         def process_endpoints(endpoints):
             newendpoints = {}
             for point, task in endpoints.items():
@@ -1831,6 +1877,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         process_endpoints(endpoints)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # Build a list of setscene tasks which are "unskippable"
         # These are direct endpoints referenced by the build
         endpoints2 = {}
@@ -1867,6 +1915,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if sq_revdeps_new2[task]:
                 self.unskippable.append(self.rqdata.runq_setscene.index(task))
 
+        self.rqdata.init_progress_reporter.next_stage(len(self.rqdata.runq_fnid))
+
         for task in range(len(self.rqdata.runq_fnid)):
             if task in self.rqdata.runq_setscene:
                 deps = set()
@@ -1875,6 +1925,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_revdeps_squash.append(deps)
             elif len(sq_revdeps_new[task]) != 0:
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+            self.rqdata.init_progress_reporter.update(task)
+
+        self.rqdata.init_progress_reporter.next_stage()
 
         # Resolve setscene inter-task dependencies
         # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
@@ -1902,10 +1955,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     # Have to zero this to avoid circular dependencies
                     sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         for task in self.sq_harddeps:
              for dep in self.sq_harddeps[task]:
                  sq_revdeps_squash[dep].add(task)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         #for task in range(len(sq_revdeps_squash)):
         #    realtask = self.rqdata.runq_setscene[task]
         #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask) , sq_revdeps_squash[task]))
@@ -1920,6 +1977,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             for dep in self.sq_revdeps[task]:
                 self.sq_deps[dep].add(task)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         for task in range(len(self.sq_revdeps)):
             if len(self.sq_revdeps[task]) == 0:
                 self.runq_buildable[task] = 1
@@ -1977,6 +2036,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                                  self.rqdata.get_user_idstring(realtask))
                     self.outrightfail.append(task)
 
+        self.rqdata.init_progress_reporter.finish()
+
         logger.info('Executing SetScene Tasks')
 
         self.rq.state = runQueueSceneRun
-- 
2.5.5


