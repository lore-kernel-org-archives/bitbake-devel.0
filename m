Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 6045571190
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:50 +0000 (UTC)
Received: by mail-wg0-f49.google.com with SMTP id k14so544098wgh.32
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=aCETpmPAFAwZuNK2dekWd6yJISTAuyZJnCZQH0otYCs=;
	b=OS/lFM8jAl48OkZ9AqsLG6gNds+oEgdQ6I7oOY3+lN70Lp1SlgZt0Otvs3kMHDE4mG
	QcGUPkdbLsh4y9hwQkdQF+p/bBdber9iHT0hiD+L2Bxp0mDseN+BCKp/EyAGfrH9b+1H
	dHMDlAf1tXMKVreg0VM20LZWunhyv6gKBLfVILK1IhyrCD3uDcJkfm6kcvKC5tYGbkKx
	ezTJVOf7yyhOYSGVa/ijPHagdQhdajOTxYmvxU/9IBqAFUvAdnL6nEKL2KFBk2gotiIL
	GqVouCKSuAP1XBd/Qj6Qz7EGs2uetjk+nx/AN+lT3uhBRywmH74UQJTUi2Nelr0OcAca
	AY/w==
X-Gm-Message-State: ALoCoQn5M2oYz14KsJQwSwKoVnLjoCvNEs27qvrvglRO2LqbasemJbkWVFdUtOEBO73/UoO6dV5Z
X-Received: by 10.194.78.100 with SMTP id a4mr5129517wjx.106.1409160231187;
	Wed, 27 Aug 2014 10:23:51 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ky3sm2596616wjb.39.2014.08.27.10.23.48
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:49 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 95F9E5611B0; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:39 +0100
Message-Id: <2c5d8c6cc34447e29fe7408a4098bc762b14c607.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 07/11] toaster: update checksettings command for auto-detection
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We enhance the checksettings command to try to automatically
detect settings for running on localhost.

The checksettings will look for a nearby poky layer source,
for a nearby build directory, and will try to import settings
from "toasterconf.json" files found in the local layer.

On new configuration, it will also perform updates from the
layer source.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   9 +-
 .../management/commands/checksettings.py           | 190 ++++++++++++++++++++-
 2 files changed, 188 insertions(+), 11 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ce16de6..2fabe5c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -65,10 +65,10 @@ function webserverStartAll()
         fi
 	if [ "x$TOASTER_MANAGED" == "x1" ]; then
 	        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-		python $BBBASEDIR/lib/toaster/manage.py checksettings  || retval=1
+		python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
 	fi
-	echo "Starting webserver"
         if [ $retval -eq 0 ]; then
+	    echo "Starting webserver"
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
             if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
@@ -144,7 +144,10 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     }
     TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
-    webserverStartAll || (echo "Fail to start the web server, stopping" 1>&2 && exit 1)
+    if ! webserverStartAll; then
+        echo "Failed to start the web server, stopping" 1>&2;
+        exit 1;
+    fi
     xdg-open http://0.0.0.0:8000/ >/dev/null 2>&1 &
     trap trap_ctrlc SIGINT
     echo "Running. Stop with Ctrl-C"
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index a91dd15..4f6a66e 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -1,38 +1,212 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
-from orm.models import Build
+from orm.models import LayerSource, ToasterSetting, Branch, Layer, Layer_Version
+from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer
 from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
 from bldcontrol.models import BuildRequest, BuildEnvironment
 import os
 
+def DN(path):
+    if path is None:
+        return ""
+    else:
+        return os.path.dirname(path)
+
+
 class Command(NoArgsCommand):
     args = ""
-    help = "Verifies thid %dthe configured settings are valid and usable, or prompts the user to fix the settings."
+    help = "Verifies that the configured settings are valid and usable, or prompts the user to fix the settings."
+
+    def _reduce_canon_path(self, path):
+        components = []
+        for c in path.split("/"):
+            if c == "..":
+                del components[-1]
+            elif c == ".":
+                pass
+            else:
+                components.append(c)
+        return "/".join(components)
+
+    def _find_first_path_for_file(self, startdirectory, filename, level = 0):
+        if level < 0:
+            return None
+        dirs = []
+        for i in os.listdir(startdirectory):
+            j = os.path.join(startdirectory, i)
+            if os.path.isfile(j):
+                if i == filename:
+                    return startdirectory
+            elif os.path.isdir(j):
+                dirs.append(j)
+        for j in dirs:
+            ret = self._find_first_path_for_file(j, filename, level - 1)
+            if ret is not None:
+                return ret
+        return None
+
+    def _get_suggested_sourcedir(self, be):
+        if be.betype != BuildEnvironment.TYPE_LOCAL:
+            return ""
+        return DN(DN(DN(self._find_first_path_for_file(self.guesspath, "toasterconf.json", 4))))
+
+    def _get_suggested_builddir(self, be):
+        if be.betype != BuildEnvironment.TYPE_LOCAL:
+            return ""
+        return DN(self._find_first_path_for_file(self.guesspath, "bblayers.conf", 3))
+
+    def _import_layer_config(self, baselayerdir):
+        filepath = os.path.join(baselayerdir, "meta/conf/toasterconf.json")
+        if not os.path.exists(filepath) or not os.path.isfile(filepath):
+            raise Exception("Failed to find toaster config file %s ." % filepath)
+
+        import json, pprint
+        data = json.loads(open(filepath, "r").read())
+
+        # verify config file validity before updating settings
+        for i in ['bitbake', 'releases', 'defaultrelease', 'config', 'layersources']:
+            assert i in data
+
+        # import bitbake data
+        for bvi in data['bitbake']:
+            bvo, created = BitbakeVersion.objects.get_or_create(name=bvi['name'])
+            bvo.giturl = bvi['giturl']
+            bvo.branch = bvi['branch']
+            bvo.dirpath = bvi['dirpath']
+            bvo.save()
+
+        # set the layer sources
+        for lsi in data['layersources']:
+            assert 'sourcetype' in lsi
+            assert 'apiurl' in lsi
+            assert 'name' in lsi
+            assert 'branches' in lsi
+
+            if lsi['sourcetype'] == LayerSource.TYPE_LAYERINDEX or lsi['apiurl'].startswith("/"):
+                apiurl = lsi['apiurl']
+            else:
+                apiurl = self._reduce_canon_path(os.path.join(DN(filepath), lsi['apiurl']))
+
+            try:
+                ls = LayerSource.objects.get(sourcetype = lsi['sourcetype'], apiurl = apiurl)
+            except LayerSource.DoesNotExist:
+                ls = LayerSource.objects.create(
+                    name = lsi['name'],
+                    sourcetype = lsi['sourcetype'],
+                    apiurl = apiurl
+                )
+
+            layerbranches = []
+            for branchname in lsi['branches']:
+                bo, created = Branch.objects.get_or_create(layer_source = ls, name = branchname)
+                layerbranches.append(bo)
+
+            if 'layers' in lsi:
+                for layerinfo in lsi['layers']:
+                    lo, created = Layer.objects.get_or_create(layer_source = ls, name = layerinfo['name'])
+                    if layerinfo['local_path'].startswith("/"):
+                        lo.local_path = layerinfo['local_path']
+                    else:
+                        lo.local_path = self._reduce_canon_path(os.path.join(DN(filepath), layerinfo['local_path']))
+                    lo.layer_index_url = layerinfo['layer_index_url']
+                    if 'vcs_url' in layerinfo:
+                        lo.vcs_url = layerinfo['vcs_url']
+                    lo.save()
+
+                    for branch in layerbranches:
+                        lvo, created = Layer_Version.objects.get_or_create(layer_source = ls,
+                                up_branch = branch,
+                                commit = branch.name,
+                                layer = lo)
+                        lvo.dirpath = layerinfo['dirpath']
+                        lvo.save()
+        # set releases
+        for ri in data['releases']:
+            bvo = BitbakeVersion.objects.get(name = ri['bitbake'])
+            assert bvo is not None
+
+            ro, created = Release.objects.get_or_create(name = ri['name'], bitbake_version = bvo)
+            ro.description = ri['description']
+            ro.branch = ri['branch']
+            ro.save()
+
+            for dli in ri['defaultlayers']:
+                lsi, layername = dli.split(":")
+                layer, created = Layer.objects.get_or_create( 
+                        layer_source = LayerSource.objects.get(name = lsi),
+                        name = layername
+                    )
+                ReleaseDefaultLayer.objects.get_or_create( release = ro, layer = layer)
+
+        # set default release
+        if ToasterSetting.objects.filter(name = "DEFAULT_RELEASE").count() > 0:
+            ToasterSetting.objects.filter(name = "DEFAULT_RELEASE").update(value = data['defaultrelease'])
+        else:
+            ToasterSetting.objects.create(name = "DEFAULT_RELEASE", value = data['defaultrelease'])
+
+        # set default config variables
+        for configname in data['config']:
+            if ToasterSetting.objects.filter(name = "DEFCONF_" + configname).count() > 0:
+                ToasterSetting.objects.filter(name = "DEFCONF_" + configname).update(value = data['config'][configname])
+            else:
+                ToasterSetting.objects.create(name = "DEFCONF_" + configname, value = data['config'][configname])
 
     def handle(self, **options):
+        self.guesspath = DN(DN(DN(DN(DN(DN(DN(__file__)))))))
+
         # we make sure we have builddir and sourcedir for all defined build envionments
         for be in BuildEnvironment.objects.all():
             def _verify_be():
                 is_changed = False
                 print("Verifying the Build Environment type %s id %d." % (be.get_betype_display(), be.pk))
                 if len(be.sourcedir) == 0:
-                    be.sourcedir = raw_input(" -- sourcedir may not be empty:")
+                    suggesteddir = self._get_suggested_sourcedir(be)
+                    be.sourcedir = raw_input(" -- Layer sources checkout directory may not be empty [guessed \"%s\"]:" % suggesteddir)
+                    if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
+                        be.sourcedir = suggesteddir
                     is_changed = True
+
                 if not be.sourcedir.startswith("/"):
-                    be.sourcedir = raw_input(" -- sourcedir must be an absolute path:")
+                    be.sourcedir = raw_input(" -- Layer sources checkout directory must be an absolute path:")
                     is_changed = True
+
                 if len(be.builddir) == 0:
-                    be.builddir = raw_input(" -- builddir may not be empty:")
+                    suggesteddir = self._get_suggested_builddir(be)
+                    be.builddir = raw_input(" -- Build directory may not be empty [guessed \"%s\"]:" % suggesteddir)
+                    if len(be.builddir) == 0 and len(suggesteddir) > 0:
+                        be.builddir = suggesteddir
                     is_changed = True
+
                 if not be.builddir.startswith("/"):
-                    be.builddir = raw_input(" -- builddir must be an absolute path:")
+                    be.builddir = raw_input(" -- Build directory must be an absolute path:")
                     is_changed = True
+
+
+
                 if is_changed:
-                    print "saved"
+                    print "Build configuration saved"
                     be.save()
+
+                if is_changed and be.betype == BuildEnvironment.TYPE_LOCAL:
+                    baselayerdir = DN(DN(self._find_first_path_for_file(be.sourcedir, "toasterconf.json", 3)))
+                    if baselayerdir:
+                        i = raw_input(" -- Do you want to import basic layer configuration from \"%s\" ? (y/N):" % baselayerdir)
+                        if len(i) and i.upper()[0] == 'Y':
+                            self._import_layer_config(baselayerdir)
+                            # we run lsupdates after config update
+                            print "Updating information from the layer source, please wait."
+                            from django.core.management import call_command
+                            call_command("lsupdates")
+                        pass
+
                 return is_changed
 
             while (_verify_be()):
                 pass
 
-            return 0
+        # verify that default settings are there
+        if ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').count() != 1:
+            ToasterSetting.objects.filter(name = 'DEFAULT_RELEASE').delete()
+            ToasterSetting.objects.get_or_create(name = 'DEFAULT_RELEASE', value = '')
+
+        return 0
-- 
1.9.1


