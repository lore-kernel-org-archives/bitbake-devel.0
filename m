Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 28124766A3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 12:20:39 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 07 Oct 2015 05:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="659549781"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 05:19:44 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id C98116A4083;
	Wed,  7 Oct 2015 05:18:46 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:17:35 +0300
Message-Id: <a12c38149e0bf25d5c0eb03e78f4ee7831888ba0.1444219934.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
References: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444219934.git.ed.bartosh@linux.intel.com>
References: <cover.1444219934.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 4/5] toaster: get rid of interactivity in bldcontrol
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
X-List-Received-Date: Wed, 07 Oct 2015 12:20:39 -0000

From: brian avery <avery.brian@gmail.com>

removed layer dir questions and base off TOASTER_DIR

removed build dir questions and base off TOASTER_DIR

base configuration file off of TOASTER_CONF

fixed some pylint issues

[YOCTO #8217]

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster                                        |   2 +-
 .../management/commands/checksettings.py           | 138 ++++++---------------
 2 files changed, 38 insertions(+), 102 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index bfedfd3..f1aee62 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -174,7 +174,7 @@ fi
 # toasterconf.json
 if [ "$TOASTER_CONF" == "" ]; then
     BIN_DIR=$(dirname "${BASH_SOURCE[0]}")
-    export TOASTER_CONF="$BIN_DIR/../../meta-yocto/conf/toasterconf.json"    
+    export TOASTER_CONF="$BIN_DIR/../../meta-yocto/conf/toasterconf.json"
 fi
 if [ ! -f $TOASTER_CONF ]; then
     echo "$TOASTER_CONF configuration file not found, exiting..."
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index b2c573c..5e70437 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -4,7 +4,7 @@ from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdExcep
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 from orm.models import ToasterSetting, Build
 import os
-import sys, traceback
+import traceback
 
 def DN(path):
     if path is None:
@@ -21,7 +21,7 @@ class Command(NoArgsCommand):
         super(Command, self).__init__(*args, **kwargs)
         self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
 
-    def _find_first_path_for_file(self, startdirectory, filename, level = 0):
+    def _find_first_path_for_file(self, startdirectory, filename, level=0):
         if level < 0:
             return None
         dirs = []
@@ -38,7 +38,7 @@ class Command(NoArgsCommand):
                 return ret
         return None
 
-    def _recursive_list_directories(self, startdirectory, level = 0):
+    def _recursive_list_directories(self, startdirectory, level=0):
         if level < 0:
             return []
         dirs = []
@@ -50,49 +50,23 @@ class Command(NoArgsCommand):
         except OSError:
             pass
         for j in dirs:
-                dirs = dirs + self._recursive_list_directories(j, level - 1)
+            dirs = dirs + self._recursive_list_directories(j, level - 1)
         return dirs
 
 
-    def _get_suggested_sourcedir(self, be):
-        if be.betype != BuildEnvironment.TYPE_LOCAL:
-            return ""
-        return DN(DN(DN(self._find_first_path_for_file(self.guesspath, "toasterconf.json", 4))))
-
-    def _get_suggested_builddir(self, be):
-        if be.betype != BuildEnvironment.TYPE_LOCAL:
-            return ""
-        return DN(self._find_first_path_for_file(DN(self.guesspath), "bblayers.conf", 4))
-
     def _verify_build_environment(self):
-        # refuse to start if we have no build environments
-        while BuildEnvironment.objects.count() == 0:
-            print(" !! No build environments found. Toaster needs at least one build environment in order to be able to run builds.\n" +
-                "You can manually define build environments in the database table bldcontrol_buildenvironment.\n" +
-                "Or Toaster can define a simple localhost-based build environment for you.")
-
-            i = raw_input(" --  Do you want to create a basic localhost build environment ? (Y/n) ");
-            if not len(i) or i.startswith("y") or i.startswith("Y"):
-                BuildEnvironment.objects.create(pk = 1, betype = 0)
-            else:
-                raise Exception("Toaster cannot start without build environments. Aborting.")
-
+        # provide a local build env. This will be extended later to include non local
+        if BuildEnvironment.objects.count() == 0:
+            BuildEnvironment.objects.create(betype=BuildEnvironment.TYPE_LOCAL)
 
         # we make sure we have builddir and sourcedir for all defined build envionments
         for be in BuildEnvironment.objects.all():
             be.needs_import = False
             def _verify_be():
                 is_changed = False
-                print("\nVerifying the build environment. If the local build environment is not properly configured, you will be asked to configure it.")
 
                 def _update_sourcedir():
-                    suggesteddir = self._get_suggested_sourcedir(be)
-                    if len(suggesteddir) > 0:
-                        be.sourcedir = raw_input("This is the directory Toaster uses to check out the source code of the layers you will build. Toaster will create new clones of the layers, so existing content in the chosen directory will not be changed.\nToaster suggests you use \"%s\" as your layers checkout directory. If you select this directory, a layer like \"meta-intel\" will end up in \"%s/meta-intel\".\nPress Enter to select \"%s\" or type the full path to a different directory. If you provide your own directory, it must be a parent of the cloned directory for the sources you are using to run Toaster: " % (suggesteddir, suggesteddir, suggesteddir))
-                    else:
-                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the source code of the layers you will build. The directory should be a parent of the cloned directory for the sources you are using to run Toaster. Toaster will create new clones of the layers, so existing content in the chosen directory will not be changed.\nType the full path to the directory (for example: \"%s\": " % os.environ.get('HOME', '/tmp/'))
-                    if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
-                        be.sourcedir = suggesteddir
+                    be.sourcedir = os.environ.get('TOASTER_DIR')
                     return True
 
                 if len(be.sourcedir) == 0:
@@ -103,23 +77,13 @@ class Command(NoArgsCommand):
                     print "\n -- Validation: The layers checkout directory must be set to an absolute path."
                     is_changed = _update_sourcedir()
 
-                if not be.sourcedir in DN(__file__):
-                    print "\n -- Validation: The layers checkout directory must be a parent of the current checkout."
-                    is_changed = _update_sourcedir()
-
                 if is_changed:
                     if be.betype == BuildEnvironment.TYPE_LOCAL:
                         be.needs_import = True
                     return True
 
                 def _update_builddir():
-                    suggesteddir = self._get_suggested_builddir(be)
-                    if len(suggesteddir) > 0:
-                        be.builddir = raw_input("Toaster needs to know where your build directory is located.\nThe build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\nPress Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
-                    else:
-                        be.builddir = raw_input("Toaster needs to know where is your build directory.\nThe build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environ.get('HOME','/tmp/'))
-                    if len(be.builddir) == 0 and len(suggesteddir) > 0:
-                        be.builddir = suggesteddir
+                    be.builddir = os.environ.get('TOASTER_DIR')+"/build"
                     return True
 
                 if len(be.builddir) == 0:
@@ -138,79 +102,51 @@ class Command(NoArgsCommand):
 
 
                 if be.needs_import:
-                    print "\nToaster can use a SINGLE predefined configuration file to set up default project settings and layer information sources.\n"
-
-                    # find configuration files
-                    config_files = []
-                    for dirname in self._recursive_list_directories(be.sourcedir,2):
-                        if os.path.exists(os.path.join(dirname, ".templateconf")):
-                            import subprocess
-                            proc = subprocess.Popen('bash -c ". '+os.path.join(dirname, ".templateconf")+'; echo \"\$TEMPLATECONF\""', shell=True, stdout=subprocess.PIPE)
-                            conffilepath, stderroroutput = proc.communicate()
-                            proc.wait()
-                            if proc.returncode != 0:
-                                raise Exception("Failed to source TEMPLATECONF: %s" % stderroroutput)
-
-                            conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
-                            candidatefilepath = os.path.join(dirname, conffilepath)
-                            if "toaster_cloned" in candidatefilepath:
-                                continue
-                            if os.path.exists(candidatefilepath):
-                                config_files.append(candidatefilepath)
-
-                    if len(config_files) > 0:
-                        print "Toaster will list now the configuration files that it found. Select the number to use the desired configuration file."
-                        for cf in config_files:
-                            print "  [%d] - %s" % (config_files.index(cf) + 1, cf)
-                        print "\n  [0] - Exit without importing any file"
-                        try:
-                                i = raw_input("\nEnter your option: ")
-                                if len(i) and (int(i) - 1 >= 0 and int(i) - 1 < len(config_files)):
-                                    print "\nImporting file: %s" % config_files[int(i)-1]
-                                    from loadconf import Command as LoadConfigCommand
-
-                                    LoadConfigCommand()._import_layer_config(config_files[int(i)-1])
-                                    # we run lsupdates after config update
-                                    print "\nLayer configuration imported. Updating information from the layer sources, please wait.\nYou can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
-                                    from django.core.management import call_command
-                                    call_command("lsupdates")
-
-                                    # we don't look for any other config files
-                                    return is_changed
-                        except Exception as e:
-                            print "Failure while trying to import the toaster config file: %s" % e
-                            traceback.print_exc(e)
-                    else:
-                        print "\nToaster could not find a configuration file. You need to configure Toaster manually using the web interface, or create a configuration file and use\n  bitbake/lib/toaster/managepy.py loadconf [filename]\n command to load it. You can use https://wiki.yoctoproject.org/wiki/File:Toasterconf.json.txt.patch as a starting point."
-
-
-
+                    try:
+                        config_file = os.environ.get('TOASTER_CONF')
+                        print "\nImporting file: %s" % config_file
+                        from loadconf import Command as LoadConfigCommand
+
+                        LoadConfigCommand()._import_layer_config(config_file)
+                        # we run lsupdates after config update
+                        print "\nLayer configuration imported. Updating information from the layer sources, please wait.\nYou can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
+                        from django.core.management import call_command
+                        call_command("lsupdates")
+
+                        # we don't look for any other config files
+                        return is_changed
+                    except Exception as e:
+                        print "Failure while trying to import the toaster config file %s: %s" %\
+                            (config_file, e)
+                        traceback.print_exc(e)
 
                 return is_changed
 
-            while (_verify_be()):
+            while _verify_be():
                 pass
         return 0
 
     def _verify_default_settings(self):
         # verify that default settings are there
-        if ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').count() != 1:
-            ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').delete()
-            ToasterSetting.objects.get_or_create(name = 'DEFAULT_RELEASE', value = '')
+        if ToasterSetting.objects.filter(name='DEFAULT_RELEASE').count() != 1:
+            ToasterSetting.objects.filter(name='DEFAULT_RELEASE').delete()
+            ToasterSetting.objects.get_or_create(name='DEFAULT_RELEASE', value='')
         return 0
 
     def _verify_builds_in_progress(self):
         # we are just starting up. we must not have any builds in progress, or build environments taken
-        for b in BuildRequest.objects.filter(state = BuildRequest.REQ_INPROGRESS):
-            BRError.objects.create(req = b, errtype = "toaster", errmsg = "Toaster found this build IN PROGRESS while Toaster started up. This is an inconsistent state, and the build was marked as failed")
+        for b in BuildRequest.objects.filter(state=BuildRequest.REQ_INPROGRESS):
+            BRError.objects.create(req=b, errtype="toaster",
+                                   errmsg=
+                                   "Toaster found this build IN PROGRESS while Toaster started up. This is an inconsistent state, and the build was marked as failed")
 
-        BuildRequest.objects.filter(state = BuildRequest.REQ_INPROGRESS).update(state = BuildRequest.REQ_FAILED)
+        BuildRequest.objects.filter(state=BuildRequest.REQ_INPROGRESS).update(state=BuildRequest.REQ_FAILED)
 
-        BuildEnvironment.objects.update(lock = BuildEnvironment.LOCK_FREE)
+        BuildEnvironment.objects.update(lock=BuildEnvironment.LOCK_FREE)
 
         # also mark "In Progress builds as failures"
         from django.utils import timezone
-        Build.objects.filter(outcome = Build.IN_PROGRESS).update(outcome = Build.FAILED, completed_on = timezone.now())
+        Build.objects.filter(outcome=Build.IN_PROGRESS).update(outcome=Build.FAILED, completed_on=timezone.now())
 
         return 0
 
-- 
2.1.4


