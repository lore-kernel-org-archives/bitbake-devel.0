Return-Path: <elliot.smith@intel.com>
Received: from nov-007-i511.relay.mailchannels.net
	(nov-007-i511.relay.mailchannels.net [46.232.183.65])
	by mail.openembedded.org (Postfix) with ESMTP id C8F8D731E0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:44:25 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DBDED21743;
	Thu, 21 Jul 2016 13:44:22 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-10-199.us-west-2.compute.internal [10.229.10.199])
	by relay.mailchannels.net (Postfix) with ESMTPA id 4AE9620036;
	Thu, 21 Jul 2016 13:44:22 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:44:22 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108696581:2568385952
X-MC-Ingress-Time: 1469108696580
Received: from [176.249.240.35] (port=56888 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQEGz-0002ZY-1J; Thu, 21 Jul 2016 09:44:21 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:43:23 +0100
Message-Id: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH][v2 01/10] toaster: loadconf remove Loading LayerSources
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
X-List-Received-Date: Thu, 21 Jul 2016 13:44:28 -0000

From: Michael Wood <michael.g.wood@intel.com>

We don't need to configure layer sources in the initial configuration as
this information is provided by the models.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../bldcontrol/management/commands/loadconf.py     | 69 +---------------------
 1 file changed, 2 insertions(+), 67 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
index 173e3ce..6f08f1d 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -1,6 +1,6 @@
 from django.core.management.base import BaseCommand, CommandError
 from orm.models import LayerSource, ToasterSetting, Branch, Layer, Layer_Version
-from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer, ReleaseLayerSourcePriority
+from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer
 from django.db import IntegrityError
 import os
 
@@ -42,7 +42,7 @@ class Command(BaseCommand):
         data = json.loads(open(filepath, "r").read())
 
         # verify config file validity before updating settings
-        for i in ['bitbake', 'releases', 'defaultrelease', 'config', 'layersources']:
+        for i in ['bitbake', 'releases', 'defaultrelease', 'config']:
             assert i in data
 
         def _read_git_url_from_local_repository(address):
@@ -81,65 +81,6 @@ class Command(BaseCommand):
             bvo.dirpath = bvi['dirpath']
             bvo.save()
 
-        # set the layer sources
-        for lsi in data['layersources']:
-            assert 'sourcetype' in lsi
-            assert 'apiurl' in lsi
-            assert 'name' in lsi
-            assert 'branches' in lsi
-
-
-            if _get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX or lsi['apiurl'].startswith("/"):
-                apiurl = lsi['apiurl']
-            else:
-                apiurl = _reduce_canon_path(os.path.join(DN(os.path.abspath(filepath)), lsi['apiurl']))
-
-            assert ((_get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX) or apiurl.startswith("/")), (lsi['sourcetype'],apiurl)
-
-            try:
-                ls, created = LayerSource.objects.get_or_create(sourcetype = _get_id_for_sourcetype(lsi['sourcetype']), apiurl = apiurl)
-                ls.name = lsi['name']
-                ls.save()
-            except IntegrityError as e:
-                logger.warning("IntegrityError %s \nWhile setting name %s for layer source %s " % (e, lsi['name'], ls))
-
-
-            layerbranches = []
-            for branchname in lsi['branches']:
-                bo, created = Branch.objects.get_or_create(layer_source = ls, name = branchname)
-                layerbranches.append(bo)
-
-            if 'layers' in lsi:
-                for layerinfo in lsi['layers']:
-                    lo, created = Layer.objects.get_or_create(layer_source = ls, name = layerinfo['name'])
-                    if layerinfo['local_path'].startswith("/"):
-                        lo.local_path = layerinfo['local_path']
-                    else:
-                        lo.local_path = _reduce_canon_path(os.path.join(ls.apiurl, layerinfo['local_path']))
-
-                    if not os.path.exists(lo.local_path):
-                        logger.error("Local layer path %s must exists. Are you trying to import a layer that does not exist ? Check your local toasterconf.json" % lo.local_path)
-
-                    if layerinfo['vcs_url'].startswith("remote:"):
-                        lo.vcs_url = _read_git_url_from_local_repository(layerinfo['vcs_url'])
-                        if lo.vcs_url is None:
-                            logger.error("The toaster config file references the local git repo, but Toaster cannot detect it.\nYour local configuration for layer %s is invalid. Make sure that the toasterconf.json file is correct." % layerinfo['name'])
-
-                    if lo.vcs_url is None:
-                        lo.vcs_url = layerinfo['vcs_url']
-
-                    if 'layer_index_url' in layerinfo:
-                        lo.layer_index_url = layerinfo['layer_index_url']
-                    lo.save()
-
-                    for branch in layerbranches:
-                        lvo, created = Layer_Version.objects.get_or_create(layer_source = ls,
-                                up_branch = branch,
-                                commit = branch.name,
-                                layer = lo)
-                        lvo.dirpath = layerinfo['dirpath']
-                        lvo.save()
-        # set releases
         for ri in data['releases']:
             bvo = BitbakeVersion.objects.get(name = ri['bitbake'])
             assert bvo is not None
@@ -149,12 +90,6 @@ class Command(BaseCommand):
             ro.helptext = ri['helptext']
             ro.save()
 
-            # save layer source priority for release
-            for ls_name in ri['layersourcepriority'].keys():
-                rlspo, created = ReleaseLayerSourcePriority.objects.get_or_create(release = ro, layer_source = LayerSource.objects.get(name=ls_name))
-                rlspo.priority = ri['layersourcepriority'][ls_name]
-                rlspo.save()
-
             for dli in ri['defaultlayers']:
                 # find layers with the same name
                 ReleaseDefaultLayer.objects.get_or_create( release = ro, layer_name = dli)
-- 
2.7.4


