Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B86EA73281
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 11:00:11 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 04:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723879224"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 04:00:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:12 +1200
Message-Id: <74266e7cfd4280dbf0c6963f1312ba90741b9a9e.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 10/10] runqueue: report progress for "Preparing RunQueue" step
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
X-List-Received-Date: Thu, 23 Jun 2016 11:00:11 -0000

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
 lib/bb/progress.py | 42 ++++++++++++++++++++++++++++++++
 lib/bb/runqueue.py | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 1365068..f8fa692 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -226,3 +226,45 @@ class MultiStageProgressReporter(object):
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
index b62a28a..57be15a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -241,6 +241,7 @@ class RunQueueData:
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
+        self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
 
         self.reset()
 
@@ -432,7 +433,8 @@ class RunQueueData:
             # Nothing to do
             return 0
 
-        logger.info("Preparing RunQueue")
+        self.init_progress_reporter.start()
+        self.init_progress_reporter.next_stage()
 
         # Step A - Work out a list of tasks to run
         #
@@ -562,8 +564,9 @@ class RunQueueData:
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
         # We need to do this separately since we need all of runtaskentries[*].depends to be complete before this is processed
+        self.init_progress_reporter.next_stage(len(recursivetasks))
         extradeps = {}
-        for tid in recursivetasks:
+        for taskcounter, tid in enumerate(recursivetasks):
             extradeps[tid] = set(self.runtaskentries[tid].depends)
 
             tasknames = recursivetasks[tid]
@@ -585,6 +588,7 @@ class RunQueueData:
             if tid in recursiveitasks:
                 for dep in recursiveitasks[tid]:
                     generate_recdeps(dep)
+            self.init_progress_reporter.update(taskcounter)
 
         # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
         for tid in recursivetasks:
@@ -600,6 +604,8 @@ class RunQueueData:
                 logger.debug(2, "Task %s contains self reference!", tid)
                 self.runtaskentries[tid].depends.remove(tid)
 
+        self.init_progress_reporter.next_stage()
+
         # Step B - Mark all active tasks
         #
         # Start with the tasks we were asked to run and mark all dependencies
@@ -664,6 +670,8 @@ class RunQueueData:
             else:
                 mark_active(tid, 1)
 
+        self.init_progress_reporter.next_stage()
+
         # Step C - Prune all inactive tasks
         #
         # Once all active tasks are marked, prune the ones we don't need.
@@ -674,6 +682,8 @@ class RunQueueData:
                 del self.runtaskentries[tid]
                 delcount += 1
 
+        self.init_progress_reporter.next_stage()
+
         #
         # Step D - Sanity checks and computation
         #
@@ -689,11 +699,15 @@ class RunQueueData:
 
         logger.verbose("Assign Weightings")
 
+        self.init_progress_reporter.next_stage()
+
         # Generate a list of reverse dependencies to ease future calculations
         for tid in self.runtaskentries:
             for dep in self.runtaskentries[tid].depends:
                 self.runtaskentries[dep].revdeps.add(tid)
 
+        self.init_progress_reporter.next_stage()
+
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
         endpoints = []
@@ -709,10 +723,14 @@ class RunQueueData:
 
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
@@ -804,6 +822,8 @@ class RunQueueData:
                 else:
                     logger.error(msg)
 
+        self.init_progress_reporter.next_stage()
+
         # Create a whitelist usable by the stamp checks
         stampfnwhitelist = []
         for entry in self.stampwhitelist.split():
@@ -813,6 +833,8 @@ class RunQueueData:
             stampfnwhitelist.append(fn)
         self.stampfnwhitelist = stampfnwhitelist
 
+        self.init_progress_reporter.next_stage()
+
         # Iterate over the task list looking for tasks with a 'setscene' function
         self.runq_setscene_tids = []
         if not self.cooker.configuration.nosetscene:
@@ -837,6 +859,8 @@ class RunQueueData:
                 logger.verbose("Invalidate task %s, %s", taskname, fn)
                 bb.parse.siggen.invalidate_task(taskname, self.dataCache, fn)
 
+        self.init_progress_reporter.next_stage()
+
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
             for (fn, target) in self.target_pairs:
@@ -850,6 +874,8 @@ class RunQueueData:
                         st = "do_%s" % st
                     invalidate_task(fn, st, True)
 
+        self.init_progress_reporter.next_stage()
+
         # Create and print to the logs a virtual/xxxx -> PN (fn) table
         virtmap = taskData.get_providermap(prefix="virtual/")
         virtpnmap = {}
@@ -859,6 +885,8 @@ class RunQueueData:
         if hasattr(bb.parse.siggen, "tasks_resolved"):
             bb.parse.siggen.tasks_resolved(virtmap, virtpnmap, self.dataCache)
 
+        self.init_progress_reporter.next_stage()
+
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(self.runtaskentries)
@@ -1096,14 +1124,25 @@ class RunQueue:
 
         if self.state is runQueuePrepare:
             self.rqexe = RunQueueExecuteDummy(self)
+            # NOTE: if you add, remove or significantly refactor the stages of this
+            # process then you should recalculate the weightings here. This is quite
+            # easy to do - just change the next line temporarily to pass debug=True as
+            # the last parameter and you'll get a printout of the weightings as well
+            # as a map to the lines where next_stage() was called. Of course this isn't
+            # critical, but it helps to keep the progress reporting accurate.
+            self.rqdata.init_progress_reporter = bb.progress.MultiStageProcessProgressReporter(self.cooker.data,
+                                                            "Initialising tasks",
+                                                            [43, 967, 4, 3, 1, 5, 3, 7, 13, 1, 2, 1, 1, 246, 35, 1, 38, 1, 35, 2, 338, 204, 142, 3, 3, 37, 244])
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
@@ -1116,7 +1155,9 @@ class RunQueue:
                     self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
             else:
+                self.rqdata.init_progress_reporter.next_stage()
                 self.start_worker()
+                self.rqdata.init_progress_reporter.next_stage()
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
@@ -1129,6 +1170,8 @@ class RunQueue:
             if self.cooker.configuration.setsceneonly:
                 self.state = runQueueComplete
             else:
+                # Just in case we didn't setscene
+                self.rqdata.init_progress_reporter.finish()
                 logger.info("Executing RunQueue Tasks")
                 self.rqexe = RunQueueExecuteTasks(self)
                 self.state = runQueueRunning
@@ -1769,6 +1812,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # therefore aims to collapse the huge runqueue dependency tree into a smaller one
         # only containing the setscene functions.
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # First process the chains up to the first setscene task.
         endpoints = {}
         for tid in self.rqdata.runtaskentries:
@@ -1778,6 +1823,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 #bb.warn("Added endpoint %s" % (tid))
                 endpoints[tid] = set()
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # Secondly process the chains between setscene tasks.
         for tid in self.rqdata.runq_setscene_tids:
             #bb.warn("Added endpoint 2 %s" % (tid))
@@ -1787,6 +1834,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     #bb.warn("  Added endpoint 3 %s" % (dep))
                     endpoints[dep].add(tid)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         def process_endpoints(endpoints):
             newendpoints = {}
             for point, task in endpoints.items():
@@ -1811,6 +1860,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         process_endpoints(endpoints)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         # Build a list of setscene tasks which are "unskippable"
         # These are direct endpoints referenced by the build
         endpoints2 = {}
@@ -1847,7 +1898,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if sq_revdeps_new2[tid]:
                 self.unskippable.append(tid)
 
-        for tid in self.rqdata.runtaskentries:
+        self.rqdata.init_progress_reporter.next_stage(len(self.rqdata.runtaskentries))
+
+        for taskcounter, tid in enumerate(self.rqdata.runtaskentries):
             if tid in self.rqdata.runq_setscene_tids:
                 deps = set()
                 for dep in sq_revdeps_new[tid]:
@@ -1855,6 +1908,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_revdeps_squash[tid] = deps
             elif len(sq_revdeps_new[tid]) != 0:
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+            self.rqdata.init_progress_reporter.update(taskcounter)
+
+        self.rqdata.init_progress_reporter.next_stage()
 
         # Resolve setscene inter-task dependencies
         # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
@@ -1882,10 +1938,14 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     # Have to zero this to avoid circular dependencies
                     sq_revdeps_squash[deptid] = set()
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         for task in self.sq_harddeps:
              for dep in self.sq_harddeps[task]:
                  sq_revdeps_squash[dep].add(task)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         #for tid in sq_revdeps_squash:
         #    for dep in sq_revdeps_squash[tid]:
         #        data = data + "\n   %s" % dep
@@ -1901,6 +1961,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             for dep in self.sq_revdeps[tid]:
                 self.sq_deps[dep].add(tid)
 
+        self.rqdata.init_progress_reporter.next_stage()
+
         for tid in self.sq_revdeps:
             if len(self.sq_revdeps[tid]) == 0:
                 self.runq_buildable.add(tid)
@@ -1956,6 +2018,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     logger.debug(2, 'No package found, so skipping setscene task %s', tid)
                     self.outrightfail.append(tid)
 
+        self.rqdata.init_progress_reporter.finish()
+
         logger.info('Executing SetScene Tasks')
 
         self.rq.state = runQueueSceneRun
-- 
2.5.5


