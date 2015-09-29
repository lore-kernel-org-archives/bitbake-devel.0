Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 74F197705E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:06 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so194495755pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding;
	bh=WVQX+jUhOVfkm19Mp7VB2VO8Gio+NIHypsGcpBWNa4s=;
	b=csVqYxLsmPWAhkOTmYxM/5DsrVI5lx2PxrCsB8xtCPOvNLRQhKgr0GJtafao1JgaQd
	HzVgj0Egwa6DPWvrGLS9b4qDOsBrr+ZnCH3Hk4GIk7YjqwEezD6Tw2M0dJ0MydXFOtWq
	Q3hRHQhI9AxAWNlSw+PMW+rDgj8a/JxWLdBSwZWl9hucT1xx5YiQMHwc/QZEuCYMSQtJ
	grPsVJQ91Oikqv9cdvAQZCoSZy+52rOsxixO2HLY0HYviu4TP0pqd24l+8Gh8+MMIyYA
	ubBVSGQnNFUX+LGGLQIrTJ2RBkFlbLDQeZ/ThrQo4NCs4o9KZAoQjG3fzdbMc9CMvSaz
	EuXw==
X-Received: by 10.66.252.131 with SMTP id zs3mr30220369pac.75.1443501846877;
	Mon, 28 Sep 2015 21:44:06 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:06 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:24 -0700
Message-Id: <7157ce79f0ea53ba238e0062a9728bc0a602f77d.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 14/22] toaster: Add Image customisation frontend feature
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:06 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Wood <michael.g.wood@intel.com>

Add the Image customisation front end feature to Toaster.
Caveat - This feature is currently in development and should not be
enabled by default.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/static/js/customrecipe.js   |  50 ++++++++
 lib/toaster/toastergui/static/js/layerBtn.js       |  13 ++
 lib/toaster/toastergui/static/js/newcustomimage.js |  49 +++++++
 .../toastergui/templates/baseprojectpage.html      |   7 +-
 .../toastergui/templates/customise_btn.html        |   9 ++
 lib/toaster/toastergui/templates/customrecipe.html | 142 +++++++++++++++++++++
 .../toastergui/templates/newcustomimage.html       |  54 ++++++++
 .../toastergui/templates/pkg_add_rm_btn.html       |  16 +++
 lib/toaster/toastergui/templates/project.html      |   2 +-
 .../toastergui/templates/projecttopbar.html        |   9 +-
 lib/toaster/toastergui/urls.py                     |  17 ++-
 lib/toaster/toastergui/views.py                    |   9 ++
 12 files changed, 368 insertions(+), 9 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/customrecipe.js
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/newcustomimage.js
 create mode 100644 bitbake/lib/toaster/toastergui/templates/customise_btn.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/customrecipe.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/newcustomimage.html
 create mode 100644 bitbake/lib/toaster/toastergui/templates/pkg_add_rm_btn.html

diff --git a/lib/toaster/toastergui/static/js/customrecipe.js b/lib/toaster/toastergui/static/js/customrecipe.js
new file mode 100644
index 0000000..4f6b304
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/customrecipe.js
@@ -0,0 +1,50 @@
+"use strict";
+
+function customRecipePageInit(ctx) {
+
+  var urlParams = libtoaster.parseUrlParams();
+
+  (function notificationRequest(){
+    if (urlParams.hasOwnProperty('notify') && urlParams.notify === 'new'){
+      $("#image-created-notification").show();
+    }
+  })();
+
+  $("#recipeselection").on('table-done', function(e, total, tableParams){
+    /* Table is done so now setup the click handler for the package buttons */
+    $(".add-rm-package-btn").click(function(e){
+      e.preventDefault();
+      addRemovePackage($(this), tableParams);
+    });
+  });
+
+  function addRemovePackage(pkgBtn, tableParams){
+    var pkgBtnData = pkgBtn.data();
+    var method;
+    var buttonToShow;
+
+    if (pkgBtnData.directive == 'add') {
+      method = 'PUT';
+      buttonToShow = '#package-rm-btn-' + pkgBtnData.package;
+    } else if (pkgBtnData.directive == 'remove') {
+      method = 'DELETE';
+      buttonToShow = '#package-add-btn-' + pkgBtnData.package;
+    } else {
+      throw("Unknown package directive: should be add or remove");
+    }
+
+    $.ajax({
+        type: method,
+        url: pkgBtnData.packageUrl,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function(data){
+          /* Invalidate the Add | Rm package table's current cache */
+          tableParams.nocache = true;
+          $.get(ctx.tableApiUrl, tableParams);
+          /* Swap the buttons around */
+          pkgBtn.hide();
+          $(buttonToShow).show();
+        }
+    });
+  }
+}
diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index a0509f9..da0241c 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -68,6 +68,19 @@ function layerBtnsInit(ctx) {
       });
   });
 
+
+  $(".customise-btn").unbind('click');
+  $(".customise-btn").click(function(e){
+    e.preventDefault();
+    var imgCustomModal = $("#new-custom-image-modal");
+
+    if (imgCustomModal.length == 0)
+      throw("Modal new-custom-image not found");
+
+    imgCustomModal.data('recipe', $(this).data('recipe'));
+    imgCustomModal.modal('show');
+  });
+
   /* Setup the initial state of the buttons */
 
   for (var i in ctx.projectLayers){
diff --git a/lib/toaster/toastergui/static/js/newcustomimage.js b/lib/toaster/toastergui/static/js/newcustomimage.js
new file mode 100644
index 0000000..935b21e
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/newcustomimage.js
@@ -0,0 +1,49 @@
+"use strict";
+
+function newCustomImagePageInit(ctx){
+
+  var newCustomImgBtn = $("#create-new-custom-image-btn");
+  var imgCustomModal = $("#new-custom-image-modal");
+
+  newCustomImgBtn.click(function(e){
+    e.preventDefault();
+
+    var name = imgCustomModal.find('input').val();
+    var baseRecipeId = imgCustomModal.data('recipe');
+
+    if (name.length > 0) {
+      createCustomRecipe(name, baseRecipeId);
+      imgCustomModal.modal('hide');
+    } else {
+      console.warn("TODO No name supplied");
+    }
+  });
+
+  function createCustomRecipe(name, baseRecipeId){
+    var data = {
+      'name' : name,
+      'project' : libtoaster.ctx.projectId,
+      'base' : baseRecipeId,
+    };
+
+    $.ajax({
+        type: "POST",
+        url: ctx.xhrCustomRecipeUrl,
+        data: data,
+        headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+        success: function (ret) {
+          if (ret.error !== "ok") {
+            console.warn(ret.error);
+          } else {
+            window.location.replace(ret.url + '?notify=new');
+          }
+        },
+        error: function (ret) {
+          console.warn("Call failed");
+          console.warn(ret);
+        }
+    });
+  }
+
+
+}
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index 668e0bf..88bf859 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -23,8 +23,11 @@
     <ul class="nav nav-list well">
       <li><a class="nav-parent" href="{% url 'project' project.id %}">Configuration</a></li>
       <li class="nav-header">Compatible metadata</li>
-<!--  <li><a href="all-image-recipes.html">Image recipes</a></li> -->
-      <li><a href="{% url 'projecttargets' project.id %}">Recipes</a></li>
+      {% if CUSTOM_IMAGE %}
+      <li><a href="{% url 'projectcustomimages' project.id %}">Custom images</a></li>
+      {% endif %}
+      <li><a href="{% url 'projectimagerecipes' project.id %}">Image recipes</a></li>
+      <li><a href="{% url 'projectsoftwarerecipes' project.id %}">Software recipes</a></li>
       <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
       <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
       <li class="nav-header">Extra configuration</li>
diff --git a/lib/toaster/toastergui/templates/customise_btn.html b/lib/toaster/toastergui/templates/customise_btn.html
new file mode 100644
index 0000000..54d05f9
--- /dev/null
+++ b/lib/toaster/toastergui/templates/customise_btn.html
@@ -0,0 +1,9 @@
+<button class="btn btn-block layer-exists-{{data.layer_version.id}} customise-btn" style="display:none;" data-recipe="{{data.id}}">
+  Customise
+</button>
+
+<button class="btn btn-block layer-add-{{data.layer_version.id}} layerbtn" data-layer='{ "id": {{data.layer_version.id}}, "name": "{{data.layer_version.layer.name}}", "layerdetailurl": "{% url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add">
+  <i class="icon-plus"></i>
+  Add layer
+</button>
+
diff --git a/lib/toaster/toastergui/templates/customrecipe.html b/lib/toaster/toastergui/templates/customrecipe.html
new file mode 100644
index 0000000..823bbd8
--- /dev/null
+++ b/lib/toaster/toastergui/templates/customrecipe.html
@@ -0,0 +1,142 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% load static %}
+{% block pagecontent %}
+
+{% include "projecttopbar.html" %}
+
+<script src="{% static 'js/customrecipe.js' %}"></script>
+<script>
+  $(document).ready(function (){
+    var ctx = {
+      tableApiUrl: "{% url 'recipeselectpackages' project.id recipe.pk %}?format=json"
+    };
+
+    try {
+      customRecipePageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
+
+<div class="row-fluid span11">
+  <div class="alert alert-success lead" id="image-created-notification" style="margin-top: 15px; display: none">
+    <button type="button" data-dismiss="alert" class="close">x</button>
+    Your custom image <strong>{{recipe.name}}</strong> has been created. You can now add or remove packages as needed.
+  </div>
+  <div class="page-header air">
+    <h1>
+      {{recipe.name}}
+      <small>({{recipe.base_recipe.name}})</small>
+    </h1>
+  </div>
+</div>
+
+<div class="row-fluid span11">
+  <div class="span8">
+    <div class="button-place btn-group" style="width: 100%">
+      <a class="btn btn-large span6" href="#" id="build-custom-image" style="width: 50%">
+        Build {{recipe.name}}
+      </a>
+      <button class="btn btn-large span6" data-toggle="modal" data-target="#download-file" id="download" style="width: 50%">
+      Download recipe file
+    </button>
+  </div>
+  <div id="no-package-results" class="air" style="display:none;">
+    <div class="alert">
+      <h3>No packages found</h3>
+      <p>You might consider <a href="all-software-recipes.html">searching the list of recipes</a> instead. If you find a recipe that matches the name of the package you want:</p>
+      <ol>
+        <li>Add the layer providing the recipe to your project</li>
+        <li>Build the recipe</li>
+        <li>Once the build completes, come back to this page and search for the package</li>
+      </ol>
+      <form class="input-append no-results">
+        <input type="text" class="input-xlarge" value="search query">
+          <a href="#" class="add-on btn">
+            <i class="icon-remove"></i>
+          </a>
+          <button class="btn">Search</button>
+          <button class="btn btn-link" id="show-all">Show all packages</button>
+        </form>
+      </div>
+    </div>
+    <div id="packages-table">
+      {% url 'recipeselectpackages' project.id recipe.id as xhr_table_url %}
+      {% with 'recipeselection' as table_name %}
+      {% with 'Add | Remove packages' as  title %}
+
+      <h2>{{title}} (<span class="table-count-{{table_name}}"></span>) </h2>
+
+      {% include "toastertable.html" %}
+      {% endwith %}
+      {% endwith %}
+    </div>
+  </div>
+    <div class="span4 well">
+      <h2 style="margin-bottom:20px;">About {{recipe.name}}</h2>
+
+      <dl>
+        <dt>
+          Approx. packages included
+          <i class="icon-question-sign get-help" title="" data-original-title="The number of packages included is based on information from previous builds and from parsing layers, so we can never be sure it is 100% accurate"></i>
+        </dt>
+        <dd class="no-packages">{{recipe.packages.count}}</dd>
+        <!-- <dt>
+          Approx. package size
+          <i class="icon-question-sign get-help" title="" data-original-title="Package size is based on information from previous builds, so we can never be sure it is 100% accurate"></i>
+        </dt>
+        <dd>244.3 MB</dd>
+        <dt>Last build</dt>
+        <dd>
+          <i class="icon-ok-sign success"></i>
+          <a href="build-dashboard.html">11/06/15 15:22</a>
+        </dd>
+        <dt>Recipe file</dt>
+        <dd>
+          <code>custom-image-name.bb</code>
+          <a href="#download-file" data-toggle="modal"><i class="icon-download-alt" title="" data-original-title="Download recipe file"></i></a>
+          </dd> -->
+        <dt>Layer</dt>
+        <!-- TODO recipe details page -->
+        <dd><a href="{% url 'layerdetails' project.id recipe.base_recipe.layer_version.pk %}">{{recipe.base_recipe.layer_version.layer.name}}</a></dd>
+        <!--<dt>
+          Summary
+        </dt>
+        <dd>
+          <span class="muted">Not set</span>
+          <i class="icon-pencil" data-original-title="" title=""></i>
+        </dd>
+        <dt>
+          Description
+        </dt>
+        <dd>
+          <span class="muted">Not set</span>
+          <i class="icon-pencil" data-original-title="" title=""></i>
+        </dd>
+        <dt>Version</dt>
+        <dd>
+          1.0
+          <i class="icon-pencil" data-original-title="" title=""></i>
+        </dd>
+        <dt>Section</dt>
+        <dd>
+          base
+          <i class="icon-pencil" data-original-title="" title=""></i>
+          <i class="icon-trash" data-original-title="" title=""></i>
+        </dd>
+        <dt>License</dt>
+        <dd>
+          MIT
+          <i class="icon-question-sign get-help" title="" data-original-title="All custom images have their license set to MIT. This is because the license applies only to the recipe (.bb) file, and not to the image itself. To see which licenses apply to the image you must check the license manifest generated with each build"></i>
+          </dd> -->
+      </dl>
+      <i class="icon-trash no-tooltip"></i>
+      <a href="#" class="error" id="delete">Delete custom image</a>
+    </div>
+</div>
+
+  {% endblock %}
diff --git a/lib/toaster/toastergui/templates/newcustomimage.html b/lib/toaster/toastergui/templates/newcustomimage.html
new file mode 100644
index 0000000..4487b3e
--- /dev/null
+++ b/lib/toaster/toastergui/templates/newcustomimage.html
@@ -0,0 +1,54 @@
+{% extends "base.html" %}
+{% load projecttags %}
+{% load humanize %}
+{% load static %}
+{% block pagecontent %}
+
+<script src="{% static 'js/newcustomimage.js' %}"></script>
+<script>
+  $(document).ready(function (){
+    var ctx = {
+      xhrCustomRecipeUrl : "{% url 'xhr_customrecipe' %}",
+    };
+
+    try {
+      newCustomImagePageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
+
+</script>
+<div class="modal hide fade in" id="new-custom-image-modal" aria-hidden="false">
+  <div class="modal-header">
+    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
+    <h3>Name your custom image</h3>
+  </div>
+  <div class="modal-body">
+    <div class="row-fluid">
+      <span class="help-block span8">Image names must be unique. They should not contain spaces or capital letters, and the only allowed special character is dash (-).<p></p>
+      </span></div>
+    <div class="control-group controls">
+      <input type="text" class="huge span5" placeholder="Type the name, something like 'core-image-myimage'">
+        <span class="help-block" style="display:none">Image names cannot contain spaces or capital letters. The only allowed special character is dash (-)</span>
+        <span class="help-block" style="display: none">An image with this name already exists. Image names must be unique: try a different one.</span>
+      </div>
+    </div>
+    <div class="modal-footer">
+      <a href="#" id="create-new-custom-image-btn" class="btn btn-primary btn-large" data-original-title="" title="">Create custom image</a>
+    </div>
+</div>
+
+{% include "projecttopbar.html" %}
+
+
+{% url table_name project.id as xhr_table_url %}
+{% include "toastertable.html" %}
+
+
+
+{% endblock %}
+
+
diff --git a/lib/toaster/toastergui/templates/pkg_add_rm_btn.html b/lib/toaster/toastergui/templates/pkg_add_rm_btn.html
new file mode 100644
index 0000000..b766aea
--- /dev/null
+++ b/lib/toaster/toastergui/templates/pkg_add_rm_btn.html
@@ -0,0 +1,16 @@
+<button class="btn btn-block btn-danger add-rm-package-btn" id="package-rm-btn-{{data.pk}}" data-directive="remove" data-package="{{data.pk}}" data-package-url="{% url 'xhr_customrecipe_packages' extra.recipe_id data.pk %}" style="
+  {% if data.pk not in extra.current_packages %}
+    display:none
+  {% endif %}
+  ">
+  <i class="icon-trash no-tooltip"></i>
+  Remove package
+</a>
+<button class="btn btn-block add-rm-package-btn" data-directive="add" id="package-add-btn-{{data.pk}}" data-package="{{data.pk}}" data-package-url="{% url 'xhr_customrecipe_packages' extra.recipe_id data.pk %}" style="
+  {% if data.pk in extra.current_packages %}
+    display:none
+  {% endif %}
+    ">
+<i class="icon-plus"></i>
+ Add package
+</button>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index e8354fd..2f978bc 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -67,7 +67,7 @@
 
       <div class="alert alert-info" style="display:none" id="no-most-built">
         <span class="lead">You haven't built any recipes yet</span>
-        <p style="margin-top: 10px;"><a href="{% url 'projecttargets' project.id %}">Choose a recipe to build</a></p>
+        <p style="margin-top: 10px;"><a href="{% url 'projectsoftwarerecipes' project.id %}">Choose a recipe to build</a></p>
       </div>
 
       <ul class="unstyled configuration-list" id="freq-build-list">
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index ca2741d..a3d1b88 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -1,6 +1,6 @@
 <div class="alert alert-success lead" id="project-created-notification" style="margin-top:15px; display:none">
   <button type="button" class="close" data-dismiss="alert">×</button>
-  Your project <strong>{{project.name}}</strong> has been created. You can now <a href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a href="{% url 'projecttargets' project.id %}">choose image recipes</a> to build.
+  Your project <strong>{{project.name}}</strong> has been created. You can now <a href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a href="{% url 'projectsoftwarerecipes' project.id %}">choose image recipes</a> to build.
 </div>
 
 <!-- project name -->
@@ -34,6 +34,13 @@
         Import layer
       </a>
     </li>
+    {% if CUSTOM_IMAGE %}
+    <li>
+      <a href="{% url 'newcustomimage' project.id %}">
+        New custom image
+      </a>
+    </li>
+    {% endif %}
     <li class="pull-right">
       <form class="form-inline" style="margin-bottom:0px;">
         <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>"></i>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index b47a161..a1adbb7 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -103,16 +103,13 @@ urlpatterns = patterns('toastergui.views',
             tables.NewCustomImagesTable.as_view(template_name="newcustomimage.html"),
             name="newcustomimage"),
 
-        url(r'^project/(?P<pid>\d+)/availablerecipes/$',
-            tables.ProjectLayersRecipesTable.as_view(template_name="generic-toastertable-page.html"),
-            { 'table_name': tables.ProjectLayersRecipesTable.__name__.lower(),
-              'title' : 'Recipes available for layers in the current project' },
-            name="projectavailabletargets"),
 
         url(r'^project/(?P<pid>\d+)/layers/$',
             tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
             name="projectlayers"),
 
+
+
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
             'layerdetails', name='layerdetails'),
 
@@ -129,6 +126,16 @@ urlpatterns = patterns('toastergui.views',
             name=tables.LayerMachinesTable.__name__.lower()),
 
 
+        url(r'^project/(?P<pid>\d+)/customrecipe/(?P<recipeid>\d+)/selectpackages/$',
+            tables.SelectPackagesTable.as_view(template_name="generic-toastertable-page.html"), name="recipeselectpackages"),
+
+
+        url(r'^project/(?P<pid>\d+)/customrecipe/(?P<recipe_id>\d+)$',
+            'customrecipe',
+            name="customrecipe"),
+
+
+
         # typeahead api end points
         url(r'^xhr_typeahead/(?P<pid>\d+)/layers$',
             typeaheads.LayersTypeAhead.as_view(), name='xhr_layerstypeahead'),
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 392e56d..b7eddf4 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2790,6 +2790,15 @@ if True:
 
         return(vars_managed,sorted(vars_fstypes),vars_blacklist)
 
+    def customrecipe(request, pid, recipe_id):
+        project = Project.objects.get(pk=pid)
+        context = {'project' : project,
+                   'projectlayers': [],
+                   'recipe' : CustomImageRecipe.objects.get(pk=recipe_id)
+                  }
+
+        return render(request, "customrecipe.html", context)
+
     @_template_renderer("projectconf.html")
     def projectconf(request, pid):
 
-- 
1.9.1


