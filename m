Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id BC9DB78441
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 14:22:17 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w4EELrLw023821
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 07:22:08 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Mon, 14 May 2018 07:21:42 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 14 May 2018 10:21:38 -0400
Message-ID: <20180514142139.165484-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180514142139.165484-1-mark.hatle@windriver.com>
References: <20180514142139.165484-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] runqueue.py: Minor cleanup for RunQueueStats and users
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
X-List-Received-Date: Mon, 14 May 2018 14:22:17 -0000
Content-Type: text/plain

The RunQueueStats:taskCompleted and RunQueueStats:taskSkipped can take
multiple arguments.  However, nowehere in bitbake are multiple arguments used.
Change this to match the behavior of the other APIs where it needs to be
called once for each task.

Additionally, these two functions were usually called in tandem, however in
the wrong order.  It really doesn't matter as there is no specific preemption
point between the calls.  But the taskSkipped should be called first to
increment the 'active' count, and then taskCompleted called to decrement it.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/runqueue.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f2e52cf..a937a0b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -94,13 +94,13 @@ class RunQueueStats:
         self.active = self.active - 1
         self.failed = self.failed + 1
 
-    def taskCompleted(self, number = 1):
-        self.active = self.active - number
-        self.completed = self.completed + number
+    def taskCompleted(self):
+        self.active = self.active - 1
+        self.completed = self.completed + 1
 
-    def taskSkipped(self, number = 1):
-        self.active = self.active + number
-        self.skipped = self.skipped + number
+    def taskSkipped(self):
+        self.active = self.active + 1
+        self.skipped = self.skipped + 1
 
     def taskActive(self):
         self.active = self.active + 1
@@ -1896,8 +1896,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
         self.setbuildable(task)
         bb.event.fire(runQueueTaskSkipped(task, self.stats, self.rq, reason), self.cfgData)
         self.task_completeoutright(task)
-        self.stats.taskCompleted()
         self.stats.taskSkipped()
+        self.stats.taskCompleted()
 
     def execute(self):
         """
@@ -2342,8 +2342,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
     def task_failoutright(self, task):
         self.runq_running.add(task)
         self.runq_buildable.add(task)
-        self.stats.taskCompleted()
         self.stats.taskSkipped()
+        self.stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task, True)
 
@@ -2351,8 +2351,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.runq_running.add(task)
         self.runq_buildable.add(task)
         self.task_completeoutright(task)
-        self.stats.taskCompleted()
         self.stats.taskSkipped()
+        self.stats.taskCompleted()
 
     def execute(self):
         """
-- 
1.8.3.1


