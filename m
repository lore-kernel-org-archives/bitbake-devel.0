Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f169.google.com (mail-pf0-f169.google.com
	[209.85.192.169])
	by mail.openembedded.org (Postfix) with ESMTP id EC6B66067C
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:53 +0000 (UTC)
Received: by mail-pf0-f169.google.com with SMTP id i123so17270793pfg.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=HgbnB6WxCPDXJW51NHuU+Otf41pgGFjJ//fSrMBSjC0=;
	b=PyJ7UgiGalqoSgV8BO6BUQUz5jMsjPHmZL+kI9vHgQm82/oYLOFYDZb6hYvzc8PIr0
	StnxdBLMhd9b8ekF33Bdf6OMK8rHMCcz66/pk+mHT2MOmIhCw3WOX4BQnGG/AYrKhmT3
	WfIGMPcSVnnDRXCe+qDPzhOpLEjlOeflUXWiBedAb9Czrq4FPE4yHS1/u9Py6Fp55XVd
	K2qsd9rpmQwwZAQsAlAcsz2xGQJoeLJhPGi8pP1shPdGvpAQg9VBUkGVRZl5vvCXsjyD
	W0nxQ4Z8xP+qQ+I0Czm8FmrJUNuBgP+U4EAX6wdzevqVtc2Q3iNt2hOI9zBkVN2+q6iR
	8YOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HgbnB6WxCPDXJW51NHuU+Otf41pgGFjJ//fSrMBSjC0=;
	b=kPtuQvO4dfCgCvRln+lO2avKsWzyemLMtFH1W2PUBA30S31zcSDKmrFvTWgmoKIXLM
	KJWRwfwKNNVsbazGF75bGgD56fBUtTareLfwxohr7UkbL+NYF/Fw99RtJPt7RlEEy+5A
	Eu081CTuw8wduJ9VMWhhEpV7cJAOIqJOV23zJRdp4hRpZLU1qLqGn1EhVPocSX4eE1UF
	MzPfuuEvGX8rJIlz5zgoNsOBMLM/xCZ27R6x3uFdTt5fbQua4P2JpSNdj1XhrzJ0X2Ek
	rVoIzZQYT84NeIQWg6WFpsthmpbnnouCbN54CgNoOI/9zUb7EIU0ww//3gysvOq5KDGf
	vkzg==
X-Gm-Message-State: ALyK8tKh1vGsZ7Q0ubIHFK9nF/LyqS6sVAjvOz2lMEo1ahmX/vocXcCGDf6zF6Sgz/RzOA==
X-Received: by 10.98.66.209 with SMTP id h78mr8755717pfd.11.1468025574228;
	Fri, 08 Jul 2016 17:52:54 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:53 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:45 -0700
Message-Id: <4d7e8a020126cc2c3728ce30a8d9da3b28574535.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 5/7] toaster: attach kernel artifacts to targets
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:55 -0000

From: Elliot Smith <elliot.smith@intel.com>

The bzImage and modules files were previously attached to a build,
rather than to the target which produced them. This meant it was
not possible to determine which kernel artifact produced by a
build came from which target; which in turn made it difficult to
associate existing kernel artifact with targets when those
targets didn't produce artifacts (e.g. if the same machine + target
combination was built again and didn't produce a bzImage or modules
file because those files already existed).

By associating kernel artifacts with the target (via a new
TargetArtifactFile model), we make it possible to find all
the artifacts for a given machine + target combination. Then, in
cases where a build is completed but its targets don't produce
any artifacts, we can find a previous Target object with the same
machine + target and copy its artifacts to the targets for a
just-completed build.

Note that this doesn't cover SDK artifacts yet, which are still
retrieved in toaster.bbclass and show up as "Other artifacts",
lumped together for the whole build rather than by target.

[YOCTO #8556]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       |  85 +++++++++-----
 .../orm/migrations/0008_targetartifactfile.py      |  23 ++++
 lib/toaster/orm/models.py                          | 123 ++++++++++++++++++++-
 .../toastergui/templates/builddashboard.html       |  15 ++-
 lib/toaster/toastergui/views.py                    |   7 ++
 5 files changed, 221 insertions(+), 32 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0008_targetartifactfile.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8bdc9cc..a5b2237 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -37,7 +37,7 @@ os.environ["DJANGO_SETTINGS_MODULE"] =\
 django.setup()

 from orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
-from orm.models import Target_Image_File, BuildArtifact
+from orm.models import Target_Image_File, BuildArtifact, TargetArtifactFile
 from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from orm.models import Task_Dependency, Package_Dependency
@@ -121,6 +121,13 @@ class ORMWrapper(object):

         return vars(self)[dictname][key]

+    def get_similar_target_with_image_files(self, target):
+        """
+        Get a Target object "similar" to target; i.e. with the same target
+        name ('core-image-minimal' etc.) and machine.
+        """
+        return target.get_similar_target_with_image_files()
+
     def _timestamp_to_datetime(self, secs):
         """
         Convert timestamp in seconds to Python datetime
@@ -678,27 +685,32 @@ class ORMWrapper(object):
                             file_name = file_name,
                             file_size = file_size)

-    def save_artifact_information_no_dedupe(self, build_obj, file_name, file_size):
+    def save_target_artifact_file(self, target_obj, file_name, file_size):
         """
-        Save artifact information without checking for duplicate paths;
-        this is used when we are saving data about an artifact which was
-        generated by a previous build but which is also relevant to this build,
-        e.g. a bzImage file.
+        Save artifact file information for a Target target_obj.
+
+        Note that this doesn't include SDK artifacts, only images and
+        related files (e.g. bzImage).
         """
-        BuildArtifact.objects.create(build=build_obj, file_name=file_name,
-            file_size=file_size)
+        TargetArtifactFile.objects.create(target=target_obj,
+            file_name=file_name, file_size=file_size)

     def save_artifact_information(self, build_obj, file_name, file_size):
-        # we skip the image files from other builds
-        if Target_Image_File.objects.filter(file_name = file_name).count() > 0:
-            return
-
+        """
+        TODO this is currently used to save SDK artifacts to the database,
+        but will be replaced in future once SDK artifacts are associated with
+        Target objects (as they eventually should be)
+        """
         # do not update artifacts found in other builds
         if BuildArtifact.objects.filter(file_name = file_name).count() > 0:
             return

-        self.save_artifact_information_no_dedupe(self, build_obj, file_name,
-            file_size)
+        # do not update artifact if already a target artifact file for that path
+        if TargetArtifactFile.objects.filter(file_name = file_name).count() > 0:
+            return
+
+        BuildArtifact.objects.create(build=build_obj, file_name=file_name,
+            file_size=file_size)

     def create_logmessage(self, log_information):
         assert 'build' in log_information
@@ -1496,7 +1508,7 @@ class BuildInfoHelper(object):

         self.orm_wrapper.create_logmessage(log_information)

-    def _get_files_from_image_license(self, image_license_manifest_path):
+    def _get_filenames_from_image_license(self, image_license_manifest_path):
         """
         Find the FILES line in the image_license.manifest file,
         which has the basenames of the bzImage and modules files
@@ -1567,19 +1579,20 @@ class BuildInfoHelper(object):

         OR

-        2. There are no files for the target, so copy them from a
-        previous build with the same target + machine.
+        2. There are no new files for the target (they were already produced by
+        a previous build), so copy them from the most recent previous build with
+        the same target, task and machine.
         """
         deploy_dir_image = \
             self.server.runCommand(['getVariable', 'DEPLOY_DIR_IMAGE'])[0]

         # if there's no DEPLOY_DIR_IMAGE, there aren't going to be
-        # any build artifacts, so we can return immediately
+        # any image artifacts, so we can return immediately
         if not deploy_dir_image:
             return

         buildname = self.server.runCommand(['getVariable', 'BUILDNAME'])[0]
-        machine =  self.server.runCommand(['getVariable', 'MACHINE'])[0]
+        machine = self.server.runCommand(['getVariable', 'MACHINE'])[0]
         image_name = self.server.runCommand(['getVariable', 'IMAGE_NAME'])[0]

         # location of the image_license.manifest files for this build;
@@ -1597,7 +1610,10 @@ class BuildInfoHelper(object):
             image_file_extensions_unique = set(image_file_extensions.split(' '))

         targets = self.internal_state['targets']
+
+        # filter out anything which isn't an image target
         image_targets = [target for target in targets if target.is_image]
+
         for target in image_targets:
             # this is set to True if we find at least one file relating to
             # this target; if this remains False after the scan, we copy the
@@ -1625,16 +1641,17 @@ class BuildInfoHelper(object):
             if os.path.isfile(image_license_manifest_path):
                 has_files = True

-                basenames = self._get_files_from_image_license(
+                basenames = self._get_filenames_from_image_license(
                     image_license_manifest_path)

                 for basename in basenames:
                     artifact_path = os.path.join(deploy_dir_image, basename)
                     artifact_size = os.stat(artifact_path).st_size

-                    self.orm_wrapper.save_artifact_information_no_dedupe(
-                        self.internal_state['build'], artifact_path,
-                        artifact_size)
+                    # note that the artifact will only be saved against this
+                    # build if it hasn't been already
+                    self.orm_wrapper.save_target_artifact_file(target,
+                        artifact_path, artifact_size)

                 # store the license manifest path on the target
                 # (this file is also created any time an image file is created)
@@ -1648,7 +1665,10 @@ class BuildInfoHelper(object):
             # (via real_image_name); note that we don't have to set
             # has_files = True, as searching for the license manifest file
             # will already have set it to true if at least one image file was
-            # produced
+            # produced; note that the real_image_name includes BUILDNAME, which
+            # in turn includes a timestamp; so if no files were produced for
+            # this timestamp (i.e. the build reused existing image files already
+            # in the directory), no files will be recorded against this target
             image_files = self._get_image_files(deploy_dir_image,
                 real_image_name, image_file_extensions_unique)

@@ -1657,11 +1677,18 @@ class BuildInfoHelper(object):
                     target, image_file['path'], image_file['size'])

             if not has_files:
-                # TODO copy artifact and image files from the
-                # most-recently-built Target with the same target + machine
-                # as this Target; also copy the license manifest path,
-                # as that is treated differently
-                pass
+                # copy image files and build artifacts from the
+                # most-recently-built Target with the
+                # same target + machine as this Target; also copy the license
+                # manifest path, as that is not treated as an artifact and needs
+                # to be set separately
+                most_recent = \
+                    self.orm_wrapper.get_similar_target_with_image_files(target)
+
+                if most_recent:
+                    logger.info('image artifacts for target %s cloned from ' \
+                        'target %s' % (target.pk, most_recent.pk))
+                    target.clone_artifacts_from(most_recent)

     def close(self, errorcode):
         if self.brbe is not None:
diff --git a/lib/toaster/orm/migrations/0008_targetartifactfile.py b/lib/toaster/orm/migrations/0008_targetartifactfile.py
new file mode 100644
index 0000000..9f1d9bf
--- /dev/null
+++ b/lib/toaster/orm/migrations/0008_targetartifactfile.py
@@ -0,0 +1,23 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0007_auto_20160523_1446'),
+    ]
+
+    operations = [
+        migrations.CreateModel(
+            name='TargetArtifactFile',
+            fields=[
+                ('id', models.AutoField(primary_key=True, serialize=False, auto_created=True, verbose_name='ID')),
+                ('file_name', models.FilePathField()),
+                ('file_size', models.IntegerField()),
+                ('target', models.ForeignKey(to='orm.Target')),
+            ],
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 40cdb9e..9edbef3 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -22,7 +22,7 @@
 from __future__ import unicode_literals

 from django.db import models, IntegrityError
-from django.db.models import F, Q, Avg, Max, Sum
+from django.db.models import F, Q, Avg, Max, Sum, Count
 from django.utils import timezone
 from django.utils.encoding import force_bytes

@@ -438,7 +438,9 @@ class Build(models.Model):

     def get_image_file_extensions(self):
         """
-        Get list of file name extensions for images produced by this build
+        Get list of file name extensions for images produced by this build;
+        note that this is the actual list of extensions stored on Target objects
+        for this build, and not the value of IMAGE_FSTYPES.
         """
         extensions = []

@@ -458,6 +460,15 @@ class Build(models.Model):

         return ', '.join(extensions)

+    def get_image_fstypes(self):
+        """
+        Get the IMAGE_FSTYPES variable value for this build as a de-duplicated
+        list of image file suffixes.
+        """
+        image_fstypes = Variable.objects.get(
+            build=self, variable_name='IMAGE_FSTYPES').variable_value
+        return list(set(re.split(r' {1,}', image_fstypes)))
+
     def get_sorted_target_list(self):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
@@ -612,6 +623,114 @@ class Target(models.Model):
     def __unicode__(self):
         return self.target

+    def get_similar_targets(self):
+        """
+        Get targets for the same machine, task and target name
+        (e.g. 'core-image-minimal') from a successful build for this project
+        (but excluding this target).
+
+        Note that we look for targets built by this project because projects
+        can have different configurations from each other, and put their
+        artifacts in different directories.
+        """
+        query = ~Q(pk=self.pk) & \
+            Q(target=self.target) & \
+            Q(build__machine=self.build.machine) & \
+            Q(build__outcome=Build.SUCCEEDED) & \
+            Q(build__project=self.build.project)
+
+        return Target.objects.filter(query)
+
+    def get_similar_target_with_image_files(self):
+        """
+        Get the most recent similar target with Target_Image_Files associated
+        with it, for the purpose of cloning those files onto this target.
+        """
+        similar_target = None
+
+        candidates = self.get_similar_targets()
+        if candidates.count() < 1:
+            return similar_target
+
+        task_subquery = Q(task=self.task)
+
+        # we can look for a 'build' task if this task is a 'populate_sdk_ext'
+        # task, as it will have created images; and vice versa; note that
+        # 'build' targets can have their task set to '';
+        # also note that 'populate_sdk' does not produce image files
+        image_tasks = [
+            '', # aka 'build'
+            'build',
+            'populate_sdk_ext'
+        ]
+        if self.task in image_tasks:
+            task_subquery = Q(task__in=image_tasks)
+
+        query = task_subquery & Q(num_files__gt=0)
+
+        # annotate with the count of files, to exclude any targets which
+        # don't have associated files
+        candidates = candidates.annotate(
+            num_files=Count('target_image_file'))
+
+        candidates = candidates.filter(query)
+
+        if candidates.count() > 0:
+            candidates.order_by('build__completed_on')
+            similar_target = candidates.last()
+
+        return similar_target
+
+    def clone_artifacts_from(self, target):
+        """
+        Make clones of the BuildArtifacts, Target_Image_Files and
+        TargetArtifactFile objects associated with Target target, then
+        associate them with this target.
+
+        Note that for Target_Image_Files, we only want files from the previous
+        build whose suffix matches one of the suffixes defined in this
+        target's build's IMAGE_FSTYPES configuration variable. This prevents the
+        Target_Image_File object for an ext4 image being associated with a
+        target for a project which didn't produce an ext4 image (for example).
+
+        Also sets the license_manifest_path of this target to the same path
+        as that of target being cloned from, as the license manifest path is
+        also a build artifact but is treated differently.
+        """
+
+        image_fstypes = self.build.get_image_fstypes()
+
+        # filter out any image files whose suffixes aren't in the
+        # IMAGE_FSTYPES suffixes variable for this target's build
+        image_files = [target_image_file \
+            for target_image_file in target.target_image_file_set.all() \
+            if target_image_file.suffix in image_fstypes]
+
+        for image_file in image_files:
+            image_file.pk = None
+            image_file.target = self
+            image_file.save()
+
+        artifact_files = target.targetartifactfile_set.all()
+        for artifact_file in artifact_files:
+            artifact_file.pk = None
+            artifact_file.target = self
+            artifact_file.save()
+
+        self.license_manifest_path = target.license_manifest_path
+        self.save()
+
+# an Artifact is anything that results from a target being built, and may
+# be of interest to the user, and is not an image file
+class TargetArtifactFile(models.Model):
+    target = models.ForeignKey(Target)
+    file_name = models.FilePathField()
+    file_size = models.IntegerField()
+
+    @property
+    def basename(self):
+        return os.path.basename(self.file_name)
+
 class Target_Image_File(models.Model):
     # valid suffixes for image files produced by a build
     SUFFIXES = {
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index dcda2a8..f6d62b9 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -74,7 +74,7 @@
     {% for target in targets %}
         {% if target.target.is_image %}
     <div class="well well-transparent dashboard-section">
-        <h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target}}</a></h3>
+        <h3><a href="{% url 'target' build.pk target.target.pk %}">{{target.target.target}}</a></h3>
         <dl class="dl-horizontal">
             <dt>Packages included</dt>
             <dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
@@ -124,6 +124,19 @@
                     {% endfor %}
                 </ul>
             </dd>
+            <dt>
+                Kernel artifacts
+            </dt>
+            <dd>
+                <ul class="list-unstyled">
+                    {% for artifact in target.target_artifacts|dictsort:"basename" %}
+                        <li>
+                            <a href="{% url 'build_artifact' build.id 'targetartifactfile' artifact.id %}">{{artifact.basename}}</a>
+                            ({{artifact.file_size|filtered_filesizeformat}})
+                        </li>
+                    {% endfor %}
+                  </ul>
+            </dd>
         </dl>
         {% endif %}
     </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ad85faf..0ec88d9 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -31,6 +31,7 @@ from django.shortcuts import render, redirect, get_object_or_404
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact, CustomImagePackage
+from orm.models import TargetArtifactFile
 from orm.models import BitbakeVersion, CustomImageRecipe
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
@@ -509,6 +510,8 @@ def builddashboard( request, build_id ):
             targetHasNoImages = True
         elem[ 'imageFiles' ] = imageFiles
         elem[ 'targetHasNoImages' ] = targetHasNoImages
+        elem['target_artifacts'] = t.targetartifactfile_set.all()
+
         targets.append( elem )

     ##
@@ -2294,6 +2297,10 @@ if True:
         elif artifact_type == "buildartifact":
             file_name = BuildArtifact.objects.get(build = build, pk = artifact_id).file_name

+        elif artifact_type == "targetartifactfile":
+            target = TargetArtifactFile.objects.get(pk=artifact_id)
+            file_name = target.file_name
+
         elif artifact_type == "licensemanifest":
             file_name = Target.objects.get(build = build, pk = artifact_id).license_manifest_path

--
1.9.1

