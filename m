Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id B9CAC6BDAF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 18 Sep 2013 05:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="403549422"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id AA691560A7B; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:53 +0100
Message-Id: <3f22b14f9fe193cb1e21bb6adf9c3b54ce7b2405.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 7/7] bitbake: runqueue: add task hash to Queue events
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
X-List-Received-Date: Wed, 18 Sep 2013 12:15:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding the sstate-related hash for all runqueue and
scenequeue tasks, as it's needed in the WebHob data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/runqueue.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 19e89e9..c09cfd4 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -223,6 +223,9 @@ class RunQueueData:
     def get_task_file(self, task):
         return self.taskData.fn_index[self.runq_fnid[task]]
 
+    def get_task_hash(self, task):
+        return self.runq_hash[task]
+
     def get_user_idstring(self, task, task_name_suffix = ""):
         fn = self.taskData.fn_index[self.runq_fnid[task]]
         taskname = self.runq_task[task] + task_name_suffix
@@ -1794,6 +1797,7 @@ class runQueueEvent(bb.event.Event):
         self.taskstring = rq.rqdata.get_user_idstring(task)
         self.taskname = rq.rqdata.get_task_name(task)
         self.taskfile = rq.rqdata.get_task_file(task)
+        self.taskhash = rq.rqdata.get_task_hash(task)
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
@@ -1807,6 +1811,7 @@ class sceneQueueEvent(runQueueEvent):
         self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
         self.taskname = rq.rqdata.get_task_name(realtask) + "_setscene"
         self.taskfile = rq.rqdata.get_task_file(realtask)
+        self.taskhash = rq.rqdata.get_task_hash(task)
 
 class runQueueTaskStarted(runQueueEvent):
     """
-- 
1.8.1.2


