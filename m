Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 986C76CB46
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:18 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948497"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 9B173561159; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:44 +0100
Message-Id: <ca57d76c7063953d49aaa92e61221d168c53fad5.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 15/94] bitbake: dsi: Translate runQueue events into Task data
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:18 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We're moving the capture of task running information from
bb.build.Task* events to runQueue* events.

We handle runQueueTaskSkipped events to record all skipped
tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/dsi.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 5ff5696..e527e56 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -287,11 +287,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event)
 
-            if isinstance(event, bb.build.TaskStarted):
-                buildinfohelper.store_started_task(event)
-
             if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
-                buildinfohelper.update_and_store_task(event)
+                continue
 
             if isinstance(event, bb.event.LogExecTTY):
                 if log_exec_tty:
@@ -416,13 +413,19 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                             event.stats.total, event.taskid, event.taskstring)
                 continue
 
+            if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.runQueueTaskSkipped)):
+                buildinfohelper.store_started_task(event)
+                continue
+
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
+                buildinfohelper.update_and_store_task(event)
                 taskfailures.append(event.taskstring)
                 logger.error("Task %s (%s) failed with exit code '%s'",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+                buildinfohelper.update_and_store_task(event)
                 logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
-- 
1.8.1.2


