Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5me-0007Xl-BK
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:20 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 06 Jan 2012 01:00:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="53852738"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by AZSMGA002.ch.intel.com with ESMTP; 06 Jan 2012 01:00:54 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:34 +0800
Message-Id: <c9c075648019ee0f55b2ed916b40567307cd5674.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 16/16] runqueue: fire sceneQueueTaskStarted event when a setscene queue starts
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:20 -0000

Fire a sceneQueueTaskStarted event to notify the setscene tasks progress.

Signed-off-by: Shane Wang <shane.wang@intel.com>
Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/event.py    |    2 +-
 lib/bb/runqueue.py |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index ffd4213..10de984 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -223,7 +223,7 @@ class OperationProgress(Event):
         Event.__init__(self)
         self.current = current
         self.total = total
-        self.msg = msg + ": %s/%s (%.0f%%)" % (current, total, (current*1.0/total)*100);
+        self.msg = msg + ": %s/%s" % (current, total);
 
 class ConfigParsed(Event):
     """Configuration Parsing Complete"""
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



