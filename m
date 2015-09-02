Return-Path: <alejandro.franco@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D39C17702A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Sep 2015 20:11:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 02 Sep 2015 13:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,456,1437462000"; d="scan'208";a="554062612"
Received: from afshjern.zpn.intel.com ([10.219.128.48])
	by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2015 13:11:01 -0700
From: Alex Franco <alejandro.franco@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 15:11:30 -0500
Message-Id: <1441224690-17798-1-git-send-email-alejandro.franco@linux.intel.com>
X-Mailer: git-send-email 2.5.1
Cc: clarson@kergoth.com
Subject: [PATCHv2] Allow bitbake commands starting with do_
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
X-List-Received-Date: Wed, 02 Sep 2015 20:11:03 -0000

The output of "bitbake, -c listtasks pkg" lists tasks with their real names
(starting with "do_"), but then "bitbake -c do_task" fails, as "do_" always
gets unconditionally prepended to task names. This patch handles this error
by checking whether a task starts with "do_" prior to prepending it with it
when the task runlist is being constructed (and a few other corner cases).

[YOCTO #7818]

Signed-off-by: Alex Franco <alejandro.franco@linux.intel.com>
---
 bitbake/lib/bb/cooker.py   | 12 +++++++++---
 bitbake/lib/bb/runqueue.py |  4 +++-
 bitbake/lib/bb/shell.py    |  4 +++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 99c4785..a0d7d59 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -663,7 +663,9 @@ class BBCooker:
                 ktask = k2[1]
             taskdata.add_provider(localdata, self.recipecache, k)
             current += 1
-            runlist.append([k, "do_%s" % ktask])
+            if not ktask.startswith("do_"):
+                ktask = "do_%s" % ktask
+            runlist.append([k, ktask])
             bb.event.fire(bb.event.TreeDataPreparationProgress(current, len(fulltargetlist)), self.data)
         taskdata.add_unresolved(localdata, self.recipecache)
         bb.event.fire(bb.event.TreeDataPreparationCompleted(len(fulltargetlist)), self.data)
@@ -1302,7 +1304,9 @@ class BBCooker:
         # Invalidate task for target if force mode active
         if self.configuration.force:
             logger.verbose("Invalidate task %s, %s", task, fn)
-            bb.parse.siggen.invalidate_task('do_%s' % task, self.recipecache, fn)
+            if not task.startswith("do_"):
+                task = "do_%s" % task
+            bb.parse.siggen.invalidate_task(task, self.recipecache, fn)
 
         # Setup taskdata structure
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
@@ -1312,7 +1316,9 @@ class BBCooker:
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue
-        runlist = [[item, "do_%s" % task]]
+        if not task.startswith("do_"):
+            task = "do_%s" % task
+        runlist = [[item, task]]
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecache, taskdata, runlist)
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0f99e5a..2b71eed 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -793,7 +793,9 @@ class RunQueueData:
         if self.cooker.configuration.invalidate_stamp:
             for (fn, target) in self.target_pairs:
                 for st in self.cooker.configuration.invalidate_stamp.split(','):
-                    invalidate_task(fn, "do_%s" % st, True)
+                    if not st.startswith("do_"):
+                        st = "do_%s" % st
+                    invalidate_task(fn, st, True)
 
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
diff --git a/bitbake/lib/bb/shell.py b/bitbake/lib/bb/shell.py
index 1dd8d54..ffc87bb 100644
--- a/bitbake/lib/bb/shell.py
+++ b/bitbake/lib/bb/shell.py
@@ -167,7 +167,9 @@ class BitBakeShellCommands:
                 if len(providers) == 0:
                     raise Providers.NoProvider
 
-                tasks.append([name, "do_%s" % cmd])
+                if not cmd.startswith("do_"):
+                    cmd = "do_%s" % cmd
+                tasks.append([name, cmd])
 
             td.add_unresolved(localdata, cooker.status)
 
-- 
2.5.1


