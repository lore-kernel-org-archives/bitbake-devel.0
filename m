Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 8C27B6CB97
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948536"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 094E25623E1; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:22 +0100
Message-Id: <d79dc2468304bb5020c3049899df9e3d9152f60c.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 53/94] bitbake: dsi: fix sstate task information gathering
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fixing the information gathering for sstate-related tasks -
now the start and completion events are correctly handled,
and we get an update for tasks that were covered by sstate
tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 6 +++++-
 bitbake/lib/bb/ui/dsi.py             | 5 ++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 1d8cb44..bfd7fef 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -67,7 +67,11 @@ class ORMWrapper(object):
         for v in vars(task_object):
             if v in task_information.keys():
                 vars(task_object)[v] = task_information[v]
+        # if we got covered by a setscene task, we're SSTATE
+        if task_object.outcome == Task.OUTCOME_COVERED and 1 == Task.objects.filter(task_executed=True, build = task_object.build, recipe = task_object.recipe, task_name=task_object.task_name+"_setscene").count():
+            task_object.outcome = Task.OUTCOME_SSTATE
 
+        # mark down duration if we have a start time
         if 'start_time' in task_information.keys():
             duration = datetime.datetime.now() - task_information['start_time']
             task_object.elapsed_time = duration.total_seconds()
@@ -393,7 +397,7 @@ class BuildInfoHelper(object):
         except:
             pass
 
-        if isinstance(event, bb.runqueue.runQueueTaskCompleted):
+        if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
             task_information['outcome'] = Task.OUTCOME_SUCCESS     # TODO: needs to use constants
             task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
             task_information['cpu_usage'] = task_build_stats['cpu_usage']
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 3e0b7ff..0305121 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -415,6 +415,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                buildinfohelper.store_started_task(event)
                 logger.info("Running setscene task %d of %d (%s)" % (event.stats.completed + event.stats.active + event.stats.failed + 1, event.stats.total, event.taskstring))
                 continue
 
@@ -446,10 +447,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
-            if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+            if isinstance(event, (bb.runqueue.sceneQueueTaskCompleted, bb.runqueue.sceneQueueTaskFailed)):
                 buildinfohelper.update_and_store_task(event)
-                logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
-                             event.taskid, event.taskstring, event.exitcode)
                 continue
 
 
-- 
1.8.1.2


