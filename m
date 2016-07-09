Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id A3F896067C
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:55 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id hu1so4489579pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=FsbSWK3j0LU9BovAEShC3+Th0ItYL68mwIEAov/G4pI=;
	b=a5/ROHhcfPerJVmkCzS2cvn3/0aoFpMBiBScp0I0EBP29V8UyDqhOXRRaQ8CS/h9mR
	Yd0WA6bRLFf61RsiQqSDpy/R4fv/D1FbQkp2sFeoHCGUd7uNWSZbDjVHTIAayebdl+gi
	mDZSfx/SEI3/Cc0Tf51DoG4GhRLUhMsq0aKLZ8k5GMmaXNt3HvmpOX1cy7FH3HlOiFgo
	ng+ZEBO28fnrjaUO1qyQ2zrMyGjYoT9IH5iivU64WpgqGZrLtauqJUl4V5IPVKq+BM9O
	HM2baldvIkEbKVWuiqLTGO4zAjS43AvAMqMY4YBwtJctERBBnfmf/EpkXHdeWQr7i030
	ubfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=FsbSWK3j0LU9BovAEShC3+Th0ItYL68mwIEAov/G4pI=;
	b=KPPAGqSVTu8V9ez+92tddY2qZRzn/fmShyk2fw6V8oYSM7NeIJYJOh4eoWjS8Rqz1S
	44f7wbRg4wgL2PBDfimP5O8MqTAV2myXuc+e4qOcp1foKI98XsjW7HabqKDeBNJzy43v
	THHZtCoNZuQVWYUlCV9L+x5x1zb5+NRz3r/CGmVWVyoDikDCi3XbdhGMrZJEoIdGrOE/
	rj/+0Z6kJIe0qnWOs1uQxdOT8CIW1/XfbjVYqxHFQD9f1PcKCW4eP9wuzsZZjZo1CjbN
	ZAQrup4Yx2JKXTyqJXNexheGankA+d+YaNMxMau+zhH+8oEf7FQvMtElXzoxPvbQJSBT
	0m4g==
X-Gm-Message-State: ALyK8tK43MZNsgG/qJdHvu7RbOGte9pi4LnXjcspZoa1FCwW/oX4FhJJNzNPcTRaSxF1wA==
X-Received: by 10.66.73.193 with SMTP id n1mr14739918pav.70.1468025575835;
	Fri, 08 Jul 2016 17:52:55 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:55 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:47 -0700
Message-Id: <c8e965dbb42d846f5af69b29f4b4f324f1d525a8.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 7/7] toaster: improve scan for SDK artifacts
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

SDK artifacts were previously picked up by toaster.bbclass and
notified to buildinfohelper (via toasterui). The artifacts
were then added to the Build object, so that it wasn't clear
which artifact went with which target; we were also unable
to attach SDK artifacts to a Build if they had already been
attached to a previous build.

Now, toaster.bbclass just notifies the TOOLCHAIN_OUTPUTNAME when
a populate_sdk* target completes. The scan is moved to buildinfohelper,
where we search the SDK deploy directory for files matching
TOOLCHAIN_OUTPUTNAME and attach them to targets (not builds).

If an SDK file is not produced by a target, we now look for a
similar, previously-run target which did produce artifacts.
If there is one, we clone the SDK artifacts from that target
onto the current one.

This all means that we can show SDK artifacts by target, and should
always get artifacts associated with a target, regardless of whether
it really build them.

This requires an additional model, TargetSDKFile, which tracks
the size and path of SDK artifact files with respect to Target
objects.

[YOCTO #8556]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/bb/ui/buildinfohelper.py                       | 175 ++++++++++++++++-----
 lib/bb/ui/toasterui.py                             |   7 +-
 ...actfile.py => 0008_refactor_artifact_models.py} |  20 ++-
 lib/toaster/orm/models.py                          | 112 ++++++++-----
 .../toastergui/templates/builddashboard.html       |  64 +++++---
 lib/toaster/toastergui/views.py                    |  19 ++-
 6 files changed, 279 insertions(+), 118 deletions(-)
 rename bitbake/lib/toaster/orm/migrations/{0008_targetartifactfile.py => 0008_refactor_artifact_models.py} (40%)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index e1b59c3..bf032ae 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -37,7 +37,7 @@ os.environ["DJANGO_SETTINGS_MODULE"] =\
 django.setup()

 from orm.models import Build, Task, Recipe, Layer_Version, Layer, Target, LogMessage, HelpText
-from orm.models import Target_Image_File, BuildArtifact, TargetArtifactFile
+from orm.models import Target_Image_File, TargetKernelFile, TargetSDKFile
 from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from orm.models import Task_Dependency, Package_Dependency
@@ -128,6 +128,15 @@ class ORMWrapper(object):
         """
         return target.get_similar_target_with_image_files()

+    def get_similar_target_with_sdk_files(self, target):
+        return target.get_similar_target_with_sdk_files()
+
+    def clone_image_artifacts(self, target_from, target_to):
+        target_to.clone_image_artifacts_from(target_from)
+
+    def clone_sdk_artifacts(self, target_from, target_to):
+        target_to.clone_sdk_artifacts_from(target_from)
+
     def _timestamp_to_datetime(self, secs):
         """
         Convert timestamp in seconds to Python datetime
@@ -682,35 +691,22 @@ class ORMWrapper(object):
             logger.warning("buildinfohelper: target_package_info could not identify recipes: \n%s", errormsg)

     def save_target_image_file_information(self, target_obj, file_name, file_size):
-        Target_Image_File.objects.create( target = target_obj,
-                            file_name = file_name,
-                            file_size = file_size)
+        Target_Image_File.objects.create(target=target_obj,
+            file_name=file_name, file_size=file_size)

-    def save_target_artifact_file(self, target_obj, file_name, file_size):
+    def save_target_kernel_file(self, target_obj, file_name, file_size):
         """
-        Save artifact file information for a Target target_obj.
-
-        Note that this doesn't include SDK artifacts, only images and
-        related files (e.g. bzImage).
+        Save kernel file (bzImage, modules*) information for a Target target_obj.
         """
-        TargetArtifactFile.objects.create(target=target_obj,
+        TargetKernelFile.objects.create(target=target_obj,
             file_name=file_name, file_size=file_size)

-    def save_artifact_information(self, build_obj, file_name, file_size):
+    def save_target_sdk_file(self, target_obj, file_name, file_size):
         """
-        TODO this is currently used to save SDK artifacts to the database,
-        but will be replaced in future once SDK artifacts are associated with
-        Target objects (as they eventually should be)
+        Save SDK artifacts to the database, associating them with a
+        Target object.
         """
-        # do not update artifacts found in other builds
-        if BuildArtifact.objects.filter(file_name = file_name).count() > 0:
-            return
-
-        # do not update artifact if already a target artifact file for that path
-        if TargetArtifactFile.objects.filter(file_name = file_name).count() > 0:
-            return
-
-        BuildArtifact.objects.create(build=build_obj, file_name=file_name,
+        TargetSDKFile.objects.create(target=target_obj, file_name=file_name,
             file_size=file_size)

     def create_logmessage(self, log_information):
@@ -1085,11 +1081,6 @@ class BuildInfoHelper(object):

         return self.brbe

-    def update_artifact_image_file(self, event):
-        evdata = BuildInfoHelper._get_data_from_event(event)
-        for artifact_path in evdata.keys():
-            self.orm_wrapper.save_artifact_information(self.internal_state['build'], artifact_path, evdata[artifact_path])
-
     def update_build_information(self, event, errors, warnings, taskfailures):
         if 'build' in self.internal_state:
             self.orm_wrapper.update_build_object(self.internal_state['build'], errors, warnings, taskfailures)
@@ -1568,9 +1559,9 @@ class BuildInfoHelper(object):

         return image_files

-    def scan_build_artifacts(self):
+    def scan_image_artifacts(self):
         """
-        Scan for build artifacts in DEPLOY_DIR_IMAGE and associate them
+        Scan for built image artifacts in DEPLOY_DIR_IMAGE and associate them
         with a Target object in self.internal_state['targets'].

         We have two situations to handle:
@@ -1615,7 +1606,7 @@ class BuildInfoHelper(object):
         # filter out anything which isn't an image target
         image_targets = [target for target in targets if target.is_image]

-        for target in image_targets:
+        for image_target in image_targets:
             # this is set to True if we find at least one file relating to
             # this target; if this remains False after the scan, we copy the
             # files from the most-recent Target with the same target + machine
@@ -1627,7 +1618,7 @@ class BuildInfoHelper(object):
             # 'defaultpkgname-<MACHINE>-<BUILDNAME>';
             # we need to change it to
             # <TARGET>-<MACHINE>-<BUILDNAME>
-            real_image_name = re.sub(r'^defaultpkgname', target.target,
+            real_image_name = re.sub(r'^defaultpkgname', image_target.target,
                 image_name)

             image_license_manifest_path = os.path.join(
@@ -1651,7 +1642,7 @@ class BuildInfoHelper(object):

                     # note that the artifact will only be saved against this
                     # build if it hasn't been already
-                    self.orm_wrapper.save_target_artifact_file(target,
+                    self.orm_wrapper.save_target_kernel_file(image_target,
                         artifact_path, artifact_size)

                 # store the license manifest path on the target
@@ -1659,8 +1650,8 @@ class BuildInfoHelper(object):
                 license_path = os.path.join(license_directory,
                     real_image_name, 'license.manifest')

-                self.orm_wrapper.update_target_set_license_manifest(target,
-                    license_path)
+                self.orm_wrapper.update_target_set_license_manifest(
+                    image_target, license_path)

             # scan the directory for image files relating to this build
             # (via real_image_name); note that we don't have to set
@@ -1675,7 +1666,7 @@ class BuildInfoHelper(object):

             for image_file in image_files:
                 self.orm_wrapper.save_target_image_file_information(
-                    target, image_file['path'], image_file['size'])
+                    image_target, image_file['path'], image_file['size'])

             if not has_files:
                 # copy image files and build artifacts from the
@@ -1683,13 +1674,115 @@ class BuildInfoHelper(object):
                 # same target + machine as this Target; also copy the license
                 # manifest path, as that is not treated as an artifact and needs
                 # to be set separately
-                most_recent = \
-                    self.orm_wrapper.get_similar_target_with_image_files(target)
+                similar_target = \
+                    self.orm_wrapper.get_similar_target_with_image_files(
+                        image_target)

-                if most_recent:
+                if similar_target:
                     logger.info('image artifacts for target %s cloned from ' \
-                        'target %s' % (target.pk, most_recent.pk))
-                    target.clone_artifacts_from(most_recent)
+                        'target %s' % (image_target.pk, similar_target.pk))
+                    self.orm_wrapper.clone_image_artifacts(similar_target,
+                        image_target)
+
+    def _get_sdk_targets(self):
+        """
+        Return targets which could generate SDK artifacts, i.e.
+        "do_populate_sdk" and "do_populate_sdk_ext".
+        """
+        return [target for target in self.internal_state['targets'] \
+            if target.task in ['populate_sdk', 'populate_sdk_ext']]
+
+    def scan_sdk_artifacts(self, event):
+        """
+        Note that we have to intercept an SDKArtifactInfo event from
+        toaster.bbclass (via toasterui) to get hold of the SDK variables we
+        need to be able to scan for files accurately: this is because
+        variables like TOOLCHAIN_OUTPUTNAME have reset to None by the time
+        BuildCompleted is fired by bitbake, so we have to get those values
+        while the build is still in progress.
+
+        For populate_sdk_ext, this runs twice, with two different
+        TOOLCHAIN_OUTPUTNAME settings, each of which will capture some of the
+        files in the SDK output directory.
+        """
+        sdk_vars = BuildInfoHelper._get_data_from_event(event)
+        toolchain_outputname = sdk_vars['TOOLCHAIN_OUTPUTNAME']
+
+        # targets which might have created SDK artifacts
+        sdk_targets = self._get_sdk_targets()
+
+        # location of SDK artifacts
+        tmpdir = self.server.runCommand(['getVariable', 'TMPDIR'])[0]
+        sdk_dir = os.path.join(tmpdir, 'deploy', 'sdk')
+
+        # all files in the SDK directory
+        artifacts = []
+        for dir_path, _, filenames in os.walk(sdk_dir):
+            for filename in filenames:
+                full_path = os.path.join(dir_path, filename)
+                if not os.path.islink(full_path):
+                    artifacts.append(full_path)
+
+        for sdk_target in sdk_targets:
+            # find files in the SDK directory which haven't already been
+            # recorded against a Target and whose basename matches
+            # TOOLCHAIN_OUTPUTNAME
+            for artifact_path in artifacts:
+                basename = os.path.basename(artifact_path)
+
+                toolchain_match = basename.startswith(toolchain_outputname)
+
+                # files which match the name of the target which produced them;
+                # for example,
+                # poky-glibc-x86_64-core-image-sato-i586-toolchain-ext-2.1+snapshot.sh
+                target_match = re.search(sdk_target.target, basename)
+
+                # targets which produce "*-nativesdk-*" files
+                is_ext_sdk_target = sdk_target.task in \
+                    ['do_populate_sdk_ext', 'populate_sdk_ext']
+
+                # SDK files which don't match the target name, i.e.
+                # x86_64-nativesdk-libc.*
+                # poky-glibc-x86_64-buildtools-tarball-i586-buildtools-nativesdk-standalone-2.1+snapshot*
+                is_ext_sdk_file = re.search('-nativesdk-', basename)
+
+                file_from_target = (toolchain_match and target_match) or \
+                    (is_ext_sdk_target and is_ext_sdk_file)
+
+                if file_from_target:
+                    # don't record the file if it's already been added to this
+                    # target
+                    matching_files = TargetSDKFile.objects.filter(
+                        target=sdk_target, file_name=artifact_path)
+
+                    if matching_files.count() == 0:
+                        artifact_size = os.stat(artifact_path).st_size
+
+                        self.orm_wrapper.save_target_sdk_file(
+                            sdk_target, artifact_path, artifact_size)
+
+    def clone_required_sdk_artifacts(self):
+        """
+        If an SDK target doesn't have any SDK artifacts, this means that
+        the postfuncs of populate_sdk or populate_sdk_ext didn't fire, which
+        in turn means that the targets of this build didn't generate any new
+        artifacts.
+
+        In this case, clone SDK artifacts for targets in the current build
+        from existing targets for this build.
+        """
+        sdk_targets = self._get_sdk_targets()
+        for sdk_target in sdk_targets:
+            # only clone for SDK targets which have no TargetSDKFiles yet
+            if sdk_target.targetsdkfile_set.all().count() == 0:
+                similar_target = \
+                    self.orm_wrapper.get_similar_target_with_sdk_files(
+                        sdk_target)
+                if similar_target:
+                    logger.info('SDK artifacts for target %s cloned from ' \
+                        'target %s' % (sdk_target.pk, similar_target.pk))
+                    self.orm_wrapper.clone_sdk_artifacts(similar_target,
+                        sdk_target)

     def close(self, errorcode):
         if self.brbe is not None:
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index d8bccdb..f399a7d 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -364,7 +364,8 @@ def main(server, eventHandler, params):
                     errorcode = 1
                     logger.error("Command execution failed: %s", event.error)
                 elif isinstance(event, bb.event.BuildCompleted):
-                    buildinfohelper.scan_build_artifacts()
+                    buildinfohelper.scan_image_artifacts()
+                    buildinfohelper.clone_required_sdk_artifacts()

                 # turn off logging to the current build log
                 _close_build_log(build_log)
@@ -412,8 +413,8 @@ def main(server, eventHandler, params):
                     buildinfohelper.store_target_package_data(event)
                 elif event.type == "MissedSstate":
                     buildinfohelper.store_missed_state_tasks(event)
-                elif event.type == "ArtifactFileSize":
-                    buildinfohelper.update_artifact_image_file(event)
+                elif event.type == "SDKArtifactInfo":
+                    buildinfohelper.scan_sdk_artifacts(event)
                 elif event.type == "SetBRBE":
                     buildinfohelper.brbe = buildinfohelper._get_data_from_event(event)
                 elif event.type == "OSErrorException":
diff --git a/lib/toaster/orm/migrations/0008_targetartifactfile.py b/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
similarity index 40%
rename from lib/toaster/orm/migrations/0008_targetartifactfile.py
rename to lib/toaster/orm/migrations/0008_refactor_artifact_models.py
index 9f1d9bf..3367582 100644
--- a/lib/toaster/orm/migrations/0008_targetartifactfile.py
+++ b/lib/toaster/orm/migrations/0008_refactor_artifact_models.py
@@ -12,12 +12,28 @@ class Migration(migrations.Migration):

     operations = [
         migrations.CreateModel(
-            name='TargetArtifactFile',
+            name='TargetKernelFile',
             fields=[
-                ('id', models.AutoField(primary_key=True, serialize=False, auto_created=True, verbose_name='ID')),
+                ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
                 ('file_name', models.FilePathField()),
                 ('file_size', models.IntegerField()),
                 ('target', models.ForeignKey(to='orm.Target')),
             ],
         ),
+        migrations.CreateModel(
+            name='TargetSDKFile',
+            fields=[
+                ('id', models.AutoField(auto_created=True, primary_key=True, verbose_name='ID', serialize=False)),
+                ('file_name', models.FilePathField()),
+                ('file_size', models.IntegerField()),
+                ('target', models.ForeignKey(to='orm.Target')),
+            ],
+        ),
+        migrations.RemoveField(
+            model_name='buildartifact',
+            name='build',
+        ),
+        migrations.DeleteModel(
+            name='BuildArtifact',
+        ),
     ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9edbef3..61f6a20 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -581,28 +581,6 @@ class Build(models.Model):
     def __str__(self):
         return "%d %s %s" % (self.id, self.project, ",".join([t.target for t in self.target_set.all()]))

-
-# an Artifact is anything that results from a Build, and may be of interest to the user, and is not stored elsewhere
-class BuildArtifact(models.Model):
-    build = models.ForeignKey(Build)
-    file_name = models.FilePathField()
-    file_size = models.IntegerField()
-
-    def get_local_file_name(self):
-        try:
-            deploydir = Variable.objects.get(build = self.build, variable_name="DEPLOY_DIR").variable_value
-            return  self.file_name[len(deploydir)+1:]
-        except:
-            raise
-
-        return self.file_name
-
-    def get_basename(self):
-        return os.path.basename(self.file_name)
-
-    def is_available(self):
-        return self.build.buildrequest.environment.has_artifact(self.file_name)
-
 class ProjectTarget(models.Model):
     project = models.ForeignKey(Project)
     target = models.CharField(max_length=100)
@@ -625,13 +603,19 @@ class Target(models.Model):

     def get_similar_targets(self):
         """
-        Get targets for the same machine, task and target name
+        Get target sfor the same machine, task and target name
         (e.g. 'core-image-minimal') from a successful build for this project
         (but excluding this target).

-        Note that we look for targets built by this project because projects
-        can have different configurations from each other, and put their
-        artifacts in different directories.
+        Note that we only look for targets built by this project because
+        projects can have different configurations from each other, and put
+        their artifacts in different directories.
+
+        The possibility of error when retrieving candidate targets
+        is minimised by the fact that bitbake will rebuild artifacts if MACHINE
+        (or various other variables) change. In this case, there is no need to
+        clone artifacts from another target, as those artifacts will have
+        been re-generated for this target anyway.
         """
         query = ~Q(pk=self.pk) & \
             Q(target=self.target) & \
@@ -649,29 +633,54 @@ class Target(models.Model):
         similar_target = None

         candidates = self.get_similar_targets()
-        if candidates.count() < 1:
+        if candidates.count() == 0:
             return similar_target

         task_subquery = Q(task=self.task)

         # we can look for a 'build' task if this task is a 'populate_sdk_ext'
-        # task, as it will have created images; and vice versa; note that
+        # task, as the latter also creates images; and vice versa; note that
         # 'build' targets can have their task set to '';
         # also note that 'populate_sdk' does not produce image files
         image_tasks = [
             '', # aka 'build'
             'build',
+            'image',
             'populate_sdk_ext'
         ]
         if self.task in image_tasks:
             task_subquery = Q(task__in=image_tasks)

+        # annotate with the count of files, to exclude any targets which
+        # don't have associated files
+        candidates = candidates.annotate(num_files=Count('target_image_file'))
+
         query = task_subquery & Q(num_files__gt=0)

+        candidates = candidates.filter(query)
+
+        if candidates.count() > 0:
+            candidates.order_by('build__completed_on')
+            similar_target = candidates.last()
+
+        return similar_target
+
+    def get_similar_target_with_sdk_files(self):
+        """
+        Get the most recent similar target with TargetSDKFiles associated
+        with it, for the purpose of cloning those files onto this target.
+        """
+        similar_target = None
+
+        candidates = self.get_similar_targets()
+        if candidates.count() == 0:
+            return similar_target
+
         # annotate with the count of files, to exclude any targets which
         # don't have associated files
-        candidates = candidates.annotate(
-            num_files=Count('target_image_file'))
+        candidates = candidates.annotate(num_files=Count('targetsdkfile'))
+
+        query = Q(task=self.task) & Q(num_files__gt=0)

         candidates = candidates.filter(query)

@@ -681,11 +690,10 @@ class Target(models.Model):

         return similar_target

-    def clone_artifacts_from(self, target):
+    def clone_image_artifacts_from(self, target):
         """
-        Make clones of the BuildArtifacts, Target_Image_Files and
-        TargetArtifactFile objects associated with Target target, then
-        associate them with this target.
+        Make clones of the Target_Image_Files and TargetKernelFile objects
+        associated with Target target, then associate them with this target.

         Note that for Target_Image_Files, we only want files from the previous
         build whose suffix matches one of the suffixes defined in this
@@ -711,18 +719,38 @@ class Target(models.Model):
             image_file.target = self
             image_file.save()

-        artifact_files = target.targetartifactfile_set.all()
-        for artifact_file in artifact_files:
-            artifact_file.pk = None
-            artifact_file.target = self
-            artifact_file.save()
+        kernel_files = target.targetkernelfile_set.all()
+        for kernel_file in kernel_files:
+            kernel_file.pk = None
+            kernel_file.target = self
+            kernel_file.save()

         self.license_manifest_path = target.license_manifest_path
         self.save()

-# an Artifact is anything that results from a target being built, and may
-# be of interest to the user, and is not an image file
-class TargetArtifactFile(models.Model):
+    def clone_sdk_artifacts_from(self, target):
+        """
+        Clone TargetSDKFile objects from target and associate them with this
+        target.
+        """
+        sdk_files = target.targetsdkfile_set.all()
+        for sdk_file in sdk_files:
+            sdk_file.pk = None
+            sdk_file.target = self
+            sdk_file.save()
+
+# kernel artifacts for a target: bzImage and modules*
+class TargetKernelFile(models.Model):
+    target = models.ForeignKey(Target)
+    file_name = models.FilePathField()
+    file_size = models.IntegerField()
+
+    @property
+    def basename(self):
+        return os.path.basename(self.file_name)
+
+# SDK artifacts for a target: sh and manifest files
+class TargetSDKFile(models.Model):
     target = models.ForeignKey(Target)
     file_name = models.FilePathField()
     file_size = models.IntegerField()
diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index f6d62b9..e1bde21 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -80,29 +80,30 @@
             <dd><a href="{% url 'target' build.pk target.target.pk %}">{{target.npkg}}</a></dd>
             <dt>Total package size</dt>
             <dd>{{target.pkgsz|filtered_filesizeformat}}</dd>
-                        {% if target.targetHasNoImages %}
-                </dl>
-                <div class="row">
-                  <div class="col-md-7">
-                    <div class="alert alert-info">
-                      <p>
-                      <strong>This build did not create any image files</strong>
-                      </p>
-                      <p>
-                      This is probably because valid image and license manifest
-                      files from a previous build already exist in your
-                      <code>build/tmp/deploy</code>
-                      directory. You can
-                      also <a href="{% url 'target' build.pk target.target.pk %}">view the
-                        license manifest information</a> in Toaster.
-                      </p>
-                    </div>
-                  </div>
+        </dl>
+        {% if target.targetHasNoImages %}
+            <div class="row">
+              <div class="col-md-7">
+                <div class="alert alert-info">
+                  <p>
+                  <strong>This build did not create any image files</strong>
+                  </p>
+                  <p>
+                  This is probably because valid image and license manifest
+                  files from a previous build already exist in your
+                  <code>build/tmp/deploy</code>
+                  directory. You can
+                  also <a href="{% url 'target' build.pk target.target.pk %}">view the
+                    license manifest information</a> in Toaster.
+                  </p>
                 </div>
-        {% else %}
+              </div>
+            </div>
+        {% endif %}
+        {% if not target.targetHasNoImages %}
+          <dl class="dl-horizontal">
             <dt>
                 <span class="glyphicon glyphicon-question-sign get-help" title="The location in disk of the license manifest, a document listing all packages installed in your image and their licenses"></span>
-
                 License manifest
             </dt>
             <dd>
@@ -129,15 +130,32 @@
             </dt>
             <dd>
                 <ul class="list-unstyled">
-                    {% for artifact in target.target_artifacts|dictsort:"basename" %}
+                    {% for artifact in target.target_kernel_artifacts|dictsort:"basename" %}
                         <li>
-                            <a href="{% url 'build_artifact' build.id 'targetartifactfile' artifact.id %}">{{artifact.basename}}</a>
+                            <a href="{% url 'build_artifact' build.id 'targetkernelartifact' artifact.id %}">{{artifact.basename}}</a>
                             ({{artifact.file_size|filtered_filesizeformat}})
                         </li>
                     {% endfor %}
                   </ul>
             </dd>
-        </dl>
+          </dl>
+        {% endif %}
+        {% if target.target_sdk_artifacts_count > 0 %}
+          <dl class="dl-horizontal">
+            <dt>
+              SDK artifacts
+            </dt>
+            <dd>
+              <ul class="list-unstyled">
+                {% for artifact in target.target_sdk_artifacts|dictsort:"basename" %}
+                <li>
+                  <a href="{% url 'build_artifact' build.id 'targetsdkartifact' artifact.id %}">{{artifact.basename}}</a>
+                  ({{artifact.file_size|filtered_filesizeformat}})
+                </li>
+                {% endfor %}
+              </ul>
+            </dd>
+          </dl>
         {% endif %}
     </div>
         {% endif %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 0ec88d9..a82a261 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -30,8 +30,8 @@ from django.db import IntegrityError, Error
 from django.shortcuts import render, redirect, get_object_or_404
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact, CustomImagePackage
-from orm.models import TargetArtifactFile
+from orm.models import Target_Installed_Package, Target_File, Target_Image_File, CustomImagePackage
+from orm.models import TargetKernelFile, TargetSDKFile
 from orm.models import BitbakeVersion, CustomImageRecipe
 from bldcontrol import bbcontroller
 from django.views.decorators.cache import cache_control
@@ -510,7 +510,11 @@ def builddashboard( request, build_id ):
             targetHasNoImages = True
         elem[ 'imageFiles' ] = imageFiles
         elem[ 'targetHasNoImages' ] = targetHasNoImages
-        elem['target_artifacts'] = t.targetartifactfile_set.all()
+        elem['target_kernel_artifacts'] = t.targetkernelfile_set.all()
+
+        target_sdk_files = t.targetsdkfile_set.all()
+        elem['target_sdk_artifacts_count'] = target_sdk_files.count()
+        elem['target_sdk_artifacts'] = target_sdk_files

         targets.append( elem )

@@ -2294,11 +2298,12 @@ if True:
         elif artifact_type == "imagefile":
             file_name = Target_Image_File.objects.get(target__build = build, pk = artifact_id).file_name

-        elif artifact_type == "buildartifact":
-            file_name = BuildArtifact.objects.get(build = build, pk = artifact_id).file_name
+        elif artifact_type == "targetkernelartifact":
+            target = TargetKernelFile.objects.get(pk=artifact_id)
+            file_name = target.file_name

-        elif artifact_type == "targetartifactfile":
-            target = TargetArtifactFile.objects.get(pk=artifact_id)
+        elif artifact_type == "targetsdkartifact":
+            target = TargetSDKFile.objects.get(pk=artifact_id)
             file_name = target.file_name

         elif artifact_type == "licensemanifest":
--
1.9.1

