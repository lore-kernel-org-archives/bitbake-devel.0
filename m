Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RlccJ-0002R5-Tm
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:36:08 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 13 Jan 2012 00:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="111866737"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2012 00:28:32 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 16:30:43 +0800
Message-Id: <0729e8527a9760dca10b3aaad0d8ac9764c726ee.1326442655.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
Subject: [PATCH 9/9] runqueue: fire sceneQueueTaskStarted event when a setscene queue starts
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Jan 2012 08:36:08 -0000

The current code prints a log when a setscene task starts, therefore
the progressbar in hob will not receive it. Use a sceneQueueTaskStarted
event instead.

Signed-off-by: Shane Wang <shane.wang@intel.com>
Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/runqueue.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0e83d05..0ba414f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1619,6 +1619,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.task_skip(task)
                 return True
 
+            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
+            bb.event.fire(startevent, self.cfgData)
+
             pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
 
             self.build_pids[pid] = task
@@ -1686,6 +1689,13 @@ class runQueueTaskStarted(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.noexec = noexec
 
+class sceneQueueTaskStarted(runQueueTaskStarted):
+    """
+    Event notifing a setscene task was started
+    """
+    def __init__(self, task, stats, rq, noexec=False):
+        runQueueTaskStarted.__init__(self, task, stats, rq, noexec)
+
 class runQueueTaskFailed(runQueueEvent):
     """
     Event notifing a task failed
-- 
1.7.0.4



