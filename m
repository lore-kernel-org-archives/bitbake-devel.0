Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id EE0D46E2C3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359897"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:26 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:09 +0000
Message-Id: <33b60a940f58e8374a8c7baa9bf28a98f54cdf13.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/11] toaster: move layer information reading code
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:28 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In the processes of removing local system accesses
from toaster UI, we remove the layer data reading
code that was moved to toaster.bbclass, and
adapt the database writing code to read the data
from event sent by the toaster.bbclass

    [YOCTO #5604]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 88 ++++++++------------------------------------
 lib/bb/ui/toasterui.py       |  4 +-
 lib/toaster/orm/models.py    |  1 +
 3 files changed, 19 insertions(+), 74 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c99a511..b2e21ef 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -20,8 +20,6 @@ import datetime
 import sys
 import bb
 import re
-import subprocess
-
 
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "toaster.toastermain.settings")
 
@@ -125,10 +123,11 @@ class ORMWrapper(object):
 
         return recipe_object
 
-    def get_layer_version_object(self, layer_version_information):
+    def get_update_layer_version_object(self, build_obj, layer_obj, layer_version_information):
 
         layer_version_object = Layer_Version.objects.get_or_create(
-                                    layer = layer_version_information['layer'],
+                                    build = build_obj,
+                                    layer = layer_obj,
                                     branch = layer_version_information['branch'],
                                     commit = layer_version_information['commit'],
                                     priority = layer_version_information['priority']
@@ -274,60 +273,6 @@ class BuildInfoHelper(object):
     ###################
     ## methods to convert event/external info into objects that the ORM layer uses
 
-    def _get_layer_dict(self, layer_path):
-
-        layer_info = {}
-        layer_name = layer_path.split('/')[-1]
-        layer_url = 'http://layers.openembedded.org/layerindex/layer/{layer}/'
-        layer_url_name = self._get_url_map_name(layer_name)
-
-        layer_info['name'] = layer_name
-        layer_info['local_path'] = layer_path
-        layer_info['layer_index_url'] = layer_url.format(layer=layer_url_name)
-
-        return layer_info
-
-    def _get_url_map_name(self, layer_name):
-        """ Some layers have a different name on openembedded.org site,
-            this method returns the correct name to use in the URL
-        """
-
-        url_name = layer_name
-        url_mapping = {'meta': 'openembedded-core'}
-
-        for key in url_mapping.keys():
-            if key == layer_name:
-                url_name = url_mapping[key]
-
-        return url_name
-
-    def _get_layer_information(self):
-
-        layer_info = {}
-
-        return layer_info
-
-    def _get_layer_version_information(self, layer_object):
-
-        layer_version_info = {}
-        layer_version_info['build'] = self.internal_state['build']
-        layer_version_info['layer'] = layer_object
-        layer_version_info['branch'] = self._get_git_branch(layer_object.local_path)
-        layer_version_info['commit'] = self._get_git_revision(layer_object.local_path)
-        layer_version_info['priority'] = 0
-
-        return layer_version_info
-
-
-    def _get_git_branch(self, layer_path):
-        branch = subprocess.Popen("git symbolic-ref HEAD 2>/dev/null ", cwd=layer_path, shell=True, stdout=subprocess.PIPE).communicate()[0]
-        branch = branch.replace('refs/heads/', '').rstrip()
-        return branch
-
-    def _get_git_revision(self, layer_path):
-        revision = subprocess.Popen("git rev-parse HEAD 2>/dev/null ", cwd=layer_path, shell=True, stdout=subprocess.PIPE).communicate()[0].rstrip()
-        return revision
-
 
     def _get_build_information(self):
         build_info = {}
@@ -366,7 +311,7 @@ class BuildInfoHelper(object):
 
         # Heuristics: we always match recipe to the deepest layer path that
         # we can match to the recipe file path
-        for bl in sorted(self.internal_state['layer_versions'], reverse=True, key=_slkey):
+        for bl in sorted(Layer_Version.objects.filter(build = self.internal_state['build']), reverse=True, key=_slkey):
             if (path.startswith(bl.layer.local_path)):
                 return bl
 
@@ -452,12 +397,12 @@ class BuildInfoHelper(object):
     ################################
     ## external available methods to store information
 
-    def store_layer_info(self):
-        layers = self.server.runCommand(["getVariable", "BBLAYERS"])[0].strip().split(" ")
-        self.internal_state['layers'] = []
-        for layer_path in { l for l in layers if len(l) }:
-            layer_information = self._get_layer_dict(layer_path)
-            self.internal_state['layers'].append(self.orm_wrapper.get_update_layer_object(layer_information))
+    def store_layer_info(self, event):
+        layerinfos = event.data
+        self.internal_state['lvs'] = {}
+        for layer in layerinfos:
+            self.internal_state['lvs'][self.orm_wrapper.get_update_layer_object(layerinfos[layer])] = layerinfos[layer]['version']
+
 
     def store_started_build(self, event):
 
@@ -466,6 +411,12 @@ class BuildInfoHelper(object):
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
 
+        # save layer version information for this build
+        for layer_obj in self.internal_state['lvs']:
+            self.orm_wrapper.get_update_layer_version_object(build_obj, layer_obj, self.internal_state['lvs'][layer_obj])
+
+        del self.internal_state['lvs']
+
         # create target information
         target_information = {}
         target_information['targets'] = event.getPkgs()
@@ -473,13 +424,6 @@ class BuildInfoHelper(object):
 
         self.internal_state['targets'] = self.orm_wrapper.create_target_objects(target_information)
 
-        # Load layer information for the build
-        self.internal_state['layer_versions'] = []
-        for layer_object in self.internal_state['layers']:
-            layer_version_information = self._get_layer_version_information(layer_object)
-            self.internal_state['layer_versions'].append(self.orm_wrapper.get_layer_version_object(layer_version_information))
-
-        del self.internal_state['layers']
         # Save build configuration
         self.orm_wrapper.save_build_variables(build_obj, self.server.runCommand(["getAllKeysWithFlags", ["doc", "func"]])[0])
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 8e30a91..50493e7 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -93,7 +93,6 @@ def main(server, eventHandler, params ):
     taskfailures = []
 
     buildinfohelper = BuildInfoHelper(server, build_history_enabled)
-    buildinfohelper.store_layer_info()
 
 
     while True:
@@ -232,12 +231,13 @@ def main(server, eventHandler, params ):
                 warnings = 0
                 taskfailures = []
                 buildinfohelper = BuildInfoHelper(server, build_history_enabled)
-                buildinfohelper.store_layer_info()
                 continue
 
             if isinstance(event, bb.event.MetadataEvent):
                 if event.type == "SinglePackageInfo":
                     buildinfohelper.store_build_package_information(event)
+                if event.type == "LayerInfo":
+                    buildinfohelper.store_layer_info(event)
                 continue
 
             # ignore
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index cac8367..0bb048c 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -229,6 +229,7 @@ class Layer(models.Model):
 
 
 class Layer_Version(models.Model):
+    build = models.ForeignKey(Build, related_name='layer_version_build')
     layer = models.ForeignKey(Layer, related_name='layer_version_layer')
     branch = models.CharField(max_length=50)
     commit = models.CharField(max_length=100)
-- 
1.8.1.2


