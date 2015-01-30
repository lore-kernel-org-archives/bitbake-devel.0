Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3D4EB60034
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 14:28:33 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id eu11so52975060pac.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 06:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iUZ5lkwRLk3D1uDd10bSbglBgCwmxHAoxZAdKMMtxVE=;
	b=T1qIOGGeCi7SaBV2chOX2vu/GuMeihPEmRDE8AFsdqg2kzu15EeqaHwc0+CHjKsWhO
	HDenCsZf5cST4yBmgt5lgkbXLUUEWihM4IJZ+BdLPxWwv8fF4Aml8XAOUNW7LSqeiAyn
	ZJPUna/HF6gtcvCkXa3jlgDBS529FU1bwOtjzdy14NXaNByTBjesMBq+bPk7zAEmbp7u
	aWnl3DfDBGzwBDHAw6l9NA9EefYcmgCgITKmPf6dGWLbABNPlWkX5ORaDzdanlBN5AzL
	odjk6LQD3AskCdxyXBfhFu7xs6JNQwsZSvtkT3IdnrbXw1xdm7nlXST3kzcR8b2Wd+NG
	L1yA==
X-Gm-Message-State: ALoCoQl6lLfVM5UdwejOJTq8/i9CKA8je7ZdoetxY8LQomxJVBtWmIbXkd0BoItXv+QAE1DchpJF
X-Received: by 10.68.202.98 with SMTP id kh2mr9536600pbc.6.1422628114720;
	Fri, 30 Jan 2015 06:28:34 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id mz7sm11032840pdb.3.2015.01.30.06.28.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Jan 2015 06:28:34 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 94C15561F4A; Fri, 30 Jan 2015 14:28:31 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Jan 2015 14:28:29 +0000
Message-Id: <90ef8975f35e2da824bc1c80e41ca26d9af0b208.1422627985.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1422627985.git.alexandru.damian@intel.com>
References: <cover.1422627985.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/2] toaster: update texts for the startup sequence
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
X-List-Received-Date: Fri, 30 Jan 2015 14:28:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch updates the prompts to the user to better explain
what Toaster is doing and the information it needs from the user.

Additionally, fixes a check in loadconf command.

[YOCTO #6785]
[YOCTO #7251]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                         |  6 +++---
 .../bldcontrol/management/commands/checksettings.py | 21 ++++++++++++++-------
 .../bldcontrol/management/commands/loadconf.py      |  2 +-
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index a6d2e92..4f25293 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -68,7 +68,7 @@ function webserverStartAll()
 		python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
 	fi
         if [ $retval -eq 0 ]; then
-	    echo "Starting webserver"
+	    echo "Starting webserver..."
             python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >${BUILDDIR}/toaster_web_$$.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
             if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
@@ -171,7 +171,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
     if [ -n "$BUILDDIR" ]; then
-        echo -e "Error: build/ directory detected. Toaster will not start in managed mode if a build environment is detected.\nUse a clean terminal to start Toaster." 1>&2;
+	echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment. You can work around this problem by starting Toaster from a new terminal window." 1>&2;
         exit 1;
     fi
 
@@ -194,7 +194,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         xdg-open http://127.0.0.1:$WEB_PORT/ >/dev/null 2>&1 &
     fi
     trap trap_ctrlc SIGINT
-    echo "Running. Stop with Ctrl-C"
+    echo "Toaster is now running. You can stop it with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
 	python $BBBASEDIR/lib/toaster/manage.py runbuilds
 	sleep 1
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 55f118c..cf3c3d7 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -80,27 +80,33 @@ class Command(NoArgsCommand):
         for be in BuildEnvironment.objects.all():
             def _verify_be():
                 is_changed = False
-                print("Verifying the Build Environment type %s id %d." % (be.get_betype_display(), be.pk))
+                print("Verifying the Build Environment. If the Build Environment is completly configured, you will be asked to configure it.")
                 if len(be.sourcedir) == 0:
                     suggesteddir = self._get_suggested_sourcedir(be)
-                    be.sourcedir = raw_input(" -- Layer sources checkout directory may not be empty [guessed \"%s\"]:" % suggesteddir)
+                    if len(suggesteddir) > 0:
+                        be.sourcedir = raw_input("\nToaster needs to know in which directory it should check out the layers that will be needed for your builds.\n Toaster suggests \"%s\". If you select this directory, a layer like \"meta-yocto\" will end up in \"%s/meta-yocto\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir, suggesteddir))
+                    else:
+                        be.sourcedir = raw_input("\nToaster needs to know in which directory it should check out the layers that will be needed for your builds. Type the full path to the directory (for example: \"%s\": " % os.environment['HOME'])
                     if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
                         be.sourcedir = suggesteddir
                     is_changed = True
 
                 if not be.sourcedir.startswith("/"):
-                    be.sourcedir = raw_input(" -- Layer sources checkout directory must be an absolute path:")
+                    be.sourcedir = raw_input(" Layer sources checkout directory must be an absolute path:")
                     is_changed = True
 
                 if len(be.builddir) == 0:
                     suggesteddir = self._get_suggested_builddir(be)
-                    be.builddir = raw_input(" -- Build directory may not be empty [guessed \"%s\"]:" % suggesteddir)
+                    if len(suggesteddir) > 0:
+                        be.builddir = raw_input("\nToaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Toaster suggests \"%s\".\n Press Enter to select \"%s\" or type the full path to a different directory: " % (suggesteddir, suggesteddir))
+                    else:
+                        be.builddir = raw_input("\nToaster needs to know where is your build directory.\n The build directory is where all the artifacts created by your builds will be stored. Type the full path to the directory (for example: \" %s/build\")" % os.environment['HOME'])
                     if len(be.builddir) == 0 and len(suggesteddir) > 0:
                         be.builddir = suggesteddir
                     is_changed = True
 
                 if not be.builddir.startswith("/"):
-                    be.builddir = raw_input(" -- Build directory must be an absolute path:")
+                    be.builddir = raw_input(" Build directory must be an absolute path:")
                     is_changed = True
 
 
@@ -109,6 +115,7 @@ class Command(NoArgsCommand):
                     be.save()
 
                 if is_changed and be.betype == BuildEnvironment.TYPE_LOCAL:
+                    print "\nToaster can use a SINGLE predefined configuration file to set up default project settings and layer information sources.\n Toaster will list now the configuration files that it found. Select Yes to use the desired configuration file."
                     for dirname in self._recursive_list_directories(be.sourcedir,2):
                         if os.path.exists(os.path.join(dirname, ".templateconf")):
                             import subprocess
@@ -116,13 +123,13 @@ class Command(NoArgsCommand):
                             conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
                             candidatefilepath = os.path.join(dirname, conffilepath)
                             if os.path.exists(candidatefilepath):
-                                i = raw_input(" -- Do you want to import basic layer configuration from \"%s\" ? (y/N):" % candidatefilepath)
+                                i = raw_input("\n Found an preset configuration file \"%s\".\n Do you want to use it? (y/N):" % candidatefilepath)
                                 if len(i) and i.upper()[0] == 'Y':
                                     from loadconf import Command as LoadConfigCommand
 
                                     LoadConfigCommand()._import_layer_config(candidatefilepath)
                                     # we run lsupdates after config update
-                                    print "Layer configuration imported. Updating information from the layer source, please wait."
+                                    print "Layer configuration imported. Updating information from the layer sources, please wait.\n You can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
                                     from django.core.management import call_command
                                     call_command("lsupdates")
 
diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index 2257a71..e2f61e4 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -22,7 +22,7 @@ def _get_id_for_sourcetype(s):
     for i in LayerSource.SOURCE_TYPE:
         if s == i[1]:
             return i[0]
-    raise Exception("Could not find definition for sourcetype " + s)
+    raise Exception("Could not find definition for sourcetype '%s'. Valid source types are %s" % (str(s), ', '.join(map(lambda x: "'%s'" % x[1], LayerSource.SOURCE_TYPE ))))
 
 class Command(BaseCommand):
     help = "Loads a toasterconf.json file in the database"
-- 
1.9.1


