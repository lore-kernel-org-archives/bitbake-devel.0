Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id AD51B6CB2A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814501"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:01 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 804A5560FB6; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:34 +0100
Message-Id: <c6907cbf7d32c45d27f494dafc08ee43ec398f89.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 05/94] bitbake: webhob: updates to Django models
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

Based on recent discussions with the team I have updated the
Django models we had in order to store information more clearly.
The updates include: renaming of some tables, removing of
unnecessary fields, adding supplementary tables to reflect relations
between objects.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/webhob/orm/models.py | 94 ++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 43b4319..6b8e2fa 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -1,22 +1,18 @@
 from django.db import models
 
 
-class Builds(models.Model):
+class Build(models.Model):
 
     BUILD_OUTCOME = (
-        (0, 'Succeded'),
+        (0, 'Succeeded'),
         (1, 'Failed'),
     )
 
     uuid = models.CharField(max_length=100, unique=True)
     target = models.CharField(max_length=100)
-    host_machine = models.CharField(max_length=100)
+    machine = models.ForeignKey('Machine', related_name='build_machine')
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
-    host_system = models.CharField(max_length=100)
-    host_distribution = models.CharField(max_length=100)
-    target_system = models.ForeignKey('Machines', related_name='builds_machines')
-    layers = models.ManyToManyField('Layers')
     started_on = models.DateTimeField()
     completed_on = models.DateTimeField()
     outcome = models.IntegerField(choices=BUILD_OUTCOME)
@@ -29,7 +25,7 @@ class Builds(models.Model):
     bitbake_version = models.CharField(max_length=50)
 
 
-class Tasks(models.Model):
+class Task(models.Model):
 
     SSTATE_RESULT = (
         (0, 'Not Applicable'), # For rest of tasks, but they still need checking.
@@ -47,23 +43,23 @@ class Tasks(models.Model):
         (0, 'Covered'),
         (1, 'Sstate'),
         (2, 'Existing'),
-        (3, 'Succeded'),
+        (3, 'Succeeded'),
         (4, 'Failed'),
     )
 
-    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='tasks_builds')
+    build = models.ForeignKey(Build, related_name='task_build')
     order = models.IntegerField()
     task_executed = models.BooleanField() # True means Executed, False means Prebuilt
     outcome = models.IntegerField(choices=TASK_OUTCOME)
     sstate_checksum = models.CharField(max_length=100)
     path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
-    recipe = models.ForeignKey('Recipes', related_name='builds_recipes')
+    recipe = models.ForeignKey('Recipe', related_name='build_recipe')
     task_name = models.CharField(max_length=100)
-    source_url = models.FilePathField(max_length=200)
-    log_file = models.FilePathField(max_length=200, blank=True)
-    work_directory = models.FilePathField(max_length=200)
+    source_url = models.FilePathField(max_length=255)
+    log_file = models.FilePathField(max_length=255, blank=True)
+    work_directory = models.FilePathField(max_length=255)
     script_type = models.IntegerField(choices=TASK_CODING)
-    file_path = models.FilePathField(max_length=200)
+    file_path = models.FilePathField(max_length=255)
     line_number = models.IntegerField()
     py_stack_trace = models.TextField()
     disk_io = models.DecimalField(max_digits=20, decimal_places=10)
@@ -74,54 +70,52 @@ class Tasks(models.Model):
     error = models.TextField()
     warning = models.TextField()
     sstate_result = models.IntegerField(choices=SSTATE_RESULT)
-    diffsigs = models.CharField(max_length=500)
 
 
-class Task_Dependencies(models.Model):
-    task = models.ForeignKey(Tasks, related_name='task_dependencies_task')
-    depends_on = models.ForeignKey(Tasks, related_name='task_dependencies_depends')
+class Task_Dependency(models.Model):
+    task = models.ForeignKey(Task, related_name='task_dependencies_task')
+    depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
 
 
-class Targets(models.Model):
-    uuid = models.ForeignKey(Builds, to_field='uuid',  related_name='targets_builds')
+class Target(models.Model):
+    build = models.ForeignKey(Build, related_name='target_build')
     is_image = models.BooleanField()
 
 
-class Artifacts(models.Model):
-    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='artifacts_builds')
-    target = models.ForeignKey(Targets, related_name='artifacts_targets')
+class Artifact(models.Model):
+    build = models.ForeignKey(Build, related_name='artifact_build')
+    target = models.ForeignKey(Target, related_name='artifact_target')
     file_name = models.CharField(max_length=100)
     file_size = models.IntegerField()
 
 
-class Packages_In_Images(models.Model):
-    package = models.ForeignKey('Packages', related_name='packages_in_images_package')
-    target = models.ForeignKey(Targets, related_name='packages_in_images_target')
+class Package_In_Image(models.Model):
+    package = models.ForeignKey('Package', related_name='package_in_image_package')
+    target = models.ForeignKey(Target, related_name='package_in_image_target')
 
 
-class Packages(models.Model):
-    package_id = models.IntegerField()
-    recipe = models.ForeignKey('Recipes', related_name='packages_recipes')
+class Package(models.Model):
+    recipe = models.ForeignKey('Recipe', related_name='package_recipe')
     name = models.CharField(max_length=100)
     version = models.CharField(max_length=100)
     size = models.IntegerField()
 
 
-class Package_Dependencies(models.Model):
-    package = models.ForeignKey(Packages, related_name='package_dependencies_package')
-    depends_on = models.ForeignKey(Packages, related_name='package_dependencies_depends')
+class Package_Dependency(models.Model):
+    package = models.ForeignKey(Package, related_name='package_dependencies_package')
+    depends_on = models.ForeignKey(Package, related_name='package_dependencies_depends')
 
 
 class Filelist(models.Model):
-    package = models.ForeignKey(Packages, related_name='filelist_packages')
-    complete_file_path = models.FilePathField(max_length=200, blank=True)
+    package = models.ForeignKey(Package, related_name='filelist_package')
+    complete_file_path = models.FilePathField(max_length=255, blank=True)
     file_size = models.IntegerField()
 
 
-class Recipes(models.Model):
+class Recipe(models.Model):
     name = models.CharField(max_length=100)
     version = models.CharField(max_length=100)
-    layer = models.ForeignKey('Layers', related_name='recipes_layers')
+    layer = models.ForeignKey('Build_Layer', related_name='recipe_build_layer')
     summary = models.CharField(max_length=100)
     description = models.CharField(max_length=100)
     section = models.CharField(max_length=100)
@@ -130,33 +124,39 @@ class Recipes(models.Model):
     homepage = models.URLField()
     bugtracker = models.URLField()
     author = models.CharField(max_length=100)
-    file_path = models.FilePathField(max_length=200)
+    file_path = models.FilePathField(max_length=255)
 
 
-class Recipe_Dependencies(models.Model):
-    recipe = models.ForeignKey(Recipes, related_name='recipe_dependencies_recipe')
-    depends_on = models.ForeignKey(Recipes, related_name='recipe_dependencies_depends')
+class Recipe_Dependency(models.Model):
+    recipe = models.ForeignKey(Recipe, related_name='recipe_dependencies_recipe')
+    depends_on = models.ForeignKey(Recipe, related_name='recipe_dependencies_depends')
 
 
-class Layers(models.Model):
+class Layer(models.Model):
     name = models.CharField(max_length=100)
+    local_path = models.FilePathField(max_length=255)
+    layer_index_url = models.URLField()
+
+
+class Build_Layer(models.Model):
+    build = models.ForeignKey(Build, related_name='build_layer_build')
+    layer = models.ForeignKey(Layer, related_name='build_layer_layer')
     branch = models.CharField(max_length=50)
     commit = models.CharField(max_length=100)
     priority = models.IntegerField()
-    link_to_oe_core = models.URLField()
 
 
-class Variables(models.Model):
-    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='variables_builds')
+class Variable(models.Model):
+    build = models.ForeignKey(Build, related_name='variable_build')
     variable_name = models.CharField(max_length=100)
     variable_value = models.TextField()
-    file = models.FilePathField(max_length=200)
+    file = models.FilePathField(max_length=255)
     changed = models.BooleanField()
     human_readable_name = models.CharField(max_length=200)
     description = models.TextField()
 
 
-class Machines(models.Model):
+class Machine(models.Model):
     name = models.CharField(max_length=100)
     description = models.TextField()
 
-- 
1.8.1.2


