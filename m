Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0k9s-0001QS-Cg
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 02:41:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 23 Feb 2012 17:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110177461"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 23 Feb 2012 17:32:52 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 09:31:30 +0800
Message-Id: <d5e286c87af1c74f7ea968917d67a6f46898ccff.1330046167.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330046167.git.dongxiao.xu@intel.com>
References: <cover.1330046167.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330046167.git.dongxiao.xu@intel.com>
References: <cover.1330046167.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/1] runqueue: fire sceneQueueTaskStarted event when a setscene queue starts
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
X-List-Received-Date: Fri, 24 Feb 2012 01:41:16 -0000

The current code prints a log when a setscene task starts, therefore
the progressbar in hob will not receive it. Use a sceneQueueTaskStarted
event instead.

Besides, change the sceneQueueTaskFailed event to inherit runQueueEvent
directly to avoid confusion to event receiver.

Signed-off-by: Shane Wang <shane.wang@intel.com>
Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/runqueue.py |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d1d9ad9..1959007 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1653,6 +1653,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.task_skip(task)
                 return True
 
+            startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
+            bb.event.fire(startevent, self.cfgData)
+
             pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
 
             self.build_pids[pid] = task
@@ -1720,6 +1723,14 @@ class runQueueTaskStarted(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.noexec = noexec
 
+class sceneQueueTaskStarted(runQueueEvent):
+    """
+    Event notifing a setscene task was started
+    """
+    def __init__(self, task, stats, rq, noexec=False):
+        runQueueEvent.__init__(self, task, stats, rq)
+        self.noexec = noexec
+
 class runQueueTaskFailed(runQueueEvent):
     """
     Event notifing a task failed
@@ -1728,12 +1739,13 @@ class runQueueTaskFailed(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
 
-class sceneQueueTaskFailed(runQueueTaskFailed):
+class sceneQueueTaskFailed(runQueueEvent):
     """
     Event notifing a setscene task failed
     """
     def __init__(self, task, stats, exitcode, rq):
-        runQueueTaskFailed.__init__(self, task, stats, exitcode, rq)
+        runQueueEvent.__init__(self, task, stats, rq)
+        self.exitcode = exitcode
         self.taskstring = rq.rqdata.get_user_idstring(task, "_setscene")
 
 class runQueueTaskCompleted(runQueueEvent):
-- 
1.7.4.1



