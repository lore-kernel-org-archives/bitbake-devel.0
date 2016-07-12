Return-Path: <brian.avery@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2D054731DD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 22:53:56 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Jul 2016 15:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,354,1464678000"; d="scan'208";a="1015672976"
Received: from bavery-ws-desk.jf.intel.com ([10.7.201.28])
	by orsmga002.jf.intel.com with ESMTP; 12 Jul 2016 15:53:44 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2016 15:54:54 -0700
Message-Id: <57c979b5cc959c1bd4bf0468c34a714d7ff35bb9.1468363530.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
References: <4551b56f132497c055f39567946a5d3be347d770.1468363530.git.brian.avery@intel.com>
In-Reply-To: <cover.1468363530.git.brian.avery@intel.com>
References: <cover.1468363530.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 13/17] toaster: add package manifest path to Target objects
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
X-List-Received-Date: Tue, 12 Jul 2016 22:53:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

Store the path to the *.rootfs.manifest file for targets which
generate images.

A link to the package manifest is displayed in the build dashboard
for targets which produce image files.

Like the license manifest path, if a target would have produced
the package manifest (but didn't, because it already existed), that
path is copied from the target which did produce the package
manifest.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 24 +++++++++++++++++++---
 .../0009_target_package_manifest_path.py           | 19 +++++++++++++++++
 lib/toaster/orm/models.py                          |  8 +++++---
 .../toastergui/templates/builddashboard.html       |  6 ++++++
 lib/toaster/toastergui/views.py                    |  3 +++
 5 files changed, 54 insertions(+), 6 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0009_target_package_manifest_path.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 52b5e12..91189f6 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -256,6 +256,10 @@ class ORMWrapper(object):
         target.license_manifest_path = license_manifest_path
         target.save()
 
+    def update_target_set_package_manifest(self, target, package_manifest_path):
+        target.package_manifest_path = package_manifest_path
+        target.save()
+
     def update_task_object(self, build, task_name, recipe_name, task_stats):
         """
         Find the task for build which matches the recipe and task name
@@ -1597,7 +1601,7 @@ class BuildInfoHelper(object):
         machine = self.server.runCommand(['getVariable', 'MACHINE'])[0]
         image_name = self.server.runCommand(['getVariable', 'IMAGE_NAME'])[0]
 
-        # location of the image_license.manifest files for this build;
+        # location of the manifest files for this build;
         # note that this file is only produced if an image is produced
         license_directory = \
             self.server.runCommand(['getVariable', 'LICENSE_DIRECTORY'])[0]
@@ -1636,6 +1640,11 @@ class BuildInfoHelper(object):
                 real_image_name,
                 'image_license.manifest')
 
+            image_package_manifest_path = os.path.join(
+                license_directory,
+                real_image_name,
+                'image_license.manifest')
+
             # if image_license.manifest exists, we can read the names of bzImage
             # and modules files for this build from it, then look for them
             # in the DEPLOY_DIR_IMAGE; note that this file is only produced
@@ -1657,11 +1666,20 @@ class BuildInfoHelper(object):
 
                 # store the license manifest path on the target
                 # (this file is also created any time an image file is created)
-                license_path = os.path.join(license_directory,
+                license_manifest_path = os.path.join(license_directory,
                     real_image_name, 'license.manifest')
 
                 self.orm_wrapper.update_target_set_license_manifest(
-                    image_target, license_path)
+                    image_target, license_manifest_path)
+
+                # store the package manifest path on the target (this file
+                # is created any time an image file is created)
+                package_manifest_path = os.path.join(deploy_dir_image,
+                    real_image_name + '.rootfs.manifest')
+
+                if os.path.exists(package_manifest_path):
+                    self.orm_wrapper.update_target_set_package_manifest(
+                        image_target, package_manifest_path)
 
             # scan the directory for image files relating to this build
             # (via real_image_name); note that we don't have to set
diff --git a/lib/toaster/orm/migrations/0009_target_package_manifest_path.py b/lib/toaster/orm/migrations/0009_target_package_manifest_path.py
new file mode 100644
index 0000000..c958f30
--- /dev/null
+++ b/lib/toaster/orm/migrations/0009_target_package_manifest_path.py
@@ -0,0 +1,19 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0008_refactor_artifact_models'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='target',
+            name='package_manifest_path',
+            field=models.CharField(null=True, max_length=500),
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index a111916..8e40f0a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -622,6 +622,7 @@ class Target(models.Model):
     is_image = models.BooleanField(default = False)
     image_size = models.IntegerField(default=0)
     license_manifest_path = models.CharField(max_length=500, null=True)
+    package_manifest_path = models.CharField(max_length=500, null=True)
 
     def package_count(self):
         return Target_Installed_Package.objects.filter(target_id__exact=self.id).count()
@@ -729,9 +730,9 @@ class Target(models.Model):
         Target_Image_File object for an ext4 image being associated with a
         target for a project which didn't produce an ext4 image (for example).
 
-        Also sets the license_manifest_path of this target to the same path
-        as that of target being cloned from, as the license manifest path is
-        also a build artifact but is treated differently.
+        Also sets the license_manifest_path and package_manifest_path
+        of this target to the same path as that of target being cloned from, as
+        the manifests are also build artifacts but are treated differently.
         """
 
         image_fstypes = self.build.get_image_fstypes()
@@ -754,6 +755,7 @@ class Target(models.Model):
             kernel_file.save()
 
         self.license_manifest_path = target.license_manifest_path
+        self.package_manifest_path = target.package_manifest_path
         self.save()
 
     def clone_sdk_artifacts_from(self, target):
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 32212ea..36c28b7 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -90,6 +90,12 @@
             <dd>
               <a href="{% url 'build_artifact' build.pk 'licensemanifest' target.target.pk %}">License manifest</a>
             </dd>
+
+            {% if target.target.package_manifest_path %}
+              <dd>
+                <a href="{% url 'build_artifact' build.pk 'packagemanifest' target.target.pk %}">Package manifest</a>
+              </dd>
+            {% endif %}
           </dl>
 
           <dl class="dl-horizontal">
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index baaa288..aab6536 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2315,6 +2315,9 @@ if True:
         elif artifact_type == "licensemanifest":
             file_name = Target.objects.get(build = build, pk = artifact_id).license_manifest_path
 
+        elif artifact_type == "packagemanifest":
+            file_name = Target.objects.get(build = build, pk = artifact_id).package_manifest_path
+
         elif artifact_type == "tasklogfile":
             file_name = Task.objects.get(build = build, pk = artifact_id).logfile
 
-- 
1.9.1


