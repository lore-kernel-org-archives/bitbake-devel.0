Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id EB0B272521
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 11:45:27 +0000 (UTC)
Received: by mail-wg0-f54.google.com with SMTP id l2so8929893wgh.27
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Dec 2014 03:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=N4TPmjyVbRx/Zyy+32LSvVV8ii1W1TUmRmTfeYUYL+o=;
	b=jZgr5g+COsufnYr3IKkDLaxRZ+0KqvhtDCyWowfExNTxq2j0E0DtoG9mYS8LiGjY4+
	KQsuKsotMzg+F3Bk92xH9jx04ixXsroiHOWo2ieac2p4OdVoxOl4hYgQEQl/StWd9iO1
	+mMcOB0ubRaANoZwLkjYlag2nDQhJ+sV69gRA6r6TeJFuepYegQTXuOObnaOr1Sj0GQ4
	hdnXn+ySxgb0SMy8PPLihydlCpXL6JLdbErl/8dRKYsSuNUFcw3HzSF5FF+uxz5pbRZ/
	ThWtAesdYmURzESLvt+itrVLzKGFq27tuB6+v36Wgil1cvvdWb8882+kjn1E3ZlFzYxf
	d5yQ==
X-Gm-Message-State: ALoCoQlO+wk4u3YWuw0HEMwV8P8uUeDYM96flfDG9olTYboUhHAdP4PlmzlWBd2DjHRMsEXG3BOA
X-Received: by 10.194.189.240 with SMTP id gl16mr25647887wjc.119.1418384728395;
	Fri, 12 Dec 2014 03:45:28 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id pl1sm1736499wic.16.2014.12.12.03.45.22
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Dec 2014 03:45:25 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 48B81566252; Fri, 12 Dec 2014 11:45:19 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Dec 2014 11:45:12 +0000
Message-Id: <23ca89dc3e0f0ea387649f1e9e8d7d50846048d6.1418384609.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
References: <bbe24d912869312d561be199b2c029b0c898e049.1418384609.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418384609.git.alexandru.damian@intel.com>
References: <cover.1418384609.git.alexandru.damian@intel.com>
Subject: [PATCH 13/18] toaster: Importlayer add notify exactly which layers changed
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
X-List-Received-Date: Fri, 12 Dec 2014 11:45:28 -0000

From: Michael Wood <michael.g.wood@intel.com>

This changes when the dependencies are added to the project so that we
can know which ones were successfully added by waiting for the server to
respond with a list. This is more reliable because we may have specified
dependencies which are already in the project.

To pass this information to the project page a temporary cookie is used
with the values for the notification.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js    | 19 +++++++--
 lib/toaster/toastergui/static/js/projectapp.js     | 27 ++++++++++--
 .../toastergui/templates/layers_dep_modal.html     | 48 ++++++++++++++++------
 lib/toaster/toastergui/views.py                    | 11 +++--
 4 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index e2bc1ab..15830dd 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -78,8 +78,14 @@ function importLayerPageInit (ctx) {
   });
 
   importAndAddBtn.click(function(){
+    /* This is a list of the names from layerDeps for the layer deps
+     * modal dialog body
+     */
+    var depNames = [];
+
     /* arrray of all layer dep ids includes parent and child deps */
     var allDeps = [];
+
     /* temporary object to use to do a reduce on the dependencies for each
      * layer dependency added
      */
@@ -96,6 +102,7 @@ function importLayerPageInit (ctx) {
           depDeps[layer.id] = layer;
         }
       }
+      depNames.push(layerDeps[key].name);
       allDeps.push(layerDeps[key].id);
     }
 
@@ -106,10 +113,14 @@ function importLayerPageInit (ctx) {
 
     if (depDepsArray.length > 0) {
       var layer = { name: layerNameInput.val(), url: "#", id: -1 };
-      show_layer_deps_modal(ctx.projectId, layer, depDepsArray, function(selected){
+      var title = "Layer";
+      var body = "<strong>"+layer.name+"</strong>'s dependencies ("+
+        depNames.join(", ")+"</span>) require some layers that are not added to your project. Select the ones you want to add:</p>";
+
+      show_layer_deps_modal(ctx.projectId, layer, depDepsArray, title, body, false, function(selected){
         /* Add the accepted dependencies to the allDeps array */
         if (selected.length > 0){
-          allDeps.concat (selected);
+          allDeps = allDeps.concat (selected);
         }
         import_and_add ();
       });
@@ -141,8 +152,10 @@ function importLayerPageInit (ctx) {
               show_error_message(data, layerData);
               console.log(data.error);
             } else {
+              layerData.layersAdded = data.layers_added;
               /* Success layer import now go to the project page */
-              window.location.replace(ctx.projectPageUrl+'#/layerimported='+layerData.name);
+              $.cookie('layer-imported-alert', JSON.stringify(layerData), { path: '/'});
+              window.location.replace(ctx.projectPageUrl+'#/layerimported');
             }
           },
           error: function (data) {
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 8e3499a..94c24f4 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -128,7 +128,7 @@ projectApp.filter('timediff', function() {
 
 
 // main controller for the project page
-projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $location, $cookies, $q, $sce, $anchorScroll, $animate, $sanitize) {
+projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $location, $cookies, $cookieStore, $q, $sce, $anchorScroll, $animate, $sanitize) {
 
     $scope.getSuggestions = function(type, currentValue) {
         var deffered = $q.defer();
@@ -572,9 +572,28 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
         });
 
         _cmdExecuteWithParam("/layerimported", function (layer) {
-            $scope.displayAlert($scope.zone2alerts,
-                    "You have imported <strong>" + layer +
-                    "</strong> and added it to your project.", "alert-success");
+          var imported = $cookieStore.get("layer-imported-alert");
+          var text;
+
+          if (!imported)
+            return;
+
+          if (imported.layersAdded.length == 0) {
+            text = "You have imported <strong>"+imported.name+
+              "</strong> and added it to your project.";
+          } else {
+            text = "You have imported <strong>"+imported.name+
+              "</strong> and added <strong>"+imported.layersAdded.length+
+              "</strong> layers to your project. <strong>"+
+              imported.layersAdded.join(", ")+"</strong>";
+          }
+
+            $scope.displayAlert($scope.zone2alerts, text, "alert-info");
+
+            // This doesn't work
+            $cookieStore.remove("layer-imported-alert");
+            //use jquery plugin instead
+            $.removeCookie("layer-imported-alert", { path: "/"});
         });
 
         _cmdExecuteWithParam("/targetbuild=", function (targets) {
diff --git a/lib/toaster/toastergui/templates/layers_dep_modal.html b/lib/toaster/toastergui/templates/layers_dep_modal.html
index 821bbda..b03fd0b 100644
--- a/lib/toaster/toastergui/templates/layers_dep_modal.html
+++ b/lib/toaster/toastergui/templates/layers_dep_modal.html
@@ -3,10 +3,10 @@
         <form id="dependencies_modal_form">
         <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-            <h3><span class="layer-name"></span> dependencies</h3>
+            <h3><span id="title"></span> dependencies</h3>
         </div>
         <div class="modal-body">
-            <p><strong class="layer-name"></strong> depends on some layers that are not added to your project. Select the ones you want to add:</p>
+            <p id="body-text"> <strong id="layer-name"></strong> depends on some layers that are not added to your project. Select the ones you want to add:</p>
             <ul class="unstyled" id="dependencies_list">
             </ul>
         </div>
@@ -18,9 +18,20 @@
     </div>
 
 <script>
-function show_layer_deps_modal(projectId, layer, dependencies, successAdd) {
+function show_layer_deps_modal(projectId, layer, dependencies, title, body, addToProject, successAdd) {
     // update layer name
-    $('.layer-name').text(layer.name);
+    if (title) {
+      $('#dependencies_modal #title').text(title);
+    } else {
+      $('#dependencies_modal #title').text(layer.name);
+    }
+
+    if (body) {
+      $("#dependencies_modal #body-text").html(body);
+    } else {
+      $("#dependencies_modal #layer-name").text(layer.name);
+    }
+
     var deplistHtml = "";
     for (var i = 0; i < dependencies.length; i++) {
       deplistHtml += "<li><label class=\"checkbox\"><input name=\"dependencies\" value=\"";
@@ -31,7 +42,13 @@ function show_layer_deps_modal(projectId, layer, dependencies, successAdd) {
     }
     $('#dependencies_list').html(deplistHtml);
 
-    var selected = [layer.id];
+    var selected = [];
+    /* -1 is a special dummy Id which we use when the layer isn't yet in the
+     * system, normally we would add the current layer to the selection.
+     */
+    if (layer.id != -1)
+      selected.push(layer.id);
+
     var layer_link_list = "<a href='"+layer.url+"'>"+layer.name+"</a>";
 
     $("#dependencies_modal_form").submit(function (e) {
@@ -54,15 +71,20 @@ function show_layer_deps_modal(projectId, layer, dependencies, successAdd) {
 
         $('#dependencies_modal').modal('hide');
 
-        var editProjectUrl  = "{% url 'xhr_projectedit' project.id %}";
-        libtoaster.editProject(editProjectUrl, projectId, { 'layerAdd': selected.join(",") }, function () {
-          if (successAdd) {
-            successAdd(selected);
-          }
-        }, function () {
-          console.log ("Adding layers to project failed");
-        });
+        if (addToProject) {
+          var editProjectUrl  = "{% url 'xhr_projectedit' project.id %}";
+          libtoaster.editProject(editProjectUrl, projectId, { 'layerAdd': selected.join(",") }, function () {
+            if (successAdd) {
+              successAdd(selected);
+            }
+          }, function () {
+            console.log ("Adding layers to project failed");
+          });
+        } else {
+          successAdd(selected);
+        }
     });
+
     $('#dependencies_modal').modal('show');
 }
 </script>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index ec055d3..dd43080 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2253,6 +2253,8 @@ if toastermain.settings.MANAGED:
             not request.POST.has_key('project_id')):
           return HttpResponse(jsonfilter({"error": "Missing parameters; requires vcs_url, name, git_ref and project_id"}), content_type = "application/json")
 
+        layers_added = [];
+
         # Rudimentary check for any possible html tags
         if "<" in request.POST:
           return HttpResponse(jsonfilter({"error": "Invalid character <"}), content_type = "application/json")
@@ -2315,9 +2317,12 @@ if toastermain.settings.MANAGED:
                         # if the project now contains the exact
                         # dependency already (like modified on another page)
                         try:
-                            ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj)
+                            prj_layer, prj_layer_created = ProjectLayer.objects.get_or_create(layercommit=layer_dep_obj, project=prj)
                         except:
-                            pass
+                            continue
+
+                        if prj_layer_created:
+                            layers_added.append(Layer.objects.get(id=layer_dep_obj.layer_id).name)
 
 
                 # If an old layer version exists in our project then remove it
@@ -2337,7 +2342,7 @@ if toastermain.settings.MANAGED:
                 return HttpResponse(jsonfilter({"error": "Uncaught error: Could not create layer version"}), content_type = "application/json")
 
 
-        return HttpResponse(jsonfilter({"error": "ok"}), content_type = "application/json")
+        return HttpResponse(jsonfilter({"error": "ok", "layers_added": layers_added}), content_type = "application/json")
 
 
 
-- 
1.9.1


