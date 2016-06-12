Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8B1926FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 22:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5CMtptO016092 for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:51 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5BOwFOaghgVf for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:51 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u5CMtmte016089
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 12 Jun 2016 23:55:49 +0100
Message-ID: <1465772148.13979.192.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 12 Jun 2016 23:55:48 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
X-Mailman-Approved-At: Sun, 12 Jun 2016 23:04:32 +0000
Subject: [PATCH] taskdata/runqueue: Rewrite without use of ID indirection
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
X-List-Received-Date: Sun, 12 Jun 2016 22:55:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I'm not sure what possesed me when I wrote this code originally but its
indirection of everyting to use numeric IDs and position dependent lists
is horrific. Given the way python internals work, its completely and
utterly pointless from  performance perspective. It also makes the code
hard to understand and debug since any numeric ID has to be translated
into something human readable.

The hard part is that the IDs are infectous and spread from taskdata
into runqueue and even partly into cooker for the dependency graph
processing. The only real way to deal with this is to convert everything
to use a more sane data structure.

This patch:
* Uses "<fn>:<taskname>" as the ID for tasks rather than a number
* Changes to dict() based structures rather than position dependent lists
* Drops the build name, runtime name and filename ID indexes

On the most part there shouldn't be user visible changes. Sadly we did
leak datastructures to the setscene verify function which has to be
rewritten. To handle this, the variable name used to specifiy the version
changes from BB_SETSCENE_VERIFY_FUNCTION to BB_SETSCENE_VERIFY_FUNCTION2
allowing multiple versions of bitbake to work with suitably written
metadata. Anyone with custom schedulers may also need to change them.

I believe the benefits in code readability and easier debugging far
outweigh those issues though. It also means we have a saner codebase
to add multiconfig support on top of.

During development, I did have some of the original code coexisting with
the new data stores to allow comparision of the data and check it was
working correcty, particuarly for taskdata. I have also compared
task-depends.dot files before and after the change. There should be no
functionality changes in this patch, its purely a data structure change
and that is visible in the patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2154ef4..8b8b63a 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -623,9 +623,7 @@ class BBCooker:
 
             taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
 
-            targetid = taskdata.getbuild_id(pkgs_to_build[0])
-            fnid = taskdata.build_targets[targetid][0]
-            fn = taskdata.fn_index[fnid]
+            fn = taskdata.build_targets[pkgs_to_build[0]][0]
         else:
             envdata = self.data
 
@@ -714,7 +712,7 @@ class BBCooker:
 
 
     def buildDependTree(self, rq, taskdata):
-        seen_fnids = []
+        seen_fns = []
         depend_tree = {}
         depend_tree["depends"] = {}
         depend_tree["tdepends"] = {}
@@ -732,10 +730,9 @@ class BBCooker:
                 version = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
                 depend_tree['providermap'][name] = (pn, version)
 
-        for task in range(len(rq.rqdata.runq_fnid)):
-            taskname = rq.rqdata.runq_task[task]
-            fnid = rq.rqdata.runq_fnid[task]
-            fn = taskdata.fn_index[fnid]
+        for tid in rq.rqdata.runtaskentries:
+            taskname = bb.runqueue.taskname_from_tid(tid)
+            fn = bb.runqueue.fn_from_tid(tid)
             pn = self.recipecache.pkg_fn[fn]
             version  = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
             if pn not in depend_tree["pn"]:
@@ -756,24 +753,24 @@ class BBCooker:
                     depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
 
 
-            for dep in rq.rqdata.runq_depends[task]:
-                depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
+            for dep in rq.rqdata.runtaskentries[tid].depends:
+                depfn = bb.runqueue.fn_from_tid(dep)
                 deppn = self.recipecache.pkg_fn[depfn]
-                dotname = "%s.%s" % (pn, rq.rqdata.runq_task[task])
+                dotname = "%s.%s" % (pn, bb.runqueue.taskname_from_tid(dep))
                 if not dotname in depend_tree["tdepends"]:
                     depend_tree["tdepends"][dotname] = []
-                depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, rq.rqdata.runq_task[dep]))
-            if fnid not in seen_fnids:
-                seen_fnids.append(fnid)
+                depend_tree["tdepends"][dotname].append("%s.%s" % (deppn, bb.runqueue.taskname_from_tid(dep)))
+            if fn not in seen_fns:
+                seen_fns.append(fn)
                 packages = []
 
                 depend_tree["depends"][pn] = []
-                for dep in taskdata.depids[fnid]:
-                    depend_tree["depends"][pn].append(taskdata.build_names_index[dep])
+                for dep in taskdata.depids[fn]:
+                    depend_tree["depends"][pn].append(dep)
 
                 depend_tree["rdepends-pn"][pn] = []
-                for rdep in taskdata.rdepids[fnid]:
-                    depend_tree["rdepends-pn"][pn].append(taskdata.run_names_index[rdep])
+                for rdep in taskdata.rdepids[fn]:
+                    depend_tree["rdepends-pn"][pn].append(rdep)
 
                 rdepends = self.recipecache.rundeps[fn]
                 for package in rdepends:
@@ -805,12 +802,8 @@ class BBCooker:
         Create a dependency tree of pkgs_to_build, returning the data.
         """
         _, taskdata = self.prepareTreeData(pkgs_to_build, task)
-        tasks_fnid = []
-        if len(taskdata.tasks_name) != 0:
-            for task in range(len(taskdata.tasks_name)):
-                tasks_fnid.append(taskdata.tasks_fnid[task])
 
-        seen_fnids = []
+        seen_fns = []
         depend_tree = {}
         depend_tree["depends"] = {}
         depend_tree["pn"] = {}
@@ -825,9 +818,8 @@ class BBCooker:
                 cachefields = getattr(cache_class, 'cachefields', [])
                 extra_info = extra_info + cachefields
 
-        for task in range(len(tasks_fnid)):
-            fnid = tasks_fnid[task]
-            fn = taskdata.fn_index[fnid]
+        for tid in taskdata.taskentries:
+            fn = bb.runqueue.fn_from_tid(tid)
             pn = self.recipecache.pkg_fn[fn]
 
             if pn not in depend_tree["pn"]:
@@ -843,33 +835,27 @@ class BBCooker:
                 for ei in extra_info:
                     depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
 
-            if fnid not in seen_fnids:
-                seen_fnids.append(fnid)
+            if fn not in seen_fns:
+                seen_fns.append(fn)
 
                 depend_tree["depends"][pn] = []
-                for dep in taskdata.depids[fnid]:
-                    item = taskdata.build_names_index[dep]
+                for item in taskdata.depids[fn]:
                     pn_provider = ""
-                    targetid = taskdata.getbuild_id(item)
-                    if targetid in taskdata.build_targets and taskdata.build_targets[targetid]:
-                        id = taskdata.build_targets[targetid][0]
-                        fn_provider = taskdata.fn_index[id]
+                    if dep in taskdata.build_targets and taskdata.build_targets[dep]:
+                        fn_provider = taskdata.build_targets[dep][0]
                         pn_provider = self.recipecache.pkg_fn[fn_provider]
                     else:
                         pn_provider = item
                     depend_tree["depends"][pn].append(pn_provider)
 
                 depend_tree["rdepends-pn"][pn] = []
-                for rdep in taskdata.rdepids[fnid]:
-                    item = taskdata.run_names_index[rdep]
+                for rdep in taskdata.rdepids[fn]:
                     pn_rprovider = ""
-                    targetid = taskdata.getrun_id(item)
-                    if targetid in taskdata.run_targets and taskdata.run_targets[targetid]:
-                        id = taskdata.run_targets[targetid][0]
-                        fn_rprovider = taskdata.fn_index[id]
+                    if rdep in taskdata.run_targets and taskdata.run_targets[rdep]:
+                        fn_rprovider = taskdata.run_targets[rdep][0]
                         pn_rprovider = self.recipecache.pkg_fn[fn_rprovider]
                     else:
-                        pn_rprovider = item
+                        pn_rprovider = rdep
                     depend_tree["rdepends-pn"][pn].append(pn_rprovider)
 
                 depend_tree["rdepends-pkg"].update(rdepends)
@@ -1350,7 +1336,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures, interrupted), self.expanded_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.expanded_data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1386,7 +1372,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures, interrupted), self.data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), self.data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e55b0c4..739f553 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -42,6 +42,12 @@ logger = logging.getLogger("BitBake.RunQueue")
 
 __find_md5__ = re.compile( r'(?i)(?<![a-z0-9])[a-f0-9]{32}(?![a-z0-9])' )
 
+def fn_from_tid(tid):
+     return tid.rsplit(":", 1)[0]
+
+def taskname_from_tid(tid):
+    return tid.rsplit(":", 1)[1]
+
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -97,19 +103,18 @@ class RunQueueScheduler(object):
         """
         self.rq = runqueue
         self.rqdata = rqdata
-        self.numTasks = len(self.rqdata.runq_fnid)
+        self.numTasks = len(self.rqdata.runtaskentries)
 
-        self.prio_map = []
-        self.prio_map.extend(range(self.numTasks))
+        self.prio_map = [self.rqdata.runtaskentries.keys()]
 
         self.buildable = []
         self.stamps = {}
-        for taskid in range(self.numTasks):
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[taskid]]
-            taskname = self.rqdata.runq_task[taskid]
-            self.stamps[taskid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-            if taskid in self.rq.runq_buildable:
-                self.buildable.append(taskid)
+        for tid in self.rqdata.runtaskentries:
+            fn = fn_from_tid(tid)
+            taskname = taskname_from_tid(tid)
+            self.stamps[tid] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
+            if tid in self.rq.runq_buildable:
+                self.buildable.append(tid)
 
         self.rev_prio_map = None
 
@@ -121,26 +126,26 @@ class RunQueueScheduler(object):
         if not self.buildable:
             return None
         if len(self.buildable) == 1:
-            taskid = self.buildable[0]
-            stamp = self.stamps[taskid]
+            tid = self.buildable[0]
+            stamp = self.stamps[tid]
             if stamp not in self.rq.build_stamps.values():
-                return taskid
+                return tid
 
         if not self.rev_prio_map:
-            self.rev_prio_map = list(range(self.numTasks))
-            for taskid in range(self.numTasks):
-                self.rev_prio_map[self.prio_map[taskid]] = taskid
+            self.rev_prio_map = {}
+            for tid in self.rqdata.runtaskentries:
+                self.rev_prio_map[tid] = self.prio_map.index(tid)
 
         best = None
         bestprio = None
-        for taskid in self.buildable:
-            prio = self.rev_prio_map[taskid]
+        for tid in self.buildable:
+            prio = self.rev_prio_map[tid]
             if bestprio is None or bestprio > prio:
-                stamp = self.stamps[taskid]
+                stamp = self.stamps[tid]
                 if stamp in self.rq.build_stamps.values():
                     continue
                 bestprio = prio
-                best = taskid
+                best = tid
 
         return best
 
@@ -167,14 +172,17 @@ class RunQueueSchedulerSpeed(RunQueueScheduler):
         """
         RunQueueScheduler.__init__(self, runqueue, rqdata)
 
-        sortweight = sorted(copy.deepcopy(self.rqdata.runq_weight))
-        copyweight = copy.deepcopy(self.rqdata.runq_weight)
-        self.prio_map = []
+        weights = {}
+        for tid in self.rqdata.runtaskentries:
+            weight = self.rqdata.runtaskentries[tid].weight
+            if not weight in weights:
+                weights[weight] = []
+            weights[weight].append(tid)
 
-        for weight in sortweight:
-            idx = copyweight.index(weight)
-            self.prio_map.append(idx)
-            copyweight[idx] = -1
+        self.prio_map = []
+        for weight in sorted(weights):
+            for w in weights[weight]:
+                self.prio_map.append(w)
 
         self.prio_map.reverse()
 
@@ -191,25 +199,33 @@ class RunQueueSchedulerCompletion(RunQueueSchedulerSpeed):
     def __init__(self, runqueue, rqdata):
         RunQueueSchedulerSpeed.__init__(self, runqueue, rqdata)
 
-        #FIXME - whilst this groups all fnids together it does not reorder the
-        #fnid groups optimally.
+        #FIXME - whilst this groups all fns together it does not reorder the
+        #fn groups optimally.
 
         basemap = copy.deepcopy(self.prio_map)
         self.prio_map = []
         while (len(basemap) > 0):
             entry = basemap.pop(0)
             self.prio_map.append(entry)
-            fnid = self.rqdata.runq_fnid[entry]
+            fn = fn_from_tid(entry)
             todel = []
             for entry in basemap:
-                entry_fnid = self.rqdata.runq_fnid[entry]
-                if entry_fnid == fnid:
+                entry_fn = fn_from_tid(entry)
+                if entry_fn == fn:
                     todel.append(basemap.index(entry))
                     self.prio_map.append(entry)
             todel.reverse()
             for idx in todel:
                 del basemap[idx]
 
+class RunTaskEntry(object):
+    def __init__(self):
+        self.depends = set()
+        self.revdeps = set()
+        self.hash = None
+        self.task = None
+        self.weight = 1
+
 class RunQueueData:
     """
     BitBake Run Queue implementation
@@ -228,48 +244,29 @@ class RunQueueData:
         self.reset()
 
     def reset(self):
-        self.runq_fnid = []
-        self.runq_task = []
-        self.runq_depends = []
-        self.runq_revdeps = []
-        self.runq_hash = []
+        self.runtaskentries = {}
 
     def runq_depends_names(self, ids):
         import re
         ret = []
-        for id in self.runq_depends[ids]:
-            nam = os.path.basename(self.get_user_idstring(id))
+        for id in ids:
+            nam = os.path.basename(id)
             nam = re.sub("_[^,]*,", ",", nam)
             ret.extend([nam])
         return ret
 
-    def get_task_name(self, task):
-        return self.runq_task[task]
-
-    def get_task_file(self, task):
-        return self.taskData.fn_index[self.runq_fnid[task]]
+    def get_task_hash(self, tid):
+        return self.runtaskentries[tid].hash
 
-    def get_task_hash(self, task):
-        return self.runq_hash[task]
-
-    def get_user_idstring(self, task, task_name_suffix = ""):
-        fn = self.taskData.fn_index[self.runq_fnid[task]]
-        taskname = self.runq_task[task] + task_name_suffix
-        return "%s, %s" % (fn, taskname)
+    def get_user_idstring(self, tid, task_name_suffix = ""):
+        return tid + task_name_suffix
 
     def get_short_user_idstring(self, task, task_name_suffix = ""):
-        fn = self.taskData.fn_index[self.runq_fnid[task]]
+        fn = fn_from_tid(task)
         pn = self.dataCache.pkg_fn[fn]
-        taskname = self.runq_task[task] + task_name_suffix
+        taskname = taskname_from_tid(task) + task_name_suffix
         return "%s:%s" % (pn, taskname)
 
-
-    def get_task_id(self, fnid, taskname):
-        for listid in range(len(self.runq_fnid)):
-            if self.runq_fnid[listid] == fnid and self.runq_task[listid] == taskname:
-                return listid
-        return None
-
     def circular_depchains_handler(self, tasks):
         """
         Some tasks aren't buildable, likely due to circular dependency issues.
@@ -314,11 +311,11 @@ class RunQueueData:
                     return True
             return False
 
-        def find_chains(taskid, prev_chain):
-            prev_chain.append(taskid)
+        def find_chains(tid, prev_chain):
+            prev_chain.append(tid)
             total_deps = []
-            total_deps.extend(self.runq_revdeps[taskid])
-            for revdep in self.runq_revdeps[taskid]:
+            total_deps.extend(self.runtaskentries[tid].revdeps)
+            for revdep in self.runtaskentries[tid].revdeps:
                 if revdep in prev_chain:
                     idx = prev_chain.index(revdep)
                     # To prevent duplicates, reorder the chain to start with the lowest taskid
@@ -329,7 +326,7 @@ class RunQueueData:
                         valid_chains.append(new_chain)
                         msgs.append("Dependency loop #%d found:\n" % len(valid_chains))
                         for dep in new_chain:
-                            msgs.append("  Task %s (%s) (dependent Tasks %s)\n" % (dep, self.get_user_idstring(dep), self.runq_depends_names(dep)))
+                            msgs.append("  Task %s (dependent Tasks %s)\n" % (dep, self.runq_depends_names(self.runtaskentries[dep].depends)))
                         msgs.append("\n")
                     if len(valid_chains) > 10:
                         msgs.append("Aborted dependency loops search after 10 matches.\n")
@@ -366,25 +363,25 @@ class RunQueueData:
         possible to execute due to circular dependencies.
         """
 
-        numTasks = len(self.runq_fnid)
-        weight = []
-        deps_left = []
-        task_done = []
+        numTasks = len(self.runtaskentries)
+        weight = {}
+        deps_left = {}
+        task_done = {}
 
-        for listid in range(numTasks):
-            task_done.append(False)
-            weight.append(1)
-            deps_left.append(len(self.runq_revdeps[listid]))
+        for tid in self.runtaskentries:
+            task_done[tid] = False
+            weight[tid] = 1
+            deps_left[tid] = len(self.runtaskentries[tid].revdeps)
 
-        for listid in endpoints:
-            weight[listid] = 10
-            task_done[listid] = True
+        for tid in endpoints:
+            weight[tid] = 10
+            task_done[tid] = True
 
         while True:
             next_points = []
-            for listid in endpoints:
-                for revdep in self.runq_depends[listid]:
-                    weight[revdep] = weight[revdep] + weight[listid]
+            for tid in endpoints:
+                for revdep in self.runtaskentries[tid].depends:
+                    weight[revdep] = weight[revdep] + weight[tid]
                     deps_left[revdep] = deps_left[revdep] - 1
                     if deps_left[revdep] == 0:
                         next_points.append(revdep)
@@ -395,14 +392,15 @@ class RunQueueData:
 
         # Circular dependency sanity check
         problem_tasks = []
-        for task in range(numTasks):
-            if task_done[task] is False or deps_left[task] != 0:
-                problem_tasks.append(task)
-                logger.debug(2, "Task %s (%s) is not buildable", task, self.get_user_idstring(task))
-                logger.debug(2, "(Complete marker was %s and the remaining dependency count was %s)\n", task_done[task], deps_left[task])
+        for tid in self.runtaskentries:
+            if task_done[tid] is False or deps_left[tid] != 0:
+                problem_tasks.append(tid)
+                logger.debug(2, "Task %s is not buildable", tid)
+                logger.debug(2, "(Complete marker was %s and the remaining dependency count was %s)\n", task_done[tid], deps_left[tid])
+            self.runtaskentries[tid].weight = weight[tid]
 
         if problem_tasks:
-            message = "Unbuildable tasks were found.\n"
+            message = "%s unbuildable tasks were found.\n" % len(problem_tasks)
             message = message + "These are usually caused by circular dependencies and any circular dependency chains found will be printed below. Increase the debug level to see a list of unbuildable tasks.\n\n"
             message = message + "Identifying dependency loops (this may take a short while)...\n"
             logger.error(message)
@@ -422,14 +420,14 @@ class RunQueueData:
         to optimise the execution order.
         """
 
-        runq_build = []
+        runq_build = {}
         recursivetasks = {}
         recursiveitasks = {}
         recursivetasksselfref = set()
 
         taskData = self.taskData
 
-        if len(taskData.tasks_name) == 0:
+        if len(taskData.taskentries) == 0:
             # Nothing to do
             return 0
 
@@ -447,160 +445,159 @@ class RunQueueData:
         # rdeptast, recrdeptask, idepends).
 
         def add_build_dependencies(depids, tasknames, depends):
-            for depid in depids:
+            for depname in depids:
                 # Won't be in build_targets if ASSUME_PROVIDED
-                if depid not in taskData.build_targets:
+                if depname not in taskData.build_targets or not taskData.build_targets[depname]:
                     continue
-                depdata = taskData.build_targets[depid][0]
+                depdata = taskData.build_targets[depname][0]
                 if depdata is None:
                     continue
                 for taskname in tasknames:
-                    taskid = taskData.gettask_id_fromfnid(depdata, taskname)
-                    if taskid is not None:
-                        depends.add(taskid)
+                    t = depdata + ":" + taskname
+                    if t in taskData.taskentries:
+                        depends.add(t)
 
         def add_runtime_dependencies(depids, tasknames, depends):
-            for depid in depids:
-                if depid not in taskData.run_targets:
+            for depname in depids:
+                if depname not in taskData.run_targets or not taskData.run_targets[depname]:
                     continue
-                depdata = taskData.run_targets[depid][0]
+                depdata = taskData.run_targets[depname][0]
                 if depdata is None:
                     continue
                 for taskname in tasknames:
-                    taskid = taskData.gettask_id_fromfnid(depdata, taskname)
-                    if taskid is not None:
-                        depends.add(taskid)
+                    t = depdata + ":" + taskname
+                    if t in taskData.taskentries:
+                        depends.add(t)
 
-        def add_resolved_dependencies(depids, tasknames, depends):
-            for depid in depids:
-                for taskname in tasknames:
-                    taskid = taskData.gettask_id_fromfnid(depid, taskname)
-                    if taskid is not None:
-                        depends.add(taskid)
+        def add_resolved_dependencies(fn, tasknames, depends):
+            for taskname in tasknames:
+                tid = fn + ":" + taskname
+                if tid in self.runtaskentries:
+                    depends.add(tid)
+
+        for tid in taskData.taskentries:
+
+            fn = fn_from_tid(tid)
+            taskname = taskname_from_tid(tid)
 
-        for task in range(len(taskData.tasks_name)):
             depends = set()
-            fnid = taskData.tasks_fnid[task]
-            fn = taskData.fn_index[fnid]
             task_deps = self.dataCache.task_deps[fn]
 
-            #logger.debug(2, "Processing %s:%s", fn, taskData.tasks_name[task])
+            self.runtaskentries[tid] = RunTaskEntry()
+
+            #logger.debug(2, "Processing %s:%s", fn, taskname)
 
-            if fnid not in taskData.failed_fnids:
+            if fn not in taskData.failed_fns:
 
                 # Resolve task internal dependencies
                 #
                 # e.g. addtask before X after Y
-                depends = set(taskData.tasks_tdepends[task])
+                depends.update(taskData.taskentries[tid].tdepends)
 
                 # Resolve 'deptask' dependencies
                 #
                 # e.g. do_sometask[deptask] = "do_someothertask"
                 # (makes sure sometask runs after someothertask of all DEPENDS)
-                if 'deptask' in task_deps and taskData.tasks_name[task] in task_deps['deptask']:
-                    tasknames = task_deps['deptask'][taskData.tasks_name[task]].split()
-                    add_build_dependencies(taskData.depids[fnid], tasknames, depends)
+                if 'deptask' in task_deps and taskname in task_deps['deptask']:
+                    tasknames = task_deps['deptask'][taskname].split()
+                    add_build_dependencies(taskData.depids[fn], tasknames, depends)
 
                 # Resolve 'rdeptask' dependencies
                 #
                 # e.g. do_sometask[rdeptask] = "do_someothertask"
                 # (makes sure sometask runs after someothertask of all RDEPENDS)
-                if 'rdeptask' in task_deps and taskData.tasks_name[task] in task_deps['rdeptask']:
-                    tasknames = task_deps['rdeptask'][taskData.tasks_name[task]].split()
-                    add_runtime_dependencies(taskData.rdepids[fnid], tasknames, depends)
+                if 'rdeptask' in task_deps and taskname in task_deps['rdeptask']:
+                    tasknames = task_deps['rdeptask'][taskname].split()
+                    add_runtime_dependencies(taskData.rdepids[fn], tasknames, depends)
 
                 # Resolve inter-task dependencies
                 #
                 # e.g. do_sometask[depends] = "targetname:do_someothertask"
                 # (makes sure sometask runs after targetname's someothertask)
-                idepends = taskData.tasks_idepends[task]
-                for (depid, idependtask) in idepends:
-                    if depid in taskData.build_targets and not depid in taskData.failed_deps:
+                idepends = taskData.taskentries[tid].idepends
+                for (depname, idependtask) in idepends:
+                    if depname in taskData.build_targets and taskData.build_targets[depname] and not depname in taskData.failed_deps:
                         # Won't be in build_targets if ASSUME_PROVIDED
-                        depdata = taskData.build_targets[depid][0]
+                        depdata = taskData.build_targets[depname][0]
                         if depdata is not None:
-                            taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
-                            if taskid is None:
-                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, taskData.fn_index[depdata]))
-                            depends.add(taskid)
-                irdepends = taskData.tasks_irdepends[task]
-                for (depid, idependtask) in irdepends:
-                    if depid in taskData.run_targets:
+                            t = depdata + ":" + idependtask
+                            depends.add(t)
+                            if t not in taskData.taskentries:
+                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
+                irdepends = taskData.taskentries[tid].irdepends
+                for (depname, idependtask) in irdepends:
+                    if depname in taskData.run_targets:
                         # Won't be in run_targets if ASSUME_PROVIDED
-                        depdata = taskData.run_targets[depid][0]
+                        depdata = taskData.run_targets[depname][0]
                         if depdata is not None:
-                            taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
-                            if taskid is None:
-                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, taskData.fn_index[depdata]))
-                            depends.add(taskid)
+                            t = depdata + ":" + idependtask
+                            depends.add(t)
+                            if t not in taskData.taskentries:
+                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
 
                 # Resolve recursive 'recrdeptask' dependencies (Part A)
                 #
                 # e.g. do_sometask[recrdeptask] = "do_someothertask"
                 # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
                 # We cover the recursive part of the dependencies below
-                if 'recrdeptask' in task_deps and taskData.tasks_name[task] in task_deps['recrdeptask']:
-                    tasknames = task_deps['recrdeptask'][taskData.tasks_name[task]].split()
-                    recursivetasks[task] = tasknames
-                    add_build_dependencies(taskData.depids[fnid], tasknames, depends)
-                    add_runtime_dependencies(taskData.rdepids[fnid], tasknames, depends)
-                    if taskData.tasks_name[task] in tasknames:
-                        recursivetasksselfref.add(task)
-
-                    if 'recideptask' in task_deps and taskData.tasks_name[task] in task_deps['recideptask']:
-                        recursiveitasks[task] = []
-                        for t in task_deps['recideptask'][taskData.tasks_name[task]].split():
-                            newdep = taskData.gettask_id_fromfnid(fnid, t)
-                            recursiveitasks[task].append(newdep)
-
-            self.runq_fnid.append(taskData.tasks_fnid[task])
-            self.runq_task.append(taskData.tasks_name[task])
-            self.runq_depends.append(depends)
-            self.runq_revdeps.append(set())
-            self.runq_hash.append("")
-
-            runq_build.append(0)
+                if 'recrdeptask' in task_deps and taskname in task_deps['recrdeptask']:
+                    tasknames = task_deps['recrdeptask'][taskname].split()
+                    recursivetasks[tid] = tasknames
+                    add_build_dependencies(taskData.depids[fn], tasknames, depends)
+                    add_runtime_dependencies(taskData.rdepids[fn], tasknames, depends)
+                    if taskname in tasknames:
+                        recursivetasksselfref.add(tid)
+
+                    if 'recideptask' in task_deps and taskname in task_deps['recideptask']:
+                        recursiveitasks[tid] = []
+                        for t in task_deps['recideptask'][taskname].split():
+                            newdep = fn + ":" + t
+                            recursiveitasks[tid].append(newdep)
+
+            self.runtaskentries[tid].depends = depends
 
         # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
-        # We need to do this separately since we need all of self.runq_depends to be complete before this is processed
+        # We need to do this separately since we need all of runtaskentries[*].depends to be complete before this is processed
         extradeps = {}
-        for task in recursivetasks:
-            extradeps[task] = set(self.runq_depends[task])
-            tasknames = recursivetasks[task]
+        for tid in recursivetasks:
+            extradeps[tid] = set(self.runtaskentries[tid].depends)
+
+            tasknames = recursivetasks[tid]
             seendeps = set()
-            seenfnid = []
 
             def generate_recdeps(t):
                 newdeps = set()
-                add_resolved_dependencies([taskData.tasks_fnid[t]], tasknames, newdeps)
-                extradeps[task].update(newdeps)
+                add_resolved_dependencies(fn_from_tid(t), tasknames, newdeps)
+                extradeps[tid].update(newdeps)
                 seendeps.add(t)
                 newdeps.add(t)
                 for i in newdeps:
-                    for n in self.runq_depends[i]:
+                    task = self.runtaskentries[i].task
+                    for n in self.runtaskentries[i].depends:
                         if n not in seendeps:
-                            generate_recdeps(n)
-            generate_recdeps(task)
+                             generate_recdeps(n)
+            generate_recdeps(tid)
 
-            if task in recursiveitasks:
-                for dep in recursiveitasks[task]:
+            if tid in recursiveitasks:
+                for dep in recursiveitasks[tid]:
                     generate_recdeps(dep)
 
         # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
-        for task in recursivetasks:
-            extradeps[task].difference_update(recursivetasksselfref)
+        for tid in recursivetasks:
+            extradeps[tid].difference_update(recursivetasksselfref)
 
-        for task in range(len(taskData.tasks_name)):
+        for tid in self.runtaskentries:
+            task = self.runtaskentries[tid].task
             # Add in extra dependencies
-            if task in extradeps:
-                 self.runq_depends[task] = extradeps[task]
+            if tid in extradeps:
+                 self.runtaskentries[tid].depends = extradeps[tid]
             # Remove all self references
-            if task in self.runq_depends[task]:
-                logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], self.runq_depends[task])
-                self.runq_depends[task].remove(task)
+            if tid in self.runtaskentries[tid].depends:
+                logger.debug(2, "Task %s contains self reference!", tid)
+                self.runtaskentries[tid].depends.remove(tid)
 
         # Step B - Mark all active tasks
         #
@@ -610,33 +607,30 @@ class RunQueueData:
 
         logger.verbose("Marking Active Tasks")
 
-        def mark_active(listid, depth):
+        def mark_active(tid, depth):
             """
             Mark an item as active along with its depends
             (calls itself recursively)
             """
 
-            if runq_build[listid] == 1:
+            if tid in runq_build:
                 return
 
-            runq_build[listid] = 1
+            runq_build[tid] = 1
 
-            depends = self.runq_depends[listid]
+            depends = self.runtaskentries[tid].depends
             for depend in depends:
                 mark_active(depend, depth+1)
 
         self.target_pairs = []
         for target in self.targets:
-            targetid = taskData.getbuild_id(target[0])
-
-            if targetid not in taskData.build_targets:
+            if target[0] not in taskData.build_targets:
                 continue
 
-            if targetid in taskData.failed_deps:
+            if target in taskData.failed_deps:
                 continue
 
-            fnid = taskData.build_targets[targetid][0]
-            fn = taskData.fn_index[fnid]
+            fn = taskData.build_targets[target[0]][0]
             task = target[1]
             parents = False
             if task.endswith('-'):
@@ -645,87 +639,72 @@ class RunQueueData:
 
             self.target_pairs.append((fn, task))
 
-            if fnid in taskData.failed_fnids:
+            if fn in taskData.failed_fns:
                 continue
 
-            if task not in taskData.tasks_lookup[fnid]:
+            tid = fn + ":" + task
+            if tid not in taskData.taskentries:
                 import difflib
-                close_matches = difflib.get_close_matches(task, taskData.tasks_lookup[fnid], cutoff=0.7)
+                tasks = []
+                for x in taskData.taskentries:
+                    if x.startswith(fn + ":"):
+                        tasks.append(taskname_from_tid(x))
+                close_matches = difflib.get_close_matches(task, tasks, cutoff=0.7)
                 if close_matches:
                     extra = ". Close matches:\n  %s" % "\n  ".join(close_matches)
                 else:
                     extra = ""
                 bb.msg.fatal("RunQueue", "Task %s does not exist for target %s%s" % (task, target[0], extra))
-  
+
             # For tasks called "XXXX-", ony run their dependencies
-            listid = taskData.tasks_lookup[fnid][task]
             if parents:
-                for i in self.runq_depends[listid]:
+                for i in self.runtaskentries[tid].depends:
                     mark_active(i, 1)
             else:
-                mark_active(listid, 1)
+                mark_active(tid, 1)
 
         # Step C - Prune all inactive tasks
         #
         # Once all active tasks are marked, prune the ones we don't need.
 
-        maps = []
         delcount = 0
-        for listid in range(len(self.runq_fnid)):
-            if runq_build[listid-delcount] == 1:
-                maps.append(listid-delcount)
-            else:
-                del self.runq_fnid[listid-delcount]
-                del self.runq_task[listid-delcount]
-                del self.runq_depends[listid-delcount]
-                del runq_build[listid-delcount]
-                del self.runq_revdeps[listid-delcount]
-                del self.runq_hash[listid-delcount]
-                delcount = delcount + 1
-                maps.append(-1)
+        for tid in list(self.runtaskentries.keys()):
+            if tid not in runq_build:
+                del self.runtaskentries[tid]
+                delcount += 1
 
         #
         # Step D - Sanity checks and computation
         #
 
         # Check to make sure we still have tasks to run
-        if len(self.runq_fnid) == 0:
+        if len(self.runtaskentries) == 0:
             if not taskData.abort:
                 bb.msg.fatal("RunQueue", "All buildable tasks have been run but the build is incomplete (--continue mode). Errors for the tasks that failed will have been printed above.")
             else:
                 bb.msg.fatal("RunQueue", "No active tasks and not in --continue mode?! Please report this bug.")
 
-        logger.verbose("Pruned %s inactive tasks, %s left", delcount, len(self.runq_fnid))
-
-        # Remap the dependencies to account for the deleted tasks
-        # Check we didn't delete a task we depend on
-        for listid in range(len(self.runq_fnid)):
-            newdeps = []
-            origdeps = self.runq_depends[listid]
-            for origdep in origdeps:
-                if maps[origdep] == -1:
-                    bb.msg.fatal("RunQueue", "Invalid mapping - Should never happen!")
-                newdeps.append(maps[origdep])
-            self.runq_depends[listid] = set(newdeps)
+        logger.verbose("Pruned %s inactive tasks, %s left", delcount, len(self.runtaskentries))
 
         logger.verbose("Assign Weightings")
 
         # Generate a list of reverse dependencies to ease future calculations
-        for listid in range(len(self.runq_fnid)):
-            for dep in self.runq_depends[listid]:
-                self.runq_revdeps[dep].add(listid)
+        for tid in self.runtaskentries:
+            for dep in self.runtaskentries[tid].depends:
+                self.runtaskentries[dep].revdeps.add(tid)
 
         # Identify tasks at the end of dependency chains
         # Error on circular dependency loops (length two)
         endpoints = []
-        for listid in range(len(self.runq_fnid)):
-            revdeps = self.runq_revdeps[listid]
+        for tid in self.runtaskentries:
+            revdeps = self.runtaskentries[tid].revdeps
             if len(revdeps) == 0:
-                endpoints.append(listid)
+                endpoints.append(tid)
             for dep in revdeps:
-                if dep in self.runq_depends[listid]:
+                if dep in self.runtaskentries[tid].depends:
                     #self.dump_data(taskData)
-                    bb.msg.fatal("RunQueue", "Task %s (%s) has circular dependency on %s (%s)" % (taskData.fn_index[self.runq_fnid[dep]], self.runq_task[dep], taskData.fn_index[self.runq_fnid[listid]], self.runq_task[listid]))
+                    bb.msg.fatal("RunQueue", "Task %s has circular dependency on %s" % (tid, dep))
+
 
         logger.verbose("Compute totals (have %s endpoint(s))", len(endpoints))
 
@@ -736,8 +715,8 @@ class RunQueueData:
         # Sanity Check - Check for multiple tasks building the same provider
         prov_list = {}
         seen_fn = []
-        for task in range(len(self.runq_fnid)):
-            fn = taskData.fn_index[self.runq_fnid[task]]
+        for tid in self.runtaskentries:
+            fn = fn_from_tid(tid)
             if fn in seen_fn:
                 continue
             seen_fn.append(fn)
@@ -766,15 +745,15 @@ class RunQueueData:
                 commondeps = None
                 for provfn in prov_list[prov]:
                     deps = set()
-                    for task, fnid in enumerate(self.runq_fnid):
-                        fn = taskData.fn_index[fnid]
+                    for tid in self.runtaskentries:
+                        fn = fn_from_tid(tid)
                         if fn != provfn:
                             continue
-                        for dep in self.runq_revdeps[task]:
-                            fn = taskData.fn_index[self.runq_fnid[dep]]
+                        for dep in self.runtaskentries[tid].revdeps:
+                            fn = fn_from_tid(dep)
                             if fn == provfn:
                                 continue
-                            deps.add(self.get_short_user_idstring(dep))
+                            deps.add(dep)
                     if not commondeps:
                         commondeps = set(deps)
                     else:
@@ -827,27 +806,26 @@ class RunQueueData:
         # Create a whitelist usable by the stamp checks
         stampfnwhitelist = []
         for entry in self.stampwhitelist.split():
-            entryid = self.taskData.getbuild_id(entry)
-            if entryid not in self.taskData.build_targets:
+            if entry not in self.taskData.build_targets:
                 continue
-            fnid = self.taskData.build_targets[entryid][0]
-            fn = self.taskData.fn_index[fnid]
+            fn = self.taskData.build_targets[entry][0]
             stampfnwhitelist.append(fn)
         self.stampfnwhitelist = stampfnwhitelist
 
         # Iterate over the task list looking for tasks with a 'setscene' function
-        self.runq_setscene = []
+        self.runq_setscene_tids = []
         if not self.cooker.configuration.nosetscene:
-            for task in range(len(self.runq_fnid)):
-                setscene = taskData.gettask_id(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task] + "_setscene", False)
-                if not setscene:
+            for tid in self.runtaskentries:
+                setscenetid = tid + "_setscene"
+                if setscenetid not in taskData.taskentries:
                     continue
-                self.runq_setscene.append(task)
+                task = self.runtaskentries[tid].task
+                self.runq_setscene_tids.append(tid)
 
         def invalidate_task(fn, taskname, error_nostamp):
             taskdep = self.dataCache.task_deps[fn]
-            fnid = self.taskData.getfn_id(fn)
-            if taskname not in taskData.tasks_lookup[fnid]:
+            tid = fn + ":" + taskname
+            if tid not in taskData.taskentries:
                 logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
             if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
                 if error_nostamp:
@@ -882,43 +860,38 @@ class RunQueueData:
 
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
-        todeal = set(range(len(self.runq_fnid)))
+        todeal = set(self.runtaskentries)
         while len(todeal) > 0:
-            for task in todeal.copy():
-                if len(self.runq_depends[task] - dealtwith) == 0:
-                    dealtwith.add(task)
-                    todeal.remove(task)
+            for tid in todeal.copy():
+                if len(self.runtaskentries[tid].depends - dealtwith) == 0:
+                    dealtwith.add(tid)
+                    todeal.remove(tid)
                     procdep = []
-                    for dep in self.runq_depends[task]:
-                        procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
-                    self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
+                    for dep in self.runtaskentries[tid].depends:
+                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
+                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(fn_from_tid(tid), taskname_from_tid(tid), procdep, self.dataCache)
+                    task = self.runtaskentries[tid].task
 
         bb.parse.siggen.writeout_file_checksum_cache()
-        return len(self.runq_fnid)
+        return len(self.runtaskentries)
 
     def dump_data(self, taskQueue):
         """
         Dump some debug information on the internal data structures
         """
         logger.debug(3, "run_tasks:")
-        for task in range(len(self.rqdata.runq_task)):
-            logger.debug(3, " (%s)%s - %s: %s   Deps %s RevDeps %s", task,
-                         taskQueue.fn_index[self.rqdata.runq_fnid[task]],
-                         self.rqdata.runq_task[task],
-                         self.rqdata.runq_weight[task],
-                         self.rqdata.runq_depends[task],
-                         self.rqdata.runq_revdeps[task])
+        for tid in self.runtaskentries:
+            logger.debug(3, " %s: %s   Deps %s RevDeps %s", tid,
+                         self.runtaskentries[tid].weight,
+                         self.runtaskentries[tid].depends,
+                         self.runtaskentries[tid].revdeps)
 
         logger.debug(3, "sorted_tasks:")
-        for task1 in range(len(self.rqdata.runq_task)):
-            if task1 in self.prio_map:
-                task = self.prio_map[task1]
-                logger.debug(3, " (%s)%s - %s: %s   Deps %s RevDeps %s", task,
-                           taskQueue.fn_index[self.rqdata.runq_fnid[task]],
-                           self.rqdata.runq_task[task],
-                           self.rqdata.runq_weight[task],
-                           self.rqdata.runq_depends[task],
-                           self.rqdata.runq_revdeps[task])
+        for tid in self.prio_map:
+            logger.debug(3, " %s: %s   Deps %s RevDeps %s", tid,
+                         self.runtaskentries[tid].weight,
+                         self.runtaskentries[tid].depends,
+                         self.runtaskentries[tid].revdeps)
 
 class RunQueue:
     def __init__(self, cooker, cfgData, dataCache, taskData, targets):
@@ -929,7 +902,7 @@ class RunQueue:
 
         self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY", True) or "perfile"
         self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION", True) or None
-        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION", True) or None
+        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION2", True) or None
         self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID", True) or None
 
         self.state = runQueuePrepare
@@ -961,13 +934,17 @@ class RunQueue:
         bb.utils.nonblockingfd(worker.stdout)
         workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
 
+        runqhash = {}
+        for tid in self.rqdata.runtaskentries:
+            runqhash[tid] = self.rqdata.runtaskentries[tid].hash
+
         workerdata = {
             "taskdeps" : self.rqdata.dataCache.task_deps,
             "fakerootenv" : self.rqdata.dataCache.fakerootenv,
             "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
             "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
-            "runq_hash" : self.rqdata.runq_hash,
+            "runq_hash" : runqhash,
             "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
             "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
             "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
@@ -1033,7 +1010,7 @@ class RunQueue:
             fds.append(self.fakeworkerpipe.input)
         return fds
 
-    def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
+    def check_stamp_task(self, tid, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
             try:
                 if not os.access(f, os.F_OK):
@@ -1050,9 +1027,9 @@ class RunQueue:
             if self.stamppolicy == "whitelist":
                 stampwhitelist = self.rqdata.stampfnwhitelist
 
-        fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+        fn = fn_from_tid(tid)
         if taskname is None:
-            taskname = self.rqdata.runq_task[task]
+            taskname = taskname_from_tid(tid)
 
         stampfile = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
 
@@ -1074,10 +1051,10 @@ class RunQueue:
 
         iscurrent = True
         t1 = get_timestamp(stampfile)
-        for dep in self.rqdata.runq_depends[task]:
+        for dep in self.rqdata.runtaskentries[tid].depends:
             if iscurrent:
-                fn2 = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[dep]]
-                taskname2 = self.rqdata.runq_task[dep]
+                fn2 = fn_from_tid(dep)
+                taskname2 = taskname_from_tid(dep)
                 stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCache, fn2)
                 stampfile3 = bb.build.stampfile(taskname2 + "_setscene", self.rqdata.dataCache, fn2)
                 t2 = get_timestamp(stampfile2)
@@ -1104,7 +1081,7 @@ class RunQueue:
                             iscurrent = self.check_stamp_task(dep, recurse=True, cache=cache)
                             cache[dep] = iscurrent
         if recurse:
-            cache[task] = iscurrent
+            cache[tid] = iscurrent
         return iscurrent
 
     def _execute_runqueue(self):
@@ -1171,9 +1148,9 @@ class RunQueue:
 
         if self.state is runQueueFailed:
             if not self.rqdata.taskData.tryaltconfigs:
-                raise bb.runqueue.TaskFailure(self.rqexe.failed_fnids)
-            for fnid in self.rqexe.failed_fnids:
-                self.rqdata.taskData.fail_fnid(fnid)
+                raise bb.runqueue.TaskFailure(self.rqexe.failed_fns)
+            for fn in self.rqexe.failed_fns:
+                self.rqdata.taskData.fail_fn(fn)
             self.rqdata.reset()
 
         if self.state is runQueueComplete:
@@ -1220,11 +1197,11 @@ class RunQueue:
     def dump_signatures(self, options):
         done = set()
         bb.note("Reparsing files to collect dependency data")
-        for task in range(len(self.rqdata.runq_fnid)):
-            if self.rqdata.runq_fnid[task] not in done:
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+        for tid in self.rqdata.runtaskentries:
+            fn = fn_from_tid(tid)
+            if fn not in done:
                 the_data = bb.cache.Cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn), self.cooker.data)
-                done.add(self.rqdata.runq_fnid[task])
+                done.add(fn)
 
         bb.parse.siggen.dump_sigs(self.rqdata.dataCache, options)
 
@@ -1242,20 +1219,20 @@ class RunQueue:
         stamppresent = []
         valid_new = set()
 
-        for task in range(len(self.rqdata.runq_fnid)):
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-            taskname = self.rqdata.runq_task[task]
+        for tid in self.rqdata.runtaskentries:
+            fn = fn_from_tid(tid)
+            taskname = taskname_from_tid(tid)
             taskdep = self.rqdata.dataCache.task_deps[fn]
 
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                noexec.append(task)
+                noexec.append(tid)
                 continue
 
             sq_fn.append(fn)
             sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
-            sq_hash.append(self.rqdata.runq_hash[task])
+            sq_hash.append(self.rqdata.runtaskentries[tid].hash)
             sq_taskname.append(taskname)
-            sq_task.append(task)
+            sq_task.append(tid)
         locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
         try:
             call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
@@ -1270,13 +1247,13 @@ class RunQueue:
         # Tasks which are both setscene and noexec never care about dependencies
         # We therefore find tasks which are setscene and noexec and mark their
         # unique dependencies as valid.
-        for task in noexec:
-            if task not in self.rqdata.runq_setscene:
+        for tid in noexec:
+            if tid not in self.rqdata.runq_setscene_tids:
                 continue
-            for dep in self.rqdata.runq_depends[task]:
+            for dep in self.rqdata.runtaskentries[tid].depends:
                 hasnoexecparents = True
-                for dep2 in self.rqdata.runq_revdeps[dep]:
-                    if dep2 in self.rqdata.runq_setscene and dep2 in noexec:
+                for dep2 in self.rqdata.runtaskentries[dep].revdeps:
+                    if dep2 in self.rqdata.runq_setscene_tids and dep2 in noexec:
                         continue
                     hasnoexecparents = False
                     break
@@ -1284,30 +1261,30 @@ class RunQueue:
                     valid_new.add(dep)
 
         invalidtasks = set()
-        for task in range(len(self.rqdata.runq_fnid)):
-            if task not in valid_new and task not in noexec:
-                invalidtasks.add(task)
+        for tid in self.rqdata.runtaskentries:
+            if tid not in valid_new and tid not in noexec:
+                invalidtasks.add(tid)
 
         found = set()
         processed = set()
-        for task in invalidtasks:
-            toprocess = set([task])
+        for tid in invalidtasks:
+            toprocess = set([tid])
             while toprocess:
                 next = set()
                 for t in toprocess:
-                    for dep in self.rqdata.runq_depends[t]:
+                    for dep in self.rqdata.runtaskentries[t].depends:
                         if dep in invalidtasks:
-                            found.add(task)
+                            found.add(tid)
                         if dep not in processed:
                             processed.add(dep)
                             next.add(dep)
                 toprocess = next
-                if task in found:
+                if tid in found:
                     toprocess = set()
 
         tasklist = []
-        for task in invalidtasks.difference(found):
-            tasklist.append(self.rqdata.get_user_idstring(task))
+        for tid in invalidtasks.difference(found):
+            tasklist.append(tid)
 
         if tasklist:
             bb.plain("The differences between the current build and any cached tasks start at the following tasks:\n" + "\n".join(tasklist))
@@ -1331,11 +1308,11 @@ class RunQueue:
             return recout
 
 
-        for task in invalidtasks:
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+        for tid in invalidtasks:
+            fn = fn_from_tid(tid)
             pn = self.rqdata.dataCache.pkg_fn[fn]
-            taskname = self.rqdata.runq_task[task]
-            h = self.rqdata.runq_hash[task]
+            taskname = taskname_from_tid(tid)
+            h = self.rqdata.runtaskentries[tid].hash
             matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData)
             match = None
             for m in matches:
@@ -1367,7 +1344,7 @@ class RunQueueExecute:
 
         self.build_stamps = {}
         self.build_stamps2 = []
-        self.failed_fnids = []
+        self.failed_fns = []
 
         self.stampcache = {}
 
@@ -1401,7 +1378,7 @@ class RunQueueExecute:
             except IOError:
                 # worker must have died?
                 pass
-        if len(self.failed_fnids) != 0:
+        if len(self.failed_fns) != 0:
             self.rq.state = runQueueFailed
             return
 
@@ -1416,7 +1393,7 @@ class RunQueueExecute:
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        if len(self.failed_fnids) != 0:
+        if len(self.failed_fns) != 0:
             self.rq.state = runQueueFailed
             return True
 
@@ -1430,13 +1407,9 @@ class RunQueueExecute:
         taskdata = {}
         taskdeps.add(task)
         for dep in taskdeps:
-            if setscene:
-                depid = self.rqdata.runq_setscene[dep]
-            else:
-                depid = dep
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[depid]]
+            fn = fn_from_tid(dep)
             pn = self.rqdata.dataCache.pkg_fn[fn]
-            taskname = self.rqdata.runq_task[depid]
+            taskname = taskname_from_tid(dep)
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
         locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.expanded_data }
@@ -1456,30 +1429,30 @@ class RunQueueExecuteTasks(RunQueueExecute):
     def __init__(self, rq):
         RunQueueExecute.__init__(self, rq)
 
-        self.stats = RunQueueStats(len(self.rqdata.runq_fnid))
+        self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
 
         self.stampcache = {}
 
         initial_covered = self.rq.scenequeue_covered.copy()
 
         # Mark initial buildable tasks
-        for task in range(self.stats.total):
-            if len(self.rqdata.runq_depends[task]) == 0:
-                self.runq_buildable.add(task)
-            if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
-                self.rq.scenequeue_covered.add(task)
+        for tid in self.rqdata.runtaskentries:
+            if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                self.runq_buildable.add(tid)
+            if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
+                self.rq.scenequeue_covered.add(tid)
 
         found = True
         while found:
             found = False
-            for task in range(self.stats.total):
-                if task in self.rq.scenequeue_covered:
+            for tid in self.rqdata.runtaskentries:
+                if tid in self.rq.scenequeue_covered:
                     continue
-                logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
+                logger.debug(1, 'Considering %s: %s' % (tid, str(self.rqdata.runtaskentries[tid].revdeps)))
 
-                if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
+                if len(self.rqdata.runtaskentries[tid].revdeps) > 0 and self.rqdata.runtaskentries[tid].revdeps.issubset(self.rq.scenequeue_covered):
                     found = True
-                    self.rq.scenequeue_covered.add(task)
+                    self.rq.scenequeue_covered.add(tid)
 
         logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))
 
@@ -1487,35 +1460,33 @@ class RunQueueExecuteTasks(RunQueueExecute):
         covered_remove = set()
         if self.rq.setsceneverify:
             invalidtasks = []
-            for task in range(len(self.rqdata.runq_task)):
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-                taskname = self.rqdata.runq_task[task]
+            tasknames = {}
+            fns = {}
+            for tid in self.rqdata.runtaskentries:
+                fn = fn_from_tid(tid)
+                taskname = taskname_from_tid(tid)
                 taskdep = self.rqdata.dataCache.task_deps[fn]
-
+                fns[tid] = fn
+                tasknames[tid] = taskname
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
                     continue
-                if self.rq.check_stamp_task(task, taskname + "_setscene", cache=self.stampcache):
-                    logger.debug(2, 'Setscene stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(task))
+                if self.rq.check_stamp_task(tid, taskname + "_setscene", cache=self.stampcache):
+                    logger.debug(2, 'Setscene stamp current for task %s', tid)
                     continue
-                if self.rq.check_stamp_task(task, taskname, recurse = True, cache=self.stampcache):
-                    logger.debug(2, 'Normal stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(task))
+                if self.rq.check_stamp_task(tid, taskname, recurse = True, cache=self.stampcache):
+                    logger.debug(2, 'Normal stamp current for task %s', tid)
                     continue
-                invalidtasks.append(task)
+                invalidtasks.append(tid)
 
-            call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d, invalidtasks=invalidtasks)"
-            call2 = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.expanded_data, "invalidtasks" : invalidtasks }
-            # Backwards compatibility with older versions without invalidtasks
-            try:
-                covered_remove = bb.utils.better_eval(call, locs)
-            except TypeError:
-                covered_remove = bb.utils.better_eval(call2, locs)
+            call = self.rq.setsceneverify + "(covered, tasknames, fns, d, invalidtasks=invalidtasks)"
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : tasknames, "fns" : fns, "d" : self.cooker.expanded_data, "invalidtasks" : invalidtasks }
+            covered_remove = bb.utils.better_eval(call, locs)
 
-        def removecoveredtask(task):
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-            taskname = self.rqdata.runq_task[task] + '_setscene'
+        def removecoveredtask(tid):
+            fn = fn_from_tid(tid)
+            taskname = taskname_from_tid(tid) + '_setscene'
             bb.build.del_stamp(taskname, self.rqdata.dataCache, fn)
-            self.rq.scenequeue_covered.remove(task)
+            self.rq.scenequeue_covered.remove(tid)
 
         toremove = covered_remove
         for task in toremove:
@@ -1524,7 +1495,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             covered_remove = []
             for task in toremove:
                 removecoveredtask(task)
-                for deptask in self.rqdata.runq_depends[task]:
+                for deptask in self.rqdata.runtaskentries[task].depends:
                     if deptask not in self.rq.scenequeue_covered:
                         continue
                     if deptask in toremove or deptask in covered_remove or deptask in initial_covered:
@@ -1580,20 +1551,20 @@ class RunQueueExecuteTasks(RunQueueExecute):
         completed dependencies as buildable
         """
         self.runq_complete.add(task)
-        for revdep in self.rqdata.runq_revdeps[task]:
+        for revdep in self.rqdata.runtaskentries[task].revdeps:
             if revdep in self.runq_running:
                 continue
             if revdep in self.runq_buildable:
                 continue
             alldeps = 1
-            for dep in self.rqdata.runq_depends[revdep]:
+            for dep in self.rqdata.runtaskentries[revdep].depends:
                 if dep not in self.runq_complete:
                     alldeps = 0
             if alldeps == 1:
                 self.setbuildable(revdep)
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[revdep]]
-                taskname = self.rqdata.runq_task[revdep]
-                logger.debug(1, "Marking task %s (%s, %s) as buildable", revdep, fn, taskname)
+                fn = fn_from_tid(revdep)
+                taskname = taskname_from_tid(revdep)
+                logger.debug(1, "Marking task %s as buildable", revdep)
 
     def task_complete(self, task):
         self.stats.taskCompleted()
@@ -1606,8 +1577,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Updates the state engine with the failure
         """
         self.stats.taskFailed()
-        fnid = self.rqdata.runq_fnid[task]
-        self.failed_fnids.append(fnid)
+        fn = fn_from_tid(task)
+        self.failed_fns.append(fn)
         bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq), self.cfgData)
         if self.rqdata.taskData.abort:
             self.rq.state = runQueueCleanUp
@@ -1626,7 +1597,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         """
 
         self.rq.read_workers()
-        
+
 
         if self.stats.total == 0:
             # nothing to do
@@ -1634,18 +1605,17 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         task = self.sched.next()
         if task is not None:
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-            taskname = self.rqdata.runq_task[task]
+            fn = fn_from_tid(task)
+            taskname = taskname_from_tid(task)
 
             if task in self.rq.scenequeue_covered:
-                logger.debug(2, "Setscene covered task %s (%s)", task,
-                                self.rqdata.get_user_idstring(task))
+                logger.debug(2, "Setscene covered task %s", task)
                 self.task_skip(task, "covered")
                 return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
-                logger.debug(2, "Stamp current task %s (%s)", task,
-                                self.rqdata.get_user_idstring(task))
+                logger.debug(2, "Stamp current task %s", task)
+
                 self.task_skip(task, "existing")
                 return True
 
@@ -1672,7 +1642,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     try:
                         self.rq.start_fakeworker(self)
                     except OSError as exc:
-                        logger.critical("Failed to spawn fakeroot worker to run %s:%s: %s" % (fn, taskname, str(exc)))
+                        logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
                         return True
                 self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
@@ -1682,7 +1652,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
-            self.build_stamps2.append(self.build_stamps[task]) 
+            self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
@@ -1692,12 +1662,12 @@ class RunQueueExecuteTasks(RunQueueExecute):
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        if len(self.failed_fnids) != 0:
+        if len(self.failed_fns) != 0:
             self.rq.state = runQueueFailed
             return True
 
         # Sanity Checks
-        for task in range(self.stats.total):
+        for task in self.rqdata.runtaskentries:
             if task not in self.runq_buildable:
                 logger.error("Task %s never buildable!", task)
             if task not in self.runq_running:
@@ -1710,15 +1680,15 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
     def build_taskdepdata(self, task):
         taskdepdata = {}
-        next = self.rqdata.runq_depends[task]
+        next = self.rqdata.runtaskentries[task].depends
         next.add(task)
         while next:
             additional = []
             for revdep in next:
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[revdep]]
+                fn = fn_from_tid(revdep)
                 pn = self.rqdata.dataCache.pkg_fn[fn]
-                taskname = self.rqdata.runq_task[revdep]
-                deps = self.rqdata.runq_depends[revdep]
+                taskname = taskname_from_tid(revdep)
+                deps = self.rqdata.runtaskentries[revdep].depends
                 provides = self.rqdata.dataCache.fn_provides[fn]
                 taskdepdata[revdep] = [pn, taskname, fn, deps, provides]
                 for revdep2 in deps:
@@ -1738,16 +1708,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_notneeded = set()
 
         # If we don't have any setscene functions, skip this step
-        if len(self.rqdata.runq_setscene) == 0:
+        if len(self.rqdata.runq_setscene_tids) == 0:
             rq.scenequeue_covered = set()
             rq.state = runQueueRunInit
             return
 
-        self.stats = RunQueueStats(len(self.rqdata.runq_setscene))
+        self.stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
 
-        sq_revdeps = []
-        sq_revdeps_new = []
-        sq_revdeps_squash = []
+        sq_revdeps = {}
+        sq_revdeps_new = {}
+        sq_revdeps_squash = {}
         self.sq_harddeps = {}
 
         # We need to construct a dependency graph for the setscene functions. Intermediate
@@ -1758,22 +1728,21 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # Build a lits of non-setscene task endpoints
         # Also populate sq_revdeps{,_new}
         endpoints = {}
-        for task in range(len(self.rqdata.runq_fnid)):
-            sq_revdeps.append(copy.copy(self.rqdata.runq_revdeps[task]))
-            sq_revdeps_new.append(set())
-            if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
-                #bb.warn("Added endpoint %s:%s" % (task, self.rqdata.get_user_idstring(task)))
-                endpoints[task] = set()
+        for tid in self.rqdata.runtaskentries:
+            sq_revdeps[tid] = copy.copy(self.rqdata.runtaskentries[tid].revdeps)
+            sq_revdeps_new[tid] = set()
+            if (len(sq_revdeps[tid]) == 0) and tid not in self.rqdata.runq_setscene_tids:
+                #bb.warn("Added endpoint %s" % (tid))
+                endpoints[tid] = set()
 
         # Add in setscene task endpoints to process the chains between setscene tasks
-        for task in self.rqdata.runq_setscene:
-            #bb.warn("Added endpoint 2 %s:%s" % (task, self.rqdata.get_user_idstring(task)))
-            for dep in self.rqdata.runq_depends[task]:
+        for tid in self.rqdata.runq_setscene_tids:
+            #bb.warn("Added endpoint 2 %s" % (tid))
+            for dep in self.rqdata.runtaskentries[tid].depends:
                     if dep not in endpoints:
                         endpoints[dep] = set()
-                    #bb.warn("  Added endpoint 3 %s:%s" % (dep, self.rqdata.get_user_idstring(dep)))
-
-                    endpoints[dep].add(task)
+                    #bb.warn("  Added endpoint 3 %s" % (dep))
+                    endpoints[dep].add(tid)
 
         def process_endpoints(endpoints):
             newendpoints = {}
@@ -1788,15 +1757,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 if sq_revdeps_new[point]:
                     tasks |= sq_revdeps_new[point]
                 sq_revdeps_new[point] = set()
-                if point in self.rqdata.runq_setscene:
+                if point in self.rqdata.runq_setscene_tids:
                     sq_revdeps_new[point] = tasks
                     tasks = set()
-                for dep in self.rqdata.runq_depends[point]:
+                for dep in self.rqdata.runtaskentries[point].depends:
                     if point in sq_revdeps[dep]:
                         sq_revdeps[dep].remove(point)
-                    if tasks:# and dep not in self.rqdata.runq_setscene:
+                    if tasks:
                         sq_revdeps_new[dep] |= tasks
-                    if (len(sq_revdeps[dep]) == 0 or len(sq_revdeps_new[dep]) != 0) and dep not in self.rqdata.runq_setscene:
+                    if (len(sq_revdeps[dep]) == 0 or len(sq_revdeps_new[dep]) != 0) and dep not in self.rqdata.runq_setscene_tids:
                         newendpoints[dep] = task
             if len(newendpoints) != 0:
                 process_endpoints(newendpoints)
@@ -1813,8 +1782,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # Build a list of setscene tasks which are "unskippable"
         # These are direct endpoints referenced by the build
         endpoints2 = {}
-        sq_revdeps2 = []
-        sq_revdeps_new2 = []
+        sq_revdeps2 = {}
+        sq_revdeps_new2 = {}
         def process_endpoints2(endpoints):
             newendpoints = {}
             for point, task in endpoints.items():
@@ -1824,35 +1793,35 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 if sq_revdeps_new2[point]:
                     tasks |= sq_revdeps_new2[point]
                 sq_revdeps_new2[point] = set()
-                if point in self.rqdata.runq_setscene:
+                if point in self.rqdata.runq_setscene_tids:
                     sq_revdeps_new2[point] = tasks
-                for dep in self.rqdata.runq_depends[point]:
+                for dep in self.rqdata.runtaskentries[point].depends:
                     if point in sq_revdeps2[dep]:
                         sq_revdeps2[dep].remove(point)
                     if tasks:
                         sq_revdeps_new2[dep] |= tasks
-                    if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in self.rqdata.runq_setscene:
+                    if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in self.rqdata.runq_setscene_tids:
                         newendpoints[dep] = tasks
             if len(newendpoints) != 0:
                 process_endpoints2(newendpoints)
-        for task in range(len(self.rqdata.runq_fnid)):
-            sq_revdeps2.append(copy.copy(self.rqdata.runq_revdeps[task]))
-            sq_revdeps_new2.append(set())
-            if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
-                endpoints2[task] = set()
+        for tid in self.rqdata.runtaskentries:
+            sq_revdeps2[tid] = copy.copy(self.rqdata.runtaskentries[tid].revdeps)
+            sq_revdeps_new2[tid] = set()
+            if (len(sq_revdeps2[tid]) == 0) and tid not in self.rqdata.runq_setscene_tids:
+                endpoints2[tid] = set()
         process_endpoints2(endpoints2)
         self.unskippable = []
-        for task in self.rqdata.runq_setscene:
-            if sq_revdeps_new2[task]:
-                self.unskippable.append(self.rqdata.runq_setscene.index(task))
+        for tid in self.rqdata.runq_setscene_tids:
+            if sq_revdeps_new2[tid]:
+                self.unskippable.append(tid)
 
-        for task in range(len(self.rqdata.runq_fnid)):
-            if task in self.rqdata.runq_setscene:
+        for tid in self.rqdata.runtaskentries:
+            if tid in self.rqdata.runq_setscene_tids:
                 deps = set()
-                for dep in sq_revdeps_new[task]:
-                    deps.add(self.rqdata.runq_setscene.index(dep))
-                sq_revdeps_squash.append(deps)
-            elif len(sq_revdeps_new[task]) != 0:
+                for dep in sq_revdeps_new[tid]:
+                    deps.add(tid)
+                sq_revdeps_squash[tid] = deps
+            elif len(sq_revdeps_new[tid]) != 0:
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
 
 
@@ -1860,28 +1829,28 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # Resolve setscene inter-task dependencies
         # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
         # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
-        for task in self.rqdata.runq_setscene:
-                realid = self.rqdata.taskData.gettask_id(self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]], self.rqdata.runq_task[task] + "_setscene", False)
-                idepends = self.rqdata.taskData.tasks_idepends[realid]
-                for (depid, idependtask) in idepends:
-                    if depid not in self.rqdata.taskData.build_targets:
+        for tid in self.rqdata.runq_setscene_tids:
+                realtid = tid + "_setscene"
+                idepends = self.rqdata.taskData.taskentries[realtid].idepends
+                for (depname, idependtask) in idepends:
+
+                    if depname not in self.rqdata.taskData.build_targets:
                         continue
 
-                    depdata = self.rqdata.taskData.build_targets[depid][0]
-                    if depdata is None:
+                    depfn = self.rqdata.taskData.build_targets[depname][0]
+                    if depfn is None:
                          continue
-                    dep = self.rqdata.taskData.fn_index[depdata]
-                    taskid = self.rqdata.get_task_id(self.rqdata.taskData.getfn_id(dep), idependtask.replace("_setscene", ""))
-                    if taskid is None:
-                        bb.msg.fatal("RunQueue", "Task %s_setscene depends upon non-existent task %s:%s" % (self.rqdata.get_user_idstring(task), dep, idependtask))
+                    deptid = depfn + ":" + idependtask.replace("_setscene", "")
+                    if deptid not in self.rqdata.runtaskentries:
+                        bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
 
-                    if not self.rqdata.runq_setscene.index(taskid) in self.sq_harddeps:
-                        self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)] = set()
-                    self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)].add(self.rqdata.runq_setscene.index(task))
+                    if not deptid in self.sq_harddeps:
+                        self.sq_harddeps[deptid] = set()
+                    self.sq_harddeps[deptid].add(tid)
 
-                    sq_revdeps_squash[self.rqdata.runq_setscene.index(task)].add(self.rqdata.runq_setscene.index(taskid))
+                    sq_revdeps_squash[tid].add(deptid)
                     # Have to zero this to avoid circular dependencies
-                    sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
+                    sq_revdeps_squash[deptid] = set()
 
         for task in self.sq_harddeps:
              for dep in self.sq_harddeps[task]:
@@ -1897,19 +1866,19 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask), sq_revdeps_squash[task]))
 
 
-        self.sq_deps = []
+        self.sq_deps = {}
         self.sq_revdeps = sq_revdeps_squash
         self.sq_revdeps2 = copy.deepcopy(self.sq_revdeps)
 
-        for task in range(len(self.sq_revdeps)):
-            self.sq_deps.append(set())
-        for task in range(len(self.sq_revdeps)):
-            for dep in self.sq_revdeps[task]:
+        for tid in self.sq_revdeps:
+            self.sq_deps[tid] = set()
+        for tid in self.sq_revdeps:
+            for dep in self.sq_revdeps[tid]:
                 self.sq_deps[dep].add(task)
 
-        for task in range(len(self.sq_revdeps)):
-            if len(self.sq_revdeps[task]) == 0:
-                self.runq_buildable.add(task)
+        for tid in self.sq_revdeps:
+            if len(self.sq_revdeps[tid]) == 0:
+                self.runq_buildable.add(tid)
 
         self.outrightfail = []
         if self.rq.hashvalidate:
@@ -1920,35 +1889,35 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             sq_task = []
             noexec = []
             stamppresent = []
-            for task in range(len(self.sq_revdeps)):
-                realtask = self.rqdata.runq_setscene[task]
-                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
-                taskname = self.rqdata.runq_task[realtask]
+            for tid in self.sq_revdeps:
+                fn = fn_from_tid(tid)
+                taskname = taskname_from_tid(tid)
+
                 taskdep = self.rqdata.dataCache.task_deps[fn]
 
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                    noexec.append(task)
-                    self.task_skip(task)
+                    noexec.append(tid)
+                    self.task_skip(tid)
                     bb.build.make_stamp(taskname + "_setscene", self.rqdata.dataCache, fn)
                     continue
 
-                if self.rq.check_stamp_task(realtask, taskname + "_setscene", cache=self.stampcache):
-                    logger.debug(2, 'Setscene stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(realtask))
-                    stamppresent.append(task)
-                    self.task_skip(task)
+                if self.rq.check_stamp_task(tid, taskname + "_setscene", cache=self.stampcache):
+                    logger.debug(2, 'Setscene stamp current for task %s', tid)
+                    stamppresent.append(tid)
+                    self.task_skip(tid)
                     continue
 
-                if self.rq.check_stamp_task(realtask, taskname, recurse = True, cache=self.stampcache):
-                    logger.debug(2, 'Normal stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(realtask))
-                    stamppresent.append(task)
-                    self.task_skip(task)
+                if self.rq.check_stamp_task(tid, taskname, recurse = True, cache=self.stampcache):
+                    logger.debug(2, 'Normal stamp current for task %s', tid)
+                    stamppresent.append(tid)
+                    self.task_skip(tid)
                     continue
 
                 sq_fn.append(fn)
                 sq_hashfn.append(self.rqdata.dataCache.hashfn[fn])
-                sq_hash.append(self.rqdata.runq_hash[realtask])
+                sq_hash.append(self.rqdata.runtaskentries[tid].hash)
                 sq_taskname.append(taskname)
-                sq_task.append(task)
+                sq_task.append(tid)
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
             locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
             valid = bb.utils.better_eval(call, locs)
@@ -1957,12 +1926,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             for v in valid:
                 valid_new.append(sq_task[v])
 
-            for task in range(len(self.sq_revdeps)):
-                if task not in valid_new and task not in noexec:
-                    realtask = self.rqdata.runq_setscene[task]
-                    logger.debug(2, 'No package found, so skipping setscene task %s',
-                                 self.rqdata.get_user_idstring(realtask))
-                    self.outrightfail.append(task)
+            for tid in self.sq_revdeps:
+                if tid not in valid_new and tid not in noexec:
+                    logger.debug(2, 'No package found, so skipping setscene task %s', tid)
+                    self.outrightfail.append(tid)
 
         logger.info('Executing SetScene Tasks')
 
@@ -1971,9 +1938,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
     def scenequeue_updatecounters(self, task, fail = False):
         for dep in self.sq_deps[task]:
             if fail and task in self.sq_harddeps and dep in self.sq_harddeps[task]:
-                realtask = self.rqdata.runq_setscene[task]
-                realdep = self.rqdata.runq_setscene[dep]
-                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (self.rqdata.get_user_idstring(realtask), self.rqdata.get_user_idstring(realdep)))
+                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.scenequeue_updatecounters(dep, fail)
                 continue
             if task not in self.sq_revdeps2[dep]:
@@ -1990,10 +1955,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         completed dependencies as buildable
         """
 
-        index = self.rqdata.runq_setscene[task]
-        logger.debug(1, 'Found task %s which could be accelerated',
-                        self.rqdata.get_user_idstring(index))
-
+        logger.debug(1, 'Found task %s which could be accelerated', task)
         self.scenequeue_covered.add(task)
         self.scenequeue_updatecounters(task)
 
@@ -2013,7 +1975,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.runq_buildable.add(task)
         self.stats.taskCompleted()
         self.stats.taskSkipped()
-        index = self.rqdata.runq_setscene[task]
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
@@ -2034,20 +1995,19 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         task = None
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
-            for nexttask in range(self.stats.total):
+            for nexttask in self.rqdata.runq_setscene_tids:
                 if nexttask in self.runq_buildable and nexttask not in self.runq_running:
                     if nexttask in self.unskippable:
-                        logger.debug(2, "Setscene task %s is unskippable" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))                      
+                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
-                        realtask = self.rqdata.runq_setscene[nexttask]
-                        fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
+                        fn = fn_from_tid(nexttask)
                         foundtarget = False
                         for target in self.rqdata.target_pairs:
-                            if target[0] == fn and target[1] == self.rqdata.runq_task[realtask]:
+                            if target[0] == fn and target[1] == taskname_from_tid(nexttask):
                                 foundtarget = True
                                 break
                         if not foundtarget:
-                            logger.debug(2, "Skipping setscene for task %s" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))
+                            logger.debug(2, "Skipping setscene for task %s" % nexttask)
                             self.task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
@@ -2057,25 +2017,21 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     task = nexttask
                     break
         if task is not None:
-            realtask = self.rqdata.runq_setscene[task]
-            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
-
-            taskname = self.rqdata.runq_task[realtask] + "_setscene"
-            if self.rq.check_stamp_task(realtask, self.rqdata.runq_task[realtask], recurse = True, cache=self.stampcache):
-                logger.debug(2, 'Stamp for underlying task %s(%s) is current, so skipping setscene variant',
-                             task, self.rqdata.get_user_idstring(realtask))
+            fn = fn_from_tid(task)
+            taskname = taskname_from_tid(task) + "_setscene"
+            if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
+                logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
                 self.task_failoutright(task)
                 return True
 
             if self.cooker.configuration.force:
                 for target in self.rqdata.target_pairs:
-                    if target[0] == fn and target[1] == self.rqdata.runq_task[realtask]:
+                    if target[0] == fn and target[1] == taskname_from_tid(task):
                         self.task_failoutright(task)
                         return True
 
-            if self.rq.check_stamp_task(realtask, taskname, cache=self.stampcache):
-                logger.debug(2, 'Setscene stamp current task %s(%s), so skip it and its dependencies',
-                             task, self.rqdata.get_user_idstring(realtask))
+            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
+                logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
                 self.task_skip(task)
                 return True
 
@@ -2086,10 +2042,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
+                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
                 self.rq.fakeworker.stdin.flush()
             else:
-                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
+                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
                 self.rq.worker.stdin.flush()
 
             self.runq_running.add(task)
@@ -2111,7 +2067,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         oldcovered = self.scenequeue_covered
         self.rq.scenequeue_covered = set()
         for task in oldcovered:
-            self.rq.scenequeue_covered.add(self.rqdata.runq_setscene[task])
+            self.rq.scenequeue_covered.add(task)
 
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 
@@ -2123,8 +2079,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         return True
 
     def runqueue_process_waitpid(self, task, status):
-        task = self.rq.rqdata.runq_setscene.index(task)
-
         RunQueueExecute.runqueue_process_waitpid(self, task, status)
 
 class TaskFailure(Exception):
@@ -2151,9 +2105,9 @@ class runQueueEvent(bb.event.Event):
     """
     def __init__(self, task, stats, rq):
         self.taskid = task
-        self.taskstring = rq.rqdata.get_user_idstring(task)
-        self.taskname = rq.rqdata.get_task_name(task)
-        self.taskfile = rq.rqdata.get_task_file(task)
+        self.taskstring = task
+        self.taskname = taskname_from_tid(task)
+        self.taskfile = fn_from_tid(task)
         self.taskhash = rq.rqdata.get_task_hash(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
@@ -2164,11 +2118,10 @@ class sceneQueueEvent(runQueueEvent):
     """
     def __init__(self, task, stats, rq, noexec=False):
         runQueueEvent.__init__(self, task, stats, rq)
-        realtask = rq.rqdata.runq_setscene[task]
-        self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
-        self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
-        self.taskfile = rq.rqdata.get_task_file(realtask)
-        self.taskhash = rq.rqdata.get_task_hash(realtask)
+        self.taskstring = task + "_setscene"
+        self.taskname = taskname_from_tid(task) + "_setscene"
+        self.taskfile = fn_from_tid(task)
+        self.taskhash = rq.rqdata.get_task_hash(task)
 
 class runQueueTaskStarted(runQueueEvent):
     """
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 65628c8..d8bdbca 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -37,27 +37,24 @@ def re_match_strings(target, strings):
     return any(name == target or re.match(name, target)
                for name in strings)
 
+class TaskEntry:
+    def __init__(self):
+        self.tdepends = []
+        self.idepends = []
+        self.irdepends = []
+
 class TaskData:
     """
     BitBake Task Data implementation
     """
     def __init__(self, abort = True, tryaltconfigs = False, skiplist = None, allowincomplete = False):
-        self.build_names_index = []
-        self.run_names_index = []
-        self.fn_index = []
-
         self.build_targets = {}
         self.run_targets = {}
 
         self.external_targets = []
 
-        self.tasks_fnid = []
-        self.tasks_name = []
-        self.tasks_tdepends = []
-        self.tasks_idepends = []
-        self.tasks_irdepends = []
-        # Cache to speed up task ID lookups
-        self.tasks_lookup = {}
+        self.seenfns = []
+        self.taskentries = {}
 
         self.depids = {}
         self.rdepids = {}
@@ -66,7 +63,7 @@ class TaskData:
 
         self.failed_deps = []
         self.failed_rdeps = []
-        self.failed_fnids = []
+        self.failed_fns = []
 
         self.abort = abort
         self.tryaltconfigs = tryaltconfigs
@@ -74,88 +71,6 @@ class TaskData:
 
         self.skiplist = skiplist
 
-    def getbuild_id(self, name):
-        """
-        Return an ID number for the build target name.
-        If it doesn't exist, create one.
-        """
-        if not name in self.build_names_index:
-            self.build_names_index.append(name)
-            return len(self.build_names_index) - 1
-
-        return self.build_names_index.index(name)
-
-    def getrun_id(self, name):
-        """
-        Return an ID number for the run target name.
-        If it doesn't exist, create one.
-        """
-        if not name in self.run_names_index:
-            self.run_names_index.append(name)
-            return len(self.run_names_index) - 1
-
-        return self.run_names_index.index(name)
-
-    def getfn_id(self, name):
-        """
-        Return an ID number for the filename.
-        If it doesn't exist, create one.
-        """
-        if not name in self.fn_index:
-            self.fn_index.append(name)
-            return len(self.fn_index) - 1
-
-        return self.fn_index.index(name)
-
-    def gettask_ids(self, fnid):
-        """
-        Return an array of the ID numbers matching a given fnid.
-        """
-        ids = []
-        if fnid in self.tasks_lookup:
-            for task in self.tasks_lookup[fnid]:
-                ids.append(self.tasks_lookup[fnid][task])
-        return ids
-
-    def gettask_id_fromfnid(self, fnid, task):
-        """
-        Return an ID number for the task matching fnid and task.
-        """
-        if fnid in self.tasks_lookup:
-            if task in self.tasks_lookup[fnid]:
-                return self.tasks_lookup[fnid][task]
-
-        return None
-
-    def gettask_id(self, fn, task, create = True):
-        """
-        Return an ID number for the task matching fn and task.
-        If it doesn't exist, create one by default.
-        Optionally return None instead.
-        """
-        fnid = self.getfn_id(fn)
-
-        if fnid in self.tasks_lookup:
-            if task in self.tasks_lookup[fnid]:
-                return self.tasks_lookup[fnid][task]
-
-        if not create:
-            return None
-
-        self.tasks_name.append(task)
-        self.tasks_fnid.append(fnid)
-        self.tasks_tdepends.append([])
-        self.tasks_idepends.append([])
-        self.tasks_irdepends.append([])
-
-        listid = len(self.tasks_name) - 1
-
-        if fnid not in self.tasks_lookup:
-            self.tasks_lookup[fnid] = {}
-        self.tasks_lookup[fnid][task] = listid
-
-        return listid
-
     def add_tasks(self, fn, dataCache):
         """
         Add tasks for a given fn to the database
@@ -163,29 +78,31 @@ class TaskData:
 
         task_deps = dataCache.task_deps[fn]
 
-        fnid = self.getfn_id(fn)
-
-        if fnid in self.failed_fnids:
+        if fn in self.failed_fns:
             bb.msg.fatal("TaskData", "Trying to re-add a failed file? Something is broken...")
 
         # Check if we've already seen this fn
-        if fnid in self.tasks_fnid:
+        if fn in self.seenfns:
             return
 
+        self.seenfns.append(fn)
+
         self.add_extra_deps(fn, dataCache)
 
         for task in task_deps['tasks']:
 
+            tid = "%s:%s" % (fn, task)
+            self.taskentries[tid] = TaskEntry()
+
             # Work out task dependencies
             parentids = []
             for dep in task_deps['parents'][task]:
                 if dep not in task_deps['tasks']:
                     bb.debug(2, "Not adding dependeny of %s on %s since %s does not exist" % (task, dep, dep))
                     continue
-                parentid = self.gettask_id(fn, dep)
+                parentid = "%s:%s" % (fn, dep)
                 parentids.append(parentid)
-            taskid = self.gettask_id(fn, task)
-            self.tasks_tdepends[taskid].extend(parentids)
+            self.taskentries[tid].tdepends.extend(parentids)
 
             # Touch all intertask dependencies
             if 'depends' in task_deps and task in task_deps['depends']:
@@ -194,29 +111,30 @@ class TaskData:
                     if dep:
                         if ":" not in dep:
                             bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'depends' should be specified in the form 'packagename:task'" % (fn, dep))
-                        ids.append(((self.getbuild_id(dep.split(":")[0])), dep.split(":")[1]))
-                self.tasks_idepends[taskid].extend(ids)
+                        ids.append(((dep.split(":")[0]), dep.split(":")[1]))
+                        self.seen_build_target(dep.split(":")[0])
+                self.taskentries[tid].idepends.extend(ids)
             if 'rdepends' in task_deps and task in task_deps['rdepends']:
                 ids = []
                 for dep in task_deps['rdepends'][task].split():
                     if dep:
                         if ":" not in dep:
                             bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'rdepends' should be specified in the form 'packagename:task'" % (fn, dep))
-                        ids.append(((self.getrun_id(dep.split(":")[0])), dep.split(":")[1]))
-                self.tasks_irdepends[taskid].extend(ids)
-
+                        ids.append(((dep.split(":")[0]), dep.split(":")[1]))
+                        self.seen_run_target(dep.split(":")[0])
+                self.taskentries[tid].irdepends.extend(ids)
 
         # Work out build dependencies
-        if not fnid in self.depids:
-            dependids = {}
+        if not fn in self.depids:
+            dependids = set()
             for depend in dataCache.deps[fn]:
-                dependids[self.getbuild_id(depend)] = None
-            self.depids[fnid] = dependids.keys()
+                dependids.add(depend)
+            self.depids[fn] = list(dependids)
             logger.debug(2, "Added dependencies %s for %s", str(dataCache.deps[fn]), fn)
 
         # Work out runtime dependencies
-        if not fnid in self.rdepids:
-            rdependids = {}
+        if not fn in self.rdepids:
+            rdependids = set()
             rdepends = dataCache.rundeps[fn]
             rrecs = dataCache.runrecs[fn]
             rdependlist = []
@@ -224,24 +142,26 @@ class TaskData:
             for package in rdepends:
                 for rdepend in rdepends[package]:
                     rdependlist.append(rdepend)
-                    rdependids[self.getrun_id(rdepend)] = None
+                    rdependids.add(rdepend)
             for package in rrecs:
                 for rdepend in rrecs[package]:
                     rreclist.append(rdepend)
-                    rdependids[self.getrun_id(rdepend)] = None
+                    rdependids.add(rdepend)
             if rdependlist:
                 logger.debug(2, "Added runtime dependencies %s for %s", str(rdependlist), fn)
             if rreclist:
                 logger.debug(2, "Added runtime recommendations %s for %s", str(rreclist), fn)
-            self.rdepids[fnid] = rdependids.keys()
+            self.rdepids[fn] = list(rdependids)
 
-        for dep in self.depids[fnid]:
+        for dep in self.depids[fn]:
+            self.seen_build_target(dep)
             if dep in self.failed_deps:
-                self.fail_fnid(fnid)
+                self.fail_fn(fn)
                 return
-        for dep in self.rdepids[fnid]:
+        for dep in self.rdepids[fn]:
+            self.seen_run_target(dep)
             if dep in self.failed_rdeps:
-                self.fail_fnid(fnid)
+                self.fail_fn(fn)
                 return
 
     def add_extra_deps(self, fn, dataCache):
@@ -263,9 +183,7 @@ class TaskData:
         """
         Have we a build target matching this name?
         """
-        targetid = self.getbuild_id(target)
-
-        if targetid in self.build_targets:
+        if target in self.build_targets and self.build_targets[target]:
             return True
         return False
 
@@ -273,50 +191,54 @@ class TaskData:
         """
         Have we a runtime target matching this name?
         """
-        targetid = self.getrun_id(target)
-
-        if targetid in self.run_targets:
+        if target in self.run_targets and self.run_targets[target]:
             return True
         return False
 
+    def seen_build_target(self, name):
+        """
+        Maintain a list of build targets
+        """
+        if name not in self.build_targets:
+            self.build_targets[name] = []
+
     def add_build_target(self, fn, item):
         """
         Add a build target.
         If already present, append the provider fn to the list
         """
-        targetid = self.getbuild_id(item)
-        fnid = self.getfn_id(fn)
-
-        if targetid in self.build_targets:
-            if fnid in self.build_targets[targetid]:
+        if item in self.build_targets:
+            if fn in self.build_targets[item]:
                 return
-            self.build_targets[targetid].append(fnid)
+            self.build_targets[item].append(fn)
             return
-        self.build_targets[targetid] = [fnid]
+        self.build_targets[item] = [fn]
+
+    def seen_run_target(self, name):
+        """
+        Maintain a list of runtime build targets
+        """
+        if name not in self.run_targets:
+            self.run_targets[name] = []
 
     def add_runtime_target(self, fn, item):
         """
         Add a runtime target.
         If already present, append the provider fn to the list
         """
-        targetid = self.getrun_id(item)
-        fnid = self.getfn_id(fn)
-
-        if targetid in self.run_targets:
-            if fnid in self.run_targets[targetid]:
+        if item in self.run_targets:
+            if fn in self.run_targets[item]:
                 return
-            self.run_targets[targetid].append(fnid)
+            self.run_targets[item].append(fn)
             return
-        self.run_targets[targetid] = [fnid]
+        self.run_targets[item] = [fn]
 
-    def mark_external_target(self, item):
+    def mark_external_target(self, target):
         """
         Mark a build target as being externally requested
         """
-        targetid = self.getbuild_id(item)
-
-        if targetid not in self.external_targets:
-            self.external_targets.append(targetid)
+        if target not in self.external_targets:
+            self.external_targets.append(target)
 
     def get_unresolved_build_targets(self, dataCache):
         """
@@ -324,12 +246,12 @@ class TaskData:
         are unknown.
         """
         unresolved = []
-        for target in self.build_names_index:
+        for target in self.build_targets:
             if re_match_strings(target, dataCache.ignored_dependencies):
                 continue
-            if self.build_names_index.index(target) in self.failed_deps:
+            if target in self.failed_deps:
                 continue
-            if not self.have_build_target(target):
+            if not self.build_targets[target]:
                 unresolved.append(target)
         return unresolved
 
@@ -339,12 +261,12 @@ class TaskData:
         are unknown.
         """
         unresolved = []
-        for target in self.run_names_index:
+        for target in self.run_targets:
             if re_match_strings(target, dataCache.ignored_dependencies):
                 continue
-            if self.run_names_index.index(target) in self.failed_rdeps:
+            if target in self.failed_rdeps:
                 continue
-            if not self.have_runtime_target(target):
+            if not self.run_targets[target]:
                 unresolved.append(target)
         return unresolved
 
@@ -352,50 +274,26 @@ class TaskData:
         """
         Return a list of providers of item
         """
-        targetid = self.getbuild_id(item)
+        return self.build_targets[item]
 
-        return self.build_targets[targetid]
-
-    def get_dependees(self, itemid):
+    def get_dependees(self, item):
         """
         Return a list of targets which depend on item
         """
         dependees = []
-        for fnid in self.depids:
-            if itemid in self.depids[fnid]:
-                dependees.append(fnid)
-        return dependees
-
-    def get_dependees_str(self, item):
-        """
-        Return a list of targets which depend on item as a user readable string
-        """
-        itemid = self.getbuild_id(item)
-        dependees = []
-        for fnid in self.depids:
-            if itemid in self.depids[fnid]:
-                dependees.append(self.fn_index[fnid])
+        for fn in self.depids:
+            if item in self.depids[fn]:
+                dependees.append(fn)
         return dependees
 
-    def get_rdependees(self, itemid):
+    def get_rdependees(self, item):
         """
         Return a list of targets which depend on runtime item
         """
         dependees = []
-        for fnid in self.rdepids:
-            if itemid in self.rdepids[fnid]:
-                dependees.append(fnid)
-        return dependees
-
-    def get_rdependees_str(self, item):
-        """
-        Return a list of targets which depend on runtime item as a user readable string
-        """
-        itemid = self.getrun_id(item)
-        dependees = []
-        for fnid in self.rdepids:
-            if itemid in self.rdepids[fnid]:
-                dependees.append(self.fn_index[fnid])
+        for fn in self.rdepids:
+            if item in self.rdepids[fn]:
+                dependees.append(fn)
         return dependees
 
     def get_reasons(self, item, runtime=False):
@@ -431,7 +329,7 @@ class TaskData:
         except bb.providers.NoProvider:
             if self.abort:
                 raise
-            self.remove_buildtarget(self.getbuild_id(item))
+            self.remove_buildtarget(item)
 
         self.mark_external_target(item)
 
@@ -453,7 +351,7 @@ class TaskData:
                 new = dataCache.pkg_fn[fn] + " RPROVIDES " + item
                 if new not in close_matches:
                     close_matches.append(new)
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item), close_matches=close_matches), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees(item), reasons=self.get_reasons(item), close_matches=close_matches), cfgData)
             raise bb.providers.NoProvider(item)
 
         if self.have_build_target(item):
@@ -462,10 +360,10 @@ class TaskData:
         all_p = dataCache.providers[item]
 
         eligible, foundUnique = bb.providers.filterProviders(all_p, item, cfgData, dataCache)
-        eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
+        eligible = [p for p in eligible if not p in self.failed_fns]
 
         if not eligible:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=["No eligible PROVIDERs exist for '%s'" % item]), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees(item), reasons=["No eligible PROVIDERs exist for '%s'" % item]), cfgData)
             raise bb.providers.NoProvider(item)
 
         if len(eligible) > 1 and foundUnique == False:
@@ -477,8 +375,7 @@ class TaskData:
             self.consider_msgs_cache.append(item)
 
         for fn in eligible:
-            fnid = self.getfn_id(fn)
-            if fnid in self.failed_fnids:
+            if fn in self.failed_fns:
                 continue
             logger.debug(2, "adding %s to satisfy %s", fn, item)
             self.add_build_target(fn, item)
@@ -502,14 +399,14 @@ class TaskData:
         all_p = bb.providers.getRuntimeProviders(dataCache, item)
 
         if not all_p:
-            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item), reasons=self.get_reasons(item, True)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees(item), reasons=self.get_reasons(item, True)), cfgData)
             raise bb.providers.NoRProvider(item)
 
         eligible, numberPreferred = bb.providers.filterProvidersRunTime(all_p, item, cfgData, dataCache)
-        eligible = [p for p in eligible if not self.getfn_id(p) in self.failed_fnids]
+        eligible = [p for p in eligible if not p in self.failed_fns]
 
         if not eligible:
-            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees_str(item), reasons=["No eligible RPROVIDERs exist for '%s'" % item]), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, runtime=True, dependees=self.get_rdependees(item), reasons=["No eligible RPROVIDERs exist for '%s'" % item]), cfgData)
             raise bb.providers.NoRProvider(item)
 
         if len(eligible) > 1 and numberPreferred == 0:
@@ -531,82 +428,80 @@ class TaskData:
 
         # run through the list until we find one that we can build
         for fn in eligible:
-            fnid = self.getfn_id(fn)
-            if fnid in self.failed_fnids:
+            if fn in self.failed_fns:
                 continue
             logger.debug(2, "adding '%s' to satisfy runtime '%s'", fn, item)
             self.add_runtime_target(fn, item)
             self.add_tasks(fn, dataCache)
 
-    def fail_fnid(self, fnid, missing_list=None):
+    def fail_fn(self, fn, missing_list=None):
         """
         Mark a file as failed (unbuildable)
         Remove any references from build and runtime provider lists
 
         missing_list, A list of missing requirements for this target
         """
-        if fnid in self.failed_fnids:
+        if fn in self.failed_fns:
             return
         if not missing_list:
             missing_list = []
-        logger.debug(1, "File '%s' is unbuildable, removing...", self.fn_index[fnid])
-        self.failed_fnids.append(fnid)
+        logger.debug(1, "File '%s' is unbuildable, removing...", fn)
+        self.failed_fns.append(fn)
         for target in self.build_targets:
-            if fnid in self.build_targets[target]:
-                self.build_targets[target].remove(fnid)
+            if fn in self.build_targets[target]:
+                self.build_targets[target].remove(fn)
                 if len(self.build_targets[target]) == 0:
                     self.remove_buildtarget(target, missing_list)
         for target in self.run_targets:
-            if fnid in self.run_targets[target]:
-                self.run_targets[target].remove(fnid)
+            if fn in self.run_targets[target]:
+                self.run_targets[target].remove(fn)
                 if len(self.run_targets[target]) == 0:
                     self.remove_runtarget(target, missing_list)
 
-    def remove_buildtarget(self, targetid, missing_list=None):
+    def remove_buildtarget(self, target, missing_list=None):
         """
         Mark a build target as failed (unbuildable)
         Trigger removal of any files that have this as a dependency
         """
         if not missing_list:
-            missing_list = [self.build_names_index[targetid]]
+            missing_list = [target]
         else:
-            missing_list = [self.build_names_index[targetid]] + missing_list
-        logger.verbose("Target '%s' is unbuildable, removing...\nMissing or unbuildable dependency chain was: %s", self.build_names_index[targetid], missing_list)
-        self.failed_deps.append(targetid)
-        dependees = self.get_dependees(targetid)
-        for fnid in dependees:
-            self.fail_fnid(fnid, missing_list)
-        for taskid in range(len(self.tasks_idepends)):
-            idepends = self.tasks_idepends[taskid]
-            for (idependid, idependtask) in idepends:
-                if idependid == targetid:
-                    self.fail_fnid(self.tasks_fnid[taskid], missing_list)
-
-        if self.abort and targetid in self.external_targets:
-            target = self.build_names_index[targetid]
+            missing_list = [target] + missing_list
+        logger.verbose("Target '%s' is unbuildable, removing...\nMissing or unbuildable dependency chain was: %s", target, missing_list)
+        self.failed_deps.append(target)
+        dependees = self.get_dependees(target)
+        for fn in dependees:
+            self.fail_fn(fn, missing_list)
+        for tid in self.taskentries:
+            for (idepend, idependtask) in self.taskentries[tid].idepends:
+                if idepend == target:
+                    fn = tid.rsplit(":",1)[0]
+                    self.fail_fn(fn, missing_list)
+
+        if self.abort and target in self.external_targets:
             logger.error("Required build target '%s' has no buildable providers.\nMissing or unbuildable dependency chain was: %s", target, missing_list)
             raise bb.providers.NoProvider(target)
 
-    def remove_runtarget(self, targetid, missing_list=None):
+    def remove_runtarget(self, target, missing_list=None):
         """
         Mark a run target as failed (unbuildable)
         Trigger removal of any files that have this as a dependency
         """
         if not missing_list:
-            missing_list = [self.run_names_index[targetid]]
+            missing_list = [target]
         else:
-            missing_list = [self.run_names_index[targetid]] + missing_list
-
-        logger.info("Runtime target '%s' is unbuildable, removing...\nMissing or unbuildable dependency chain was: %s", self.run_names_index[targetid], missing_list)
-        self.failed_rdeps.append(targetid)
-        dependees = self.get_rdependees(targetid)
-        for fnid in dependees:
-            self.fail_fnid(fnid, missing_list)
-        for taskid in range(len(self.tasks_irdepends)):
-            irdepends = self.tasks_irdepends[taskid]
-            for (idependid, idependtask) in irdepends:
-                if idependid == targetid:
-                    self.fail_fnid(self.tasks_fnid[taskid], missing_list)
+            missing_list = [target] + missing_list
+
+        logger.info("Runtime target '%s' is unbuildable, removing...\nMissing or unbuildable dependency chain was: %s", target, missing_list)
+        self.failed_rdeps.append(target)
+        dependees = self.get_rdependees(target)
+        for fn in dependees:
+            self.fail_fn(fn, missing_list)
+        for tid in self.taskentries:
+            for (idepend, idependtask) in self.taskentries[tid].irdepends:
+                if idepend == target:
+                    fn = tid.rsplit(":",1)[0]
+                    self.fail_fn(fn, missing_list)
 
     def add_unresolved(self, cfgData, dataCache):
         """
@@ -620,17 +515,16 @@ class TaskData:
                     self.add_provider_internal(cfgData, dataCache, target)
                     added = added + 1
                 except bb.providers.NoProvider:
-                    targetid = self.getbuild_id(target)
-                    if self.abort and targetid in self.external_targets and not self.allowincomplete:
+                    if self.abort and target in self.external_targets and not self.allowincomplete:
                         raise
                     if not self.allowincomplete:
-                        self.remove_buildtarget(targetid)
+                        self.remove_buildtarget(target)
             for target in self.get_unresolved_run_targets(dataCache):
                 try:
                     self.add_rprovider(cfgData, dataCache, target)
                     added = added + 1
                 except (bb.providers.NoRProvider, bb.providers.MultipleRProvider):
-                    self.remove_runtarget(self.getrun_id(target))
+                    self.remove_runtarget(target)
             logger.debug(1, "Resolved " + str(added) + " extra dependencies")
             if added == 0:
                 break
@@ -638,13 +532,13 @@ class TaskData:
 
     def get_providermap(self, prefix=None):
         provmap = {}
-        for name in self.build_names_index:
+        for name in self.build_targets:
             if prefix and not name.startswith(prefix):
                 continue
             if self.have_build_target(name):
                 provider = self.get_provider(name)
                 if provider:
-                    provmap[name] = self.fn_index[provider[0]]
+                    provmap[name] = provider[0]
         return provmap
 
     def dump_data(self):
@@ -652,39 +546,37 @@ class TaskData:
         Dump some debug information on the internal data structures
         """
         logger.debug(3, "build_names:")
-        logger.debug(3, ", ".join(self.build_names_index))
+        logger.debug(3, ", ".join(self.build_targets))
 
         logger.debug(3, "run_names:")
-        logger.debug(3, ", ".join(self.run_names_index))
+        logger.debug(3, ", ".join(self.run_targets))
 
         logger.debug(3, "build_targets:")
-        for buildid in range(len(self.build_names_index)):
-            target = self.build_names_index[buildid]
+        for target in self.build_targets:
             targets = "None"
-            if buildid in self.build_targets:
-                targets = self.build_targets[buildid]
-            logger.debug(3, " (%s)%s: %s", buildid, target, targets)
+            if target in self.build_targets:
+                targets = self.build_targets[target]
+            logger.debug(3, " %s: %s", target, targets)
 
         logger.debug(3, "run_targets:")
-        for runid in range(len(self.run_names_index)):
-            target = self.run_names_index[runid]
+        for target in self.run_targets:
             targets = "None"
-            if runid in self.run_targets:
-                targets = self.run_targets[runid]
-            logger.debug(3, " (%s)%s: %s", runid, target, targets)
+            if target in self.run_targets:
+                targets = self.run_targets[target]
+            logger.debug(3, " %s: %s", target, targets)
 
         logger.debug(3, "tasks:")
-        for task in range(len(self.tasks_name)):
-            logger.debug(3, " (%s)%s - %s: %s",
-                       task,
-                       self.fn_index[self.tasks_fnid[task]],
-                       self.tasks_name[task],
-                       self.tasks_tdepends[task])
+        for tid in self.taskentries:
+            logger.debug(3, " %s: %s %s %s",
+                       tid,
+                       self.taskentries[tid].idepends,
+                       self.taskentries[tid].irdepends,
+                       self.taskentries[tid].tdepends)
 
         logger.debug(3, "dependency ids (per fn):")
-        for fnid in self.depids:
-            logger.debug(3, " %s %s: %s", fnid, self.fn_index[fnid], self.depids[fnid])
+        for fn in self.depids:
+            logger.debug(3, " %s: %s", fn, self.depids[fn])
 
         logger.debug(3, "runtime dependency ids (per fn):")
-        for fnid in self.rdepids:
-            logger.debug(3, " %s %s: %s", fnid, self.fn_index[fnid], self.rdepids[fnid])
+        for fn in self.rdepids:
+            logger.debug(3, " %s: %s", fn, self.rdepids[fn])



