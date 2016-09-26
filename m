Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id B71B765D00
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:36 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga105.fm.intel.com with ESMTP; 26 Sep 2016 04:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="1056684952"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2016 04:00:33 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id B615E6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:04 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:35 +0300
Message-Id: <5462e0ae5168262e8b58c80a34d11519afea0afc.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 08/10] toaster: importlayer Convert success import to new notification system
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use the simpler libtoaster method of showing a notification about
successful import of a layer.
Also a number of whitespace clean ups.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 59 ++++++++++++++++------
 lib/toaster/toastergui/static/js/projectpage.js | 66 +------------------------
 2 files changed, 47 insertions(+), 78 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 191b30f..570ca33 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -17,7 +17,9 @@ function importLayerPageInit (ctx) {
   var currentLayerDepSelection;
   var validLayerName = /^(\w|-)+$/;
 
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput,
+                           libtoaster.ctx.layersTypeAheadUrl,
+                           { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
   });
 
@@ -95,7 +97,8 @@ function importLayerPageInit (ctx) {
 
     $("#layer-deps-list").append(newLayerDep);
 
-    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerdetailurl, function (data){
+    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerdetailurl,
+                                      function (data){
         /* These are the dependencies of the layer added as a dependency */
         if (data.list.length > 0) {
           currentLayerDepSelection.url = currentLayerDepSelection.layerdetailurl;
@@ -150,7 +153,9 @@ function importLayerPageInit (ctx) {
       var body = "<strong>"+layer.name+"</strong>'s dependencies ("+
         depNames.join(", ")+"</span>) require some layers that are not added to your project. Select the ones you want to add:</p>";
 
-      showLayerDepsModal(layer, depDepsArray, title, body, false, function(layerObsList){
+      showLayerDepsModal(layer,
+                         depDepsArray,
+                         title, body, false, function(layerObsList){
         /* Add the accepted layer dependencies' ids to the allDeps array */
         for (var key in layerObsList){
           allDeps.push(layerObsList[key].id);
@@ -191,9 +196,8 @@ function importLayerPageInit (ctx) {
             if (data.error != "ok") {
               console.log(data.error);
             } else {
-              /* Success layer import now go to the project page */
-              $.cookie('layer-imported-alert', JSON.stringify(data), { path: '/'});
-              window.location.replace(libtoaster.ctx.projectPageUrl+'?notify=layer-imported');
+              createImportedNotification(data);
+              window.location.replace(libtoaster.ctx.projectPageUrl);
             }
           },
           error: function (data) {
@@ -204,6 +208,30 @@ function importLayerPageInit (ctx) {
     }
   });
 
+  /* Layer imported notification */
+  function createImportedNotification(imported){
+    var message = "Layer imported";
+
+    if (imported.deps_added.length === 0) {
+      message = "You have imported <strong><a class=\"alert-link\" href=\""+imported.imported_layer.layerdetailurl+"\">"+imported.imported_layer.name+"</a></strong> and added it to your project.";
+    } else {
+
+      var links = "<a href=\""+imported.imported_layer.layerdetailurl+"\">"+imported.imported_layer.name+"</a>, ";
+
+      imported.deps_added.map (function(item, index){
+        links +='<a href="'+item.layerdetailurl+'">'+item.name+'</a>';
+        /*If we're at the last element we don't want the trailing comma */
+        if (imported.deps_added[index+1] !== undefined)
+          links += ', ';
+      });
+
+      /* Length + 1 here to do deps + the imported layer */
+      message = 'You have imported <strong><a href="'+imported.imported_layer.layerdetailurl+'">'+imported.imported_layer.name+'</a></strong> and added <strong>'+(imported.deps_added.length+1)+'</strong> layers to your project: <strong>'+links+'</strong>';
+    }
+
+    libtoaster.setNotification("layer-imported", message);
+  }
+
   function enable_import_btn(enabled) {
     var importAndAddHint = $("#import-and-add-hint");
 
@@ -230,10 +258,13 @@ function importLayerPageInit (ctx) {
     }
 
     if (valid) {
-      if ($("#local-dir-radio").prop("checked") && localDirPath.val().length > 0) {
+      if ($("#local-dir-radio").prop("checked") &&
+          localDirPath.val().length > 0) {
         enable_import_btn(true);
       }
-      if ($("#git-repo-radio").prop("checked") && vcsURLInput.val().length > 0 && gitRefInput.val().length > 0) {
+
+      if ($("#git-repo-radio").prop("checked") &&
+          vcsURLInput.val().length > 0 && gitRefInput.val().length > 0) {
         enable_import_btn(true);
       }
     }
@@ -266,13 +297,13 @@ function importLayerPageInit (ctx) {
   }
 
   layerNameInput.on('blur', function() {
-      if (!$(this).val()){
-        return;
-      }
-      var name = $(this).val();
+    if (!$(this).val()){
+      return;
+    }
+    var name = $(this).val();
 
-      /* Check if the layer name exists */
-      $.getJSON(libtoaster.ctx.layersTypeAheadUrl,
+    /* Check if the layer name exists */
+    $.getJSON(libtoaster.ctx.layersTypeAheadUrl,
         { include_added: "true" , search: name, format: "json" },
         function(layer) {
           if (layer.results.length > 0) {
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 7f19c0d..4536703 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -50,70 +50,8 @@ function projectPageInit(ctx) {
     $("#delete-project-modal .project-name").text(prjInfo.name);
   });
 
-  (function notificationRequest(){
-
-    if (urlParams.hasOwnProperty('notify')){
-      switch (urlParams.notify){
-        case 'new-project':
-          $("#project-created-notification").show();
-          break;
-        case 'layer-imported':
-          layerImportedNotification();
-          break;
-        case 'layer-deleted':
-          layerDeletedNotification();
-        default:
-          break;
-      }
-    }
-  })();
-
-  /* Layer deleted notification */
-  function layerDeletedNotification(){
-    var layer = $.cookie("layer-deleted");
-
-    if (!layer)
-      return;
-
-    var message = "You have deleted <strong>1</strong> layer from your ";
-    message += "project: <strong>" + layer + "</strong>";
-
-    libtoaster.showChangeNotification(message);
-
-    $.removeCookie("layer-deleted", { path: "/"});
-  }
-
-
-  /* Layer imported notification */
-  function layerImportedNotification(){
-    var imported = $.cookie("layer-imported-alert");
-    var message = "Layer imported";
-
-    if (!imported)
-      return;
-    else
-      imported = JSON.parse(imported);
-
-    if (imported.deps_added.length === 0) {
-      message = "You have imported <strong><a class=\"alert-link\" href=\""+imported.imported_layer.layerdetailurl+"\">"+imported.imported_layer.name+"</a></strong> and added it to your project.";
-    } else {
-
-      var links = "<a href=\""+imported.imported_layer.layerdetailurl+"\">"+imported.imported_layer.name+"</a>, ";
-
-      imported.deps_added.map (function(item, index){
-        links +='<a href="'+item.layerdetailurl+'">'+item.name+'</a>';
-        /*If we're at the last element we don't want the trailing comma */
-        if (imported.deps_added[index+1] !== undefined)
-          links += ', ';
-      });
-
-      /* Length + 1 here to do deps + the imported layer */
-      message = 'You have imported <strong><a href="'+imported.imported_layer.layerdetailurl+'">'+imported.imported_layer.name+'</a></strong> and added <strong>'+(imported.deps_added.length+1)+'</strong> layers to your project: <strong>'+links+'</strong>';
-    }
-
-    libtoaster.showChangeNotification(message);
-
-    $.removeCookie("layer-imported-alert", { path: "/"});
+  if (urlParams.hasOwnProperty('notify') && urlParams.notify === 'new-project'){
+    $("#project-created-notification").show();
   }
 
   /* Add/Rm layer functionality */
-- 
2.6.6


