Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB9EE0218
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 15:36:13 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.66475.1767108971085075500
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Dec 2025 07:36:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=o24wJUIu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-202512301536093e9dd1831f00020795-usx5it@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202512301536093e9dd1831f00020795
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 30 Dec 2025 16:36:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0JbiQyVEUFqsaDRMddTV74mVpmRCz8G1eRpTR7vEM9A=;
 b=o24wJUIu54jJ/E2M/z+wuZDHsDrywZfMfDv+Z6Q/uaO4ikwO5AWS22htT7QkDO28YYPGvE
 ZAWb9rx+E9WrLpdxJb94AUwPuoVz1rblCXFqbY2GtaB/jiRs5QbePiG4gPKHjMBoyxdmWODs
 13JjthWfDIUn36D233RYDPvz81ntzBdpXuaIRD61X5qBOqqLM4sNt/HkIl1B+jqDW6jPoMeE
 37wD+wR4Q0c/rvTMLtSSnHqelI3TdOpyJlID0A60EgqiNo1Ox5JtQ2kyOuttErPCb7PFjtXd
 Yxtd4mEKfdaYn6pY7JrkI+U1738actL0u7dGIZgVecYdMi0Z3zz99I1Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 1/2] bitbake: add --skip-deps option to re-run tasks directly
Date: Tue, 30 Dec 2025 16:32:29 +0100
Message-ID: <20251230153539.3940266-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251230153539.3940266-1-adrian.freihofer@siemens.com>
References: <20251230153539.3940266-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 15:36:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18662

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Introduce a --skip-deps CLI flag that instructs bitbake to run the
specified task immediately for the given recipe(s) without performing
the usual dependency resolution and run-queue scheduling.

This is aimed at development workflows (for example devtool ide-sdk)
where an IDE or developer wants to re-run a single task (such as
do_install) and then deploy or debug it on a target without rebuilding
or executing unrelated dependent tasks.

Usage example:
  bitbake <recipe> -c <task> --skip-deps --force

Alternative implementations considered:
- Generating a simple script which executes a run.do_install script
  directly from the temp workdir. This was rejected because it leads to
  code duplication and would need to be maintained separately. While
  this works for simple tasks it would probably lead to issues with more
  complex tasks. Also, spawning pseudo would require a second implementation.
- Use bitbake to dump the tinfoil message which is sent to the worker into
  a file. Later a script could start a single worker and feed this file
  directly to the worker. This is much more complex to implement and
  maintain than it might look at first sight.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/cookerdata.py |   3 +-
 lib/bb/main.py       |   5 +
 lib/bb/runqueue.py   | 319 ++++++++++++++++++++++---------------------
 3 files changed, 169 insertions(+), 158 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 22ac95eac..f86970df8 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -62,7 +62,7 @@ class ConfigParameters(object):
                   "dry_run", "dump_signatures",
                   "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout",
-                  "nosetscene", "setsceneonly", "skipsetscene",
+                  "nosetscene", "setsceneonly", "skipsetscene", "skipdeps",
                   "runall", "runonly", "writeeventlog"]:
             options[o] = getattr(self.options, o)
 
@@ -130,6 +130,7 @@ class CookerConfiguration(object):
         self.profile = False
         self.nosetscene = False
         self.setsceneonly = False
+        self.skipdeps = False
         self.skipsetscene = False
         self.invalidate_stamp = False
         self.dump_signatures = []
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 597cb2784..0e5cb3622 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -196,6 +196,11 @@ def create_bitbake_parser():
                         dest="setsceneonly",
                         help="Only run setscene tasks, don't run any real tasks.")
 
+    task_group.add_argument("--skip-deps", action="store_true",
+                        dest="skipdeps",
+                        help="Run the specified task directly without dependencies. "
+                             "Parses the recipe and executes the task immediately, "
+                             "skipping the runqueue and dependency resolution. ")
 
     exec_group.add_argument("-n", "--dry-run", action="store_true",
                         help="Don't execute, just go through the motions.")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a880a0d54..81520c5f3 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -737,98 +737,103 @@ class RunQueueData:
                         bb.fatal("Task mcdepends on non-existent task %s" % (newdep))
                     taskData[mc].taskentries[tid].tdepends.append(newdep)
 
-        for mc in taskData:
-            for tid in taskData[mc].taskentries:
-
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-                #runtid = build_tid(mc, fn, taskname)
-
-                #logger.debug2("Processing %s,%s:%s", mc, fn, taskname)
-
-                depends = set()
-                task_deps = self.dataCaches[mc].task_deps[taskfn]
-
+        if self.cooker.configuration.skipdeps:
+            for (mc, target, task, fn) in self.targets:
+                tid = build_tid(mc, fn, task)
                 self.runtaskentries[tid] = RunTaskEntry()
+        else:
+            for mc in taskData:
+                for tid in taskData[mc].taskentries:
 
-                if fn in taskData[mc].failed_fns:
-                    continue
+                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+                    #runtid = build_tid(mc, fn, taskname)
 
-                # We add multiconfig dependencies before processing internal task deps (tdepends)
-                if 'mcdepends' in task_deps and taskname in task_deps['mcdepends']:
-                    add_mc_dependencies(mc, tid)
+                    #logger.debug2("Processing %s,%s:%s", mc, fn, taskname)
 
-                # Resolve task internal dependencies
-                #
-                # e.g. addtask before X after Y
-                for t in taskData[mc].taskentries[tid].tdepends:
-                    (depmc, depfn, deptaskname, _) = split_tid_mcfn(t)
-                    depends.add(build_tid(depmc, depfn, deptaskname))
+                    depends = set()
+                    task_deps = self.dataCaches[mc].task_deps[taskfn]
 
-                # Resolve 'deptask' dependencies
-                #
-                # e.g. do_sometask[deptask] = "do_someothertask"
-                # (makes sure sometask runs after someothertask of all DEPENDS)
-                if 'deptask' in task_deps and taskname in task_deps['deptask']:
-                    tasknames = task_deps['deptask'][taskname].split()
-                    add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
+                    self.runtaskentries[tid] = RunTaskEntry()
 
-                # Resolve 'rdeptask' dependencies
-                #
-                # e.g. do_sometask[rdeptask] = "do_someothertask"
-                # (makes sure sometask runs after someothertask of all RDEPENDS)
-                if 'rdeptask' in task_deps and taskname in task_deps['rdeptask']:
-                    tasknames = task_deps['rdeptask'][taskname].split()
-                    add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
+                    if fn in taskData[mc].failed_fns:
+                        continue
 
-                # Resolve inter-task dependencies
-                #
-                # e.g. do_sometask[depends] = "targetname:do_someothertask"
-                # (makes sure sometask runs after targetname's someothertask)
-                idepends = taskData[mc].taskentries[tid].idepends
-                for (depname, idependtask) in idepends:
-                    if depname in taskData[mc].build_targets and taskData[mc].build_targets[depname] and not depname in taskData[mc].failed_deps:
-                        # Won't be in build_targets if ASSUME_PROVIDED
-                        depdata = taskData[mc].build_targets[depname][0]
-                        if depdata is not None:
-                            t = depdata + ":" + idependtask
-                            depends.add(t)
-                            if t not in taskData[mc].taskentries:
-                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
-                irdepends = taskData[mc].taskentries[tid].irdepends
-                for (depname, idependtask) in irdepends:
-                    if depname in taskData[mc].run_targets:
-                        # Won't be in run_targets if ASSUME_PROVIDED
-                        if not taskData[mc].run_targets[depname]:
-                            continue
-                        depdata = taskData[mc].run_targets[depname][0]
-                        if depdata is not None:
-                            t = depdata + ":" + idependtask
-                            depends.add(t)
-                            if t not in taskData[mc].taskentries:
-                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
+                    # We add multiconfig dependencies before processing internal task deps (tdepends)
+                    if 'mcdepends' in task_deps and taskname in task_deps['mcdepends']:
+                        add_mc_dependencies(mc, tid)
 
-                # Resolve recursive 'recrdeptask' dependencies (Part A)
-                #
-                # e.g. do_sometask[recrdeptask] = "do_someothertask"
-                # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
-                # We cover the recursive part of the dependencies below
-                if 'recrdeptask' in task_deps and taskname in task_deps['recrdeptask']:
-                    tasknames = task_deps['recrdeptask'][taskname].split()
-                    recursivetasks[tid] = tasknames
-                    add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
-                    add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
-                    if taskname in tasknames:
-                        recursivetasksselfref.add(tid)
+                    # Resolve task internal dependencies
+                    #
+                    # e.g. addtask before X after Y
+                    for t in taskData[mc].taskentries[tid].tdepends:
+                        (depmc, depfn, deptaskname, _) = split_tid_mcfn(t)
+                        depends.add(build_tid(depmc, depfn, deptaskname))
 
-                    if 'recideptask' in task_deps and taskname in task_deps['recideptask']:
-                        recursiveitasks[tid] = []
-                        for t in task_deps['recideptask'][taskname].split():
-                            newdep = build_tid(mc, fn, t)
-                            recursiveitasks[tid].append(newdep)
+                    # Resolve 'deptask' dependencies
+                    #
+                    # e.g. do_sometask[deptask] = "do_someothertask"
+                    # (makes sure sometask runs after someothertask of all DEPENDS)
+                    if 'deptask' in task_deps and taskname in task_deps['deptask']:
+                        tasknames = task_deps['deptask'][taskname].split()
+                        add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
 
-                self.runtaskentries[tid].depends = depends
-                # Remove all self references
-                self.runtaskentries[tid].depends.discard(tid)
+                    # Resolve 'rdeptask' dependencies
+                    #
+                    # e.g. do_sometask[rdeptask] = "do_someothertask"
+                    # (makes sure sometask runs after someothertask of all RDEPENDS)
+                    if 'rdeptask' in task_deps and taskname in task_deps['rdeptask']:
+                        tasknames = task_deps['rdeptask'][taskname].split()
+                        add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
+
+                    # Resolve inter-task dependencies
+                    #
+                    # e.g. do_sometask[depends] = "targetname:do_someothertask"
+                    # (makes sure sometask runs after targetname's someothertask)
+                    idepends = taskData[mc].taskentries[tid].idepends
+                    for (depname, idependtask) in idepends:
+                        if depname in taskData[mc].build_targets and taskData[mc].build_targets[depname] and not depname in taskData[mc].failed_deps:
+                            # Won't be in build_targets if ASSUME_PROVIDED
+                            depdata = taskData[mc].build_targets[depname][0]
+                            if depdata is not None:
+                                t = depdata + ":" + idependtask
+                                depends.add(t)
+                                if t not in taskData[mc].taskentries:
+                                    bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
+                    irdepends = taskData[mc].taskentries[tid].irdepends
+                    for (depname, idependtask) in irdepends:
+                        if depname in taskData[mc].run_targets:
+                            # Won't be in run_targets if ASSUME_PROVIDED
+                            if not taskData[mc].run_targets[depname]:
+                                continue
+                            depdata = taskData[mc].run_targets[depname][0]
+                            if depdata is not None:
+                                t = depdata + ":" + idependtask
+                                depends.add(t)
+                                if t not in taskData[mc].taskentries:
+                                    bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskname, fn, idependtask, depdata))
+
+                    # Resolve recursive 'recrdeptask' dependencies (Part A)
+                    #
+                    # e.g. do_sometask[recrdeptask] = "do_someothertask"
+                    # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
+                    # We cover the recursive part of the dependencies below
+                    if 'recrdeptask' in task_deps and taskname in task_deps['recrdeptask']:
+                        tasknames = task_deps['recrdeptask'][taskname].split()
+                        recursivetasks[tid] = tasknames
+                        add_build_dependencies(taskData[mc].depids[taskfn], tasknames, depends, mc)
+                        add_runtime_dependencies(taskData[mc].rdepids[taskfn], tasknames, depends, mc)
+                        if taskname in tasknames:
+                            recursivetasksselfref.add(tid)
+
+                        if 'recideptask' in task_deps and taskname in task_deps['recideptask']:
+                            recursiveitasks[tid] = []
+                            for t in task_deps['recideptask'][taskname].split():
+                                newdep = build_tid(mc, fn, t)
+                                recursiveitasks[tid].append(newdep)
+
+                    self.runtaskentries[tid].depends = depends
+                    # Remove all self references
+                    self.runtaskentries[tid].depends.discard(tid)
 
         #self.dump_data()
 
@@ -848,89 +853,89 @@ class RunQueueData:
         #     c) combine the total list of dependencies in cumulativedeps
         #     d) optimise by pre-truncating 'task' off the items in cumulativedeps (keeps items in sets lower)
 
+        if not self.cooker.configuration.skipdeps:
+            revdeps = {}
+            deps = {}
+            cumulativedeps = {}
+            for tid in self.runtaskentries:
+                deps[tid] = set(self.runtaskentries[tid].depends)
+                revdeps[tid] = set()
+                cumulativedeps[tid] = set()
+            # Generate a temp list of reverse dependencies
+            for tid in self.runtaskentries:
+                for dep in self.runtaskentries[tid].depends:
+                    revdeps[dep].add(tid)
+            # Find the dependency chain endpoints
+            endpoints = set()
+            for tid in self.runtaskentries:
+                if not deps[tid]:
+                    endpoints.add(tid)
+            # Iterate the chains collating dependencies
+            while endpoints:
+                next = set()
+                for tid in endpoints:
+                    for dep in revdeps[tid]:
+                        cumulativedeps[dep].add(fn_from_tid(tid))
+                        cumulativedeps[dep].update(cumulativedeps[tid])
+                        if tid in deps[dep]:
+                            deps[dep].remove(tid)
+                        if not deps[dep]:
+                            next.add(dep)
+                endpoints = next
+            #for tid in deps:
+            #    if deps[tid]:
+            #        bb.warn("Sanity test failure, dependencies left for %s (%s)" % (tid, deps[tid]))
 
-        revdeps = {}
-        deps = {}
-        cumulativedeps = {}
-        for tid in self.runtaskentries:
-            deps[tid] = set(self.runtaskentries[tid].depends)
-            revdeps[tid] = set()
-            cumulativedeps[tid] = set()
-        # Generate a temp list of reverse dependencies
-        for tid in self.runtaskentries:
-            for dep in self.runtaskentries[tid].depends:
-                revdeps[dep].add(tid)
-        # Find the dependency chain endpoints
-        endpoints = set()
-        for tid in self.runtaskentries:
-            if not deps[tid]:
-                endpoints.add(tid)
-        # Iterate the chains collating dependencies
-        while endpoints:
-            next = set()
-            for tid in endpoints:
-                for dep in revdeps[tid]:
-                    cumulativedeps[dep].add(fn_from_tid(tid))
-                    cumulativedeps[dep].update(cumulativedeps[tid])
-                    if tid in deps[dep]:
-                        deps[dep].remove(tid)
-                    if not deps[dep]:
-                        next.add(dep)
-            endpoints = next
-        #for tid in deps:
-        #    if deps[tid]:
-        #        bb.warn("Sanity test failure, dependencies left for %s (%s)" % (tid, deps[tid]))
+            # Loop here since recrdeptasks can depend upon other recrdeptasks and we have to
+            # resolve these recursively until we aren't adding any further extra dependencies
+            extradeps = True
+            while extradeps:
+                extradeps = 0
+                for tid in recursivetasks:
+                    tasknames = recursivetasks[tid]
 
-        # Loop here since recrdeptasks can depend upon other recrdeptasks and we have to
-        # resolve these recursively until we aren't adding any further extra dependencies
-        extradeps = True
-        while extradeps:
-            extradeps = 0
-            for tid in recursivetasks:
-                tasknames = recursivetasks[tid]
+                    totaldeps = set(self.runtaskentries[tid].depends)
+                    if tid in recursiveitasks:
+                        totaldeps.update(recursiveitasks[tid])
+                        for dep in recursiveitasks[tid]:
+                            if dep not in self.runtaskentries:
+                                continue
+                            totaldeps.update(self.runtaskentries[dep].depends)
 
-                totaldeps = set(self.runtaskentries[tid].depends)
-                if tid in recursiveitasks:
-                    totaldeps.update(recursiveitasks[tid])
-                    for dep in recursiveitasks[tid]:
-                        if dep not in self.runtaskentries:
-                            continue
-                        totaldeps.update(self.runtaskentries[dep].depends)
+                    deps = set()
+                    for dep in totaldeps:
+                        if dep in cumulativedeps:
+                            deps.update(cumulativedeps[dep])
 
-                deps = set()
-                for dep in totaldeps:
-                    if dep in cumulativedeps:
-                        deps.update(cumulativedeps[dep])
+                    for t in deps:
+                        for taskname in tasknames:
+                            newtid = t + ":" + taskname
+                            if newtid == tid:
+                                continue
+                            if newtid in self.runtaskentries and newtid not in self.runtaskentries[tid].depends:
+                                extradeps += 1
+                                self.runtaskentries[tid].depends.add(newtid)
 
-                for t in deps:
-                    for taskname in tasknames:
-                        newtid = t + ":" + taskname
-                        if newtid == tid:
-                            continue
-                        if newtid in self.runtaskentries and newtid not in self.runtaskentries[tid].depends:
-                            extradeps += 1
-                            self.runtaskentries[tid].depends.add(newtid)
+                    # Handle recursive tasks which depend upon other recursive tasks
+                    deps = set()
+                    for dep in self.runtaskentries[tid].depends.intersection(recursivetasks):
+                        deps.update(self.runtaskentries[dep].depends.difference(self.runtaskentries[tid].depends))
+                    for newtid in deps:
+                        for taskname in tasknames:
+                            if not newtid.endswith(":" + taskname):
+                                continue
+                            if newtid in self.runtaskentries:
+                                extradeps += 1
+                                self.runtaskentries[tid].depends.add(newtid)
 
-                # Handle recursive tasks which depend upon other recursive tasks
-                deps = set()
-                for dep in self.runtaskentries[tid].depends.intersection(recursivetasks):
-                    deps.update(self.runtaskentries[dep].depends.difference(self.runtaskentries[tid].depends))
-                for newtid in deps:
-                    for taskname in tasknames:
-                        if not newtid.endswith(":" + taskname):
-                            continue
-                        if newtid in self.runtaskentries:
-                            extradeps += 1
-                            self.runtaskentries[tid].depends.add(newtid)
+                bb.debug(1, "Added %s recursive dependencies in this loop" % extradeps)
 
-            bb.debug(1, "Added %s recursive dependencies in this loop" % extradeps)
+            # Remove recrdeptask circular references so that do_a[recrdeptask] = "do_a do_b" can work
+            for tid in recursivetasksselfref:
+                self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
 
-        # Remove recrdeptask circular references so that do_a[recrdeptask] = "do_a do_b" can work
-        for tid in recursivetasksselfref:
-            self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
-
-        self.init_progress_reporter.next_stage()
-        bb.event.check_for_interrupts()
+            self.init_progress_reporter.next_stage()
+            bb.event.check_for_interrupts()
 
         #self.dump_data()
 
-- 
2.52.0


