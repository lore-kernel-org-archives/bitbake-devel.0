Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 020F871D97
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Feb 2018 09:54:15 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w199sESp002306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 9 Feb 2018 09:54:15 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1ek5Nm-0005YC-3K; Fri, 09 Feb 2018 09:54:14 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Feb 2018 09:54:12 +0000
Message-Id: <1518170052-21298-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: [PATCH] main/runqueue: Rework runall task and add runonly option
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
X-List-Received-Date: Fri, 09 Feb 2018 09:54:16 -0000

The runall commandline option was confusing people. There are in fact two
different behaviours people may want.

a) For a given target (or set of targets) look through the task graph and
run task X only if its present and would have been built.

b) For a given target (or set of targets) look through the task graph and
run task X if any recipe in the taskgraph has such a target even if it wasn't
in the original task graph.

I've decided to interpret the existing "runall" option as b), even if right
now if behaves like a). For a), which is a valid use case, this patch adds
a "runonly" option.

With both behaviours present, I'm hoping we can then kill off the "fetchall",
"checkuriall" and other tasks from OE metadata and replace them with this
option. This would significantly speed up task graph processing.

(Deleting the checkuriall and fetchall tasks takes "bitbake core-image-sato -g"
from 22s to 8s).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py |  3 ++-
 lib/bb/main.py       |  8 ++++++--
 lib/bb/runqueue.py   | 49 ++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index fab47c7..c67f012 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -143,7 +143,8 @@ class CookerConfiguration(object):
         self.writeeventlog = False
         self.server_only = False
         self.limited_deps = False
-        self.runall = None
+        self.runall = []
+        self.runonly = []
 
         self.env = {}
 
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 7711b29..f4474e4 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -292,8 +292,12 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Writes the event log of the build to a bitbake event json file. "
                                "Use '' (empty string) to assign the name automatically.")
 
-        parser.add_option("", "--runall", action="store", dest="runall",
-                          help="Run the specified task for all build targets and their dependencies.")
+        parser.add_option("", "--runall", action="append", dest="runall",
+                          help="Run the specified task for any recipe in the taskgraph of the specified target (even if it wouldn't otherwise have run).")
+
+        parser.add_option("", "--runonly", action="append", dest="runonly",
+                          help="Run only the specified task within the taskgraph of the specified targets (and any task dependencies those tasks may have).")
+
 
         options, targets = parser.parse_args(argv)
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d7acfab..48df013 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -841,30 +841,57 @@ class RunQueueData:
         #
         # Once all active tasks are marked, prune the ones we don't need.
 
-        delcount = 0
+        delcount = {}
         for tid in list(self.runtaskentries.keys()):
             if tid not in runq_build:
+                delcount[tid] = self.runtaskentries[tid]
                 del self.runtaskentries[tid]
-                delcount += 1
 
-        self.init_progress_reporter.next_stage()
+        # Handle --runall
+        if self.cooker.configuration.runall:
+            # re-run the mark_active and then drop unused tasks from new list
+            runq_build = {}
+
+            for task in self.cooker.configuration.runall:
+                runall_tids = set()
+                for tid in list(self.runtaskentries):
+                    wanttid = fn_from_tid(tid) + ":do_%s" % task
+                    if wanttid in delcount:
+                        self.runtaskentries[wanttid] = delcount[wanttid]
+                    if wanttid in self.runtaskentries:
+                        runall_tids.add(wanttid)
+
+                for tid in list(runall_tids):
+                    mark_active(tid,1)
+
+            for tid in list(self.runtaskentries.keys()):
+                if tid not in runq_build:
+                    delcount[tid] = self.runtaskentries[tid]
+                    del self.runtaskentries[tid]
 
-        if self.cooker.configuration.runall is not None:
-            runall = "do_%s" % self.cooker.configuration.runall
-            runall_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == runall }
+            if len(self.runtaskentries) == 0:
+                bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the recipes of the taskgraphs of the targets %s" % (str(self.cooker.configuration.runall), str(self.targets)))
 
+        self.init_progress_reporter.next_stage()
+
+        # Handle runonly
+        if self.cooker.configuration.runonly:
             # re-run the mark_active and then drop unused tasks from new list
             runq_build = {}
-            for tid in list(runall_tids):
-                mark_active(tid,1)
+
+            for task in self.cooker.configuration.runonly:
+                runonly_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == "do_%s" % task }
+
+                for tid in list(runonly_tids):
+                    mark_active(tid,1)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
+                    delcount[tid] = self.runtaskentries[tid]
                     del self.runtaskentries[tid]
-                    delcount += 1
 
             if len(self.runtaskentries) == 0:
-                bb.msg.fatal("RunQueue", "No remaining tasks to run for build target %s with runall %s" % (target, runall))
+                bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the taskgraphs of the targets %s" % (str(self.cooker.configuration.runonly), str(self.targets)))
 
         #
         # Step D - Sanity checks and computation
@@ -877,7 +904,7 @@ class RunQueueData:
             else:
                 bb.msg.fatal("RunQueue", "No active tasks and not in --continue mode?! Please report this bug.")
 
-        logger.verbose("Pruned %s inactive tasks, %s left", delcount, len(self.runtaskentries))
+        logger.verbose("Pruned %s inactive tasks, %s left", len(delcount), len(self.runtaskentries))
 
         logger.verbose("Assign Weightings")
 
-- 
2.7.4


