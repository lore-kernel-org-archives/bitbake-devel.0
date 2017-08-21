Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A46B978271
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 01:10:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v7L1ADmk031552
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Aug 2017 18:10:13 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 20 Aug 2017 18:10:12 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Aug 2017 18:01:48 -0700
Message-ID: <69930c5907ba050d9ae47569525cf130017dc6d3.1503276918.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1503276918.git.David.Reyna@windriver.com>
References: <cover.1503276918.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/2] toaster: custom image updates and original creation
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
X-List-Received-Date: Mon, 21 Aug 2017 01:10:11 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

When Toaster removes a package from a custom image, it must
also always remove the advised reverse-dependent recipes.
Similarly, when adding a package it must always add its advised
the packages it depends on. This code must be un-indented so
that it applies to all respective added or removed packages.

Toaster normally waits until a new custom image is built before
creating the custom layer and the recipe. However, an intermediate
different build can fail because the recipe has already been added
to the project, so the image's default recipe must be created
when the image is created.

[YOCTO #11915]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py     |  2 +-
 lib/toaster/toastergui/api.py | 98 +++++++++++++++++++++++++++----------------
 2 files changed, 62 insertions(+), 38 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 7aaebed..3a7dff8 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1658,7 +1658,7 @@ class CustomImageRecipe(Recipe):
 
     def get_base_recipe_file(self):
         """Get the base recipe file path if it exists on the file system"""
-        path_schema_one = "%s/%s" % (self.base_recipe.layer_version.dirpath,
+        path_schema_one = "%s/%s" % (self.base_recipe.layer_version.local_path,
                                      self.base_recipe.file_path)
 
         path_schema_two = self.base_recipe.file_path
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 88d6aa7..cb8f0f3 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -18,6 +18,7 @@
 
 # Please run flake8 on this file before sending patches
 
+import os
 import re
 import logging
 import json
@@ -28,7 +29,7 @@ from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
 from orm.models import Recipe, CustomImageRecipe, CustomImagePackage
 from orm.models import Layer, Target, Package, Package_Dependency
 from orm.models import ProjectVariable
-from bldcontrol.models import BuildRequest
+from bldcontrol.models import BuildRequest, BuildEnvironment
 from bldcontrol import bbcontroller
 
 from django.http import HttpResponse, JsonResponse
@@ -509,6 +510,27 @@ class XhrCustomRecipe(View):
                                    (tpackage.package.name, e))
                     pass
 
+        # pre-create layer directory structure, so that other builds
+        # are not blocked by this new recipe dependecy
+        # NOTE: this is parallel code to 'localhostbecontroller.py'
+        be = BuildEnvironment.objects.all()[0]
+        layerpath = os.path.join(be.builddir,
+                                 CustomImageRecipe.LAYER_NAME)
+        for name in ("conf", "recipes"):
+            path = os.path.join(layerpath, name)
+            if not os.path.isdir(path):
+                os.makedirs(path)
+        # pre-create layer.conf
+        config = os.path.join(layerpath, "conf", "layer.conf")
+        if not os.path.isfile(config):
+            with open(config, "w") as conf:
+                conf.write('BBPATH .= ":${LAYERDIR}"\nBBFILES += "${LAYERDIR}/recipes/*.bb"\n')
+        # pre-create new image's recipe file
+        recipe_path = os.path.join(layerpath, "recipes", "%s.bb" %
+                                   recipe.name)
+        with open(recipe_path, "w") as recipef:
+            recipef.write(recipe.generate_recipe_file_contents())
+
         return JsonResponse(
             {"error": "ok",
              "packages": recipe.get_all_packages().count(),
@@ -752,7 +774,6 @@ class XhrCustomRecipePackages(View):
                 return error_response("Package %s not found in excludes"
                                       " but was in included list" %
                                       package.name)
-
         else:
             recipe.appends_set.add(package)
             # Make sure that package is not in the excludes set
@@ -760,26 +781,27 @@ class XhrCustomRecipePackages(View):
                 recipe.excludes_set.remove(package)
             except:
                 pass
-            # Add the dependencies we think will be added to the recipe
-            # as a result of appending this package.
-            # TODO this should recurse down the entire deps tree
-            for dep in package.package_dependencies_source.all_depends():
+
+        # Add the dependencies we think will be added to the recipe
+        # as a result of appending this package.
+        # TODO this should recurse down the entire deps tree
+        for dep in package.package_dependencies_source.all_depends():
+            try:
+                cust_package = CustomImagePackage.objects.get(
+                    name=dep.depends_on.name)
+
+                recipe.includes_set.add(cust_package)
                 try:
-                    cust_package = CustomImagePackage.objects.get(
-                        name=dep.depends_on.name)
-
-                    recipe.includes_set.add(cust_package)
-                    try:
-                        # When adding the pre-requisite package, make
-                        # sure it's not in the excluded list from a
-                        # prior removal.
-                        recipe.excludes_set.remove(cust_package)
-                    except package.DoesNotExist:
-                        # Don't care if the package had never been excluded
-                        pass
-                except:
-                    logger.warning("Could not add package's suggested"
-                                   "dependencies to the list")
+                    # When adding the pre-requisite package, make
+                    # sure it's not in the excluded list from a
+                    # prior removal.
+                    recipe.excludes_set.remove(cust_package)
+                except package.DoesNotExist:
+                    # Don't care if the package had never been excluded
+                    pass
+            except:
+                logger.warning("Could not add package's suggested"
+                               "dependencies to the list")
         return JsonResponse({"error": "ok"})
 
     def delete(self, request, *args, **kwargs):
@@ -797,22 +819,24 @@ class XhrCustomRecipePackages(View):
                 recipe.excludes_set.add(package)
             else:
                 recipe.appends_set.remove(package)
-                all_current_packages = recipe.get_all_packages()
-
-                reverse_deps_dictlist = self._get_all_dependents(
-                    package.pk,
-                    all_current_packages)
-
-                ids = [entry['pk'] for entry in reverse_deps_dictlist]
-                reverse_deps = CustomImagePackage.objects.filter(id__in=ids)
-                for r in reverse_deps:
-                    try:
-                        if r.id in included_packages:
-                            recipe.excludes_set.add(r)
-                        else:
-                            recipe.appends_set.remove(r)
-                    except:
-                        pass
+
+            # remove dependencies as well
+            all_current_packages = recipe.get_all_packages()
+
+            reverse_deps_dictlist = self._get_all_dependents(
+                package.pk,
+                all_current_packages)
+
+            ids = [entry['pk'] for entry in reverse_deps_dictlist]
+            reverse_deps = CustomImagePackage.objects.filter(id__in=ids)
+            for r in reverse_deps:
+                try:
+                    if r.id in included_packages:
+                        recipe.excludes_set.add(r)
+                    else:
+                        recipe.appends_set.remove(r)
+                except:
+                    pass
 
             return JsonResponse({"error": "ok"})
         except CustomImageRecipe.DoesNotExist:
-- 
1.9.1


