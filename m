Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RSsRS-0004VF-LR
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Nov 2011 16:39:27 +0100
Received: by opal (Postfix, from userid 111)
	id A542510334; Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111122130839.A542510334@opal>
Date: Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/runqueue.py: Add BB_SETSCENE_VERIFY_FUNCTION hook
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
X-List-Received-Date: Tue, 22 Nov 2011 15:39:27 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 2f6d987d9957a5d713ce119c24c2e87540611f53
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=2f6d987d9957a5d713ce119c24c2e87540611f53

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Nov 21 14:34:23 2011 +0000

bitbake/runqueue.py: Add BB_SETSCENE_VERIFY_FUNCTION hook

The OE metadata has cases where it needs to prevent some setscene
functions from running. An example of this is where we know a task
is going to run do_configure (which would clean out do_populate_sysroot)
and hence we don't want do_populate_sysroot_setscene to run.

This change adds in a hook so that the metadata can allow any
such policy decision to filter back up to bitbake.

It removes the existing code which attempted to do this in a generic
way but failed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6cc6ab2..62b62dd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -767,6 +767,7 @@ class RunQueue:
 
         self.stamppolicy = bb.data.getVar("BB_STAMP_POLICY", cfgData, True) or "perfile"
         self.hashvalidate = bb.data.getVar("BB_HASHCHECK_FUNCTION", cfgData, True) or None
+        self.setsceneverify = bb.data.getVar("BB_SETSCENE_VERIFY_FUNCTION", cfgData, True) or None
 
         self.state = runQueuePrepare
 
@@ -1216,23 +1217,20 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     if found:
                         self.rq.scenequeue_covered.add(task)
 
-        # Detect when the real task needs to be run anyway by looking to see
-        # if any of its dependencies within the same package are scheduled
-        # to be run.
+        logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))
+
+        # Allow the metadata to elect for setscene tasks to run anyway
         covered_remove = set()
-        for task in self.rq.scenequeue_covered:
-            task_fnid = self.rqdata.runq_fnid[task]
-            for dep in self.rqdata.runq_depends[task]:
-                if self.rqdata.runq_fnid[dep] == task_fnid:
-                    if dep not in self.rq.scenequeue_covered:
-                        covered_remove.add(task)
-                        break
+        if self.rq.setsceneverify:
+            call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.configuration.data }
+            covered_remove = bb.utils.better_eval(call, locs)
 
         for task in covered_remove:
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
             taskname = self.rqdata.runq_task[task] + '_setscene'
             bb.build.del_stamp(taskname, self.rqdata.dataCache, fn)
-            logger.debug(1, 'Not skipping task %s because it will have to be run anyway', task)
+            logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
             self.rq.scenequeue_covered.remove(task)
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)



