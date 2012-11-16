Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TZO6D-0001mL-1a for bitbake-devel@lists.openembedded.org;
	Fri, 16 Nov 2012 16:44:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAGFUw7h000702
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2012 15:30:58 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32677-06 for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2012 15:30:54 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAGFUpNB000695
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Nov 2012 15:30:53 GMT
Message-ID: <1353079852.3709.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 16 Nov 2012 15:30:52 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue: Allow partial setscene task coverage
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 16 Nov 2012 15:44:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When the setscene code was originally written it was thought that we'd
allow "partial" coverage. For example, if we just want to build the target
"bash:do_populate_sysroot" and its available from sstate, it makes no sense
to install gcc-cross's sstate package as its simply not needed.

Due to various other issues in the codebase, this functionality was
disabled/removed to allow the setscene code and sstate to stabilise and allow
us to concentrate on other problems.

The time has now come to enable "partial" coverage. There are two major changes
in this patch:

a) Creation of an unskippable list. This lists direct dependencies of
   build targets and hence things that cannot be skipped.

b) Addition of a handler which looks at a given setscene target and what depends
   on it and then decides whether its necessary.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 75797e2..0c7dfec 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -785,6 +785,7 @@ class RunQueue:
         self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY", True) or "perfile"
         self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION", True) or None
         self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION", True) or None
+        self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID", True) or None
 
         self.state = runQueuePrepare
 
@@ -1161,6 +1162,26 @@ class RunQueueExecute:
 
         return pid, pipein, pipeout
 
+    def check_dependencies(self, task, taskdeps, setscene = False):
+        if not self.rq.depvalidate:
+            return False
+
+        taskdata = {}
+        taskdeps.add(task)
+        for dep in taskdeps:
+            if setscene:
+                depid = self.rqdata.runq_setscene[dep]
+            else:
+                depid = dep
+            fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[depid]]
+            pn = self.rqdata.dataCache.pkg_fn[fn]
+            taskname = self.rqdata.runq_task[depid]
+            taskdata[dep] = [pn, taskname, fn]
+        call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
+        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.configuration.data }
+        valid = bb.utils.better_eval(call, locs)
+        return valid
+
 class RunQueueExecuteDummy(RunQueueExecute):
     def __init__(self, rq):
         self.rq = rq
@@ -1198,16 +1219,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
 
                 if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered) and task not in self.rq.scenequeue_notcovered:
-                    ok = True
-                    for revdep in self.rqdata.runq_revdeps[task]:
-                        if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
-                            logger.debug(1, 'Found "bad" dep %s (%s) for %s (%s)' % (revdep, self.rqdata.get_user_idstring(revdep), task, self.rqdata.get_user_idstring(task)))
-
-                            ok = False
-                            break
-                    if ok:
-                        found = True
-                        self.rq.scenequeue_covered.add(task)
+                    found = True
+                    self.rq.scenequeue_covered.add(task)
 
         logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))
 
@@ -1408,6 +1421,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         self.scenequeue_covered = set()
         self.scenequeue_notcovered = set()
+        self.scenequeue_notneeded = set()
 
         # If we don't have any setscene functions, skip this step
         if len(self.rqdata.runq_setscene) == 0:
@@ -1417,7 +1431,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         self.stats = RunQueueStats(len(self.rqdata.runq_setscene))
 
-        endpoints = {}
         sq_revdeps = []
         sq_revdeps_new = []
         sq_revdeps_squash = []
@@ -1432,12 +1445,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.runq_complete.append(0)
             self.runq_buildable.append(0)
 
+        # First process the chains up to the first setscene task.
+        endpoints = {}
         for task in xrange(len(self.rqdata.runq_fnid)):
             sq_revdeps.append(copy.copy(self.rqdata.runq_revdeps[task]))
             sq_revdeps_new.append(set())
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
                 endpoints[task] = set()
 
+        # Secondly process the chains between setscene tasks.
         for task in self.rqdata.runq_setscene:
             for dep in self.rqdata.runq_depends[task]:
                     if dep not in endpoints:
@@ -1453,6 +1469,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 if sq_revdeps_new[point]:
                     tasks |= sq_revdeps_new[point]
                 sq_revdeps_new[point] = set()
+                if point in self.rqdata.runq_setscene:
+                    sq_revdeps_new[point] = tasks
                 for dep in self.rqdata.runq_depends[point]:
                     if point in sq_revdeps[dep]:
                         sq_revdeps[dep].remove(point)
@@ -1465,6 +1483,42 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
         process_endpoints(endpoints)
 
+        # Build a list of setscene tasks which as "unskippable"
+        # These are direct endpoints referenced by the build
+        endpoints2 = {}
+        sq_revdeps2 = []
+        sq_revdeps_new2 = []
+        def process_endpoints2(endpoints):
+            newendpoints = {}
+            for point, task in endpoints.items():
+                tasks = set([point])
+                if task:
+                    tasks |= task
+                if sq_revdeps_new2[point]:
+                    tasks |= sq_revdeps_new2[point]
+                sq_revdeps_new2[point] = set()
+                if point in self.rqdata.runq_setscene:
+                    sq_revdeps_new2[point] = tasks
+                for dep in self.rqdata.runq_depends[point]:
+                    if point in sq_revdeps2[dep]:
+                        sq_revdeps2[dep].remove(point)
+                    if tasks:
+                        sq_revdeps_new2[dep] |= tasks
+                    if (len(sq_revdeps2[dep]) == 0 or len(sq_revdeps_new2[dep]) != 0) and dep not in self.rqdata.runq_setscene:
+                        newendpoints[dep] = tasks
+            if len(newendpoints) != 0:
+                process_endpoints2(newendpoints)
+        for task in xrange(len(self.rqdata.runq_fnid)):
+            sq_revdeps2.append(copy.copy(self.rqdata.runq_revdeps[task]))
+            sq_revdeps_new2.append(set())
+            if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
+                endpoints2[task] = set()
+        process_endpoints2(endpoints2)
+        self.unskippable = []
+        for task in self.rqdata.runq_setscene:
+            if sq_revdeps_new2[task]:
+                self.unskippable.append(self.rqdata.runq_setscene.index(task))
+
         for task in xrange(len(self.rqdata.runq_fnid)):
             if task in self.rqdata.runq_setscene:
                 deps = set()
@@ -1625,6 +1679,13 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             # Find the next setscene to run
             for nexttask in xrange(self.stats.total):
                 if self.runq_buildable[nexttask] == 1 and self.runq_running[nexttask] != 1:
+                    if nexttask in self.unskippable:
+                        logger.debug(2, "Setscene task %s is unskippable" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))                      
+                    if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
+                        logger.debug(2, "Skipping setscene for task %s" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))
+                        self.task_skip(nexttask)
+                        self.scenequeue_notneeded.add(nexttask)
+                        return True
                     task = nexttask
                     break
         if task is not None:




