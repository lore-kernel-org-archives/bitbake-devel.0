Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 9B8566CB9A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948505"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B88C45613ED; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:55 +0100
Message-Id: <8b417d6044184b894d5925a61306da381e0eba0d.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 26/94] bitbake: dsi: refactor the BuildInfoHelper code
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a in-depth refactoring of the BuildInfoHelper code
designed to promote clean separation of code behinnd the
data interfaces.

ORMWrapper now contains only database-related code.
BuildInfoHelper keeps track of the internal state, and
translated the Bitbake event-based data into dictionaries
that the ORM layer can process.

DSI now sets featureSets to get a complete dependency dump.

The code uses the dependency information dump to create
all the recipe and task entries before actual running the
build, providing safe default.

The database models have been updated to allow for NULL
values instead of creating generic placeholders.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py             | 546 ++++++++++++-----------
 bitbake/lib/bb/ui/dsi.py                         |  14 +
 bitbake/lib/webhob/bldviewer/templates/task.html |   2 +-
 bitbake/lib/webhob/orm/models.py                 |  67 +--
 4 files changed, 333 insertions(+), 296 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index e43aa8c..07296d9 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -2,12 +2,13 @@ import datetime
 import sys
 import uuid
 import bb
+import re
 
 
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer
+from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer, Package, Task_Dependency, Package_Dependency
 
 class ORMWrapper(object):
     """ This class creates the dictionaries needed to store information in the database
@@ -15,21 +16,8 @@ class ORMWrapper(object):
         information in the database.
     """
 
-    def __init__(self, server):
-        self.uuid = None
-        self.task_order = 0
-        self.transport_utils = {}
-        self.server = server
-
-    def get_machine_information(self):
-        machine_info = {}
-
-        machine_info['name'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
-        machine_info['description'] = 'Not Available'
-
-        self.transport_utils['machine'] = machine_info['name']
-
-        return machine_info
+    def __init__(self):
+        pass
 
     def create_machine_object(self, machine_information):
 
@@ -38,29 +26,6 @@ class ORMWrapper(object):
 
         return machine[0]
 
-    def get_build_information(self, machine_obj):
-        build_info = {}
-
-        # Generate an identifier for each new build
-        self.uuid = str(uuid.uuid4())
-
-        build_info['uuid'] = self.uuid
-        build_info['target'] = 'Not Available'
-        build_info['machine'] = machine_obj
-        build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
-        build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
-        build_info['started_on'] = datetime.datetime.now()
-        build_info['completed_on'] = datetime.datetime.now()
-        build_info['outcome'] = 0
-        build_info['number_of_errors'] = 0
-        build_info['number_of_warnings'] = 0
-        build_info['image_fstypes'] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
-        build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
-        build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
-        build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
-
-        return build_info
-
     def create_build_object(self, build_info):
 
         build = Build.objects.create(uuid=build_info['uuid'],
@@ -70,14 +35,12 @@ class ORMWrapper(object):
                                     distro_version=build_info['distro_version'],
                                     started_on=build_info['started_on'],
                                     completed_on=build_info['completed_on'],
-                                    outcome=build_info['outcome'],
-                                    errors_no=build_info['number_of_errors'],
-                                    warnings_no=build_info['number_of_warnings'],
                                     image_fstypes=build_info['image_fstypes'],
                                     cooker_log_path=build_info['cooker_log_path'],
                                     build_name=build_info['build_name'],
                                     bitbake_version=build_info['bitbake_version'])
 
+
         return build
 
     def update_build_object(self, build_obj, errors, warnings, taskfailures):
@@ -93,12 +56,178 @@ class ORMWrapper(object):
         build.outcome = outcome
         build.save()
 
-    def get_task_information(self, event):
 
-        recipe = self._get_recipe_object(event)
+    def get_update_task_object(self, task_information):
+        task_object, created = Task.objects.get_or_create(
+                                build=task_information['build'],
+                                recipe=task_information['recipe'],
+                                task_name=task_information['task_name'],
+                                )
+
+        for v in vars(task_object):
+            if v in task_information.keys():
+                vars(task_object)[v] = task_information[v]
+
+        if 'start_time' in task_information.keys():
+            duration = datetime.datetime.now() - task_information['start_time']
+            task_object.elapsed_time = duration.total_seconds()
+
+        task_object.save()
+        return task_object
+
+
+    def get_update_recipe_object(self, recipe_information):
+
+        recipe_object, created = Recipe.objects.get_or_create(
+                                         build_layer=recipe_information['build_layer'],
+                                         file_path=recipe_information['file_path'])
+
+        for v in vars(recipe_object):
+            if v in recipe_information.keys():
+                vars(recipe_object)[v] = recipe_information[v]
+
+        recipe_object.save()
+
+        return recipe_object
+
+    def get_build_layer_object(self, build_layer_information):
+
+        build_layer_object = Build_Layer.objects.get_or_create(
+                                    build = build_layer_information['build'],
+                                    layer = build_layer_information['layer'],
+                                    branch = build_layer_information['branch'],
+                                    commit = build_layer_information['commit'],
+                                    priority = build_layer_information['priority']
+                                    )
+
+        build_layer_object[0].save()
+
+        return build_layer_object[0]
+
+    def get_update_layer_object(self, layer_information):
+
+        layer_object = Layer.objects.get_or_create(
+                                name=layer_information['name'],
+                                local_path=layer_information['local_path'],
+                                layer_index_url=layer_information['layer_index_url'])
+        layer_object[0].save()
+
+        return layer_object[0]
+
+
+class BuildInfoHelper(object):
+    """ This class gathers the build information from the server and sends it
+        towards the ORM wrapper for storing in the database
+        It is instantiated once per build
+        Keeps in memory all data that needs matching before writing it to the database
+    """
+
+    def __init__(self, server):
+        self._configure_django()
+        self.internal_state = {}
+        self.uuid = None
+        self.task_order = 0
+        self.server = server
+        self.orm_wrapper = ORMWrapper()
+
+    def _configure_django(self):
+        # Add webhob to sys path for importing modules
+        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
+
+    ###################
+    ## methods to convert event/external info into objects that the ORM layer uses
+
+    def _get_machine_information(self):
+        machine_info = {}
+        machine_info['name'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
+        machine_info['description'] = 'Not Available'
+        self.internal_state['machine'] = machine_info['name']
+        return machine_info
+
+    def _get_layer_dict(self, layer_path):
+
+        layer_info = {}
+        layer_name = layer_path.split('/')[-1]
+        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
+        layer_url_name = self._get_url_map_name(layer_name)
+
+        layer_info['name'] = layer_name
+        layer_info['local_path'] = layer_path
+        layer_info['layer_index_url'] = layer_url.format(layer=layer_url_name)
+
+        return layer_info
+
+    def _get_url_map_name(self, layer_name):
+        """ Some layers have a different name on openembedded.org site,
+            this method returns the correct name to use in the URL
+        """
+
+        url_name = layer_name
+        url_mapping = {'meta': 'openembedded-core'}
+
+        for key in url_mapping.keys():
+            if key == layer_name:
+                url_name = url_mapping[key]
+
+        return url_name
+
+    def _get_layer_information(self):
+
+        layer_info = {}
+
+        return layer_info
+
+    def _get_build_layer_information(self, layer_object):
+
+        build_layer_info = {}
+        build_layer_info['build'] = self.internal_state['build']
+        build_layer_info['layer'] = layer_object
+        build_layer_info['branch'] = self._get_git_branch(layer_object.local_path)
+        build_layer_info['commit'] = self._get_git_revision(layer_object.local_path)
+        build_layer_info['priority'] = 0
+
+        return build_layer_info
+
+
+    def _get_git_branch(self, layer_path):
+        branch = os.popen('cd {path}; git branch 2>&1 | grep "^* " | tr -d "* "'.format(path=layer_path)).read()
+
+        if len(branch) != 0:
+            return branch
+        return "<unknown>"
+
+    def _get_git_revision(self, layer_path):
+        f = os.popen("cd {path}; git log -n 1 --pretty=oneline -- 2>&1".format(path=layer_path))
+        data = f.read()
+        if f.close() is None:
+            rev = data.split(" ")[0]
+            if len(rev) != 0:
+                return rev
+        return "<unknown>"
+
+
+    def _get_build_information(self, machine_obj):
+        build_info = {}
+        # Generate an identifier for each new build
+
+        build_info['uuid'] = self.uuid
+        build_info['machine'] = machine_obj
+        build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
+        build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
+        build_info['started_on'] = datetime.datetime.now()
+        build_info['completed_on'] = datetime.datetime.now()
+        build_info['image_fstypes'] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
+        build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
+        build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
+        build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
+
+        return build_info
+
+    def _get_task_information(self, event, recipe):
+
 
         task_information = {}
-        task_information['build'] = self.transport_utils['build']
+        task_information['build'] = self.internal_state['build']
         task_information['outcome'] = 4
         if isinstance(event, bb.runqueue.runQueueTaskSkipped):
             task_information['task_executed'] = False
@@ -108,86 +237,33 @@ class ORMWrapper(object):
                 task_information['outcome'] = 0
         else:
             task_information['task_executed'] = True
-        task_information['sstate_checksum'] = 'Not Available'
-        task_information['path_to_sstate_obj'] = 'Not Available'
         task_information['recipe'] = recipe
         task_information['task_name'] = event.taskname
-        task_information['source_url'] = 'Not Available'
-        task_information['log_file'] = 'Not Available'
-        task_information['work_directory'] = 'Not Available'
-        task_information['script_type'] = 0
-        task_information['file_path'] = event.taskfile
-        task_information['line_number'] = 0
-        task_information['py_stack_trace'] = 'Not Available'
-        task_information['disk_io'] = 0
-        task_information['cpu_usage'] = 0
-        task_information['elapsed_time'] = 'Not Available'
-        task_information['errors_no'] = 0
-        task_information['warnings_no'] = 0
-        task_information['error'] = 'Not Available'
-        task_information['warning'] = 'Not Available'
-        task_information['sstate_result'] = 0
-
         return task_information
 
-    def create_task_object(self, task_information):
-        self.task_order += 1
-        identifier = task_information['recipe'].file_path + task_information['task_name']
+    def _get_build_layer_for_path(self, path):
+        def _slkey(build_layer):
+            return len(build_layer.layer.local_path)
 
-        task_object = Task.objects.get_or_create(
-                                build=task_information['build'],
-                                order=self.task_order,
-                                task_executed=task_information['task_executed'],
-                                outcome=task_information['outcome'],
-                                sstate_checksum=task_information['sstate_checksum'],
-                                path_to_sstate_obj=task_information['path_to_sstate_obj'],
-                                recipe=task_information['recipe'],
-                                task_name=task_information['task_name'],
-                                source_url=task_information['source_url'],
-                                log_file=task_information['log_file'],
-                                work_directory=task_information['work_directory'],
-                                script_type=task_information['script_type'],
-                                file_path=task_information['file_path'],
-                                line_number=task_information['line_number'],
-                                py_stack_trace=task_information['py_stack_trace'],
-                                disk_io=task_information['disk_io'],
-                                cpu_usage=task_information['cpu_usage'],
-                                elapsed_time=task_information['elapsed_time'],
-                                errors_no=task_information['errors_no'],
-                                warnings_no=task_information['warnings_no'],
-                                error=task_information['error'],
-                                warning=task_information['warning'],
-                                sstate_result=task_information['sstate_result'])
-        task_object[0].save()
-
-        self.transport_utils[identifier] = {'object': task_object[0], 'start_time': datetime.datetime.now()}
-
-        return task_object[0]
-
-    def update_task_object(self, task_dictionary, event):
-
-        task = task_dictionary['object']
-
-        duration = datetime.datetime.now() - task_dictionary['start_time']
-        task.elapsed_time = duration.total_seconds()
+        # Heuristics: we always match recipe to the deepest layer path that
+        # we can match to the recipe file path
+        for bl in sorted(self.internal_state['build_layers'], reverse=True, key=_slkey):
+            if (path.startswith(bl.layer.local_path)):
+                return bl
 
-        if isinstance(event, bb.runqueue.runQueueTaskCompleted):
-            task.outcome = 3
-            task.save()
+        #TODO: if we get here, we didn't read layers correctly
+        assert False
+        return None
 
-        if isinstance(event, bb.build.TaskBase):
-            task.recipe.name = event._package
-            task.recipe.save()
+    def _get_recipe_information_from_build_event(self, event):
 
-        task_build_stats = self._get_task_build_stats(task)
-        task.cpu_usage = task_build_stats['cpu_usage']
-        task.disk_io = task_build_stats['disk_io']
+        build_layer_obj = self._get_build_layer_for_path(re.split(':', event.taskfile)[-1])
 
-        #TODO: get error number
-        #TODO: get warnings number
-        #TODO: get warning information
+        recipe_info = {}
+        recipe_info['build_layer'] = build_layer_obj
+        recipe_info['file_path'] = re.split(':', event.taskfile)[-1]
 
-        task.save()
+        return recipe_info
 
     def _get_task_build_stats(self, task_object):
         bs_path = self._get_path_information(task_object)
@@ -199,9 +275,9 @@ class ORMWrapper(object):
         build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
 
         tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
-        target = self.transport_utils['target']
-        machine = self.transport_utils['build'].machine.name
-        buildname = self.transport_utils['build'].build_name
+        target = self.internal_state['target']
+        machine = self.internal_state['build'].machine.name
+        buildname = self.internal_state['build'].build_name
         package = task_object.recipe.name
 
         build_stats_path = build_stats_format.format(tmpdir=tmp_dir, target=target,
@@ -240,177 +316,121 @@ class ORMWrapper(object):
 
         return task_build_stats
 
-    def _get_recipe_object(self, event):
 
-        recipe_information = self._get_recipe_information(event)
+    ################################
+    ## external available methods to store information
 
-        recipe_object = Recipe.objects.get_or_create(
-                                name=recipe_information['name'],
-                                version=recipe_information['version'],
-                                layer=recipe_information['layer'],
-                                summary=recipe_information['summary'],
-                                description=recipe_information['description'],
-                                section=recipe_information['section'],
-                                license=recipe_information['license'],
-                                licensing_info=recipe_information['licensing_info'],
-                                homepage=recipe_information['homepage'],
-                                bugtracker=recipe_information['bugtracker'],
-                                author=recipe_information['author'],
-                                file_path=recipe_information['file_path'])
-        recipe_object[0].save()
-
-        return recipe_object[0]
-
-    def _get_recipe_information(self, event):
-
-        build_layer_obj = self._get_build_layer_object(event)
-
-        recipe_info = {}
-        recipe_info['name'] = 'N/A'
-        recipe_info['version'] = 'Not Available'
-        recipe_info['layer'] = build_layer_obj
-        recipe_info['summary'] = 'Not Available'
-        recipe_info['description'] = 'Not Available'
-        recipe_info['section'] = 'Not Available'
-        recipe_info['license'] = 'Not Available'
-        recipe_info['licensing_info'] = 'Not Available'
-        recipe_info['homepage'] = 'Not Available'
-        recipe_info['bugtracker'] = 'Not Available'
-        recipe_info['author'] = 'Not Available'
-        recipe_info['file_path'] = event.taskfile
-
-
-        return recipe_info
-
-    def _get_build_layer_object(self, event):
-
-        build_layer_information = self._get_build_layer_information(event)
-
-        build_layer_object = Build_Layer.objects.get_or_create(
-                                    build = build_layer_information['build'],
-                                    layer = build_layer_information['layer'],
-                                    branch = build_layer_information['branch'],
-                                    commit = build_layer_information['commit'],
-                                    priority = build_layer_information['priority'])
-        build_layer_object[0].save()
-
-        return build_layer_object[0]
-
-    def _get_build_layer_information(self, event):
-
-        layer_object = self._get_layer_object(event)
-
-        build_layer_info = {}
-        build_layer_info['build'] = self.transport_utils['build']
-        build_layer_info['layer'] = layer_object
-        build_layer_info['branch'] = 'Not Available'
-        build_layer_info['commit'] = 'Not Available'
-        build_layer_info['priority'] = 0
-
-        return build_layer_info
-
-    def _get_layer_object(self, event):
-
-        layer_information = self._get_layer_information(event)
-
-        layer_object = Layer.objects.get_or_create(
-                                name=layer_information['name'],
-                                local_path=layer_information['local_path'],
-                                layer_index_url=layer_information['layer_index_url'])
-        layer_object[0].save()
+    def store_layer_info(self):
+        layers = self.server.runCommand(["getVariable", "BBLAYERS"])[0].strip().split(" ")
+        self.internal_state['layers'] = []
+        for layer_path in { l for l in layers if len(l) }:
+            layer_information = self._get_layer_dict(layer_path)
+            self.internal_state['layers'].append(self.orm_wrapper.get_update_layer_object(layer_information))
 
-        return layer_object[0]
+    def store_started_build(self, event):
 
-    def _get_layer_information(self, event):
+        machine_information = self._get_machine_information()
+        machine_obj = self.orm_wrapper.create_machine_object(machine_information)
+        self.uuid = str(uuid.uuid4())
 
-        layer_info = {}
-        layer_info['name'] = 'Layer Test Name'
-        layer_info['local_path'] = 'Not Available'
-        layer_info['layer_index_url'] = 'Not Available'
+        build_information = self._get_build_information(machine_obj)
+        build_information['target'] = ' '.join(event.getPkgs())
+        build_obj = self.orm_wrapper.create_build_object(build_information)
+        self.internal_state['build'] = build_obj
+        self.internal_state['target'] = build_information['target']
+        self.internal_state['build_layers'] = []
+        for layer_object in self.internal_state['layers']:
+            build_layer_information = self._get_build_layer_information(layer_object)
+            self.internal_state['build_layers'].append(self.orm_wrapper.get_build_layer_object(build_layer_information))
 
-        return layer_info
+        del self.internal_state['layers']
 
-    def _get_layer_dict(self, layer_path):
 
-        layer_info = {}
-        layer_name = layer_path.split('/')[-1]
-        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
-        layer_url_name = self._get_url_map_name(layer_name)
-
-        layer_info['name'] = layer_name
-        layer_info['local_path'] = layer_path
-        layer_info['layer_index_url'] = layer_url.format(layer=layer_url_name)
 
-        return layer_info
+    def update_build_information(self, event, errors, warnings, taskfailures):
+        self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
+        del self.internal_state['build']
 
-    def _get_url_map_name(self, layer_name):
-        """ Some layers have a different name on openembedded.org site,
-            this method returns the correct name to use in the URL
-        """
+    def store_started_task(self, event):
+        identifier = re.split(':', event.taskfile)[-1] + event.taskname
 
-        url_name = layer_name
-        url_mapping = {'meta': 'openembedded-core'}
+        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
 
-        for key in url_mapping.keys():
-            if key == layer_name:
-                url_name = url_mapping[key]
+        task_information = self._get_task_information(event, recipe)
 
-        return url_name
+        self.task_order += 1
+        task_information['order'] = self.task_order
+        task_obj = self.orm_wrapper.get_update_task_object(task_information)
 
-    def _save_layer_object(self, layer_path):
+        self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
 
-        layer_information = self._get_layer_dict(layer_path)
+    def update_and_store_task(self, event):
+        identifier = re.split(':', event.taskfile)[-1] + event.taskname
+        recipe_information = self._get_recipe_information_from_build_event(event)
+        recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
+        task_information = self._get_task_information(event,recipe)
+        try:
+            task_information['start_time'] = self.internal_state[identifier]['start_time']
+        except:
+            pass
 
-        layer_object = Layer.objects.get_or_create(
-                            name=layer_information['name'],
-                            local_path=layer_information['local_path'],
-                            layer_index_url=layer_information['layer_index_url'])
+        if isinstance(event, bb.runqueue.runQueueTaskCompleted):
+            task_information['outcome'] = 3     # TODO: needs to use constants
+            task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
+            task_information['cpu_usage'] = task_build_stats['cpu_usage']
+            task_information['disk_io'] = task_build_stats['disk_io']
+            del self.internal_state[identifier]
 
-        layer_object[0].save()
+        #TODO: get error number
+        #TODO: get warnings number
+        #TODO: get warning information
 
-    def store_layer_info(self):
-        layers = self.server.runCommand(["getVariable", "BBLAYERS"])[0].strip().split(" ")
-        for layer_path in layers:
-            self._save_layer_object(layer_path)
 
+        self.orm_wrapper.get_update_task_object(task_information)
 
-class BuildInfoHelper(object):
-    """ This class gathers the build information from the server and sends it
-        towards the ORM wrapper for storing in the database
-    """
 
-    def __init__(self, server):
-        self._configure_django()
-        self.orm_wrapper = ORMWrapper(server)
 
-    def _configure_django(self):
-        # Add webhob to sys path for importing modules
-        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
+    def store_dependency_information(self, event):
+        self.internal_state['recipes'] = {}
+        for pn in event._depgraph['pn']:
 
-    def store_started_build(self, event):
+            file_name = re.split(':', event._depgraph['pn'][pn]['filename'])[-1]
+            build_layer_obj = self._get_build_layer_for_path(re.split(':', file_name)[-1])
 
-        self.orm_wrapper.store_layer_info()
+            assert build_layer_obj is not None
 
-        machine_information = self.orm_wrapper.get_machine_information()
-        machine_obj = self.orm_wrapper.create_machine_object(machine_information)
+            recipe_info = {}
+            recipe_info['name'] = pn
+            recipe_info['version'] = event._depgraph['pn'][pn]['version']
+            recipe_info['build_layer'] = build_layer_obj
 
-        build_information = self.orm_wrapper.get_build_information(machine_obj)
-        build_information['target'] = ' '.join(event.getPkgs())
-        build_obj = self.orm_wrapper.create_build_object(build_information)
-        self.orm_wrapper.transport_utils['build'] = build_obj
-        self.orm_wrapper.transport_utils['target'] = build_information['target']
+            # TODO: dump all this info in the deptree event
+            recipe_info['summary'] = 'Not Available'
+            recipe_info['description'] = 'Not Available'
+            recipe_info['section'] = 'Not Available'
+            recipe_info['license'] = 'Not Available'
+            recipe_info['licensing_info'] = 'Not Available'
+            recipe_info['homepage'] = 'Not Available'
+            recipe_info['bugtracker'] = 'Not Available'
+            recipe_info['author'] = 'Not Available'
+            recipe_info['file_path'] = file_name
+            recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
+            self.internal_state['recipes'][pn] = recipe
 
-    def update_build_information(self, event, errors, warnings, taskfailures):
-        self.orm_wrapper.update_build_object(self.orm_wrapper.transport_utils['build'], errors, warnings, taskfailures)
-        del self.orm_wrapper.transport_utils['build']
+        def _save_a_task(taskdesc):
+            pn, taskname = re.split(r'\.', taskdesc);
+            e = event
+            e.taskname = pn
+            recipe = self.internal_state['recipes'][pn]
+            task_info = self._get_task_information(e, recipe)
+            task_info['task_name'] = taskname
+            task_obj = self.orm_wrapper.get_update_task_object(task_info)
+            return task_obj
 
-    def store_started_task(self, event):
-        task_information = self.orm_wrapper.get_task_information(event)
-        task_obj = self.orm_wrapper.create_task_object(task_information)
+        for taskdesc in event._depgraph['tdepends']:
+            _save_a_task(taskdesc)
+            for taskdesc1 in event._depgraph['tdepends'][taskdesc]:
+                _save_a_task(taskdesc1)
 
-    def update_and_store_task(self, event):
-        identifier = event.taskfile + event.taskname
-        task_dictionary = self.orm_wrapper.transport_utils[identifier]
-        self.orm_wrapper.update_task_object(task_dictionary, event)
-        if isinstance(event,bb.runqueue.runQueueTaskCompleted):
-            del self.orm_wrapper.transport_utils[identifier]
+        del self.internal_state['recipes']
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 22b35e2..d03a7c5 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -17,6 +17,11 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
+try:
+    import bb
+except RuntimeError as exc:
+    sys.exit(str(exc))
+
 from bb.ui import uihelper
 from bb.ui.buildinfohelper import BuildInfoHelper
 
@@ -32,6 +37,7 @@ import sys
 import time
 import xmlrpclib
 
+featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.SEND_DEPENDS_TREE]
 
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
@@ -268,7 +274,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errors = 0
     warnings = 0
     taskfailures = []
+
     buildinfohelper = BuildInfoHelper(server)
+    buildinfohelper.store_layer_info()
 
     termfilter = tf(main, helper, console, format)
 
@@ -464,8 +472,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+
                 # we start a new build info
                 buildinfohelper = BuildInfoHelper(server)
+                buildinfohelper.store_layer_info()
                 continue
 
             # ignore
@@ -481,6 +491,10 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.cooker.CookerExit)):
                 continue
 
+            if isinstance(event, bb.event.DepTreeGenerated):
+                buildinfohelper.store_dependency_information(event)
+                continue
+
             logger.error("Unknown event: %s", event)
 
         except EnvironmentError as ioerror:
diff --git a/bitbake/lib/webhob/bldviewer/templates/task.html b/bitbake/lib/webhob/bldviewer/templates/task.html
index 26a09e9..7410489 100644
--- a/bitbake/lib/webhob/bldviewer/templates/task.html
+++ b/bitbake/lib/webhob/bldviewer/templates/task.html
@@ -64,7 +64,7 @@
 				<td>{{task.path_to_sstate_obj}}</td>
 				<td>{{task.source_url}}</td>
 				<td>{{task.get_script_type_display}}</td>
-				<td>{{task.file_path}}</td>
+				<td>{{task.recipe.file_path}}</td>
 				<td>{{task.line_number}}</td>
 				<td>{{task.py_stack_trace}}</td>
 				<td>{{task.get_sstate_result_display}}</td>
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 76b7c1d..dfbc0ae 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -6,6 +6,7 @@ class Build(models.Model):
     BUILD_OUTCOME = (
         (0, 'Succeeded'),
         (1, 'Failed'),
+        (2, 'In Progress'),
     )
 
     uuid = models.CharField(max_length=100, unique=True)
@@ -15,9 +16,9 @@ class Build(models.Model):
     distro_version = models.CharField(max_length=100)
     started_on = models.DateTimeField()
     completed_on = models.DateTimeField()
-    outcome = models.IntegerField(choices=BUILD_OUTCOME)
-    errors_no = models.IntegerField()
-    warnings_no = models.IntegerField()
+    outcome = models.IntegerField(choices=BUILD_OUTCOME, default=2)
+    errors_no = models.IntegerField(default=0)
+    warnings_no = models.IntegerField(default=0)
     image_fstypes = models.CharField(max_length=100)
     cooker_log_path = models.CharField(max_length=500)
     build_name = models.CharField(max_length=100)
@@ -47,28 +48,30 @@ class Task(models.Model):
     )
 
     build = models.ForeignKey(Build, related_name='task_build')
-    order = models.IntegerField()
-    task_executed = models.BooleanField() # True means Executed, False means Prebuilt
-    outcome = models.IntegerField(choices=TASK_OUTCOME)
-    sstate_checksum = models.CharField(max_length=100)
+    order = models.IntegerField(null=True)
+    task_executed = models.BooleanField(default=False) # True means Executed, False means Prebuilt
+    outcome = models.IntegerField(choices=TASK_OUTCOME, default=4)
+    sstate_checksum = models.CharField(max_length=100, null=True)
     path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
     recipe = models.ForeignKey('Recipe', related_name='build_recipe')
     task_name = models.CharField(max_length=100)
-    source_url = models.FilePathField(max_length=255)
+    source_url = models.FilePathField(max_length=255, null=True)
     log_file = models.FilePathField(max_length=255, blank=True)
-    work_directory = models.FilePathField(max_length=255)
-    script_type = models.IntegerField(choices=TASK_CODING)
-    file_path = models.FilePathField(max_length=255)
-    line_number = models.IntegerField()
-    py_stack_trace = models.TextField()
-    disk_io = models.IntegerField()
-    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2)
-    elapsed_time = models.CharField(max_length=50)
-    errors_no = models.IntegerField()
-    warnings_no = models.IntegerField()
-    error = models.TextField()
-    warning = models.TextField()
-    sstate_result = models.IntegerField(choices=SSTATE_RESULT)
+    work_directory = models.FilePathField(max_length=255, null=True)
+    script_type = models.IntegerField(choices=TASK_CODING, default=0)
+    line_number = models.IntegerField(default=0)
+    py_stack_trace = models.TextField(null=True)
+    disk_io = models.IntegerField(default=0)
+    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, default=0)
+    elapsed_time = models.CharField(max_length=50, default=0)
+    errors_no = models.IntegerField(default=0)
+    warnings_no = models.IntegerField(default=0)
+    error = models.TextField(null=True)
+    warning = models.TextField(null=True)
+    sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=0)
+
+    class Meta:
+        ordering = ('order', 'recipe' ,)
 
 
 class Task_Dependency(models.Model):
@@ -112,17 +115,17 @@ class Filelist(models.Model):
 
 
 class Recipe(models.Model):
-    name = models.CharField(max_length=100)
-    version = models.CharField(max_length=100)
-    layer = models.ForeignKey('Build_Layer', related_name='recipe_build_layer')
-    summary = models.CharField(max_length=100)
-    description = models.CharField(max_length=100)
-    section = models.CharField(max_length=100)
-    license = models.CharField(max_length=200)
-    licensing_info = models.TextField()
-    homepage = models.URLField()
-    bugtracker = models.URLField()
-    author = models.CharField(max_length=100)
+    name = models.CharField(max_length=100, null=True)
+    version = models.CharField(max_length=100, null=True)
+    build_layer = models.ForeignKey('Build_Layer', related_name='recipe_build_layer')
+    summary = models.CharField(max_length=100, null=True)
+    description = models.CharField(max_length=100, null=True)
+    section = models.CharField(max_length=100, null=True)
+    license = models.CharField(max_length=200, null=True)
+    licensing_info = models.TextField(null=True)
+    homepage = models.URLField(null=True)
+    bugtracker = models.URLField(null=True)
+    author = models.CharField(max_length=100, null=True)
     file_path = models.FilePathField(max_length=255)
 
 
-- 
1.8.1.2


