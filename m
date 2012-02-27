Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S25qP-0001wh-3C
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 20:02:45 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Feb 2012 10:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70898434"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.30])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Feb 2012 10:54:16 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 18:54:11 +0000
Message-Id: <67b6b60673a682f1d76aa224e0e47e1ca83f5bc9.1330368761.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330368761.git.paul.eggleton@linux.intel.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330368761.git.paul.eggleton@linux.intel.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: fix setscene task start/failure handling
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
X-List-Received-Date: Mon, 27 Feb 2012 19:02:45 -0000

* When a setscene task starts, print out that it's starting in the UI
  (ensuring we get the correct task name)
* When a setscene task fails, ensure we remove it from the list of
  running tasks so that if you break out any time afterwards it
  is not still listed.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py       |   10 +++++++++-
 bitbake/lib/bb/runqueue.py    |   18 +++++++++++++-----
 bitbake/lib/bb/ui/knotty.py   |    9 +++++++++
 bitbake/lib/bb/ui/uihelper.py |    3 +--
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index e85d7c4..b7031ab 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -96,6 +96,12 @@ class TaskFailed(TaskBase):
         self.errprinted = errprinted
         super(TaskFailed, self).__init__(task, metadata)
 
+class TaskFailedSilent(TaskBase):
+    """Task execution failed (silently)"""
+    def __init__(self, task, logfile, metadata):
+        self.logfile = logfile
+        super(TaskFailedSilent, self).__init__(task, metadata)
+
 class TaskInvalid(TaskBase):
 
     def __init__(self, task, metadata):
@@ -334,7 +340,9 @@ def _exec_task(fn, task, d, quieterr):
         for func in (postfuncs or '').split():
             exec_func(func, localdata)
     except FuncFailed as exc:
-        if not quieterr:
+        if quieterr:
+            event.fire(TaskFailedSilent(task, logfn, localdata), localdata)
+        else:
             errprinted = errchk.triggered
             logger.error(str(exc))
             event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f08f93a..0652c49 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1729,6 +1729,15 @@ class runQueueEvent(bb.event.Event):
         self.stats = stats.copy()
         bb.event.Event.__init__(self)
 
+class sceneQueueEvent(runQueueEvent):
+    """
+    Base sceneQueue event class
+    """
+    def __init__(self, task, stats, rq, noexec=False):
+        runQueueEvent.__init__(self, task, stats, rq)
+        realtask = rq.rqdata.runq_setscene[task]
+        self.taskstring = rq.rqdata.get_user_idstring(realtask, "_setscene")
+
 class runQueueTaskStarted(runQueueEvent):
     """
     Event notifing a task was started
@@ -1737,12 +1746,12 @@ class runQueueTaskStarted(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.noexec = noexec
 
-class sceneQueueTaskStarted(runQueueEvent):
+class sceneQueueTaskStarted(sceneQueueEvent):
     """
     Event notifing a setscene task was started
     """
     def __init__(self, task, stats, rq, noexec=False):
-        runQueueEvent.__init__(self, task, stats, rq)
+        sceneQueueEvent.__init__(self, task, stats, rq)
         self.noexec = noexec
 
 class runQueueTaskFailed(runQueueEvent):
@@ -1753,14 +1762,13 @@ class runQueueTaskFailed(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
 
-class sceneQueueTaskFailed(runQueueEvent):
+class sceneQueueTaskFailed(sceneQueueEvent):
     """
     Event notifing a setscene task failed
     """
     def __init__(self, task, stats, exitcode, rq):
-        runQueueEvent.__init__(self, task, stats, rq)
+        sceneQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
-        self.taskstring = rq.rqdata.get_user_idstring(task, "_setscene")
 
 class runQueueTaskCompleted(runQueueEvent):
     """
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index e2e6ac3..14989d4 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -238,6 +238,10 @@ def main(server, eventHandler):
                         logger.error("%s", reason)
                 continue
 
+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                logger.info("Running setscene task %d of %d (%s)" % (event.stats.completed + event.stats.active + event.stats.failed + 1, event.stats.total, event.taskstring))
+                continue
+
             if isinstance(event, bb.runqueue.runQueueTaskStarted):
                 if event.noexec:
                     tasktype = 'noexec task'
@@ -256,6 +260,11 @@ def main(server, eventHandler):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
+            if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+                logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
+                             event.taskid, event.taskstring, event.exitcode)
+                continue
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.StampUpdate,
diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index bbf5135..4116dab 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -32,9 +32,8 @@ class BBUIHelper:
         if isinstance(event, bb.build.TaskSucceeded):
             del self.running_tasks[event.pid]
             self.needUpdate = True
-        if isinstance(event, bb.build.TaskFailed):
+        if isinstance(event, bb.build.TaskFailed) or isinstance(event, bb.build.TaskFailedSilent):
             del self.running_tasks[event.pid]
-            self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
 
     def getTasks(self):
-- 
1.7.5.4



