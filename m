Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 08C4D6D437
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 22:29:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJMTXr1029046 for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 22:29:33 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uvB75ATml7FE for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 22:29:33 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAJMTSnt029041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 22:29:30 GMT
Message-ID: <1384900165.16887.24.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Nov 2013 22:29:25 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: runqueue: Fix hole in setsceneverify skipped task logic
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
X-List-Received-Date: Tue, 19 Nov 2013 22:29:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We have do_bundle_initramfs which is a task inserted after compile and
before build. It is not covered by sstate.

If we run a build with a valid sstate cache present, the setsceneverify
function realises it will rerun the do_compile step (due to the
bundle_initramfs task) and hence marks do_populate_sysroot to rerun.
do_install, a dependency of do_populate_sysroot is left as marked as
covered by sstate.

What we need to do is traverse the dependency tree for any setsceneverify
invalided task and ensure any dependencies are also invalidated. We can
stop at any point we reach another setscene task though.

This means the do_populate_sysroot task has the data from do_install
available and doesn't crash.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b570ff5..a88f7c9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1230,6 +1230,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         self.stampcache = {}
 
+        initial_covered = self.rq.scenequeue_covered.copy()
+
         # Mark initial buildable tasks
         for task in xrange(self.stats.total):
             self.runq_running.append(0)
@@ -1283,13 +1285,28 @@ class RunQueueExecuteTasks(RunQueueExecute):
             except TypeError:
                 covered_remove = bb.utils.better_eval(call2, locs)
 
-        for task in covered_remove:
+        def removecoveredtask(task):
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
             taskname = self.rqdata.runq_task[task] + '_setscene'
             bb.build.del_stamp(taskname, self.rqdata.dataCache, fn)
-            logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
             self.rq.scenequeue_covered.remove(task)
 
+        toremove = covered_remove
+        for task in toremove:
+            logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
+        while toremove:
+            covered_remove = []
+            for task in toremove:
+                for deptask in self.rqdata.runq_depends[task]:
+                    if deptask not in self.rq.scenequeue_covered:
+                        continue
+                    if deptask in toremove or deptask in covered_remove or deptask in initial_covered:
+                        continue
+                    logger.debug(1, 'Task %s depends on task %s so not skipping' % (task, deptask))
+                    removecoveredtask(deptask)
+                    covered_remove.append(deptask)
+            toremove = covered_remove
+
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
         event.fire(bb.event.StampUpdate(self.rqdata.target_pairs, self.rqdata.dataCache.stamp), self.cfgData)



