Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id CA04F6FFF7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:29:03 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id v188so169469448wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1fU5eFc3S/EIjNn6iU1kJcGDxV7AL4/CWo3AT8h2SOk=;
	b=kxG+3/dHgI7WYkU+E0xm1TtFYbBFl+gUptJMcAHRHXPwwLf5M9rW4IwHYUh0FmCDax
	2tPTLLfrMSpEYviy3hPNCMJPWHM8d+vp/s++sgVtHsMBFhtOT1uUowlFUyl+ZGCT4PEj
	kVRK548NOyLvYLxQrP8NfDIkiXoSKHD+jOjGM/BIJ4uhTuZfYOODusMYYFE5wx52Tr+S
	Yu1qCkd90EBFSAFWnbSvBtGSSGz48Eg1pwliD0YoMHEBcPubGW9esCCNP18FvwA5/JsE
	LEmFJAi/827YVQxEsM9B89DrjL4wvkhl3HqPffPTfpNgJ8rC+XyzR28pfK/aw3qh8hSi
	IXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1fU5eFc3S/EIjNn6iU1kJcGDxV7AL4/CWo3AT8h2SOk=;
	b=bCzzi/RyXVkl9MKcmuAabZ4L19enWBok2BH42Yb/HCb6I5UBTFBjjvzrY2/uSofPHJ
	AcY/YcdCHt5KqvtA+UR7K3eMG698MF0OC+NC85yIGpB9hipmH+oW+BU3GtuT5GjyWPIg
	nDG7Fh+eeQYCKX8MXNMSVLSwhfrFI7v9fbURk33SHx2LEFly0a1sQH7YFDzs3QSAT9SY
	teZNzF6J6jIM66MbgPAEd51MLpKXXpgiftWfBHlEAI/jYQr82lP4n1rerIu/AkR8udbP
	QaKSiHQ5PxuuCCbI6TWIQsxmZNNHlt9UyqVejOg/Hx3y4nf3Nz4RBjlzQK2Jin87LV0g
	6WhQ==
X-Gm-Message-State: AOPr4FUtAU7qaBjvf6ywbfb4AogL5XDUTahT+5Yvv7P7P05T66wAc6ZHHr8PWN8kX6w1C+/G
X-Received: by 10.194.93.2 with SMTP id cq2mr4327407wjb.151.1461083344318;
	Tue, 19 Apr 2016 09:29:04 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.29.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:29:03 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:46 +0100
Message-Id: <1461083327-11668-10-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
MIME-Version: 1.0
Subject: [PATCH 09/10] toaster: add modal to select custom image for editing
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
X-List-Received-Date: Tue, 19 Apr 2016 16:29:04 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Elliot Smith <elliot.smith@intel.com>

Add functionality to the placeholder button on the build dashboard
to open a modal dialog displaying editable custom images, in cases
where multiple custom images were built by the build. Where there
is only one editable custom image, go direct to its edit page.

The images shown in the modal are custom recipes for the project
which were built during the build shown in the dashboard.

This also affects the new custom image dialog, as that also has
to show custom image recipes as well as image recipes built during
the build. Modify the API on the Build object to support both.

Also modify and rename the queryset_to_list template filter so that
it can deal with lists as well as querysets, as the new custom image
modal has to show a list of image recipes which is an amalgam of two
querysets.

[YOCTO #9123]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py                          | 45 ++++++++------
 .../toastergui/static/js/newcustomimage_modal.js   | 15 +++--
 lib/toaster/toastergui/templates/base.html         |  1 -
 .../toastergui/templates/basebuildpage.html        | 62 +++++++++++---------
 .../templates/editcustomimage_modal.html           | 68 ++++++++++++++++++----
 .../templatetags/objects_to_dictionaries_filter.py | 35 +++++++++++
 .../templatetags/queryset_to_list_filter.py        | 26 ---------
 lib/toaster/toastergui/views.py                    | 26 +++++++--
 8 files changed, 186 insertions(+), 92 deletions(-)
 create mode 100644 lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
 delete mode 100644 lib/toaster/toastergui/templatetags/queryset_to_list_filter.py

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 75e6ea3..0b83b99 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -503,33 +503,37 @@ class Build(models.Model):
         return Recipe.objects.filter(criteria) \
                              .select_related('layer_version', 'layer_version__layer')
 
-    def get_custom_image_recipe_names(self):
-        """
-        Get the names of custom image recipes for this build's project
-        as a list; this is used to screen out custom image recipes from the
-        recipes for the build by name, and to distinguish image recipes from
-        custom image recipes
-        """
-        custom_image_recipes = \
-            CustomImageRecipe.objects.filter(project=self.project)
-        return custom_image_recipes.values_list('name', flat=True)
-
     def get_image_recipes(self):
         """
-        Returns a queryset of image recipes related to this build, sorted
-        by name
+        Returns a list of image Recipes (custom and built-in) related to this
+        build, sorted by name; note that this has to be done in two steps, as
+        there's no way to get all the custom image recipes and image recipes
+        in one query
         """
-        criteria = Q(is_image=True)
-        return self.get_recipes().filter(criteria).order_by('name')
+        custom_image_recipes = self.get_custom_image_recipes()
+        custom_image_recipe_names = custom_image_recipes.values_list('name', flat=True)
+
+        not_custom_image_recipes = ~Q(name__in=custom_image_recipe_names) & \
+                                   Q(is_image=True)
+
+        built_image_recipes = self.get_recipes().filter(not_custom_image_recipes)
+
+        # append to the custom image recipes and sort
+        customisable_image_recipes = list(
+            itertools.chain(custom_image_recipes, built_image_recipes)
+        )
+
+        return sorted(customisable_image_recipes, key=lambda recipe: recipe.name)
 
     def get_custom_image_recipes(self):
         """
-        Returns a queryset of custom image recipes related to this build,
+        Returns a queryset of CustomImageRecipes related to this build,
         sorted by name
         """
-        custom_image_recipe_names = self.get_custom_image_recipe_names()
-        criteria = Q(is_image=True) & Q(name__in=custom_image_recipe_names)
-        return self.get_recipes().filter(criteria).order_by('name')
+        built_recipe_names = self.get_recipes().values_list('name', flat=True)
+        criteria = Q(name__in=built_recipe_names) & Q(project=self.project)
+        queryset = CustomImageRecipe.objects.filter(criteria).order_by('name')
+        return queryset
 
     def get_outcome_text(self):
         return Build.BUILD_OUTCOME[int(self.outcome)][1]
@@ -1380,6 +1384,9 @@ class Layer(models.Model):
 
 # LayerCommit class is synced with layerindex.LayerBranch
 class Layer_Version(models.Model):
+    """
+    A Layer_Version either belongs to a single project or no project
+    """
     search_allowed_fields = ["layer__name", "layer__summary", "layer__description", "layer__vcs_url", "dirpath", "up_branch__name", "commit", "branch"]
     build = models.ForeignKey(Build, related_name='layer_version_build', default = None, null = True)
     layer = models.ForeignKey(Layer, related_name='layer_version_layer')
diff --git a/lib/toaster/toastergui/static/js/newcustomimage_modal.js b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
index 1ae0d34..cb9ed4d 100644
--- a/lib/toaster/toastergui/static/js/newcustomimage_modal.js
+++ b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
@@ -12,6 +12,7 @@ for the new custom image. This will manage the addition of radio buttons
 to select the base image (or remove the radio buttons, if there is only a
 single base image available).
 */
+
 function newCustomImageModalInit(){
 
   var newCustomImgBtn = $("#create-new-custom-image-btn");
@@ -21,7 +22,8 @@ function newCustomImageModalInit(){
   var nameInput = imgCustomModal.find('input');
 
   var invalidNameMsg = "Image names cannot contain spaces or capital letters. The only allowed special character is dash (-).";
-  var duplicateNameMsg = "An image with this name already exists. Image names must be unique.";
+  var duplicateNameMsg = "A recipe with this name already exists. Image names must be unique.";
+  var duplicateImageInProjectMsg = "An image with this name already exists in this project."
   var invalidBaseRecipeIdMsg = "Please select an image to customise.";
 
   // capture clicks on radio buttons inside the modal; when one is selected,
@@ -51,9 +53,12 @@ function newCustomImageModalInit(){
           if (ret.error === "invalid-name") {
             showNameError(invalidNameMsg);
             return;
-          } else if (ret.error === "already-exists") {
+          } else if (ret.error === "recipe-already-exists") {
             showNameError(duplicateNameMsg);
             return;
+          } else if (ret.error === "image-already-exists") {
+            showNameError(duplicateImageInProjectMsg);
+            return;
           }
         } else {
           imgCustomModal.modal('hide');
@@ -112,13 +117,13 @@ function newCustomImageModalSetRecipes(baseRecipes) {
   var imageSelector = $('#new-custom-image-modal [data-role="image-selector"]');
   var imageSelectRadiosContainer = $('#new-custom-image-modal [data-role="image-selector-radios"]');
 
+  // remove any existing radio buttons + labels
+  imageSelector.remove('[data-role="image-radio"]');
+
   if (baseRecipes.length === 1) {
     // hide the radio button container
     imageSelector.hide();
 
-    // remove any radio buttons + labels
-    imageSelector.remove('[data-role="image-radio"]');
-
     // set the single recipe ID on the modal as it's the only one
     // we can build from
     imgCustomModal.data('recipe', baseRecipes[0].id);
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 192f9fb..210cf33 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -43,7 +43,6 @@
         recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
         layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
         machinesTypeAheadUrl: {% url 'xhr_machinestypeahead' project.id as paturl%}{{paturl|json}},
-
         projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
         xhrCustomRecipeUrl : "{% url 'xhr_customrecipe' %}",
         projectId : {{project.id}},
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 4a8e2a7..0d8c882 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -1,7 +1,7 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load project_url_tag %}
-{% load queryset_to_list_filter %}
+{% load objects_to_dictionaries_filter %}
 {% load humanize %}
 {% block pagecontent %}
   <!-- breadcrumbs -->
@@ -81,33 +81,40 @@
           </p>
         </li>
 
-        <li>
-          <!-- edit custom image built during this build -->
-          <p class="navbar-btn" data-role="edit-custom-image-trigger">
-            <button class="btn btn-block">Edit custom image</button>
-          </p>
-          {% include 'editcustomimage_modal.html' %}
-          <script>
-            $(document).ready(function () {
-              var editableCustomImageRecipes = {{ build.get_custom_image_recipes | queryset_to_list:"id,name" | json }};
-
-              // edit custom image which was built during this build
-              var editCustomImageModal = $('#edit-custom-image-modal');
-              var editCustomImageTrigger = $('[data-role="edit-custom-image-trigger"]');
+        {% with build.get_custom_image_recipes as custom_image_recipes %}
+          {% if custom_image_recipes.count > 0 %}
+            <!-- edit custom image built during this build -->
+            <li>
+              <p class="navbar-btn" data-role="edit-custom-image-trigger">
+                <button class="btn btn-block">Edit custom image</button>
+                {% include 'editcustomimage_modal.html' %}
+                <script>
+                  var editableCustomImageRecipes = {{ custom_image_recipes | objects_to_dictionaries:"id,name" | json }};
 
-              editCustomImageTrigger.click(function () {
-                // if there is a single editable custom image, go direct to the edit
-                // page for it; if there are multiple editable custom images, show
-                // dialog to select one of them for editing
+                  $(document).ready(function () {
+                    var editCustomImageTrigger = $('[data-role="edit-custom-image-trigger"]');
+                    var editCustomImageModal = $('#edit-custom-image-modal');
 
-                // single editable custom image
-
-                // multiple editable custom images
-                editCustomImageModal.modal('show');
-              });
-            });
-          </script>
-        </li>
+                    // edit custom image which was built during this build
+                    editCustomImageTrigger.click(function () {
+                      // single editable custom image: redirect to the edit page
+                      // for that image
+                      if (editableCustomImageRecipes.length === 1) {
+                        var url = '{% url "customrecipe" build.project.id custom_image_recipes.first.id %}';
+                        document.location.href = url;
+                      }
+                      // multiple editable custom images: show modal to select
+                      // one of them for editing
+                      else {
+                        editCustomImageModal.modal('show');
+                      }
+                    });
+                  });
+                </script>
+              </p>
+            </li>
+          {% endif %}
+        {% endwith %}
 
         <li>
           <!-- new custom image from image recipe in this build -->
@@ -119,7 +126,7 @@
             // imageRecipes includes both custom image recipes and built-in
             // image recipes, any of which can be used as the basis for a
             // new custom image
-            var imageRecipes = {{ build.get_image_recipes | queryset_to_list:"id,name" | json }};
+            var imageRecipes = {{ build.get_image_recipes | objects_to_dictionaries:"id,name" | json }};
 
             $(document).ready(function () {
               var newCustomImageModal = $('#new-custom-image-modal');
@@ -131,6 +138,7 @@
                 if (!imageRecipes.length) {
                   return;
                 }
+
                 newCustomImageModalSetRecipes(imageRecipes);
                 newCustomImageModal.modal('show');
               });
diff --git a/lib/toaster/toastergui/templates/editcustomimage_modal.html b/lib/toaster/toastergui/templates/editcustomimage_modal.html
index fd998f6..8046c08 100644
--- a/lib/toaster/toastergui/templates/editcustomimage_modal.html
+++ b/lib/toaster/toastergui/templates/editcustomimage_modal.html
@@ -1,23 +1,71 @@
 <!--
-modal dialog shown on the build dashboard, for editing an existing custom image
+modal dialog shown on the build dashboard, for editing an existing custom image;
+only shown if more than one custom image was built, so the user needs to
+choose which one to edit
+
+required context:
+  build - a Build object
 -->
 <div class="modal hide fade in" aria-hidden="false" id="edit-custom-image-modal">
   <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
-    <h3>Select custom image to edit</h3>
+    <h3>Which image do you want to edit?</h3>
   </div>
+
   <div class="modal-body">
     <div class="row-fluid">
-      <span class="help-block">
-        Explanation of what this modal is for
-      </span>
-    </div>
-    <div class="control-group controls">
-      <input type="text" class="huge" placeholder="input box" required>
-      <span class="help-block error" style="display:none">Error text</span>
+      {% for recipe in build.get_custom_image_recipes %}
+        <label class="radio">
+          {{recipe.name}}
+          <input type="radio" class="form-control" name="select-custom-image"
+                 data-url="{% url 'customrecipe' build.project.id recipe.id %}">
+        </label>
+      {% endfor %}
     </div>
+    <span class="help-block error" id="invalid-custom-image-help" style="display:none">
+      Please select a custom image to edit.
+    </span>
   </div>
+
   <div class="modal-footer">
-    <button class="btn btn-primary btn-large" disabled>Action</button>
+    <button class="btn btn-primary btn-large" data-url="#"
+       data-action="edit-custom-image" disabled>
+      Edit custom image
+    </button>
   </div>
 </div>
+
+<script>
+$(document).ready(function () {
+  var editCustomImageButton = $('[data-action="edit-custom-image"]');
+  var error = $('#invalid-custom-image-help');
+  var radios = $('[name="select-custom-image"]');
+
+  // return custom image radio buttons which are selected
+  var getSelectedRadios = function () {
+    return $('[name="select-custom-image"]:checked');
+  };
+
+  radios.change(function () {
+    if (getSelectedRadios().length === 1) {
+      editCustomImageButton.removeAttr('disabled');
+      error.hide();
+    }
+    else {
+      editCustomImageButton.attr('disabled', 'disabled');
+      error.show();
+    }
+  });
+
+  editCustomImageButton.click(function () {
+    var selectedRadios = getSelectedRadios();
+
+    if (selectedRadios.length === 1) {
+      document.location.href = selectedRadios.first().attr('data-url');
+    }
+    else {
+      error.show();
+    }
+  });
+});
+</script>
diff --git a/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
new file mode 100644
index 0000000..0dcc7d2
--- /dev/null
+++ b/lib/toaster/toastergui/templatetags/objects_to_dictionaries_filter.py
@@ -0,0 +1,35 @@
+from django import template
+import json
+
+register = template.Library()
+
+def objects_to_dictionaries(iterable, fields):
+    """
+    Convert an iterable into a list of dictionaries; fields should be set
+    to a comma-separated string of properties for each item included in the
+    resulting list; e.g. for a queryset:
+
+        {{ queryset | objects_to_dictionaries:"id,name" }}
+
+    will return a list like
+
+        [{'id': 1, 'name': 'foo'}, ...]
+
+    providing queryset has id and name fields
+
+    This is mostly to support serialising querysets or lists of model objects
+    to JSON
+    """
+    objects = []
+
+    if fields:
+        fields_list = [field.strip() for field in fields.split(',')]
+        for item in iterable:
+            out = {}
+            for field in fields_list:
+                out[field] = getattr(item, field)
+            objects.append(out)
+
+    return objects
+
+register.filter('objects_to_dictionaries', objects_to_dictionaries)
diff --git a/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py b/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py
deleted file mode 100644
index dfc094b..0000000
--- a/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py
+++ /dev/null
@@ -1,26 +0,0 @@
-from django import template
-import json
-
-register = template.Library()
-
-def queryset_to_list(queryset, fields):
-    """
-    Convert a queryset to a list; fields can be set to a comma-separated
-    string of fields for each record included in the resulting list; if
-    omitted, all fields are included for each record, e.g.
-
-        {{ queryset | queryset_to_list:"id,name" }}
-
-    will return a list like
-
-        [{'id': 1, 'name': 'foo'}, ...]
-
-    (providing queryset has id and name fields)
-    """
-    if fields:
-        fields_list = [field.strip() for field in fields.split(',')]
-        return list(queryset.values(*fields_list))
-    else:
-        return list(queryset.values())
-
-register.filter('queryset_to_list', queryset_to_list)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 942dc31..bd5bf63 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -507,6 +507,7 @@ def builddashboard( request, build_id ):
 
     context = {
             'build'           : build,
+            'project'         : build.project,
             'hasImages'       : hasImages,
             'ntargets'        : ntargets,
             'targets'         : targets,
@@ -797,6 +798,7 @@ eans multiple licenses exist that cover different parts of the source',
     context = {
         'objectname': variant,
         'build'                : build,
+        'project'              : build.project,
         'target'               : Target.objects.filter( pk = target_id )[ 0 ],
         'objects'              : packages,
         'packages_sum'         : packages_sum[ 'installed_size__sum' ],
@@ -937,7 +939,10 @@ def dirinfo(request, build_id, target_id, file_path=None):
             if head != sep:
                 dir_list.insert(0, head)
 
-    context = { 'build': Build.objects.get(pk=build_id),
+    build = Build.objects.get(pk=build_id)
+
+    context = { 'build': build,
+                'project': build.project,
                 'target': Target.objects.get(pk=target_id),
                 'packages_sum': packages_sum['installed_size__sum'],
                 'objects': objects,
@@ -1211,6 +1216,7 @@ def tasks_common(request, build_id, variant, task_anchor):
                 'filter_search_display': filter_search_display,
                 'mainheading': title_variant,
                 'build': build,
+                'project': build.project,
                 'objects': task_objects,
                 'default_orderby' : default_orderby,
                 'search_term': search_term,
@@ -1282,6 +1288,7 @@ def recipes(request, build_id):
     context = {
         'objectname': 'recipes',
         'build': build,
+        'project': build.project,
         'objects': recipes,
         'default_orderby' : 'name:+',
         'recipe_deps' : deps,
@@ -1366,10 +1373,12 @@ def configuration(request, build_id):
                  'MACHINE', 'DISTRO', 'DISTRO_VERSION', 'TUNE_FEATURES', 'TARGET_FPU')
     context = dict(Variable.objects.filter(build=build_id, variable_name__in=var_names)\
                                            .values_list('variable_name', 'variable_value'))
+    build = Build.objects.get(pk=build_id)
     context.update({'objectname': 'configuration',
                     'object_search_display':'variables',
                     'filter_search_display':'variables',
-                    'build': Build.objects.get(pk=build_id),
+                    'build': build,
+                    'project': build.project,
                     'targets': Target.objects.filter(build=build_id)})
     return render(request, template, context)
 
@@ -1406,12 +1415,15 @@ def configvars(request, build_id):
         file_filter += '/bitbake.conf'
     build_dir=re.sub("/tmp/log/.*","",Build.objects.get(pk=build_id).cooker_log_path)
 
+    build = Build.objects.get(pk=build_id)
+
     context = {
                 'objectname': 'configvars',
                 'object_search_display':'BitBake variables',
                 'filter_search_display':'variables',
                 'file_filter': file_filter,
-                'build': Build.objects.get(pk=build_id),
+                'build': build,
+                'project': build.project,
                 'objects' : variables,
                 'total_count':queryset_with_search.count(),
                 'default_orderby' : 'variable_name:+',
@@ -1480,6 +1492,7 @@ def bpackage(request, build_id):
     context = {
         'objectname': 'packages built',
         'build': build,
+        'project': build.project,
         'objects' : packages,
         'default_orderby' : 'name:+',
         'tablecols':[
@@ -1554,7 +1567,12 @@ def bpackage(request, build_id):
 def bfile(request, build_id, package_id):
     template = 'bfile.html'
     files = Package_File.objects.filter(package = package_id)
-    context = {'build': Build.objects.get(pk=build_id), 'objects' : files}
+    build = Build.objects.get(pk=build_id)
+    context = {
+        'build': build,
+        'project': build.project,
+        'objects' : files
+    }
     return render(request, template, context)
 
 
-- 
2.5.0


