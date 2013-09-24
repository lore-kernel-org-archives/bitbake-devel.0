Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 528166CB13
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:14 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814542"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8546F561023; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:36 +0100
Message-Id: <c930bb0100717d380fd3ce5a24cf09b1098bfbc5.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 07/94] bitbake: webhob: make DSI store task information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:16 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch will enable DSI to store task related information.
Together with the task object, other objects need to be obtained
or created in order to respect the Django models defined.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 235 +++++++++++++++++++++++++++++++++--
 bitbake/lib/bb/ui/dsi.py             |   8 +-
 2 files changed, 231 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index c77248c..57e404b 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -11,6 +11,8 @@ class ORMWrapper(object):
 
     def __init__(self):
         self.uuid = None
+        self.task_order = 0
+        self.transport_utils = {}
 
     def get_machine_information(self, server):
         machine_info = {}
@@ -75,12 +77,12 @@ class ORMWrapper(object):
 
         return build
 
-    def update_build_object(self, build_obj, errors, warnings):
+    def update_build_object(self, build_obj, errors, warnings, taskfailures):
         # This needs to be imported after we have configured the Django settings file
         from webhob.orm.models import Build
 
         outcome = 0
-        if errors or warnings:
+        if errors or taskfailures:
             outcome = 1
 
         build = Build.objects.get(uuid=build_obj.uuid)
@@ -90,7 +92,212 @@ class ORMWrapper(object):
         build.outcome = outcome
         build.save()
 
-        return build_obj
+    def get_task_information(self, event):
+
+        self.task_order += 1
+
+        recipe = self.get_recipe_object(event)
+
+        task_information = {}
+        task_information['build'] = self.transport_utils['build']
+        task_information['order'] = self.task_order
+        task_information['task_executed'] = True
+        task_information['outcome'] = 0
+        task_information['sstate_checksum'] = 'Not Available'
+        task_information['path_to_sstate_obj'] = 'Not Available'
+        task_information['recipe'] = recipe
+        task_information['task_name'] = event._task
+        task_information['source_url'] = 'Not Available'
+        task_information['log_file'] = 'Not Available'
+        task_information['work_directory'] = 'Not Available'
+        task_information['script_type'] = 0
+        task_information['file_path'] = 'Not Available'
+        task_information['line_number'] = 0
+        task_information['py_stack_trace'] = 'Not Available'
+        task_information['disk_io'] = 0
+        task_information['cpu_usage'] = 0
+        task_information['elapsed_time'] = 'Not Available'
+        task_information['errors_no'] = 0
+        task_information['warnings_no'] = 0
+        task_information['error'] = 'Not Available'
+        task_information['warning'] = 'Not Available'
+        task_information['sstate_result'] = 0
+
+        return task_information
+
+    def create_task_object(self, task_information):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Task
+
+        identifier = task_information['recipe'].name + task_information['task_name']
+
+        task_object = Task.objects.get_or_create(
+                                build=task_information['build'],
+                                order=task_information['order'],
+                                task_executed=task_information['task_executed'],
+                                outcome=task_information['outcome'],
+                                sstate_checksum=task_information['sstate_checksum'],
+                                path_to_sstate_obj=task_information['path_to_sstate_obj'],
+                                recipe=task_information['recipe'],
+                                task_name=task_information['task_name'],
+                                source_url=task_information['source_url'],
+                                log_file=task_information['log_file'],
+                                work_directory=task_information['work_directory'],
+                                script_type=task_information['script_type'],
+                                file_path=task_information['file_path'],
+                                line_number=task_information['line_number'],
+                                py_stack_trace=task_information['py_stack_trace'],
+                                disk_io=task_information['disk_io'],
+                                cpu_usage=task_information['cpu_usage'],
+                                elapsed_time=task_information['elapsed_time'],
+                                errors_no=task_information['errors_no'],
+                                warnings_no=task_information['warnings_no'],
+                                error=task_information['error'],
+                                warning=task_information['warning'],
+                                sstate_result=task_information['sstate_result'])
+        task_object[0].save()
+
+        self.transport_utils[identifier] = {'object': task_object[0], 'start_time': datetime.datetime.now()}
+
+        return task_object[0]
+
+    def update_task_object(self, task_dictionary, event):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Task
+
+        task_object = task_dictionary['object']
+
+        task = Task.objects.get(build=task_object.build,
+                                task_name=task_object.task_name,
+                                recipe=task_object.recipe)
+
+        duration = datetime.datetime.now() - task_dictionary['start_time']
+        task.elapsed_time = duration.total_seconds()
+
+        outcome_info = self.get_outcome_of_task(event)
+        task.outcome = outcome_info['task_outcome']
+
+        if outcome_info.get('error', ''):
+            task.error = outcome_info['error']
+
+        #TODO: get error number
+        #TODO: get warnings number
+        #TODO: get warning information
+
+        task.save()
+
+    def get_outcome_of_task(self, event):
+        from webhob.orm.models import Task
+
+        outcome_info = {}
+
+        task_result = event.getDisplayName().lower()
+        for outcome in Task.TASK_OUTCOME:
+            if task_result == outcome[1].lower():
+                task_outcome = outcome[0]
+
+        outcome_info['task_outcome'] = task_outcome
+
+        if isinstance(event, bb.build.TaskFailed):
+            if event.logfile and os.path.exists(event.logfile):
+                outcome_info['error'] = open(event.logfile, "r").read()
+
+        return outcome_info
+
+    def get_recipe_object(self, event):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Recipe
+
+        recipe_information = self.get_recipe_information(event)
+
+        recipe_object = Recipe.objects.get_or_create(
+                                name=recipe_information['name'],
+                                version=recipe_information['version'],
+                                layer=recipe_information['layer'],
+                                summary=recipe_information['summary'],
+                                description=recipe_information['description'],
+                                section=recipe_information['section'],
+                                license=recipe_information['license'],
+                                licensing_info=recipe_information['licensing_info'],
+                                homepage=recipe_information['homepage'],
+                                bugtracker=recipe_information['bugtracker'],
+                                author=recipe_information['author'],
+                                file_path=recipe_information['file_path'])
+        recipe_object[0].save()
+
+        return recipe_object[0]
+
+    def get_recipe_information(self, event):
+
+        build_layer_obj = self.get_build_layer_object(event)
+
+        recipe_info = {}
+        recipe_info['name'] = event._package
+        recipe_info['version'] = 'Not Available'
+        recipe_info['layer'] = build_layer_obj
+        recipe_info['summary'] = 'Not Available'
+        recipe_info['description'] = 'Not Available'
+        recipe_info['section'] = 'Not Available'
+        recipe_info['license'] = 'Not Available'
+        recipe_info['licensing_info'] = 'Not Available'
+        recipe_info['homepage'] = 'Not Available'
+        recipe_info['bugtracker'] = 'Not Available'
+        recipe_info['author'] = 'Not Available'
+        recipe_info['file_path'] = 'Not Available'
+
+        return recipe_info
+
+    def get_build_layer_object(self, event):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Build_Layer
+
+        build_layer_information = self.get_build_layer_information(event)
+
+        build_layer_object = Build_Layer.objects.get_or_create(
+                                    build = build_layer_information['build'],
+                                    layer = build_layer_information['layer'],
+                                    branch = build_layer_information['branch'],
+                                    commit = build_layer_information['commit'],
+                                    priority = build_layer_information['priority'])
+        build_layer_object[0].save()
+
+        return build_layer_object[0]
+
+    def get_build_layer_information(self, event):
+
+        layer_object = self.get_layer_object(event)
+
+        build_layer_info = {}
+        build_layer_info['build'] = self.transport_utils['build']
+        build_layer_info['layer'] = layer_object
+        build_layer_info['branch'] = 'Not Available'
+        build_layer_info['commit'] = 'Not Available'
+        build_layer_info['priority'] = 0
+
+        return build_layer_info
+
+    def get_layer_object(self, event):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Layer
+
+        layer_information = self.get_layer_information(event)
+
+        layer_object = Layer.objects.get_or_create(
+                                name=layer_information['name'],
+                                local_path=layer_information['local_path'],
+                                layer_index_url=layer_information['layer_index_url'])
+        layer_object[0].save()
+
+        return layer_object[0]
+
+    def get_layer_information(self, event):
+
+        layer_info = {}
+        layer_info['name'] = 'Layer Test Name'
+        layer_info['local_path'] = 'Not Available'
+        layer_info['layer_index_url'] = 'Not Available'
+
+        return layer_info
 
 
 class BuildInfoHelper(object):
@@ -100,10 +307,6 @@ class BuildInfoHelper(object):
 
     def __init__(self):
         self.configure_django()
-        self.task_order = 0
-        self.tasks_information = {}
-        self.uuid = None
-        self.transport_utils = {}
         self.orm_wrapper = ORMWrapper()
 
     def configure_django(self):
@@ -120,8 +323,18 @@ class BuildInfoHelper(object):
 
         build_information = self.orm_wrapper.get_build_information(server, machine_obj)
         build_obj = self.orm_wrapper.create_build_object(build_information)
-        self.transport_utils['build'] = build_obj
+        self.orm_wrapper.transport_utils['build'] = build_obj
+
+    def update_build_information(self, event, errors, warnings, taskfailures):
+        self.orm_wrapper.update_build_object(self.orm_wrapper.transport_utils['build'], errors, warnings, taskfailures)
+        del self.orm_wrapper.transport_utils['build']
+
+    def store_started_task(self, event):
+        task_information = self.orm_wrapper.get_task_information(event)
+        task_obj = self.orm_wrapper.create_task_object(task_information)
 
-    def update_build_information(self, event, errors, warnings):
-        build_obj = self.orm_wrapper.update_build_object(self.transport_utils['build'], errors, warnings)
-        del self.transport_utils['build']
+    def update_and_store_task(self, event):
+        identifier = event._package + event._task
+        task_dictionary = self.orm_wrapper.transport_utils[identifier]
+        self.orm_wrapper.update_task_object(task_dictionary, event)
+        del self.orm_wrapper.transport_utils[identifier]
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index d7b038c..54364ce 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -308,6 +308,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event, server)
 
+            if isinstance(event, bb.build.TaskStarted):
+                buildinfohelper.store_started_task(event)
+
+            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
+                buildinfohelper.update_and_store_task(event)
+
             if isinstance(event, bb.event.LogExecTTY):
                 if log_exec_tty:
                     tries = event.retries
@@ -443,7 +449,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, (bb.command.CommandFailed, bb.command.CommandExit, bb.command.CommandCompleted, bb.cooker.CookerExit)):
-                buildinfohelper.update_build_information(event, errors, warnings)
+                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 main.shutdown = 2
 
             if isinstance(event, bb.event.ConfigParsed):
-- 
1.8.1.2


