Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 9B9B6758D8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:45 +0000 (UTC)
Received: by wgbgq6 with SMTP id gq6so37541205wgb.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=XyoT17anDdeae6BRhT1sVwfBGnP/mBDUkwZoRmWNuok=;
	b=VAFca68tuvXxHR7KSCwsxCfurM3d436O5z7usqTI+RQVf6guuBycGjyUy9bi+SdVgv
	XQmZxCaLHU+Gb2eWD4lItt0NyOCaIdQuaI/2BdRunv+3V8IA/aNzZuc1a/Pgg1G2CRRb
	8pqYquaOR6eNpTm1d2rQHS3cgmRoSCfdCxURO4nPuVRVFZxb4zpKTsXMC9nSeL5nsr5i
	9ZYItkft+y8KoHcOJUnERM7Efqxg+R80n8k0nCifVQF6QiHVBJtbyGMI5bQ4nQspXV1w
	Pe7Cl3jOTNrwfg/2AXaxOtW7YFKn/w/JuzAOZhunxJo8tB7Brrtw4G7vfG3s2zPEkj86
	0zQQ==
X-Gm-Message-State: ALoCoQmWdIkOqUixfu3vfVHCzFV+d4tA/SkAksUfg1xWMu0VWLNGYe/HVs0zKGVN/W2ufi5xIDb3
X-Received: by 10.194.184.79 with SMTP id es15mr6621190wjc.112.1433947186815; 
	Wed, 10 Jun 2015 07:39:46 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id b7sm14888769wjx.47.2015.06.10.07.39.45
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:45 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 1B20356120B; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:38:59 +0100
Message-Id: <8e7a2c3b125a34fd9d6fa0442ab13290137ecc51.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 11/19] toastergui: remove xhr_datatypeahead and xhr_XXXbuild
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We remove the endpoints for XHR on the toastergui application.

The endpoints are now replaced with calls to the respective
REST endpoints (i.e. projectlayers, projecttargets, projectmachines).

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/contrib/tts/urllist.py                 |   2 -
 lib/toaster/toastergui/static/js/base.js           |   6 +-
 lib/toaster/toastergui/static/js/importlayer.js    |   6 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |   4 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |   8 +-
 lib/toaster/toastergui/templates/base.html         |   2 -
 lib/toaster/toastergui/templates/layerdetails.html |   4 +-
 .../toastergui/templates/managed_mrb_section.html  |   2 +-
 lib/toaster/toastergui/templates/project.html      |  52 ++++--
 lib/toaster/toastergui/templates/runagain.html     |   2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   2 +-
 lib/toaster/toastergui/tests.py                    |   6 +-
 lib/toaster/toastergui/urls.py                     |   8 +-
 lib/toaster/toastergui/views.py                    | 208 ++++++---------------
 lib/toaster/toastergui/widgets.py                  |   6 +-
 lib/toaster/toastermain/settings.py                |   2 +-
 16 files changed, 119 insertions(+), 201 deletions(-)

diff --git a/lib/toaster/contrib/tts/urllist.py b/lib/toaster/contrib/tts/urllist.py
index 433ac9f..0226334 100644
--- a/lib/toaster/contrib/tts/urllist.py
+++ b/lib/toaster/contrib/tts/urllist.py
@@ -40,9 +40,7 @@ URLS = [
 'toastergui/project/1/importlayer',
 'toastergui/project/1/targets/',
 'toastergui/project/1/machines/',
-'toastergui/xhr_projectbuild/1/',
 'toastergui/xhr_configvaredit/1',
-'toastergui/xhr_datatypeahead/1',
 'toastergui/xhr_importlayer/',
 'toastergui/xhr_updatelayer/',
 'toastergui/project/1/buildrequest/1',
diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 9c8d01e..747442c 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -89,7 +89,7 @@ function basePageInit (ctx) {
       if (!selectedTarget)
         selectedTarget = { name: newBuildTargetInput.val() };
       /* fire and forget */
-      libtoaster.startABuild(ctx.projectBuildUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
+      libtoaster.startABuild(ctx.projectBuildsUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
       window.location.replace(libtoaster.ctx.projectPageUrl);
     });
 
@@ -105,13 +105,13 @@ function basePageInit (ctx) {
       libtoaster.ctx.projectName = selectedProject.name;
       libtoaster.ctx.projectId = selectedProject.id;
 
-      ctx.projectBuildUrl = selectedProject.projectBuildUrl;
+      ctx.projectBuildsUrl = selectedProject.projectBuildsUrl;
 
       /* we can create a target typeahead only after we have a project selected */
       newBuildTargetInput.prop("disabled", false);
       newBuildTargetBuildBtn.prop("disabled", false);
 
-      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.xhrProjectDataTypeaheadUrl, { type : "targets" }, function(item){
+      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function(item){
         /* successfully selected a target */
         selectedTarget = item;
 	    });
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index beb2ede..e1fc5c5 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -18,7 +18,7 @@ function importLayerPageInit (ctx) {
 
   $("#new-project-button").hide();
 
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.projectLayersUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
@@ -28,7 +28,7 @@ function importLayerPageInit (ctx) {
   /* We automatically add "openembedded-core" layer for convenience as a
    * dependency as pretty much all layers depend on this one
    */
-  $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: "openembedded-core" }, function(layer) {
+  $.getJSON(libtoaster.ctx.projectLayersUrl, { include_added: "true" , search: "openembedded-core" }, function(layer) {
     if (layer.list.length == 1) {
       currentLayerDepSelection = layer.list[0];
       layerDepBtn.click();
@@ -211,7 +211,7 @@ function importLayerPageInit (ctx) {
       var name = $(this).val();
 
       /* Check if the layer name exists */
-      $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" , value: name }, function(layer) {
+      $.getJSON(libtoaster.ctx.projectLayersUrl, { include_added: "true" , search: name }, function(layer) {
       if (layer.list.length > 0) {
         for (var i in layer.list){
           if (layer.list[i].name == name) {
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 8e14b8f..ab78182 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -9,7 +9,7 @@ function layerDetailsPageInit (ctx) {
   var addRmLayerBtn = $("#add-remove-layer-btn");
 
   /* setup the dependencies typeahead */
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.xhrProjectDataTypeaheadUrl, { type : "layers", project_id: libtoaster.ctx.projectId, include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.projectLayersUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
@@ -170,7 +170,7 @@ function layerDetailsPageInit (ctx) {
     $(".build-target-btn").click(function(){
       /* fire a build */
       var target = $(this).data('target-name');
-      libtoaster.startABuild(ctx.projectBuildUrl, libtoaster.ctx.projectId, target, null, null);
+      libtoaster.startABuild(ctx.projectBuildsUrl, libtoaster.ctx.projectId, target, null, null);
       window.location.replace(libtoaster.ctx.projectPageUrl);
     });
   });
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 8791029..2a9a790 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -93,7 +93,7 @@ var libtoaster = (function (){
   }
 
   /* cancelABuild:
-   * url: xhr_projectbuild
+   * url: projectbuilds
    * builds_ids: space separated list of build request ids
    * onsuccess: callback for successful execution
    * onfail: callback for failed execution
@@ -172,15 +172,15 @@ var libtoaster = (function (){
 
   function _getLayerDepsForProject(projectId, layerId, onSuccess, onFail){
     /* Check for dependencies not in the current project */
-    $.getJSON(libtoaster.ctx.xhrProjectDataTypeaheadUrl,
-      { type: 'layerdeps', 'value': layerId , project_id: projectId },
+    $.getJSON(libtoaster.ctx.projectLayersUrl,
+      { format: 'json', search: layerId },
       function(data) {
         if (data.error != "ok") {
           console.log(data.error);
           if (onFail !== undefined)
             onFail(data);
         } else {
-          onSuccess(data);
+          onSuccess(data.layerdeps);
         }
       }, function() {
         console.log("E: Failed to make request");
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 5d51bc3..7fee26e 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -33,12 +33,10 @@
     htmlUrl : "{% static 'html/' %}",
     projectsUrl : "{% url 'all-projects' %}",
     {% if project.id %}
-      xhrProjectDataTypeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
       projectPageUrl : "{% url 'project' project.id %}",
       projectName : "{{project.name}}",
       projectId : {{project.id}},
     {% else %}
-      xhrProjectDataTypeaheadUrl : undefined,
       projectPageUrl : undefined,
       projectName : undefined,
       projectId : undefined,
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index c27d259..ef1795c 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -3,7 +3,7 @@
 {% load humanize %}
 {% load static %}
 {% block localbreadcrumb %}
-<li><a href="{% url 'all-layers' project.id %}">All compatible layers</a></li>
+<li><a href="{% url 'projectlayers' project.id %}">All compatible layers</a></li>
 <li>
   {{layerversion.layer.name}} ({{layerversion.get_vcs_reference|truncatechars:13}})
 </li>
@@ -33,7 +33,7 @@
 
   $(document).ready(function (){
     var ctx = {
-      projectBuildUrl : "{% url 'xhr_projectbuild' project.id %}",
+      projectBuildsUrl : "{% url 'projectbuilds' project.id %}",
       layerDetailsUrl : "{% url 'base_layerdetails' project.id %}",
       xhrUpdateLayerUrl : "{% url 'xhr_updatelayer' %}",
       layerVersion : {
diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index c93c2af..47e64ea 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -129,7 +129,7 @@
             <div class="span4 lead">Build queued
               <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
             </div>
-            <button class="btn btn-info pull-right cancel-build-btn" data-build-id="{{buildrequest.id}}" data-request-url="{% url 'xhr_projectbuild' buildrequest.project.id %}" >Cancel</button>
+            <button class="btn btn-info pull-right cancel-build-btn" data-build-id="{{buildrequest.id}}" data-request-url="{% url 'projectbuilds' buildrequest.project.id %}" >Cancel</button>
 
          {% elif buildrequest.state == buildrequest.REQ_CREATED %}
 
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index e598631..63fbc40 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -30,7 +30,7 @@ vim: expandtab tabstop=2
 
 {%else%}
 
-<div id="main" role="main" data-ng-app="project" data-ng-controller="prjCtrl" class="top-padded">
+<div id="main" role="main" data-ng-app="project" data-ng-controller="prjCtrl" class="top-padded" data-ng-cloak>
 
   <!-- project name -->
   <div class="page-header">
@@ -46,10 +46,30 @@ vim: expandtab tabstop=2
 
   <!-- custom templates for ng -->
 
-  <script type="text/ng-template" id="suggestion_details">
-    <a> {[match.model.name]} {[match.model.detail]} </a>
+  <style>
+  .missing-layer {
+    color: lightgrey;
+  }
+  </style>
+  <script type="text/ng-template" id="recipes_suggestion_details">
+    <a> {[match.model.name]}
+      <span data-ng-class="{'missing-layer':($parent.$parent.$parent.$parent.filterProjectLayerIds().indexOf(match.model.projectcompatible_layer.id) == -1)}">
+          [{[match.model.layer_version__layer__name]}]
+      </span>
+    </a>
   </script>
 
+  <script type="text/ng-template" id="machines_suggestion_details">
+    <a>  {[match.model.name]} <span class="{'missing-layer':(filterProjectLayerIds().indexOf(match.model.layer_version_compatible_id) == -1)}">[{[match.model.layer_version__layer__name]}]</span> </a>
+  </script>
+
+  <script type="text/ng-template" id="layers_suggestion_details">
+    <a>  {[match.model['layer__name']]} ( {[match.model.layer__vcs_url]} ) </a>
+  </script>
+
+
+
+
   <!-- modal dialogs -->
   <script type="text/ng-template" id="dependencies_modal">
     <div class="modal-header">
@@ -104,14 +124,14 @@ vim: expandtab tabstop=2
   <div class="well">
     <form class="build-form" data-ng-submit="buildNamedTarget()">
       <div class="input-append controls">
-        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-ng-model="targetName" data-typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" data-typeahead-template-url="suggestion_details" data-ng-disabled="!layers.length"/>
+        <input type="text" class="huge input-xxlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-ng-model="targetName" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!layers.length"/>
         <button type="submit" class="btn btn-large btn-primary" data-ng-disabled="!targetName.length">
         Build
         </button>
       </div>
       <i class="icon-question-sign get-help get-help-blue" title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to a recipe name, like so: <code>core-image-minimal:do_build</code>"></i>
       <p>
-        <a href="{% url 'all-targets' project.id %}">View all compatible recipes</a>
+        <a href="{% url 'projecttargets' project.id %}">View all compatible recipes</a>
         <i class="icon-question-sign get-help get-help-blue heading-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         {% if completedbuilds.count %}
           | <a href="{% url 'projectbuilds' project.id %}">View all project builds ({{completedbuilds.count}})</a>
@@ -278,7 +298,7 @@ vim: expandtab tabstop=2
         <p>
         You can:
           <ul>
-            <li> <a href="{% url 'all-layers' project.id %}">View all compatible layers available in Toaster</a>
+            <li> <a href="{% url 'projectlayers' project.id %}">View all compatible layers available in Toaster</a>
             <li> <a href="{% url 'importlayer' project.id %}">Import a layer</a>
             <li> <a href="https://www.yoctoproject.org/docs/1.6.1/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the manual</a>
           </ul>
@@ -287,13 +307,13 @@ vim: expandtab tabstop=2
       </div>
       <form data-ng-submit="layerAdd()">
         <div class="input-append">
-          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e.name for e in getAutocompleteSuggestions('layers', $viewValue)|filter:$viewValue" data-typeahead-template-url="suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" />
+          <input type="text" class="input-xlarge" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" />
           <input type="submit" id="add-layer" class="btn" value="Add" data-ng-disabled="!layerAddName.length"/>
         </div>
         {% csrf_token %}
       </form>
       <p>
-        <a href="{% url 'all-layers' project.id %}">View all compatible layers</a>
+        <a href="{% url 'projectlayers' project.id %}">View all compatible layers</a>
         <i class="icon-question-sign get-help" title="View all the layers you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         |
         <a href="{% url 'importlayer' project.id %}">Import layer</a></p>
@@ -314,14 +334,14 @@ vim: expandtab tabstop=2
       </h3>
         <form data-ng-submit="buildNamedTarget()">
           <div class="input-append">
-            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="e.name for e in getAutocompleteSuggestions('targets', $viewValue)|filter:$viewValue" data-typeahead-template-url="suggestion_details" data-ng-disabled="!layers.length">
+            <input type="text" class="input-xlarge" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!layers.length">
             <button type="submit" class="btn btn-primary" data-ng-disabled="!targetName1.length">
               Build </button>
           </div>
           {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'all-targets' project.id %}">View all compatible recipes</a>
+          <a href="{% url 'projecttargets' project.id %}">View all compatible recipes</a>
           <i class="icon-question-sign get-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
         </p>
         <div data-ng-if="frequenttargets.length">
@@ -355,13 +375,13 @@ vim: expandtab tabstop=2
               You cannot really compare the builds for the new machine with the previous ones.
         </div>
         <form data-ng-submit="editProjectSettings('#select-machine')" class="input-append">
-              <input type="text" id="machine" autocomplete="off" data-ng-model="machineName" value="{[machine.name]}" data-typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)" data-typeahead-template-url="suggestion_details" />
+              <input type="text" id="machine" autocomplete="off" data-ng-model="machineName" value="{[machine.name]}" data-typeahead="m.name for m in getMachinesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="machines_suggestion_details" />
               <input type="submit" id="apply-change-machine" class="btn" data-ng-disabled="machineName == machine.name || machineName.length == 0" value="Save"/>
               <input type="reset" id="cancel-machine" class="btn btn-link" data-ng-click="toggle('#select-machine')" value="Cancel"/>
               {% csrf_token %}
         </form>
         <p>
-          <a href="{% url 'all-machines' project.id %}" class="link">View all compatible machines</a>
+          <a href="{% url 'projectmachines' project.id %}" class="link">View all compatible machines</a>
         <i class="icon-question-sign get-help" title="View all the machines you can set with the release selected for this project, which is {[project.release.desc]}"></i>
       </p>
       </div>
@@ -429,11 +449,11 @@ vim: expandtab tabstop=2
 angular.element(document).ready(function() {
   scope = angular.element("#main").scope();
   scope.urls = {};
-  scope.urls.xhr_build = "{% url 'xhr_projectbuild' project.id %}";
+  scope.urls.xhr_build = "{% url 'projectbuilds' project.id %}";
   scope.urls.xhr_edit = "{% url 'project' project.id %}?format=json";
-  scope.urls.xhr_datatypeahead = "{% url 'xhr_datatypeahead' project.id %}";
-  scope.urls.layers = "{% url 'all-layers' project.id %}";
-  scope.urls.targets = "{% url 'all-targets' project.id %}";
+  scope.urls.layers = "{% url 'projectlayers' project.id %}";
+  scope.urls.targets = "{% url 'projecttargets' project.id %}";
+  scope.urls.machines = "{% url 'projectmachines' project.id %}";
   scope.urls.importlayer = "{% url 'importlayer' project.id %}";
   scope.urls.layer = "{% url 'base_layerdetails' project.id %}";
   scope.project = {{prj|json}};
diff --git a/lib/toaster/toastergui/templates/runagain.html b/lib/toaster/toastergui/templates/runagain.html
index a78c0dd..b4ba5fb 100644
--- a/lib/toaster/toastergui/templates/runagain.html
+++ b/lib/toaster/toastergui/templates/runagain.html
@@ -1,6 +1,6 @@
 {% load projecttags %}
 onclick='scheduleBuild(
-    {% url 'xhr_projectbuild' buildrequest.project.id as bpi %}{{bpi|json}},
+    {% url 'projectbuilds' buildrequest.project.id as bpi %}{{bpi|json}},
     {{buildrequest.project.name|json}},
     {% url 'project' buildrequest.project.id as bpurl %}{{bpurl|json}},
     {{buildrequest.brtarget_set.all|get_tasks|json}})
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index e79a4e5..75f2261 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -55,7 +55,7 @@ def json(value, default = None):
     # JSON spec says that "\/" is functionally identical to "/" to allow for HTML-tag embedding in JSON strings
     # unfortunately, I can't find any option in the json module to turn on forward-slash escaping, so we do
     # it manually here
-    return mark_safe(JsonLib.dumps(value, default = default, ensure_ascii=False).replace('</', '<\\/'))
+    return mark_safe(JsonLib.dumps(value, indent=2, default = default, ensure_ascii=False).replace('</', '<\\/'))
 
 @register.assignment_tag
 def query(qs, **kwargs):
diff --git a/lib/toaster/toastergui/tests.py b/lib/toaster/toastergui/tests.py
index c92c5fe..77e80fe 100644
--- a/lib/toaster/toastergui/tests.py
+++ b/lib/toaster/toastergui/tests.py
@@ -38,9 +38,9 @@ class AllProjectsViewTestCase(ProvisionedProjectTestCase):
 
         self.assertTrue(AllProjectsViewTestCase.TEST_PROJECT_NAME in map(lambda x: x["name"], data["list"]))
         self.assertTrue("id" in data["list"][0])
-        self.assertTrue("xhrProjectDataTypeaheadUrl" in data["list"][0])
+        self.assertTrue("projectLayersUrl" in data["list"][0])
         self.assertTrue("projectPageUrl" in data["list"][0])
-        self.assertTrue("projectBuildUrl" in data["list"][0])
+        self.assertTrue("projectBuildsUrl" in data["list"][0])
 
 class ProvisionedLayersProjectTestCase(ProvisionedProjectTestCase):
     LAYER_NAME = "base-layer"
@@ -59,7 +59,7 @@ class XHRDataTypeAheadTestCase(ProvisionedLayersProjectTestCase):
         self.assertTrue(self.lv in self.project.compatible_layerversions())
 
     def test_xhr_datatypeahead_layer(self):
-        response = self.client.get(reverse('xhr_datatypeahead', args=(self.project.id,)), {"type": "layers"})
+        response = self.client.get(reverse('xhr_datatypeahead', args=(self.project.id,)), {"type": "layerdeps"})
         self.assertEqual(response.status_code, 200)
         self.assertTrue(response['Content-Type'].startswith('application/json'))
 
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index d527be0..f1b74cd 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -91,19 +91,19 @@ urlpatterns = patterns('toastergui.views',
             tables.MachinesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.MachinesTable.__name__.lower(),
               'title' : 'All compatible machines' },
-            name="all-machines"),
+            name="projectmachines"),
 
         url(r'^project/(?P<pid>\d+)/recipes/$',
             tables.RecipesTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.RecipesTable.__name__.lower(),
               'title' : 'All compatible recipes' },
-            name="all-targets"),
+            name="projecttargets"),
 
         url(r'^project/(?P<pid>\d+)/layers/$',
             tables.LayersTable.as_view(template_name="generic-toastertable-page.html"),
             { 'table_name': tables.LayersTable.__name__.lower(),
               'title' : 'All compatible layers' },
-            name="all-layers"),
+            name="projectlayers"),
 
         url(r'^project/(?P<pid>\d+)/layer/(?P<layerid>\d+)$',
             tables.LayerDetails.as_view(template_name='layerdetails.html'),
@@ -121,10 +121,8 @@ urlpatterns = patterns('toastergui.views',
               'title' : 'All machines in layer' },
             name=tables.LayerMachinesTable.__name__.lower()),
 
-        url(r'^xhr_projectbuild/(?P<pid>\d+)$', 'xhr_projectbuild', name='xhr_projectbuild'),
         url(r'^xhr_configvaredit/(?P<pid>\d+)$', 'xhr_configvaredit', name='xhr_configvaredit'),
 
-        url(r'^xhr_datatypeahead/(?P<pid>\d+)$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
         url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
         url(r'^xhr_updatelayer/$', 'xhr_updatelayer', name='xhr_updatelayer'),
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index c25c512..5221f1f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -136,28 +136,6 @@ def _template_renderer(template):
 
                 # we're about to return; to keep up with the XHR API, we set the error to OK
                 context["error"] = "ok"
-                def _objtojson(obj):
-                    from django.db.models.query import QuerySet
-                    from django.db.models import Model, IntegerField
-                    if isinstance(obj, datetime):
-                        return obj.isoformat()
-                    elif isinstance(obj, timedelta):
-                        return obj.total_seconds()
-                    elif isinstance(obj, QuerySet) or isinstance(obj, set):
-                        return list(obj)
-                    elif hasattr( obj, '__dict__'):
-                        d = obj.__dict__
-                        nd = dict(d)
-                        for di in d:
-                            if di.startswith("_"):
-                                del nd[di]
-                            elif isinstance(d[di], Model):
-                                nd[di] = d[di].pk
-                            elif isinstance(d[di], int) and hasattr(obj, "get_%s_display" % di):
-                                nd[di] = getattr(obj, "get_%s_display" % di)()
-                        return nd
-                    else:
-                        raise TypeError("Unserializable object %s of type %s" % ( obj, type(obj)))
 
                 return HttpResponse(jsonfilter(context, default=objtojson ),
                             content_type = "application/json; charset=utf-8")
@@ -167,6 +145,21 @@ def _template_renderer(template):
     return func_wrapper
 
 
+def _lv_to_dict(prj, x = None):
+    if x is None:
+        def wrapper(x):
+            return _lv_to_dict(prj, x)
+        return wrapper
+
+    return {"id": x.pk,
+            "name": x.layer.name,
+            "tooltip": x.layer.vcs_url+" | "+x.get_vcs_reference(),
+            "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.get_vcs_reference()+")"),
+            "giturl": x.layer.vcs_url,
+            "layerdetailurl" : reverse('layerdetails', args=(prj.id,x.pk)),
+            "revision" : x.get_vcs_reference(),
+           }
+
 
 def _build_page_range(paginator, index = 1):
     try:
@@ -335,7 +328,6 @@ def _search_tuple(request, model):
 def _get_queryset(model, queryset, filter_string, search_term, ordering_string, ordering_secondary=''):
     if filter_string:
         filter_query = _get_filtering_query(filter_string)
-#        raise Exception(filter_query)
         queryset = queryset.filter(filter_query)
     else:
         queryset = queryset.all()
@@ -2330,82 +2322,12 @@ if toastermain.settings.MANAGED:
         return context
 
 
-    def xhr_projectbuild(request, pid):
-        try:
-            if request.method != "POST":
-                raise BadParameterException("invalid method")
-            pid = pid
-            prj = Project.objects.get(id = pid)
-
-
-            if 'buildCancel' in request.POST:
-                for i in request.POST['buildCancel'].strip().split(" "):
-                    try:
-                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_QUEUED)
-                        br.state = BuildRequest.REQ_DELETED
-                        br.save()
-                    except BuildRequest.DoesNotExist:
-                        pass
-
-            if 'buildDelete' in request.POST:
-                for i in request.POST['buildDelete'].strip().split(" "):
-                    try:
-                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
-                    except BuildRequest.DoesNotExist:
-                        pass
-
-            if 'targets' in request.POST:
-                ProjectTarget.objects.filter(project = prj).delete()
-                s = str(request.POST['targets'])
-                for t in s.translate(None, ";%|\"").split(" "):
-                    if ":" in t:
-                        target, task = t.split(":")
-                    else:
-                        target = t
-                        task = ""
-                    ProjectTarget.objects.create(project = prj, target = target, task = task)
-
-                br = prj.schedule_build()
-
-            return HttpResponse(jsonfilter({"error":"ok",
-                "builds" : _project_recent_build_list(prj),
-            }), content_type = "application/json")
-        except Exception as e:
-            return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
-
-
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
     def xhr_datatypeahead(request, pid):
         try:
             prj = Project.objects.get(pk = pid)
 
-            def _lv_to_dict(x):
-                return {"id": x.pk,
-                        "name": x.layer.name,
-                        "tooltip": x.layer.vcs_url+" | "+x.get_vcs_reference(),
-                        "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.get_vcs_reference()+")"),
-                        "giturl": x.layer.vcs_url,
-                        "layerdetailurl" : reverse('layerdetails', args=(prj.id,x.pk)),
-                        "revision" : x.get_vcs_reference(),
-                       }
-
-
-            # returns layers for current project release that are not in the project set, matching the name
-            if request.GET.get('type', None) == "layers":
-                # all layers for the current project
-                queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('search',''))
-
-                # but not layers with equivalent layers already in project
-                if not request.GET.has_key('include_added'):
-                    queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])[:8]
-
-                # and show only the selected layers for this project
-                final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
-
-                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
-
-
             # returns layer dependencies for a layer, excluding current project layers
             if request.GET.get('type', None) == "layerdeps":
                 queryset = prj.compatible_layerversions().exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()]).filter(
@@ -2413,8 +2335,7 @@ if toastermain.settings.MANAGED:
 
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
 
-                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
-
+                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict(prj), sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
 
 
             # returns layer versions that would be deleted on the new release__pk
@@ -2428,7 +2349,7 @@ if toastermain.settings.MANAGED:
                         retval.append(i)
 
                 return HttpResponse(jsonfilter( {"error":"ok",
-                    "list" : map( _lv_to_dict,  map(lambda x: x.layercommit, retval ))
+                    "list" : map( _lv_to_dict(prj),  map(lambda x: x.layercommit, retval ))
                     }), content_type = "application/json")
 
 
@@ -2446,52 +2367,8 @@ if toastermain.settings.MANAGED:
                     # and show only the selected layers for this project
                     final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
 
-                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict(prj), final_list) }), content_type = "application/json")
 
-            # returns targets provided by current project layers
-            if request.GET.get('type', None) == "targets":
-                search_token = request.GET.get('search','')
-                queryset_all = Recipe.objects.filter(layer_version__layer__name__in = [x.layercommit.layer.name for x in prj.projectlayer_set.all().select_related("layercommit__layer")]).filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token))
-
-#                layer_equivalent_set = []
-#                for i in prj.projectlayer_set.all().select_related("layercommit__up_branch", "layercommit__layer"):
-#                    layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
-
-#                queryset_all = queryset_all.filter(layer_version__in =  layer_equivalent_set)
-
-                # if we have more than one hit here (for distinct name and version), max the id it out
-                queryset_all_maxids = queryset_all.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
-                queryset_all = queryset_all.filter(id__in = queryset_all_maxids).order_by("name").select_related("layer_version__layer")
-
-
-                return HttpResponse(jsonfilter({ "error":"ok",
-                    "list" :
-                        # 7152 - sort by token position
-                        sorted (
-                            map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name +"]"},
-                        queryset_all[:8]),
-                            key = lambda i: i["name"].find(search_token) if i["name"].find(search_token) > -1 else 9999,
-                        )
-
-                    }), content_type = "application/json")
-
-            # returns machines provided by the current project layers
-            if request.GET.get('type', None) == "machines":
-                queryset_all = Machine.objects.all()
-                if 'project_id' in request.session:
-                    queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
-
-                search_token = request.GET.get('search','')
-                queryset_all = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
-
-                return HttpResponse(jsonfilter({ "error":"ok",
-                        "list" :
-                        # 7152 - sort by the token position
-                        sorted (
-                            map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ "]"}, queryset_all[:8]),
-                            key = lambda i: i["name"].find(search_token) if i["name"].find(search_token) > -1 else 9999,
-                        )
-                    }), content_type = "application/json")
 
             raise Exception("Unknown request! " + request.GET.get('type', "No parameter supplied"))
         except Exception as e:
@@ -2791,7 +2668,41 @@ if toastermain.settings.MANAGED:
 
     @_template_renderer('projectbuilds.html')
     def projectbuilds(request, pid):
-        buildrequests = BuildRequest.objects.filter(project_id = pid).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
+        # process any build request
+        prj = Project.objects.get(id = pid)
+        if request.method == "POST":
+
+            if 'buildCancel' in request.POST:
+                for i in request.POST['buildCancel'].strip().split(" "):
+                    try:
+                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_QUEUED)
+                        br.state = BuildRequest.REQ_DELETED
+                        br.save()
+                    except BuildRequest.DoesNotExist:
+                        pass
+
+            if 'buildDelete' in request.POST:
+                for i in request.POST['buildDelete'].strip().split(" "):
+                    try:
+                        br = BuildRequest.objects.select_for_update().get(project = prj, pk = i, state__lte = BuildRequest.REQ_DELETED).delete()
+                    except BuildRequest.DoesNotExist:
+                        pass
+
+            if 'targets' in request.POST:
+                ProjectTarget.objects.filter(project = prj).delete()
+                s = str(request.POST['targets'])
+                for t in s.translate(None, ";%|\"").split(" "):
+                    if ":" in t:
+                        target, task = t.split(":")
+                    else:
+                        target = t
+                        task = ""
+                    ProjectTarget.objects.create(project = prj, target = target, task = task)
+
+                br = prj.schedule_build()
+
+
+        buildrequests = BuildRequest.objects.filter(project = prj).exclude(state__lte = BuildRequest.REQ_INPROGRESS).exclude(state=BuildRequest.REQ_DELETED)
 
         try:
             context, pagesize, orderby = _build_list_helper(request, buildrequests, False)
@@ -2940,9 +2851,10 @@ if toastermain.settings.MANAGED:
         # add fields needed in JSON dumps for API call support
         for p in project_info.object_list:
             p.id = p.pk
-            p.xhrProjectDataTypeaheadUrl = reverse('xhr_datatypeahead', args=(p.id,))
             p.projectPageUrl = reverse('project', args=(p.id,))
-            p.projectBuildUrl = reverse('xhr_projectbuild', args=(p.id,))
+            p.projectLayersUrl = reverse('projectlayers', args=(p.id,))
+            p.projectBuildsUrl = reverse('projectbuilds', args=(p.id,))
+            p.projectTargetsUrl = reverse('projecttargets', args=(p.id,))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         build_mru = _managed_get_latest_builds()
@@ -3242,14 +3154,6 @@ else:
         return {}
 
     @_template_renderer('landing_not_managed.html')
-    def xhr_projectbuild(request, pid):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
-    def xhr_datatypeahead(request):
-        return {}
-
-    @_template_renderer('landing_not_managed.html')
     def xhr_configvaredit(request, pid):
         return {}
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 8bc3d7f..f5a1b3e 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -253,8 +253,8 @@ class ToasterTable(TemplateView):
 
         data = cache.get(cache_name)
 
-        if data:
-            return data
+        #if data:
+        #    return data
 
         self.setup_columns(**kwargs)
 
@@ -277,9 +277,9 @@ class ToasterTable(TemplateView):
             'default_orderby' : self.default_orderby,
             'columns' : self.columns,
             'rows' : [],
+            'error' : "ok",
         }
 
-
         try:
             for row in page.object_list:
                 #Use collection to maintain the order
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 225138b..3c7cb3b 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -223,7 +223,7 @@ CACHES = {
            'default': {
                'BACKEND': 'django.core.cache.backends.filebased.FileBasedCache',
                'LOCATION': '/tmp/django-default-cache',
-               'TIMEOUT': 5,
+               'TIMEOUT': 1,
             }
           }
 
-- 
1.9.1


