Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 50D3C71B3F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:29 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id g23so110522407wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SLrOHYBQ9FiVJaoLv3fQyQtJetQtRsVxypuSwzdzJiY=;
	b=qCsQc6Rx1mIxtNoTDCQOpbnzQsTq/rslFje6Dk3iqJfyLlpTjXmIwUyZswbuegXmrM
	J3Fp2nc4wIwBl1EUk6x/CRMeaUnu/xe7/jQOAofPRbBj1QE/P+qR9D64Kz/dya9DrlIz
	+ZGf7eiPyU6QeI1MzpgO6Z0yM8QjzKhKT7vD4m4bYKezHV0KqrPa/ObyhMd/p2ixY+cd
	zv4BgVvNpU4z9uGc26srnLqO4Ou4vRzn+wvYtuoWQs3AcGKYi/exo5X+SIpRUWG0Xk4s
	4+AGFOwiG3VjMyoRrjtIaHe0Hae/Goq3qQe8ZEtQiV0azxx5x37UvZxGH3yW0qaUGmRk
	GQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SLrOHYBQ9FiVJaoLv3fQyQtJetQtRsVxypuSwzdzJiY=;
	b=Y/eBEFy3GN79zNCNSGYi3skyifsa4KzxX1qHevPHv/6IiN15a/wsNOGZPQuJEz97md
	TdMLlfPfs+Ucr3JUmiL72WGaTTsMPnqqVz2SspxCGv5fMFXzdhEb6SltNulqPnlyut0X
	iZirPkl2BWY0idBXq7w4HGqS6qz8hP2P+UGGoMf7SZr5sbZ6XbsI5JhWcZCGJBrH2qZV
	mvxDsNlZv3+ekZeTnhHF4ogKZ5aw3rZXwfprNOuij9rsYpJrmobvDqQwVPWRjvSqFekQ
	ll8mLO1d8awYFyLybO4n3W/SPi0bmWOFOjiLspkv0PLggRhyjWCT/LJoWzzMbnOc04oo
	nxLg==
X-Gm-Message-State: AKaTC03JMkmFdfVDWvVBlNFOETiQUPNiD9es0F2dOQS4TEQRUinAdv99DMDLXcyrvfL4TAIL
X-Received: by 10.28.54.97 with SMTP id d94mr1953564wma.28.1479986429960;
	Thu, 24 Nov 2016 03:20:29 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:29 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:00 +0000
Message-Id: <1479986406-4657-10-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 09/15] toaster: buildinfohelper toaster-custom-images layer
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:29 -0000

This fixes the unidentified layers issue by making the
toaster-custom-images layer a local layer. By doing this we also fix the
git assumptions made for the local layers which stop recipes and other
meta data being associated with them. This also removed some of the
special casing previously needed when we didn't have the concept of a
local (non git) layer.

Also rename created flag var to a have a different var for each returned
value so that the same value isn't used multiple times.

[YOCTO #10220]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py                    |  7 +------
 lib/toaster/bldcontrol/localhostbecontroller.py | 25 ++++++++++++++++++-------
 lib/toaster/orm/models.py                       |  3 ++-
 lib/toaster/toastergui/api.py                   | 16 ++++++++++------
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 3ddcb2a..e96e934 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -42,7 +42,7 @@ from orm.models import Variable, VariableHistory
 from orm.models import Package, Package_File, Target_Installed_Package, Target_File
 from orm.models import Task_Dependency, Package_Dependency
 from orm.models import Recipe_Dependency, Provides
-from orm.models import Project, CustomImagePackage, CustomImageRecipe
+from orm.models import Project, CustomImagePackage
 from orm.models import signal_runbuilds
 
 from bldcontrol.models import BuildEnvironment, BuildRequest
@@ -361,11 +361,6 @@ class ORMWrapper(object):
 
     def get_update_layer_version_object(self, build_obj, layer_obj, layer_version_information):
         if isinstance(layer_obj, Layer_Version):
-            # Special case the toaster-custom-images layer which is created
-            # on the fly so don't update the values which may cause the layer
-            # to be duplicated on a future get_or_create
-            if layer_obj.layer.name == CustomImageRecipe.LAYER_NAME:
-                return layer_obj
             # We already found our layer version for this build so just
             # update it with the new build information
             logger.debug("We found our layer from toaster")
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 11335ac..18870d9 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -228,13 +228,22 @@ class LocalhostBEController(BuildEnvironmentController):
             br_layer_base_recipe = layers.get(
                 layer_version=customrecipe.base_recipe.layer_version)
 
-            br_layer_base_dirpath = \
-                    os.path.join(self.be.sourcedir,
-                                 self.getGitCloneDirectory(
-                                     br_layer_base_recipe.giturl,
-                                     br_layer_base_recipe.commit),
-                                 customrecipe.base_recipe.layer_version.dirpath
-                                )
+            # If the layer is one that we've cloned we know where it lives
+            if br_layer_base_recipe.giturl and br_layer_base_recipe.commit:
+                layer_path = self.getGitCloneDirectory(
+                    br_layer_base_recipe.giturl,
+                    br_layer_base_recipe.commit)
+            # Otherwise it's a local layer
+            elif br_layer_base_recipe.local_source_dir:
+                layer_path = br_layer_base_recipe.local_source_dir
+            else:
+                logger.error("Unable to workout the dir path for the custom"
+                             " image recipe")
+
+            br_layer_base_dirpath = os.path.join(
+                self.be.sourcedir,
+                layer_path,
+                customrecipe.base_recipe.layer_version.dirpath)
 
             customrecipe.base_recipe.layer_version.dirpath = \
                          br_layer_base_dirpath
@@ -249,6 +258,8 @@ class LocalhostBEController(BuildEnvironmentController):
 
             # Update the layer and recipe objects
             customrecipe.layer_version.dirpath = layerpath
+            customrecipe.layer_version.layer.local_source_dir = layerpath
+            customrecipe.layer_version.layer.save()
             customrecipe.layer_version.save()
 
             customrecipe.file_path = recipe_path
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index b24e9c5..fd15fbe 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1636,7 +1636,8 @@ class CustomImageRecipe(Recipe):
         if base_recipe_path:
             base_recipe = open(base_recipe_path, 'r').read()
         else:
-            raise IOError("Based on recipe file not found")
+            raise IOError("Based on recipe file not found: %s" %
+                          base_recipe_path)
 
         # Add a special case for when the recipe we have based a custom image
         # recipe on requires another recipe.
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index ae1f150..4851047 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -291,10 +291,13 @@ class XhrCustomRecipe(View):
                 return error_response("recipe-already-exists")
 
             # create layer 'Custom layer' and verion if needed
-            layer = Layer.objects.get_or_create(
+            layer, l_created = Layer.objects.get_or_create(
                 name=CustomImageRecipe.LAYER_NAME,
-                summary="Layer for custom recipes",
-                vcs_url="file:///toaster_created_layer")[0]
+                summary="Layer for custom recipes")
+
+            if l_created:
+                layer.local_source_dir = "toaster_created_layer"
+                layer.save()
 
             # Check if we have a layer version already
             # We don't use get_or_create here because the dirpath will change
@@ -303,9 +306,10 @@ class XhrCustomRecipe(View):
                                                 Q(layer=layer) &
                                                 Q(build=None)).last()
             if lver is None:
-                lver, created = Layer_Version.objects.get_or_create(
+                lver, lv_created = Layer_Version.objects.get_or_create(
                     project=params['project'],
                     layer=layer,
+                    layer_source=LayerSource.TYPE_LOCAL,
                     dirpath="toaster_created_layer")
 
             # Add a dependency on our layer to the base recipe's layer
@@ -319,7 +323,7 @@ class XhrCustomRecipe(View):
                                                optional=False)
 
             # Create the actual recipe
-            recipe, created = CustomImageRecipe.objects.get_or_create(
+            recipe, r_created = CustomImageRecipe.objects.get_or_create(
                 name=request.POST["name"],
                 base_recipe=params["base"],
                 project=params["project"],
@@ -329,7 +333,7 @@ class XhrCustomRecipe(View):
             # If we created the object then setup these fields. They may get
             # overwritten later on and cause the get_or_create to create a
             # duplicate if they've changed.
-            if created:
+            if r_created:
                 recipe.file_path = request.POST["name"]
                 recipe.license = "MIT"
                 recipe.version = "0.1"
-- 
2.7.4


