Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 452556BE34
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:21 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Sep 2013 09:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="398854311"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2013 09:41:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7A9BA56088B; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:56 +0100
Message-Id: <f67081e371fbddc8b387e1445ddd4b067dec47ad.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/13] bitbake: runqueue: add sceneQueueTaskCompleted event
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding an event to be fired when a scene task is completed.
It is analogous to the run task completed event, and has
been missing for some reason.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 73dd059..11ff193 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1652,6 +1652,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
     def task_complete(self, task):
         self.stats.taskCompleted()
+        bb.event.fire(sceneQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
         self.task_completeoutright(task)
 
     def task_fail(self, task, result):
@@ -1839,6 +1840,11 @@ class runQueueTaskCompleted(runQueueEvent):
     Event notifing a task completed
     """
 
+class sceneQueueTaskCompleted(sceneQueueEvent):
+    """
+    Event notifing a setscene task completed
+    """
+
 class runQueueTaskSkipped(runQueueEvent):
     """
     Event notifing a task was skipped
-- 
1.8.1.2


