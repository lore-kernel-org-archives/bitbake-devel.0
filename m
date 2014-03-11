Return-Path: <marius.avram@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id EB0B06F783
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Mar 2014 14:20:35 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 11 Mar 2014 07:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,631,1389772800"; d="scan'208";a="496196843"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2014 07:18:35 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Mar 2014 16:23:27 +0200
Message-Id: <1394547807-31826-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] toaster: time data for tasks differ from buildstats
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
X-List-Received-Date: Tue, 11 Mar 2014 14:20:36 -0000

The BuildInfoHelper class was measuring separately the time for a build.
This was causing many difference in the time measured by buildstats class and
the time measured here. The main problem is toaster does database operations
which delay the arrival of events.

The simplest solution, which is implemented in this fix, is to keep the time
of creation for every BaseTask event and calculate the duration by making a
difference between the creation time of TaskSucceeded and TaskStarted.

[YOCTO #5485]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/build.py              |    2 +
 bitbake/lib/bb/ui/buildinfohelper.py |   73 ++++++++++++++++++++--------------
 bitbake/lib/bb/ui/toasterui.py       |    6 ++-
 3 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 52e4149..5cb4c06 100644
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
index d7b526a..df67d70 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -125,9 +125,9 @@ class ORMWrapper(object):
                 task_object.sstate_result = Task.SSTATE_FAILED
 
         # mark down duration if we have a start time
-        if 'start_time' in task_information.keys():
-            duration = datetime.datetime.now() - task_information['start_time']
-            task_object.elapsed_time = duration.total_seconds()
+        if 'end_time' in task_information.keys():
+            duration = task_information['end_time'] - task_information['start_time']
+            task_object.elapsed_time = duration
 
         task_object.save()
         return task_object
@@ -455,7 +455,32 @@ class BuildInfoHelper(object):
             if i not in ret:
                 ret.append(i)
         return " ".join(sorted(ret))
+
+
+    def _get_real_recipe(self, event):
+        # Will be used by events derived from TaskBase. Some of this
+        # events have a missing namespace in front of their taskfile name,
+        # which is called virtual:native:. To avoid duplication of entries
+        # in the database it will append the namespace where it is needed
+        # and get the correct recipe and identifier

+        identifier = event.taskfile + ":" + event.taskname
+        if not identifier in self.internal_state['taskdata']:
+            if isinstance(event, bb.build.TaskBase):
+                # we do a bit of guessing
+                candidates = [x for x in self.internal_state['taskdata'].keys() if x.endswith(identifier)]
+                if len(candidates) == 1:
+                    identifier = candidates[0]
+
+        if isinstance(event, bb.build.TaskBase):
+            assert identifier in self.internal_state['taskdata']
+        identifierlist = identifier.split(":")
+        realtaskfile = ":".join(identifierlist[0:len(identifierlist)-1])
+        recipe_information = self._get_recipe_information_from_taskfile(realtaskfile)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
+
+        return (recipe, identifier)
+
 
     ################################
     ## external available methods to store information
@@ -497,15 +522,13 @@ class BuildInfoHelper(object):
             self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
 
     def store_started_task(self, event):
-        assert isinstance(event, (bb.runqueue.sceneQueueTaskStarted, bb.runqueue.runQueueTaskStarted, bb.runqueue.runQueueTaskSkipped))
+        assert isinstance(event, (bb.runqueue.sceneQueueTaskStarted, bb.runqueue.runQueueTaskStarted,
+            bb.build.TaskStarted, bb.runqueue.runQueueTaskSkipped))
         assert 'taskfile' in vars(event)
         localfilepath = event.taskfile.split(":")[-1]
         assert localfilepath.startswith("/")
 
-        identifier = event.taskfile + ":" + event.taskname
-
-        recipe_information = self._get_recipe_information_from_taskfile(event.taskfile)
-        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+        (recipe, identifier) = self._get_real_recipe(event)
 
         task_information = self._get_task_information(event, recipe)
         task_information['outcome'] = Task.OUTCOME_NA
@@ -528,15 +551,16 @@ class BuildInfoHelper(object):
         if not isinstance(event, bb.runqueue.sceneQueueTaskStarted):
             self.task_order += 1
             task_information['order'] = self.task_order
-
+
+        self.internal_state['taskdata'][identifier] = {}
+        self.internal_state['taskdata'][identifier]['outcome'] = task_information['outcome']
+        # This would apply only in the case of TaskStarted
+        if 'time' in vars(event):
+            self.internal_state['taskdata'][identifier]['start_time'] = event.time
+
+        # If task object already exists it will only update the start_time field
         task_obj = self.orm_wrapper.get_update_task_object(task_information)
 
-        self.internal_state['taskdata'][identifier] = {
-                        'start_time': datetime.datetime.now(),
-                        'outcome': task_information['outcome'],
-                    }
-
-
     def store_tasks_stats(self, event):
         for (taskfile, taskname, taskstats) in event.data:
             localfilepath = taskfile.split(":")[-1]
@@ -562,24 +586,15 @@ class BuildInfoHelper(object):
         localfilepath = event.taskfile.split(":")[-1]
         assert localfilepath.startswith("/")
 
-        identifier = event.taskfile + ":" + event.taskname
-        if not identifier in self.internal_state['taskdata']:
-            if isinstance(event, bb.build.TaskBase):
-                # we do a bit of guessing
-                candidates = [x for x in self.internal_state['taskdata'].keys() if x.endswith(identifier)]
-                if len(candidates) == 1:
-                    identifier = candidates[0]
+        (recipe, identifier) = self._get_real_recipe(event)
 
-        assert identifier in self.internal_state['taskdata']
-        identifierlist = identifier.split(":")
-        realtaskfile = ":".join(identifierlist[0:len(identifierlist)-1])
-        recipe_information = self._get_recipe_information_from_taskfile(realtaskfile)
-        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information, True)
         task_information = self._get_task_information(event,recipe)
-
-        task_information['start_time'] = self.internal_state['taskdata'][identifier]['start_time']
         task_information['outcome'] = self.internal_state['taskdata'][identifier]['outcome']
 
+        if 'time' in vars(event):
+            task_information['start_time'] = self.internal_state['taskdata'][identifier]['start_time']
+            task_information['end_time'] = event.time
+
         if 'logfile' in vars(event):
             task_information['logfile'] = event.logfile
 
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


From 1da35df930cb6b700bd80f792ba1ac928f81044c Mon Sep 17 00:00:00 2001
From: Marius Avram <marius.avram@intel.com>
Date: Tue, 11 Mar 2014 15:53:30 +0200
Subject: [PATCH 2/2] buildstats: use TaskBase time for elapsed time

To avoid any further inconsistencies between buildstats and buildinfohelper
from toaster, buildstats will measure task duration using the time field
from within the TaskBase events: TaskStarted and TaskSucceeded/TaskFailed.

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 meta/classes/buildstats.bbclass |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/meta/classes/buildstats.bbclass b/meta/classes/buildstats.bbclass
index 72fff11..89ae72c 100644
--- a/meta/classes/buildstats.bbclass
+++ b/meta/classes/buildstats.bbclass
@@ -109,14 +109,17 @@ def get_diskdata(var, dev, data):
         diskdata["End"+key] = str(int(newdiskdata[key]))    
     return diskdata
     
-def set_timedata(var, data):
+def set_timedata(var, data, server_time=None):
     import time
-    time = time.time()
+    if server_time:
+        time = server_time
+    else:
+        time = time.time()
     cputime = get_cputime()
     proctime = get_process_cputime(os.getpid())
     data.setVar(var, (time, cputime, proctime))
 
-def get_timedata(var, data):
+def get_timedata(var, data, server_time=None):
     import time
     timedata = data.getVar(var, False)
     if timedata is None:
@@ -124,7 +127,11 @@ def get_timedata(var, data):
     oldtime, oldcpu, oldproc = timedata
     procdiff = get_process_cputime(os.getpid()) - oldproc
     cpudiff = get_cputime() - oldcpu
-    timediff = time.time() - oldtime
+    if server_time:
+        end_time = server_time
+    else:
+        end_time = time.time()
+    timediff = end_time - oldtime
     if cpudiff > 0:
         cpuperc = float(procdiff) * 100 / cpudiff
     else:
@@ -136,7 +143,7 @@ def write_task_data(status, logfile, dev, e):
     bsdir = os.path.join(e.data.getVar('BUILDSTATS_BASE', True), bn)
     taskdir = os.path.join(bsdir, e.data.expand("${PF}"))
     file = open(os.path.join(logfile), "a")
-    timedata = get_timedata("__timedata_task", e.data)
+    timedata = get_timedata("__timedata_task", e.data, e.time)
     if timedata:
         elapsedtime, cpu = timedata
         file.write(bb.data.expand("${PF}: %s: Elapsed time: %0.2f seconds \n" %
@@ -160,7 +167,7 @@ def write_task_data(status, logfile, dev, e):
 	    file.write("Status: PASSED \n")
     else:
         file.write("Status: FAILED \n")
-    file.write("Ended: %0.2f \n" % time.time())
+    file.write("Ended: %0.2f \n" % e.time)
     file.close()
 
 python run_buildstats () {
@@ -234,7 +241,7 @@ python run_buildstats () {
         taskdir = os.path.join(bsdir, e.data.expand("${PF}"))
         if device != "NoLogicalDevice":
             set_diskdata("__diskdata_task", device, e.data)
-        set_timedata("__timedata_task", e.data)
+        set_timedata("__timedata_task", e.data, e.time)
         try:
             bb.utils.mkdirhier(taskdir)
         except:
@@ -242,7 +249,7 @@ python run_buildstats () {
         # write into the task event file the name and start time
         file = open(os.path.join(taskdir, e.task), "a")
         file.write("Event: %s \n" % bb.event.getName(e))
-        file.write("Started: %0.2f \n" % time.time())
+        file.write("Started: %0.2f \n" % e.time)
         file.close()
 
     elif isinstance(e, bb.build.TaskSucceeded):
-- 
1.7.9.5


