Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE3EC433EF
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 22:09:50 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web10.3292.1645135789718205120
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IfN53gGi;
 spf=pass (domain: konsulko.com, ip: 209.85.219.41,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f41.google.com with SMTP id c14so11065876qvl.12
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LZwR1OF5IeWR925Iw4u5lqy6Mseb0+6q3nQOlgAeFa0=;
        b=IfN53gGiaUGoddvLWV0xr/NA6M/RcD4Wz4nuG6d/ulD78ncGwPB8CcNMTBxyWP3qON
         Akzq7hvgdT45Uo3UEWm5uvSwbdqee7pudp6RFVR2AqCRbm5ztSIu8UmV84ZXdlbOABsV
         BGtwRWj+68te6Ij/QNnesiBtJRCqqYHF6WjkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZwR1OF5IeWR925Iw4u5lqy6Mseb0+6q3nQOlgAeFa0=;
        b=rcGU8/EGTdhO425Ga2yfNxKvzooLbIkyqMjm+PXoDjbxXvuN1mObUH+/8t1DVUvaUi
         +HZxCbBoeiLbwkOVI8ix3r/LK8PTvDpFe0jlyZzNhTFbNTsUVL3OerIPXVGpDFM5Ybdu
         U6au6fmliqx5vVsPr+cp91AB+7RgLdL71Vs9Y3gW0pSkmTg3HUOTIvCYFQ8d6R95Ug/s
         Um76UfqGDvcMB+ffIQgTFuZx+2d2TGYDy6o+PNsqMwAV0UHFF07mbuXHLLtSoZELYMFh
         XPaQ/YV+VDzVzF2FdGc5Npak6rQ2in1A2vLWs5JFR979X78/3Zlr5duMdJ3PdbOtEjTD
         ECwA==
X-Gm-Message-State: AOAM533s7kQ95qpgqVzrkR82u0azv2NNIKY1y/r+QQ7q+7BYmHpF8Etn
	DSzTIe3dj6xviFBe9w4xwOg0W4ozn2v7vQ==
X-Google-Smtp-Source: 
 ABdhPJyVdZjrOxtFj3vdKNTO4vTy4LfTN1A01tfuPz8iTeGAxm/6w4RgBRABFDDdmipo2Qj42R9nAw==
X-Received: by 2002:ac8:75d0:0:b0:2db:aad5:ec47 with SMTP id
 z16-20020ac875d0000000b002dbaad5ec47mr4283084qtq.390.1645135788211;
        Thu, 17 Feb 2022 14:09:48 -0800 (PST)
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com.
 [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id
 q15sm5127572qtn.41.2022.02.17.14.09.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:09:47 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] Replace "abort" usage in task handling
Date: Thu, 17 Feb 2022 17:09:33 -0500
Message-Id: 
 <e30c762db3aea0f071e0992dd394ae7f2ded6e42.1645135230.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645135230.git.scott.murray@konsulko.com>
References: <cover.1645135230.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 22:09:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13362

In line with the inclusive language migration defined at:

https://wiki.yoctoproject.org/wiki/Inclusive_language

replace the use of "abort" with "halt" in code related to handling
task failure.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/cooker.py     | 24 ++++++++++++------------
 lib/bb/cookerdata.py |  4 ++--
 lib/bb/main.py       |  2 +-
 lib/bb/runqueue.py   | 12 ++++++------
 lib/bb/taskdata.py   | 10 +++++-----
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d1d4e325..730575c5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -199,7 +199,7 @@ class BBCooker:
 
         self.inotify_modified_files = []
 
-        def _process_inotify_updates(server, cooker, abort):
+        def _process_inotify_updates(server, cooker, halt):
             cooker.process_inotify_updates()
             return 1.0
 
@@ -505,7 +505,7 @@ class BBCooker:
             logger.debug("Base environment change, triggering reparse")
             self.reset()
 
-    def runCommands(self, server, data, abort):
+    def runCommands(self, server, data, halt):
         """
         Run any queued asynchronous command
         This is done by the idle handler so it runs in true context rather than
@@ -578,7 +578,7 @@ class BBCooker:
                 if pkgs_to_build[0] in set(ignore.split()):
                     bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-                taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
+                taskdata, runlist = self.buildTaskData(pkgs_to_build, None, self.configuration.halt, allowincomplete=True)
 
                 mc = runlist[0][0]
                 fn = runlist[0][3]
@@ -616,7 +616,7 @@ class BBCooker:
             self.disableDataTracking()
             self.reset()
 
-    def buildTaskData(self, pkgs_to_build, task, abort, allowincomplete=False):
+    def buildTaskData(self, pkgs_to_build, task, halt, allowincomplete=False):
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
@@ -663,7 +663,7 @@ class BBCooker:
         localdata = {}
 
         for mc in self.multiconfigs:
-            taskdata[mc] = bb.taskdata.TaskData(abort, skiplist=self.skiplist, allowincomplete=allowincomplete)
+            taskdata[mc] = bb.taskdata.TaskData(halt, skiplist=self.skiplist, allowincomplete=allowincomplete)
             localdata[mc] = data.createCopy(self.databuilder.mcdata[mc])
             bb.data.expandKeys(localdata[mc])
 
@@ -737,7 +737,7 @@ class BBCooker:
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
 
-        # We set abort to False here to prevent unbuildable targets raising
+        # We set halt to False here to prevent unbuildable targets raising
         # an exception when we're just generating data
         taskdata, runlist = self.buildTaskData(pkgs_to_build, task, False, allowincomplete=True)
 
@@ -1425,7 +1425,7 @@ class BBCooker:
 
         # Setup taskdata structure
         taskdata = {}
-        taskdata[mc] = bb.taskdata.TaskData(self.configuration.abort)
+        taskdata[mc] = bb.taskdata.TaskData(self.configuration.halt)
         taskdata[mc].add_provider(self.databuilder.mcdata[mc], self.recipecaches[mc], item)
 
         if quietlog:
@@ -1441,11 +1441,11 @@ class BBCooker:
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
 
-        def buildFileIdle(server, rq, abort):
+        def buildFileIdle(server, rq, halt):
 
             msg = None
             interrupted = 0
-            if abort or self.state == state.forceshutdown:
+            if halt or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
                 msg = "Forced shutdown"
                 interrupted = 2
@@ -1487,10 +1487,10 @@ class BBCooker:
         Attempt to build the targets specified
         """
 
-        def buildTargetsIdle(server, rq, abort):
+        def buildTargetsIdle(server, rq, halt):
             msg = None
             interrupted = 0
-            if abort or self.state == state.forceshutdown:
+            if halt or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
                 msg = "Forced shutdown"
                 interrupted = 2
@@ -1533,7 +1533,7 @@ class BBCooker:
 
         bb.event.fire(bb.event.BuildInit(packages), self.data)
 
-        taskdata, runlist = self.buildTaskData(targets, task, self.configuration.abort)
+        taskdata, runlist = self.buildTaskData(targets, task, self.configuration.halt)
 
         buildname = self.data.getVar("BUILDNAME", False)
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 8d96fc41..c1d1f949 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -57,7 +57,7 @@ class ConfigParameters(object):
 
     def updateToServer(self, server, environment):
         options = {}
-        for o in ["abort", "force", "invalidate_stamp",
+        for o in ["halt", "force", "invalidate_stamp",
                   "dry_run", "dump_signatures",
                   "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout",
@@ -124,7 +124,7 @@ class CookerConfiguration(object):
         self.prefile = []
         self.postfile = []
         self.cmd = None
-        self.abort = True
+        self.halt = True
         self.force = False
         self.profile = False
         self.nosetscene = False
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 639fc188..93eda363 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -127,7 +127,7 @@ def create_bitbake_parser():
                       help="Execute tasks from a specific .bb recipe directly. WARNING: Does "
                            "not handle any dependencies from other recipes.")
 
-    parser.add_option("-k", "--continue", action="store_false", dest="abort", default=True,
+    parser.add_option("-k", "--continue", action="store_false", dest="halt", default=True,
                       help="Continue as much as possible after an error. While the target that "
                            "failed and anything depending on it cannot be built, as much as "
                            "possible will be built before stopping.")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index aedf9354..a7a84630 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -485,7 +485,7 @@ class RunQueueData:
                             msgs.append("  Task %s (dependent Tasks %s)\n" % (dep, self.runq_depends_names(self.runtaskentries[dep].depends)))
                         msgs.append("\n")
                     if len(valid_chains) > 10:
-                        msgs.append("Aborted dependency loops search after 10 matches.\n")
+                        msgs.append("Halted dependency loops search after 10 matches.\n")
                         raise TooManyLoops
                     continue
                 scan = False
@@ -989,7 +989,7 @@ class RunQueueData:
 
         # Check to make sure we still have tasks to run
         if not self.runtaskentries:
-            if not taskData[''].abort:
+            if not taskData[''].halt:
                 bb.msg.fatal("RunQueue", "All buildable tasks have been run but the build is incomplete (--continue mode). Errors for the tasks that failed will have been printed above.")
             else:
                 bb.msg.fatal("RunQueue", "No active tasks and not in --continue mode?! Please report this bug.")
@@ -1424,7 +1424,7 @@ class RunQueue:
         """
         Run the tasks in a queue prepared by rqdata.prepare()
         Upon failure, optionally try to recover the build using any alternate providers
-        (if the abort on failure configuration option isn't set)
+        (if the halt on failure configuration option isn't set)
         """
 
         retval = True
@@ -1929,7 +1929,7 @@ class RunQueueExecute:
 
         bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq, fakeroot_log=("".join(fakeroot_log) or None)), self.cfgData)
 
-        if self.rqdata.taskData[''].abort:
+        if self.rqdata.taskData[''].halt:
             self.rq.state = runQueueCleanUp
 
     def task_skip(self, task, reason):
@@ -2392,7 +2392,7 @@ class RunQueueExecute:
                 self.tasks_scenequeue_done.remove(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep in self.runq_complete and dep not in self.runq_tasksrun:
-                    bb.error("Task %s marked as completed but now needing to rerun? Aborting build." % dep)
+                    bb.error("Task %s marked as completed but now needing to rerun? Halting build." % dep)
                     self.failed_tids.append(tid)
                     self.rq.state = runQueueCleanUp
                     return
@@ -2710,7 +2710,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         if tid in rqdata.runq_setscene_tids:
             pass
         elif sq_revdeps_squash[tid]:
-            bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
+            bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, halting. Please report this problem.")
         else:
             del sq_revdeps_squash[tid]
         rqdata.init_progress_reporter.update(taskcounter)
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 7bfcdb84..66545a65 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -39,7 +39,7 @@ class TaskData:
     """
     BitBake Task Data implementation
     """
-    def __init__(self, abort = True, skiplist = None, allowincomplete = False):
+    def __init__(self, halt = True, skiplist = None, allowincomplete = False):
         self.build_targets = {}
         self.run_targets = {}
 
@@ -57,7 +57,7 @@ class TaskData:
         self.failed_rdeps = []
         self.failed_fns = []
 
-        self.abort = abort
+        self.halt = halt
         self.allowincomplete = allowincomplete
 
         self.skiplist = skiplist
@@ -328,7 +328,7 @@ class TaskData:
         try:
             self.add_provider_internal(cfgData, dataCache, item)
         except bb.providers.NoProvider:
-            if self.abort:
+            if self.halt:
                 raise
             self.remove_buildtarget(item)
 
@@ -479,7 +479,7 @@ class TaskData:
                     fn = tid.rsplit(":",1)[0]
                     self.fail_fn(fn, missing_list)
 
-        if self.abort and target in self.external_targets:
+        if self.halt and target in self.external_targets:
             logger.error("Required build target '%s' has no buildable providers.\nMissing or unbuildable dependency chain was: %s", target, missing_list)
             raise bb.providers.NoProvider(target)
 
@@ -516,7 +516,7 @@ class TaskData:
                     self.add_provider_internal(cfgData, dataCache, target)
                     added = added + 1
                 except bb.providers.NoProvider:
-                    if self.abort and target in self.external_targets and not self.allowincomplete:
+                    if self.halt and target in self.external_targets and not self.allowincomplete:
                         raise
                     if not self.allowincomplete:
                         self.remove_buildtarget(target)
-- 
2.35.1


