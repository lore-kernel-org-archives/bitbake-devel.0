Return-Path: <marius.avram@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C2A356E79B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Feb 2014 09:48:11 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 19 Feb 2014 01:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,504,1389772800"; d="scan'208";a="457969357"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by orsmga001.jf.intel.com with ESMTP; 19 Feb 2014 01:48:11 -0800
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Feb 2014 11:52:34 +0200
Message-Id: <1392803554-27957-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: time data for tasks differ from buildstats
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
X-List-Received-Date: Wed, 19 Feb 2014 09:48:11 -0000

The BuildInfoHelper class was measuring separately the time for a build.
This was causing many difference in the time measured by buildstats class and
the time measured here. The main problem is toaster does database operations
which delay the arrival of events.

The simplest solution, which is implemented in this fix, is to keep the time
of creation for every BaseTask and calculate the duration by making a
difference between the creation time of TaskSucceeded and TaskStarted.

[YOCTO #5727]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/build.py              |    2 ++
 bitbake/lib/bb/ui/buildinfohelper.py |   17 +++++++++++------
 bitbake/lib/bb/ui/toasterui.py       |    6 +++++-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 50a28dc..03e7996 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -30,6 +30,7 @@ import sys
 import logging
 import shlex
 import glob
+import time
 import bb
 import bb.msg
 import bb.process
@@ -75,6 +76,7 @@ class TaskBase(event.Event):
         self.taskfile = d.getVar("FILE", True)
         self.taskname = self._task
         self.logfile = logfile
+        self.time = time.time()
         event.Event.__init__(self)
         self._message = "recipe %s: task %s: %s" % (d.getVar("PF", True), t, self.getDisplayName())
 
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index da777f1..093d685 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -102,10 +102,9 @@ class ORMWrapper(object):
             elif outcome_task_setscene == Task.OUTCOME_FAILED:
                 task_object.sstate_result = Task.SSTATE_FAILED
 
-        # mark down duration if we have a start time
-        if 'start_time' in task_information.keys():
-            duration = datetime.datetime.now() - task_information['start_time']
-            task_object.elapsed_time = duration.total_seconds()
+        # mark down duration if we have an end time
+        if 'end_time' in task_information.keys():
+            task_object.elapsed_time = task_information['end_time'] - task_information['start_time']
 
         task_object.save()
         return task_object
@@ -448,6 +447,10 @@ class BuildInfoHelper(object):
         task_information = self._get_task_information(event, recipe)
         task_information['outcome'] = Task.OUTCOME_NA
 
+        self.internal_state[identifier] = {}
+        if isinstance(event, bb.build.TaskStarted):
+            self.internal_state[identifier]['start_time'] = event.time
+
         if isinstance(event, bb.runqueue.runQueueTaskSkipped):
             task_information['task_executed'] = False
             if event.reason == "covered":
@@ -468,8 +471,6 @@ class BuildInfoHelper(object):
 
         task_obj = self.orm_wrapper.get_update_task_object(task_information)
 
-        self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
-
 
     def store_tasks_stats(self, event):
         for (taskfile, taskname, taskstats) in event.data:
@@ -507,6 +508,10 @@ class BuildInfoHelper(object):
             else:
                 task_information['script_type'] = Task.CODING_SHELL
 
+        if isinstance(event, bb.build.TaskSucceeded):
+            task_information['start_time'] = self.internal_state[identifier]['start_time']
+            task_information['end_time'] = event.time
+
         if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
             task_information['outcome'] = Task.OUTCOME_SUCCESS
             del self.internal_state[identifier]
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index e469d93..58abfd3 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -109,7 +109,11 @@ def main(server, eventHandler, params ):
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event)
 
-            if isinstance(event, (bb.build.TaskStarted, bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
+            if isinstance(event, bb.build.TaskStarted):
+                buildinfohelper.store_started_task(event)
+                continue
+
+            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
                 continue
 
-- 
1.7.9.5


