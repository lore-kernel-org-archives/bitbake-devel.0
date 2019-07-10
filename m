Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 239C47EF5A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:24 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id y4so4248659wrm.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=7+0pBalobRJkyBb++0Qn75f6WJ3qletnRSvfMDI7Km4=;
	b=eWsooBqidLyfPX5una+2uOiTY1NjS0UxCPItYz4iCRf5W/Az64TSRZTb36cqzfxdj6
	KFz+jyzz9cDW2kNszorTRv4ZnByzRl3RA7YrIQBUhJGNLLcVlfNQVLrA7kaGWAKKp/W/
	fhZQHLgOFZs/D2b4qGVfdMTjeDVbKY23U1/S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7+0pBalobRJkyBb++0Qn75f6WJ3qletnRSvfMDI7Km4=;
	b=pdGiXTqwyF17D0WYHfgD1K+RaJULfxZhgQgiHeR3ibQTjsHILKXPnn4LFJ0+//sFsD
	YXkVoBAztBm83oJlM2fXTxrRVkZG0hvlyujtRLFV6epr7YWrqOogL/KPK8kbU5GYwBOG
	z9fcCqJJe9fBaRBDTA8OAs8yIlOOMTUCSXjIeVNqKI2bOLa5O2gRADFco1J5e3a4bfbf
	XxIuj5e9sYofwZPuh65e9Ohwgzs1k7mlcqUOe7DH2dCiwlmSNwHNm5YHyBTdUKX15gqQ
	iQ9NvDzowJmp+e2zjlYOem1/z3OFLFP2LQx69LNU0zlaFJI7AK1fsaFLPDo9DS56Q3+x
	4oyQ==
X-Gm-Message-State: APjAAAWjQCL0UFkSdoSgf2DUuFOXgvWpcL7PxxSSrt5WftFfZBQnyZMo
	0TppXenAyBSeAmkdPA1GO5VJLywjP10=
X-Google-Smtp-Source: APXvYqx3di0KnjQyDq1hAHPo1iyQv3yWxVAjL9/mwvgZ1loU/dizMBZIr1hvnHsxEJnJ2CdiXTFSug==
X-Received: by 2002:a5d:5644:: with SMTP id j4mr258288wrw.144.1562802865175;
	Wed, 10 Jul 2019 16:54:25 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:53:58 +0100
Message-Id: <20190710235420.23825-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 04/26] runqueue: Move scenequeue data generation to a separate function
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:25 -0000
Content-Transfer-Encoding: 8bit

Move the bulk of the scenequeue data generation to its own function
allowing for refactoring of the code.

Create the start of an object to represent this data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 457 +++++++++++++++++++++++----------------------
 1 file changed, 233 insertions(+), 224 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6ac9fb1678..b3116bce2c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2080,267 +2080,276 @@ class RunQueueExecuteTasks(RunQueueExecute):
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
-class RunQueueExecuteScenequeue(RunQueueExecute):
-    def __init__(self, rq):
-        RunQueueExecute.__init__(self, rq)
-
-        self.scenequeue_covered = set()
-        self.scenequeue_notcovered = set()
-        self.scenequeue_notneeded = set()
-
-        # If we don't have any setscene functions, skip this step
-        if len(self.rqdata.runq_setscene_tids) == 0:
-            rq.scenequeue_covered = set()
-            rq.scenequeue_notcovered = set()
-            rq.state = runQueueRunInit
-            return
-
-        self.stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
-
-        sq_revdeps = {}
-        sq_revdeps_new = {}
-        sq_revdeps_squash = {}
+class SQData(object):
+    def __init__(self):
         self.sq_harddeps = {}
         self.stamps = {}
+        self.unskippable = []
 
-        # We need to construct a dependency graph for the setscene functions. Intermediate
-        # dependencies between the setscene tasks only complicate the code. This code
-        # therefore aims to collapse the huge runqueue dependency tree into a smaller one
-        # only containing the setscene functions.
+def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
+
+    sq_revdeps = {}
+    sq_revdeps_new = {}
+    sq_revdeps_squash = {}
+
+    # We need to construct a dependency graph for the setscene functions. Intermediate
+    # dependencies between the setscene tasks only complicate the code. This code
+    # therefore aims to collapse the huge runqueue dependency tree into a smaller one
+    # only containing the setscene functions.
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # First process the chains up to the first setscene task.
+    endpoints = {}
+    for tid in rqdata.runtaskentries:
+        sq_revdeps[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
+        sq_revdeps_new[tid] = set()
+        if (len(sq_revdeps[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
+            #bb.warn("Added endpoint %s" % (tid))
+            endpoints[tid] = set()
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # Secondly process the chains between setscene tasks.
+    for tid in rqdata.runq_setscene_tids:
+        #bb.warn("Added endpoint 2 %s" % (tid))
+        for dep in rqdata.runtaskentries[tid].depends:
+                if tid in sq_revdeps[dep]:
+                    sq_revdeps[dep].remove(tid)
+                if dep not in endpoints:
+                    endpoints[dep] = set()
+                #bb.warn("  Added endpoint 3 %s" % (dep))
+                endpoints[dep].add(tid)
+
+    rqdata.init_progress_reporter.next_stage()
+
+    def process_endpoints(endpoints):
+        newendpoints = {}
+        for point, task in endpoints.items():
+            tasks = set()
+            if task:
+                tasks |= task
+            if sq_revdeps_new[point]:
+                tasks |= sq_revdeps_new[point]
+            sq_revdeps_new[point] = set()
+            if point in rqdata.runq_setscene_tids:
+                sq_revdeps_new[point] = tasks
+                tasks = set()
+                continue
+            for dep in rqdata.runtaskentries[point].depends:
+                if point in sq_revdeps[dep]:
+                    sq_revdeps[dep].remove(point)
+                if tasks:
+                    sq_revdeps_new[dep] |= tasks
+                if len(sq_revdeps[dep]) == 0 and dep not in rqdata.runq_setscene_tids:
+                    newendpoints[dep] = task
+        if len(newendpoints) != 0:
+            process_endpoints(newendpoints)
+
+    process_endpoints(endpoints)
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # Build a list of setscene tasks which are "unskippable"
+    # These are direct endpoints referenced by the build
+    endpoints2 = {}
+    sq_revdeps2 = {}
+    sq_revdeps_new2 = {}
+    def process_endpoints2(endpoints):
+        newendpoints = {}
+        for point, task in endpoints.items():
+            tasks = set([point])
+            if task:
+                tasks |= task
+            if sq_revdeps_new2[point]:
+                tasks |= sq_revdeps_new2[point]
+            sq_revdeps_new2[point] = set()
+            if point in rqdata.runq_setscene_tids:
+                sq_revdeps_new2[point] = tasks
+            for dep in rqdata.runtaskentries[point].depends:
+                if point in sq_revdeps2[dep]:
+                    sq_revdeps2[dep].remove(point)
+                if tasks:
+                    sq_revdeps_new2[dep] |= tasks
+                if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in rqdata.runq_setscene_tids:
+                    newendpoints[dep] = tasks
+        if len(newendpoints) != 0:
+            process_endpoints2(newendpoints)
+    for tid in rqdata.runtaskentries:
+        sq_revdeps2[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
+        sq_revdeps_new2[tid] = set()
+        if (len(sq_revdeps2[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
+            endpoints2[tid] = set()
+    process_endpoints2(endpoints2)
+    for tid in rqdata.runq_setscene_tids:
+        if sq_revdeps_new2[tid]:
+            sqdata.unskippable.append(tid)
+
+    rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
+
+    for taskcounter, tid in enumerate(rqdata.runtaskentries):
+        if tid in rqdata.runq_setscene_tids:
+            deps = set()
+            for dep in sq_revdeps_new[tid]:
+                deps.add(dep)
+            sq_revdeps_squash[tid] = deps
+        elif len(sq_revdeps_new[tid]) != 0:
+            bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+        rqdata.init_progress_reporter.update(taskcounter)
+
+    rqdata.init_progress_reporter.next_stage()
+
+    # Resolve setscene inter-task dependencies
+    # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
+    # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
+    for tid in rqdata.runq_setscene_tids:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            realtid = tid + "_setscene"
+            idepends = rqdata.taskData[mc].taskentries[realtid].idepends
+            sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", rqdata.dataCaches[mc], taskfn, noextra=True)
+            for (depname, idependtask) in idepends:
 
-        self.rqdata.init_progress_reporter.next_stage()
+                if depname not in rqdata.taskData[mc].build_targets:
+                    continue
 
-        # First process the chains up to the first setscene task.
-        endpoints = {}
-        for tid in self.rqdata.runtaskentries:
-            sq_revdeps[tid] = copy.copy(self.rqdata.runtaskentries[tid].revdeps)
-            sq_revdeps_new[tid] = set()
-            if (len(sq_revdeps[tid]) == 0) and tid not in self.rqdata.runq_setscene_tids:
-                #bb.warn("Added endpoint %s" % (tid))
-                endpoints[tid] = set()
+                depfn = rqdata.taskData[mc].build_targets[depname][0]
+                if depfn is None:
+                     continue
+                deptid = depfn + ":" + idependtask.replace("_setscene", "")
+                if deptid not in rqdata.runtaskentries:
+                    bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
 
-        self.rqdata.init_progress_reporter.next_stage()
+                if not deptid in sqdata.sq_harddeps:
+                    sqdata.sq_harddeps[deptid] = set()
+                sqdata.sq_harddeps[deptid].add(tid)
 
-        # Secondly process the chains between setscene tasks.
-        for tid in self.rqdata.runq_setscene_tids:
-            #bb.warn("Added endpoint 2 %s" % (tid))
-            for dep in self.rqdata.runtaskentries[tid].depends:
-                    if tid in sq_revdeps[dep]:
-                        sq_revdeps[dep].remove(tid)
-                    if dep not in endpoints:
-                        endpoints[dep] = set()
-                    #bb.warn("  Added endpoint 3 %s" % (dep))
-                    endpoints[dep].add(tid)
-
-        self.rqdata.init_progress_reporter.next_stage()
-
-        def process_endpoints(endpoints):
-            newendpoints = {}
-            for point, task in endpoints.items():
-                tasks = set()
-                if task:
-                    tasks |= task
-                if sq_revdeps_new[point]:
-                    tasks |= sq_revdeps_new[point]
-                sq_revdeps_new[point] = set()
-                if point in self.rqdata.runq_setscene_tids:
-                    sq_revdeps_new[point] = tasks
-                    tasks = set()
-                    continue
-                for dep in self.rqdata.runtaskentries[point].depends:
-                    if point in sq_revdeps[dep]:
-                        sq_revdeps[dep].remove(point)
-                    if tasks:
-                        sq_revdeps_new[dep] |= tasks
-                    if len(sq_revdeps[dep]) == 0 and dep not in self.rqdata.runq_setscene_tids:
-                        newendpoints[dep] = task
-            if len(newendpoints) != 0:
-                process_endpoints(newendpoints)
-
-        process_endpoints(endpoints)
-
-        self.rqdata.init_progress_reporter.next_stage()
-
-        # Build a list of setscene tasks which are "unskippable"
-        # These are direct endpoints referenced by the build
-        endpoints2 = {}
-        sq_revdeps2 = {}
-        sq_revdeps_new2 = {}
-        def process_endpoints2(endpoints):
-            newendpoints = {}
-            for point, task in endpoints.items():
-                tasks = set([point])
-                if task:
-                    tasks |= task
-                if sq_revdeps_new2[point]:
-                    tasks |= sq_revdeps_new2[point]
-                sq_revdeps_new2[point] = set()
-                if point in self.rqdata.runq_setscene_tids:
-                    sq_revdeps_new2[point] = tasks
-                for dep in self.rqdata.runtaskentries[point].depends:
-                    if point in sq_revdeps2[dep]:
-                        sq_revdeps2[dep].remove(point)
-                    if tasks:
-                        sq_revdeps_new2[dep] |= tasks
-                    if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in self.rqdata.runq_setscene_tids:
-                        newendpoints[dep] = tasks
-            if len(newendpoints) != 0:
-                process_endpoints2(newendpoints)
-        for tid in self.rqdata.runtaskentries:
-            sq_revdeps2[tid] = copy.copy(self.rqdata.runtaskentries[tid].revdeps)
-            sq_revdeps_new2[tid] = set()
-            if (len(sq_revdeps2[tid]) == 0) and tid not in self.rqdata.runq_setscene_tids:
-                endpoints2[tid] = set()
-        process_endpoints2(endpoints2)
-        self.unskippable = []
-        for tid in self.rqdata.runq_setscene_tids:
-            if sq_revdeps_new2[tid]:
-                self.unskippable.append(tid)
+                sq_revdeps_squash[tid].add(deptid)
+                # Have to zero this to avoid circular dependencies
+                sq_revdeps_squash[deptid] = set()
 
-        self.rqdata.init_progress_reporter.next_stage(len(self.rqdata.runtaskentries))
+    rqdata.init_progress_reporter.next_stage()
 
-        for taskcounter, tid in enumerate(self.rqdata.runtaskentries):
-            if tid in self.rqdata.runq_setscene_tids:
-                deps = set()
-                for dep in sq_revdeps_new[tid]:
-                    deps.add(dep)
-                sq_revdeps_squash[tid] = deps
-            elif len(sq_revdeps_new[tid]) != 0:
-                bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
-            self.rqdata.init_progress_reporter.update(taskcounter)
-
-        self.rqdata.init_progress_reporter.next_stage()
-
-        # Resolve setscene inter-task dependencies
-        # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
-        # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
-        for tid in self.rqdata.runq_setscene_tids:
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-                realtid = tid + "_setscene"
-                idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
-                self.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
-                for (depname, idependtask) in idepends:
+    for task in sqdata.sq_harddeps:
+        for dep in sqdata.sq_harddeps[task]:
+            sq_revdeps_squash[dep].add(task)
 
-                    if depname not in self.rqdata.taskData[mc].build_targets:
-                        continue
+    rqdata.init_progress_reporter.next_stage()
 
-                    depfn = self.rqdata.taskData[mc].build_targets[depname][0]
-                    if depfn is None:
-                         continue
-                    deptid = depfn + ":" + idependtask.replace("_setscene", "")
-                    if deptid not in self.rqdata.runtaskentries:
-                        bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
+    #for tid in sq_revdeps_squash:
+    #    for dep in sq_revdeps_squash[tid]:
+    #        data = data + "\n   %s" % dep
+    #    bb.warn("Task %s_setscene: is %s " % (tid, data
 
-                    if not deptid in self.sq_harddeps:
-                        self.sq_harddeps[deptid] = set()
-                    self.sq_harddeps[deptid].add(tid)
+    sqdata.sq_deps = {}
+    sqdata.sq_revdeps = sq_revdeps_squash
+    sqdata.sq_revdeps2 = copy.deepcopy(sqdata.sq_revdeps)
 
-                    sq_revdeps_squash[tid].add(deptid)
-                    # Have to zero this to avoid circular dependencies
-                    sq_revdeps_squash[deptid] = set()
+    for tid in sqdata.sq_revdeps:
+        sqdata.sq_deps[tid] = set()
+    for tid in sqdata.sq_revdeps:
+        for dep in sqdata.sq_revdeps[tid]:
+            sqdata.sq_deps[dep].add(tid)
 
-        self.rqdata.init_progress_reporter.next_stage()
+    rqdata.init_progress_reporter.next_stage()
 
-        for task in self.sq_harddeps:
-             for dep in self.sq_harddeps[task]:
-                 sq_revdeps_squash[dep].add(task)
+    for tid in sqdata.sq_revdeps:
+        if len(sqdata.sq_revdeps[tid]) == 0:
+            sqrq.runq_buildable.add(tid)
 
-        self.rqdata.init_progress_reporter.next_stage()
+    rqdata.init_progress_reporter.finish()
 
-        #for tid in sq_revdeps_squash:
-        #    for dep in sq_revdeps_squash[tid]:
-        #        data = data + "\n   %s" % dep
-        #    bb.warn("Task %s_setscene: is %s " % (tid, data
+    sqdata.outrightfail = []
+    if rq.hashvalidate:
+        sq_hash = []
+        sq_hashfn = []
+        sq_unihash = []
+        sq_fn = []
+        sq_taskname = []
+        sq_task = []
+        noexec = []
+        stamppresent = []
+        for tid in sqdata.sq_revdeps:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
-        self.sq_deps = {}
-        self.sq_revdeps = sq_revdeps_squash
-        self.sq_revdeps2 = copy.deepcopy(self.sq_revdeps)
+            taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
 
-        for tid in self.sq_revdeps:
-            self.sq_deps[tid] = set()
-        for tid in self.sq_revdeps:
-            for dep in self.sq_revdeps[tid]:
-                self.sq_deps[dep].add(tid)
+            if 'noexec' in taskdep and taskname in taskdep['noexec']:
+                noexec.append(tid)
+                sqrq.task_skip(tid)
+                bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
+                continue
 
-        self.rqdata.init_progress_reporter.next_stage()
+            if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
+                logger.debug(2, 'Setscene stamp current for task %s', tid)
+                stamppresent.append(tid)
+                sqrq.task_skip(tid)
+                continue
 
-        for tid in self.sq_revdeps:
-            if len(self.sq_revdeps[tid]) == 0:
-                self.runq_buildable.add(tid)
+            if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
+                logger.debug(2, 'Normal stamp current for task %s', tid)
+                stamppresent.append(tid)
+                sqrq.task_skip(tid)
+                continue
 
-        self.rqdata.init_progress_reporter.finish()
-
-        self.outrightfail = []
-        if self.rq.hashvalidate:
-            sq_hash = []
-            sq_hashfn = []
-            sq_unihash = []
-            sq_fn = []
-            sq_taskname = []
-            sq_task = []
-            noexec = []
-            stamppresent = []
-            for tid in self.sq_revdeps:
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            sq_fn.append(fn)
+            sq_hashfn.append(rqdata.dataCaches[mc].hashfn[taskfn])
+            sq_hash.append(rqdata.runtaskentries[tid].hash)
+            sq_unihash.append(rqdata.runtaskentries[tid].unihash)
+            sq_taskname.append(taskname)
+            sq_task.append(tid)
 
-                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+        cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
 
-                if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                    noexec.append(tid)
-                    self.task_skip(tid)
-                    bb.build.make_stamp(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn)
-                    continue
+        valid = rq.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
+                siginfo=False, sq_unihash=sq_unihash, d=cooker.data)
 
-                if self.rq.check_stamp_task(tid, taskname + "_setscene", cache=self.stampcache):
-                    logger.debug(2, 'Setscene stamp current for task %s', tid)
-                    stamppresent.append(tid)
-                    self.task_skip(tid)
-                    continue
+        cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
 
-                if self.rq.check_stamp_task(tid, taskname, recurse = True, cache=self.stampcache):
-                    logger.debug(2, 'Normal stamp current for task %s', tid)
-                    stamppresent.append(tid)
-                    self.task_skip(tid)
-                    continue
+        valid_new = stamppresent
+        for v in valid:
+            valid_new.append(sq_task[v])
 
-                sq_fn.append(fn)
-                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
-                sq_hash.append(self.rqdata.runtaskentries[tid].hash)
-                sq_unihash.append(self.rqdata.runtaskentries[tid].unihash)
-                sq_taskname.append(taskname)
-                sq_task.append(tid)
+        for tid in sqdata.sq_revdeps:
+            if tid not in valid_new and tid not in noexec:
+                logger.debug(2, 'No package found, so skipping setscene task %s', tid)
+                sqdata.outrightfail.append(tid)
 
-            self.cooker.data.setVar("BB_SETSCENE_STAMPCURRENT_COUNT", len(stamppresent))
 
-            valid = self.rq.validate_hash(sq_fn=sq_fn, sq_task=sq_taskname, sq_hash=sq_hash, sq_hashfn=sq_hashfn,
-                    siginfo=False, sq_unihash=sq_unihash, d=self.cooker.data)
+class RunQueueExecuteScenequeue(RunQueueExecute):
+    def __init__(self, rq):
+        RunQueueExecute.__init__(self, rq)
 
-            self.cooker.data.delVar("BB_SETSCENE_STAMPCURRENT_COUNT")
+        self.scenequeue_covered = set()
+        self.scenequeue_notcovered = set()
+        self.scenequeue_notneeded = set()
 
-            valid_new = stamppresent
-            for v in valid:
-                valid_new.append(sq_task[v])
+        # If we don't have any setscene functions, skip this step
+        if len(self.rqdata.runq_setscene_tids) == 0:
+            rq.scenequeue_covered = set()
+            rq.scenequeue_notcovered = set()
+            rq.state = runQueueRunInit
+            return
+
+        self.stats = RunQueueStats(len(self.rqdata.runq_setscene_tids))
 
-            for tid in self.sq_revdeps:
-                if tid not in valid_new and tid not in noexec:
-                    logger.debug(2, 'No package found, so skipping setscene task %s', tid)
-                    self.outrightfail.append(tid)
+        self.sqdata = SQData()
+        build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
         logger.info('Executing SetScene Tasks')
 
         self.rq.state = runQueueSceneRun
 
     def scenequeue_updatecounters(self, task, fail = False):
-        for dep in self.sq_deps[task]:
-            if fail and task in self.sq_harddeps and dep in self.sq_harddeps[task]:
+        for dep in self.sqdata.sq_deps[task]:
+            if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.scenequeue_updatecounters(dep, fail)
                 continue
-            if task not in self.sq_revdeps2[dep]:
+            if task not in self.sqdata.sq_revdeps2[dep]:
                 # May already have been removed by the fail case above
                 continue
-            self.sq_revdeps2[dep].remove(task)
-            if len(self.sq_revdeps2[dep]) == 0:
+            self.sqdata.sq_revdeps2[dep].remove(task)
+            if len(self.sqdata.sq_revdeps2[dep]) == 0:
                 self.runq_buildable.add(dep)
 
     def task_completeoutright(self, task):
@@ -2401,10 +2410,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.can_start_task():
             # Find the next setscene to run
             for nexttask in self.rqdata.runq_setscene_tids:
-                if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask in self.unskippable:
+                if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
+                    if nexttask in self.sqdata.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
-                    if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
+                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask], True):
                         fn = fn_from_tid(nexttask)
                         foundtarget = False
 
@@ -2415,7 +2424,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                             self.task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
-                    if nexttask in self.outrightfail:
+                    if nexttask in self.sqdata.outrightfail:
                         self.task_failoutright(nexttask)
                         return True
                     task = nexttask
@@ -2471,10 +2480,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        #for tid in self.sq_revdeps:
+        #for tid in self.sqdata.sq_revdeps:
         #    if tid not in self.runq_running:
         #        buildable = tid in self.runq_buildable
-        #        revdeps = self.sq_revdeps[tid]
+        #        revdeps = self.sqdata.sq_revdeps[tid]
         #        bb.warn("Found we didn't run %s %s %s" % (tid, buildable, str(revdeps)))
 
         self.rq.scenequeue_covered = self.scenequeue_covered
-- 
2.20.1


