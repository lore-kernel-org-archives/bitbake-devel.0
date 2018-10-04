Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id EA10C798CC
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 06:14:32 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w946EDVB018554
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 3 Oct 2018 23:14:23 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 3 Oct 2018 23:14:03 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 3 Oct 2018 23:10:51 -0700
Message-ID: <0c6c24769c98d8a9737f9e49a030726359eb9dde.1538633120.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1538633120.git.David.Reyna@windriver.com>
References: <cover.1538633120.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 1/1] toaster: custom image enable layer add, protect pre-cloned layers
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
X-List-Received-Date: Thu, 04 Oct 2018 06:14:33 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

When creating custom image recipes, the layer add for new layers
needs missing xhrLayerUrl data. Also, code is needed to check
and inform user if the newly added layer has not been cloned yet,
and provide helpful error message instead of the current frozen
dialog.

[YOCTO #12887]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py                                | 4 ++--
 lib/toaster/toastergui/api.py                            | 8 +++++++-
 lib/toaster/toastergui/static/js/libtoaster.js           | 3 ++-
 lib/toaster/toastergui/static/js/newcustomimage_modal.js | 7 +++++++
 lib/toaster/toastergui/templates/customise_btn.html      | 6 +++++-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index be0bda5..849c22e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1750,8 +1750,8 @@ class CustomImageRecipe(Recipe):
         if base_recipe_path:
             base_recipe = open(base_recipe_path, 'r').read()
         else:
-            raise IOError("Based on recipe file not found: %s" %
-                          base_recipe_path)
+            # Pass back None to trigger error message to user
+            return None
 
         # Add a special case for when the recipe we have based a custom image
         # recipe on requires another recipe.
diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index 1bec56d..564d595 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -677,7 +677,13 @@ class XhrCustomRecipe(View):
         recipe_path = os.path.join(layerpath, "recipes", "%s.bb" %
                                    recipe.name)
         with open(recipe_path, "w") as recipef:
-            recipef.write(recipe.generate_recipe_file_contents())
+            content = recipe.generate_recipe_file_contents()
+            if not content:
+                # Delete this incomplete image recipe object
+                recipe.delete()
+                return error_response("recipe-parent-not-exist")
+            else:
+                recipef.write(recipe.generate_recipe_file_contents())
 
         return JsonResponse(
             {"error": "ok",
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 2e8863a..f2c45c8 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -275,7 +275,8 @@ var libtoaster = (function () {
 
   function _addRmLayer(layerObj, add, doneCb){
     if (layerObj.xhrLayerUrl === undefined){
-      throw("xhrLayerUrl is undefined")
+      alert("ERROR: missing xhrLayerUrl object. Please file a bug.");
+      return;
     }
 
     if (add === true) {
diff --git a/lib/toaster/toastergui/static/js/newcustomimage_modal.js b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
index dace8e3..e55fffc 100644
--- a/lib/toaster/toastergui/static/js/newcustomimage_modal.js
+++ b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
@@ -25,6 +25,8 @@ function newCustomImageModalInit(){
   var duplicateNameMsg = "An image with this name already exists. Image names must be unique.";
   var duplicateImageInProjectMsg = "An image with this name already exists in this project."
   var invalidBaseRecipeIdMsg = "Please select an image to customise.";
+  var missingParentRecipe = "The parent recipe file was not found. Cancel this action, build any target (like 'quilt-native') to force all new layers to clone, and try again";
+  var unknownError = "Unexpected error: ";
 
   // set button to "submit" state and enable text entry so user can
   // enter the custom recipe name
@@ -62,6 +64,7 @@ function newCustomImageModalInit(){
     if (nameInput.val().length > 0) {
       libtoaster.createCustomRecipe(nameInput.val(), baseRecipeId,
       function(ret) {
+        showSubmitState();
         if (ret.error !== "ok") {
           console.warn(ret.error);
           if (ret.error === "invalid-name") {
@@ -73,6 +76,10 @@ function newCustomImageModalInit(){
           } else if (ret.error === "image-already-exists") {
             showNameError(duplicateImageInProjectMsg);
             return;
+          } else if (ret.error === "recipe-parent-not-exist") {
+            showNameError(missingParentRecipe);
+          } else {
+            showNameError(unknownError + ret.error);
           }
         } else {
           imgCustomModal.modal('hide');
diff --git a/lib/toaster/toastergui/templates/customise_btn.html b/lib/toaster/toastergui/templates/customise_btn.html
index 38c258a..ce46240 100644
--- a/lib/toaster/toastergui/templates/customise_btn.html
+++ b/lib/toaster/toastergui/templates/customise_btn.html
@@ -5,7 +5,11 @@
   >
   Customise
 </button>
-<button class="btn btn-default btn-block layer-add-{{data.layer_version.pk}} layerbtn" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add"
+<button class="btn btn-default btn-block layer-add-{{data.layer_version.pk}} layerbtn"
+    data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}",
+      "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}",
+      "xhrLayerUrl": "{% url "xhr_layer" extra.pid data.layer_version.pk %}"}'
+    data-directive="add"
     {% if data.layer_version.pk in extra.current_layers %}
     style="display:none;"
     {% endif %}
-- 
1.9.1


