Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 794BA6E23F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9o4Y010938
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:50 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:49 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:39 -0500
Message-ID: <48d01638daeb8b3a0f08082556144cd443d70eed.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1386680149.git.liezhi.yang@windriver.com>
References: <cover.1386680149.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/5] [dora] bitbake: runqueue: Fix hole in setsceneverify skipped task logic
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:50 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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

(Bitbake master rev: f21910157d873c030b149c4cdc5b57c5062ab5a6)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/runqueue.py |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c09cfd4..72c0208 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1204,6 +1204,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         self.stampcache = {}
 
+        initial_covered = self.rq.scenequeue_covered.copy()
+
         # Mark initial buildable tasks
         for task in xrange(self.stats.total):
             self.runq_running.append(0)
@@ -1257,13 +1259,28 @@ class RunQueueExecuteTasks(RunQueueExecute):
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
+                removecoveredtask(task)
+                for deptask in self.rqdata.runq_depends[task]:
+                    if deptask not in self.rq.scenequeue_covered:
+                        continue
+                    if deptask in toremove or deptask in covered_remove or deptask in initial_covered:
+                        continue
+                    logger.debug(1, 'Task %s depends on task %s so not skipping' % (task, deptask))
+                    covered_remove.append(deptask)
+            toremove = covered_remove
+
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
         event.fire(bb.event.StampUpdate(self.rqdata.target_pairs, self.rqdata.dataCache.stamp), self.cfgData)
-- 
1.7.10.4


