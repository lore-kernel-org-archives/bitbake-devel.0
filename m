Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 10F2D6E744
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2014 22:50:42 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1AMocRO032272 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2014 22:50:38 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wm2uWJ8IjA-6 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2014 22:50:38 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1AMoYIP032269
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2014 22:50:35 GMT
Message-ID: <1392072628.7120.64.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 10 Feb 2014 22:50:28 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Fix setscene hard dependency problems
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
X-List-Received-Date: Mon, 10 Feb 2014 22:50:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Commit c54e738e2b5dc0d8e6fd8e93b284ed96e7a83051 added in the idea of hard dependencies
such as the case a setscene has a hard dependency on pseudo-native and that
dependency wasn't available from sstate for some reason.

Unfortunately the implementation was a bit too enthusiastic, causing rebuilds
of things when it wasn't necessary. A test case was:

bitbake quilt-native
bitbake quilt-native -c clean
bitbake <some-image>

and then you'd watch quilt-native get rebuilt for no good reason.

The clue to the problem is in the for loop where it never depends on
the item being iterated over.

The fix is to include the exact list of hard dependencies rather than
guessing. With these changes, the use case above works, the one in
the original commit also works.

This patch also adds in or cleans up various pieces of logging to
allow issues like this to be more easily debugged in future.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 26a0d86..a83fc6a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1637,7 +1637,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         sq_revdeps = []
         sq_revdeps_new = []
         sq_revdeps_squash = []
-        self.sq_harddeps = []
+        self.sq_harddeps = {}
 
         # We need to construct a dependency graph for the setscene functions. Intermediate
         # dependencies between the setscene tasks only complicate the code. This code
@@ -1748,15 +1748,19 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     dep = self.rqdata.taskData.fn_index[depdata]
                     taskid = self.rqdata.get_task_id(self.rqdata.taskData.getfn_id(dep), idependtask.replace("_setscene", ""))
                     if taskid is None:
-                        bb.msg.fatal("RunQueue", "Task %s:%s depends upon non-existent task %s:%s" % (self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realid]], self.rqdata.taskData.tasks_name[realid], dep, idependtask))
+                        bb.msg.fatal("RunQueue", "Task %s_setscene depends upon non-existent task %s:%s" % (self.self.rqdata.get_user_idstring(task), dep, idependtask))
+
+                    if not self.rqdata.runq_setscene.index(taskid) in self.sq_harddeps:
+                        self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)] = set()
+                    self.sq_harddeps[self.rqdata.runq_setscene.index(taskid)].add(self.rqdata.runq_setscene.index(task))
 
-                    self.sq_harddeps.append(self.rqdata.runq_setscene.index(taskid))
                     sq_revdeps_squash[self.rqdata.runq_setscene.index(task)].add(self.rqdata.runq_setscene.index(taskid))
                     # Have to zero this to avoid circular dependencies
                     sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
 
         #for task in xrange(len(sq_revdeps_squash)):
-        #    print "Task %s: %s.%s is %s " % (task, self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[self.rqdata.runq_setscene[task]]], self.rqdata.runq_task[self.rqdata.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
+        #    realtask = self.rqdata.runq_setscene[task]
+        #    bb.warn("Task %s: %s_setscene is %s " % (task, self.rqdata.get_user_idstring(realtask) , sq_revdeps_squash[task]))
 
         self.sq_deps = []
         self.sq_revdeps = sq_revdeps_squash
@@ -1830,7 +1834,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
     def scenequeue_updatecounters(self, task, fail = False):
         for dep in self.sq_deps[task]:
-            if fail and task in self.sq_harddeps:
+            if fail and task in self.sq_harddeps and dep in self.sq_harddeps[task]:
+                realtask = self.rqdata.runq_setscene[task]
+                realdep = self.rqdata.runq_setscene[dep]
+                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (self.rqdata.get_user_idstring(realtask), self.rqdata.get_user_idstring(realdep)))
                 continue
             self.sq_revdeps2[dep].remove(task)
             if len(self.sq_revdeps2[dep]) == 0:
@@ -1943,6 +1950,12 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.rq.read_workers()
             return self.rq.active_fds()
 
+        #for task in xrange(self.stats.total):
+        #    if self.runq_running[task] != 1:
+        #        buildable = self.runq_buildable[task]
+        #        revdeps = self.sq_revdeps[task]
+        #        bb.warn("Found we didn't run %s %s %s %s" % (task, buildable, str(revdeps), self.rqdata.get_user_idstring(self.rqdata.runq_setscene[task])))
+
         # Convert scenequeue_covered task numbers into full taskgraph ids
         oldcovered = self.scenequeue_covered
         self.rq.scenequeue_covered = set()



