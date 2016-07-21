Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id EAEDC731BC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:39:37 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 26DE91BC77B;
	Thu, 21 Jul 2016 13:39:38 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-120-4-226.us-west-2.compute.internal [10.120.4.226])
	by relay.mailchannels.net (Postfix) with ESMTPA id B14931BCFA8;
	Thu, 21 Jul 2016 13:39:37 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.135.9.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:39:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108377971:184665528
X-MC-Ingress-Time: 1469108377971
Received: from [176.249.240.35] (port=56876 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQECO-00012R-Hy; Thu, 21 Jul 2016 09:39:36 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:39:12 +0100
Message-Id: <1469108352-12098-10-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
References: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 10/10] toaster: loadconf Partially add back some of the layerSource parsing
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
X-List-Received-Date: Thu, 21 Jul 2016 13:39:38 -0000

From: Michael Wood <michael.g.wood@intel.com>

Partially add back a revised version of the layersource handling so that
we can continue to support the old toasterconf.json and it's setup of
the local project.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../bldcontrol/management/commands/loadconf.py     | 85 +++++++++++++++++++++-
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
index 59324ac..4f8c9c6 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -9,6 +9,20 @@ from .checksettings import DN
 import logging
 logger = logging.getLogger("toaster")
 
+# Temporary old code to support old toasterconf.json
+def _reduce_canon_path(path):
+    components = []
+    for c in path.split("/"):
+        if c == "..":
+            del components[-1]
+        elif c == ".":
+            pass
+        else:
+            components.append(c)
+    if len(components) < 2:
+        components.append('')
+    return "/".join(components)
+# End temp code
 
 class Command(BaseCommand):
     help = "Loads a toasterconf.json file in the database"
@@ -76,6 +90,74 @@ class Command(BaseCommand):
                 # find layers with the same name
                 ReleaseDefaultLayer.objects.get_or_create( release = ro, layer_name = dli)
 
+        # NOTE Temporary old code to handle old toasterconf.json. All this to
+        # be removed after rewrite of config loading mechanism
+        for lsi in data['layersources']:
+            assert 'sourcetype' in lsi
+            assert 'apiurl' in lsi
+            assert 'name' in lsi
+            assert 'branches' in lsi
+
+            if "local" in lsi['sourcetype']:
+                ls = LayerSource.TYPE_LOCAL
+            else:
+                ls = LayerSource.TYPE_LAYERINDEX
+
+            layer_releases = []
+            for branchname in lsi['branches']:
+                try:
+                    release = Release.objects.get(branch_name=branchname)
+                    layer_releases.append(release)
+                except Release.DoesNotExist:
+                    logger.error("Layer set for %s but no release matches this"
+                                 "in the config" % branchname)
+
+            apiurl = _reduce_canon_path(
+                os.path.join(DN(os.path.abspath(filepath)), lsi['apiurl']))
+
+            if 'layers' in lsi:
+                for layerinfo in lsi['layers']:
+                    lo, created = Layer.objects.get_or_create(
+                        name=layerinfo['name'],
+                        vcs_url=layerinfo['vcs_url'],
+                    )
+                    if layerinfo['local_path'].startswith("/"):
+                        lo.local_path = layerinfo['local_path']
+                    else:
+                        lo.local_path = _reduce_canon_path(
+                            os.path.join(apiurl, layerinfo['local_path']))
+
+                    if layerinfo['vcs_url'].startswith("remote:"):
+                        lo.vcs_url = _read_git_url_from_local_repository(
+                            layerinfo['vcs_url'])
+                        if lo.vcs_url is None:
+                            logger.error("The toaster config file references"
+                                         " the local git repo, but Toaster "
+                                         "cannot detect it.\nYour local "
+                                         "configuration for layer %s is "
+                                         "invalid. Make sure that the "
+                                         "toasterconf.json file is correct."
+                                         % layerinfo['name'])
+
+                    if lo.vcs_url is None:
+                        lo.vcs_url = layerinfo['vcs_url']
+
+                    if 'layer_index_url' in layerinfo:
+                        lo.layer_index_url = layerinfo['layer_index_url']
+                    lo.save()
+
+                    for release in layer_releases:
+                        lvo, created = Layer_Version.objects.get_or_create(
+                            layer_source=ls,
+                            release=release,
+                            commit=release.branch_name,
+                            branch=release.branch_name,
+                            layer=lo)
+                        lvo.dirpath = layerinfo['dirpath']
+                        lvo.save()
+        # END temporary code
+
+
         # set default release
         if ToasterSetting.objects.filter(name = "DEFAULT_RELEASE").count() > 0:
             ToasterSetting.objects.filter(name = "DEFAULT_RELEASE").update(value = data['defaultrelease'])
@@ -95,6 +177,3 @@ class Command(BaseCommand):
             raise CommandError("Need a path to the toasterconf.json file")
         filepath = args[0]
         self._import_layer_config(filepath)
-
-
-
-- 
2.7.4


