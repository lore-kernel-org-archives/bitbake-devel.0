Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTCIq-0000Ll-GF
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 13:51:53 +0100
Received: by opal (Postfix, from userid 111)
	id 661C31032F; Wed, 23 Nov 2011 12:47:41 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111123124741.661C31032F@opal>
Date: Wed, 23 Nov 2011 12:47:41 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Ensure setscene tasks don' t break dependency order
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
X-List-Received-Date: Wed, 23 Nov 2011 12:51:53 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b7114d8e5d9b0720339bd5d24d243c0f2a7c1f3b
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b7114d8e5d9b0720339bd5d24d243c0f2a7c1f3b

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Nov 23 12:38:44 2011 +0000

runqueue.py: Ensure setscene tasks don't break dependency order

If A depends upon B which depends upon C and the setscene for B
succeeds but C is going to get rebuilt, we should wait for C to
try and build A but currently we don't.

This is due to the timing of when we run the task_skip() as this
triggers other tasks to become buildable. This patch moves the timing
of that call to a more appropriate place allowing dependencies to
behave as expected.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 62b62dd..bea6f9c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1235,9 +1235,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
-        for task in self.rq.scenequeue_covered:
-            self.task_skip(task)
-
         event.fire(bb.event.StampUpdate(self.rqdata.target_pairs, self.rqdata.dataCache.stamp), self.cfgData)
 
         schedulers = self.get_schedulers()
@@ -1331,8 +1328,14 @@ class RunQueueExecuteTasks(RunQueueExecute):
         task = self.sched.next()
         if task is not None:
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-
             taskname = self.rqdata.runq_task[task]
+
+            if task in self.rq.scenequeue_covered:
+                logger.debug(2, "Setscene covered task %s (%s)", task,
+                                self.rqdata.get_user_idstring(task))
+                self.task_skip(task)
+                return True
+
             if self.rq.check_stamp_task(task, taskname):
                 logger.debug(2, "Stamp current task %s (%s)", task,
                                 self.rqdata.get_user_idstring(task))



