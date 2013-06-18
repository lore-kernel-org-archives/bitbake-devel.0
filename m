Return-Path: <calinx.l.dragomir@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id AC002608A8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jun 2013 11:49:01 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2013 04:49:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,888,1363158000"; d="scan'208";a="355360914"
Received: from calin-desktop.rb.intel.com ([10.237.105.64])
	by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2013 04:49:01 -0700
From: Calin Dragomir <calinx.l.dragomir@intel.com>
To: webhob@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jun 2013 14:51:06 +0300
Message-Id: <1371556267-19628-2-git-send-email-calinx.l.dragomir@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371556267-19628-1-git-send-email-calinx.l.dragomir@intel.com>
References: <1371556267-19628-1-git-send-email-calinx.l.dragomir@intel.com>
Subject: [PATCH v2 2/3] webhob: create Django models for webhob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Jun 2013 11:49:02 -0000

Patch adds the models we need in order to store all the information
we need about the builds in the database using the Django ORM.
---
 lib/webhob/orm/__init__.py     |   0
 lib/webhob/orm/models.py       | 162 +++++++++++++++++++++++++++++++++++++++++
 lib/webhob/orm/tests.py        |  16 ++++
 lib/webhob/orm/views.py        |   1 +
 lib/webhob/whbmain/settings.py |   1 +
 5 files changed, 180 insertions(+)
 create mode 100644 lib/webhob/orm/__init__.py
 create mode 100644 lib/webhob/orm/models.py
 create mode 100644 lib/webhob/orm/tests.py
 create mode 100644 lib/webhob/orm/views.py

diff --git a/lib/webhob/orm/__init__.py b/lib/webhob/orm/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/webhob/orm/models.py b/lib/webhob/orm/models.py
new file mode 100644
index 0000000..7e0c9b3
--- /dev/null
+++ b/lib/webhob/orm/models.py
@@ -0,0 +1,162 @@
+from django.db import models
+
+
+class Builds(models.Model):
+
+    BUILD_OUTCOME = (
+        (0, 'Succeded'),
+        (1, 'Failed'),
+    )
+
+    uuid = models.CharField(max_length=100, unique=True)
+    target = models.CharField(max_length=100)
+    host_machine = models.CharField(max_length=100)
+    distro = models.CharField(max_length=100)
+    distro_version = models.CharField(max_length=100)
+    host_system = models.CharField(max_length=100)
+    host_distribution = models.CharField(max_length=100)
+    target_system = models.ForeignKey('Machines', related_name='builds_machines')
+    layers = models.ManyToManyField('Layers')
+    started_on = models.DateTimeField()
+    completed_on = models.DateTimeField()
+    outcome = models.IntegerField(choices=BUILD_OUTCOME)
+    errors_no = models.IntegerField()
+    warnings_no = models.IntegerField()
+    cpu_usage = models.IntegerField()
+    disk_io = models.DecimalField(max_digits=20, decimal_places=10)
+    cooker_log_path = models.CharField(max_length=500)
+    build_name = models.CharField(max_length=100)
+    bitbake_version = models.CharField(max_length=50)
+
+
+class Tasks(models.Model):
+
+    SSTATE_RESULT = (
+        (0, 'Not Applicable'), # For rest of tasks, but they still need checking.
+        (1, 'Unavailable'), # it is a miss
+        (2, 'Failed'), # there was a pkg, but the script failed
+        (3, 'Restored'), # succesfully restored
+    )
+
+    TASK_CODING = (
+        (0, 'Python'),
+        (1, 'Shell'),
+    )
+
+    TASK_OUTCOME = (
+        (0, 'Covered'),
+        (1, 'Sstate'),
+        (2, 'Existing'),
+        (3, 'Succeded'),
+        (4, 'Failed'),
+    )
+
+    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='tasks_builds')
+    order = models.IntegerField()
+    task_executed = models.BooleanField() # True means Executed, False means Prebuilt
+    outcome = models.IntegerField(choices=TASK_OUTCOME)
+    sstate_checksum = models.CharField(max_length=100)
+    path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
+    recipe = models.ForeignKey('Recipes', related_name='builds_recipes')
+    task_name = models.CharField(max_length=100)
+    source_url = models.FilePathField(max_length=200)
+    log_file = models.FilePathField(max_length=200, blank=True)
+    work_directory = models.FilePathField(max_length=200)
+    script_type = models.IntegerField(choices=TASK_CODING)
+    file_path = models.FilePathField(max_length=200)
+    line_number = models.IntegerField()
+    py_stack_trace = models.TextField()
+    disk_io = models.DecimalField(max_digits=20, decimal_places=10)
+    cpu_usage = models.IntegerField()
+    elapsed_time = models.CharField(max_length=50)
+    errors_no = models.IntegerField()
+    warnings_no = models.IntegerField()
+    error = models.TextField()
+    warning = models.TextField()
+    sstate_result = models.IntegerField(choices=SSTATE_RESULT)
+    diffsigs = models.CharField(max_length=500)
+
+
+class Task_Dependencies(models.Model):
+    task_id = models.ForeignKey(Tasks, related_name='task_dependencies_task')
+    depends_on = models.ForeignKey(Tasks, related_name='task_dependencies_depends')
+
+
+class Targets(models.Model):
+    uuid = models.ForeignKey(Builds, to_field='uuid',  related_name='targets_builds')
+    is_image = models.BooleanField()
+
+
+class Artifacts(models.Model):
+    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='artifacts_builds')
+    target_id = models.ForeignKey(Targets, related_name='artifacts_targets')
+    file_name = models.CharField(max_length=100)
+    file_size = models.IntegerField()
+
+
+class Packages_In_Images(models.Model):
+    package_id = models.ForeignKey('Packages', related_name='packages_in_images_package')
+    target_id = models.ForeignKey(Targets, related_name='packages_in_images_target')
+
+
+class Packages(models.Model):
+    package_id = models.IntegerField()
+    recipe = models.ForeignKey('Recipes', related_name='packages_recipes')
+    name = models.CharField(max_length=100)
+    version = models.CharField(max_length=100)
+    size = models.IntegerField()
+
+
+class Package_Dependencies(models.Model):
+    package_id = models.ForeignKey(Packages, related_name='package_dependencies_package')
+    depends_on = models.ForeignKey(Packages, related_name='package_dependencies_depends')
+
+
+class Filelist(models.Model):
+    package_id = models.ForeignKey(Packages, related_name='filelist_packages')
+    complete_file_path = models.FilePathField(max_length=200, blank=True)
+    file_size = models.IntegerField()
+
+
+class Recipes(models.Model):
+    name = models.CharField(max_length=100)
+    version = models.CharField(max_length=100)
+    layer = models.ForeignKey('Layers', related_name='recipes_layers')
+    summary = models.CharField(max_length=100)
+    description = models.CharField(max_length=100)
+    section = models.CharField(max_length=100)
+    license = models.CharField(max_length=200)
+    licensing_info = models.TextField()
+    homepage = models.CharField(max_length=100)
+    bugtracker = models.CharField(max_length=100)
+    author = models.CharField(max_length=100)
+    file_path = models.FilePathField(max_length=200)
+
+
+class Recipe_Dependencies(models.Model):
+    recipe_id = models.ForeignKey(Recipes, related_name='recipe_dependencies_recipe')
+    depends_on = models.ForeignKey(Recipes, related_name='recipe_dependencies_depends')
+
+
+class Layers(models.Model):
+    name = models.CharField(max_length=100)
+    branch = models.CharField(max_length=50)
+    commit = models.CharField(max_length=100)
+    priority = models.IntegerField()
+    link_to_oe_core = models.URLField()
+
+
+class Variables(models.Model):
+    uuid = models.ForeignKey(Builds, to_field='uuid', related_name='variables_builds')
+    variable_name = models.CharField(max_length=100)
+    variable_value = models.TextField()
+    file = models.FilePathField(max_length=200)
+    changed = models.BooleanField()
+    human_readable_name = models.CharField(max_length=200)
+    description = models.TextField()
+
+
+class Machines(models.Model):
+    name = models.CharField(max_length=100)
+    description = models.TextField()
+
diff --git a/lib/webhob/orm/tests.py b/lib/webhob/orm/tests.py
new file mode 100644
index 0000000..501deb7
--- /dev/null
+++ b/lib/webhob/orm/tests.py
@@ -0,0 +1,16 @@
+"""
+This file demonstrates writing tests using the unittest module. These will pass
+when you run "manage.py test".
+
+Replace this with more appropriate tests for your application.
+"""
+
+from django.test import TestCase
+
+
+class SimpleTest(TestCase):
+    def test_basic_addition(self):
+        """
+        Tests that 1 + 1 always equals 2.
+        """
+        self.assertEqual(1 + 1, 2)
diff --git a/lib/webhob/orm/views.py b/lib/webhob/orm/views.py
new file mode 100644
index 0000000..60f00ef
--- /dev/null
+++ b/lib/webhob/orm/views.py
@@ -0,0 +1 @@
+# Create your views here.
diff --git a/lib/webhob/whbmain/settings.py b/lib/webhob/whbmain/settings.py
index 67aaf69..71bba4f 100644
--- a/lib/webhob/whbmain/settings.py
+++ b/lib/webhob/whbmain/settings.py
@@ -123,6 +123,7 @@ INSTALLED_APPS = (
     # 'django.contrib.admin',
     # Uncomment the next line to enable admin documentation:
     # 'django.contrib.admindocs',
+    'orm',
 )
 
 # A sample logging configuration. The only tangible logging
-- 
1.8.1.2


