Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E5EA979249
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Aug 2018 01:07:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7G17YPL005890
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2018 18:07:35 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.399.0; Wed, 15 Aug 2018 18:07:33 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2018 18:04:09 -0700
Message-ID: <f0271eddedecb326a2dd36312b69abcba85f7898.1534381261.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1534381261.git.David.Reyna@windriver.com>
References: <cover.1534381261.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
X-Mailman-Approved-At: Thu, 16 Aug 2018 09:17:41 +0000
Subject: [PATCH 1/1] Toaster: Implement the project-specific feature and releated enhancements and defects.
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
X-List-Received-Date: Thu, 16 Aug 2018 01:07:34 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Here is the primary driving enhancement:

*  Bug 12785 - Support Project Specific configuration for external
   tools (e.g. ISS, Eclipse)

  -  Isolated project-specific configuration page (full Toaster context
     hidden)
  -  Support for new project, reconfigure existing project, and import
     existing command line project
  -  Ability to define variables (e.g. image recipe) and pass them back
     to external GUI
  -  Ability to execute the cloning phase, so that external GUI receive
     a buildable project
  -  Ability to call back to the external GUI when updates are completed
     and ready
  -  Compatibility of above projects with the normal full Toaster interface
  -  Ability to pass to a 'complete' or 'cancel' web page so that the
     external GUI can immediately stop that Toaster instance, and not
     leave dangling servers nor edit sessions open

Here are the supporting enhancements, where at least the
back end is implemented:

*  Bug 12821 - Make Toaster conf changes compatible with command line usage
*  Bug 12822 - Support importing user changes to conf files into Toaster
*  Bug 12823 - Support importing user build directories into Toaster
*  Bug 12824 - Scan imported layers for content so that they are
               immediately available
*  Bug 12825 - show layer clone item in progress bar

Here are defects fixed:

*  Bug 12817 - builddelete.py requires explicit 'add_arguments'
*  Bug 12818 - Remove orphaned imported layers when project is deleted
*  Bug 12826 - fix imported layer management
*  Bug 12819 - build using selected bitbake env, not Toaster's env
*  Bug 12820 - Toaster randomizes the layer order in toaster_bblayers.conf

[YOCTO #12785]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py    | 172 ++++--
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 .../orm/migrations/0018_project_specific.py        |  28 +
 lib/toaster/orm/models.py                          |  61 ++-
 lib/toaster/toastergui/api.py                      | 168 +++++-
 lib/toaster/toastergui/static/js/layerBtn.js       |  12 +
 lib/toaster/toastergui/static/js/libtoaster.js     | 105 ++++
 lib/toaster/toastergui/static/js/mrbsection.js     |   4 +-
 lib/toaster/toastergui/static/js/projecttopbar.js  |  22 +
 lib/toaster/toastergui/tables.py                   |   4 +
 .../toastergui/templates/base_specific.html        | 128 +++++
 .../templates/baseprojectspecificpage.html         |  48 ++
 .../templates/generic-toastertable-page.html       |   2 +-
 lib/toaster/toastergui/templates/importlayer.html  |   4 +-
 .../toastergui/templates/landing_specific.html     |  50 ++
 lib/toaster/toastergui/templates/layerdetails.html |   3 +-
 lib/toaster/toastergui/templates/mrb_section.html  |   2 +-
 .../toastergui/templates/newcustomimage.html       |   4 +-
 .../toastergui/templates/newproject_specific.html  |  95 ++++
 lib/toaster/toastergui/templates/project.html      |   7 +-
 .../toastergui/templates/project_specific.html     | 162 ++++++
 .../templates/project_specific_topbar.html         |  80 +++
 lib/toaster/toastergui/templates/projectconf.html  |   7 +-
 .../toastergui/templates/recipe_add_btn.html       |  23 +
 lib/toaster/toastergui/urls.py                     |  13 +
 lib/toaster/toastergui/views.py                    | 151 ++++++
 lib/toaster/toastergui/widgets.py                  |   6 +
 .../toastermain/management/commands/builddelete.py |   6 +-
 .../toastermain/management/commands/buildimport.py | 586 +++++++++++++++++++++
 29 files changed, 1900 insertions(+), 55 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0018_project_specific.py
 create mode 100644 bitbake/lib/toaster/toastergui/templates/base_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/baseprojectspecificpage.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/landing_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/newproject_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/project_specific.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/project_specific_topbar.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/recipe_add_btn.html
 mode change 100755 => 100644 bitbake/lib/toaster/toastergui/views.py
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/buildimport.py

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 16c7c80..6bdd743 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -27,8 +27,9 @@ import shutil
 import time
 from django.db import transaction
 from django.db.models import Q
-from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
-from orm.models import CustomImageRecipe, Layer, Layer_Version, ProjectLayer, ToasterSetting
+from bldcontrol.models import BuildEnvironment, BuildRequest, BRLayer, BRVariable, BRTarget, BRBitbake, Build
+from orm.models import CustomImageRecipe, Layer, Layer_Version, Project, ProjectLayer, ToasterSetting
+from orm.models import signal_runbuilds
 import subprocess
 
 from toastermain import settings
@@ -38,6 +39,8 @@ from bldcontrol.bbcontroller import BuildEnvironmentController, ShellCmdExceptio
 import logging
 logger = logging.getLogger("toaster")
 
+install_dir = os.environ.get('TOASTER_DIR')
+
 from pprint import pprint, pformat
 
 class LocalhostBEController(BuildEnvironmentController):
@@ -87,10 +90,10 @@ class LocalhostBEController(BuildEnvironmentController):
         #logger.debug("localhostbecontroller: using HEAD checkout in %s" % local_checkout_path)
         return local_checkout_path
 
-
-    def setCloneStatus(self,bitbake,status,total,current):
+    def setCloneStatus(self,bitbake,status,total,current,repo_name):
         bitbake.req.build.repos_cloned=current
         bitbake.req.build.repos_to_clone=total
+        bitbake.req.build.progress_item=repo_name
         bitbake.req.build.save()
 
     def setLayers(self, bitbake, layers, targets):
@@ -100,6 +103,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         layerlist = []
         nongitlayerlist = []
+        layer_index = 0
         git_env = os.environ.copy()
         # (note: add custom environment settings here)
 
@@ -113,7 +117,7 @@ class LocalhostBEController(BuildEnvironmentController):
         if bitbake.giturl and bitbake.commit:
             gitrepos[(bitbake.giturl, bitbake.commit)] = []
             gitrepos[(bitbake.giturl, bitbake.commit)].append(
-                ("bitbake", bitbake.dirpath))
+                ("bitbake", bitbake.dirpath, 0))
 
         for layer in layers:
             # We don't need to git clone the layer for the CustomImageRecipe
@@ -124,12 +128,13 @@ class LocalhostBEController(BuildEnvironmentController):
             # If we have local layers then we don't need clone them
             # For local layers giturl will be empty
             if not layer.giturl:
-                nongitlayerlist.append(layer.layer_version.layer.local_source_dir)
+                nongitlayerlist.append( "%03d:%s" % (layer_index,layer.local_source_dir) )
                 continue
 
             if not (layer.giturl, layer.commit) in gitrepos:
                 gitrepos[(layer.giturl, layer.commit)] = []
-            gitrepos[(layer.giturl, layer.commit)].append( (layer.name, layer.dirpath) )
+            gitrepos[(layer.giturl, layer.commit)].append( (layer.name,layer.dirpath,layer_index) )
+            layer_index += 1
 
 
         logger.debug("localhostbecontroller, our git repos are %s" % pformat(gitrepos))
@@ -159,9 +164,9 @@ class LocalhostBEController(BuildEnvironmentController):
         # 3. checkout the repositories
         clone_count=0
         clone_total=len(gitrepos.keys())
-        self.setCloneStatus(bitbake,'Started',clone_total,clone_count)
+        self.setCloneStatus(bitbake,'Started',clone_total,clone_count,'')
         for giturl, commit in gitrepos.keys():
-            self.setCloneStatus(bitbake,'progress',clone_total,clone_count)
+            self.setCloneStatus(bitbake,'progress',clone_total,clone_count,gitrepos[(giturl, commit)][0][0])
             clone_count += 1
 
             localdirname = os.path.join(self.be.sourcedir, self.getGitCloneDirectory(giturl, commit))
@@ -205,16 +210,16 @@ class LocalhostBEController(BuildEnvironmentController):
                     self._shellcmd("git clone -b \"%s\" \"%s\" \"%s\" " % (bitbake.commit, bitbake.giturl, os.path.join(self.pokydirname, 'bitbake')),env=git_env)
 
             # verify our repositories
-            for name, dirpath in gitrepos[(giturl, commit)]:
+            for name, dirpath, index in gitrepos[(giturl, commit)]:
                 localdirpath = os.path.join(localdirname, dirpath)
-                logger.debug("localhostbecontroller: localdirpath expected '%s'" % localdirpath)
+                logger.debug("localhostbecontroller: localdirpath expects '%s'" % localdirpath)
                 if not os.path.exists(localdirpath):
                     raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
 
                 if name != "bitbake":
-                    layerlist.append(localdirpath.rstrip("/"))
+                    layerlist.append("%03d:%s" % (index,localdirpath.rstrip("/")))
 
-        self.setCloneStatus(bitbake,'complete',clone_total,clone_count)
+        self.setCloneStatus(bitbake,'complete',clone_total,clone_count,'')
         logger.debug("localhostbecontroller: current layer list %s " % pformat(layerlist))
 
         if self.pokydirname is None and os.path.exists(os.path.join(self.be.sourcedir, "oe-init-build-env")):
@@ -232,7 +237,7 @@ class LocalhostBEController(BuildEnvironmentController):
                     customrecipe, layers)
 
                 if os.path.isdir(custom_layer_path):
-                    layerlist.append(custom_layer_path)
+                    layerlist.append("%03d:%s" % (layer_index,custom_layer_path))
 
             except CustomImageRecipe.DoesNotExist:
                 continue  # not a custom recipe, skip
@@ -240,7 +245,11 @@ class LocalhostBEController(BuildEnvironmentController):
         layerlist.extend(nongitlayerlist)
         logger.debug("\n\nset layers gives this list %s" % pformat(layerlist))
         self.islayerset = True
-        return layerlist
+
+        # restore the order of layer list for bblayers.conf
+        layerlist.sort()
+        sorted_layerlist = [l[4:] for l in layerlist]
+        return sorted_layerlist
 
     def setup_custom_image_recipe(self, customrecipe, layers):
         """ Set up toaster-custom-images layer and recipe files """
@@ -310,31 +319,115 @@ class LocalhostBEController(BuildEnvironmentController):
 
     def triggerBuild(self, bitbake, layers, variables, targets, brbe):
         layers = self.setLayers(bitbake, layers, targets)
+        is_merged_attr = bitbake.req.project.merged_attr
+
+        git_env = os.environ.copy()
+        # (note: add custom environment settings here)
+        try:
+            # insure that the project init/build uses the selected bitbake, and not Toaster's
+            del git_env['TEMPLATECONF']
+            del git_env['BBBASEDIR']
+            del git_env['BUILDDIR']
+        except KeyError:
+            pass
 
         # init build environment from the clone
-        builddir = '%s-toaster-%d' % (self.be.builddir, bitbake.req.project.id)
+        if bitbake.req.project.builddir:
+            builddir = bitbake.req.project.builddir
+        else:
+            builddir = '%s-toaster-%d' % (self.be.builddir, bitbake.req.project.id)
         oe_init = os.path.join(self.pokydirname, 'oe-init-build-env')
         # init build environment
         try:
             custom_script = ToasterSetting.objects.get(name="CUSTOM_BUILD_INIT_SCRIPT").value
             custom_script = custom_script.replace("%BUILDDIR%" ,builddir)
-            self._shellcmd("bash -c 'source %s'" % (custom_script))
+            self._shellcmd("bash -c 'source %s'" % (custom_script),env=git_env)
         except ToasterSetting.DoesNotExist:
             self._shellcmd("bash -c 'source %s %s'" % (oe_init, builddir),
-                       self.be.sourcedir)
+                       self.be.sourcedir,env=git_env)
 
         # update bblayers.conf
-        bblconfpath = os.path.join(builddir, "conf/toaster-bblayers.conf")
-        with open(bblconfpath, 'w') as bblayers:
-            bblayers.write('# line added by toaster build control\n'
-                           'BBLAYERS = "%s"' % ' '.join(layers))
-
-        # write configuration file
-        confpath = os.path.join(builddir, 'conf/toaster.conf')
-        with open(confpath, 'w') as conf:
-            for var in variables:
-                conf.write('%s="%s"\n' % (var.name, var.value))
-            conf.write('INHERIT+="toaster buildhistory"')
+        if not is_merged_attr:
+            bblconfpath = os.path.join(builddir, "conf/toaster-bblayers.conf")
+            with open(bblconfpath, 'w') as bblayers:
+                bblayers.write('# line added by toaster build control\n'
+                               'BBLAYERS = "%s"' % ' '.join(layers))
+
+            # write configuration file
+            confpath = os.path.join(builddir, 'conf/toaster.conf')
+            with open(confpath, 'w') as conf:
+                for var in variables:
+                    conf.write('%s="%s"\n' % (var.name, var.value))
+                conf.write('INHERIT+="toaster buildhistory"')
+        else:
+            # Append the Toaster-specific values directly to the bblayers.conf
+            bblconfpath = os.path.join(bitbake.req.project.builddir, "conf/bblayers.conf")
+            bblconfpath_save = os.path.join(bitbake.req.project.builddir, "conf/bblayers.conf.save")
+            shutil.copyfile(bblconfpath, bblconfpath_save)
+            with open(bblconfpath) as bblayers:
+                content = bblayers.readlines()
+            do_write = True
+            was_toaster = False
+            with open(bblconfpath,'w') as bblayers:
+                for line in content:
+                    #line = line.strip('\n')
+                    if 'TOASTER_CONFIG_PROLOG' in line:
+                        do_write = False
+                        was_toaster = True
+                    elif 'TOASTER_CONFIG_EPILOG' in line:
+                        do_write = True
+                    elif do_write:
+                        bblayers.write(line)
+                if not was_toaster:
+                    bblayers.write('\n')
+                bblayers.write('#=== TOASTER_CONFIG_PROLOG ===\n')
+                bblayers.write('BBLAYERS = "\\\n')
+                for layer in layers:
+                    bblayers.write('  %s \\\n' % layer)
+                bblayers.write('  "\n')
+                bblayers.write('#=== TOASTER_CONFIG_EPILOG ===\n')
+            # Append the Toaster-specific values directly to the local.conf
+            bbconfpath = os.path.join(bitbake.req.project.builddir, "conf/local.conf")
+            bbconfpath_save = os.path.join(bitbake.req.project.builddir, "conf/local.conf.save")
+            shutil.copyfile(bbconfpath, bbconfpath_save)
+            with open(bbconfpath) as f:
+                content = f.readlines()
+            do_write = True
+            was_toaster = False
+            with open(bbconfpath,'w') as conf:
+                for line in content:
+                    #line = line.strip('\n')
+                    if 'TOASTER_CONFIG_PROLOG' in line:
+                        do_write = False
+                        was_toaster = True
+                    elif 'TOASTER_CONFIG_EPILOG' in line:
+                        do_write = True
+                    elif do_write:
+                        conf.write(line)
+                if not was_toaster:
+                    conf.write('\n')
+                conf.write('#=== TOASTER_CONFIG_PROLOG ===\n')
+                for var in variables:
+                    if (not var.name.startswith("INTERNAL_")) and (not var.name == "BBLAYERS"):
+                        conf.write('%s="%s"\n' % (var.name, var.value))
+                conf.write('#=== TOASTER_CONFIG_EPILOG ===\n')
+
+        # If 'target' is just the project preparation target, then we are done
+        for target in targets:
+            if "_PROJECT_PREPARE_" == target.target:
+                logger.debug('localhostbecontroller: Project has been prepared. Done.')
+                # Update the Build Request and release the build environment
+                bitbake.req.state = BuildRequest.REQ_COMPLETED
+                bitbake.req.save()
+                self.be.lock = BuildEnvironment.LOCK_FREE
+                self.be.save()
+                # Close the project build and progress bar
+                bitbake.req.build.outcome = Build.SUCCEEDED
+                bitbake.req.build.save()
+                # Update the project status
+                bitbake.req.project.set_variable(Project.PROJECT_SPECIFIC_STATUS,Project.PROJECT_SPECIFIC_CLONING_SUCCESS)
+                signal_runbuilds()
+                return
 
         # clean the Toaster to build environment
         env_clean = 'unset BBPATH;' # clean BBPATH for <= YP-2.4.0
@@ -342,9 +435,14 @@ class LocalhostBEController(BuildEnvironmentController):
         # run bitbake server from the clone
         bitbake = os.path.join(self.pokydirname, 'bitbake', 'bin', 'bitbake')
         toasterlayers = os.path.join(builddir,"conf/toaster-bblayers.conf")
-        self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
-                       '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_init,
-                       builddir, bitbake, confpath, toasterlayers), self.be.sourcedir)
+        if not is_merged_attr:
+            self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s --read %s --read %s '
+                           '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_init,
+                           builddir, bitbake, confpath, toasterlayers), self.be.sourcedir)
+        else:
+            self._shellcmd('%s bash -c \"source %s %s; BITBAKE_UI="knotty" %s '
+                           '--server-only -B 0.0.0.0:0\"' % (env_clean, oe_init,
+                           builddir, bitbake), self.be.sourcedir)
 
         # read port number from bitbake.lock
         self.be.bbport = -1
@@ -390,12 +488,20 @@ class LocalhostBEController(BuildEnvironmentController):
         log = os.path.join(builddir, 'toaster_ui.log')
         local_bitbake = os.path.join(os.path.dirname(os.getenv('BBBASEDIR')),
                                      'bitbake')
-        self._shellcmd(['%s bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
+        if not is_merged_attr:
+            self._shellcmd(['%s bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
                         '%s %s -u toasterui  --read %s --read %s --token="" >>%s 2>&1;'
                         'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:%s %s -m)&\"' \
                         % (env_clean, brbe, self.be.bbport, local_bitbake, bbtargets, confpath, toasterlayers, log,
                         self.be.bbport, bitbake,)],
                         builddir, nowait=True)
+        else:
+            self._shellcmd(['%s bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
+                        '%s %s -u toasterui  --token="" >>%s 2>&1;'
+                        'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:%s %s -m)&\"' \
+                        % (env_clean, brbe, self.be.bbport, local_bitbake, bbtargets, log,
+                        self.be.bbport, bitbake,)],
+                        builddir, nowait=True)
 
         logger.debug('localhostbecontroller: Build launched, exiting. '
                      'Follow build logs at %s' % log)
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 791e53e..6a55dd4 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -49,7 +49,7 @@ class Command(BaseCommand):
                 # we could not find a BEC; postpone the BR
                 br.state = BuildRequest.REQ_QUEUED
                 br.save()
-                logger.debug("runbuilds: No build env")
+                logger.debug("runbuilds: No build env (%s)" % e)
                 return
 
             logger.info("runbuilds: starting build %s, environment %s" %
diff --git a/lib/toaster/orm/migrations/0018_project_specific.py b/lib/toaster/orm/migrations/0018_project_specific.py
new file mode 100644
index 0000000..084ecad
--- /dev/null
+++ b/lib/toaster/orm/migrations/0018_project_specific.py
@@ -0,0 +1,28 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0017_distro_clone'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='Project',
+            name='builddir',
+            field=models.TextField(),
+        ),
+        migrations.AddField(
+            model_name='Project',
+            name='merged_attr',
+            field=models.BooleanField(default=False)
+        ),
+        migrations.AddField(
+            model_name='Build',
+            name='progress_item',
+            field=models.CharField(max_length=40)
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3a7dff8..306c4fa 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -121,8 +121,15 @@ class ToasterSetting(models.Model):
 
 
 class ProjectManager(models.Manager):
-    def create_project(self, name, release):
-        if release is not None:
+    def create_project(self, name, release, existing_project=None):
+        if existing_project and (release is not None):
+            prj = existing_project
+            prj.bitbake_version = release.bitbake_version
+            prj.release = release
+            # Delete the previous ProjectLayer mappings
+            for pl in ProjectLayer.objects.filter(project=prj):
+                pl.delete()
+        elif release is not None:
             prj = self.model(name=name,
                              bitbake_version=release.bitbake_version,
                              release=release)
@@ -130,15 +137,14 @@ class ProjectManager(models.Manager):
             prj = self.model(name=name,
                              bitbake_version=None,
                              release=None)
-
         prj.save()
 
         for defaultconf in ToasterSetting.objects.filter(
                 name__startswith="DEFCONF_"):
             name = defaultconf.name[8:]
-            ProjectVariable.objects.create(project=prj,
-                                           name=name,
-                                           value=defaultconf.value)
+            pv,create = ProjectVariable.objects.get_or_create(project=prj,name=name)
+            pv.value = defaultconf.value
+            pv.save()
 
         if release is None:
             return prj
@@ -197,6 +203,11 @@ class Project(models.Model):
     user_id = models.IntegerField(null=True)
     objects = ProjectManager()
 
+    # build directory override (e.g. imported)
+    builddir = models.TextField()
+    # merge the Toaster configure attributes directly into the standard conf files
+    merged_attr = models.BooleanField(default=False)
+
     # set to True for the project which is the default container
     # for builds initiated by the command line etc.
     is_default= models.BooleanField(default=False)
@@ -305,6 +316,15 @@ class Project(models.Model):
             return layer_versions
 
 
+    def get_default_image_recipe(self):
+        try:
+            return self.projectvariable_set.get(name="DEFAULT_IMAGE").value
+        except (ProjectVariable.DoesNotExist,IndexError):
+            return None;
+
+    def get_is_new(self):
+        return self.get_variable(Project.PROJECT_SPECIFIC_ISNEW)
+
     def get_available_machines(self):
         """ Returns QuerySet of all Machines which are provided by the
         Layers currently added to the Project """
@@ -353,6 +373,32 @@ class Project(models.Model):
 
         return queryset
 
+    # Project Specific status management
+    PROJECT_SPECIFIC_STATUS = 'INTERNAL_PROJECT_SPECIFIC_STATUS'
+    PROJECT_SPECIFIC_CALLBACK = 'INTERNAL_PROJECT_SPECIFIC_CALLBACK'
+    PROJECT_SPECIFIC_ISNEW = 'INTERNAL_PROJECT_SPECIFIC_ISNEW'
+    PROJECT_SPECIFIC_DEFAULTIMAGE = 'PROJECT_SPECIFIC_DEFAULTIMAGE'
+    PROJECT_SPECIFIC_NONE = ''
+    PROJECT_SPECIFIC_NEW = '1'
+    PROJECT_SPECIFIC_EDIT = '2'
+    PROJECT_SPECIFIC_CLONING = '3'
+    PROJECT_SPECIFIC_CLONING_SUCCESS = '4'
+    PROJECT_SPECIFIC_CLONING_FAIL = '5'
+
+    def get_variable(self,variable,default_value = ''):
+        try:
+            return self.projectvariable_set.get(name=variable).value
+        except (ProjectVariable.DoesNotExist,IndexError):
+            return default_value
+
+    def set_variable(self,variable,value):
+        pv,create = ProjectVariable.objects.get_or_create(project = self, name = variable)
+        pv.value = value
+        pv.save()
+
+    def get_default_image(self):
+        return self.get_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE)
+
     def schedule_build(self):
 
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer
@@ -459,6 +505,9 @@ class Build(models.Model):
     # number of repos cloned so far for this build (default off)
     repos_cloned = models.IntegerField(default=1)
 
+    # Hint on current progress item
+    progress_item = models.CharField(max_length=40)
+
     @staticmethod
     def get_recent(project=None):
         """
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index ab6ba69..1bec56d 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -22,7 +22,9 @@ import os
 import re
 import logging
 import json
+import subprocess
 from collections import Counter
+from shutil import copyfile
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
 from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
@@ -38,6 +40,18 @@ from django.core.urlresolvers import reverse
 from django.db.models import Q, F
 from django.db import Error
 from toastergui.templatetags.projecttags import filtered_filesizeformat
+from django.utils import timezone
+import pytz
+
+# development/debugging support
+verbose = 2
+def _log(msg):
+    if 1 == verbose:
+        print(msg)
+    elif 2 == verbose:
+        f1=open('/tmp/toaster.log', 'a')
+        f1.write("|" + msg + "|\n" )
+        f1.close()
 
 logger = logging.getLogger("toaster")
 
@@ -137,6 +151,130 @@ class XhrBuildRequest(View):
         return response
 
 
+class XhrProjectUpdate(View):
+
+    def get(self, request, *args, **kwargs):
+        return HttpResponse()
+
+    def post(self, request, *args, **kwargs):
+        """
+          Project Update
+
+          Entry point: /xhr_projectupdate/<project_id>
+          Method: POST
+
+          Args:
+              pid: pid of project to update
+
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
+
+        project = Project.objects.get(pk=kwargs['pid'])
+        logger.debug("ProjectUpdateCallback:project.pk=%d,project.builddir=%s" % (project.pk,project.builddir))
+
+        if 'do_update' in request.POST:
+
+            # Extract any default image recipe
+            if 'default_image' in request.POST:
+                project.set_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE,str(request.POST['default_image']))
+            else:
+                project.set_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE,'')
+
+            logger.debug("ProjectUpdateCallback:Chain to the build request")
+
+            # Chain to the build request
+            xhrBuildRequest = XhrBuildRequest()
+            return xhrBuildRequest.post(request, *args, **kwargs)
+
+        logger.warning("ERROR:XhrProjectUpdate")
+        response = HttpResponse()
+        response.status_code = 500
+        return response
+
+class XhrSetDefaultImageUrl(View):
+
+    def get(self, request, *args, **kwargs):
+        return HttpResponse()
+
+    def post(self, request, *args, **kwargs):
+        """
+          Project Update
+
+          Entry point: /xhr_setdefaultimage/<project_id>
+          Method: POST
+
+          Args:
+              pid: pid of project to update default image
+
+          Returns:
+              {"error": "ok"}
+            or
+              {"error": <error message>}
+        """
+
+        project = Project.objects.get(pk=kwargs['pid'])
+        logger.debug("XhrSetDefaultImageUrl:project.pk=%d" % (project.pk))
+
+        # set any default image recipe
+        if 'targets' in request.POST:
+            default_target = str(request.POST['targets'])
+            project.set_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE,default_target)
+            logger.debug("XhrSetDefaultImageUrl,project.pk=%d,project.builddir=%s" % (project.pk,project.builddir))
+            return error_response('ok')
+
+        logger.warning("ERROR:XhrSetDefaultImageUrl")
+        response = HttpResponse()
+        response.status_code = 500
+        return response
+
+
+#
+# Layer Management
+#
+# Rules for 'local_source_dir' layers
+#  * Layers must have a unique name in the Layers table
+#  * A 'local_source_dir' layer is supposed to be shared
+#    by all projects that use it, so that it can have the
+#    same logical name
+#  * Each project that uses a layer will have its own
+#    LayerVersion and Project Layer for it
+#  * During the Paroject delete process, when the last
+#    LayerVersion for a 'local_source_dir' layer is deleted
+#    then the Layer record is deleted to remove orphans
+#
+
+def scan_layer_content(layer,layer_version):
+    # if this is a local layer directory, we can immediately scan its content
+    if layer.local_source_dir:
+        try:
+            # recipes-*/*/*.bb
+            cmd = '%s %s' % ('ls', os.path.join(layer.local_source_dir,'recipes-*/*/*.bb'))
+            recipes_list = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,stderr=subprocess.STDOUT).stdout.read()
+            recipes_list = recipes_list.decode("utf-8").strip()
+            if recipes_list and 'No such' not in recipes_list:
+                for recipe in recipes_list.split('\n'):
+                    recipe_path = recipe[recipe.rfind('recipes-'):]
+                    recipe_name = recipe[recipe.rfind('/')+1:].replace('.bb','')
+                    recipe_ver = recipe_name.rfind('_')
+                    if recipe_ver > 0:
+                        recipe_name = recipe_name[0:recipe_ver]
+                    if recipe_name:
+                        ro, created = Recipe.objects.get_or_create(
+                            layer_version=layer_version,
+                            name=recipe_name
+                        )
+                        if created:
+                            ro.file_path = recipe_path
+                            ro.summary = 'Recipe %s from layer %s' % (recipe_name,layer.name)
+                            ro.description = ro.summary
+                        ro.save()
+
+        except Exception as e:
+            logger.warning("ERROR:scan_layer_content: %s" % e)
+
 class XhrLayer(View):
     """ Delete, Get, Add and Update Layer information
 
@@ -265,6 +403,7 @@ class XhrLayer(View):
             (csv)]
 
         """
+
         try:
             project = Project.objects.get(pk=kwargs['pid'])
 
@@ -285,7 +424,13 @@ class XhrLayer(View):
             if layer_data['name'] in existing_layers:
                 return JsonResponse({"error": "layer-name-exists"})
 
-            layer = Layer.objects.create(name=layer_data['name'])
+            if ('local_source_dir' in layer_data):
+                # Local layer can be shared across projects. They have no 'release'
+                # and are not included in get_all_compatible_layer_versions() above
+                layer,created = Layer.objects.get_or_create(name=layer_data['name'])
+                _log("Local Layer created=%s" % created)
+            else:
+                layer = Layer.objects.create(name=layer_data['name'])
 
             layer_version = Layer_Version.objects.create(
                 layer=layer,
@@ -293,7 +438,7 @@ class XhrLayer(View):
                 layer_source=LayerSource.TYPE_IMPORTED)
 
             # Local layer
-            if ('local_source_dir' in layer_data) and layer.local_source_dir:
+            if ('local_source_dir' in layer_data): ### and layer.local_source_dir:
                 layer.local_source_dir = layer_data['local_source_dir']
             # git layer
             elif 'vcs_url' in layer_data:
@@ -325,6 +470,9 @@ class XhrLayer(View):
                              'layerdetailurl':
                              layer_dep.get_detailspage_url(project.pk)})
 
+            # Scan the layer's content and update components
+            scan_layer_content(layer,layer_version)
+
         except Layer_Version.DoesNotExist:
             return error_response("layer-dep-not-found")
         except Project.DoesNotExist:
@@ -1014,8 +1162,24 @@ class XhrProject(View):
                     state=BuildRequest.REQ_INPROGRESS):
                 XhrBuildRequest.cancel_build(br)
 
+            # gather potential orphaned local layers attached to this project
+            project_local_layer_list = []
+            for pl in ProjectLayer.objects.filter(project=project):
+                if pl.layercommit.layer_source == LayerSource.TYPE_IMPORTED:
+                    project_local_layer_list.append(pl.layercommit.layer)
+
+            # deep delete the project and its dependencies
             project.delete()
 
+            # delete any local layers now orphaned
+            _log("LAYER_ORPHAN_CHECK:Check for orphaned layers")
+            for layer in project_local_layer_list:
+                layer_refs = Layer_Version.objects.filter(layer=layer)
+                _log("LAYER_ORPHAN_CHECK:Ref Count for '%s' = %d" % (layer.name,len(layer_refs)))
+                if 0 == len(layer_refs):
+                    _log("LAYER_ORPHAN_CHECK:DELETE orpahned '%s'" % (layer.name))
+                    Layer.objects.filter(pk=layer.id).delete()
+
         except Project.DoesNotExist:
             return error_response("Project %s does not exist" %
                                   kwargs['project_id'])
diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index 9f9eda1..a5a6563 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -67,6 +67,18 @@ function layerBtnsInit() {
       });
   });
 
+  $("td .set-default-recipe-btn").unbind('click');
+  $("td .set-default-recipe-btn").click(function(e){
+    e.preventDefault();
+    var recipe = $(this).data('recipe-name');
+
+    libtoaster.setDefaultImage(null, recipe,
+      function(){
+        /* Success */
+        window.location.replace(libtoaster.ctx.projectSpecificPageUrl);
+      });
+  });
+
 
   $(".customise-btn").unbind('click');
   $(".customise-btn").click(function(e){
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 6f9b5d0..2e8863a 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -465,6 +465,108 @@ var libtoaster = (function () {
     $.cookie('toaster-notification', JSON.stringify(data), { path: '/'});
   }
 
+  /* _updateProject:
+   * url: xhrProjectUpdateUrl or null for current project
+   * onsuccess: callback for successful execution
+   * onfail: callback for failed execution
+   */
+  function _updateProject (url, targets, default_image, onsuccess, onfail) {
+
+    if (!url)
+      url = libtoaster.ctx.xhrProjectUpdateUrl;
+
+    /* Flatten the array of targets into a space spearated list */
+    if (targets instanceof Array){
+      targets = targets.reduce(function(prevV, nextV){
+        return prev + ' ' + next;
+      });
+    }
+
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: { 'do_update' : 'True' , 'targets' : targets , 'default_image' : default_image , },
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error !== "ok") {
+            console.warn(_data.error);
+          } else {
+            if (onsuccess !== undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.warn("Call failed");
+          console.warn(_data);
+          if (onfail) onfail(data);
+    } });
+  }
+
+  /* _cancelProject:
+   * url: xhrProjectUpdateUrl or null for current project
+   * onsuccess: callback for successful execution
+   * onfail: callback for failed execution
+   */
+  function _cancelProject (url, onsuccess, onfail) {
+
+    if (!url)
+      url = libtoaster.ctx.xhrProjectCancelUrl;
+
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: { 'do_cancel' : 'True'  },
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error !== "ok") {
+            console.warn(_data.error);
+          } else {
+            if (onsuccess !== undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.warn("Call failed");
+          console.warn(_data);
+          if (onfail) onfail(data);
+    } });
+  }
+
+  /* _setDefaultImage:
+   * url: xhrSetDefaultImageUrl or null for current project
+   * targets: an array or space separated list of targets to set as default
+   * onsuccess: callback for successful execution
+   * onfail: callback for failed execution
+   */
+  function _setDefaultImage (url, targets, onsuccess, onfail) {
+
+    if (!url)
+      url = libtoaster.ctx.xhrSetDefaultImageUrl;
+
+    /* Flatten the array of targets into a space spearated list */
+    if (targets instanceof Array){
+      targets = targets.reduce(function(prevV, nextV){
+        return prev + ' ' + next;
+      });
+    }
+
+    $.ajax( {
+        type: "POST",
+        url: url,
+        data: { 'targets' : targets },
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (_data) {
+          if (_data.error !== "ok") {
+            console.warn(_data.error);
+          } else {
+            if (onsuccess !== undefined) onsuccess(_data);
+          }
+        },
+        error: function (_data) {
+          console.warn("Call failed");
+          console.warn(_data);
+          if (onfail) onfail(data);
+    } });
+  }
+
   return {
     enableAjaxLoadingTimer: _enableAjaxLoadingTimer,
     disableAjaxLoadingTimer: _disableAjaxLoadingTimer,
@@ -485,6 +587,9 @@ var libtoaster = (function () {
     createCustomRecipe: _createCustomRecipe,
     makeProjectNameValidation: _makeProjectNameValidation,
     setNotification: _setNotification,
+    updateProject : _updateProject,
+    cancelProject : _cancelProject,
+    setDefaultImage : _setDefaultImage,
   };
 })();
 
diff --git a/lib/toaster/toastergui/static/js/mrbsection.js b/lib/toaster/toastergui/static/js/mrbsection.js
index c0c5fa9..f07ccf8 100644
--- a/lib/toaster/toastergui/static/js/mrbsection.js
+++ b/lib/toaster/toastergui/static/js/mrbsection.js
@@ -86,7 +86,7 @@ function mrbSectionInit(ctx){
           if (buildFinished(build)) {
             // a build finished: reload the whole page so that the build
             // shows up in the builds table
-            window.location.reload();
+            window.location.reload(true);
           }
           else if (stateChanged(build)) {
             // update the whole template
@@ -110,6 +110,8 @@ function mrbSectionInit(ctx){
             // update the clone progress text
             selector = '#repos-cloned-percentage-' + build.id;
             $(selector).html(build.repos_cloned_percentage);
+            selector = '#repos-cloned-progressitem-' + build.id;
+            $(selector).html('('+build.progress_item+')');
 
             // update the recipe progress bar
             selector = '#repos-cloned-percentage-bar-' + build.id;
diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index 69220aa..3f9e186 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -14,6 +14,9 @@ function projectTopBarInit(ctx) {
   var newBuildTargetBuildBtn = $("#build-button");
   var selectedTarget;
 
+  var updateProjectBtn = $("#update-project-button");
+  var cancelProjectBtn = $("#cancel-project-button");
+
   /* Project name change functionality */
   projectNameFormToggle.click(function(e){
     e.preventDefault();
@@ -89,6 +92,25 @@ function projectTopBarInit(ctx) {
     }, null);
   });
 
+  updateProjectBtn.click(function (e) {
+    e.preventDefault();
+
+    selectedTarget = { name: "_PROJECT_PREPARE_" };
+
+    /* Save current default build image, fire off the build */
+    libtoaster.updateProject(null, selectedTarget.name, newBuildTargetInput.val().trim(),
+      function(){
+        window.location.replace(libtoaster.ctx.projectSpecificPageUrl);
+    }, null);
+  });
+
+  cancelProjectBtn.click(function (e) {
+    e.preventDefault();
+
+    /* redirect to 'done/canceled' landing page */
+    window.location.replace(libtoaster.ctx.landingSpecificCancelURL);
+  });
+
   /* Call makeProjectNameValidation function */
   libtoaster.makeProjectNameValidation($("#project-name-change-input"),
       $("#hint-error-project-name"), $("#validate-project-name"),
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index dca2fa2..03bd2ae 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -35,6 +35,8 @@ from toastergui.tablefilter import TableFilterActionToggle
 from toastergui.tablefilter import TableFilterActionDateRange
 from toastergui.tablefilter import TableFilterActionDay
 
+import os
+
 class ProjectFilters(object):
     @staticmethod
     def in_project(project_layers):
@@ -339,6 +341,8 @@ class RecipesTable(ToasterTable):
             'filter_name' : "in_current_project",
             'static_data_name' : "add-del-layers",
             'static_data_template' : '{% include "recipe_btn.html" %}'}
+    if '1' == os.environ.get('TOASTER_PROJECTSPECIFIC'):
+            build_col['static_data_template'] = '{% include "recipe_add_btn.html" %}'
 
     def get_context_data(self, **kwargs):
         project = Project.objects.get(pk=kwargs['pid'])
diff --git a/lib/toaster/toastergui/templates/base_specific.html b/lib/toaster/toastergui/templates/base_specific.html
new file mode 100644
index 0000000..e377cad
--- /dev/null
+++ b/lib/toaster/toastergui/templates/base_specific.html
@@ -0,0 +1,128 @@
+<!DOCTYPE html>
+{% load static %}
+{% load projecttags %}
+{% load project_url_tag %}
+<html lang="en">
+  <head>
+    <title>
+      {% block title %} Toaster {% endblock %}
+    </title>
+    <link rel="stylesheet" href="{% static 'css/bootstrap.min.css' %}" type="text/css"/>
+    <!--link rel="stylesheet" href="{% static 'css/bootstrap-theme.css' %}" type="text/css"/-->
+    <link rel="stylesheet" href="{% static 'css/font-awesome.min.css' %}" type='text/css'/>
+    <link rel="stylesheet" href="{% static 'css/default.css' %}" type='text/css'/>
+
+    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
+    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
+    <script src="{% static 'js/jquery-2.0.3.min.js' %}">
+    </script>
+    <script src="{% static 'js/jquery.cookie.js' %}">
+    </script>
+    <script src="{% static 'js/bootstrap.min.js' %}">
+    </script>
+    <script src="{% static 'js/typeahead.jquery.js' %}">
+    </script>
+    <script src="{% static 'js/jsrender.min.js' %}">
+    </script>
+    <script src="{% static 'js/highlight.pack.js' %}">
+    </script>
+    <script src="{% static 'js/libtoaster.js' %}">
+    </script>
+    {% if DEBUG %}
+    <script>
+      libtoaster.debug = true;
+    </script>
+    {% endif %}
+    <script>
+      /* Set JsRender delimiters (mrb_section.html) different than Django's */
+      $.views.settings.delimiters("<%", "%>");
+
+      /* This table allows Django substitutions to be passed to libtoaster.js */
+      libtoaster.ctx = {
+        jsUrl : "{% static 'js/' %}",
+        htmlUrl : "{% static 'html/' %}",
+        projectsUrl : "{% url 'all-projects' %}",
+        projectsTypeAheadUrl: {% url 'xhr_projectstypeahead' as prjurl%}{{prjurl|json}},
+        {% if project.id %}
+        landingSpecificURL : "{% url 'landing_specific' project.id %}",
+        landingSpecificCancelURL : "{% url 'landing_specific_cancel' project.id %}",
+        projectId : {{project.id}},
+        projectPageUrl : {% url 'project' project.id as purl %}{{purl|json}},
+        projectSpecificPageUrl : {% url 'project_specific' project.id as purl %}{{purl|json}},
+        xhrProjectUrl : {% url 'xhr_project' project.id as pxurl %}{{pxurl|json}},
+        projectName : {{project.name|json}},
+        recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
+        layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
+        machinesTypeAheadUrl: {% url 'xhr_machinestypeahead' project.id as paturl%}{{paturl|json}},
+        distrosTypeAheadUrl: {% url 'xhr_distrostypeahead' project.id as paturl%}{{paturl|json}},
+        projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
+        xhrCustomRecipeUrl : "{% url 'xhr_customrecipe' %}",
+        projectId : {{project.id}},
+        xhrBuildRequestUrl: "{% url 'xhr_buildrequest' project.id %}",
+        mostRecentBuildsUrl: "{% url 'most_recent_builds' %}?project_id={{project.id}}",
+        xhrProjectUpdateUrl: "{% url 'xhr_projectupdate' project.id %}",
+        xhrProjectCancelUrl: "{% url 'landing_specific_cancel' project.id %}",
+        xhrSetDefaultImageUrl: "{% url 'xhr_setdefaultimage' project.id %}",
+        {% else %}
+        mostRecentBuildsUrl: "{% url 'most_recent_builds' %}",
+        projectId : undefined,
+        projectPageUrl : undefined,
+        projectName : undefined,
+        {% endif %}
+      };
+    </script>
+    {% block extraheadcontent %}
+    {% endblock %}
+  </head>
+
+  <body>
+
+    {% csrf_token %}
+    <div id="loading-notification" class="alert alert-warning lead text-center" style="display:none">
+      Loading <i class="fa-pulse icon-spinner"></i>
+    </div>
+
+    <div id="change-notification" class="alert alert-info alert-dismissible change-notification" style="display:none">
+      <button type="button" class="close" id="hide-alert" data-toggle="alert">&times;</button>
+      <span id="change-notification-msg"></span>
+    </div>
+
+    <nav class="navbar navbar-default navbar-fixed-top">
+      <div class="container-fluid">
+        <div class="navbar-header">
+          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#global-nav" aria-expanded="false">
+            <span class="sr-only">Toggle navigation</span>
+            <span class="icon-bar"></span>
+            <span class="icon-bar"></span>
+            <span class="icon-bar"></span>
+          </button>
+          <div class="toaster-navbar-brand">
+          	{% if project_specific %}
+              <img class="logo" src="{% static 'img/logo.png' %}" class="" alt="Yocto Project logo"/>
+              Toaster
+          	{% else %}
+            <a href="/">
+            </a>
+            <a href="/">
+              <img class="logo" src="{% static 'img/logo.png' %}" class="" alt="Yocto Project logo"/>
+            </a>
+            <a class="brand" href="/">Toaster</a>
+            {% endif %}
+            {% if DEBUG %}
+            <span class="glyphicon glyphicon-info-sign" title="<strong>Toaster version information</strong>" data-content="<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
+            {% endif %}
+          </div>
+        </div>
+        <div class="collapse navbar-collapse" id="global-nav">
+            <ul class="nav navbar-nav">
+            <h3> Project Configuration Page </h3>
+        </div>
+      </div>
+    </nav>
+
+    <div class="container-fluid">
+      {% block pagecontent %}
+      {% endblock %}
+    </div>
+  </body>
+</html>
diff --git a/lib/toaster/toastergui/templates/baseprojectspecificpage.html b/lib/toaster/toastergui/templates/baseprojectspecificpage.html
new file mode 100644
index 0000000..d0b588d
--- /dev/null
+++ b/lib/toaster/toastergui/templates/baseprojectspecificpage.html
@@ -0,0 +1,48 @@
+{% extends "base_specific.html" %}
+
+{% load projecttags %}
+{% load humanize %}
+
+{% block title %} {{title}} - {{project.name}} - Toaster {% endblock %}
+
+{% block pagecontent %}
+
+<div class="row">
+  {% include "project_specific_topbar.html" %}
+  <script type="text/javascript">
+$(document).ready(function(){
+    $("#config-nav .nav li a").each(function(){
+      if (window.location.pathname === $(this).attr('href'))
+      $(this).parent().addClass('active');
+      else
+      $(this).parent().removeClass('active');
+      });
+
+    $("#topbar-configuration-tab").addClass("active")
+    });
+  </script>
+
+  <!-- only on config pages -->
+  <div id="config-nav" class="col-md-2">
+    <ul class="nav nav-pills nav-stacked">
+      <li><a class="nav-parent" href="{% url 'project' project.id %}">Configuration</a></li>
+      <li class="nav-header">Compatible metadata</li>
+      <li><a href="{% url 'projectcustomimages' project.id %}">Custom images</a></li>
+      <li><a href="{% url 'projectimagerecipes' project.id %}">Image recipes</a></li>
+      <li><a href="{% url 'projectsoftwarerecipes' project.id %}">Software recipes</a></li>
+      <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
+      <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
+      <li><a href="{% url 'projectdistros' project.id %}">Distros</a></li>
+      <li class="nav-header">Extra configuration</li>
+      <li><a href="{% url 'projectconf' project.id %}">BitBake variables</a></li>
+
+      <li class="nav-header">Actions</li>
+    </ul>
+  </div>
+  <div class="col-md-10">
+    {% block projectinfomain %}{% endblock %}
+  </div>
+
+</div>
+{% endblock %}
+
diff --git a/lib/toaster/toastergui/templates/generic-toastertable-page.html b/lib/toaster/toastergui/templates/generic-toastertable-page.html
index b3eabe1..99fbb38 100644
--- a/lib/toaster/toastergui/templates/generic-toastertable-page.html
+++ b/lib/toaster/toastergui/templates/generic-toastertable-page.html
@@ -1,4 +1,4 @@
-{% extends "baseprojectpage.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 97d52c7..e0c987e 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,base.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
@@ -6,7 +6,7 @@
 {% block pagecontent %}
 
 <div class="row">
-  {% include "projecttopbar.html" %}
+  {% include project_specific|yesno:"project_specific_topbar.html,projecttopbar.html" %}
   {% if project and project.release %}
   <script src="{% static 'js/layerDepsModal.js' %}"></script>
   <script src="{% static 'js/importlayer.js' %}"></script>
diff --git a/lib/toaster/toastergui/templates/landing_specific.html b/lib/toaster/toastergui/templates/landing_specific.html
new file mode 100644
index 0000000..e289c7d
--- /dev/null
+++ b/lib/toaster/toastergui/templates/landing_specific.html
@@ -0,0 +1,50 @@
+{% extends "base_specific.html" %}
+
+{% load static %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block title %} Welcome to Toaster {% endblock %}
+
+{% block pagecontent %}
+
+  <div class="container">
+   <div class="row">
+    <!-- Empty - no build module -->
+    <div class="page-header top-air">
+     <h1>
+       Configuration {% if status == "cancel" %}Canceled{% else %}Completed{% endif %}! You can now close this window.
+     </h1>
+    </div>
+    <div class="alert alert-info lead">
+     <p>
+     Your project configuration {% if status == "cancel" %}changes have been canceled{% else %}has completed!{% endif %}
+     <br>
+     <br>
+     <ul>
+       <li>
+       The Toaster instance for project configuration has been shut down
+       </li>
+       <li>
+       You can start Toaster independently for advanced project management and analysis:
+         <pre><code>
+         Set up bitbake environment:
+         $ cd {{install_dir}}
+         $ . oe-init-build-env [toaster_server]
+
+         Option 1: Start a local Toaster server, open local browser to "localhost:8000"
+         $ . toaster start webport=8000
+
+         Option 2: Start a shared Toaster server, open any browser to "[host_ip]:8000"
+         $ . toaster start webport=0.0.0.0:8000
+
+         To stop the Toaster server:
+         $ . toaster stop
+         </code></pre>
+       </li>
+     </ul>
+     </p>
+    </div>
+   </div>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index e0069db..1e26e31 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,base.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
@@ -310,6 +310,7 @@
             {% endwith %}
             {% endwith %}
           </div>
+
         </div> <!-- end tab content -->
       </div> <!-- end tabable -->
 
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index c5b9fe9..98d9fac 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -119,7 +119,7 @@
           title="Toaster is cloning the repos required for your build">
     </span>
 
-    Cloning <span id="repos-cloned-percentage-<%:id%>"><%:repos_cloned_percentage%></span>% complete
+    Cloning <span id="repos-cloned-percentage-<%:id%>"><%:repos_cloned_percentage%></span>% complete <span id="repos-cloned-progressitem-<%:id%>">(<%:progress_item%>)</span>
 
     <%include tmpl='#cancel-template'/%>
   </div>
diff --git a/lib/toaster/toastergui/templates/newcustomimage.html b/lib/toaster/toastergui/templates/newcustomimage.html
index 980179a..0766e5e 100644
--- a/lib/toaster/toastergui/templates/newcustomimage.html
+++ b/lib/toaster/toastergui/templates/newcustomimage.html
@@ -1,4 +1,4 @@
-{% extends "base.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,base.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
@@ -8,7 +8,7 @@
 
 <div class="row">
 
-  {% include "projecttopbar.html" %}
+  {% include project_specific|yesno:"project_specific_topbar.html,projecttopbar.html" %}
 
   <div class="col-md-12">
     {% url table_name project.id as xhr_table_url %}
diff --git a/lib/toaster/toastergui/templates/newproject_specific.html b/lib/toaster/toastergui/templates/newproject_specific.html
new file mode 100644
index 0000000..cfa77f2
--- /dev/null
+++ b/lib/toaster/toastergui/templates/newproject_specific.html
@@ -0,0 +1,95 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+
+{% block title %} Create a new project - Toaster {% endblock %}
+
+{% block pagecontent %}
+<div class="row">
+  <div class="col-md-12">
+    <div class="page-header">
+          <h1>Create a new project</h1>
+        </div>
+    {% if alert %}
+      <div class="alert alert-danger" role="alert">{{alert}}</div>
+    {% endif %}
+
+        <form method="POST"  action="{%url "newproject_specific" project_pk %}">{% csrf_token %}
+          <div class="form-group" id="validate-project-name">
+            <label class="control-label">Project name <span class="text-muted">(required)</span></label>
+            <input type="text" class="form-control" required id="new-project-name" name="display_projectname" value="{{projectname}}" disabled>
+          </div>
+          <p class="help-block text-danger" style="display: none;" id="hint-error-project-name">A project with this name exists. Project names must be unique.</p>
+        <input type="hidden" name="ptype" value="build" />
+        <input type="hidden" name="projectname" value="{{projectname}}" />
+
+        {% if releases.count > 0 %}
+				<div class="release form-group">
+            {% if releases.count > 1 %}
+              <label class="control-label">
+                Release
+                <span class="glyphicon glyphicon-question-sign get-help" title="The version of the build system you want to use"></span>
+              </label>
+              <select name="projectversion" id="projectversion" class="form-control">
+                {% for release in releases %}
+                    <option value="{{release.id}}"
+                        {%if defaultbranch == release.name %}
+                            selected
+                        {%endif%}
+                     >{{release.description}}</option>
+                {% endfor %}
+              </select>
+              <div class="row">
+                <div class="col-md-4">
+                {% for release in releases %}
+                  <div class="helptext" id="description-{{release.id}}" style="display: none">
+                    <span class="help-block">{{release.helptext|safe}}</span>
+                  </div>
+                {% endfor %}
+            {% else %}
+              <input type="hidden" name="projectversion" value="{{releases.0.id}}"/>
+            {% endif %}
+                </div>
+              </div>
+            </fieldset>
+        {% endif %}
+            <div class="top-air">
+              <input type="submit" id="create-project-button" class="btn btn-primary btn-lg" value="Create project"/>
+              <span class="help-inline" style="vertical-align:middle;">To create a project, you need to specify the release</span>
+            </div>
+
+        </form>
+      </div>
+    </div>
+
+    <script type="text/javascript">
+        $(document).ready(function () {
+            // hide the new project button, name is preset
+            $("#new-project-button").hide();
+
+            // enable submit button when all required fields are populated
+            $("input#new-project-name").on('input', function() {
+                if ($("input#new-project-name").val().length > 0 ){
+                    $('.btn-primary').removeAttr('disabled');
+                    $(".help-inline").css('visibility','hidden');
+                }
+                else {
+                    $('.btn-primary').attr('disabled', 'disabled');
+                    $(".help-inline").css('visibility','visible');
+                }
+            });
+
+            // show relevant help text for the selected release
+            var selected_release = $('select').val();
+            $("#description-" + selected_release).show();
+
+            $('select').change(function(){
+                var new_release = $('select').val();
+                $(".helptext").hide();
+                $('#description-' + new_release).fadeIn();
+            });
+
+        });
+    </script>
+
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 11603d1..fa41e3c 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -1,4 +1,4 @@
-{% extends "baseprojectpage.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,baseprojectpage.html" %}
 
 {% load projecttags %}
 {% load humanize %}
@@ -18,7 +18,7 @@
     try {
       projectPageInit(ctx);
     } catch (e) {
-      document.write("Sorry, An error has occurred loading this page");
+      document.write("Sorry, An error has occurred loading this page (project):"+e);
       console.warn(e);
     }
   });
@@ -93,6 +93,7 @@
       </form>
     </div>
 
+	{% if not project_specific %}
     <div class="well well-transparent">
       <h3>Most built recipes</h3>
 
@@ -105,6 +106,7 @@
       </ul>
       <button class="btn btn-primary" id="freq-build-btn" disabled="disabled">Build selected recipes</button>
     </div>
+    {% endif %}
 
     <div class="well well-transparent">
       <h3>Project release</h3>
@@ -157,5 +159,6 @@
       <ul class="list-unstyled lead" id="layers-in-project-list">
       </ul>
   </div>
+
 </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/project_specific.html b/lib/toaster/toastergui/templates/project_specific.html
new file mode 100644
index 0000000..f625d18
--- /dev/null
+++ b/lib/toaster/toastergui/templates/project_specific.html
@@ -0,0 +1,162 @@
+{% extends "baseprojectspecificpage.html" %}
+
+{% load projecttags %}
+{% load humanize %}
+{% load static %}
+
+{% block title %} Configuration - {{project.name}} - Toaster {% endblock %}
+{% block projectinfomain %}
+
+<script src="{% static 'js/layerDepsModal.js' %}"></script>
+<script src="{% static 'js/projectpage.js' %}"></script>
+<script>
+  $(document).ready(function (){
+    var ctx = {
+      testReleaseChangeUrl: "{% url 'xhr_testreleasechange' project.id %}",
+    };
+
+    try {
+      projectPageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
+
+<div id="delete-project-modal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
+  <div class="modal-dialog">
+    <div class="modal-content">
+      <div class="modal-header">
+        <h4>Are you sure you want to delete this project?</h4>
+      </div>
+      <div class="modal-body">
+        <p>Deleting the <strong class="project-name"></strong> project
+        will:</p>
+        <ul>
+          <li>Cancel its builds currently in progress</li>
+          <li>Remove its configuration information</li>
+          <li>Remove its imported layers</li>
+          <li>Remove its custom images</li>
+          <li>Remove all its build information</li>
+        </ul>
+      </div>
+      <div class="modal-footer">
+        <button type="button" class="btn btn-primary" id="delete-project-confirmed">
+          <span data-role="submit-state">Delete project</span>
+          <span data-role="loading-state" style="display:none">
+            <span class="fa-pulse">
+            <i class="fa-pulse icon-spinner"></i>
+          </span>
+            &nbsp;Deleting project...
+          </span>
+        </button>
+        <button type="button" class="btn btn-link" data-dismiss="modal">Cancel</button>
+      </div>
+    </div><!-- /.modal-content -->
+  </div><!-- /.modal-dialog -->
+</div>
+
+
+<div class="row" id="project-page" style="display:none">
+  <div class="col-md-6">
+    <div class="well well-transparent" id="machine-section">
+      <h3>Machine</h3>
+
+      <p class="lead"><span id="project-machine-name"></span> <span class="glyphicon glyphicon-edit" id="change-machine-toggle"></span></p>
+
+      <form id="select-machine-form" style="display:none;" class="form-inline">
+        <span class="help-block">Machine suggestions come from the list of layers added to your project. If you don't see the machine you are looking for, <a href="{% url 'projectmachines' project.id %}">check the full list of machines</a></span>
+        <div class="form-group" id="machine-input-form">
+          <input class="form-control" id="machine-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
+        </div>
+        <button id="machine-change-btn" class="btn btn-default" type="button">Save</button>
+        <a href="#" id="cancel-machine-change" class="btn btn-link">Cancel</a>
+        <span class="help-block text-danger" id="invalid-machine-name-help" style="display:none">A valid machine name cannot include spaces.</span>
+        <p class="form-link"><a href="{% url 'projectmachines' project.id %}">View compatible machines</a></p>
+      </form>
+    </div>
+
+    <div class="well well-transparent" id="distro-section">
+      <h3>Distro</h3>
+
+      <p class="lead"><span id="project-distro-name"></span> <span class="glyphicon glyphicon-edit" id="change-distro-toggle"></span></p>
+
+      <form id="select-distro-form" style="display:none;" class="form-inline">
+        <span class="help-block">Distro suggestions come from the Layer Index</a></span>
+        <div class="form-group">
+          <input class="form-control" id="distro-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
+        </div>
+        <button id="distro-change-btn" class="btn btn-default" type="button">Save</button>
+        <a href="#" id="cancel-distro-change" class="btn btn-link">Cancel</a>
+        <p class="form-link"><a href="{% url 'projectdistros' project.id %}">View compatible distros</a></p>
+      </form>
+    </div>
+
+    <div class="well well-transparent">
+      <h3>Most built recipes</h3>
+
+      <div class="alert alert-info" style="display:none" id="no-most-built">
+        <h4>You haven't built any recipes yet</h4>
+        <p class="form-link"><a href="{% url 'projectimagerecipes' project.id %}">Choose a recipe to build</a></p>
+      </div>
+
+      <ul class="list-unstyled lead" id="freq-build-list">
+      </ul>
+      <button class="btn btn-primary" id="freq-build-btn" disabled="disabled">Build selected recipes</button>
+    </div>
+
+    <div class="well well-transparent">
+      <h3>Project release</h3>
+
+      <p class="lead"><span id="project-release-title"></span>
+
+      <!-- Comment out the ability to change the project release, until we decide what to do with this functionality -->
+
+      <!--i title="" data-original-title="" id="release-change-toggle" class="icon-pencil"></i-->
+      </p>
+
+      <!-- Comment out the ability to change the project release, until we decide what to do with this functionality -->
+
+      <!--form class="form-inline" id="change-release-form" style="display:none;">
+        <select></select>
+        <button class="btn" style="margin-left:5px;" id="change-release-btn">Change</button> <a href="#" id="cancel-release-change" class="btn btn-link">Cancel</a>
+      </form-->
+    </div>
+  </div>
+
+  <div class="col-md-6">
+    <div class="well well-transparent" id="layer-container">
+      <h3>Layers <span class="counter">(<span id="project-layers-count"></span>)</span>
+        <span title="OpenEmbedded organises recipes and machines into thematic groups called <strong>layers</strong>. Click on a layer name to see the recipes and machines it includes." class="glyphicon glyphicon-question-sign get-help"></span>
+      </h3>
+
+      <div class="alert alert-warning" id="no-layers-in-project" style="display:none">
+        <h4>This project has no layers</h4>
+        In order to build this project you need to add some layers first. For that you can:
+        <ul>
+          <li><a href="{% url 'projectlayers' project.id %}">Choose from the layers compatible with this project</a></li>
+          <li><a href="{% url 'importlayer' project.id %}">Import a layer</a></li>
+          <li><a href="http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the documentation</a></li>
+          <li>Or type a layer name below</li>
+        </ul>
+      </div>
+
+      <form class="form-inline">
+        <div class="form-group">
+          <input id="layer-add-input" class="form-control" autocomplete="off" placeholder="Type a layer name" data-minlength="1" data-autocomplete="off" data-provide="typeahead" data-source="" type="text">
+        </div>
+        <button id="add-layer-btn" class="btn btn-default" disabled>Add layer</button>
+        <p class="form-link">
+          <a href="{% url 'projectlayers' project.id %}" id="view-compatible-layers">View compatible layers</a>
+          <span class="text-muted">|</span>
+          <a href="{% url 'importlayer' project.id %}">Import layer</a>
+        </p>
+      </form>
+
+      <ul class="list-unstyled lead" id="layers-in-project-list">
+      </ul>
+  </div>
+
+</div>
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/project_specific_topbar.html b/lib/toaster/toastergui/templates/project_specific_topbar.html
new file mode 100644
index 0000000..622787c
--- /dev/null
+++ b/lib/toaster/toastergui/templates/project_specific_topbar.html
@@ -0,0 +1,80 @@
+{% load static %}
+<script src="{% static 'js/projecttopbar.js' %}"></script>
+<script>
+  $(document).ready(function () {
+    var ctx = {
+      numProjectLayers : {{project.get_project_layer_versions.count}},
+      machine : "{{project.get_current_machine_name|default_if_none:""}}",
+    }
+
+    try {
+      projectTopBarInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page (pstb):"+e);
+      console.warn(e);
+    }
+  });
+</script>
+
+<div class="col-md-12">
+  <div class="alert alert-success alert-dismissible change-notification" id="project-created-notification" style="display:none">
+    <button type="button" class="close" data-dismiss="alert">&times;</button>
+		<p>Your project <strong>{{project.name}}</strong> has been created. You can now <a class="alert-link" href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a class="alert-link" href="{% url 'projectimagerecipes' project.id %}">choose image recipes</a> to build.</p>
+  </div>
+  <!-- project name -->
+  <div class="page-header">
+    <h1 id="project-name-container">
+      <span class="project-name">{{project.name}}</span>
+      {% if project.is_default %}
+      <span class="glyphicon glyphicon-question-sign get-help" title="This project shows information about the builds you start from the command line while Toaster is running"></span>
+      {% endif %}
+    </h1>
+    <form id="project-name-change-form" class="form-inline" style="display: none;">
+      <div class="form-group">
+        <input class="form-control input-lg" type="text" id="project-name-change-input" autocomplete="off" value="{{project.name}}">
+      </div>
+      <button id="project-name-change-btn" class="btn btn-default btn-lg" type="button">Save</button>
+      <a href="#" id="project-name-change-cancel" class="btn btn-lg btn-link">Cancel</a>
+    </form>
+  </div>
+
+  {% with mrb_type='project' %}
+    {% include "mrb_section.html" %}
+  {% endwith %}
+
+  {% if not project.is_default %}
+  <div id="project-topbar">
+    <ul class="nav nav-tabs">
+      <li id="topbar-configuration-tab">
+      <a href="{% url 'project_specific' project.id %}">
+        Configuration
+      </a>
+      </li>
+      <li>
+      <a href="{% url 'importlayer' project.id %}">
+        Import layer
+      </a>
+      </li>
+      <li>
+      <a href="{% url 'newcustomimage' project.id %}">
+        New custom image
+      </a>
+      </li>
+      <li class="pull-right">
+        <form class="form-inline">
+          <div class="form-group">
+            <span class="glyphicon glyphicon-question-sign get-help" data-placement="left" title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a colon and a task name to the recipe name, like so: <code>busybox:clean</code>"></span>
+                <input id="build-input" type="text" class="form-control input-lg" placeholder="Select the default image recipe" autocomplete="off" disabled value="{{project.get_default_image}}">
+          </div>
+          {% if project.get_is_new %}
+            <button id="update-project-button" class="btn btn-primary btn-lg" data-project-id="{{project.id}}">Prepare Project</button>
+          {% else %}
+            <button id="cancel-project-button" class="btn info btn-lg" data-project-id="{{project.id}}">Cancel</button>
+            <button id="update-project-button" class="btn btn-primary btn-lg" data-project-id="{{project.id}}">Update</button>
+          {% endif %}
+        </form>
+      </li>
+    </ul>
+  </div>
+  {% endif %}
+</div>
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index 933c588..fb20b26 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -1,4 +1,4 @@
-{% extends "baseprojectpage.html" %}
+{% extends project_specific|yesno:"baseprojectspecificpage.html,baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
 
@@ -438,8 +438,11 @@ function onEditPageUpdate(data) {
         var_context='m';
       }
     }
+    if (configvars_sorted[i][0].startsWith("INTERNAL_")) {
+        var_context='m';
+    }
     if (var_context == undefined) {
-      orightml += '<dt><span id="config_var_entry_'+configvars_sorted[i][2]+'" class="js-config-var-name"></span><span class="glyphicon glyphicon-trash js-icon-trash-config_var" id="config_var_trash_'+configvars_sorted[i][2]+'" x-data="'+configvars_sorted[i][2]+'"></span> </dt>'
+        orightml += '<dt><span id="config_var_entry_'+configvars_sorted[i][2]+'" class="js-config-var-name"></span><span class="glyphicon glyphicon-trash js-icon-trash-config_var" id="config_var_trash_'+configvars_sorted[i][2]+'" x-data="'+configvars_sorted[i][2]+'"></span> </dt>'
         orightml += '<dd class="variable-list">'
         orightml += '    <span class="lead" id="config_var_value_'+configvars_sorted[i][2]+'"></span>'
         orightml += '    <span class="glyphicon glyphicon-edit js-icon-pencil-config_var" x-data="'+configvars_sorted[i][2]+'"></span>'
diff --git a/lib/toaster/toastergui/templates/recipe_add_btn.html b/lib/toaster/toastergui/templates/recipe_add_btn.html
new file mode 100644
index 0000000..06c4645
--- /dev/null
+++ b/lib/toaster/toastergui/templates/recipe_add_btn.html
@@ -0,0 +1,23 @@
+<a data-recipe-name="{{data.name}}" class="btn btn-default btn-block layer-exists-{{data.layer_version.pk}} set-default-recipe-btn" style="margin-top: 5px;
+  {% if data.layer_version.pk not in extra.current_layers %}
+    display:none;
+  {% endif %}"
+ >
+  Set recipe
+</a>
+<a class="btn btn-default btn-block layerbtn layer-add-{{data.layer_version.pk}}"
+  data-layer='{
+  "id": {{data.layer_version.pk}},
+  "name":  "{{data.layer_version.layer.name}}",
+  "layerdetailurl": "{%url "layerdetails" extra.pid data.layer_version.pk%}",
+   "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.layer_version.pk %}"
+   }' data-directive="add"
+    {% if data.layer_version.pk in extra.current_layers %}
+     style="display:none;"
+    {% endif %}
+>
+  <span class="glyphicon glyphicon-plus"></span>
+  Add layer
+  <span class="glyphicon glyphicon-question-sign get-help" title="To set this
+      recipe you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
+</a>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index e07b0ef..dc03e30 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -116,6 +116,11 @@ urlpatterns = [
             tables.ProjectBuildsTable.as_view(template_name="projectbuilds-toastertable.html"),
             name='projectbuilds'),
 
+        url(r'^newproject_specific/(?P<pid>\d+)/$', views.newproject_specific, name='newproject_specific'),
+        url(r'^project_specific/(?P<pid>\d+)/$', views.project_specific, name='project_specific'),
+        url(r'^landing_specific/(?P<pid>\d+)/$', views.landing_specific, name='landing_specific'),
+        url(r'^landing_specific_cancel/(?P<pid>\d+)/$', views.landing_specific_cancel, name='landing_specific_cancel'),
+
         # the import layer is a project-specific functionality;
         url(r'^project/(?P<pid>\d+)/importlayer$', views.importlayer, name='importlayer'),
 
@@ -233,6 +238,14 @@ urlpatterns = [
             api.XhrBuildRequest.as_view(),
             name='xhr_buildrequest'),
 
+        url(r'^xhr_projectupdate/project/(?P<pid>\d+)$',
+            api.XhrProjectUpdate.as_view(),
+            name='xhr_projectupdate'),
+
+        url(r'^xhr_setdefaultimage/project/(?P<pid>\d+)$',
+            api.XhrSetDefaultImageUrl.as_view(),
+            name='xhr_setdefaultimage'),
+
         url(r'xhr_project/(?P<project_id>\d+)$',
             api.XhrProject.as_view(),
             name='xhr_project'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
old mode 100755
new mode 100644
index 34ed2b2..4939b6b
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -25,6 +25,7 @@ import re
 from django.db.models import F, Q, Sum
 from django.db import IntegrityError
 from django.shortcuts import render, redirect, get_object_or_404
+from django.utils.http import urlencode
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
 from orm.models import LogMessage, Variable, Package_Dependency, Package
 from orm.models import Task_Dependency, Package_File
@@ -51,6 +52,7 @@ logger = logging.getLogger("toaster")
 
 # Project creation and managed build enable
 project_enable = ('1' == os.environ.get('TOASTER_BUILDSERVER'))
+is_project_specific = ('1' == os.environ.get('TOASTER_PROJECTSPECIFIC'))
 
 class MimeTypeFinder(object):
     # setting this to False enables additional non-standard mimetypes
@@ -70,6 +72,7 @@ class MimeTypeFinder(object):
 # single point to add global values into the context before rendering
 def toaster_render(request, page, context):
     context['project_enable'] = project_enable
+    context['project_specific'] = is_project_specific
     return render(request, page, context)
 
 
@@ -1434,12 +1437,160 @@ if True:
 
         raise Exception("Invalid HTTP method for this page")
 
+    # new project
+    def newproject_specific(request, pid):
+        if not project_enable:
+            return redirect( landing )
+
+        project = Project.objects.get(pk=pid)
+        template = "newproject_specific.html"
+        context = {
+            'email': request.user.email if request.user.is_authenticated() else '',
+            'username': request.user.username if request.user.is_authenticated() else '',
+            'releases': Release.objects.order_by("description"),
+            'projectname': project.name,
+            'project_pk': project.pk,
+        }
+
+        # WORKAROUND: if we already know release, redirect 'newproject_specific' to 'project_specific'
+        if '1' == project.get_variable('INTERNAL_PROJECT_SPECIFIC_SKIPRELEASE'):
+            return redirect(reverse(project_specific, args=(project.pk,)))
+
+        try:
+            context['defaultbranch'] = ToasterSetting.objects.get(name = "DEFAULT_RELEASE").value
+        except ToasterSetting.DoesNotExist:
+            pass
+
+        if request.method == "GET":
+            # render new project page
+            return toaster_render(request, template, context)
+        elif request.method == "POST":
+            mandatory_fields = ['projectname', 'ptype']
+            try:
+                ptype = request.POST.get('ptype')
+                if ptype == "build":
+                    mandatory_fields.append('projectversion')
+                # make sure we have values for all mandatory_fields
+                missing = [field for field in mandatory_fields if len(request.POST.get(field, '')) == 0]
+                if missing:
+                    # set alert for missing fields
+                    raise BadParameterException("Fields missing: %s" % ", ".join(missing))
+
+                if not request.user.is_authenticated():
+                    user = authenticate(username = request.POST.get('username', '_anonuser'), password = 'nopass')
+                    if user is None:
+                        user = User.objects.create_user(username = request.POST.get('username', '_anonuser'), email = request.POST.get('email', ''), password = "nopass")
+
+                        user = authenticate(username = user.username, password = 'nopass')
+                    login(request, user)
+
+                #  save the project
+                if ptype == "analysis":
+                    release = None
+                else:
+                    release = Release.objects.get(pk = request.POST.get('projectversion', None ))
+
+                prj = Project.objects.create_project(name = request.POST['projectname'], release = release, existing_project = project)
+                prj.user_id = request.user.pk
+                prj.save()
+                return redirect(reverse(project_specific, args=(prj.pk,)) + "?notify=new-project")
+
+            except (IntegrityError, BadParameterException) as e:
+                # fill in page with previously submitted values
+                for field in mandatory_fields:
+                    context.__setitem__(field, request.POST.get(field, "-- missing"))
+                if isinstance(e, IntegrityError) and "username" in str(e):
+                    context['alert'] = "Your chosen username is already used"
+                else:
+                    context['alert'] = str(e)
+                return toaster_render(request, template, context)
+
+        raise Exception("Invalid HTTP method for this page")
+
     # Shows the edit project page
     def project(request, pid):
         project = Project.objects.get(pk=pid)
+
+        if '1' == os.environ.get('TOASTER_PROJECTSPECIFIC'):
+            if request.GET:
+                #Example:request.GET=<QueryDict: {'setMachine': ['qemuarm']}>
+                params = urlencode(request.GET).replace('%5B%27','').replace('%27%5D','')
+                return redirect("%s?%s" % (reverse(project_specific, args=(project.pk,)),params))
+            else:
+                return redirect(reverse(project_specific, args=(project.pk,)))
         context = {"project": project}
         return toaster_render(request, "project.html", context)
 
+    # Shows the edit project-specific page
+    def project_specific(request, pid):
+        project = Project.objects.get(pk=pid)
+
+        # Are we refreshing from a successful project specific update clone?
+        if Project.PROJECT_SPECIFIC_CLONING_SUCCESS == project.get_variable(Project.PROJECT_SPECIFIC_STATUS):
+            return redirect(reverse(landing_specific,args=(project.pk,)))
+
+        context = {
+            "project": project,
+            "is_new" : project.get_variable(Project.PROJECT_SPECIFIC_ISNEW),
+            "default_image_recipe" : project.get_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE),
+            "mru" : Build.objects.all().filter(project=project,outcome=Build.IN_PROGRESS),
+            }
+        if project.build_set.filter(outcome=Build.IN_PROGRESS).count() > 0:
+            context['build_in_progress_none_completed'] = True
+        else:
+            context['build_in_progress_none_completed'] = False
+        return toaster_render(request, "project.html", context)
+
+    # perform the final actions for the project specific page
+    def project_specific_finalize(cmnd, pid):
+        project = Project.objects.get(pk=pid)
+        callback = project.get_variable(Project.PROJECT_SPECIFIC_CALLBACK)
+        if "update" == cmnd:
+            # Delete all '_PROJECT_PREPARE_' builds
+            for b in Build.objects.all().filter(project=project):
+                delete_build = False
+                for t in b.target_set.all():
+                    if '_PROJECT_PREPARE_' == t.target:
+                        delete_build = True
+                if delete_build:
+                    from django.core import management
+                    management.call_command('builddelete', str(b.id), interactive=False)
+            # perform callback at this last moment if defined, in case Toaster gets shutdown next
+            default_target = project.get_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE)
+            if callback:
+                callback = callback.replace("<IMAGE>",default_target)
+        if "cancel" == cmnd:
+            if callback:
+                callback = callback.replace("<IMAGE>","none")
+                callback = callback.replace("--update","--cancel")
+        # perform callback at this last moment if defined, in case this Toaster gets shutdown next
+        ret = ''
+        if callback:
+            ret = os.system('bash -c "%s"' % callback)
+            project.set_variable(Project.PROJECT_SPECIFIC_CALLBACK,'')
+        # Delete the temp project specific variables
+        project.set_variable(Project.PROJECT_SPECIFIC_ISNEW,'')
+        project.set_variable(Project.PROJECT_SPECIFIC_STATUS,Project.PROJECT_SPECIFIC_NONE)
+        # WORKAROUND: Release this workaround flag
+        project.set_variable('INTERNAL_PROJECT_SPECIFIC_SKIPRELEASE','')
+
+    # Shows the final landing page for project specific update
+    def landing_specific(request, pid):
+        project_specific_finalize("update", pid)
+        context = {
+            "install_dir": os.environ['TOASTER_DIR'],
+        }
+        return toaster_render(request, "landing_specific.html", context)
+
+    # Shows the related landing-specific page
+    def landing_specific_cancel(request, pid):
+        project_specific_finalize("cancel", pid)
+        context = {
+            "install_dir": os.environ['TOASTER_DIR'],
+            "status": "cancel",
+        }
+        return toaster_render(request, "landing_specific.html", context)
+
     def jsunittests(request):
         """ Provides a page for the js unit tests """
         bbv = BitbakeVersion.objects.filter(branch="master").first()
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index a1792d9..88dff8a 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -89,6 +89,10 @@ class ToasterTable(TemplateView):
 
         # global variables
         context['project_enable'] = ('1' == os.environ.get('TOASTER_BUILDSERVER'))
+        try:
+            context['project_specific'] = ('1' == os.environ.get('TOASTER_PROJECTSPECIFIC'))
+        except:
+            context['project_specific'] = ''
 
         return context
 
@@ -519,6 +523,8 @@ class MostRecentBuildsView(View):
                 int((build_obj.repos_cloned /
                      build_obj.repos_to_clone) * 100)
 
+            build['progress_item'] = build_obj.progress_item
+
             tasks_complete_percentage = 0
             if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
                 tasks_complete_percentage = 100
diff --git a/lib/toaster/toastermain/management/commands/builddelete.py b/lib/toaster/toastermain/management/commands/builddelete.py
index 0bef8d4..bf69a8f 100644
--- a/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/lib/toaster/toastermain/management/commands/builddelete.py
@@ -10,8 +10,12 @@ class Command(BaseCommand):
     args    = '<buildID1 buildID2 .....>'
     help    = "Deletes selected build(s)"
 
+    def add_arguments(self, parser):
+        parser.add_argument('buildids', metavar='N', type=int, nargs='+',
+                    help="Build ID's to delete")
+
     def handle(self, *args, **options):
-        for bid in args:
+        for bid in options['buildids']:
             try:
                 b = Build.objects.get(pk = bid)
             except ObjectDoesNotExist:
diff --git a/lib/toaster/toastermain/management/commands/buildimport.py b/lib/toaster/toastermain/management/commands/buildimport.py
new file mode 100644
index 0000000..791d528
--- /dev/null
+++ b/lib/toaster/toastermain/management/commands/buildimport.py
@@ -0,0 +1,586 @@
+#
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2018        Wind River Systems
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+# buildimport: import a project for project specific configuration
+#
+# Usage:
+#  (a) Set up Toaster environent
+#
+#  (b) Call buildimport
+#      $ /path/to/bitbake/lib/toaster/manage.py buildimport \
+#        --name=$PROJECTNAME \
+#        --path=$BUILD_DIRECTORY \
+#        --callback="$CALLBACK_SCRIPT" \
+#        --command="configure|reconfigure|import"
+#
+#  (c) Return is "|Default_image=%s|Project_id=%d"
+#
+#  (d) Open Toaster to this project using for example:
+#      $ xdg-open http://localhost:$toaster_port/toastergui/project_specific/$project_id
+#
+#  (e) To delete a project:
+#      $ /path/to/bitbake/lib/toaster/manage.py buildimport \
+#        --name=$PROJECTNAME --delete-project
+#
+
+
+# ../bitbake/lib/toaster/manage.py buildimport --name=test --path=`pwd` --callback="" --command=import
+
+from django.core.management.base import BaseCommand, CommandError
+from django.core.exceptions import ObjectDoesNotExist
+from orm.models import ProjectManager, Project, Release, ProjectVariable
+from orm.models import Layer, Layer_Version, LayerSource, ProjectLayer
+from toastergui.api import scan_layer_content
+from django.db import OperationalError
+
+import os
+import re
+import os.path
+import subprocess
+
+# Toaster variable section delimiters
+TOASTER_PROLOG = '#=== TOASTER_CONFIG_PROLOG ==='
+TOASTER_EPILOG = '#=== TOASTER_CONFIG_EPILOG ==='
+
+# quick development/debugging support
+verbose = 2
+def _log(msg):
+    if 1 == verbose:
+        print(msg)
+    elif 2 == verbose:
+        f1=open('/tmp/toaster.log', 'a')
+        f1.write("|" + msg + "|\n" )
+        f1.close()
+
+
+__config_regexp__  = re.compile( r"""
+    ^
+    (?P<exp>export\s+)?
+    (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
+    (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
+
+    \s* (
+        (?P<colon>:=) |
+        (?P<lazyques>\?\?=) |
+        (?P<ques>\?=) |
+        (?P<append>\+=) |
+        (?P<prepend>=\+) |
+        (?P<predot>=\.) |
+        (?P<postdot>\.=) |
+        =
+    ) \s*
+
+    (?!'[^']*'[^']*'$)
+    (?!\"[^\"]*\"[^\"]*\"$)
+    (?P<apo>['\"])
+    (?P<value>.*)
+    (?P=apo)
+    $
+    """, re.X)
+
+class Command(BaseCommand):
+    args    = "<name> <path> <release>"
+    help    = "Import a command line build directory"
+    vars    = {}
+    toaster_vars = {}
+
+    def add_arguments(self, parser):
+        parser.add_argument(
+            '--name', dest='name', required=True,
+            help='name of the project',
+            )
+        parser.add_argument(
+            '--path', dest='path', required=True,
+            help='path to the project',
+            )
+        parser.add_argument(
+            '--release', dest='release', required=False,
+            help='release for the project',
+            )
+        parser.add_argument(
+            '--callback', dest='callback', required=False,
+            help='callback for project config update',
+            )
+        parser.add_argument(
+            '--delete-project', dest='delete_project', required=False,
+            help='delete this project from the database',
+            )
+        parser.add_argument(
+            '--command', dest='command', required=False,
+            help='command (configure,reconfigure,import)',
+            )
+
+    # Extract the bb variables from a conf file
+    def scan_conf(self,fn):
+        vars = self.vars
+        toaster_vars = self.toaster_vars
+
+        #_log("scan_conf:%s" % fn)
+        if not os.path.isfile(fn):
+            return
+        f = open(fn, 'r')
+
+        #statements = ast.StatementGroup()
+        lineno = 0
+        is_toaster_section = False
+        while True:
+            lineno = lineno + 1
+            s = f.readline()
+            if not s:
+                break
+            w = s.strip()
+            # skip empty lines
+            if not w:
+                continue
+            # evaluate Toaster sections
+            if w.startswith(TOASTER_PROLOG):
+                is_toaster_section = True
+                continue
+            if w.startswith(TOASTER_EPILOG):
+                is_toaster_section = False
+                continue
+            s = s.rstrip()
+            while s[-1] == '\\':
+                s2 = f.readline().strip()
+                lineno = lineno + 1
+                if (not s2 or s2 and s2[0] != "#") and s[0] == "#" :
+                    echo("There is a confusing multiline, partially commented expression on line %s of file %s (%s).\nPlease clarify whether this is all a comment or should be parsed." % (lineno, fn, s))
+                s = s[:-1] + s2
+            # skip comments
+            if s[0] == '#':
+                continue
+            # process the line for just assignments
+            m = __config_regexp__.match(s)
+            if m:
+                groupd = m.groupdict()
+                var = groupd['var']
+                value = groupd['value']
+
+                if groupd['lazyques']:
+                    if not var in vars:
+                        vars[var] = value
+                    continue
+                if groupd['ques']:
+                    if not var in vars:
+                        vars[var] = value
+                    continue
+                # preset empty blank for remaining operators
+                if not var in vars:
+                    vars[var] = ''
+                if groupd['append']:
+                    vars[var] += value
+                elif groupd['prepend']:
+                    vars[var] = "%s%s" % (value,vars[var])
+                elif groupd['predot']:
+                    vars[var] = "%s %s" % (value,vars[var])
+                elif groupd['postdot']:
+                    vars[var] = "%s %s" % (vars[var],value)
+                else:
+                    vars[var] = "%s" % (value)
+                # capture vars in a Toaster section
+                if is_toaster_section:
+                    toaster_vars[var] = vars[var]
+
+        # DONE WITH PARSING
+        f.close()
+        self.vars = vars
+        self.toaster_vars = toaster_vars
+
+    # Update the scanned project variables
+    def update_project_vars(self,project,name):
+        pv, create = ProjectVariable.objects.get_or_create(project = project, name = name)
+        if (not name in self.vars.keys()) or (not self.vars[name]):
+            self.vars[name] = pv.value
+        else:
+            if pv.value != self.vars[name]:
+                pv.value = self.vars[name]
+        pv.save()
+
+    # Find the git version of the installation
+    def find_layer_dir_version(self,path):
+        #  * rocko               ...
+
+        install_version = ''
+        cwd = os.getcwd()
+        os.chdir(path)
+        p = subprocess.Popen(['git', 'branch', '-av'], stdout=subprocess.PIPE,
+                                                stderr=subprocess.PIPE)
+        out, err = p.communicate()
+        out = out.decode("utf-8")
+        for branch in out.split('\n'):
+            if ('*' == branch[0:1]) and ('no branch' not in branch):
+                install_version = re.sub(' .*','',branch[2:])
+                break
+            if 'remotes/m/master' in branch:
+                install_version = re.sub('.*base/','',branch)
+                break
+        os.chdir(cwd)
+        return install_version
+
+    # Compute table of the installation's registered layer versions (branch or commit)
+    def find_layer_dir_versions(self,INSTALL_URL_PREFIX):
+        lv_dict = {}
+        layer_versions = Layer_Version.objects.all()
+        for lv in layer_versions:
+            layer = Layer.objects.filter(pk=lv.layer.pk)[0]
+            if layer.vcs_url:
+                url_short = layer.vcs_url.replace(INSTALL_URL_PREFIX,'')
+            else:
+                url_short = ''
+            # register the core, branch, and the version variations
+            lv_dict["%s,%s,%s" % (url_short,lv.dirpath,'')] = (lv.id,layer.name)
+            lv_dict["%s,%s,%s" % (url_short,lv.dirpath,lv.branch)] = (lv.id,layer.name)
+            lv_dict["%s,%s,%s" % (url_short,lv.dirpath,lv.commit)] = (lv.id,layer.name)
+            #_log("  (%s,%s,%s|%s) = (%s,%s)" % (url_short,lv.dirpath,lv.branch,lv.commit,lv.id,layer.name))
+        return lv_dict
+
+    # Apply table of all layer versions
+    def extract_bblayers(self):
+        # set up the constants
+        bblayer_str = self.vars['BBLAYERS']
+        TOASTER_DIR = os.environ.get('TOASTER_DIR')
+        INSTALL_CLONE_PREFIX = os.path.dirname(TOASTER_DIR) + "/"
+        TOASTER_CLONE_PREFIX = TOASTER_DIR + "/_toaster_clones/"
+        INSTALL_URL_PREFIX = ''
+        layers = Layer.objects.filter(name='openembedded-core')
+        for layer in layers:
+            if layer.vcs_url:
+                INSTALL_URL_PREFIX = layer.vcs_url
+                break
+        INSTALL_URL_PREFIX = INSTALL_URL_PREFIX.replace("/poky","/")
+        INSTALL_VERSION_DIR = TOASTER_DIR
+        INSTALL_URL_POSTFIX = INSTALL_URL_PREFIX.replace(':','_')
+        INSTALL_URL_POSTFIX = INSTALL_URL_POSTFIX.replace('/','_')
+        INSTALL_URL_POSTFIX = "%s_%s" % (TOASTER_CLONE_PREFIX,INSTALL_URL_POSTFIX)
+
+        # get the set of available layer:layer_versions
+        lv_dict = self.find_layer_dir_versions(INSTALL_URL_PREFIX)
+
+        # compute the layer matches
+        layers_list = []
+        for line in bblayer_str.split(' '):
+            if not line:
+                continue
+            if line.endswith('/local'):
+                continue
+
+            # isolate the repo
+            layer_path = line
+            line = line.replace(INSTALL_URL_POSTFIX,'').replace(INSTALL_CLONE_PREFIX,'').replace('/layers/','/').replace('/poky/','/')
+
+            # isolate the sub-path
+            path_index = line.rfind('/')
+            if path_index > 0:
+                sub_path = line[path_index+1:]
+                line = line[0:path_index]
+            else:
+                sub_path = ''
+
+            # isolate the version
+            if TOASTER_CLONE_PREFIX in layer_path:
+                is_toaster_clone = True
+                # extract version from name syntax
+                version_index = line.find('_')
+                if version_index > 0:
+                    version = line[version_index+1:]
+                    line = line[0:version_index]
+                else:
+                    version = ''
+                _log("TOASTER_CLONE(%s/%s), version=%s" % (line,sub_path,version))
+            else:
+                is_toaster_clone = False
+                # version is from the installation
+                version = self.find_layer_dir_version(layer_path)
+                _log("LOCAL_CLONE(%s/%s), version=%s" % (line,sub_path,version))
+
+            # capture the layer information into layers_list
+            layers_list.append( (line,sub_path,version,layer_path,is_toaster_clone) )
+        return layers_list,lv_dict
+
+    #
+    def find_import_release(self,layers_list,lv_dict,default_release):
+        #   poky,meta,rocko => 4;openembedded-core
+        release = default_release
+        for line,path,version,layer_path,is_toaster_clone in layers_list:
+            key = "%s,%s,%s" % (line,path,version)
+            if key in lv_dict:
+                lv_id = lv_dict[key]
+                if 'openembedded-core' == lv_id[1]:
+                    _log("Find_import_release(%s):version=%s,Toaster=%s" % (lv_id[1],version,is_toaster_clone))
+                    # only versions in Toaster managed layers are accepted
+                    if not is_toaster_clone:
+                        break
+                    try:
+                        release = Release.objects.get(name=version)
+                    except:
+                        pass
+                    break
+        _log("Find_import_release:RELEASE=%s" % release.name)
+        return release
+
+    # Apply the found conf layers
+    def apply_conf_bblayers(self,layers_list,lv_dict,project,release=None):
+        for line,path,version,layer_path,is_toaster_clone in layers_list:
+            # Assert release promote if present
+            if release:
+                version = release
+            # try to match the key to a layer_version
+            key = "%s,%s,%s" % (line,path,version)
+            key_short = "%s,%s,%s" % (line,path,'')
+            lv_id = ''
+            if key in lv_dict:
+                lv_id = lv_dict[key]
+                lv = Layer_Version.objects.get(pk=int(lv_id[0]))
+                pl,created = ProjectLayer.objects.get_or_create(project=project,
+                                                   layercommit=lv)
+                pl.optional=False
+                pl.save()
+                _log("  %s => %s;%s" % (key,lv_id[0],lv_id[1]))
+            elif key_short in lv_dict:
+                lv_id = lv_dict[key_short]
+                lv = Layer_Version.objects.get(pk=int(lv_id[0]))
+                pl,created = ProjectLayer.objects.get_or_create(project=project,
+                                                   layercommit=lv)
+                pl.optional=False
+                pl.save()
+                _log("  %s ?> %s" % (key,lv_dict[key_short]))
+            else:
+                _log("%s <= %s" % (key,layer_path))
+                found = False
+                # does local layer already exist in this project?
+                try:
+                    for pl in ProjectLayer.objects.filter(project=project):
+                        if pl.layercommit.layer.local_source_dir == layer_path:
+                            found = True
+                            _log("  Project Local Layer found!")
+                except Exception as e:
+                    _log("ERROR: Local Layer '%s'" % e)
+                    pass
+
+                if not found:
+                    # Does Layer name+path already exist?
+                    try:
+                        layer_name_base = os.path.basename(layer_path)
+                        _log("Layer_lookup: try '%s','%s'" % (layer_name_base,layer_path))
+                        layer = Layer.objects.get(name=layer_name_base,local_source_dir = layer_path)
+                        # Found! Attach layer_version and ProjectLayer
+                        layer_version = Layer_Version.objects.create(
+                            layer=layer,
+                            project=project,
+                            layer_source=LayerSource.TYPE_IMPORTED)
+                        layer_version.save()
+                        pl,created = ProjectLayer.objects.get_or_create(project=project,
+                                                           layercommit=layer_version)
+                        pl.optional=False
+                        pl.save()
+                        found = True
+                        # add layer contents to this layer version
+                        scan_layer_content(layer,layer_version)
+                        _log("  Parent Local Layer found in db!")
+                    except Exception as e:
+                        _log("Layer_exists_test_failed: Local Layer '%s'" % e)
+                        pass
+
+                if not found:
+                    # Insure that layer path exists, in case of user typo
+                    if not os.path.isdir(layer_path):
+                        _log("ERROR:Layer path '%s' not found" % layer_path)
+                        continue
+                    # Add layer to db and attach project to it
+                    layer_name_base = os.path.basename(layer_path)
+                    # generate a unique layer name
+                    layer_name_matches = {}
+                    for layer in Layer.objects.filter(name__contains=layer_name_base):
+                        layer_name_matches[layer.name] = '1'
+                    layer_name_idx = 0
+                    layer_name_test = layer_name_base
+                    while layer_name_test in layer_name_matches.keys():
+                        layer_name_idx += 1
+                        layer_name_test = "%s_%d" % (layer_name_base,layer_name_idx)
+                    # create the layer and layer_verion objects
+                    layer = Layer.objects.create(name=layer_name_test)
+                    layer.local_source_dir = layer_path
+                    layer_version = Layer_Version.objects.create(
+                        layer=layer,
+                        project=project,
+                        layer_source=LayerSource.TYPE_IMPORTED)
+                    layer.save()
+                    layer_version.save()
+                    pl,created = ProjectLayer.objects.get_or_create(project=project,
+                                                       layercommit=layer_version)
+                    pl.optional=False
+                    pl.save()
+                    # register the layer's content
+                    _log("  Local Layer Add content")
+                    scan_layer_content(layer,layer_version)
+                    _log("  Local Layer Added '%s'!" % layer_name_test)
+
+    # Scan the project's conf files (if any)
+    def scan_conf_variables(self,project_path):
+        # scan the project's settings, add any new layers or variables
+        if os.path.isfile("%s/conf/local.conf" % project_path):
+            self.scan_conf("%s/conf/local.conf" % project_path)
+            self.scan_conf("%s/conf/bblayers.conf" % project_path)
+            # Import then disable old style Toaster conf files (before 'merged_attr')
+            old_toaster_local = "%s/conf/toaster.conf" % project_path
+            if os.path.isfile(old_toaster_local):
+                self.scan_conf(old_toaster_local)
+                shutil.move(old_toaster_local, old_toaster_local+"_old")
+            old_toaster_layer = "%s/conf/toaster-bblayers.conf" % project_path
+            if os.path.isfile(old_toaster_layer):
+                self.scan_conf(old_toaster_layer)
+                shutil.move(old_toaster_layer, old_toaster_layer+"_old")
+
+    # Scan the found conf variables (if any)
+    def apply_conf_variables(self,project,layers_list,lv_dict,release=None):
+        if self.vars:
+            # Catch vars relevant to Toaster (in case no Toaster section)
+            self.update_project_vars(project,'DISTRO')
+            self.update_project_vars(project,'MACHINE')
+            self.update_project_vars(project,'IMAGE_INSTALL_append')
+            self.update_project_vars(project,'IMAGE_FSTYPES')
+            self.update_project_vars(project,'PACKAGE_CLASSES')
+            # These vars are typically only assigned by Toaster
+            #self.update_project_vars(project,'DL_DIR')
+            #self.update_project_vars(project,'SSTATE_DIR')
+
+            # Assert found Toaster vars
+            for var in self.toaster_vars.keys():
+                pv, create = ProjectVariable.objects.get_or_create(project = project, name = var)
+                pv.value = self.toaster_vars[var]
+                _log("* Add/update Toaster var '%s' = '%s'" % (pv.name,pv.value))
+                pv.save()
+
+            # Assert found BBLAYERS
+            if 0 < verbose:
+                for pl in ProjectLayer.objects.filter(project=project):
+                    release_name = 'None' if not pl.layercommit.release else pl.layercommit.release.name
+                    print(" BEFORE:ProjectLayer=%s,%s,%s,%s" % (pl.layercommit.layer.name,release_name,pl.layercommit.branch,pl.layercommit.commit))
+            self.apply_conf_bblayers(layers_list,lv_dict,project,release)
+            if 0 < verbose:
+                for pl in ProjectLayer.objects.filter(project=project):
+                    release_name = 'None' if not pl.layercommit.release else pl.layercommit.release.name
+                    print(" AFTER :ProjectLayer=%s,%s,%s,%s" % (pl.layercommit.layer.name,release_name,pl.layercommit.branch,pl.layercommit.commit))
+
+
+    def handle(self, *args, **options):
+        project_name = options['name']
+        project_path = options['path']
+        project_callback = options['callback']
+        if options['release']:
+            release_name = options['release']
+        else:
+            release_name = ''
+
+        #
+        # Delete project
+        #
+
+        if options['delete_project']:
+            try:
+                print("Project '%s' delete from Toaster database" % (project_name))
+                project = Project.objects.get(name=project_name)
+                # TODO: deep project delete
+                project.delete()
+                print("Project '%s' Deleted" % (project_name))
+                return
+            except Exception as e:
+                print("Project '%s' not found, not deleted (%s)" % (project_name,e))
+                return
+
+        #
+        # Create/Update/Import project
+        #
+
+        # See if project (by name) exists
+        project = None
+        try:
+            # Project already exists
+            project = Project.objects.get(name=project_name)
+        except Exception as e:
+            pass
+
+        # Find the installation's default release
+        default_release = Release.objects.get(id=1)
+
+        # SANITY: if 'reconfig' but project does not exist (deleted externally), switch to 'import'
+        if ("reconfigure" == options['command']) and (None == project):
+            options['command'] = 'import'
+
+        # 'Configure':
+        if "configure" == options['command']:
+            # Note: ignore any existing conf files
+            # create project, SANITY: reuse any project of same name
+            project = Project.objects.create_project(project_name,default_release,project)
+
+        # 'Re-configure':
+        if "reconfigure" == options['command']:
+            # Scan the directory's conf files
+            self.scan_conf_variables(project_path)
+            # Scan the layer list
+            layers_list,lv_dict = self.extract_bblayers()
+            # Apply any new layers or variables
+            self.apply_conf_variables(project,layers_list,lv_dict)
+
+        # 'Import':
+        if "import" == options['command']:
+            # Scan the directory's conf files
+            self.scan_conf_variables(project_path)
+            # Remove these Toaster controlled variables
+            for var in ('DL_DIR','SSTATE_DIR'):
+                self.vars.pop(var, None)
+                self.toaster_vars.pop(var, None)
+            # Scan the layer list
+            layers_list,lv_dict = self.extract_bblayers()
+            # Find the directory's release, and promote to default_release if local paths
+            release = self.find_import_release(layers_list,lv_dict,default_release)
+            # create project, SANITY: reuse any project of same name
+            project = Project.objects.create_project(project_name,release,project)
+            # Apply any new layers or variables
+            self.apply_conf_variables(project,layers_list,lv_dict,release)
+            # WORKAROUND: since we now derive the release, redirect 'newproject_specific' to 'project_specific'
+            project.set_variable('INTERNAL_PROJECT_SPECIFIC_SKIPRELEASE','1')
+
+        # Set up the project's meta data
+        project.builddir = project_path
+        project.merged_attr = True
+        project.set_variable(Project.PROJECT_SPECIFIC_CALLBACK,project_callback)
+        project.set_variable(Project.PROJECT_SPECIFIC_STATUS,Project.PROJECT_SPECIFIC_EDIT)
+        if ("configure" == options['command']) or ("import" == options['command']):
+            # preset the mode and default image recipe
+            project.set_variable(Project.PROJECT_SPECIFIC_ISNEW,Project.PROJECT_SPECIFIC_NEW)
+            project.set_variable(Project.PROJECT_SPECIFIC_DEFAULTIMAGE,"core-image-minimal")
+            # Assert any extended/custom actions or variables for new non-Toaster projects
+            if not len(self.toaster_vars):
+                pass
+        else:
+            project.set_variable(Project.PROJECT_SPECIFIC_ISNEW,Project.PROJECT_SPECIFIC_NONE)
+
+        # Save the updated Project
+        project.save()
+
+        _log("Buildimport:project='%s' at '%d'" % (project_name,project.id))
+
+        if ('DEFAULT_IMAGE' in self.vars) and (self.vars['DEFAULT_IMAGE']):
+            print("|Default_image=%s|Project_id=%d" % (self.vars['DEFAULT_IMAGE'],project.id))
+        else:
+            print("|Project_id=%d" % (project.id))
+
-- 
1.9.1


