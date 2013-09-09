Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id ADE576BF68
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:07 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="400703686"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 09 Sep 2013 09:41:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7816A560829; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:55 +0100
Message-Id: <9e330c1945465cfe7838a940e27cfb3e98f7f0ba.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/13] bitbake: runqueue, build: event data change
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We modify event data to make sure we can match build events
with runqueue events. This is important because the build
events supply datastore-evaluated data while runqueue events supply
bitbake-related data. We get the recipe name and version from
the datastore, while the file paths and timing information are
collected from the RunQueue.

We modify filling-in the information side to take advantage of the
new info supplied.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/build.py    | 3 +++
 bitbake/lib/bb/runqueue.py | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index a53aba9..1265bdc 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -72,6 +72,9 @@ class TaskBase(event.Event):
     def __init__(self, t, d ):
         self._task = t
         self._package = d.getVar("PF", True)
+        self._file = d.getVar("FILE", True)
+        self.taskfile = self._file
+        self.taskname = self._task
         event.Event.__init__(self)
         self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 002bf76..73dd059 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -220,7 +220,7 @@ class RunQueueData:
     def get_task_name(self, task):
         return self.runq_task[task]
 
-    def get_task_package(self, task):
+    def get_task_file(self, task):
         return self.taskData.fn_index[self.runq_fnid[task]]
 
     def get_user_idstring(self, task, task_name_suffix = ""):
@@ -1787,7 +1787,7 @@ class runQueueEvent(bb.event.Event):
         self.taskid = task
         self.taskstring = rq.rqdata.get_user_idstring(task)
         self.taskname = rq.rqdata.get_task_name(task)
-        self.taskpackage = rq.rqdata.get_task_package(task)
+        self.taskfile = rq.rqdata.get_task_file(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
@@ -1800,7 +1800,7 @@ class sceneQueueEvent(runQueueEvent):
         realtask = rq.rqdata.runq_setscene[task]
         self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
         self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
-        self.taskpackage = rq.rqdata.get_task_package(realtask)
+        self.taskfile = rq.rqdata.get_task_file(realtask)
 
 class runQueueTaskStarted(runQueueEvent):
     """
@@ -1845,7 +1845,7 @@ class runQueueTaskSkipped(runQueueEvent):
     """
     def __init__(self, task, stats, rq, skip_reason):
         runQueueEvent.__init__(self, task, stats, rq)
-        self._package = rq.rqdata.get_task_package(task)
+        self._file = rq.rqdata.get_task_file(task)
         self._task = rq.rqdata.get_task_name(task)
         self._skip = skip_reason
 
-- 
1.8.1.2


