Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web12.30980.1585196653909264331
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2020 21:24:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 02Q4Nqpr021732
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2020 21:24:02 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.92) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 25 Mar 2020 21:23:41 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] toaster: migrate to Django-2.2
Date: Wed, 25 Mar 2020 21:24:55 -0700
Message-ID: <94a40d083368abd51ab66f725a8b81dad63b7e18.1585196549.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1585196549.git.David.Reyna@windriver.com>
References: <cover.1585196549.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.92]
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster migration to Django-2.2. Django-1.x has been deprecated.

[YOCTO #13207]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcollector/views.py                  |   2 +-
 lib/toaster/bldcontrol/migrations/0001_initial.py  |  18 ++--
 lib/toaster/bldcontrol/models.py                   |  18 ++--
 lib/toaster/orm/migrations/0001_initial.py         | 100 ++++++++++-----------
 .../orm/migrations/0002_customimagerecipe.py       |   6 +-
 .../orm/migrations/0003_customimagepackage.py      |   2 +-
 lib/toaster/orm/migrations/0004_provides.py        |   4 +-
 .../migrations/0008_refactor_artifact_models.py    |   4 +-
 .../0012_use_release_instead_of_up_branch.py       |   2 +-
 lib/toaster/orm/migrations/0017_distro_clone.py    |   2 +-
 lib/toaster/orm/migrations/0019_django_2_2.py      |  23 +++++
 lib/toaster/orm/models.py                          |  98 ++++++++++----------
 lib/toaster/tests/browser/test_all_builds_page.py  |   2 +-
 .../tests/browser/test_all_projects_page.py        |   2 +-
 .../tests/browser/test_builddashboard_page.py      |   2 +-
 .../browser/test_builddashboard_page_artifacts.py  |   2 +-
 .../browser/test_builddashboard_page_recipes.py    |   2 +-
 .../browser/test_builddashboard_page_tasks.py      |   2 +-
 lib/toaster/tests/browser/test_js_unit_tests.py    |   2 +-
 lib/toaster/tests/browser/test_landing_page.py     |   2 +-
 .../tests/browser/test_layerdetails_page.py        |   2 +-
 .../browser/test_most_recent_builds_states.py      |   2 +-
 .../tests/browser/test_new_custom_image_page.py    |   2 +-
 lib/toaster/tests/browser/test_new_project_page.py |   2 +-
 .../tests/browser/test_project_builds_page.py      |   2 +-
 .../tests/browser/test_project_config_page.py      |   5 +-
 lib/toaster/tests/browser/test_project_page.py     |   2 +-
 lib/toaster/tests/browser/test_sample.py           |   2 +-
 lib/toaster/tests/browser/test_task_page.py        |   2 +-
 lib/toaster/tests/browser/test_toastertable_ui.py  |   2 +-
 lib/toaster/tests/views/test_views.py              |   2 +-
 lib/toaster/toastergui/api.py                      |   2 +-
 .../toastergui/templatetags/project_url_tag.py     |   2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   4 +-
 lib/toaster/toastergui/typeaheads.py               |   2 +-
 lib/toaster/toastergui/views.py                    |  16 ++--
 lib/toaster/toastergui/widgets.py                  |   2 +-
 .../toastermain/management/commands/buildimport.py |   2 +-
 lib/toaster/toastermain/settings.py                |  17 ++--
 lib/toaster/toastermain/urls.py                    |   4 +-
 40 files changed, 197 insertions(+), 174 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0019_django_2_2.py

diff --git a/lib/toaster/bldcollector/views.py b/lib/toaster/bldcollector/views.py
index 6d9227c..04cd8b3 100644
--- a/lib/toaster/bldcollector/views.py
+++ b/lib/toaster/bldcollector/views.py
@@ -6,7 +6,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.http import HttpResponseBadRequest, HttpResponse
 import os
 import tempfile
diff --git a/lib/toaster/bldcontrol/migrations/0001_initial.py b/lib/toaster/bldcontrol/migrations/0001_initial.py
index 67db378..7ee19f4 100644
--- a/lib/toaster/bldcontrol/migrations/0001_initial.py
+++ b/lib/toaster/bldcontrol/migrations/0001_initial.py
@@ -37,7 +37,7 @@ class Migration(migrations.Migration):
                 ('giturl', models.CharField(max_length=254)),
                 ('commit', models.CharField(max_length=254)),
                 ('dirpath', models.CharField(max_length=254)),
-                ('layer_version', models.ForeignKey(to='orm.Layer_Version', null=True)),
+                ('layer_version', models.ForeignKey(to='orm.Layer_Version', null=True, on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -80,34 +80,34 @@ class Migration(migrations.Migration):
                 ('state', models.IntegerField(default=0, choices=[(0, b'created'), (1, b'queued'), (2, b'in progress'), (3, b'completed'), (4, b'failed'), (5, b'deleted'), (6, b'archive')])),
                 ('created', models.DateTimeField(auto_now_add=True)),
                 ('updated', models.DateTimeField(auto_now=True)),
-                ('build', models.OneToOneField(null=True, to='orm.Build')),
-                ('environment', models.ForeignKey(to='bldcontrol.BuildEnvironment', null=True)),
-                ('project', models.ForeignKey(to='orm.Project')),
+                ('build', models.OneToOneField(null=True, to='orm.Build', on_delete=models.CASCADE)),
+                ('environment', models.ForeignKey(to='bldcontrol.BuildEnvironment', null=True, on_delete=models.CASCADE)),
+                ('project', models.ForeignKey(to='orm.Project', on_delete=models.CASCADE)),
             ],
         ),
         migrations.AddField(
             model_name='brvariable',
             name='req',
-            field=models.ForeignKey(to='bldcontrol.BuildRequest'),
+            field=models.ForeignKey(to='bldcontrol.BuildRequest', on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='brtarget',
             name='req',
-            field=models.ForeignKey(to='bldcontrol.BuildRequest'),
+            field=models.ForeignKey(to='bldcontrol.BuildRequest', on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='brlayer',
             name='req',
-            field=models.ForeignKey(to='bldcontrol.BuildRequest'),
+            field=models.ForeignKey(to='bldcontrol.BuildRequest', on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='brerror',
             name='req',
-            field=models.ForeignKey(to='bldcontrol.BuildRequest'),
+            field=models.ForeignKey(to='bldcontrol.BuildRequest', on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='brbitbake',
             name='req',
-            field=models.OneToOneField(to='bldcontrol.BuildRequest'),
+            field=models.OneToOneField(to='bldcontrol.BuildRequest', on_delete=models.CASCADE),
         ),
     ]
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 0d30fd9..c2f302d 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -85,9 +85,9 @@ class BuildRequest(models.Model):
 
     search_allowed_fields = ("brtarget__target", "build__project__name")
 
-    project     = models.ForeignKey(Project)
-    build       = models.OneToOneField(Build, null = True)     # TODO: toasterui should set this when Build is created
-    environment = models.ForeignKey(BuildEnvironment, null = True)
+    project     = models.ForeignKey(Project, on_delete=models.CASCADE)
+    build       = models.OneToOneField(Build, on_delete=models.CASCADE, null = True)     # TODO: toasterui should set this when Build is created
+    environment = models.ForeignKey(BuildEnvironment, on_delete=models.CASCADE, null = True)
     state       = models.IntegerField(choices = REQUEST_STATE, default = REQ_CREATED)
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
@@ -131,32 +131,32 @@ class BuildRequest(models.Model):
 
 
 class BRLayer(models.Model):
-    req = models.ForeignKey(BuildRequest)
+    req = models.ForeignKey(BuildRequest, on_delete=models.CASCADE)
     name = models.CharField(max_length=100)
     giturl = models.CharField(max_length=254, null=True)
     local_source_dir = models.CharField(max_length=254, null=True)
     commit = models.CharField(max_length=254, null=True)
     dirpath = models.CharField(max_length=254, null=True)
-    layer_version = models.ForeignKey(Layer_Version, null=True)
+    layer_version = models.ForeignKey(Layer_Version, on_delete=models.CASCADE, null=True)
 
 class BRBitbake(models.Model):
-    req         = models.OneToOneField(BuildRequest)    # only one bitbake for a request
+    req         = models.OneToOneField(BuildRequest, on_delete=models.CASCADE)    # only one bitbake for a request
     giturl      = models.CharField(max_length =254)
     commit      = models.CharField(max_length = 254)
     dirpath     = models.CharField(max_length = 254)
 
 class BRVariable(models.Model):
-    req         = models.ForeignKey(BuildRequest)
+    req         = models.ForeignKey(BuildRequest, on_delete=models.CASCADE)
     name        = models.CharField(max_length=100)
     value       = models.TextField(blank = True)
 
 class BRTarget(models.Model):
-    req         = models.ForeignKey(BuildRequest)
+    req         = models.ForeignKey(BuildRequest, on_delete=models.CASCADE)
     target      = models.CharField(max_length=100)
     task        = models.CharField(max_length=100, null=True)
 
 class BRError(models.Model):
-    req         = models.ForeignKey(BuildRequest)
+    req         = models.ForeignKey(BuildRequest, on_delete=models.CASCADE)
     errtype     = models.CharField(max_length=100)
     errmsg      = models.TextField()
     traceback   = models.TextField()
diff --git a/lib/toaster/orm/migrations/0001_initial.py b/lib/toaster/orm/migrations/0001_initial.py
index 760462f..a8ac23b 100644
--- a/lib/toaster/orm/migrations/0001_initial.py
+++ b/lib/toaster/orm/migrations/0001_initial.py
@@ -54,7 +54,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('file_name', models.FilePathField()),
                 ('file_size', models.IntegerField()),
-                ('build', models.ForeignKey(to='orm.Build')),
+                ('build', models.ForeignKey(to='orm.Build', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -64,7 +64,7 @@ class Migration(migrations.Migration):
                 ('area', models.IntegerField(choices=[(0, b'variable')])),
                 ('key', models.CharField(max_length=100)),
                 ('text', models.TextField()),
-                ('build', models.ForeignKey(related_name='helptext_build', to='orm.Build')),
+                ('build', models.ForeignKey(related_name='helptext_build', to='orm.Build', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -94,8 +94,8 @@ class Migration(migrations.Migration):
                 ('dirpath', models.CharField(default=None, max_length=255, null=True)),
                 ('priority', models.IntegerField(default=0)),
                 ('local_path', models.FilePathField(default=b'/', max_length=1024)),
-                ('build', models.ForeignKey(related_name='layer_version_build', default=None, to='orm.Build', null=True)),
-                ('layer', models.ForeignKey(related_name='layer_version_layer', to='orm.Layer')),
+                ('build', models.ForeignKey(related_name='layer_version_build', default=None, to='orm.Build', null=True, on_delete=models.CASCADE)),
+                ('layer', models.ForeignKey(related_name='layer_version_layer', to='orm.Layer', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -112,9 +112,9 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('up_id', models.IntegerField(default=None, null=True)),
-                ('depends_on', models.ForeignKey(related_name='dependees', to='orm.Layer_Version')),
-                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True)),
-                ('layer_version', models.ForeignKey(related_name='dependencies', to='orm.Layer_Version')),
+                ('depends_on', models.ForeignKey(related_name='dependees', to='orm.Layer_Version', on_delete=models.CASCADE)),
+                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True, on_delete=models.CASCADE)),
+                ('layer_version', models.ForeignKey(related_name='dependencies', to='orm.Layer_Version', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -125,7 +125,7 @@ class Migration(migrations.Migration):
                 ('message', models.TextField(null=True, blank=True)),
                 ('pathname', models.FilePathField(max_length=255, blank=True)),
                 ('lineno', models.IntegerField(null=True)),
-                ('build', models.ForeignKey(to='orm.Build')),
+                ('build', models.ForeignKey(to='orm.Build', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -136,8 +136,8 @@ class Migration(migrations.Migration):
                 ('up_date', models.DateTimeField(default=None, null=True)),
                 ('name', models.CharField(max_length=255)),
                 ('description', models.CharField(max_length=255)),
-                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True)),
-                ('layer_version', models.ForeignKey(to='orm.Layer_Version')),
+                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True, on_delete=models.CASCADE)),
+                ('layer_version', models.ForeignKey(to='orm.Layer_Version', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -154,7 +154,7 @@ class Migration(migrations.Migration):
                 ('installed_size', models.IntegerField(default=0)),
                 ('section', models.CharField(max_length=80, blank=True)),
                 ('license', models.CharField(max_length=80, blank=True)),
-                ('build', models.ForeignKey(to='orm.Build', null=True)),
+                ('build', models.ForeignKey(to='orm.Build', null=True, on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -162,8 +162,8 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('dep_type', models.IntegerField(choices=[(0, b'depends'), (1, b'depends'), (3, b'recommends'), (2, b'recommends'), (4, b'suggests'), (5, b'provides'), (6, b'replaces'), (7, b'conflicts')])),
-                ('depends_on', models.ForeignKey(related_name='package_dependencies_target', to='orm.Package')),
-                ('package', models.ForeignKey(related_name='package_dependencies_source', to='orm.Package')),
+                ('depends_on', models.ForeignKey(related_name='package_dependencies_target', to='orm.Package', on_delete=models.CASCADE)),
+                ('package', models.ForeignKey(related_name='package_dependencies_source', to='orm.Package', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -172,7 +172,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('path', models.FilePathField(max_length=255, blank=True)),
                 ('size', models.IntegerField()),
-                ('package', models.ForeignKey(related_name='buildfilelist_package', to='orm.Package')),
+                ('package', models.ForeignKey(related_name='buildfilelist_package', to='orm.Package', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -185,7 +185,7 @@ class Migration(migrations.Migration):
                 ('updated', models.DateTimeField(auto_now=True)),
                 ('user_id', models.IntegerField(null=True)),
                 ('is_default', models.BooleanField(default=False)),
-                ('bitbake_version', models.ForeignKey(to='orm.BitbakeVersion', null=True)),
+                ('bitbake_version', models.ForeignKey(to='orm.BitbakeVersion', null=True, on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -193,8 +193,8 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('optional', models.BooleanField(default=True)),
-                ('layercommit', models.ForeignKey(to='orm.Layer_Version', null=True)),
-                ('project', models.ForeignKey(to='orm.Project')),
+                ('layercommit', models.ForeignKey(to='orm.Layer_Version', null=True, on_delete=models.CASCADE)),
+                ('project', models.ForeignKey(to='orm.Project', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -203,7 +203,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('target', models.CharField(max_length=100)),
                 ('task', models.CharField(max_length=100, null=True)),
-                ('project', models.ForeignKey(to='orm.Project')),
+                ('project', models.ForeignKey(to='orm.Project', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -212,7 +212,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('name', models.CharField(max_length=100)),
                 ('value', models.TextField(blank=True)),
-                ('project', models.ForeignKey(to='orm.Project')),
+                ('project', models.ForeignKey(to='orm.Project', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -232,8 +232,8 @@ class Migration(migrations.Migration):
                 ('file_path', models.FilePathField(max_length=255)),
                 ('pathflags', models.CharField(max_length=200, blank=True)),
                 ('is_image', models.BooleanField(default=False)),
-                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True)),
-                ('layer_version', models.ForeignKey(related_name='recipe_layer_version', to='orm.Layer_Version')),
+                ('layer_source', models.ForeignKey(default=None, to='orm.LayerSource', null=True, on_delete=models.CASCADE)),
+                ('layer_version', models.ForeignKey(related_name='recipe_layer_version', to='orm.Layer_Version', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -241,8 +241,8 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('dep_type', models.IntegerField(choices=[(0, b'depends'), (1, b'rdepends')])),
-                ('depends_on', models.ForeignKey(related_name='r_dependencies_depends', to='orm.Recipe')),
-                ('recipe', models.ForeignKey(related_name='r_dependencies_recipe', to='orm.Recipe')),
+                ('depends_on', models.ForeignKey(related_name='r_dependencies_depends', to='orm.Recipe', on_delete=models.CASCADE)),
+                ('recipe', models.ForeignKey(related_name='r_dependencies_recipe', to='orm.Recipe', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -253,7 +253,7 @@ class Migration(migrations.Migration):
                 ('description', models.CharField(max_length=255)),
                 ('branch_name', models.CharField(default=b'', max_length=50)),
                 ('helptext', models.TextField(null=True)),
-                ('bitbake_version', models.ForeignKey(to='orm.BitbakeVersion')),
+                ('bitbake_version', models.ForeignKey(to='orm.BitbakeVersion', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -261,7 +261,7 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('layer_name', models.CharField(default=b'', max_length=100)),
-                ('release', models.ForeignKey(to='orm.Release')),
+                ('release', models.ForeignKey(to='orm.Release', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -269,8 +269,8 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('priority', models.IntegerField(default=0)),
-                ('layer_source', models.ForeignKey(to='orm.LayerSource')),
-                ('release', models.ForeignKey(to='orm.Release')),
+                ('layer_source', models.ForeignKey(to='orm.LayerSource', on_delete=models.CASCADE)),
+                ('release', models.ForeignKey(to='orm.Release', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -282,7 +282,7 @@ class Migration(migrations.Migration):
                 ('is_image', models.BooleanField(default=False)),
                 ('image_size', models.IntegerField(default=0)),
                 ('license_manifest_path', models.CharField(max_length=500, null=True)),
-                ('build', models.ForeignKey(to='orm.Build')),
+                ('build', models.ForeignKey(to='orm.Build', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -295,9 +295,9 @@ class Migration(migrations.Migration):
                 ('permission', models.CharField(max_length=16)),
                 ('owner', models.CharField(max_length=128)),
                 ('group', models.CharField(max_length=128)),
-                ('directory', models.ForeignKey(related_name='directory_set', to='orm.Target_File', null=True)),
-                ('sym_target', models.ForeignKey(related_name='symlink_set', to='orm.Target_File', null=True)),
-                ('target', models.ForeignKey(to='orm.Target')),
+                ('directory', models.ForeignKey(related_name='directory_set', to='orm.Target_File', null=True, on_delete=models.CASCADE)),
+                ('sym_target', models.ForeignKey(related_name='symlink_set', to='orm.Target_File', null=True, on_delete=models.CASCADE)),
+                ('target', models.ForeignKey(to='orm.Target', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -306,15 +306,15 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('file_name', models.FilePathField(max_length=254)),
                 ('file_size', models.IntegerField()),
-                ('target', models.ForeignKey(to='orm.Target')),
+                ('target', models.ForeignKey(to='orm.Target', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
             name='Target_Installed_Package',
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
-                ('package', models.ForeignKey(related_name='buildtargetlist_package', to='orm.Package')),
-                ('target', models.ForeignKey(to='orm.Target')),
+                ('package', models.ForeignKey(related_name='buildtargetlist_package', to='orm.Package', on_delete=models.CASCADE)),
+                ('target', models.ForeignKey(to='orm.Target', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -337,8 +337,8 @@ class Migration(migrations.Migration):
                 ('sstate_result', models.IntegerField(default=0, choices=[(0, b'Not Applicable'), (1, b'File not in cache'), (2, b'Failed'), (3, b'Succeeded')])),
                 ('message', models.CharField(max_length=240)),
                 ('logfile', models.FilePathField(max_length=255, blank=True)),
-                ('build', models.ForeignKey(related_name='task_build', to='orm.Build')),
-                ('recipe', models.ForeignKey(related_name='tasks', to='orm.Recipe')),
+                ('build', models.ForeignKey(related_name='task_build', to='orm.Build', on_delete=models.CASCADE)),
+                ('recipe', models.ForeignKey(related_name='tasks', to='orm.Recipe', on_delete=models.CASCADE)),
             ],
             options={
                 'ordering': ('order', 'recipe'),
@@ -348,8 +348,8 @@ class Migration(migrations.Migration):
             name='Task_Dependency',
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
-                ('depends_on', models.ForeignKey(related_name='task_dependencies_depends', to='orm.Task')),
-                ('task', models.ForeignKey(related_name='task_dependencies_task', to='orm.Task')),
+                ('depends_on', models.ForeignKey(related_name='task_dependencies_depends', to='orm.Task', on_delete=models.CASCADE)),
+                ('task', models.ForeignKey(related_name='task_dependencies_task', to='orm.Task', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -370,7 +370,7 @@ class Migration(migrations.Migration):
                 ('changed', models.BooleanField(default=False)),
                 ('human_readable_name', models.CharField(max_length=200)),
                 ('description', models.TextField(blank=True)),
-                ('build', models.ForeignKey(related_name='variable_build', to='orm.Build')),
+                ('build', models.ForeignKey(related_name='variable_build', to='orm.Build', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -381,28 +381,28 @@ class Migration(migrations.Migration):
                 ('file_name', models.FilePathField(max_length=255)),
                 ('line_number', models.IntegerField(null=True)),
                 ('operation', models.CharField(max_length=64)),
-                ('variable', models.ForeignKey(related_name='vhistory', to='orm.Variable')),
+                ('variable', models.ForeignKey(related_name='vhistory', to='orm.Variable', on_delete=models.CASCADE)),
             ],
         ),
         migrations.AddField(
             model_name='project',
             name='release',
-            field=models.ForeignKey(to='orm.Release', null=True),
+            field=models.ForeignKey(to='orm.Release', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='package_dependency',
             name='target',
-            field=models.ForeignKey(to='orm.Target', null=True),
+            field=models.ForeignKey(to='orm.Target', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='package',
             name='recipe',
-            field=models.ForeignKey(to='orm.Recipe', null=True),
+            field=models.ForeignKey(to='orm.Recipe', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='logmessage',
             name='task',
-            field=models.ForeignKey(blank=True, to='orm.Task', null=True),
+            field=models.ForeignKey(blank=True, to='orm.Task', null=True, on_delete=models.CASCADE),
         ),
         migrations.AlterUniqueTogether(
             name='layersource',
@@ -411,32 +411,32 @@ class Migration(migrations.Migration):
         migrations.AddField(
             model_name='layer_version',
             name='layer_source',
-            field=models.ForeignKey(default=None, to='orm.LayerSource', null=True),
+            field=models.ForeignKey(default=None, to='orm.LayerSource', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='layer_version',
             name='project',
-            field=models.ForeignKey(default=None, to='orm.Project', null=True),
+            field=models.ForeignKey(default=None, to='orm.Project', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='layer_version',
             name='up_branch',
-            field=models.ForeignKey(default=None, to='orm.Branch', null=True),
+            field=models.ForeignKey(default=None, to='orm.Branch', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='layer',
             name='layer_source',
-            field=models.ForeignKey(default=None, to='orm.LayerSource', null=True),
+            field=models.ForeignKey(default=None, to='orm.LayerSource', null=True, on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='build',
             name='project',
-            field=models.ForeignKey(to='orm.Project'),
+            field=models.ForeignKey(to='orm.Project', on_delete=models.CASCADE),
         ),
         migrations.AddField(
             model_name='branch',
             name='layer_source',
-            field=models.ForeignKey(default=True, to='orm.LayerSource', null=True),
+            field=models.ForeignKey(default=True, to='orm.LayerSource', null=True, on_delete=models.CASCADE),
         ),
         migrations.CreateModel(
             name='ImportedLayerSource',
diff --git a/lib/toaster/orm/migrations/0002_customimagerecipe.py b/lib/toaster/orm/migrations/0002_customimagerecipe.py
index 9cec82e..09c2bff 100644
--- a/lib/toaster/orm/migrations/0002_customimagerecipe.py
+++ b/lib/toaster/orm/migrations/0002_customimagerecipe.py
@@ -14,10 +14,10 @@ class Migration(migrations.Migration):
         migrations.CreateModel(
             name='CustomImageRecipe',
             fields=[
-                ('recipe_ptr', models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Recipe')),
+                ('recipe_ptr', models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Recipe', on_delete=models.CASCADE)),
                 ('last_updated', models.DateTimeField(default=None, null=True)),
-                ('base_recipe', models.ForeignKey(related_name='based_on_recipe', to='orm.Recipe')),
-                ('project', models.ForeignKey(to='orm.Project')),
+                ('base_recipe', models.ForeignKey(related_name='based_on_recipe', to='orm.Recipe', on_delete=models.CASCADE)),
+                ('project', models.ForeignKey(to='orm.Project', on_delete=models.CASCADE)),
             ],
             bases=('orm.recipe',),
         ),
diff --git a/lib/toaster/orm/migrations/0003_customimagepackage.py b/lib/toaster/orm/migrations/0003_customimagepackage.py
index b027f66..8cb81d7 100644
--- a/lib/toaster/orm/migrations/0003_customimagepackage.py
+++ b/lib/toaster/orm/migrations/0003_customimagepackage.py
@@ -14,7 +14,7 @@ class Migration(migrations.Migration):
         migrations.CreateModel(
             name='CustomImagePackage',
             fields=[
-                ('package_ptr', models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Package')),
+                ('package_ptr', models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Package', on_delete=models.CASCADE)),
                 ('recipe_appends', models.ManyToManyField(related_name='appends_set', to='orm.CustomImageRecipe')),
                 ('recipe_excludes', models.ManyToManyField(related_name='excludes_set', to='orm.CustomImageRecipe')),
                 ('recipe_includes', models.ManyToManyField(related_name='includes_set', to='orm.CustomImageRecipe')),
diff --git a/lib/toaster/orm/migrations/0004_provides.py b/lib/toaster/orm/migrations/0004_provides.py
index dfde2d1..8449604 100644
--- a/lib/toaster/orm/migrations/0004_provides.py
+++ b/lib/toaster/orm/migrations/0004_provides.py
@@ -16,12 +16,12 @@ class Migration(migrations.Migration):
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                 ('name', models.CharField(max_length=100)),
-                ('recipe', models.ForeignKey(to='orm.Recipe')),
+                ('recipe', models.ForeignKey(to='orm.Recipe', on_delete=models.CASCADE)),
             ],
         ),
         migrations.AddField(
             model_name='recipe_dependency',
             name='via',
-            field=models.ForeignKey(null=True, default=None, to='orm.Provides'),
+            field=models.ForeignKey(null=True, default=None, to='orm.Provides', on_delete=models.CASCADE),
         ),
     ]
diff --git a/lib/toaster/orm/migrations/0008_refactor_artifact_models.py b/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
index 3367582..41a547a 100644
--- a/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
+++ b/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
@@ -17,7 +17,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
                 ('file_name', models.FilePathField()),
                 ('file_size', models.IntegerField()),
-                ('target', models.ForeignKey(to='orm.Target')),
+                ('target', models.ForeignKey(to='orm.Target', on_delete=models.CASCADE)),
             ],
         ),
         migrations.CreateModel(
@@ -26,7 +26,7 @@ class Migration(migrations.Migration):
                 ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
                 ('file_name', models.FilePathField()),
                 ('file_size', models.IntegerField()),
-                ('target', models.ForeignKey(to='orm.Target')),
+                ('target', models.ForeignKey(to='orm.Target', on_delete=models.CASCADE)),
             ],
         ),
         migrations.RemoveField(
diff --git a/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py b/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py
index 0e6bb83..4b96bf0 100644
--- a/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py
+++ b/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py
@@ -46,7 +46,7 @@ class Migration(migrations.Migration):
         migrations.AddField(
             model_name='layer_version',
             name='release',
-            field=models.ForeignKey(to='orm.Release', default=None, null=True),
+            field=models.ForeignKey(to='orm.Release', default=None, null=True, on_delete=models.CASCADE),
         ),
         migrations.RunPython(branch_to_release,
                              reverse_code=migrations.RunPython.noop),
diff --git a/lib/toaster/orm/migrations/0017_distro_clone.py b/lib/toaster/orm/migrations/0017_distro_clone.py
index d3c5901..731c0de 100644
--- a/lib/toaster/orm/migrations/0017_distro_clone.py
+++ b/lib/toaster/orm/migrations/0017_distro_clone.py
@@ -18,7 +18,7 @@ class Migration(migrations.Migration):
                 ('up_date', models.DateTimeField(default=None, null=True)),
                 ('name', models.CharField(max_length=255)),
                 ('description', models.CharField(max_length=255)),
-                ('layer_version', models.ForeignKey(to='orm.Layer_Version')),
+                ('layer_version', models.ForeignKey(to='orm.Layer_Version', on_delete=models.CASCADE)),
             ],
         ),
     ]
diff --git a/lib/toaster/orm/migrations/0019_django_2_2.py b/lib/toaster/orm/migrations/0019_django_2_2.py
new file mode 100644
index 0000000..666aef1
--- /dev/null
+++ b/lib/toaster/orm/migrations/0019_django_2_2.py
@@ -0,0 +1,23 @@
+# Generated by Django 2.2.7 on 2019-11-19 03:38
+
+from django.db import migrations, models
+import django.db.models.deletion
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0018_project_specific'),
+    ]
+
+    operations = [
+        migrations.RemoveField(
+            model_name='distro',
+            name='up_id',
+        ),
+        migrations.AlterField(
+            model_name='build',
+            name='recipes_parsed',
+            field=models.IntegerField(default=1),
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index caf0697..7f7e922 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -13,7 +13,7 @@ from django.db.models import F, Q, Sum, Count
 from django.utils import timezone
 from django.utils.encoding import force_bytes
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 
 from django.core import validators
 from django.conf import settings
@@ -178,8 +178,8 @@ class Project(models.Model):
                              'release__branch_name']
     name = models.CharField(max_length=100)
     short_description = models.CharField(max_length=50, blank=True)
-    bitbake_version = models.ForeignKey('BitbakeVersion', null=True)
-    release = models.ForeignKey("Release", null=True)
+    bitbake_version = models.ForeignKey('BitbakeVersion', on_delete=models.CASCADE, null=True)
+    release = models.ForeignKey("Release", on_delete=models.CASCADE, null=True)
     created = models.DateTimeField(auto_now_add=True)
     updated = models.DateTimeField(auto_now=True)
     # This is a horrible hack; since Toaster has no "User" model available when
@@ -469,7 +469,7 @@ class Build(models.Model):
 
     search_allowed_fields = ['machine', 'cooker_log_path', "target__target", "target__target_image_file__file_name"]
 
-    project = models.ForeignKey(Project)            # must have a project
+    project = models.ForeignKey(Project, on_delete=models.CASCADE)            # must have a project
     machine = models.CharField(max_length=100)
     distro = models.CharField(max_length=100)
     distro_version = models.CharField(max_length=100)
@@ -777,13 +777,13 @@ class Build(models.Model):
         return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))
 
 class ProjectTarget(models.Model):
-    project = models.ForeignKey(Project)
+    project = models.ForeignKey(Project, on_delete=models.CASCADE)
     target = models.CharField(max_length=100)
     task = models.CharField(max_length=100, null=True)
 
 class Target(models.Model):
     search_allowed_fields = ['target', 'file_name']
-    build = models.ForeignKey(Build)
+    build = models.ForeignKey(Build, on_delete=models.CASCADE)
     target = models.CharField(max_length=100)
     task = models.CharField(max_length=100, null=True)
     is_image = models.BooleanField(default = False)
@@ -944,7 +944,7 @@ class Target(models.Model):
 
 # kernel artifacts for a target: bzImage and modules*
 class TargetKernelFile(models.Model):
-    target = models.ForeignKey(Target)
+    target = models.ForeignKey(Target, on_delete=models.CASCADE)
     file_name = models.FilePathField()
     file_size = models.IntegerField()
 
@@ -954,7 +954,7 @@ class TargetKernelFile(models.Model):
 
 # SDK artifacts for a target: sh and manifest files
 class TargetSDKFile(models.Model):
-    target = models.ForeignKey(Target)
+    target = models.ForeignKey(Target, on_delete=models.CASCADE)
     file_name = models.FilePathField()
     file_size = models.IntegerField()
 
@@ -973,7 +973,7 @@ class Target_Image_File(models.Model):
         'ubifs', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
     }
 
-    target = models.ForeignKey(Target)
+    target = models.ForeignKey(Target, on_delete=models.CASCADE)
     file_name = models.FilePathField(max_length=254)
     file_size = models.IntegerField()
 
@@ -1007,15 +1007,15 @@ class Target_File(models.Model):
         ( ITYPE_BLOCK ,'block'),
         )
 
-    target = models.ForeignKey(Target)
+    target = models.ForeignKey(Target, on_delete=models.CASCADE)
     path = models.FilePathField()
     size = models.IntegerField()
     inodetype = models.IntegerField(choices = ITYPES)
     permission = models.CharField(max_length=16)
     owner = models.CharField(max_length=128)
     group = models.CharField(max_length=128)
-    directory = models.ForeignKey('Target_File', related_name="directory_set", null=True)
-    sym_target = models.ForeignKey('Target_File', related_name="symlink_set", null=True)
+    directory = models.ForeignKey('Target_File', on_delete=models.CASCADE, related_name="directory_set", null=True)
+    sym_target = models.ForeignKey('Target_File', on_delete=models.CASCADE, related_name="symlink_set", null=True)
 
 
 class Task(models.Model):
@@ -1102,13 +1102,13 @@ class Task(models.Model):
     def get_description(self):
         return self._helptext
 
-    build = models.ForeignKey(Build, related_name='task_build')
+    build = models.ForeignKey(Build, on_delete=models.CASCADE, related_name='task_build')
     order = models.IntegerField(null=True)
     task_executed = models.BooleanField(default=False) # True means Executed, False means Not/Executed
     outcome = models.IntegerField(choices=TASK_OUTCOME, default=OUTCOME_NA)
     sstate_checksum = models.CharField(max_length=100, blank=True)
     path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
-    recipe = models.ForeignKey('Recipe', related_name='tasks')
+    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE, related_name='tasks')
     task_name = models.CharField(max_length=100)
     source_url = models.FilePathField(max_length=255, blank=True)
     work_directory = models.FilePathField(max_length=255, blank=True)
@@ -1147,13 +1147,13 @@ class Task(models.Model):
 
 
 class Task_Dependency(models.Model):
-    task = models.ForeignKey(Task, related_name='task_dependencies_task')
-    depends_on = models.ForeignKey(Task, related_name='task_dependencies_depends')
+    task = models.ForeignKey(Task, on_delete=models.CASCADE, related_name='task_dependencies_task')
+    depends_on = models.ForeignKey(Task, on_delete=models.CASCADE, related_name='task_dependencies_depends')
 
 class Package(models.Model):
     search_allowed_fields = ['name', 'version', 'revision', 'recipe__name', 'recipe__version', 'recipe__license', 'recipe__layer_version__layer__name', 'recipe__layer_version__branch', 'recipe__layer_version__commit', 'recipe__layer_version__local_path', 'installed_name']
-    build = models.ForeignKey('Build', null=True)
-    recipe = models.ForeignKey('Recipe', null=True)
+    build = models.ForeignKey('Build', on_delete=models.CASCADE, null=True)
+    recipe = models.ForeignKey('Recipe', on_delete=models.CASCADE, null=True)
     name = models.CharField(max_length=100)
     installed_name = models.CharField(max_length=100, default='')
     version = models.CharField(max_length=100, blank=True)
@@ -1289,19 +1289,19 @@ class Package_Dependency(models.Model):
         TYPE_RCONFLICTS :   ("conflicts", "%s conflicts with %s, which will not be installed if this package is not first removed"),
     }
 
-    package = models.ForeignKey(Package, related_name='package_dependencies_source')
-    depends_on = models.ForeignKey(Package, related_name='package_dependencies_target')   # soft dependency
+    package = models.ForeignKey(Package, on_delete=models.CASCADE, related_name='package_dependencies_source')
+    depends_on = models.ForeignKey(Package, on_delete=models.CASCADE, related_name='package_dependencies_target')   # soft dependency
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
-    target = models.ForeignKey(Target, null=True)
+    target = models.ForeignKey(Target, on_delete=models.CASCADE, null=True)
     objects = Package_DependencyManager()
 
 class Target_Installed_Package(models.Model):
-    target = models.ForeignKey(Target)
-    package = models.ForeignKey(Package, related_name='buildtargetlist_package')
+    target = models.ForeignKey(Target, on_delete=models.CASCADE)
+    package = models.ForeignKey(Package, on_delete=models.CASCADE, related_name='buildtargetlist_package')
 
 
 class Package_File(models.Model):
-    package = models.ForeignKey(Package, related_name='buildfilelist_package')
+    package = models.ForeignKey(Package, on_delete=models.CASCADE, related_name='buildfilelist_package')
     path = models.FilePathField(max_length=255, blank=True)
     size = models.IntegerField()
 
@@ -1318,7 +1318,7 @@ class Recipe(models.Model):
 
     name = models.CharField(max_length=100, blank=True)
     version = models.CharField(max_length=100, blank=True)
-    layer_version = models.ForeignKey('Layer_Version',
+    layer_version = models.ForeignKey('Layer_Version', on_delete=models.CASCADE,
                                       related_name='recipe_layer_version')
     summary = models.TextField(blank=True)
     description = models.TextField(blank=True)
@@ -1356,7 +1356,7 @@ class Recipe_DependencyManager(models.Manager):
 
 class Provides(models.Model):
     name = models.CharField(max_length=100)
-    recipe = models.ForeignKey(Recipe)
+    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE)
 
 class Recipe_Dependency(models.Model):
     TYPE_DEPENDS = 0
@@ -1366,9 +1366,9 @@ class Recipe_Dependency(models.Model):
         (TYPE_DEPENDS, "depends"),
         (TYPE_RDEPENDS, "rdepends"),
     )
-    recipe = models.ForeignKey(Recipe, related_name='r_dependencies_recipe')
-    depends_on = models.ForeignKey(Recipe, related_name='r_dependencies_depends')
-    via = models.ForeignKey(Provides, null=True, default=None)
+    recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE, related_name='r_dependencies_recipe')
+    depends_on = models.ForeignKey(Recipe, on_delete=models.CASCADE, related_name='r_dependencies_depends')
+    via = models.ForeignKey(Provides, on_delete=models.CASCADE, null=True, default=None)
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
     objects = Recipe_DependencyManager()
 
@@ -1377,7 +1377,7 @@ class Machine(models.Model):
     search_allowed_fields = ["name", "description", "layer_version__layer__name"]
     up_date = models.DateTimeField(null = True, default = None)
 
-    layer_version = models.ForeignKey('Layer_Version')
+    layer_version = models.ForeignKey('Layer_Version', on_delete=models.CASCADE)
     name = models.CharField(max_length=255)
     description = models.CharField(max_length=255)
 
@@ -1408,7 +1408,7 @@ class Release(models.Model):
     """ A release is a project template, used to pre-populate Project settings with a configuration set """
     name = models.CharField(max_length=32, unique = True)
     description = models.CharField(max_length=255)
-    bitbake_version = models.ForeignKey(BitbakeVersion)
+    bitbake_version = models.ForeignKey(BitbakeVersion, on_delete=models.CASCADE)
     branch_name = models.CharField(max_length=50, default = "")
     helptext = models.TextField(null=True)
 
@@ -1419,7 +1419,7 @@ class Release(models.Model):
         return self.name
 
 class ReleaseDefaultLayer(models.Model):
-    release = models.ForeignKey(Release)
+    release = models.ForeignKey(Release, on_delete=models.CASCADE)
     layer_name = models.CharField(max_length=100, default="")
 
 
@@ -1474,10 +1474,10 @@ class Layer_Version(models.Model):
                              "layer__description", "layer__vcs_url",
                              "dirpath", "release__name", "commit", "branch"]
 
-    build = models.ForeignKey(Build, related_name='layer_version_build',
+    build = models.ForeignKey(Build, on_delete=models.CASCADE, related_name='layer_version_build',
                               default=None, null=True)
 
-    layer = models.ForeignKey(Layer, related_name='layer_version_layer')
+    layer = models.ForeignKey(Layer, on_delete=models.CASCADE, related_name='layer_version_layer')
 
     layer_source = models.IntegerField(choices=LayerSource.SOURCE_TYPE,
                                        default=0)
@@ -1485,7 +1485,7 @@ class Layer_Version(models.Model):
     up_date = models.DateTimeField(null=True, default=timezone.now)
 
     # To which metadata release does this layer version belong to
-    release = models.ForeignKey(Release, null=True, default=None)
+    release = models.ForeignKey(Release, on_delete=models.CASCADE, null=True, default=None)
 
     branch = models.CharField(max_length=80)
     commit = models.CharField(max_length=100)
@@ -1499,7 +1499,7 @@ class Layer_Version(models.Model):
     local_path = models.FilePathField(max_length=1024, default="/")
 
     # Set if this layer is restricted to a particular project
-    project = models.ForeignKey('Project', null=True, default=None)
+    project = models.ForeignKey('Project', on_delete=models.CASCADE, null=True, default=None)
 
     # code lifted, with adaptations, from the layerindex-web application
     # https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
@@ -1608,14 +1608,14 @@ class Layer_Version(models.Model):
 
 class LayerVersionDependency(models.Model):
 
-    layer_version = models.ForeignKey(Layer_Version,
+    layer_version = models.ForeignKey(Layer_Version, on_delete=models.CASCADE,
                                       related_name="dependencies")
-    depends_on = models.ForeignKey(Layer_Version,
+    depends_on = models.ForeignKey(Layer_Version, on_delete=models.CASCADE,
                                    related_name="dependees")
 
 class ProjectLayer(models.Model):
-    project = models.ForeignKey(Project)
-    layercommit = models.ForeignKey(Layer_Version, null=True)
+    project = models.ForeignKey(Project, on_delete=models.CASCADE)
+    layercommit = models.ForeignKey(Layer_Version, on_delete=models.CASCADE, null=True)
     optional = models.BooleanField(default = True)
 
     def __unicode__(self):
@@ -1630,8 +1630,8 @@ class CustomImageRecipe(Recipe):
     LAYER_NAME = "toaster-custom-images"
 
     search_allowed_fields = ['name']
-    base_recipe = models.ForeignKey(Recipe, related_name='based_on_recipe')
-    project = models.ForeignKey(Project)
+    base_recipe = models.ForeignKey(Recipe, on_delete=models.CASCADE, related_name='based_on_recipe')
+    project = models.ForeignKey(Project, on_delete=models.CASCADE)
     last_updated = models.DateTimeField(null=True, default=None)
 
     def get_last_successful_built_target(self):
@@ -1784,14 +1784,14 @@ class CustomImageRecipe(Recipe):
         return recipe_contents
 
 class ProjectVariable(models.Model):
-    project = models.ForeignKey(Project)
+    project = models.ForeignKey(Project, on_delete=models.CASCADE)
     name = models.CharField(max_length=100)
     value = models.TextField(blank = True)
 
 class Variable(models.Model):
     search_allowed_fields = ['variable_name', 'variable_value',
                              'vhistory__file_name', "description"]
-    build = models.ForeignKey(Build, related_name='variable_build')
+    build = models.ForeignKey(Build, on_delete=models.CASCADE, related_name='variable_build')
     variable_name = models.CharField(max_length=100)
     variable_value = models.TextField(blank=True)
     changed = models.BooleanField(default=False)
@@ -1799,7 +1799,7 @@ class Variable(models.Model):
     description = models.TextField(blank=True)
 
 class VariableHistory(models.Model):
-    variable = models.ForeignKey(Variable, related_name='vhistory')
+    variable = models.ForeignKey(Variable, on_delete=models.CASCADE, related_name='vhistory')
     value   = models.TextField(blank=True)
     file_name = models.FilePathField(max_length=255)
     line_number = models.IntegerField(null=True)
@@ -1809,7 +1809,7 @@ class HelpText(models.Model):
     VARIABLE = 0
     HELPTEXT_AREA = ((VARIABLE, 'variable'), )
 
-    build = models.ForeignKey(Build, related_name='helptext_build')
+    build = models.ForeignKey(Build, on_delete=models.CASCADE, related_name='helptext_build')
     area = models.IntegerField(choices=HELPTEXT_AREA)
     key = models.CharField(max_length=100)
     text = models.TextField()
@@ -1829,8 +1829,8 @@ class LogMessage(models.Model):
         (EXCEPTION, "toaster exception")
     )
 
-    build = models.ForeignKey(Build)
-    task  = models.ForeignKey(Task, blank = True, null=True)
+    build = models.ForeignKey(Build, on_delete=models.CASCADE)
+    task  = models.ForeignKey(Task, on_delete=models.CASCADE, blank = True, null=True)
     level = models.IntegerField(choices=LOG_LEVEL, default=INFO)
     message = models.TextField(blank=True, null=True)
     pathname = models.FilePathField(max_length=255, blank=True)
@@ -1859,7 +1859,7 @@ class Distro(models.Model):
     search_allowed_fields = ["name", "description", "layer_version__layer__name"]
     up_date = models.DateTimeField(null = True, default = None)
 
-    layer_version = models.ForeignKey('Layer_Version')
+    layer_version = models.ForeignKey('Layer_Version', on_delete=models.CASCADE)
     name = models.CharField(max_length=255)
     description = models.CharField(max_length=255)
 
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toaster/tests/browser/test_all_builds_page.py
index fba627b..8423d3d 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -9,7 +9,7 @@
 
 import re
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/toaster/tests/browser/test_all_projects_page.py
index afd2d35..15b0340 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -9,7 +9,7 @@
 
 import re
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/toaster/tests/browser/test_builddashboard_page.py
index d972aff..efcd89b 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index e2623e8..c6226d6 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
index c542d45..9d85ba9 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_recipes.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from orm.models import Project, Build, Recipe, Task, Layer, Layer_Version
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
index 22acb47..7fdf75d 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_tasks.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from orm.models import Project, Build, Recipe, Task, Layer, Layer_Version
diff --git a/lib/toaster/tests/browser/test_js_unit_tests.py b/lib/toaster/tests/browser/test_js_unit_tests.py
index e8b4295..e6163bb 100644
--- a/lib/toaster/tests/browser/test_js_unit_tests.py
+++ b/lib/toaster/tests/browser/test_js_unit_tests.py
@@ -11,7 +11,7 @@
 Run the js unit tests
 """
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 import logging
 
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/tests/browser/test_landing_page.py
index 0790198..8bb64b9 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -7,7 +7,7 @@
 # Copyright (C) 2013-2016 Intel Corporation
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index f81e696..71bdd2a 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -7,7 +7,7 @@
 # Copyright (C) 2013-2016 Intel Corporation
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 
 from orm.models import Layer, Layer_Version, Project, LayerSource, Release
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index 15d25dc..7844aaa 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -7,7 +7,7 @@
 # Copyright (C) 2013-2016 Intel Corporation
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from tests.browser.selenium_helpers_base import Wait
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/lib/toaster/tests/browser/test_new_custom_image_page.py
index 0aa3b7a..9906ae4 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 
 from orm.models import BitbakeVersion, Release, Project, ProjectLayer, Layer
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toaster/tests/browser/test_new_project_page.py
index 8e56bb0..e20a1f6 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 from selenium.webdriver.support.ui import Select
 from selenium.common.exceptions import InvalidElementStateException
diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/toaster/tests/browser/test_project_builds_page.py
index 47fb10b..51717e7 100644
--- a/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -9,7 +9,7 @@
 
 import re
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/toaster/tests/browser/test_project_config_page.py
index eaf27a1..944bcb2 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 
 from orm.models import BitbakeVersion, Release, Project, ProjectVariable
@@ -213,4 +213,5 @@ class TestProjectConfigsPage(SeleniumTestCase):
 
         hidden_element = self.driver.find_element_by_id('hintError-sstate_dir')
         self.assertEqual(hidden_element.is_displayed(), False,
-            'sstate directory path valid but treated as invalid')
\ No newline at end of file
+            'sstate directory path valid but treated as invalid')
+
diff --git a/lib/toaster/tests/browser/test_project_page.py b/lib/toaster/tests/browser/test_project_page.py
index 8b5e1b6..546293f 100644
--- a/lib/toaster/tests/browser/test_project_page.py
+++ b/lib/toaster/tests/browser/test_project_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 
diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests/browser/test_sample.py
index f4ad670..b0067c2 100644
--- a/lib/toaster/tests/browser/test_sample.py
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -16,7 +16,7 @@ New test files should follow this structure, should be named "test_*.py",
 and should be in the same directory as this sample.
 """
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 
 class TestSample(SeleniumTestCase):
diff --git a/lib/toaster/tests/browser/test_task_page.py b/lib/toaster/tests/browser/test_task_page.py
index 26f3dca..011b585 100644
--- a/lib/toaster/tests/browser/test_task_page.py
+++ b/lib/toaster/tests/browser/test_task_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from orm.models import Project, Build, Layer, Layer_Version, Recipe, Target
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toaster/tests/browser/test_toastertable_ui.py
index ef78cbb..e82d5ec 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -9,7 +9,7 @@
 
 from datetime import datetime
 
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from orm.models import BitbakeVersion, Release, Project, Build
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/views/test_views.py
index 68d9e9d..735d596 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -11,7 +11,7 @@
 
 from django.test import TestCase
 from django.test.client import RequestFactory
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.db.models import Q
 
 from orm.models import Project, Package
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index a4afc9e..b4cdc33 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -24,7 +24,7 @@ from bldcontrol import bbcontroller
 
 from django.http import HttpResponse, JsonResponse
 from django.views.generic import View
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.db.models import Q, F
 from django.db import Error
 from toastergui.templatetags.projecttags import filtered_filesizeformat
diff --git a/lib/toaster/toastergui/templatetags/project_url_tag.py b/lib/toaster/toastergui/templatetags/project_url_tag.py
index 71e0925..7b6f15b 100644
--- a/lib/toaster/toastergui/templatetags/project_url_tag.py
+++ b/lib/toaster/toastergui/templatetags/project_url_tag.py
@@ -3,7 +3,7 @@
 #
 
 from django import template
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 
 register = template.Library()
 
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index b703da3..c432f59 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -44,7 +44,7 @@ def json(value, default = None):
     # it manually here
     return mark_safe(JsonLib.dumps(value, indent=2, default = default, ensure_ascii=False).replace('</', '<\\/'))
 
-@register.assignment_tag
+@register.simple_tag
 def query(qs, **kwargs):
     """ template tag which allows queryset filtering. Usage:
           {% query books author=author as mybooks %}
@@ -83,7 +83,7 @@ def divide(value, arg):
 def multiply(value, arg):
     return int(value) * int(arg)
 
-@register.assignment_tag
+@register.simple_tag
 def datecompute(delta, start = timezone.now()):
     return start + timedelta(delta)
 
diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index fd750ff..a1e6fe9 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -10,7 +10,7 @@ import subprocess
 
 from toastergui.widgets import ToasterTypeAhead
 from orm.models import Project
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 from django.core.cache import cache
 
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index e2ead83..ae1973f 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -19,7 +19,7 @@ from orm.models import Target_Installed_Package, Target_File
 from orm.models import TargetKernelFile, TargetSDKFile, Target_Image_File
 from orm.models import BitbakeVersion, CustomImageRecipe
 
-from django.core.urlresolvers import reverse, resolve
+from django.urls import reverse, resolve
 from django.core.exceptions import ObjectDoesNotExist
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseNotFound, JsonResponse
@@ -352,7 +352,7 @@ def _get_parameters_values(request, default_count, default_order):
 # set cookies for parameters. this is usefull in case parameters are set
 # manually from the GET values of the link
 def _set_parameters_values(pagesize, orderby, request):
-    from django.core.urlresolvers import resolve
+    from django.urls import resolve
     current_url = resolve(request.path_info).url_name
     request.session['%s_count' % current_url] = pagesize
     request.session['%s_orderby' % current_url] =orderby
@@ -1364,8 +1364,8 @@ if True:
 
         template = "newproject.html"
         context = {
-            'email': request.user.email if request.user.is_authenticated() else '',
-            'username': request.user.username if request.user.is_authenticated() else '',
+            'email': request.user.email if request.user.is_authenticated else '',
+            'username': request.user.username if request.user.is_authenticated else '',
             'releases': Release.objects.order_by("description"),
         }
 
@@ -1391,7 +1391,7 @@ if True:
                     # set alert for missing fields
                     raise BadParameterException("Fields missing: %s" % ", ".join(missing))
 
-                if not request.user.is_authenticated():
+                if not request.user.is_authenticated:
                     user = authenticate(username = request.POST.get('username', '_anonuser'), password = 'nopass')
                     if user is None:
                         user = User.objects.create_user(username = request.POST.get('username', '_anonuser'), email = request.POST.get('email', ''), password = "nopass")
@@ -1438,8 +1438,8 @@ if True:
         project = Project.objects.get(pk=pid)
         template = "newproject_specific.html"
         context = {
-            'email': request.user.email if request.user.is_authenticated() else '',
-            'username': request.user.username if request.user.is_authenticated() else '',
+            'email': request.user.email if request.user.is_authenticated else '',
+            'username': request.user.username if request.user.is_authenticated else '',
             'releases': Release.objects.order_by("description"),
             'projectname': project.name,
             'project_pk': project.pk,
@@ -1469,7 +1469,7 @@ if True:
                     # set alert for missing fields
                     raise BadParameterException("Fields missing: %s" % ", ".join(missing))
 
-                if not request.user.is_authenticated():
+                if not request.user.is_authenticated:
                     user = authenticate(username = request.POST.get('username', '_anonuser'), password = 'nopass')
                     if user is None:
                         user = User.objects.create_user(username = request.POST.get('username', '_anonuser'), email = request.POST.get('email', ''), password = "nopass")
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 645f458..ceff529 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -22,7 +22,7 @@ from django.utils import timezone
 from toastergui.templatetags.projecttags import sectohms, get_tasks
 from toastergui.templatetags.projecttags import json as template_json
 from django.http import JsonResponse
-from django.core.urlresolvers import reverse
+from django.urls import reverse
 
 import types
 import json
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
index 3e246fd..7718caa 100644
--- a/lib/toaster/toastermain/management/commands/buildimport.py
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -466,7 +466,6 @@ class Command(BaseCommand):
                     release_name = 'None' if not pl.layercommit.release else pl.layercommit.release.name
                     print(" AFTER :ProjectLayer=%s,%s,%s,%s" % (pl.layercommit.layer.name,release_name,pl.layercommit.branch,pl.layercommit.commit))
 
-
     def handle(self, *args, **options):
         project_name = options['name']
         project_path = options['path']
@@ -551,6 +550,7 @@ class Command(BaseCommand):
             # preset the mode and default image recipe
             project.set_variable(Project.PROJECT_SPECIFIC_ISNEW,Project.PROJECT_SPECIFIC_NEW)
             project.set_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE,"core-image-minimal")
+
             # Assert any extended/custom actions or variables for new non-Toaster projects
             if not len(self.toaster_vars):
                 pass
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 74501fa..a4b370c 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -189,15 +189,16 @@ TEMPLATES = [
     },
 ]
 
-MIDDLEWARE_CLASSES = (
+MIDDLEWARE = [
     'django.middleware.common.CommonMiddleware',
     'django.contrib.sessions.middleware.SessionMiddleware',
     'django.middleware.csrf.CsrfViewMiddleware',
     'django.contrib.auth.middleware.AuthenticationMiddleware',
     'django.contrib.messages.middleware.MessageMiddleware',
-    # Uncomment the next line for simple clickjacking protection:
-    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
-)
+    'django.contrib.auth.middleware.AuthenticationMiddleware',
+    'django.contrib.messages.middleware.MessageMiddleware',
+    'django.contrib.sessions.middleware.SessionMiddleware',
+]
 
 CACHES = {
     #        'default': {
@@ -248,7 +249,7 @@ FRESH_ENABLED = False
 if os.environ.get('TOASTER_DEVEL', None) is not None:
     try:
         import fresh
-        MIDDLEWARE_CLASSES = ("fresh.middleware.FreshMiddleware",) + MIDDLEWARE_CLASSES
+        MIDDLEWARE = ["fresh.middleware.FreshMiddleware",] + MIDDLEWARE
         INSTALLED_APPS = INSTALLED_APPS + ('fresh',)
         FRESH_ENABLED = True
     except:
@@ -258,8 +259,8 @@ DEBUG_PANEL_ENABLED = False
 if os.environ.get('TOASTER_DEVEL', None) is not None:
     try:
         import debug_toolbar, debug_panel
-        MIDDLEWARE_CLASSES = ('debug_panel.middleware.DebugPanelMiddleware',) + MIDDLEWARE_CLASSES
-        #MIDDLEWARE_CLASSES = MIDDLEWARE_CLASSES + ('debug_toolbar.middleware.DebugToolbarMiddleware',)
+        MIDDLEWARE = ['debug_panel.middleware.DebugPanelMiddleware',] + MIDDLEWARE
+        #MIDDLEWARE = MIDDLEWARE + ['debug_toolbar.middleware.DebugToolbarMiddleware',]
         INSTALLED_APPS = INSTALLED_APPS + ('debug_toolbar','debug_panel',)
         DEBUG_PANEL_ENABLED = True
 
@@ -352,5 +353,3 @@ def activate_synchronous_off(sender, connection, **kwargs):
 connection_created.connect(activate_synchronous_off)
 #
 
-
-
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index ac77bc3..5fb520b 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -51,7 +51,7 @@ if toastermain.settings.DEBUG_PANEL_ENABLED:
 
 urlpatterns = [
     # Uncomment the next line to enable the admin:
-    url(r'^admin/', include(admin.site.urls)),
+    url(r'^admin/', admin.site.urls),
 ] + urlpatterns
 
 # Automatically discover urls.py in various apps, beside our own
@@ -69,7 +69,7 @@ for t in os.walk(os.path.dirname(currentdir)):
         # make sure we don't have this module name in
         conflict = False
         for p in urlpatterns:
-            if p.regex.pattern == '^' + modulename + '/':
+            if p.pattern.regex.pattern == '^' + modulename + '/':
                 conflict = True
         if not conflict:
             urlpatterns.insert(0, url(r'^' + modulename + '/', include ( modulename + '.urls')))
-- 
1.9.1

