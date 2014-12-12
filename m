Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 09D5772503
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:24 +0000 (UTC)
Received: by mail-wi0-f181.google.com with SMTP id r20so2261198wiv.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=fK1ZwQjSxBfSgf244wyad0uukSwmx1kLB2dJI749Kwg=;
	b=PFBm3qDBGw0hCV4OBf2GzUqHH4BUVBjAoWWRGtSajdlWZop1hDSKgYUBUlFXiRGVQQ
	hV5hIPKIdjSnUsRX08r1N7RUzF74yXuFyEGeXbnxTgG+EXlJkasxNAYLvafyZTcVDemJ
	qmbIWd1Innw8cPGfheDFVmefw4lwvzLdcly5u7pdekXvfuczK8m9gLCgxfVIP0RXSm9h
	d1Jk/dsVZAV8qFxKuSJUHx5pYW9FP+48d0hXfpQozW/EEsaLPtYvVmJiQAUs3FO/cEmO
	vy6CeqwfM9Rhe4gioo9Qh/W2GfuGPreICdlc5NcUFv1F8h15xFn1ijPJG1qBrf4mESWu
	SVxg==
X-Gm-Message-State: ALoCoQm/cWdDkUMvmQchvISh/MIMwXQ1cFKx2TbFLJCmtDrWd9fk4HLB+w7amhZU1xruVi8OiClT
X-Received: by 10.180.211.2 with SMTP id my2mr6781238wic.3.1418384725032;
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id wv8sm1478658wjc.44.2014.12.12.03.45.21
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:22 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 445A1566242; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:10 +0000
Message-Id: <017f5c746e894f9d87d927c848386459ea332378.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 11/18] toaster: Add import layer feature.
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:25 -0000

From: Michael Wood <michael.g.wood@intel.com>

This feature allows users to import layers from git into their current
project and associate it with the release of the current project and the
dependencies for the newly imported layer with existing layers.
It will also resolve the child dependencies of the dependencies added.

[YOCTO #6595]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js    | 277 +++++++++++++++++++++
 lib/toaster/toastergui/static/js/projectapp.js     |   6 +
 lib/toaster/toastergui/templates/importlayer.html  | 109 +++++---
 .../toastergui/templates/layers_dep_modal.html     |  68 +++++
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    | 107 +++++++-
 6 files changed, 533 insertions(+), 36 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/importlayer.js
 create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
new file mode 100644
index 0000000..e2bc1ab
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -0,0 +1,277 @@
+"use strict"
+
+function importLayerPageInit (ctx) {
+
+  var layerDepBtn = $("#add-layer-dependency-btn");
+  var importAndAddBtn = $("#import-and-add-btn");
+  var layerNameInput = $("#layer-name");
+  var vcsURLInput = $("#layer-git-repo-url");
+  var gitRefInput = $("#layer-git-ref");
+  var layerDepInput = $("#layer-dependency");
+  var layerNameCtrl = $("#layer-name-ctrl");
+  var duplicatedLayerName = $("#duplicated-layer-name-hint");
+
+  var layerDeps = {};
+  var layerDepsDeps = {};
+  var currentLayerDepSelection;
+  var validLayerName = /^(\w|-)+$/;
+
+  $("#new-project-button").hide();
+
+  libtoaster.makeTypeahead(layerDepInput, ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: ctx.projectId, include_added: "true" }, function(item){
+    currentLayerDepSelection = item;
+
+    layerDepBtn.removeAttr("disabled");
+  });
+
+
+  /* We automatically add "openembedded-core" layer for convenience as a
+   * dependency as pretty much all layers depend on this one
+   */
+  $.getJSON(ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: ctx.projectId, include_added: "true" , value: "openembedded-core" }, function(layer) {
+    if (layer.list.length == 1) {
+      currentLayerDepSelection = layer.list[0];
+      layerDepBtn.click();
+    }
+  });
+
+  layerDepBtn.click(function(){
+    if (currentLayerDepSelection == undefined)
+      return;
+
+    layerDeps[currentLayerDepSelection.id] = currentLayerDepSelection;
+
+    /* Make a list item for the new layer dependency */
+    var newLayerDep = $("<li><a></a><span class=\"icon-trash\" data-toggle=\"tooltip\" title=\"Delete\"></span></li>");
+
+    newLayerDep.data('layer-id', currentLayerDepSelection.id);
+    newLayerDep.children("span").tooltip();
+
+    var link = newLayerDep.children("a");
+    link.attr("href", ctx.layerDetailsUrl+String(currentLayerDepSelection.id));
+    link.text(currentLayerDepSelection.name);
+    link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
+
+    var trashItem = newLayerDep.children("span");
+    trashItem.click(function () {
+      var toRemove = $(this).parent().data('layer-id');
+      delete layerDeps[toRemove];
+      $(this).parent().fadeOut(function (){
+        $(this).remove();
+      });
+    });
+
+    $("#layer-deps-list").append(newLayerDep);
+
+    libtoaster.getLayerDepsForProject(ctx.xhrDataTypeaheadUrl, ctx.projectId, currentLayerDepSelection.id, function (data){
+        /* These are the dependencies of the layer added as a dependency */
+        if (data.list.length > 0) {
+          currentLayerDepSelection.url = ctx.layerDetailsUrl+currentLayerDepSelection.id;
+          layerDeps[currentLayerDepSelection.id].deps = data.list
+        }
+
+        /* Clear the current selection */
+        layerDepInput.val("");
+        currentLayerDepSelection = undefined;
+        layerDepBtn.attr("disabled","disabled");
+      }, null);
+  });
+
+  importAndAddBtn.click(function(){
+    /* arrray of all layer dep ids includes parent and child deps */
+    var allDeps = [];
+    /* temporary object to use to do a reduce on the dependencies for each
+     * layer dependency added
+     */
+    var depDeps = {};
+
+    /* the layers that have dependencies have an extra property "deps"
+     * look in this for each layer and reduce this to a unquie object
+     * of deps.
+     */
+    for (var key in layerDeps){
+      if (layerDeps[key].hasOwnProperty('deps')){
+        for (var dep in layerDeps[key].deps){
+          var layer = layerDeps[key].deps[dep];
+          depDeps[layer.id] = layer;
+        }
+      }
+      allDeps.push(layerDeps[key].id);
+    }
+
+    /* we actually want it as an array so convert it now */
+    var depDepsArray = [];
+    for (var key in depDeps)
+      depDepsArray.push (depDeps[key]);
+
+    if (depDepsArray.length > 0) {
+      var layer = { name: layerNameInput.val(), url: "#", id: -1 };
+      show_layer_deps_modal(ctx.projectId, layer, depDepsArray, function(selected){
+        /* Add the accepted dependencies to the allDeps array */
+        if (selected.length > 0){
+          allDeps.concat (selected);
+        }
+        import_and_add ();
+      });
+    } else {
+      import_and_add ();
+    }
+
+    function import_and_add () {
+      /* convert to a csv of all the deps to be added */
+      var layerDepsCsv = allDeps.join(",");
+
+      var layerData = {
+        name: layerNameInput.val(),
+        vcs_url: vcsURLInput.val(),
+        git_ref: gitRefInput.val(),
+        summary:  $("#layer-summary").val(),
+        dir_path: $("#layer-subdir").val(),
+        project_id: ctx.projectId,
+        layer_deps: layerDepsCsv,
+      };
+
+      $.ajax({
+          type: "POST",
+          url: ctx.xhrImportLayerUrl,
+          data: layerData,
+          headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
+          success: function (data) {
+            if (data.error != "ok") {
+              show_error_message(data, layerData);
+              console.log(data.error);
+            } else {
+              /* Success layer import now go to the project page */
+              window.location.replace(ctx.projectPageUrl+'#/layerimported='+layerData.name);
+            }
+          },
+          error: function (data) {
+            console.log("Call failed");
+            console.log(data);
+          }
+      });
+    }
+  });
+
+  function show_error_message(error, layerData) {
+
+    var errorMsg = $("#import-error").fadeIn();
+    var errorType = error.error;
+    var body = errorMsg.children("span");
+    var title = errorMsg.children("h3");
+    var optionsList = errorMsg.children("ul");
+    var invalidLayerRevision = $("#invalid-layer-revision-hint");
+    var layerRevisionCtrl = $("#layer-revision-ctrl");
+
+    /* remove any existing items */
+    optionsList.children().each(function(){ $(this).remove(); });
+    body.text("");
+    title.text("");
+    invalidLayerRevision.hide();
+    layerNameCtrl.removeClass("error");
+    layerRevisionCtrl.removeClass("error");
+
+    switch (errorType){
+      case 'hint-layer-version-exists':
+        title.text("This layer already exists");
+        body.html("A layer <strong>"+layerData.name+"</strong> already exists with this Git repository URL and this revision. You can:");
+        optionsList.append("<li>Import <strong>"+layerData.name+"</strong> with a different revision </li>");
+        optionsList.append("<li>or <a href=\""+ctx.layerDetailsUrl+error.existing_layer_version+"/\" >change the revision of the existing layer</a></li>");
+
+        layerRevisionCtrl.addClass("error");
+
+        invalidLayerRevision.html("A layer <strong>"+layerData.name+"</strong> already exists with this revision.<br />You can import <strong>"+layerData.name+"</strong> with a different revision");
+        invalidLayerRevision.show();
+        break;
+
+      case 'hint-layer-exists-with-different-url':
+        title.text("This layer already exists");
+        body.html("A layer <strong>"+layerData.name+"</strong> already exists with a different Git repository URL:<br /><br />"+error.current_url+"<br /><br />You Can:");
+        optionsList.append("<li>Import the layer under a different name</li>");
+        optionsList.append("<li>or <a href=\""+ctx.layerDetailsUrl+error.current_id+"/\" >change the Git repository URL of the existing layer</a></li>");
+        duplicatedLayerName.html("A layer <strong>"+layerData.name+"</strong> already exists with a different Git repository URL.<br />To import this layer give it a different name.");
+        duplicatedLayerName.show();
+        layerNameCtrl.addClass("error");
+        break;
+
+      case 'hint-layer-exists':
+        title.text("This layer already exists");
+        body.html("A layer <strong>"+layerData.name+"</strong> already exists: You Can:");
+        optionsList.append("<li>Import the layer under a different name</li>");
+        break;
+      default:
+        title.text("Error")
+        body.text(data.error);
+    }
+  }
+
+  function enable_import_btn (enabled) {
+    var importAndAddHint = $("#import-and-add-hint");
+
+    if (enabled) {
+      importAndAddBtn.removeAttr("disabled");
+      importAndAddHint.hide();
+      return;
+    }
+
+    importAndAddBtn.attr("disabled", "disabled");
+    importAndAddHint.show();
+  }
+
+  function check_form() {
+    var valid = false;
+    var inputs = $("input:required");
+
+    for (var i=0; i<inputs.length; i++){
+      if (!(valid = inputs[i].value)){
+        enable_import_btn(false);
+        break;
+      }
+    }
+
+    if (valid)
+      enable_import_btn(true);
+  }
+
+  vcsURLInput.keyup(function() {
+    check_form();
+  });
+
+  gitRefInput.keyup(function() {
+    check_form();
+  });
+
+  layerNameInput.keyup(function() {
+    if ($(this).val() && !validLayerName.test($(this).val())){
+      layerNameCtrl.addClass("error")
+      $("#invalid-layer-name-hint").show();
+      enable_import_btn(false);
+      return;
+    }
+
+    /* Don't remove the error class if we're displaying the error for another
+     * reason.
+     */
+    if (!duplicatedLayerName.is(":visible"))
+      layerNameCtrl.removeClass("error")
+
+    $("#invalid-layer-name-hint").hide();
+    check_form();
+  });
+
+  /* Have a guess at the layer name */
+  vcsURLInput.focusout(function (){
+    /* If we a layer name specified don't overwrite it or if there isn't a
+     * url typed in yet return
+     */
+    if (layerNameInput.val() || !$(this).val())
+      return;
+
+    if ($(this).val().search("/")){
+      var urlPts = $(this).val().split("/");
+      var suggestion = urlPts[urlPts.length-1].replace(".git","");
+      layerNameInput.val(suggestion);
+    }
+  });
+
+}
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index e9b07c7..8e3499a 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -571,6 +571,12 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     "\">select targets</a> you want to build.", "alert-success");
         });
 
+        _cmdExecuteWithParam("/layerimported", function (layer) {
+            $scope.displayAlert($scope.zone2alerts,
+                    "You have imported <strong>" + layer +
+                    "</strong> and added it to your project.", "alert-success");
+        });
+
         _cmdExecuteWithParam("/targetbuild=", function (targets) {
             var oldTargetName = $scope.targetName;
             $scope.targetName = targets.split(",").join(" ");
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 7e48eac..913f951 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -1,68 +1,115 @@
 {% extends "baseprojectpage.html" %}
 {% load projecttags %}
 {% load humanize %}
+{% load static %}
 
 {% block localbreadcrumb %}
-<li>Layers</li>
+<li>Import layer</li>
 {% endblock %}
 
 {% block projectinfomain %}
+
+                  <script src="{% static 'js/importlayer.js' %}"></script>
+                  <script>
+                    $(document).ready(function (){
+                      var ctx = {};
+                      ctx.xhrDataTypeaheadUrl = "{% url 'xhr_datatypeahead' %}";
+                      ctx.layerDetailsUrl = "{% url 'layerdetails' %}";
+                      ctx.xhrImportLayerUrl = "{% url 'xhr_importlayer' %}";
+                      ctx.xhrEditProjectUrl = "{% url 'xhr_projectedit' project.id %}";
+                      ctx.projectPageUrl = "{% url 'project' project.id %}";
+                      ctx.projectId = {{project.id}};
+
+                      try {
+                        importLayerPageInit(ctx);
+                      } catch(e) {
+                        document.write(e.stack);
+                        console.log(e);
+                      }
+                    });
+                  </script>
+
                 <div class="page-header">
                     <h1>Import layer</h1>
                 </div>
+
+                {% include "layers_dep_modal.html" %}
                 <form>
         {% if project %}
                     <span class="help-block" style="padding-left:19px;">The layer you are importing must be compatible with {{project.release.name}} ({{project.release.description}}), which is the release you are using in this project.</span>
           {% endif %}
-                    <fieldset class="air">
-                        <legend>Layer repository information</legend>
+                   <fieldset class="air">
+                      <legend>Layer repository information</legend>
+                      <div class="alert alert-error" id="import-error" style="display:none">
+                        <button type="button" class="close" data-dismiss="alert">&times;</button>
+                        <h3></h3>
+                        <span></span>
+                        <ul></ul>
+                      </div>
+
+                      <div class="control-group" id="layer-name-ctrl">
+                        <label class="control-label" for="layer-name">
+                            Layer name
+                            <span class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes" />
+                        </label>
+                        <div class="controls">
+                          <input id="layer-name" type="text" required autofocus>
+                          <span class="help-inline" style="display: none;" id="invalid-layer-name-hint">A valid layer name can only include letters, numbers and dashes</span>
+                          <span class="help-inline" style="display: none;" id="duplicated-layer-name-hint"></span>
+                        </div>
+
+                      </div>
+
                         <label>
                             Git repository URL
-                            <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories."></i>
+                            <span class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories." />
                         </label>
-                        <input id="repo" type="text" class="input-xxlarge" required>
-                        <label class="project-form">
+
+                        <input type="text" id="layer-git-repo-url" class="input-xxlarge" required>
+                        <label class="project-form" for="layer-subdir">
                             Repository subdirectory
                             <span class="muted">(optional)</span>
-                            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
-                        </label>
-                        <input type="text"  id="subdir">
-                        <label class="project-form">Branch, tag or commit</label>
-                        <input type="text" class="span4" id="layer-version" required>
-                        <label class="project-form">
-                            Layer name
-                            <i class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes"></i>
+                            <span class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)" />
                         </label>
-                        <input id="layer-name" type="text" required>
+                        <input type="text"  id="layer-subdir">
+
+                          <div class="control-group" id="layer-revision-ctrl">
+                            <label class="control-label" for="layer-git-ref">Revision
+                              <span class="icon-question-sign get-help" title="You can provide a Git branch, a tag or a commit SHA as the revision"></span>
+                            </label>
+                            <div class="controls">
+                              <input type="text" class="span4" id="layer-git-ref" required>
+                                <span class="help-inline" style="diaply:none;" id="invalid-layer-revision-hint"></span>
+                            </div>
+                          </div>
+
+                          <label class="project-form" for="layer-description">Layer description
+                            <span class="muted">(optional)</span>
+                            <span class="icon-question-sign get-help" title="Short description for for the layer" />
+                          </label>
+                          <input id="layer-description" type="text" class="input-xxlarge" />
+
                     </fieldset>
                     <fieldset class="air">
                         <legend>
                             Layer dependencies
                             <span class="muted">(optional)</span>
-                            <i class="icon-question-sign get-help heading-help" title="Other layers this layer depends upon"></i>
+                            <span class="icon-question-sign get-help heading-help" title="Other layers this layer depends upon" />
                         </legend>
-                        <ul class="unstyled configuration-list">
-                            <li>
-                                <a href="" class="layer-info" title="OpenEmbedded | daisy">openembedded-core (meta)</a>
-                                <i class="icon-trash"></i>
-                            </li>
+                        <ul class="unstyled configuration-list" id="layer-deps-list">
                         </ul>
                         <div class="input-append">
-                            <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off"
-                            data-provide="typeahead"  data-source='
-                []
-                ' placeholder="Type a layer name" id="layer-dependency" class="input-xlarge">
-                            <a class="btn" type="button" id="add-layer-dependency" disabled>
+                            <input type="text" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" placeholder="Type a layer name" id="layer-dependency" class="input-xlarge">
+                            <a class="btn" type="button" id="add-layer-dependency-btn" disabled>
                                 Add layer
                             </a>
                         </div>
                         <span class="help-inline">You can only add layers Toaster knows about</span>
                     </fieldset>
-                    <div class="form-actions">
-                        <a href="#dependencies-message" class="btn btn-primary btn-large" data-toggle="modal" data-target="#dependencies-message" disabled>Import and add to project</a>
-                        <a href="layer-details-just-imported.html" class="btn btn-large" disabled>Just import for the moment</a>
-                        <span class="help-inline" style="vertical-align: middle;">To import a layer, you need to enter a repository URL, a branch, tag or commit and a layer name</span>
+                    <div class="form-actions" id="form-actions">
+                      <button class="btn btn-primary btn-large" data-toggle="modal" id="import-and-add-btn" data-target="#dependencies-message" disabled>Import and add to project</button>
+                        <span class="help-inline" id="import-and-add-hint" style="vertical-align: middle;">To import a layer, you need to enter a repository URL, a branch, tag or commit and a layer name</span>
                     </div>
-                </form>
+                  </form>
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/layers_dep_modal.html b/lib/toaster/toastergui/templates/layers_dep_modal.html
new file mode 100644
index 0000000..821bbda
--- /dev/null
+++ b/lib/toaster/toastergui/templates/layers_dep_modal.html
@@ -0,0 +1,68 @@
+<!-- 'Layer dependencies modal' -->
+    <div id="dependencies_modal" class="modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
+        <form id="dependencies_modal_form">
+        <div class="modal-header">
+            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+            <h3><span class="layer-name"></span> dependencies</h3>
+        </div>
+        <div class="modal-body">
+            <p><strong class="layer-name"></strong> depends on some layers that are not added to your project. Select the ones you want to add:</p>
+            <ul class="unstyled" id="dependencies_list">
+            </ul>
+        </div>
+        <div class="modal-footer">
+            <button class="btn btn-primary" type="submit">Add layers</button>
+            <button class="btn" type="reset" data-dismiss="modal">Cancel</button>
+        </div>
+        </form>
+    </div>
+
+<script>
+function show_layer_deps_modal(projectId, layer, dependencies, successAdd) {
+    // update layer name
+    $('.layer-name').text(layer.name);
+    var deplistHtml = "";
+    for (var i = 0; i < dependencies.length; i++) {
+      deplistHtml += "<li><label class=\"checkbox\"><input name=\"dependencies\" value=\"";
+        deplistHtml += dependencies[i].id;
+        deplistHtml +="\" type=\"checkbox\" checked=\"checked\"/>";
+        deplistHtml += dependencies[i].name;
+        deplistHtml += "</label></li>";
+    }
+    $('#dependencies_list').html(deplistHtml);
+
+    var selected = [layer.id];
+    var layer_link_list = "<a href='"+layer.url+"'>"+layer.name+"</a>";
+
+    $("#dependencies_modal_form").submit(function (e) {
+        e.preventDefault();
+        $("input[name='dependencies']:checked").map(function () { selected.push(parseInt($(this).val()))});
+        if (selected.length > 1) {
+            tooltipUpdateText = "" + selected.length + " layers added";
+        } else {
+            tooltipUpdateText = "1 layer added";
+        }
+
+        for (var i = 0; i < selected.length; i++) {
+            for (var j = 0; j < dependencies.length; j++) {
+                if (dependencies[j].id == selected[i]) {
+                    layer_link_list+= ", <a href='"+dependencies[j].layerdetailurl+"'>"+dependencies[j].name+"</a>"
+                    break;
+                }
+            }
+        }
+
+        $('#dependencies_modal').modal('hide');
+
+        var editProjectUrl  = "{% url 'xhr_projectedit' project.id %}";
+        libtoaster.editProject(editProjectUrl, projectId, { 'layerAdd': selected.join(",") }, function () {
+          if (successAdd) {
+            successAdd(selected);
+          }
+        }, function () {
+          console.log ("Adding layers to project failed");
+        });
+    });
+    $('#dependencies_modal').modal('show');
+}
+</script>
diff --git a/lib/toaster/toastergui/urls.py b/lib/toaster/toastergui/urls.py
index b60f761..6e1b0ab 100644
--- a/lib/toaster/toastergui/urls.py
+++ b/lib/toaster/toastergui/urls.py
@@ -76,6 +76,7 @@ urlpatterns = patterns('toastergui.views',
 
         url(r'^layers/$', 'layers', name='layers'),
         url(r'^layer/(?P<layerid>\d+)/$', 'layerdetails', name='layerdetails'),
+        url(r'^layer/$', 'layerdetails', name='layerdetails'),
         url(r'^targets/$', 'targets', name='targets'),
         url(r'^machines/$', 'machines', name='machines'),
 
@@ -92,6 +93,7 @@ urlpatterns = patterns('toastergui.views',
         url(r'^xhr_projectedit/(?P<pid>\d+)/$', 'xhr_projectedit', name='xhr_projectedit'),
 
         url(r'^xhr_datatypeahead/$', 'xhr_datatypeahead', name='xhr_datatypeahead'),
+        url(r'^xhr_importlayer/$', 'xhr_importlayer', name='xhr_importlayer'),
 
 
         # default redirection
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 434e118..ec055d3 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -30,6 +30,7 @@ from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File
 from orm.models import Target_Installed_Package, Target_File, Target_Image_File, BuildArtifact
 from django.views.decorators.cache import cache_control
 from django.core.urlresolvers import reverse
+from django.core.exceptions import MultipleObjectsReturned
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 from django.http import HttpResponseBadRequest, HttpResponseNotFound
 from django.utils import timezone
@@ -2016,8 +2017,9 @@ if toastermain.settings.MANAGED:
                         "name" : x.layercommit.layer.name,
                         "giturl": x.layercommit.layer.vcs_url,
                         "url": x.layercommit.layer.layer_index_url,
-                        "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)),
-                        "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}},
+                        "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)),
+                # This branch name is actually the release
+                        "branch" : { "name" : x.layercommit.commit, "layersource" : x.layercommit.up_branch.layer_source.name}},
                     prj.projectlayer_set.all().order_by("id")),
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
             "freqtargets": freqtargets,
@@ -2164,7 +2166,7 @@ if toastermain.settings.MANAGED:
 
 
             def _lv_to_dict(x):
-                return {"id": x.pk, "name": x.layer.name,
+                return {"id": x.pk, "name": x.layer.name, "tooltip": x.layer.vcs_url+" | "+x.commit,
                         "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.up_branch.name+")"),
                         "giturl": x.layer.vcs_url, "layerdetailurl" : reverse('layerdetails', args=(x.pk,))}
 
@@ -2174,8 +2176,9 @@ if toastermain.settings.MANAGED:
                 # all layers for the current project
                 queryset_all = prj.compatible_layerversions().filter(layer__name__icontains=request.GET.get('value',''))
 
-                # but not layers with equivalent layers already in project
-                queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])[:8]
+                # but not layers with equivalent layers already in project               
+                if not request.GET.has_key('include_added'):
+                    queryset_all = queryset_all.exclude(pk__in = [x.id for x in prj.projectlayer_equivalent_set()])[:8]
 
                 # and show only the selected layers for this project
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
@@ -2243,6 +2246,100 @@ if toastermain.settings.MANAGED:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
 
+    def xhr_importlayer(request):
+        if (not request.POST.has_key('vcs_url') or
+            not request.POST.has_key('name') or
+            not request.POST.has_key('git_ref') or
+            not request.POST.has_key('project_id')):
+          return HttpResponse(jsonfilter({"error": "Missing parameters; requires vcs_url, name, git_ref and project_id"}), content_type = "application/json")
+
+        # Rudimentary check for any possible html tags
+        if "<" in request.POST:
+          return HttpResponse(jsonfilter({"error": "Invalid character <"}), content_type = "application/json")
+
+        prj = Project.objects.get(pk=request.POST['project_id'])
+
+        # Strip trailing/leading whitespace from all values
+        # put into a new dict because POST one is immutable
+        post_data = dict()
+        for key,val in request.POST.iteritems():
+          post_data[key] = val.strip()
+
+
+        # We need to know what release the current project is so that we
+        # can set the imported layer's up_branch_id
+        prj_branch_name = Release.objects.get(pk=prj.release_id).branch_name
+        up_branch, branch_created = Branch.objects.get_or_create(name=prj_branch_name, layer_source_id=LayerSource.TYPE_IMPORTED)
+
+        layer_source = LayerSource.objects.get(sourcetype=LayerSource.TYPE_IMPORTED)
+        try:
+            layer, layer_created = Layer.objects.get_or_create(name=post_data['name'])
+        except MultipleObjectsReturned:
+            return HttpResponse(jsonfilter({"error": "hint-layer-exists"}), content_type = "application/json")
+
+        if layer:
+            if layer_created:
+                layer.layer_source = layer_source
+                layer.vcs_url = post_data['vcs_url']
+                if post_data.has_key('summary'):
+                    layer.summary = layer.description = post_data['summary']
+
+                layer.up_date = timezone.now()
+                layer.save()
+            else:
+                # We have an existing layer by this name, let's see if the git
+                # url is the same, if it is then we can just create a new layer
+                # version for this layer. Otherwise we need to bail out.
+                if layer.vcs_url != post_data['vcs_url']:
+                    return HttpResponse(jsonfilter({"error": "hint-layer-exists-with-different-url" , "current_url" : layer.vcs_url, "current_id": layer.id }), content_type = "application/json")
+
+
+            layer_version, version_created = Layer_Version.objects.get_or_create(layer_source=layer_source, layer=layer, project=prj, up_branch_id=up_branch.id,branch=post_data['git_ref'],  commit=post_data['git_ref'], dirpath=post_data['dir_path'])
+
+            if layer_version:
+                if not version_created:
+                    return HttpResponse(jsonfilter({"error": "hint-layer-version-exists", "existing_layer_version": layer_version.id }), content_type = "application/json")
+
+                layer_version.up_date = timezone.now()
+                layer_version.save()
+
+                # Add the dependencies specified for this new layer
+                if (post_data.has_key("layer_deps") and
+                    version_created and
+                    len(post_data["layer_deps"]) > 0):
+                    for layer_dep_id in post_data["layer_deps"].split(","):
+
+                        layer_dep_obj = Layer_Version.objects.get(pk=layer_dep_id)
+                        LayerVersionDependency.objects.get_or_create(layer_version=layer_version, depends_on=layer_dep_obj)
+                        # Now add them to the project, we could get an execption
+                        # if the project now contains the exact
+                        # dependency already (like modified on another page)
+                        try:
+                            ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj)
+                        except:
+                            pass
+
+
+                # If an old layer version exists in our project then remove it
+                for prj_layers in ProjectLayer.objects.filter(project=prj):
+                    dup_layer_v = Layer_Version.objects.filter(id=prj_layers.layercommit_id, layer_id=layer.id)
+                    if len(dup_layer_v) >0 :
+                        prj_layers.delete()
+
+                # finally add the imported layer (version id) to the project
+                ProjectLayer.objects.create(layercommit=layer_version, project=prj,optional=1)
+
+            else:
+                # We didn't create a layer version so back out now and clean up.
+                if layer_created:
+                    layer.delete()
+
+                return HttpResponse(jsonfilter({"error": "Uncaught error: Could not create layer version"}), content_type = "application/json")
+
+
+        return HttpResponse(jsonfilter({"error": "ok"}), content_type = "application/json")
+
+
 
     def importlayer(request):
         template = "importlayer.html"
-- 
1.9.1


