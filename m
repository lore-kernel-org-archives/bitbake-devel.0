Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 8336172341
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:22 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id y19so3923614wgg.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=d2w1qJGJIU12h/x161GZv0+jZpBOxzg250iBZN/yyus=;
	b=Wc8eLJVfM9NObLlzKfn6L21pFKDpSWFE5D8ToCtUVtO9gnrSlYxAL8FSfaaaOubKyX
	RuoGM0F3omWnqDWtaJQsiIJr0u7ZQI+KamUz5JQWc39k0UGeGvOUfh29Mn6iN4itaKjZ
	vgc28z3MVYqBu64aucVrfhu8S7lQNSvBYoLtCRPr4/JnWe6y7hzgnfDAtKZYTHwledsZ
	ffCp/zhpT8GHTV84RtoPZLzb5WAvsub4T+O5S4LvxQ7il37zomXVRww5CeZXxEzWOhV0
	uYL9e00cnGSIWMNysRQBQzZn02ZsoO+FjBaS2NYWdo6D4CmTGjhedpwb7HXf5x7asx0t
	J0mw==
X-Gm-Message-State: ALoCoQng10HRhtnulX7iSSAnH0Kn4+7AaA3xcDI4j57IFXRxevWjo64JHo8G0/eX3Lq6nkgkw78p
X-Received: by 10.194.174.72 with SMTP id bq8mr7360146wjc.120.1418224343235;
	Wed, 10 Dec 2014 07:12:23 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	t10sm18283801wix.15.2014.12.10.07.12.20 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:20 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 733BD564715; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:16 +0000
Message-Id: <b6ac1b85f5fb1acdc1c73b873652520bc9bfc168.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Subject: [PATCH 11/11] toaster: Add import layer feature.
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:24 -0000

From: Michael Wood <michael.g.wood@intel.com>

This feature allows users to import layers from git into their current
project and associate it with the release of the current project and the
dependencies for the newly imported layer with existing layers.
It will also resolve the child dependencies of the dependencies added.

[YOCTO #6595]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js    | 190 +++++++++++++++++++++
 lib/toaster/toastergui/static/js/projectapp.js     |   6 +
 lib/toaster/toastergui/templates/importlayer.html  |  80 ++++++---
 .../toastergui/templates/layers_dep_modal.html     |  68 ++++++++
 lib/toaster/toastergui/urls.py                     |   2 +
 lib/toaster/toastergui/views.py                    |  76 +++++++++
 6 files changed, 395 insertions(+), 27 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/importlayer.js
 create mode 100644 lib/toaster/toastergui/templates/layers_dep_modal.html

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
new file mode 100644
index 0000000..e3a0096
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -0,0 +1,190 @@
+"use strict"
+
+function importLayerPageInit (ctx) {
+
+  var layerDepBtn = $("#add-layer-dependency-btn");
+  var importAndAddBtn = $("#import-and-add-btn");
+  var layerNameInput = $("#layer-name");
+  var vcsURLInput = $("#layer-git-repo-url");
+  var gitRefInput = $("#layer-git-ref");
+  var summaryInput = $("#layer-summary");
+  var layerDepInput = $("#layer-dependency");
+
+  var layerDeps = {};
+  var currentLayerDepSelection;
+  var validLayerName = /^(\w|-)+$/;
+
+  libtoaster.makeTypeahead(layerDepInput, ctx.xhrDataTypeaheadUrl, { type : "layers", project_id: ctx.projectId }, function(item){
+    currentLayerDepSelection = item;
+
+    layerDepBtn.removeAttr("disabled");
+  });
+
+  layerDepBtn.click(function() {
+    if (currentLayerDepSelection == undefined)
+      return;
+
+    layerDeps[currentLayerDepSelection.id] = currentLayerDepSelection;
+
+    /* Make a list item for the new layer dependency */
+    var newLayerDep = $("<li><a></a><i class=\"icon-trash\"></i></li>");
+
+    newLayerDep.data('layer-id', currentLayerDepSelection.id);
+
+    var link = newLayerDep.children("a");
+    link.attr("href", ctx.layerDetailsUrl+String(currentLayerDepSelection.id));
+    link.text(currentLayerDepSelection.name);
+    link.tooltip({title: currentLayerDepSelection.detail});
+
+    var trashItem = newLayerDep.children("i");
+    trashItem.click(function () {
+      var toRemove = $(this).parent().data('layer-id');
+      delete layerDeps[toRemove];
+      /* also remove from db / system */
+      $(this).parent().remove();
+    });
+
+    $("#layer-deps-list").append(newLayerDep);
+
+    libtoaster.getLayerDepsForProject(ctx.xhrDataTypeaheadUrl, ctx.projectId, currentLayerDepSelection.id, function (data){
+        /* These are the layers needed to be added */
+        if (data.list.length > 0) {
+          currentLayerDepSelection.url = ctx.layerDetailsUrl+currentLayerDepSelection.id;
+          show_layer_deps_modal(ctx.projectId, currentLayerDepSelection, data.list, null);
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
+    check_layer_name_unique(layerNameInput.val(),function (isUnique){
+      if (!isUnique){
+        console.log("Error layer name not unique");
+        $("#duplicate-layer-name-hint").show();
+        importAndAddBtn.attr("disabled", "disabled");
+        return;
+      }
+
+      var layerDepsCsv = "";
+
+      /* Iter through the properties and convert to a csv */
+      for (var key in layerDeps){
+        layerDepsCsv += ','+key.toString();
+      }
+
+      /* Remove leading comma */
+      layerDepsCsv = layerDepsCsv.substr(1);
+
+      var layerData = {
+        name: layerNameInput.val(),
+        vcs_url: vcsURLInput.val(),
+        git_ref: gitRefInput.val(),
+        summary: summaryInput.val(),
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
+              console.log(data.error);
+            } else {
+              /* Success layer now added to the project */
+              console.log("Layer added");
+              window.location.replace(ctx.projectPageUrl+'#/layerimported='+layerData.name);
+            }
+          },
+          error: function (data) {
+            console.log("Call failed");
+            console.log(data);
+          }
+      });
+    });
+  });
+
+  function check_layer_name_unique(layerName, checkDone){
+    var isUnique = false;
+
+    $.getJSON(ctx.xhrDataTypeaheadUrl, { type: "layers", value: layerName},
+      function(data){
+        console.log(data);
+
+        if (data.error != "ok") {
+          console.log(data.error);
+          checkDone(isUnique);
+          return;
+        }
+        if (data.list.length > 0){
+          /* check through the fuzzy matches for an exact match */
+          for (var layer in data.list){
+            if (data.list[layer].name == layerName){
+              isUnique = false;
+              break;
+            }
+          }
+        } else {
+          isUnique = true;
+        }
+        checkDone(isUnique);
+    });
+  }
+
+  function check_form(){
+    var valid = false;
+    var inputs = $("input:required");
+
+    for (var i=0; i<inputs.length; i++){
+      if (!(valid = inputs[i].value)){
+        importAndAddBtn.attr("disabled", "disabled");
+        break;
+      }
+    }
+
+    if (valid)
+      importAndAddBtn.removeAttr("disabled");
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
+      $("#invalid-layer-name-hint").show();
+      importAndAddBtn.attr("disabled", "disabled");
+      return;
+    }
+
+    $("#duplicate-layer-name-hint").hide();
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
index e9b07c7..99a61c1 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -571,6 +571,12 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
                     "\">select targets</a> you want to build.", "alert-success");
         });
 
+        _cmdExecuteWithParam("/layerimported", function (layer) {
+            $scope.displayAlert($scope.zone1alerts,
+                    "You have imported <strong>" + layer +
+                    "</strong> and added it to your project.", "alert-success");
+        });
+
         _cmdExecuteWithParam("/targetbuild=", function (targets) {
             var oldTargetName = $scope.targetName;
             $scope.targetName = targets.split(",").join(" ");
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index 7e48eac..ac77fb6 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -1,68 +1,94 @@
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
+                      importLayerPageInit(ctx);
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
                         <label>
                             Git repository URL
-                            <i class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories."></i>
+                            <span class="icon-question-sign get-help" title="Fetch/clone URL of the repository. Currently, Toaster only supports Git repositories." />
                         </label>
-                        <input id="repo" type="text" class="input-xxlarge" required>
-                        <label class="project-form">
+
+                        <input type="text" id="layer-git-repo-url" class="input-xxlarge" required autofocus>
+                        <label class="project-form" for="layer-subdir">
                             Repository subdirectory
                             <span class="muted">(optional)</span>
-                            <i class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)"></i>
+                            <span class="icon-question-sign get-help" title="Subdirectory within the repository where the layer is located, if not in the root (usually only used if the repository contains more than one layer)" />
                         </label>
-                        <input type="text"  id="subdir">
-                        <label class="project-form">Branch, tag or commit</label>
-                        <input type="text" class="span4" id="layer-version" required>
-                        <label class="project-form">
+                        <input type="text"  id="layer-subdir">
+
+                        <label class="project-form" for="layer-git-ref">Branch, tag or commit</label>
+                        <input type="text" class="span4" id="layer-git-ref" required>
+
+                        <label class="project-form" for="layer-name">
                             Layer name
-                            <i class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes"></i>
+                            <span class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes" />
                         </label>
+
                         <input id="layer-name" type="text" required>
+                          <p class="help-inline" style="color: #b94a48; display: none;" id="invalid-layer-name-hint">A valid layer name can only include letters, numbers and dashes</p>
+                          <p class="help-inline" style="color: #b94a48; display: none;" id="duplicate-layer-name-hint">This layer name already exists. Your layer name must be unique.</p>
+
+
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
+                    <div class="form-actions" id="form-actions">
+                      <button class="btn btn-primary btn-large" data-toggle="modal" id="import-and-add-btn" data-target="#dependencies-message" disabled>Import and add to project</button>
                         <span class="help-inline" style="vertical-align: middle;">To import a layer, you need to enter a repository URL, a branch, tag or commit and a layer name</span>
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
index 434e118..9877e27 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2243,6 +2243,82 @@ if toastermain.settings.MANAGED:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
 
+    def xhr_importlayer(request):
+        if (not request.POST.has_key('vcs_url') or
+            not request.POST.has_key('name') or
+            not request.POST.has_key('git_ref') or
+            not request.POST.has_key('project_id')):
+          return HttpResponse(jsonfilter({"error": "missing parameters requires vcs_url, name, git_ref and project_id"}), content_type = "application/json")
+
+        # Rudimentary check for any possible html tags
+        if "<" in request.POST:
+          return HttpResponse(jsonfilter({"error": "invalid character <"}), content_type = "application/json")
+
+        prj = Project.objects.get(pk=request.POST['project_id'])
+        # Strip trailing/leading whitespace from all values
+        # put into a new dict because POST one is immutable
+        post_data = dict()
+        for key,val in request.POST.iteritems():
+          post_data[key] = val.strip()
+
+        layer_source = LayerSource.objects.get(sourcetype=LayerSource.TYPE_IMPORTED)
+        layer, layer_created = Layer.objects.get_or_create(layer_source=layer_source, name=post_data['name'])
+
+        if layer_created is False and layer:
+          return HttpResponse(jsonfilter({"error": "layer exists"}), content_type = "application/json")
+
+        if layer_created and layer:
+          layer.vcs_url = post_data['vcs_url']
+          if post_data.has_key('summary'):
+            layer.summary = layers.description = post_data['summary']
+
+          layer.up_date = timezone.now()
+
+          layer.save()
+
+          layer_version, version_created = Layer_Version.objects.get_or_create(layer_source=layer_source, layer=layer, project=prj)
+          layer_version.branch = layer_version.commit = post_data['git_ref']
+
+          if version_created:
+            if post_data.has_key('dir_path'):
+              layer_version.dirpath = post_data['dir_path']
+
+            # We need to know what release the current project is so that we
+            # can set the imported layer's up_branch_id
+            branch_name = Release.objects.get(pk=prj.release_id).branch_name
+            branch, branch_created = Branch.objects.get_or_create(name=branch_name, layer_source_id=LayerSource.TYPE_IMPORTED)
+            layer_version.up_branch_id = branch.id
+
+            layer_version.up_date = layer.up_date
+
+            layer_version.save()
+
+            # Add the dependencies specified for this new layer
+            if (post_data.has_key("layer_deps") and
+                version_created and
+                len(post_data["layer_deps"]) > 0):
+              for layer_dep_id in post_data["layer_deps"].split(","):
+                layer_dep_obj = Layer_Version.objects.get(pk=layer_dep_id)
+                LayerVersionDependency.objects.get_or_create(layer_version=layer_version, depends_on=layer_dep_obj)
+                # Now add them to the project
+                # Their own dependencies were satisfied at the time of adding
+                # them to this list. The project could have them already hence
+                # get_or_create.
+                ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj, optional=1)
+
+
+
+            # finally add the imported layer (version id) to the project
+            ProjectLayer.objects.create(layercommit=layer_version, project=prj,optional=1)
+
+          else:
+            # We didn't create a layer version so back out now and clean up.
+            layer.delete()
+            return HttpResponse(jsonfilter({"error": "Could not create layer version"}), content_type = "application/json")
+
+
+          return HttpResponse(jsonfilter({"error": "ok"}), content_type = "application/json")
+
 
     def importlayer(request):
         template = "importlayer.html"
-- 
1.9.1


