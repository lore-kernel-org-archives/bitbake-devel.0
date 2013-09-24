Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 2DDF26CC5B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511858"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A78DF5611BD; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:48 +0100
Message-Id: <5be34ab42f250255485d284f4c84e8a76a75d75c.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 19/94] bitbake: dsi: saving prebuild task detailed information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:29 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Changes to the internal structure of the database interface layer.

Clearing up the code to save information about prebuild tasks.

Clear up the event-processing fall-through code in DSI.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 54 +++++++++++++-----------------------
 bitbake/lib/bb/ui/dsi.py             |  9 ++++--
 2 files changed, 25 insertions(+), 38 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index c743751..a0da2e1 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -1,6 +1,7 @@
 import datetime
 import sys
 import uuid
+import bb
 
 
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
@@ -97,19 +98,24 @@ class ORMWrapper(object):
 
     def get_task_information(self, event):
 
-        self.task_order += 1
 
         recipe = self.get_recipe_object(event)
 
         task_information = {}
         task_information['build'] = self.transport_utils['build']
-        task_information['order'] = self.task_order
-        task_information['task_executed'] = True
-        task_information['outcome'] = 0
+        task_information['outcome'] = 4
+        if isinstance(event, bb.runqueue.runQueueTaskSkipped):
+            task_information['task_executed'] = False
+            if event._skip == "covered":
+                task_information['outcome'] = 2
+            if event._skip == "existing":
+                task_information['outcome'] = 0
+        else:
+            task_information['task_executed'] = True
         task_information['sstate_checksum'] = 'Not Available'
         task_information['path_to_sstate_obj'] = 'Not Available'
         task_information['recipe'] = recipe
-        task_information['task_name'] = event._task
+        task_information['task_name'] = event.taskname
         task_information['source_url'] = 'Not Available'
         task_information['log_file'] = 'Not Available'
         task_information['work_directory'] = 'Not Available'
@@ -165,21 +171,16 @@ class ORMWrapper(object):
 
     def update_task_object(self, task_dictionary, event):
         # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Task
-
-        task_object = task_dictionary['object']
 
-        task = Task.objects.get(build=task_object.build,
-                                task_name=task_object.task_name,
-                                recipe=task_object.recipe)
+        task = task_dictionary['object']
 
         duration = datetime.datetime.now() - task_dictionary['start_time']
         task.elapsed_time = duration.total_seconds()
 
-        outcome_info = self.get_outcome_of_task(event)
-        task.outcome = outcome_info['task_outcome']
+        if isinstance(event, bb.runqueue.runQueueTaskCompleted):
+            task.outcome = 3
 
-        task_build_stats = self.get_task_build_stats(task_object)
+        task_build_stats = self.get_task_build_stats(task)
         task.cpu_usage = task_build_stats['cpu_usage']
         task.disk_io = task_build_stats['disk_io']
 
@@ -192,24 +193,6 @@ class ORMWrapper(object):
 
         task.save()
 
-    def get_outcome_of_task(self, event):
-        from webhob.orm.models import Task
-
-        outcome_info = {}
-
-        task_result = event.getDisplayName().lower()
-        for outcome in Task.TASK_OUTCOME:
-            if task_result == outcome[1].lower():
-                task_outcome = outcome[0]
-
-        outcome_info['task_outcome'] = task_outcome
-
-        if isinstance(event, bb.build.TaskFailed):
-            if event.logfile and os.path.exists(event.logfile):
-                outcome_info['error'] = open(event.logfile, "r").read()
-
-        return outcome_info
-
     def get_task_build_stats(self, task_object):
         bs_path = self.get_path_information(task_object)
         task_build_stats = self.get_build_stats_from_file(bs_path, task_object.task_name)
@@ -288,7 +271,7 @@ class ORMWrapper(object):
         build_layer_obj = self.get_build_layer_object(event)
 
         recipe_info = {}
-        recipe_info['name'] = event._package
+        recipe_info['name'] = event.taskpackage
         recipe_info['version'] = 'Not Available'
         recipe_info['layer'] = build_layer_obj
         recipe_info['summary'] = 'Not Available'
@@ -373,9 +356,10 @@ class BuildInfoHelper(object):
         machine_obj = self.orm_wrapper.create_machine_object(machine_information)
 
         build_information = self.orm_wrapper.get_build_information(machine_obj)
+        build_information['target'] = ' '.join(event.getPkgs())
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.orm_wrapper.transport_utils['build'] = build_obj
-        self.orm_wrapper.transport_utils['target'] = event.getPkgs()[0]
+        self.orm_wrapper.transport_utils['target'] = build_information['target']
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         self.orm_wrapper.update_build_object(self.orm_wrapper.transport_utils['build'], errors, warnings, taskfailures)
@@ -386,7 +370,7 @@ class BuildInfoHelper(object):
         task_obj = self.orm_wrapper.create_task_object(task_information)
 
     def update_and_store_task(self, event):
-        identifier = event._package + event._task
+        identifier = event.taskpackage + event.taskname
         task_dictionary = self.orm_wrapper.transport_utils[identifier]
         self.orm_wrapper.update_task_object(task_dictionary, event)
         del self.orm_wrapper.transport_utils[identifier]
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index e527e56..6264ecc 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -411,12 +411,17 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                             event.stats.completed + event.stats.active +
                                 event.stats.failed + 1,
                             event.stats.total, event.taskid, event.taskstring)
+                buildinfohelper.store_started_task(event)
                 continue
 
-            if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.runQueueTaskSkipped)):
+            if isinstance(event, (bb.runqueue.runQueueTaskStarted, bb.runqueue.runQueueTaskSkipped)):
                 buildinfohelper.store_started_task(event)
                 continue
 
+            if isinstance(event, bb.runqueue.runQueueTaskCompleted):
+                buildinfohelper.update_and_store_task(event)
+                continue
+
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 buildinfohelper.update_and_store_task(event)
                 taskfailures.append(event.taskstring)
@@ -430,8 +435,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
-            if isinstance(event, bb.event.BuildCompleted):
-                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
 
             if isinstance(event, bb.event.ConfigParsed):
                 # timestamp should be added for this
-- 
1.8.1.2


