Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 4E39B6CACE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Sep 2013 09:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="406511832"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2013 09:53:05 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 91DA85610CE; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:41 +0100
Message-Id: <2f5a58f038f0be063f836c0ebca720fc143703dc.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 12/94] bitbake: webhob: gather buildstats for each executed task
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:04 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch reads the buildstats file created for each
executed task and retrieves cpu usage and disk IO information
which it will store in the database.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 89 ++++++++++++++++++++++++++++++------
 bitbake/lib/bb/ui/dsi.py             |  4 +-
 bitbake/lib/webhob/orm/models.py     |  4 +-
 3 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index e1ebd41..6f3b5c2 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -9,17 +9,20 @@ class ORMWrapper(object):
         information in the database.
     """
 
-    def __init__(self):
+    def __init__(self, server):
         self.uuid = None
         self.task_order = 0
         self.transport_utils = {}
+        self.server = server
 
-    def get_machine_information(self, server):
+    def get_machine_information(self):
         machine_info = {}
 
-        machine_info['name'] = server.runCommand(["getVariable", "MACHINE"])[0]
+        machine_info['name'] = self.server.runCommand(["getVariable", "MACHINE"])[0]
         machine_info['description'] = 'Not Available'
 
+        self.transport_utils['machine'] = machine_info['name']
+
         return machine_info
 
     def create_machine_object(self, machine_information):
@@ -31,7 +34,7 @@ class ORMWrapper(object):
 
         return machine[0]
 
-    def get_build_information(self, server, machine_obj):
+    def get_build_information(self, machine_obj):
         build_info = {}
 
         # Generate an identifier for each new build
@@ -40,17 +43,17 @@ class ORMWrapper(object):
         build_info['uuid'] = self.uuid
         build_info['target'] = 'Not Available'
         build_info['machine'] = machine_obj
-        build_info['distro'] = server.runCommand(["getVariable", "DISTRO"])[0]
-        build_info['distro_version'] = server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
+        build_info['distro'] = self.server.runCommand(["getVariable", "DISTRO"])[0]
+        build_info['distro_version'] = self.server.runCommand(["getVariable", "DISTRO_VERSION"])[0]
         build_info['started_on'] = datetime.datetime.now()
         build_info['completed_on'] = datetime.datetime.now()
         build_info['outcome'] = 0
         build_info['number_of_errors'] = 0
         build_info['number_of_warnings'] = 0
-        build_info['image_fstypes'] = server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
-        build_info['cooker_log_path'] = server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
-        build_info['build_name'] = server.runCommand(["getVariable", "BUILDNAME"])[0]
-        build_info['bitbake_version'] = server.runCommand(["getVariable", "BB_VERSION"])[0]
+        build_info['image_fstypes'] = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"])[0]
+        build_info['cooker_log_path'] = self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
+        build_info['build_name'] = self.server.runCommand(["getVariable", "BUILDNAME"])[0]
+        build_info['bitbake_version'] = self.server.runCommand(["getVariable", "BB_VERSION"])[0]
 
         return build_info
 
@@ -175,6 +178,10 @@ class ORMWrapper(object):
         outcome_info = self.get_outcome_of_task(event)
         task.outcome = outcome_info['task_outcome']
 
+        task_build_stats = self.get_task_build_stats(task_object)
+        task.cpu_usage = task_build_stats['cpu_usage']
+        task.disk_io = task_build_stats['disk_io']
+
         if outcome_info.get('error', ''):
             task.error = outcome_info['error']
 
@@ -202,6 +209,57 @@ class ORMWrapper(object):
 
         return outcome_info
 
+    def get_task_build_stats(self, task_object):
+        bs_path = self.get_path_information(task_object)
+        task_build_stats = self.get_build_stats_from_file(bs_path, task_object.task_name)
+
+        return task_build_stats
+
+    def get_path_information(self, task_object):
+        build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
+
+        tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
+        target = self.transport_utils['target']
+        machine = self.transport_utils['build'].machine.name
+        buildname = self.transport_utils['build'].build_name
+        package = task_object.recipe.name
+
+        build_stats_path = build_stats_format.format(tmpdir=tmp_dir, target=target,
+                                                     machine=machine, buildname=buildname,
+                                                     package=package)
+
+        return build_stats_path
+
+    def get_build_stats_from_file(self, bs_path, task_name):
+
+        task_bs_filename = str(bs_path) + str(task_name)
+        task_bs = open(task_bs_filename, 'r')
+
+        cpu_usage = 0
+        disk_io = 0
+        startio = ''
+        endio = ''
+
+        for line in task_bs.readlines():
+            if line.startswith('CPU usage: '):
+                cpu_usage = line[11:]
+            elif line.startswith('EndTimeIO: '):
+                endio = line[11:]
+            elif line.startswith('StartTimeIO: '):
+                startio = line[13:]
+
+        task_bs.close()
+
+        if startio and endio:
+            disk_io = int(endio.strip('\n ')) - int(startio.strip('\n '))
+
+        if cpu_usage:
+            cpu_usage = float(cpu_usage.strip('% \n'))
+
+        task_build_stats = {'cpu_usage': cpu_usage, 'disk_io': disk_io}
+
+        return task_build_stats
+
     def get_recipe_object(self, event):
         # This needs to be imported after we have configured the Django settings file
         from webhob.orm.models import Recipe
@@ -303,9 +361,9 @@ class BuildInfoHelper(object):
         towards the ORM wrapper for storing in the database
     """
 
-    def __init__(self):
+    def __init__(self, server):
         self.configure_django()
-        self.orm_wrapper = ORMWrapper()
+        self.orm_wrapper = ORMWrapper(server)
 
     def configure_django(self):
         import webhob.whbmain.settings as whb_django_settings
@@ -314,14 +372,15 @@ class BuildInfoHelper(object):
         # Add webhob to sys path for importing modules
         sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
 
-    def store_started_build(self, event, server):
+    def store_started_build(self, event):
 
-        machine_information = self.orm_wrapper.get_machine_information(server)
+        machine_information = self.orm_wrapper.get_machine_information()
         machine_obj = self.orm_wrapper.create_machine_object(machine_information)
 
-        build_information = self.orm_wrapper.get_build_information(server, machine_obj)
+        build_information = self.orm_wrapper.get_build_information(machine_obj)
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.orm_wrapper.transport_utils['build'] = build_obj
+        self.orm_wrapper.transport_utils['target'] = event.getPkgs()[0]
 
     def update_build_information(self, event, errors, warnings, taskfailures):
         self.orm_wrapper.update_build_object(self.orm_wrapper.transport_utils['build'], errors, warnings, taskfailures)
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index d5fe733..fb3595b 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -285,7 +285,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     errors = 0
     warnings = 0
     taskfailures = []
-    buildinfohelper = BuildInfoHelper()
+    buildinfohelper = BuildInfoHelper(server)
 
     termfilter = tf(main, helper, console, format)
 
@@ -306,7 +306,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                     main.shutdown = 1
 
             if isinstance(event, bb.event.BuildStarted):
-                buildinfohelper.store_started_build(event, server)
+                buildinfohelper.store_started_build(event)
 
             if isinstance(event, bb.build.TaskStarted):
                 buildinfohelper.store_started_task(event)
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index f0492db..76b7c1d 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -61,8 +61,8 @@ class Task(models.Model):
     file_path = models.FilePathField(max_length=255)
     line_number = models.IntegerField()
     py_stack_trace = models.TextField()
-    disk_io = models.DecimalField(max_digits=20, decimal_places=10)
-    cpu_usage = models.IntegerField()
+    disk_io = models.IntegerField()
+    cpu_usage = models.DecimalField(max_digits=6, decimal_places=2)
     elapsed_time = models.CharField(max_length=50)
     errors_no = models.IntegerField()
     warnings_no = models.IntegerField()
-- 
1.8.1.2


