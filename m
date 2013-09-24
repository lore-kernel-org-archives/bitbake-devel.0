Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 118E36CB7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:20 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948516"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id C87975619A1; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:01 +0100
Message-Id: <27460d2be0c46c1e4c75c9fa294f523d094e849a.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 32/94] bitbake: webhob: clear up ORM relations
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

After a bit of analysis, it's become clear that Recipes
only depend on a specific Layer version, and not on
the current build.

So I clear up the Build_Layer transforming it to Layer_Version
and remove the Build dependency.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 61 ++++++++++++++++++------------------
 bitbake/lib/webhob/orm/models.py     |  7 ++---
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 6eafea0..b0b56aa 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -8,7 +8,7 @@ import re
 os.environ.setdefault("DJANGO_SETTINGS_MODULE", "webhob.whbmain.settings")
 
 import webhob.whbmain.settings as whb_django_settings
-from webhob.orm.models import Machine, Build, Task, Recipe, Build_Layer, Layer, Package
+from webhob.orm.models import Machine, Build, Task, Recipe, Layer_Version, Layer, Package
 from webhob.orm.models import Task_Dependency
 
 
@@ -81,7 +81,7 @@ class ORMWrapper(object):
     def get_update_recipe_object(self, recipe_information):
 
         recipe_object, created = Recipe.objects.get_or_create(
-                                         build_layer=recipe_information['build_layer'],
+                                         layer_version=recipe_information['layer_version'],
                                          file_path=recipe_information['file_path'])
 
         for v in vars(recipe_object):
@@ -92,19 +92,18 @@ class ORMWrapper(object):
 
         return recipe_object
 
-    def get_build_layer_object(self, build_layer_information):
+    def get_layer_version_object(self, layer_version_information):
 
-        build_layer_object = Build_Layer.objects.get_or_create(
-                                    build = build_layer_information['build'],
-                                    layer = build_layer_information['layer'],
-                                    branch = build_layer_information['branch'],
-                                    commit = build_layer_information['commit'],
-                                    priority = build_layer_information['priority']
+        layer_version_object = Layer_Version.objects.get_or_create(
+                                    layer = layer_version_information['layer'],
+                                    branch = layer_version_information['branch'],
+                                    commit = layer_version_information['commit'],
+                                    priority = layer_version_information['priority']
                                     )
 
-        build_layer_object[0].save()
+        layer_version_object[0].save()
 
-        return build_layer_object[0]
+        return layer_version_object[0]
 
     def get_update_layer_object(self, layer_information):
 
@@ -179,16 +178,16 @@ class BuildInfoHelper(object):
 
         return layer_info
 
-    def _get_build_layer_information(self, layer_object):
+    def _get_layer_version_information(self, layer_object):
 
-        build_layer_info = {}
-        build_layer_info['build'] = self.internal_state['build']
-        build_layer_info['layer'] = layer_object
-        build_layer_info['branch'] = self._get_git_branch(layer_object.local_path)
-        build_layer_info['commit'] = self._get_git_revision(layer_object.local_path)
-        build_layer_info['priority'] = 0
+        layer_version_info = {}
+        layer_version_info['build'] = self.internal_state['build']
+        layer_version_info['layer'] = layer_object
+        layer_version_info['branch'] = self._get_git_branch(layer_object.local_path)
+        layer_version_info['commit'] = self._get_git_revision(layer_object.local_path)
+        layer_version_info['priority'] = 0
 
-        return build_layer_info
+        return layer_version_info
 
 
     def _get_git_branch(self, layer_path):
@@ -235,13 +234,13 @@ class BuildInfoHelper(object):
         task_information['task_name'] = event.taskname
         return task_information
 
-    def _get_build_layer_for_path(self, path):
-        def _slkey(build_layer):
-            return len(build_layer.layer.local_path)
+    def _get_layer_version_for_path(self, path):
+        def _slkey(layer_version):
+            return len(layer_version.layer.local_path)
 
         # Heuristics: we always match recipe to the deepest layer path that
         # we can match to the recipe file path
-        for bl in sorted(self.internal_state['build_layers'], reverse=True, key=_slkey):
+        for bl in sorted(self.internal_state['layer_versions'], reverse=True, key=_slkey):
             if (path.startswith(bl.layer.local_path)):
                 return bl
 
@@ -251,10 +250,10 @@ class BuildInfoHelper(object):
 
     def _get_recipe_information_from_build_event(self, event):
 
-        build_layer_obj = self._get_build_layer_for_path(re.split(':', event.taskfile)[-1])
+        layer_version_obj = self._get_layer_version_for_path(re.split(':', event.taskfile)[-1])
 
         recipe_info = {}
-        recipe_info['build_layer'] = build_layer_obj
+        recipe_info['layer_version'] = layer_version_obj
         recipe_info['file_path'] = re.split(':', event.taskfile)[-1]
 
         return recipe_info
@@ -332,10 +331,10 @@ class BuildInfoHelper(object):
         build_obj = self.orm_wrapper.create_build_object(build_information)
         self.internal_state['build'] = build_obj
         self.internal_state['target'] = build_information['target']
-        self.internal_state['build_layers'] = []
+        self.internal_state['layer_versions'] = []
         for layer_object in self.internal_state['layers']:
-            build_layer_information = self._get_build_layer_information(layer_object)
-            self.internal_state['build_layers'].append(self.orm_wrapper.get_build_layer_object(build_layer_information))
+            layer_version_information = self._get_layer_version_information(layer_object)
+            self.internal_state['layer_versions'].append(self.orm_wrapper.get_layer_version_object(layer_version_information))
 
         del self.internal_state['layers']
 
@@ -404,14 +403,14 @@ class BuildInfoHelper(object):
         for pn in event._depgraph['pn']:
 
             file_name = re.split(':', event._depgraph['pn'][pn]['filename'])[-1]
-            build_layer_obj = self._get_build_layer_for_path(re.split(':', file_name)[-1])
+            layer_version_obj = self._get_layer_version_for_path(re.split(':', file_name)[-1])
 
-            assert build_layer_obj is not None
+            assert layer_version_obj is not None
 
             recipe_info = {}
             recipe_info['name'] = pn
             recipe_info['version'] = event._depgraph['pn'][pn]['version']
-            recipe_info['build_layer'] = build_layer_obj
+            recipe_info['layer_version'] = layer_version_obj
 
             # TODO: dump all this info in the deptree event
             recipe_info['summary'] = 'Not Available'
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index e6663a3..91b352e 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -127,7 +127,7 @@ class Filelist(models.Model):
 class Recipe(models.Model):
     name = models.CharField(max_length=100, null=True)
     version = models.CharField(max_length=100, null=True)
-    build_layer = models.ForeignKey('Build_Layer', related_name='recipe_build_layer')
+    layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
     summary = models.CharField(max_length=100, null=True)
     description = models.CharField(max_length=100, null=True)
     section = models.CharField(max_length=100, null=True)
@@ -150,9 +150,8 @@ class Layer(models.Model):
     layer_index_url = models.URLField()
 
 
-class Build_Layer(models.Model):
-    build = models.ForeignKey(Build, related_name='build_layer_build')
-    layer = models.ForeignKey(Layer, related_name='build_layer_layer')
+class Layer_Version(models.Model):
+    layer = models.ForeignKey(Layer, related_name='layer_version_layer')
     branch = models.CharField(max_length=50)
     commit = models.CharField(max_length=100)
     priority = models.IntegerField()
-- 
1.8.1.2


