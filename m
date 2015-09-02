Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7A56276FE2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Sep 2015 09:56:43 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Sep 2015 02:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,452,1437462000"; d="scan'208";a="796558883"
Received: from gionescx-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.26.81])
	by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2015 02:56:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 10:56:15 +0100
Message-Id: <1441187775-28018-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: improve explanation of checkout dir
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
X-List-Received-Date: Wed, 02 Sep 2015 09:56:46 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Improve the explanation we show to users during set up
when asking them to set the layers checkout directory.

The patch also makes minor changes in text formatting to
improve legibility.

[YOCTO #7740]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../management/commands/checksettings.py           | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
index 83b4f28..3ccc7c6 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -69,8 +69,8 @@ class Command(NoArgsCommand):
         # verify that we have a settings for downloading artifacts
         while ToasterSetting.objects.filter(name="ARTIFACTS_STORAGE_DIR").count() == 0:
             guessedpath = os.getcwd() + "/toaster_build_artifacts/"
-            print("Toaster needs to know in which directory it can download build log files and other artifacts.\n Toaster suggests \"%s\"." % guessedpath)
-            artifacts_storage_dir = raw_input(" Press Enter to select \"%s\" or type the full path to a different directory: " % guessedpath)
+            print("\nToaster needs to know in which directory it can download build log files and other artifacts.\nToaster suggests \"%s\"." % guessedpath)
+            artifacts_storage_dir = raw_input("Press Enter to select \"%s\" or type the full path to a different directory: " % guessedpath)
             if len(artifacts_storage_dir) == 0:
                 artifacts_storage_dir = guessedpath
             if len(artifacts_storage_dir) > 0 and artifacts_storage_dir.startswith("/"):
@@ -104,28 +104,28 @@ class Command(NoArgsCommand):
             be.needs_import = False
             def _verify_be():
                 is_changed = False
-                print("Verifying the Build Environment. If the local Build Environment is not properly configured, you will be asked to configure it.")
+                print("\nVerifying the build environment. If the local build environment is not properly configured, you will be asked to configure it.")
 
                 def _update_sourcedir():
                     suggesteddir = self._get_suggested_sourcedir(be)
                     if len(suggesteddir) > 0:
-                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the layers that will be needed for your builds.\n Toaster suggests \"%s\". If you select this directory, a layer like \"meta-intel\" will end up in \"%s/meta-intel\".\n Press Enter to select \"%s\" or type the full path to a different directory (must be a parent of current checkout directory): " % (suggesteddir, suggesteddir, suggesteddir))
+                        be.sourcedir = raw_input("This is the directory Toaster uses to check out the source code of the layers you will build. Toaster will create new clones of the layers, so existing content in the chosen directory will not be changed.\nToaster suggests you use \"%s\" as your layers checkout directory. If you select this directory, a layer like \"meta-intel\" will end up in \"%s/meta-intel\".\nPress Enter to select \"%s\" or type the full path to a different directory. If you provide your own directory, it must be a parent of the cloned directory for the sources you are using to run Toaster: " % (suggesteddir, suggesteddir, suggesteddir))
                     else:
-                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the layers that will be needed for your builds. Type the full path to the directory (for example: \"%s\": " % os.environ.get('HOME', '/tmp/'))
+                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the source code of the layers you will build. The directory should be a parent of the cloned directory for the sources you are using to run Toaster. Toaster will create new clones of the layers, so existing content in the chosen directory will not be changed.\nType the full path to the directory (for example: \"%s\": " % os.environ.get('HOME', '/tmp/'))
                     if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
                         be.sourcedir = suggesteddir
                     return True
 
                 if len(be.sourcedir) == 0:
-                    print "\n -- Validation: The checkout directory must be set."
+                    print "\n -- Validation: The layers checkout directory must be set."
                     is_changed = _update_sourcedir()
 
                 if not be.sourcedir.startswith("/"):
-                    print "\n -- Validation: The checkout directory must be set to an absolute path."
+                    print "\n -- Validation: The layers checkout directory must be set to an absolute path."
                     is_changed = _update_sourcedir()
 
                 if not be.sourcedir in DN(__file__):
-                    print "\n -- Validation: The checkout directory must be a parent of the current checkout."
+                    print "\n -- Validation: The layers checkout directory must be a parent of the current checkout."
                     is_changed = _update_sourcedir()
 
                 if is_changed:
@@ -136,9 +136,9 @@ class Command(NoArgsCommand):
                 def _update_builddir():
                     suggesteddir = self._get_suggested_builddir(be)
                     if len(suggesteddir) > 0:
-                        be.builddir = raw_input("Toaster needs to know where your build directory is located.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
+                        be.builddir = raw_input("Toaster needs to know where your build directory is located.\nThe build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\nPress Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
                     else:
-                        be.builddir = raw_input("Toaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environ.get('HOME','/tmp/'))
+                        be.builddir = raw_input("Toaster needs to know where is your build directory.\nThe build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environ.get('HOME','/tmp/'))
                     if len(be.builddir) == 0 and len(suggesteddir) > 0:
                         be.builddir = suggesteddir
                     return True
@@ -153,7 +153,7 @@ class Command(NoArgsCommand):
 
 
                 if is_changed:
-                    print "Build configuration saved"
+                    print "\nBuild configuration saved"
                     be.save()
                     return True
 
@@ -180,19 +180,19 @@ class Command(NoArgsCommand):
                                 config_files.append(candidatefilepath)
 
                     if len(config_files) > 0:
-                        print " Toaster will list now the configuration files that it found. Select the number to use the desired configuration file."
+                        print "Toaster will list now the configuration files that it found. Select the number to use the desired configuration file."
                         for cf in config_files:
                             print "  [%d] - %s" % (config_files.index(cf) + 1, cf)
                         print "\n  [0] - Exit without importing any file"
                         try:
-                                i = raw_input("\n Enter your option: ")
+                                i = raw_input("\nEnter your option: ")
                                 if len(i) and (int(i) - 1 >= 0 and int(i) - 1 < len(config_files)):
-                                    print "Importing file: %s" % config_files[int(i)-1]
+                                    print "\nImporting file: %s" % config_files[int(i)-1]
                                     from loadconf import Command as LoadConfigCommand
 
                                     LoadConfigCommand()._import_layer_config(config_files[int(i)-1])
                                     # we run lsupdates after config update
-                                    print "Layer configuration imported. Updating information from the layer sources, please wait.\n You can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
+                                    print "\nLayer configuration imported. Updating information from the layer sources, please wait.\nYou can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
                                     from django.core.management import call_command
                                     call_command("lsupdates")
 
@@ -202,7 +202,7 @@ class Command(NoArgsCommand):
                             print "Failure while trying to import the toaster config file: %s" % e
                             traceback.print_exc(e)
                     else:
-                        print "\n Toaster could not find a configuration file. You need to configure Toaster manually using the web interface, or create a configuration file and use\n  bitbake/lib/toaster/managepy.py loadconf [filename]\n command to load it. You can use https://wiki.yoctoproject.org/wiki/File:Toasterconf.json.txt.patch as a starting point."
+                        print "\nToaster could not find a configuration file. You need to configure Toaster manually using the web interface, or create a configuration file and use\n  bitbake/lib/toaster/managepy.py loadconf [filename]\n command to load it. You can use https://wiki.yoctoproject.org/wiki/File:Toasterconf.json.txt.patch as a starting point."
 
 
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


