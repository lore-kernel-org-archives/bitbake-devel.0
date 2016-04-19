Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2D2B873170
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 16:29:02 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id u206so39020270wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xo21+DQfDqqaBBsF3uhz3s+mrP7IbNiNLhrShiWzrG8=;
	b=Qwg8MOvMKei7dkR3RRZGQRMrLSr5eLR2b45ZWuGZ2GQ5f+QA+g7eZPG+gfHz/SMEyE
	RSwAXDDg6WGU42i/9oPhTOOjyWHRPmfn2DMvichV24Hb7f5M1l3IqiZ1IELvCgMbDPtz
	nvz1ay5Bm8/FND7LcBClieUxG3S1h127r7I3+B858/VedH+2VEMLmewNats8LjrAfnbT
	x1wsHwI5zCqR7/aiEDd4vaHgFSVWH10HGZp2GBw/eACTZOtKA7jdFkNWri0Dj+KLj/gB
	MR38jGDiLkCi6LD06ojzF2tn09ddi85mo12wMvx/YHyL3ak5Xbj+jXHhlx9iwO/IN07a
	Ia6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xo21+DQfDqqaBBsF3uhz3s+mrP7IbNiNLhrShiWzrG8=;
	b=f9ZSG99W3LniV6gOjsi+feOb2OYPhcW2IFhYzFF3/+ZEcVSM0fd6Njp7XT67B3KXrr
	SEd0uMKvmSoMeGsdMiJNtyhDeiNOy6VzBHE+FqR1pbHuEfycnbkEfo8R9AV2FeJ8IsVH
	uZSxpGeRAnRsmZYVfIdyRuAcTUAV+XN7lAFynhIMyWQzIsfNud4NL1I1IxXtnzIHWcmA
	0EQDwCcO3wM8oiJBCdHxi3v6k3NXoeC+xyzRNqBLJ58eXVm39X6BmUXJzIaeEi3/JwVL
	4NXoY6DsQzdYtyMx9KoiWzyRGUT15VnH2VhME3gyyxujkLegcsCIhqnMRRT0kCnjYFM9
	S/6Q==
X-Gm-Message-State: AOPr4FWbGM0azrDR9KE7ETN9KoOqMsvZXjSsyB4akV3HsqPMboUpQgJ5jnpELittbZR+sTZW
X-Received: by 10.194.6.225 with SMTP id e1mr4330597wja.152.1461083343373;
	Tue, 19 Apr 2016 09:29:03 -0700 (PDT)
Received: from orion.home (host109-150-176-203.range109-150.btcentralplus.com.
	[109.150.176.203])
	by smtp.gmail.com with ESMTPSA id v64sm5168806wmv.1.2016.04.19.09.29.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Apr 2016 09:29:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 17:28:45 +0100
Message-Id: <1461083327-11668-9-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
References: <1461083327-11668-1-git-send-email-michael.g.wood@intel.com>
MIME-Version: 1.0
Subject: [PATCH 08/10] toaster: add build dashboard buttons to edit/create custom images
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

When a build is viewed in the dashboard, enable users to edit
a custom image which was built during that build, and/or create
a new custom image based on one of the image recipes built during
the build.

Add methods to the Build model to enable querying for the
set of image recipes built during a build.

Add buttons to the dashboard, with the "Edit custom image"
button opening a basic modal for now. The "New custom image"
button opens the existing new custom image modal, but is modified
to show a list of images available as a base for a new custom image.

Add a new function to the new custom image modal's script which
enables multiple potential custom images to be shown as radio
buttons in the dialog (if there is more than 1). Modify existing
code to use this new function.

Add a template filter which allows the queryset of recipes for
a build to be available to client-side scripts, and from there
be used to populate the new custom image modal.

[YOCTO #9123]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py                          |  41 ++++
 lib/toaster/toastergui/static/js/layerBtn.js       |   3 +-
 .../toastergui/static/js/newcustomimage_modal.js   | 103 ++++++++--
 lib/toaster/toastergui/static/js/recipedetails.js  |   3 +-
 .../toastergui/templates/basebuildpage.html        | 207 +++++++++++++--------
 .../templates/editcustomimage_modal.html           |  23 +++
 .../toastergui/templates/newcustomimage_modal.html |  28 ++-
 .../templatetags/queryset_to_list_filter.py        |  26 +++
 lib/toaster/toastergui/views.py                    |   7 +-
 9 files changed, 345 insertions(+), 96 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/editcustomimage_modal.html
 create mode 100644 lib/toaster/toastergui/templatetags/queryset_to_list_filter.py

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f0a8786..75e6ea3 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -490,6 +490,47 @@ class Build(models.Model):
         tgts = Target.objects.filter(build_id = self.id).order_by( 'target' );
         return( tgts );
 
+    def get_recipes(self):
+        """
+        Get the recipes related to this build;
+        note that the related layer versions and layers are also prefetched
+        by this query, as this queryset can be sorted by these objects in the
+        build recipes view; prefetching them here removes the need
+        for another query in that view
+        """
+        layer_versions = Layer_Version.objects.filter(build=self)
+        criteria = Q(layer_version__id__in=layer_versions)
+        return Recipe.objects.filter(criteria) \
+                             .select_related('layer_version', 'layer_version__layer')
+
+    def get_custom_image_recipe_names(self):
+        """
+        Get the names of custom image recipes for this build's project
+        as a list; this is used to screen out custom image recipes from the
+        recipes for the build by name, and to distinguish image recipes from
+        custom image recipes
+        """
+        custom_image_recipes = \
+            CustomImageRecipe.objects.filter(project=self.project)
+        return custom_image_recipes.values_list('name', flat=True)
+
+    def get_image_recipes(self):
+        """
+        Returns a queryset of image recipes related to this build, sorted
+        by name
+        """
+        criteria = Q(is_image=True)
+        return self.get_recipes().filter(criteria).order_by('name')
+
+    def get_custom_image_recipes(self):
+        """
+        Returns a queryset of custom image recipes related to this build,
+        sorted by name
+        """
+        custom_image_recipe_names = self.get_custom_image_recipe_names()
+        criteria = Q(is_image=True) & Q(name__in=custom_image_recipe_names)
+        return self.get_recipes().filter(criteria).order_by('name')
+
     def get_outcome_text(self):
         return Build.BUILD_OUTCOME[int(self.outcome)][1]
 
diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index aa43284..259271d 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -76,7 +76,8 @@ function layerBtnsInit() {
     if (imgCustomModal.length == 0)
       throw("Modal new-custom-image not found");
 
-    imgCustomModal.data('recipe', $(this).data('recipe'));
+    var recipe = {id: $(this).data('recipe'), name: null}
+    newCustomImageModalSetRecipes([recipe]);
     imgCustomModal.modal('show');
   });
 }
diff --git a/lib/toaster/toastergui/static/js/newcustomimage_modal.js b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
index 98e87f4..1ae0d34 100644
--- a/lib/toaster/toastergui/static/js/newcustomimage_modal.js
+++ b/lib/toaster/toastergui/static/js/newcustomimage_modal.js
@@ -1,33 +1,59 @@
 "use strict";
 
-/* Used for the newcustomimage_modal actions */
+/*
+Used for the newcustomimage_modal actions
+
+The .data('recipe') value on the outer element determines which
+recipe ID is used as the basis for the new custom image recipe created via
+this modal.
+
+Use newCustomImageModalSetRecipes() to set the recipes available as a base
+for the new custom image. This will manage the addition of radio buttons
+to select the base image (or remove the radio buttons, if there is only a
+single base image available).
+*/
 function newCustomImageModalInit(){
 
   var newCustomImgBtn = $("#create-new-custom-image-btn");
   var imgCustomModal = $("#new-custom-image-modal");
   var invalidNameHelp = $("#invalid-name-help");
+  var invalidRecipeHelp = $("#invalid-recipe-help");
   var nameInput = imgCustomModal.find('input');
 
-  var invalidMsg = "Image names cannot contain spaces or capital letters. The only allowed special character is dash (-).";
-  var duplicateImageMsg = "An image with this name already exists in this project.";
-  var duplicateRecipeMsg = "A non-image recipe with this name already exists.";
+  var invalidNameMsg = "Image names cannot contain spaces or capital letters. The only allowed special character is dash (-).";
+  var duplicateNameMsg = "An image with this name already exists. Image names must be unique.";
+  var invalidBaseRecipeIdMsg = "Please select an image to customise.";
+
+  // capture clicks on radio buttons inside the modal; when one is selected,
+  // set the recipe on the modal
+  imgCustomModal.on("click", "[name='select-image']", function (e) {
+    clearRecipeError();
+
+    var recipeId = $(e.target).attr('data-recipe');
+    imgCustomModal.data('recipe', recipeId);
+  });
 
   newCustomImgBtn.click(function(e){
     e.preventDefault();
 
     var baseRecipeId = imgCustomModal.data('recipe');
 
+    if (!baseRecipeId) {
+      showRecipeError(invalidBaseRecipeIdMsg);
+      return;
+    }
+
     if (nameInput.val().length > 0) {
       libtoaster.createCustomRecipe(nameInput.val(), baseRecipeId,
       function(ret) {
         if (ret.error !== "ok") {
           console.warn(ret.error);
           if (ret.error === "invalid-name") {
-            showError(invalidMsg);
-          } else if (ret.error === "image-already-exists") {
-            showError(duplicateImageMsg);
-          } else if (ret.error === "recipe-already-exists") {
-            showError(duplicateRecipeMsg);
+            showNameError(invalidNameMsg);
+            return;
+          } else if (ret.error === "already-exists") {
+            showNameError(duplicateNameMsg);
+            return;
           }
         } else {
           imgCustomModal.modal('hide');
@@ -37,12 +63,21 @@ function newCustomImageModalInit(){
     }
   });
 
-  function showError(text){
+  function showNameError(text){
     invalidNameHelp.text(text);
     invalidNameHelp.show();
     nameInput.parent().addClass('error');
   }
 
+  function showRecipeError(text){
+    invalidRecipeHelp.text(text);
+    invalidRecipeHelp.show();
+  }
+
+  function clearRecipeError(){
+    invalidRecipeHelp.hide();
+  }
+
   nameInput.on('keyup', function(){
     if (nameInput.val().length === 0){
       newCustomImgBtn.prop("disabled", true);
@@ -50,7 +85,7 @@ function newCustomImageModalInit(){
     }
 
     if (nameInput.val().search(/[^a-z|0-9|-]/) != -1){
-      showError(invalidMsg);
+      showNameError(invalidNameMsg);
       newCustomImgBtn.prop("disabled", true);
       nameInput.parent().addClass('error');
     } else {
@@ -60,3 +95,49 @@ function newCustomImageModalInit(){
     }
   });
 }
+
+// Set the image recipes which can used as the basis for the custom
+// image recipe the user is creating
+//
+// baseRecipes: a list of one or more recipes which can be
+// used as the base for the new custom image recipe in the format:
+// [{'id': <recipe ID>, 'name': <recipe name>'}, ...]
+//
+// if recipes is a single recipe, just show the text box to set the
+// name for the new custom image; if recipes contains multiple recipe objects,
+// show a set of radio buttons so the user can decide which to use as the
+// basis for the new custom image
+function newCustomImageModalSetRecipes(baseRecipes) {
+  var imgCustomModal = $("#new-custom-image-modal");
+  var imageSelector = $('#new-custom-image-modal [data-role="image-selector"]');
+  var imageSelectRadiosContainer = $('#new-custom-image-modal [data-role="image-selector-radios"]');
+
+  if (baseRecipes.length === 1) {
+    // hide the radio button container
+    imageSelector.hide();
+
+    // remove any radio buttons + labels
+    imageSelector.remove('[data-role="image-radio"]');
+
+    // set the single recipe ID on the modal as it's the only one
+    // we can build from
+    imgCustomModal.data('recipe', baseRecipes[0].id);
+  }
+  else {
+    // add radio buttons; note that the handlers for the radio buttons
+    // are set in newCustomImageModalInit via event delegation
+    for (var i = 0; i < baseRecipes.length; i++) {
+      var recipe = baseRecipes[i];
+      imageSelectRadiosContainer.append(
+        '<label class="radio" data-role="image-radio">' +
+        recipe.name +
+        '<input type="radio" class="form-control" name="select-image" ' +
+        'data-recipe="' + recipe.id + '">' +
+        '</label>'
+      );
+    }
+
+    // show the radio button container
+    imageSelector.show();
+  }
+}
diff --git a/lib/toaster/toastergui/static/js/recipedetails.js b/lib/toaster/toastergui/static/js/recipedetails.js
index d5f9eac..604db5f 100644
--- a/lib/toaster/toastergui/static/js/recipedetails.js
+++ b/lib/toaster/toastergui/static/js/recipedetails.js
@@ -9,7 +9,8 @@ function recipeDetailsPageInit(ctx){
     if (imgCustomModal.length === 0)
       throw("Modal new-custom-image not found");
 
-    imgCustomModal.data('recipe', $(this).data('recipe'));
+    var recipe = {id: $(this).data('recipe'), name: null}
+    newCustomImageModalSetRecipes([recipe]);
     imgCustomModal.modal('show');
   });
 
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index ff9433e..4a8e2a7 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -1,90 +1,149 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load project_url_tag %}
+{% load queryset_to_list_filter %}
 {% load humanize %}
 {% block pagecontent %}
+  <!-- breadcrumbs -->
+  <div class="section">
+    <ul class="breadcrumb" id="breadcrumb">
+      <li><a href="{% project_url build.project %}">{{build.project.name}}</a></li>
+      {% if not build.project.is_default %}
+        <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
+      {% endif %}
+      <li>
+        {% block parentbreadcrumb %}
+          <a href="{%url 'builddashboard' build.pk%}">
+            {{build.get_sorted_target_list.0.target}} {% if build.target_set.all.count > 1 %}(+{{build.target_set.all.count|add:"-1"}}){% endif %} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+          </a>
+        {% endblock %}
+      </li>
+      {% block localbreadcrumb %}{% endblock %}
+    </ul>
+    <script>
+      $( function () {
+        $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
+        $('#breadcrumb > li:last').addClass("active");
+        $('#breadcrumb > li:last > span').remove();
+      });
+    </script>
+  </div>
+
+  <div class="row-fluid">
+    <!-- begin left sidebar container -->
+    <div id="nav" class="span2">
+      <ul class="nav nav-list well">
+        <li
+          {% if request.resolver_match.url_name == 'builddashboard'  %}
+            class="active"
+          {% endif %} >
+          <a class="nav-parent" href="{% url 'builddashboard' build.pk %}">Build summary</a>
+        </li>
+        {% if build.target_set.all.0.is_image and build.outcome == 0 %}
+          <li class="nav-header">Images</li>
+          {% block nav-target %}
+            {% for t in build.get_sorted_target_list %}
+              <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
+            {% endfor %}
+          {% endblock %}
+        {% endif %}
+        <li class="nav-header">Build</li>
+        {% block nav-configuration %}
+          <li><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
+        {% endblock %}
+        {% block nav-tasks %}
+          <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
+        {% endblock %}
+        {% block nav-recipes %}
+          <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
+        {% endblock %}
+        {% block nav-packages %}
+          <li><a href="{% url 'packages' build.pk %}">Packages</a></li>
+        {% endblock %}
+          <li class="nav-header">Performance</li>
+        {% block nav-buildtime %}
+          <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
+        {% endblock %}
+        {% block nav-cputime %}
+          <li><a href="{% url 'cputime' build.pk %}">CPU usage</a></li>
+        {% endblock %}
+        {% block nav-diskio %}
+          <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+        {% endblock %}
 
+        <li class="divider"></li>
 
- <div class="">
-<!-- Breadcrumbs -->
-    <div class="section">
-        <ul class="breadcrumb" id="breadcrumb">
-            <li><a href="{% project_url build.project %}">{{build.project.name}}</a></li>
-            {% if not build.project.is_default %}
-                <li><a href="{% url 'projectbuilds' build.project.id %}">Builds</a></li>
-            {% endif %}
-            <li>
-            {% block parentbreadcrumb %}
-            <a href="{%url 'builddashboard' build.pk%}">
-              {{build.get_sorted_target_list.0.target}} {%if build.target_set.all.count > 1%}(+{{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|date:"d/m/y H:i"}})
+        <li>
+          <p class="navbar-btn">
+            <a class="btn btn-block" href="{% url 'build_artifact' build.id 'cookerlog' build.id %}">
+              Download build log
             </a>
-            {% endblock %}
-            </li>
-            {% block localbreadcrumb %}{% endblock %}
-        </ul>
-        <script>
-        $( function () {
-            $('#breadcrumb > li').append('<span class="divider">&rarr;</span>');
-            $('#breadcrumb > li:last').addClass("active");
-            $('#breadcrumb > li:last > span').remove();
-        });
-        </script>
-    </div>
+          </p>
+        </li>
 
-    <div class="row-fluid">
+        <li>
+          <!-- edit custom image built during this build -->
+          <p class="navbar-btn" data-role="edit-custom-image-trigger">
+            <button class="btn btn-block">Edit custom image</button>
+          </p>
+          {% include 'editcustomimage_modal.html' %}
+          <script>
+            $(document).ready(function () {
+              var editableCustomImageRecipes = {{ build.get_custom_image_recipes | queryset_to_list:"id,name" | json }};
 
-        <!-- begin left sidebar container -->
-        <div id="nav" class="span2">
-            <ul class="nav nav-list well">
-              <li
-                {% if request.resolver_match.url_name == 'builddashboard'  %}
-                  class="active"
-                {% endif %} >
-                <a class="nav-parent" href="{% url 'builddashboard' build.pk %}">Build summary</a>
-              </li>
-              {% if build.target_set.all.0.is_image and build.outcome == 0 %}
-                <li class="nav-header">Images</li>
-                {% block nav-target %}
-                  {% for t in build.get_sorted_target_list %}
-                    <li><a href="{% url 'target' build.pk t.pk %}">{{t.target}}</a><li>
-                  {% endfor %}
-                {% endblock %}
-              {% endif %}
-              <li class="nav-header">Build</li>
-              {% block nav-configuration %}
-                  <li><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
-              {% endblock %}
-              {% block nav-tasks %}
-                  <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
-              {% endblock %}
-              {% block nav-recipes %}
-                  <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
-              {% endblock %}
-              {% block nav-packages %}
-                  <li><a href="{% url 'packages' build.pk %}">Packages</a></li>
-              {% endblock %}
-                  <li class="nav-header">Performance</li>
-              {% block nav-buildtime %}
-                  <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
-              {% endblock %}
-              {% block nav-cputime %}
-                  <li><a href="{% url 'cputime' build.pk %}">CPU time</a></li>
-              {% endblock %}
-              {% block nav-diskio %}
-                  <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
-              {% endblock %}
-            </ul>
-        </div>
-        <!-- end left sidebar container -->
+              // edit custom image which was built during this build
+              var editCustomImageModal = $('#edit-custom-image-modal');
+              var editCustomImageTrigger = $('[data-role="edit-custom-image-trigger"]');
 
-        <!-- Begin right container -->
-        {% block buildinfomain %}{% endblock %}
-        <!-- End right container -->
+              editCustomImageTrigger.click(function () {
+                // if there is a single editable custom image, go direct to the edit
+                // page for it; if there are multiple editable custom images, show
+                // dialog to select one of them for editing
 
+                // single editable custom image
 
-    </div>
-  </div>
+                // multiple editable custom images
+                editCustomImageModal.modal('show');
+              });
+            });
+          </script>
+        </li>
 
+        <li>
+          <!-- new custom image from image recipe in this build -->
+          <p class="navbar-btn" data-role="new-custom-image-trigger">
+            <button class="btn btn-block">New custom image</button>
+          </p>
+          {% include 'newcustomimage_modal.html' %}
+          <script>
+            // imageRecipes includes both custom image recipes and built-in
+            // image recipes, any of which can be used as the basis for a
+            // new custom image
+            var imageRecipes = {{ build.get_image_recipes | queryset_to_list:"id,name" | json }};
 
-{% endblock %}
+            $(document).ready(function () {
+              var newCustomImageModal = $('#new-custom-image-modal');
+              var newCustomImageTrigger = $('[data-role="new-custom-image-trigger"]');
 
+              // show create new custom image modal to select an image built
+              // during this build as the basis for the custom recipe
+              newCustomImageTrigger.click(function () {
+                if (!imageRecipes.length) {
+                  return;
+                }
+                newCustomImageModalSetRecipes(imageRecipes);
+                newCustomImageModal.modal('show');
+              });
+            });
+          </script>
+        </li>
+      </ul>
+
+    </div>
+    <!-- end left sidebar container -->
+
+    <!-- begin right container -->
+    {% block buildinfomain %}{% endblock %}
+    <!-- end right container -->
+  </div>
+{% endblock %}
diff --git a/lib/toaster/toastergui/templates/editcustomimage_modal.html b/lib/toaster/toastergui/templates/editcustomimage_modal.html
new file mode 100644
index 0000000..fd998f6
--- /dev/null
+++ b/lib/toaster/toastergui/templates/editcustomimage_modal.html
@@ -0,0 +1,23 @@
+<!--
+modal dialog shown on the build dashboard, for editing an existing custom image
+-->
+<div class="modal hide fade in" aria-hidden="false" id="edit-custom-image-modal">
+  <div class="modal-header">
+    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
+    <h3>Select custom image to edit</h3>
+  </div>
+  <div class="modal-body">
+    <div class="row-fluid">
+      <span class="help-block">
+        Explanation of what this modal is for
+      </span>
+    </div>
+    <div class="control-group controls">
+      <input type="text" class="huge" placeholder="input box" required>
+      <span class="help-block error" style="display:none">Error text</span>
+    </div>
+  </div>
+  <div class="modal-footer">
+    <button class="btn btn-primary btn-large" disabled>Action</button>
+  </div>
+</div>
diff --git a/lib/toaster/toastergui/templates/newcustomimage_modal.html b/lib/toaster/toastergui/templates/newcustomimage_modal.html
index b1b5148..caeb302 100644
--- a/lib/toaster/toastergui/templates/newcustomimage_modal.html
+++ b/lib/toaster/toastergui/templates/newcustomimage_modal.html
@@ -15,18 +15,34 @@
 <div class="modal hide fade in" id="new-custom-image-modal" aria-hidden="false">
   <div class="modal-header">
     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
-    <h3>Name your custom image</h3>
+    <h3>New custom image</h3>
   </div>
+
   <div class="modal-body">
+    <!--
+    this container is visible if there are multiple image recipes which could
+    be used as a basis for the new custom image; radio buttons are added to it
+    via newCustomImageModalSetRecipes() as required
+    -->
+    <div data-role="image-selector" style="display:none;">
+      <h4>Which image do you want to customise?</h4>
+      <div data-role="image-selector-radios"></div>
+      <span class="help-block error" id="invalid-recipe-help" style="display:none"></span>
+      <div class="air"></div>
+    </div>
+
+    <h4>Name your custom image</h4>
+
     <div class="row-fluid">
       <span class="help-block span8">Image names must be unique. They should not contain spaces or capital letters, and the only allowed special character is dash (-).<p></p>
       </span></div>
     <div class="control-group controls">
       <input type="text" class="huge" placeholder="Type the custom image name" required>
-        <span class="help-block error" id="invalid-name-help" style="display:none"></span>
-      </div>
-    </div>
-    <div class="modal-footer">
-      <button id="create-new-custom-image-btn" class="btn btn-primary btn-large" data-original-title="" title="" disabled>Create custom image</button>
+      <span class="help-block error" id="invalid-name-help" style="display:none"></span>
     </div>
+  </div>
+
+  <div class="modal-footer">
+    <button id="create-new-custom-image-btn" class="btn btn-primary btn-large" data-original-title="" title="" disabled>Create custom image</button>
+  </div>
 </div>
diff --git a/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py b/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py
new file mode 100644
index 0000000..dfc094b
--- /dev/null
+++ b/lib/toaster/toastergui/templatetags/queryset_to_list_filter.py
@@ -0,0 +1,26 @@
+from django import template
+import json
+
+register = template.Library()
+
+def queryset_to_list(queryset, fields):
+    """
+    Convert a queryset to a list; fields can be set to a comma-separated
+    string of fields for each record included in the resulting list; if
+    omitted, all fields are included for each record, e.g.
+
+        {{ queryset | queryset_to_list:"id,name" }}
+
+    will return a list like
+
+        [{'id': 1, 'name': 'foo'}, ...]
+
+    (providing queryset has id and name fields)
+    """
+    if fields:
+        fields_list = [field.strip() for field in fields.split(',')]
+        return list(queryset.values(*fields_list))
+    else:
+        return list(queryset.values())
+
+register.filter('queryset_to_list', queryset_to_list)
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9744f4e..942dc31 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1257,7 +1257,10 @@ def recipes(request, build_id):
     if retval:
         return _redirect_parameters( 'recipes', request.GET, mandatory_parameters, build_id = build_id)
     (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
-    queryset = Recipe.objects.filter(layer_version__id__in=Layer_Version.objects.filter(build=build_id)).select_related("layer_version", "layer_version__layer")
+
+    build = Build.objects.get(pk=build_id)
+
+    queryset = build.get_recipes()
     queryset = _get_queryset(Recipe, queryset, filter_string, search_term, ordering_string, 'name')
 
     recipes = _build_page_range(Paginator(queryset, pagesize),request.GET.get('page', 1))
@@ -1276,8 +1279,6 @@ def recipes(request, build_id):
             revlist.append(recipe_dep)
         revs[recipe.id] = revlist
 
-    build = Build.objects.get(pk=build_id)
-
     context = {
         'objectname': 'recipes',
         'build': build,
-- 
2.5.0


