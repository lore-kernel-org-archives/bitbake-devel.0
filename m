Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 32EBF6CABA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:03 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511818"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:03 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 829A056100F; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:35 +0100
Message-Id: <81c2ea58343caeb8e0c7c90edd1a6066ad90f0b7.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 06/94] bitbake: webhob: make DSI store build information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:03 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch will enable DSI to store build information defined in
the Django models. This will be done for each executed build and it
will use a helper file to save this information.

Moved code from DSI interface to the helper file in to classes,
one which wraps around Django model interface operations, and one that
fills in information from the event system into the model data.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 127 ++++++++++++++++++++++++
 bitbake/lib/bb/ui/dsi.py             | 180 ++++-------------------------------
 2 files changed, 148 insertions(+), 159 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/buildinfohelper.py

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
new file mode 100644
index 0000000..c77248c
--- /dev/null
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -0,0 +1,127 @@
+import datetime
+import sys
+import uuid
+
+
+class ORMWrapper(object):
+    """ This class creates the dictionaries needed to store information in the database
+        following the format defined by the Django models. It is also used to save this
+        information in the database.
+    """
+
+    def __init__(self):
+        self.uuid = None
+
+    def get_machine_information(self, server):
+        machine_info = {}
+
+        machine_info['name'] = server.runCommand(["getVariable", "MACHINE"])[0]
+        machine_info['description'] = 'Not Available'
+
+        return machine_info
+
+    def create_machine_object(self, machine_information):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Machine
+
+        machine = Machine.objects.get_or_create(name=machine_information['name'],
+                                                description=machine_information['description'])
+
+        return machine[0]
+
+    def get_build_information(self, server, machine_obj):
+        build_info = {}
+
+        # Generate an identifier for each new build
+        self.uuid = str(uuid.uuid4())
+
+        build_info['uuid'] = self.uuid
+        build_info['target'] = 'Not Available'
+        build_info['machine'] = machine_obj
+        build_info['distro'] = server.runCommand(["getVariable", "DISTRO"])[0]
+        build_info['distro_version'] = server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
+        build_info['started_on'] = datetime.datetime.now()
+        build_info['completed_on'] = datetime.datetime.now()
+        build_info['outcome'] = 0
+        build_info['number_of_errors'] = 0
+        build_info['number_of_warnings'] = 0
+        build_info['cpu_usage'] = 0
+        build_info['disk_io'] = 0
+        build_info['cooker_log_path'] = server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
+        build_info['build_name'] = server.runCommand(["getVariable", "BUILDNAME"])[0]
+        build_info['bitbake_version'] = server.runCommand(["getVariable", "BB_VERSION"])[0]
+
+        return build_info
+
+    def create_build_object(self, build_info):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Build
+
+        build = Build.objects.create(uuid=build_info['uuid'],
+                                    target=build_info['target'],
+                                    machine=build_info['machine'],
+                                    distro=build_info['distro'],
+                                    distro_version=build_info['distro_version'],
+                                    started_on=build_info['started_on'],
+                                    completed_on=build_info['completed_on'],
+                                    outcome=build_info['outcome'],
+                                    errors_no=build_info['number_of_errors'],
+                                    warnings_no=build_info['number_of_warnings'],
+                                    cpu_usage=build_info['cpu_usage'],
+                                    disk_io=build_info['disk_io'],
+                                    cooker_log_path=build_info['cooker_log_path'],
+                                    build_name=build_info['build_name'],
+                                    bitbake_version=build_info['bitbake_version'])
+
+        return build
+
+    def update_build_object(self, build_obj, errors, warnings):
+        # This needs to be imported after we have configured the Django settings file
+        from webhob.orm.models import Build
+
+        outcome = 0
+        if errors or warnings:
+            outcome = 1
+
+        build = Build.objects.get(uuid=build_obj.uuid)
+        build.completed_on = datetime.datetime.now()
+        build.errors_no = errors
+        build.warnings_no = warnings
+        build.outcome = outcome
+        build.save()
+
+        return build_obj
+
+
+class BuildInfoHelper(object):
+    """ This class gathers the build information from the server and sends it
+        towards the ORM wrapper for storing in the database
+    """
+
+    def __init__(self):
+        self.configure_django()
+        self.task_order = 0
+        self.tasks_information = {}
+        self.uuid = None
+        self.transport_utils = {}
+        self.orm_wrapper = ORMWrapper()
+
+    def configure_django(self):
+        import webhob.whbmain.settings as whb_django_settings
+        from django.core.management import setup_environ
+        setup_environ(whb_django_settings)
+        # Add webhob to sys path for importing modules
+        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
+
+    def store_started_build(self, event, server):
+
+        machine_information = self.orm_wrapper.get_machine_information(server)
+        machine_obj = self.orm_wrapper.create_machine_object(machine_information)
+
+        build_information = self.orm_wrapper.get_build_information(server, machine_obj)
+        build_obj = self.orm_wrapper.create_build_object(build_information)
+        self.transport_utils['build'] = build_obj
+
+    def update_build_information(self, event, errors, warnings):
+        build_obj = self.orm_wrapper.update_build_object(self.transport_utils['build'], errors, warnings)
+        del self.transport_utils['build']
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index f832806..d7b038c 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -17,157 +17,25 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import division
+from bb.ui import uihelper
+from bb.ui.buildinfohelper import BuildInfoHelper
 
-import os
-import sys
-import xmlrpclib
+import bb.msg
+import copy
+import fcntl
 import logging
+import os
 import progressbar
 import signal
-import bb.msg
-import time
-import fcntl
 import struct
-import copy
-import datetime
+import sys
+import time
+import xmlrpclib
 
-from bb.ui import uihelper
 
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
-class WebHOBHelper(object):
-    
-    def __init__(self):
-        self.configure_django()
-        self.task_order = 0
-        self.tasks_information = {}
-
-    def configure_django(self):
-        import webhob.whbmain.settings as whb_django_settings
-        from django.core.management import setup_environ
-        setup_environ(whb_django_settings)
-        # Add webhob to sys path for importing modules
-        sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
-    
-    def store_build(self, uuid):
-        # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Builds, Machines, Layers
-        machine_obj = Machines.objects.create(
-                                name='Test Machine',
-                                description='This is our great test machine'
-                                )
-        machine_obj.save()
-
-        layer_obj = Layers.objects.create(
-                                name='Test Layer',
-                                branch='master_test',
-                                commit='2148u323nsau83smdmbnca3312f',
-                                priority=2,
-                                link_to_oe_core='http://test.oecore.com'
-                                )
-        layer_obj.save()
-
-        build_obj = Builds.objects.create(
-                                uuid=uuid,
-                                target='test target',
-                                host_machine='Host machine',
-                                distro='1.234',
-                                distro_version='v2',
-                                host_system='Test hosting system',
-                                host_distribution='Test host distrib',
-                                target_system=machine_obj,
-                                started_on=datetime.datetime.now(),
-                                completed_on=datetime.datetime.now(),
-                                outcome=3,
-                                errors_no=0,
-                                warnings_no=0,
-                                cpu_usage=54,
-                                disk_io=23.3232,
-                                cooker_log_path='/home/test/cooker_test',
-                                build_name='tester_build',
-                                bitbake_version='1.0.5')
-        build_obj.layers.add(layer_obj)
-        build_obj.save()
-
-        return build_obj, layer_obj
-
-    def store_started_task(self, event, build_object):
-        self.task_order += 1
-        identifier = event._package + event._task
-        self.tasks_information[identifier] = {
-                'uuid': build_object,
-                'task_executed': True,
-                'order': self.task_order,
-                'recipe': event._package,
-                'task_name': event._task,
-                'start_time': time.time(),
-                }
-
-    def write_stored_tasks(self, event, build_object, layer_object):
-        identifier = event._package + event._task
-
-        # fix this
-        if event.getDisplayName().lower() == 'succeded':
-            outcome = 0
-        else:
-            outcome = 1
-
-        self.tasks_information[identifier].update({
-                'outcome': outcome,
-                'end_time': time.time(),
-                })
-
-        task = self.tasks_information[identifier]
-
-        # This needs to be imported after we have configured the Django settings file
-        from webhob.orm.models import Tasks, Recipes
-
-        recipe_obj = Recipes.objects.create(
-                                    name=task['recipe'],
-                                    version='1.0',
-                                    layer=layer_object,
-                                    summary='Short summary',
-                                    description='Longer description',
-                                    section='24',
-                                    license='license title',
-                                    licensing_info='longer license information',
-                                    homepage='http://homepage.com',
-                                    bugtracker='2456',
-                                    author='Mr.Test',
-                                    file_path='home/test/testproject/',
-                                    )
-
-        # Store finished task
-        task_obj = Tasks.objects.create(uuid=task['uuid'],
-                                        order=task['order'],
-                                        outcome=task['outcome'],
-                                        recipe=recipe_obj,
-                                        task_name=task['task_name'],
-                                        elapsed_time=task['end_time'] - task['start_time'],
-                                        # The next lines are just for testing reasons
-                                        sstate_checksum = '2134123sdscsdf232342tgfdv',
-                                        task_executed=True,
-                                        path_to_sstate_obj='/home/calin',
-                                        source_url='/',
-                                        log_file='/',
-                                        work_directory='/',
-                                        script_type=0,
-                                        file_path='/',
-                                        line_number=55,
-                                        py_stack_trace='Testing traceback',
-                                        disk_io = 23.55633,
-                                        cpu_usage=43,
-                                        errors_no=0,
-                                        warnings_no=0,
-                                        error='None',
-                                        warning='None',
-                                        sstate_result=0,
-                                        diffsigs="Testing diffsigs")
-        task_obj.save()
-        # Clean memory
-        del self.tasks_information[identifier]
-
 
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval):
@@ -350,12 +218,7 @@ class TerminalFilter(object):
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
 def main(server, eventHandler, params, tf = TerminalFilter):
-    print "This is running in DSI mode"
-
-    # Generate an unique ID for this build
-    # TODO: for multiple build commands this might not work as expected
-    import uuid
-    uuid = sessionid = str(uuid.uuid4())
+    print "DSI - Data Store Interface"
 
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
@@ -422,8 +285,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errors = 0
     warnings = 0
     taskfailures = []
-    wbhbhelper = WebHOBHelper()
-    build_object, layer_object = wbhbhelper.store_build(uuid)
+    buildinfohelper = BuildInfoHelper()
 
     termfilter = tf(main, helper, console, format)
 
@@ -443,11 +305,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 if not main.shutdown:
                     main.shutdown = 1
 
-            if isinstance(event, bb.build.TaskStarted):
-                wbhbhelper.store_started_task(event, build_object)
-
-            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
-                wbhbhelper.write_stored_tasks(event, build_object, layer_object)
+            if isinstance(event, bb.event.BuildStarted):
+                buildinfohelper.store_started_build(event, server)
 
             if isinstance(event, bb.event.LogExecTTY):
                 if log_exec_tty:
@@ -470,7 +329,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 elif event.levelno == format.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
-                # but do show them if the user has changed the default log level to 
+                # but do show them if the user has changed the default log level to
                 # include verbose/debug messages
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
                     continue
@@ -577,20 +436,24 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 logger.error("Task %s (%s) failed with exit code '%s'",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
- 
+
             if isinstance(event, bb.runqueue.sceneQueueTaskFailed):
                 logger.warn("Setscene task %s (%s) failed with exit code '%s' - real task will be run instead",
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
+            if isinstance(event, (bb.command.CommandFailed, bb.command.CommandExit, bb.command.CommandCompleted, bb.cooker.CookerExit)):
+                buildinfohelper.update_build_information(event, errors, warnings)
+                main.shutdown = 2
+
             if isinstance(event, bb.event.ConfigParsed):
                 # timestamp should be added for this
                 continue
-            
+
             if isinstance(event, bb.event.RecipeParsed):
                 # timestamp should be added for this
                 continue
-                
+
             if isinstance(event, bb.event.OperationStarted):
                 # timestamp should be added for this
                 continue
@@ -664,4 +527,3 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     termfilter.finish()
 
     return return_value
-
-- 
1.8.1.2


