Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjzRo-0001a3-DA for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jun 2012 23:06:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKtui9019628
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:55:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 19483-01 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:55:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RKtluJ019622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 21:55:48 +0100
Message-ID: <1340830550.23146.89.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jun 2012 21:55:50 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH v2] runqueue: Reimplement recrdepends so it works more correctly
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
X-List-Received-Date: Wed, 27 Jun 2012 21:06:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, recrdepends is extremely greedy. For example:

do_foo[rdepends] = "somedep:sometask"
addtask foo

which adds foo with *no* dependencies, will suddenly start appearing
as a dependency in every task which uses recrdepends. So far this has
been mildy annoying but we now have use cases where this makes no sense
at all.

This reworks the recrdepends code to avoid this problem. To do this we
can no longer collapse things into lists just based on file ID. The problem
is this code is extremely performance sensitive. The "preparing runqueue"
phase spends a lot of time in these recursive dependency calculations so any
change here could negatively impact the user experience.

As such, this code has been carefully tested on convoluted dependency trees
with operations like "time bitbake world -g". The net result of this change
and the preceding changes combined is a net speed up of these operations in
all cases measured.

Tests were made comparing "bitbake world -g" task-depends.dot before and after
this patch. There *are* differences for example -nativesdk do_build dependencies
on -native recipes are no longer present. All removed dependencies appear to
be sensible improvements to the system. The "rdepends" cross contamination
issue above is also fixed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c45287d..e927afb 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -375,9 +375,7 @@ class RunQueueData:
         """
 
         runq_build = []
-        recursive_tdepends = {}
-        runq_recrdepends = []
-        tdepends_fnid = {}
+        recursivetasks = {}
 
         taskData = self.taskData
 
@@ -423,9 +421,15 @@ class RunQueueData:
                     if taskid is not None:
                         depends.add(taskid)
 
+        def add_resolved_dependencies(depids, tasknames, depends):
+            for depid in depids:
+                for taskname in tasknames:
+                    taskid = taskData.gettask_id_fromfnid(depid, taskname)
+                    if taskid is not None:
+                        depends.add(taskid)
+
         for task in xrange(len(taskData.tasks_name)):
             depends = set()
-            recrdepends = []
             fnid = taskData.tasks_fnid[task]
             fn = taskData.fn_index[fnid]
             task_deps = self.dataCache.task_deps[fn]
@@ -459,8 +463,6 @@ class RunQueueData:
                 #
                 # e.g. do_sometask[depends] = "targetname:do_someothertask"
                 # (makes sure sometask runs after targetname's someothertask)
-                if fnid not in tdepends_fnid:
-                    tdepends_fnid[fnid] = set()
                 idepends = taskData.tasks_idepends[task]
                 for (depid, idependtask) in idepends:
                     if depid in taskData.build_targets:
@@ -471,8 +473,6 @@ class RunQueueData:
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
                             depends.add(taskid)
-                            if depdata != fnid:
-                                tdepends_fnid[fnid].add(taskid)
                 irdepends = taskData.tasks_irdepends[task]
                 for (depid, idependtask) in irdepends:
                     if depid in taskData.run_targets:
@@ -483,24 +483,17 @@ class RunQueueData:
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
                             depends.add(taskid)
-                            if depdata != fnid:
-                                tdepends_fnid[fnid].add(taskid)
 
-                # Resolve recursive 'recrdeptask' dependencies (A)
+                # Resolve recursive 'recrdeptask' dependencies (Part A)
                 #
                 # e.g. do_sometask[recrdeptask] = "do_someothertask"
                 # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
                 # We cover the recursive part of the dependencies below
                 if 'recrdeptask' in task_deps and taskData.tasks_name[task] in task_deps['recrdeptask']:
-                    for taskname in task_deps['recrdeptask'][taskData.tasks_name[task]].split():
-                        recrdepends.append(taskname)
-                        add_build_dependencies(taskData.depids[fnid], [taskname], depends)
-                        add_runtime_dependencies(taskData.rdepids[fnid], [taskname], depends)
-
-                # Rmove all self references
-                if task in depends:
-                    logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], depends)
-                    depends.remove(task)
+                    tasknames = task_deps['recrdeptask'][taskData.tasks_name[task]].split()
+                    recursivetasks[task] = tasknames
+                    add_build_dependencies(taskData.depids[fnid], tasknames, depends)
+                    add_runtime_dependencies(taskData.rdepids[fnid], tasknames, depends)
 
             self.runq_fnid.append(taskData.tasks_fnid[task])
             self.runq_task.append(taskData.tasks_name[task])
@@ -509,48 +502,39 @@ class RunQueueData:
             self.runq_hash.append("")
 
             runq_build.append(0)
-            runq_recrdepends.append(recrdepends)
 
-        #
-        # Build a list of recursive cumulative dependencies for each fnid
-        # We do this by fnid, since if A depends on some task in B
-        # we're interested in later tasks B's fnid might have but B itself
-        # doesn't depend on
-        #
-        # Algorithm is O(tasks) + O(tasks)*O(fnids)
-        #
-        reccumdepends = {}
-        for task in xrange(len(self.runq_fnid)):
-            fnid = self.runq_fnid[task]
-            if fnid not in reccumdepends:
-                if fnid in tdepends_fnid:
-                    reccumdepends[fnid] = tdepends_fnid[fnid]
-                else:
-                    reccumdepends[fnid] = set()
-            reccumdepends[fnid].update(self.runq_depends[task])
-        for task in xrange(len(self.runq_fnid)):
-            taskfnid = self.runq_fnid[task]
-            for fnid in reccumdepends:
-                if task in reccumdepends[fnid]:
-                    reccumdepends[fnid].add(task)
-                    if taskfnid in reccumdepends:
-                        reccumdepends[fnid].update(reccumdepends[taskfnid])
-
-
-        # Resolve recursive 'recrdeptask' dependencies (B)
+        # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
-        for task in xrange(len(self.runq_fnid)):
-            if len(runq_recrdepends[task]) > 0:
-                taskfnid = self.runq_fnid[task]
-                for dep in reccumdepends[taskfnid]:
-                    # Ignore self references
-                    if dep == task:
-                        continue
-                    for taskname in runq_recrdepends[task]:
-                        if taskData.tasks_name[dep] == taskname:
-                            self.runq_depends[task].add(dep)
+        # We need to do this separately since we need all of self.runq_depends to be complete before this is processed
+        extradeps = {}
+        for task in recursivetasks:
+            extradeps[task] = set()
+            tasknames = recursivetasks[task]
+            seendeps = set()
+            seenfnid = []
+
+            def generate_recdeps(t):
+                newdeps = set()
+                add_resolved_dependencies([taskData.tasks_fnid[t]], tasknames, newdeps)
+                extradeps[task].update(newdeps)
+                seendeps.add(t)
+                newdeps.add(t)
+                for i in newdeps:
+                    for n in self.runq_depends[i]:
+                        if n not in seendeps:
+                            generate_recdeps(n)
+            generate_recdeps(task)
+
+        for task in xrange(len(taskData.tasks_name)):
+            # Add in extra dependencies
+            if task in extradeps:
+                 self.runq_depends[task].update(extradeps[task])
+            # Remove all self references
+            if task in self.runq_depends[task]:
+                logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], self.runq_depends[task])
+                self.runq_depends[task].remove(task)
 
         # Step B - Mark all active tasks
         #




