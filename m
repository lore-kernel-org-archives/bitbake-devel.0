Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 54FC06CAF4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902437"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id AEE2F561307; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:51 +0100
Message-Id: <dee4685fd360f04aa6baec19a3cc8bbef53c00bb.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Subject: [PATCH 22/94] bitbake: webhob: mark private methods inside DSI
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:07 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

This patch marks private methods used in the DSI.
It also cleans some old meaningless comments.
---
 bitbake/lib/bb/ui/buildinfohelper.py | 49 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 2da38e2..820e0f8 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -32,7 +32,6 @@ class ORMWrapper(object):
         return machine_info
 
     def create_machine_object(self, machine_information):
-        # This needs to be imported after we have configured the Django settings file
 
         machine = Machine.objects.get_or_create(name=machine_information['name'],
                                                 description=machine_information['description'])
@@ -63,7 +62,6 @@ class ORMWrapper(object):
         return build_info
 
     def create_build_object(self, build_info):
-        # This needs to be imported after we have configured the Django settings file
 
         build = Build.objects.create(uuid=build_info['uuid'],
                                     target=build_info['target'],
@@ -83,7 +81,6 @@ class ORMWrapper(object):
         return build
 
     def update_build_object(self, build_obj, errors, warnings, taskfailures):
-        # This needs to be imported after we have configured the Django settings file
 
         outcome = 0
         if errors or taskfailures:
@@ -98,8 +95,7 @@ class ORMWrapper(object):
 
     def get_task_information(self, event):
 
-
-        recipe = self.get_recipe_object(event)
+        recipe = self._get_recipe_object(event)
 
         task_information = {}
         task_information['build'] = self.transport_utils['build']
@@ -135,7 +131,6 @@ class ORMWrapper(object):
         return task_information
 
     def create_task_object(self, task_information):
-        # This needs to be imported after we have configured the Django settings file
         self.task_order += 1
         identifier = task_information['recipe'].name + task_information['task_name']
 
@@ -170,7 +165,6 @@ class ORMWrapper(object):
         return task_object[0]
 
     def update_task_object(self, task_dictionary, event):
-        # This needs to be imported after we have configured the Django settings file
 
         task = task_dictionary['object']
 
@@ -180,7 +174,7 @@ class ORMWrapper(object):
         if isinstance(event, bb.runqueue.runQueueTaskCompleted):
             task.outcome = 3
 
-        task_build_stats = self.get_task_build_stats(task)
+        task_build_stats = self._get_task_build_stats(task)
         task.cpu_usage = task_build_stats['cpu_usage']
         task.disk_io = task_build_stats['disk_io']
 
@@ -193,13 +187,13 @@ class ORMWrapper(object):
 
         task.save()
 
-    def get_task_build_stats(self, task_object):
-        bs_path = self.get_path_information(task_object)
-        task_build_stats = self.get_build_stats_from_file(bs_path, task_object.task_name)
+    def _get_task_build_stats(self, task_object):
+        bs_path = self._get_path_information(task_object)
+        task_build_stats = self._get_build_stats_from_file(bs_path, task_object.task_name)
 
         return task_build_stats
 
-    def get_path_information(self, task_object):
+    def _get_path_information(self, task_object):
         build_stats_format = "{tmpdir}/buildstats/{target}-{machine}/{buildname}/{package}/"
 
         tmp_dir = self.server.runCommand(["getVariable", "TMPDIR"])[0]
@@ -214,7 +208,7 @@ class ORMWrapper(object):
 
         return build_stats_path
 
-    def get_build_stats_from_file(self, bs_path, task_name):
+    def _get_build_stats_from_file(self, bs_path, task_name):
 
         task_bs_filename = str(bs_path) + str(task_name)
         task_bs = open(task_bs_filename, 'r')
@@ -244,10 +238,9 @@ class ORMWrapper(object):
 
         return task_build_stats
 
-    def get_recipe_object(self, event):
-        # This needs to be imported after we have configured the Django settings file
+    def _get_recipe_object(self, event):
 
-        recipe_information = self.get_recipe_information(event)
+        recipe_information = self._get_recipe_information(event)
 
         recipe_object = Recipe.objects.get_or_create(
                                 name=recipe_information['name'],
@@ -266,9 +259,9 @@ class ORMWrapper(object):
 
         return recipe_object[0]
 
-    def get_recipe_information(self, event):
+    def _get_recipe_information(self, event):
 
-        build_layer_obj = self.get_build_layer_object(event)
+        build_layer_obj = self._get_build_layer_object(event)
 
         recipe_info = {}
         recipe_info['name'] = event.taskpackage
@@ -286,10 +279,9 @@ class ORMWrapper(object):
 
         return recipe_info
 
-    def get_build_layer_object(self, event):
-        # This needs to be imported after we have configured the Django settings file
+    def _get_build_layer_object(self, event):
 
-        build_layer_information = self.get_build_layer_information(event)
+        build_layer_information = self._get_build_layer_information(event)
 
         build_layer_object = Build_Layer.objects.get_or_create(
                                     build = build_layer_information['build'],
@@ -301,9 +293,9 @@ class ORMWrapper(object):
 
         return build_layer_object[0]
 
-    def get_build_layer_information(self, event):
+    def _get_build_layer_information(self, event):
 
-        layer_object = self.get_layer_object(event)
+        layer_object = self._get_layer_object(event)
 
         build_layer_info = {}
         build_layer_info['build'] = self.transport_utils['build']
@@ -314,10 +306,9 @@ class ORMWrapper(object):
 
         return build_layer_info
 
-    def get_layer_object(self, event):
-        # This needs to be imported after we have configured the Django settings file
+    def _get_layer_object(self, event):
 
-        layer_information = self.get_layer_information(event)
+        layer_information = self._get_layer_information(event)
 
         layer_object = Layer.objects.get_or_create(
                                 name=layer_information['name'],
@@ -327,7 +318,7 @@ class ORMWrapper(object):
 
         return layer_object[0]
 
-    def get_layer_information(self, event):
+    def _get_layer_information(self, event):
 
         layer_info = {}
         layer_info['name'] = 'Layer Test Name'
@@ -386,10 +377,10 @@ class BuildInfoHelper(object):
     """
 
     def __init__(self, server):
-        self.configure_django()
+        self._configure_django()
         self.orm_wrapper = ORMWrapper(server)
 
-    def configure_django(self):
+    def _configure_django(self):
         # Add webhob to sys path for importing modules
         sys.path.append(os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'webhob'))
 
-- 
1.8.1.2


