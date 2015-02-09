Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5BE67606E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:07 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id et14so35255877pad.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=35b7oVcYnpMAMBC2fnT4dwfwGAxlWdYsQCIAbqiyQ7I=;
	b=ju4/ohcR1M5VUXlnSyO2hljRDeL9ufD6icGBcmFEknaxBfX+phgb1G1zFnkAKDwGxs
	0EOrqDr91DNmQxEcdzzn/QqN4HDAYSrq9CW2ihUcjJmqDFV98s7rFcPDtgfh+rRCg3OY
	eLdiHe5T8nRQIml1e0693OPsRuLfYYnnHJMTdgaD5JxqXXf77XK82sdqG/OwVfekLVJW
	B8WqFgg4J1XRV4/M3mEhTCy6gaNJ5gvfvG8o+XuwaJrzXeo7HcIT4jvTcv31IZR5iT39
	SLFP74K/Huqp5jWE8n4HFSrnubmcXjBWTepwUu885BpCzOOSdOkd3bDbm07ru2Jorrw9
	+WSw==
X-Gm-Message-State: ALoCoQkLJWH2kGKmENWC0FuhYxjmzEMVis5DWlu9/xgDdjSZuoMlu+4qJQhjRmam9LhxOKg145W6
X-Received: by 10.68.189.41 with SMTP id gf9mr30593866pbc.21.1423504928868;
	Mon, 09 Feb 2015 10:02:08 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id b1sm17032784pdi.10.2015.02.09.10.02.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5130F566172; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:37 +0000
Message-Id: <c5ddd9d88910857a1b745b1c237df0390dd56835.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 07/27] toaster: enhancements for the startup sequence
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch brings fixes and enhancements in the startup sequence.

- the dependency version checking is now correctly enforced when
starting in both modes
- fixed errors in looking up environment variables
- added message with 'daemon' program start location
- presenting menu for selecting config file

[YOCTO #7283]
[YOCTO #7291]
[YOCTO #7273]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        | 37 +++++++----
 .../management/commands/checksettings.py           | 76 +++++++++++++++++-----
 2 files changed, 84 insertions(+), 29 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6f7c6f0..c3b8633 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -126,17 +126,20 @@ function notify_chldexit() {
 }
 
 
-# Verify prerequisites
+function verify_prereq() {
+	# Verify prerequisites
 
-if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (5,6)" | python 2>/dev/null | grep True >/dev/null; then
-    echo -e "This program needs Django 1.5 or 1.6. Please install with\n\npip install django==1.6"
-    return 2
-fi
+    if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (5,6)" | python 2>/dev/null | grep True >/dev/null; then
+        echo -e "This program needs Django 1.5 or 1.6. Please install with\n\npip install django==1.6\n"
+        return 2
+    fi
 
-if ! echo "import south; print [0,8,4] ==  map(int,south.__version__.split(\".\"))" | python 2>/dev/null | grep True >/dev/null; then
-    echo -e "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4"
-    return 2
-fi
+    if ! echo "import south; print reduce(lambda x, y: 2 if x==2 else 0 if x == 0 else y, map(lambda x: 1+cmp(x[1]-x[0],0), zip([0,8,4], map(int,south.__version__.split(\".\"))))) > 0" | python 2>/dev/null | grep True >/dev/null; then
+        echo -e "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4\n"
+        return 2
+    fi
+    return 0
+}
 
 
 # read command line parameters
@@ -170,13 +173,18 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
+    if ! verify_prereq; then
+        echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2;
+        exit 1;
+    fi
+
     if [ -n "$BUILDDIR" ]; then
-	echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment. You can work around this problem by starting Toaster from a new terminal window." 1>&2;
+	echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2;
         exit 1;
     fi
 
     if [ "x`which daemon`" == "x" ]; then
-        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program." 1>&2;
+        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program from your distribution repositories or http://www.libslack.org/daemon/" 1>&2;
 	exit 1;
     fi
 
@@ -208,6 +216,13 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     exit 0
 fi
 
+
+if ! verify_prereq; then
+	echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2;
+	return 1;
+fi
+
+
 # We make sure we're running in the current shell and in a good environment
 if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
     echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index cf3c3d7..5d80bc7 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -78,44 +78,68 @@ class Command(NoArgsCommand):
 
         # we make sure we have builddir and sourcedir for all defined build envionments
         for be in BuildEnvironment.objects.all():
+            be.needs_import = False
             def _verify_be():
                 is_changed = False
-                print("Verifying the Build Environment. If the Build Environment is completly configured, you will be asked to configure it.")
-                if len(be.sourcedir) == 0:
+                print("Verifying the Build Environment. If the local Build Environment is not properly configured, you will be asked to configure it.")
+
+                def _update_sourcedir():
                     suggesteddir = self._get_suggested_sourcedir(be)
                     if len(suggesteddir) > 0:
-                        be.sourcedir = raw_input("\nToaster needs to know in which directory it should check out the layers that will be needed for your builds.\n Toaster suggests \"%s\". If you select this directory, a layer like \"meta-yocto\" will end up in \"%s/meta-yocto\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir, suggesteddir))
+                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the layers that will be needed for your builds.\n Toaster suggests \"%s\". If you select this directory, a layer like \"meta-intel\" will end up in \"%s/meta-intel\".\n Press Enter to select \"%s\" or type the full path to a different directory (must be a parent of current checkout directory): " % (suggesteddir, suggesteddir, suggesteddir))
                     else:
-                        be.sourcedir = raw_input("\nToaster needs to know in which directory it should check out the layers that will be needed for your builds. Type the full path to the directory (for example: \"%s\": " % os.environment['HOME'])
+                        be.sourcedir = raw_input("Toaster needs to know in which directory it should check out the layers that will be needed for your builds. Type the full path to the directory (for example: \"%s\": " % os.environ.get('HOME', '/tmp/'))
                     if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
                         be.sourcedir = suggesteddir
-                    is_changed = True
+                    return True
+
+                if len(be.sourcedir) == 0:
+                    print "\n -- Validation: The checkout directory must be set."
+                    is_changed = _update_sourcedir()
 
                 if not be.sourcedir.startswith("/"):
-                    be.sourcedir = raw_input(" Layer sources checkout directory must be an absolute path:")
-                    is_changed = True
+                    print "\n -- Validation: The checkout directory must be set to an absolute path."
+                    is_changed = _update_sourcedir()
 
-                if len(be.builddir) == 0:
+                if not be.sourcedir in DN(__file__):
+                    print "\n -- Validation: The checkout directory must be a parent of the current checkout."
+                    is_changed = _update_sourcedir()
+
+                if is_changed:
+                    if be.betype == BuildEnvironment.TYPE_LOCAL:
+                        be.needs_import = True
+                    return True
+
+                def _update_builddir():
                     suggesteddir = self._get_suggested_builddir(be)
                     if len(suggesteddir) > 0:
-                        be.builddir = raw_input("\nToaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
+                        be.builddir = raw_input("Toaster needs to know where it your build directory is located.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
                     else:
-                        be.builddir = raw_input("\nToaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environment['HOME'])
+                        be.builddir = raw_input("Toaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environ.get('HOME','/tmp/'))
                     if len(be.builddir) == 0 and len(suggesteddir) > 0:
                         be.builddir = suggesteddir
-                    is_changed = True
+                    return True
+
+                if len(be.builddir) == 0:
+                    print "\n -- Validation: The build directory must be set."
+                    is_changed = _update_builddir()
 
                 if not be.builddir.startswith("/"):
-                    be.builddir = raw_input(" Build directory must be an absolute path:")
-                    is_changed = True
+                    print "\n -- Validation: The build directory must to be set to an absolute path."
+                    is_changed = _update_builddir()
 
 
                 if is_changed:
                     print "Build configuration saved"
                     be.save()
+                    return True
+
+
+                if be.needs_import:
+                    print "\nToaster can use a SINGLE predefined configuration file to set up default project settings and layer information sources.\n"
 
-                if is_changed and be.betype == BuildEnvironment.TYPE_LOCAL:
-                    print "\nToaster can use a SINGLE predefined configuration file to set up default project settings and layer information sources.\n Toaster will list now the configuration files that it found. Select Yes to use the desired configuration file."
+                    # find configuration files
+                    config_files = []
                     for dirname in self._recursive_list_directories(be.sourcedir,2):
                         if os.path.exists(os.path.join(dirname, ".templateconf")):
                             import subprocess
@@ -123,11 +147,20 @@ class Command(NoArgsCommand):
                             conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
                             candidatefilepath = os.path.join(dirname, conffilepath)
                             if os.path.exists(candidatefilepath):
-                                i = raw_input("\n Found an preset configuration file \"%s\".\n Do you want to use it? (y/N):" % candidatefilepath)
-                                if len(i) and i.upper()[0] == 'Y':
+                                config_files.append(candidatefilepath)
+
+                    if len(config_files) > 0:
+                        print " Toaster will list now the configuration files that it found. Select the number to use the desired configuration file."
+                        for cf in config_files:
+                            print "  [%d] - %s" % (config_files.index(cf) + 1, cf)
+                        print "\n  [0] - Exit without importing any file"
+                        try:
+                                i = raw_input("\n Enter your option: ")
+                                if len(i) and (int(i) - 1 >= 0 and int(i) - 1 < len(config_files)):
+                                    print "Importing file: %s" % config_files[int(i)-1]
                                     from loadconf import Command as LoadConfigCommand
 
-                                    LoadConfigCommand()._import_layer_config(candidatefilepath)
+                                    LoadConfigCommand()._import_layer_config(config_files[int(i)-1])
                                     # we run lsupdates after config update
                                     print "Layer configuration imported. Updating information from the layer sources, please wait.\n You can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
                                     from django.core.management import call_command
@@ -135,6 +168,13 @@ class Command(NoArgsCommand):
 
                                     # we don't look for any other config files
                                     return is_changed
+                        except Exception as e:
+                            print "Failure while trying to import the toaster config file: %s" % e
+                    else:
+                        print "\n Toaster could not find a configuration file. You need to configure Toaster manually using the web interface, or create a configuration file and use\n  bitbake/lib/toaster/managepy.py loadconf [filename]\n command to load it. You can use https://wiki.yoctoproject.org/wiki/File:Toasterconf.json.txt.patch as a starting point."
+
+
+
 
                 return is_changed
 
-- 
1.9.1


