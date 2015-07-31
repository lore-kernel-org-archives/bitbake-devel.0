Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E048B73D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:43 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 31 Jul 2015 05:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="616731234"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 31 Jul 2015 05:09:44 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id F36766A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:12 +0300
Message-Id: <6c610bc01a5dc665c2ea789d9444d639c951fc93.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 11/22] bitbake: toastergui: Add new project page and navigation
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Wood <michael.g.wood@intel.com>

This brings in the new project page design and improved navigation. As
this also removes the dependency on Angular it also required that the
entry points to the project page such as machine-change notifications
are also updated.

[YOCTO #7329]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js           |  81 ++--
 lib/toaster/toastergui/static/js/importlayer.js    |   4 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |   5 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  15 +-
 lib/toaster/toastergui/static/js/projectpage.js    | 429 ++++++++++++++++++
 lib/toaster/toastergui/templates/base.html         |   7 +
 .../toastergui/templates/baseprojectpage.html      |   2 -
 lib/toaster/toastergui/templates/importlayer.html  |  12 +-
 lib/toaster/toastergui/templates/machine_btn.html  |   2 +-
 lib/toaster/toastergui/templates/project.html      | 498 ++++-----------------
 .../toastergui/templates/projecttopbar.html        |  26 +-
 lib/toaster/toastergui/views.py                    |   5 +-
 12 files changed, 610 insertions(+), 476 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/projectpage.js

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 6fd77ea..0fb1f8b 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -6,13 +6,20 @@ function basePageInit(ctx) {
   var newBuildTargetInput;
   var newBuildTargetBuildBtn;
 
+  /* initially the current project is used unless overridden by the new build
+   * button in top right nav
+   */
   var selectedProject = libtoaster.ctx;
+
   var selectedTarget;
 
   var newBuildProjectInput = $("#new-build-button #project-name-input");
   var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
 
-  $("#config-nav .nav li a").each(function(){
+
+  _checkProjectBuildable();
+
+  $("#project-topbar .nav li a").each(function(){
     if (window.location.pathname === $(this).attr('href'))
       $(this).parent().addClass('active');
     else
@@ -26,7 +33,7 @@ function basePageInit(ctx) {
     });
   }
 
-    /* Hide the button if we're on the project,newproject or importlyaer page
+  /* Hide the button if we're on the project,newproject or importlyaer page
    * or if there are no projects yet defined
    * only show if there isn't already a build-target-input already
    */
@@ -37,8 +44,8 @@ function basePageInit(ctx) {
     newBuildTargetInput = $("#new-build-button .build-target-input");
     newBuildTargetBuildBtn = $("#new-build-button .build-button");
 
-    newBuildButton.show();
     _setupNewBuildButton();
+    newBuildButton.show();
   } else if ($(".build-target-input").length > 0) {
     newBuildTargetInput = $("#project-topbar .build-target-input");
     newBuildTargetBuildBtn = $("#project-topbar .build-button");
@@ -52,9 +59,35 @@ function basePageInit(ctx) {
     $('#project .icon-pencil').hide();
   }
 
+  libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
+        /* successfully selected a target */
+      selectedTarget = item;
+  });
 
-  _checkProjectBuildable();
+  newBuildTargetInput.on('input', function () {
+    if ($(this).val().length === 0) {
+      newBuildTargetBuildBtn.attr("disabled", "disabled");
+    } else {
+      newBuildTargetBuildBtn.removeAttr("disabled");
+    }
+  });
+
+  newBuildTargetBuildBtn.click(function (e) {
+    e.preventDefault();
+
+    if (!newBuildTargetInput.val()) {
+      return;
+    }
 
+    if (!selectedTarget) {
+      selectedTarget = { name: newBuildTargetInput.val() };
+    }
+    /* Fire off the build */
+    libtoaster.startABuild(selectedProject.projectBuildsUrl,
+      selectedProject.projectId, selectedTarget.name, function(){
+      window.location.replace(selectedProject.projectBuildsUrl);
+    }, null);
+  });
 
   function _checkProjectBuildable() {
     if (selectedProject.projectId === undefined) {
@@ -74,21 +107,12 @@ function basePageInit(ctx) {
           /* we can build this project; enable input fields */
           newBuildTargetInput.prop("disabled", false);
           newBuildTargetBuildBtn.prop("disabled", false);
-
-          libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
-            /* successfully selected a target */
-            selectedProject.projectPageUrl = item.projectPageUrl;
-            selectedProject.projectName = item.name;
-            selectedProject.projectId = item.id;
-            selectedProject.projectBuildsUrl = item.projectBuildsUrl;
-          });
-
-        }
+       }
       }, null);
   }
 
+  /* Setup New build button in the top nav bar */
   function _setupNewBuildButton() {
-    /* Setup New build button */
 
     /* If we don't have a current project then present the set project
      * form.
@@ -98,7 +122,6 @@ function basePageInit(ctx) {
       $('#project .icon-pencil').hide();
     }
 
-
     libtoaster.makeTypeahead(newBuildProjectInput, selectedProject.projectsUrl, { format : "json" }, function (item) {
       /* successfully selected a project */
       newBuildProjectSaveBtn.removeAttr("disabled");
@@ -115,40 +138,16 @@ function basePageInit(ctx) {
       newBuildProjectSaveBtn.attr("disabled", "disabled");
     });
 
-    newBuildTargetInput.on('input', function () {
-      if ($(this).val().length === 0) {
-        newBuildTargetBuildBtn.attr("disabled", "disabled");
-      } else {
-        newBuildTargetBuildBtn.removeAttr("disabled");
-      }
-    });
-
-    newBuildTargetBuildBtn.click(function () {
-      if (!newBuildTargetInput.val()) {
-        return;
-      }
-
-      if (!selectedTarget) {
-        selectedTarget = { name: newBuildTargetInput.val() };
-      }
-      /* fire and forget */
-      libtoaster.startABuild(selectedProject.projectBuildsUrl, selectedProject.projectId, selectedTarget.name, null, null);
-      window.location.replace(selectedProject.projectPageUrl);
-    });
 
     newBuildProjectSaveBtn.click(function () {
       selectedProject.projectId = selectedProject.pk;
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
 
-      /* we set the effective context of the page to the currently selected project */
-      /* TBD: do we override even if we already have a context project ?? */
-      /* TODO: replace global library context with references to the "selected" project */
-
-      /* we can create a target typeahead only after we have a project selected */
       newBuildTargetInput.prop("disabled", false);
       newBuildTargetBuildBtn.prop("disabled", false);
 
+      /* Update the typeahead to use the new selectedProject */
       libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
         /* successfully selected a target */
         selectedTarget = item;
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 560e25a..03274c0 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -16,8 +16,6 @@ function importLayerPageInit (ctx) {
   var currentLayerDepSelection;
   var validLayerName = /^(\w|-)+$/;
 
-  $("#new-project-button").hide();
-
   libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.projectLayersUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
@@ -154,7 +152,7 @@ function importLayerPageInit (ctx) {
             } else {
               /* Success layer import now go to the project page */
               $.cookie('layer-imported-alert', JSON.stringify(data), { path: '/'});
-              window.location.replace(libtoaster.ctx.projectPageUrl+'#/layerimported');
+              window.location.replace(libtoaster.ctx.projectPageUrl+'?notify=layer-imported');
             }
           },
           error: function (data) {
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 291ed98..be6bbcd 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -16,14 +16,15 @@ function layerDetailsPageInit (ctx) {
   });
 
   $(".breadcrumb li:first a").click(function(e){
+    e.preventDefault();
     /* By default this link goes to the project configuration page. However
      * if we have some builds we go there instead of the default href
      */
     libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
       if (prjInfo.builds && prjInfo.builds.length > 0) {
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
-        e.preventDefault();
-        return;
+      } else {
+        window.location.replace(libtoaster.ctx.projectPageUrl);
       }
     });
   });
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index afd665c..079bbcb 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -79,11 +79,12 @@ var libtoaster = (function (){
         data: data,
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
+          /* No proper reponse YOCTO #7995
           if (_data.error !== "ok") {
             console.warn(_data.error);
-          } else {
+          } else { */
             if (onsuccess !== undefined) onsuccess(_data);
-          }
+        //  }
         },
         error: function (_data) {
           console.warn("Call failed");
@@ -180,7 +181,15 @@ var libtoaster = (function (){
           if (onFail !== undefined)
             onFail(data);
         } else {
-          onSuccess(data.layerdeps);
+          var deps = {};
+          /* Filter out layer dep ids which are in the
+           * project already.
+           */
+          deps.list = data.layerdeps.list.filter(function(layerObj){
+            return (data.projectlayers.lastIndexOf(layerObj.id) < 0);
+          });
+
+          onSuccess(deps);
         }
       }, function() {
         console.log("E: Failed to make request");
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
new file mode 100644
index 0000000..b7cb074
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -0,0 +1,429 @@
+"use strict";
+
+function projectPageInit(ctx) {
+
+  var layerAddInput = $("#layer-add-input");
+  var layersInPrjList = $("#layers-in-project-list");
+  var layerAddBtn = $("#add-layer-btn");
+
+  var machineChangeInput = $("#machine-change-input");
+  var machineChangeBtn = $("#machine-change-btn");
+  var machineForm = $("#select-machine-form");
+  var machineChangeFormToggle = $("#change-machine-toggle");
+  var machineNameTitle = $("#project-machine-name");
+  var machineChangeCancel = $("#cancel-machine-change");
+
+  var freqBuildBtn =  $("#freq-build-btn");
+  var freqBuildList = $("#freq-build-list");
+
+  var releaseChangeFormToggle = $("#release-change-toggle");
+  var releaseTitle = $("#project-release-title");
+  var releaseForm = $("#change-release-form");
+  var releaseModal = $("#change-release-modal");
+  var cancelReleaseChange = $("#cancel-release-change");
+
+  var currentLayerAddSelection;
+  var currentMachineAddSelection = {};
+
+  var urlParams = libtoaster.parseUrlParams();
+
+  libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl, function(prjInfo){
+    updateProjectLayers(prjInfo.layers);
+    updateFreqBuildRecipes(prjInfo.freqtargets);
+    updateProjectRelease(prjInfo.release);
+    updateProjectReleases(prjInfo.releases, prjInfo.release);
+
+    /* If we're receiving a machine set from the url and it's different from
+     * our current machine then activate set machine sequence.
+     */
+    if (urlParams.hasOwnProperty('setMachine') &&
+        urlParams.setMachine !== prjInfo.machine.name){
+        currentMachineAddSelection.name = urlParams.setMachine;
+        machineChangeBtn.click();
+    } else {
+      updateMachineName(prjInfo.machine.name);
+    }
+
+   /* Now we're really ready show the page */
+    $("#project-page").show();
+  });
+
+  (function notificationRequest(){
+
+    if (urlParams.hasOwnProperty('notify')){
+      switch (urlParams.notify){
+        case 'new-project':
+          $("#project-created-notification").show();
+          break;
+        case 'layer-imported':
+          layerImportedNotification();
+          break;
+        default:
+          break;
+      }
+    }
+  })();
+
+  /* Layer imported notification */
+  function layerImportedNotification(){
+    var imported = $.cookie("layer-imported-alert");
+    var message = "Layer imported";
+
+    if (!imported)
+      return;
+    else
+      imported = JSON.parse(imported);
+
+    if (imported.deps_added.length === 0) {
+      message = "You have imported <strong><a href=\""+imported.imported_layer.layerdetailurl+"\">"+imported.imported_layer.name+"</a></strong> and added it to your project.";
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
+    libtoaster.showChangeNotification(message);
+
+    $.removeCookie("layer-imported-alert", { path: "/"});
+  }
+
+  /* Add/Rm layer functionality */
+
+  libtoaster.makeTypeahead(layerAddInput, libtoaster.ctx.projectLayersUrl, { include_added: "false" }, function(item){
+    currentLayerAddSelection = item;
+    layerAddBtn.removeAttr("disabled");
+  });
+
+  layerAddBtn.click(function(e){
+    e.preventDefault();
+    var layerObj = currentLayerAddSelection;
+
+    addRmLayer(layerObj, true);
+    /* Reset the text input */
+    layerAddInput.val("");
+  });
+
+  function addRmLayer(layerObj, add){
+
+    libtoaster.addRmLayer(layerObj, add, function(layerDepsList){
+      if (add){
+        updateProjectLayers([layerObj]);
+        updateProjectLayers(layerDepsList);
+      }
+
+      /* Show the alert message */
+      var message = libtoaster.makeLayerAddRmAlertMsg(layerObj, layerDepsList, add);
+      libtoaster.showChangeNotification(message);
+    });
+  }
+
+  function updateProjectLayers(layers){
+
+    /* No layers to add */
+    if (layers.length === 0){
+      updateLayersCount();
+      return;
+    }
+
+    for (var i in layers){
+      var layerObj = layers[i];
+
+      var projectLayer = $("<li><a></a><span class=\"icon-trash\" data-toggle=\"tooltip\" title=\"Delete\"></span></li>");
+
+      projectLayer.data('layer', layerObj);
+      projectLayer.children("span").tooltip();
+
+      var link = projectLayer.children("a");
+
+      link.attr("href", layerObj.layerdetailurl);
+      link.text(layerObj.name);
+      /* YOCTO #8024
+        link.tooltip({title: layerObj.giturl + " | "+ layerObj.branch.name, placement: "right"});
+        branch name not accessible sometimes it is revision instead
+      */
+
+      var trashItem = projectLayer.children("span");
+      trashItem.click(function (e) {
+        e.preventDefault();
+        var layerObjToRm = $(this).parent().data('layer');
+
+        addRmLayer(layerObjToRm, false);
+
+        $(this).parent().fadeOut(function (){
+          $(this).remove();
+          updateLayersCount();
+        });
+      });
+
+      layersInPrjList.append(projectLayer);
+
+      updateLayersCount();
+    }
+  }
+
+  function updateLayersCount(){
+    var count = $("#layers-in-project-list").children().length;
+
+    if (count === 0)
+      $("#no-layers-in-project").fadeIn();
+    else
+      $("#no-layers-in-project").hide();
+
+    $("#project-layers-count").text(count);
+
+    return count;
+  }
+
+  /* Frequent builds functionality */
+  function updateFreqBuildRecipes(recipes) {
+    var noMostBuilt = $("#no-most-built");
+
+    if (recipes.length === 0){
+      noMostBuilt.show();
+      freqBuildBtn.hide();
+    } else {
+      noMostBuilt.hide();
+      freqBuildBtn.show();
+    }
+
+    for (var i in recipes){
+      var freqTargetCheck = $('<li><label class="checkbox"><input type="checkbox" /><span class="freq-target-name"></span></label></li>');
+      freqTargetCheck.find(".freq-target-name").text(recipes[i]);
+      freqTargetCheck.find("input").val(recipes[i]);
+      freqTargetCheck.click(function(){
+        if (freqBuildList.find(":checked").length > 0)
+          freqBuildBtn.removeAttr("disabled");
+        else
+          freqBuildBtn.attr("disabled", "disabled");
+      });
+
+      freqBuildList.append(freqTargetCheck);
+    }
+  }
+
+  freqBuildBtn.click(function(e){
+    e.preventDefault();
+
+    var toBuild = "";
+    freqBuildList.find(":checked").each(function(){
+      toBuild += $(this).val();
+      toBuild += " ";
+    });
+
+    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl, libtoaster.ctx.projectId, toBuild, function(){
+      /* Build started */
+      window.location.replace(libtoaster.ctx.projectBuildsUrl);
+    },
+    function(){
+      /* Build start failed */
+      /* [YOCTO #7995] */
+      window.location.replace(libtoaster.ctx.projectBuildsUrl);
+    });
+  });
+
+
+  /* Change machine functionality */
+
+  machineChangeFormToggle.click(function(){
+    machineForm.slideDown();
+    machineNameTitle.hide();
+    $(this).hide();
+  });
+
+  machineChangeCancel.click(function(){
+    machineForm.slideUp(function(){
+      machineNameTitle.show();
+      machineChangeFormToggle.show();
+    });
+  });
+
+  function updateMachineName(machineName){
+    machineChangeInput.val(machineName);
+    machineNameTitle.text(machineName);
+  }
+
+  libtoaster.makeTypeahead(machineChangeInput, libtoaster.ctx.projectMachinesUrl, { }, function(item){
+    currentMachineAddSelection = item;
+    machineChangeBtn.removeAttr("disabled");
+  });
+
+  machineChangeBtn.click(function(e){
+    e.preventDefault();
+    if (currentMachineAddSelection.name === undefined)
+      return;
+
+    libtoaster.editCurrentProject({ machineName : currentMachineAddSelection.name },
+      function(){
+        /* Success machine changed */
+        updateMachineName(currentMachineAddSelection.name);
+        machineChangeCancel.click();
+
+        /* Show the alert message */
+        var message = $('<span class="lead">You have changed the machine to: <strong><span id="notify-machine-name"></span></strong></span>');
+        message.find("#notify-machine-name").text(currentMachineAddSelection.name);
+        libtoaster.showChangeNotification(message);
+    },
+      function(){
+        /* Failed machine changed */
+        console.log("failed to change machine");
+    });
+  });
+
+
+  /* Change release functionality */
+  function updateProjectRelease(release){
+    releaseTitle.text(release.description);
+  }
+
+  function updateProjectReleases(releases, current){
+    for (var i in releases){
+      var releaseOption = $("<option></option>");
+
+      releaseOption.val(releases[i].id);
+      releaseOption.text(releases[i].description);
+      releaseOption.data('release', releases[i]);
+
+      if (releases[i].id == current.id)
+        releaseOption.attr("selected", "selected");
+
+      releaseForm.children("select").append(releaseOption);
+    }
+  }
+
+  releaseChangeFormToggle.click(function(){
+    releaseForm.slideDown();
+    releaseTitle.hide();
+    $(this).hide();
+  });
+
+  cancelReleaseChange.click(function(e){
+    e.preventDefault();
+    releaseForm.slideUp(function(){
+      releaseTitle.show();
+      releaseChangeFormToggle.show();
+    });
+  });
+
+  function changeProjectRelease(release, layersToRm){
+    libtoaster.editCurrentProject({ projectVersion : release.id },
+      function(){
+        /* Success */
+        /* Update layers list with new layers */
+        layersInPrjList.addClass('muted');
+        libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
+            function(prjInfo){
+              layersInPrjList.children().remove();
+              updateProjectLayers(prjInfo.layers);
+              layersInPrjList.removeClass('muted');
+              releaseChangedNotification(release, prjInfo.layers, layersToRm);
+        });
+        updateProjectRelease(release);
+        cancelReleaseChange.click();
+    });
+  }
+
+  /* Create a notification to show the changes to the layer configuration
+   * caused by changing a release.
+   */
+
+  function releaseChangedNotification(release, layers, layersToRm){
+
+    var message;
+
+    if (layers.length === 0 && layersToRm.length === 0){
+      message = $('<span><span class="lead">You have changed the project release to: <strong><span id="notify-release-name"></span></strong>.');
+      message.find("#notify-release-name").text(release.description);
+      libtoaster.showChangeNotification(message);
+      return;
+    }
+
+    /* Create the whitespace separated list of layers removed */
+    var layersDelList = "";
+
+    layersToRm.map(function(layer, i){
+      layersDelList += layer.name;
+      if (layersToRm[i+1] !== undefined)
+        layersDelList += ', ';
+    });
+
+    message = $('<span><span class="lead">You have changed the project release to: <strong><span id="notify-release-name"></span></strong>. This has caused the following changes in your project layers:</span><ul id="notify-layers-changed-list"></ul></span>');
+
+    var changedList = message.find("#notify-layers-changed-list");
+
+    message.find("#notify-release-name").text(release.description);
+
+    /* Manually construct the list item for changed layers */
+    var li = '<li><strong>'+layers.length+'</strong> layers changed to the <strong>'+release.name+'</strong> release: ';
+    for (var i in layers){
+      li += '<a href='+layers[i].layerdetailurl+'>'+layers[i].name+'</a>';
+      if (i !== 0)
+        li += ', ';
+    }
+
+    changedList.append($(li));
+
+    /* Layers removed */
+    if (layersToRm && layersToRm.length > 0){
+      if (layersToRm.length == 1)
+        li = '<li><strong>1</strong> layer deleted: '+layersToRm[0].name+'</li>';
+      else
+        li = '<li><strong>'+layersToRm.length+'</strong> layers deleted: '+layersDelList+'</li>';
+
+      changedList.append($(li));
+    }
+
+    libtoaster.showChangeNotification(message);
+  }
+
+  /* Show the modal dialog which gives the option to remove layers which
+   * aren't compatible with the proposed release
+   */
+  function showReleaseLayerChangeModal(release, layers){
+    var layersToRmList = releaseModal.find("#layers-to-remove-list");
+    layersToRmList.text("");
+
+    releaseModal.find(".proposed-release-change-name").text(release.description);
+    releaseModal.data("layers", layers);
+    releaseModal.data("release", release);
+
+    for (var i in layers){
+      layersToRmList.append($("<li></li>").text(layers[i].name));
+    }
+    releaseModal.modal('show');
+  }
+
+  $("#change-release-btn").click(function(e){
+    e.preventDefault();
+
+    var newRelease = releaseForm.find("option:selected").data('release');
+
+    $.getJSON(ctx.typeaheadUrl,
+      { search: newRelease.id, type: "versionlayers" },
+      function(layers) {
+        if (layers.rows.length === 0){
+          /* No layers to change for this release */
+          changeProjectRelease(newRelease, []);
+        } else {
+          showReleaseLayerChangeModal(newRelease, layers.rows);
+        }
+    });
+  });
+
+  /* Release change modal accept */
+  $("#change-release-and-rm-layers").click(function(){
+    var layers = releaseModal.data("layers");
+    var release =  releaseModal.data("release");
+
+    changeProjectRelease(release, layers);
+  });
+
+}
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 8def2da..4c6676c 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -38,6 +38,8 @@
         projectName : {{project.name|json}},
         projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
         projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
+        projectLayersUrl: {% url 'projectlayers' project.id as plurl %}{{plurl|json}},
+        projectMachinesUrl: {% url 'projectmachines' project.id as pmurl %}{{pmurl|json}},
         projectId : {{project.id}},
         {% else %}
         projectId : undefined,
@@ -69,6 +71,11 @@
     Loading <i class="fa-pulse icon-spinner"></i>
   </div>
 
+  <div id="change-notification" class="alert lead alert-info" style="display:none">
+    <button type="button" class="close" id="hide-alert">&times;</button>
+    <span id="change-notification-msg"></span>
+  </div>
+
     <div class="navbar navbar-fixed-top">
       <div class="navbar-inner">
         <div class="container-fluid">
diff --git a/lib/toaster/toastergui/templates/baseprojectpage.html b/lib/toaster/toastergui/templates/baseprojectpage.html
index ac32dea..0db06a8 100644
--- a/lib/toaster/toastergui/templates/baseprojectpage.html
+++ b/lib/toaster/toastergui/templates/baseprojectpage.html
@@ -29,8 +29,6 @@
       <li><a href="{% url 'projecttargets' project.id %}">Recipes</a></li>
       <li><a href="{% url 'projectmachines' project.id %}">Machines</a></li>
       <li><a href="{% url 'projectlayers' project.id %}">Layers</a></li>
-      <li class="nav-header">Actions</li>
-      <li><a href="{% url 'importlayer' project.id %}">Import layer</a></li>
     </ul>
   </div>
   <div class="span10">
diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index d6984bc..bec5f1a 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -1,10 +1,11 @@
-{% extends "baseprojectpage.html" %}
+{% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
+{% block pagecontent %}
 
+{% include "projecttopbar.html" %}
 
-{% block projectinfomain %}
 
         {% if project and project.release %}
                   <script src="{% static 'js/layerDepsModal.js' %}"></script>
@@ -24,12 +25,10 @@
                     });
                   </script>
 
-                <h2>Import layer</h2>
-
-                <form>
-                    <span class="help-block">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
+                <form class="span11">
                    <fieldset class="air">
                       <legend>Layer repository information</legend>
+                      <span class="help-block">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
                       <div class="alert alert-error" id="import-error" style="display:none">
                         <button type="button" class="close" data-dismiss="alert">&times;</button>
                         <h3>&nbsp;</h3>
@@ -136,5 +135,4 @@
                       </div>
 
           {% endif %}
-
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/machine_btn.html b/lib/toaster/toastergui/templates/machine_btn.html
index 54ff5de..d2cb55b 100644
--- a/lib/toaster/toastergui/templates/machine_btn.html
+++ b/lib/toaster/toastergui/templates/machine_btn.html
@@ -1,4 +1,4 @@
-<a href="{% url 'project' extra.pid %}#/machineselect={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.id}}" style="margin-top: 5px; display:none">
+<a href="{% url 'project' extra.pid %}?setMachine={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.id}}" style="margin-top: 5px; display:none">
   Select machine</a>
 <button class="btn btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add">
   <i class="icon-plus"></i>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 0fbfb59..aad79b4 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -1,446 +1,130 @@
- {% extends "baseprojectpage.html" %}
-<!--
-vim: expandtab tabstop=2
--->
+{% extends "baseprojectpage.html" %}
+
 {% load projecttags %}
 {% load humanize %}
 {% load static %}
 
-
 {% block projectinfomain %}
-<script src="{% static "js/angular.min.js" %}"></script>
-<script src="{% static "js/angular-animate.min.js" %}"></script>
-<script src="{% static "js/angular-cookies.min.js" %}"></script>
-<script src="{% static "js/angular-route.min.js" %}"></script>
-<script src="{% static "js/angular-sanitize.min.js" %}"></script>
-<script src="{% static "js/ui-bootstrap-tpls-0.11.0.js" %}"></script>
 
-{% if lvs_nos == 0 %}
+<script src="{% static 'js/layerDepsModal.js' %}"></script>
+<script src="{% static 'js/projectpage.js' %}"></script>
+<script>
+  $(document).ready(function (){
+    var ctx = {
+      typeaheadUrl : "{% url 'xhr_datatypeahead' project.id %}",
+
+    };
+
+    try {
+      projectPageInit(ctx);
+    } catch (e) {
+      document.write("Sorry, An error has occurred loading this page");
+      console.warn(e);
+    }
+  });
+</script>
 
-  <div class="page-header">
-    <h1> {{ project.name }} </h1>
+<div id="change-release-modal" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="change-release-modal" aria-hidden="false">
+  <div class="modal-header">
+    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
+    <h3>Changing Yocto Project release to <span class="proposed-release-change-name"></span></h3>
   </div>
-  <div class="alert alert-info lead">
-	  <p>Toaster has no layer information. Without layer information, you cannot run builds. To generate layer information you can:</p>
-		<ul>
-			 <li> <a href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html#layer-source">Configure a layer source</a></li>
-			 <li> <a href="{% url 'importlayer' project.id %}">Import a layer</a></li>
-		</ul>
-</div>
-
-{%else%}
-
-<div id="main" role="main" data-ng-app="project" data-ng-controller="prjCtrl" data-ng-cloak>
-
-  <!-- alerts section 1-->
-  <div data-ng-repeat="a in zone1alerts">
-    <div class="alert alert-dismissible lead" role="alert" data-ng-class="a.type"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>
-      <span data-ng-bind-html="a.text"></span>
-    </div>
+  <div class="modal-body">
+    <p>The following added layers do not exist for <span class="proposed-release-change-name"></span>: </p>
+    <ul id="layers-to-remove-list">
+    </ul>
+    <p>If you change the Yocto Project release to <span class="proposed-release-change-name"></span>, the above layers will be deleted from your added layers.</p>
   </div>
+  <div class="modal-footer">
+    <button id="change-release-and-rm-layers" data-dismiss="modal" type="submit" class="btn btn-primary">Change release and delete layers</button>
+    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
+  </div>
+</div>
 
-  <!-- custom templates for ng -->
-
-  <style>
-  .missing-layer {
-    color: lightgrey;
-  }
-  </style>
-  <script type="text/ng-template" id="recipes_suggestion_details">
-    <a> {[match.model.name]}
-      <span data-ng-class="{'missing-layer':($parent.$parent.$parent.$parent.filterProjectLayerIds().indexOf(match.model.projectcompatible_layer.id) == -1)}">
-          [{[match.model.layer_version__layer__name]}]
-      </span>
-    </a>
-  </script>
-
-  <script type="text/ng-template" id="machines_suggestion_details">
-    <a>  {[match.model.name]} <span class="{'missing-layer':(filterProjectLayerIds().indexOf(match.model.layer_version_compatible_id) == -1)}">[{[match.model.layer_version__layer__name]}]</span> </a>
-  </script>
 
-  <script type="text/ng-template" id="layers_suggestion_details">
-    <a>  {[match.model['layer__name']]} ( {[match.model.layer__vcs_url]} ) </a>
-  </script>
+<div class="row-fluid" id="project-page" style="display:none">
+  <div class="span6">
+    <div class="well well-transparent" id="machine-section">
+      <h3>Machine</h3>
 
+      <p class="lead"><span id="project-machine-name"></span> <i title="" data-original-title="" id="change-machine-toggle" class="icon-pencil"></i></p>
 
+      <form id="select-machine-form" style="display:none;">
+        <div class="alert alert-info">
+          <strong>Machine changes have a big impact on build outcome.</strong> You cannot really compare the builds for the new machine with the previous ones.
+        </div>
 
+        <div class="input-append">
+          <input id="machine-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
+            <button id="machine-change-btn" class="btn" type="button">Save</button> <a href="#" id="cancel-machine-change" class="btn btn-link">Cancel</a>
+        </div>
 
-  <!-- modal dialogs -->
-  <script type="text/ng-template" id="dependencies_modal">
-    <div class="modal-header">
-        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-        <h3><span data-ng-bind="layerAddName"></span> dependencies</h3>
-    </div>
-    <div class="modal-body">
-        <p><strong>{[layerAddName]}</strong> depends on some layers that are not added to your project. Select the ones you want to add:</p>
-        <ul class="unstyled">
-            <li data-ng-repeat="ld in items">
-                <label class="checkbox">
-                    <input type="checkbox" data-ng-model="selectedItems[ld.id]"> {[ld.name]}
-                </label>
-            </li>
-        </ul>
-    </div>
-    <div class="modal-footer">
-        <button class="btn btn-primary" data-ng-click="ok()">Add layers</button>
-        <button class="btn" data-ng-click="cancel()">Cancel</button>
+        <p><a href="{% url 'projectmachines' project.id %}" class="link">View compatible machines</a></p>
+      </form>
     </div>
-    </form>
-  </script>
 
+    <div class="well well-transparent">
+      <h3>Most built recipes</h3>
 
-  <script type="text/ng-template" id="change_version_modal">
-    <div class="modal-header">
-        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
-        <h3>Changing release to {[releaseDescription]}</h3>
+      <div class="alert alert-info" style="display:none" id="no-most-built">
+        <span class="lead">You haven't built any recipes yet</span>
       </div>
-      <div class="modal-body">
-        <p>The following project layers do not exist for the {[releaseDescription]} release:</p>
-        <ul>
-          <li data-ng-repeat="i in items"><span class="layer-info" data-toggle="tooltip" tooltip="{[i.detail]}">{[i.name]}</span></li>
-        </ul>
-        <p>If you change the release to {[releaseDescription]}, the above layers will be deleted from your project.</p>
-      </div>
-      <div class="modal-footer">
-        <button class="btn btn-primary" data-ng-click="ok()">Change release and delete layers</button>
-        <button class="btn" data-ng-click="cancel()">Cancel</button>
-      </div>
-  </script>
-
-  <script type="text/ng-template" id="target_display">
-      <div data-ng-switch on="t.task.length">
-        <div data-ng-switch-when="undefined">{[t.target]}</div>
-        <div data-ng-switch-default>{[t.target]}:{[t.task]}</div>
-      </div>
-  </script>
-
-
-  <!-- latest builds list -->
-
-  <a id="buildslist"></a>
-  <h2 class="air" data-ng-if="builds.length">Latest builds</h2>
-  <div class="animate-repeat alert"  data-ng-repeat="b in builds track by b.id" data-ng-class="{'queued':'alert-info', 'In Progress':'alert-info', 'Succeeded':'alert-success', 'Failed':'alert-error'}[b.status]">
-    <div class="row-fluid">
-        <switch data-ng-switch="b.status">
-
-          <case data-ng-switch-when="Failed">
-            <div class="lead span3">
-              <a data-ng-class="{'Succeeded': 'success', 'Failed': 'error'}[b.status]" href="{[b.br_page_url]}">
-                <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>
-              </a>
-            </div>
-            <div class="span2 lead">
-              <ngif data-ng-if="b.updated - todaydate > 0">
-                 {[b.updated|date:'HH:mm']}
-              </ngif>
-              <ngif data-ng-if="b.updated - todaydate < 0">
-                 {[b.updated|date:'dd/MM/yy HH:mm']}
-              </ngif>
-            </div>
-            <div class="span2">
-              <ngif data-ng-if="b.errors.length">
-                <span>
-                  <i class="icon-minus-sign red lead"></i>
-                  <a href="{[b.br_page_url]}#errors" class="lead error">{[b.errors.length]}
-                  <ng-pluralize count="b.errors.length" when="{'1':'error','other':'errors'}"></ng-pluralize></a>
-                </span>
-              </ngif>
-            </div>
-            <div class="span2">
-              <!-- we don't have warnings in this case -->
-            </div>
-            <div> <span class="lead">Build time: {[b.command_time|timediff]}</span>
-                <button class="btn pull-right" data-ng-class="{'Succeeded':  'btn-success', 'Failed': 'btn-danger'}[b.status]"
-                    data-ng-click="buildExistingTarget(b.targets)">Run again</button>
-
-            </div>
-          </case>
-
-          <case data-ng-switch-when="queued">
-            <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-            <div class="span4 lead" >Build queued
-              <i title="This build will start as soon as a build server is available" class="icon-question-sign get-help get-help-blue heading-help" data-toggle="tooltip"></i>
-            </div>
-            <button class="btn pull-right btn-info" data-ng-click="buildCancel(b)">Cancel</button>
-          </case>
-
-          <case data-ng-switch-when="In Progress">
-            <switch data-ng-switch="b.build.length">
-              <case data-ng-switch-when="0">
-                <div class="lead span5"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-                <div class="span4 lead">
-                  Checking out layers
-                </div>
-              </case>
-              <case data-ng-switch-default="">
-                <div class="lead span3"> <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>   </div>
-                <div class="span4 offset1" >
-                  <div class="progress" style="margin-top:5px;" data-toggle="tooltip" tooltip="{[b.build[0].completeper]}% of tasks complete">
-                      <div style="width: {[b.build[0].completeper]}%;" class="bar"></div>
-                  </div>
-                </div>
-                <div class="text-right lead">{[b.build[0].completeper]}% tasks completed</div>
-              </case>
-          </case>
-
 
-          <case data-ng-switch-when="Succeeded">
-            <div class="lead span3">
-              <a data-ng-class="{'Succeeded': 'success', 'Failed': 'error'}[b.build[0].status]" href="{[b.build[0].build_page_url]}">
-                <span data-ng-repeat="t in b.targets" data-ng-include src="'target_display'"></span>
-              </a>
-            </div>
-            <div class="span2 lead">
-              <ngif data-ng-if="b.build[0].completed_on - todaydate > 0">
-                 {[b.build[0].completed_on|date:'HH:mm']}
-              </ngif>
-              <ngif data-ng-if="b.build[0].completed_on - todaydate < 0">
-                 {[b.build[0].completed_on|date:'dd/MM/yy HH:mm']}
-              </ngif>
-            </div>
-            <div class="span2">
-              <ngif data-ng-if="b.build[0].errors">
-                <span>
-                  <i class="icon-minus-sign red lead"></i>
-                  <a href="{[b.build[0].build_page_url]}#errors" class="lead error">{[b.build[0].errors]}
-                  <ng-pluralize count="b.build[0].errors" when="{'1':'error','other':'errors'}"></ng-pluralize></a>
-                </span>
-              </ngif>
-            </div>
-            <div class="span2">
-              <ngif data-ng-if="b.build[0].warnings">
-                <span>
-                  <i class="icon-warning-sign yellow lead"></i>
-                  <a href="{[b.build[0].build_page_url]}#warnings" class="lead warning">{[b.build[0].warnings]}
-                  <ng-pluralize count="b.build[0].warnings" when="{'1':'warning','other':'warnings'}"></ng-pluralize></a>
-                </span>
-              </ngif>
-            </div>
-            <div> <span class="lead">Build time: <a href="{[b.build[0].build_time_page_url]}">{[b.build[0].build_time|timediff]}</a></span>
-                <button class="btn pull-right" data-ng-class="{'Succeeded':  'btn-success', 'Failed': 'btn-danger'}[b.build[0].status]"
-                    data-ng-click="buildExistingTarget(b.targets)">Run again</button>
+      <ul class="unstyled configuration-list" id="freq-build-list">
+      </ul>
+      <button class="btn btn-primary" id="freq-build-btn" disabled="disabled">Build selected recipes</button>
+    </div>
 
-            </div>
-          </case>
+    <div class="well well-transparent">
+      <h3>Project release</h3>
 
+      <p class="lead"><span id="project-release-title"></span> <i title="" data-original-title="" id="release-change-toggle" class="icon-pencil"></i></p>
 
-          <case data-ng-switch-default="">
-          <div>FIXME!</div>
-          </case>
-        </switch>
-      <div class="lead pull-right">
-      </div>
+      <form class="form-inline" id="change-release-form" style="display:none;">
+        <select></select>
+        <button class="btn" style="margin-left:5px;" id="change-release-btn">Change</button> <a href="#" id="cancel-release-change" class="btn btn-link">Cancel</a>
+      </form>
     </div>
   </div>
 
-  <h2 class="air">Project configuration</h2>
+  <div class="span6">
+    <div class="well well-transparent" id="layer-container">
+      <h3>Layers <span class="muted counter">(<span id="project-layers-count"></span>)</span>
+        <i data-original-title="OpenEmbedded organises metadata into modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>" class="icon-question-sign get-help heading-help" title=""></i>
+      </h3>
 
-  <!-- alerts section 2 -->
-  <div data-ng-repeat="a in zone2alerts">
-    <div class="alert alert-dismissible lead" role="alert" data-ng-class="a.type"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>
-      <span data-ng-bind-html="a.text"></span>
-    </div>
-  </div>
+      <div class="alert lead" id="no-layers-in-project" style="display:none">
+        You need to add some layers. For that you can:
+        <ul>
+          <li><a href="{% url 'projectlayers' project.id %}">View all layers compatible with this project</a></li>
+          <li><a href="{% url 'importlayer' project.id %}">Import a layer</a></li>
+          <li><a href="http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the documentation</a></li>
+        </ul>
+        <p>Or type a layer name below.</p>
+      </div>
 
-  <div class="row-fluid">
+      <form style="margin-top:20px">
+        <!--div class="control-group error"-->
 
-    <!-- project layers -->
-    <div id="layer-container" class="well well-transparent span4">
-      <h3>
-        Layers <span class="muted counter">({[layers.length]})</span>
-        <i class="icon-question-sign get-help heading-help" title="Bitbake reads metadata files from modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>"></i>
-      </h3>
-      <div class="alert" data-ng-if="project.release && !layers.length">
-        <b>You need to add some layers </b>
-        <p>
-        You can:
-          <ul>
-            <li> <a href="{% url 'projectlayers' project.id %}">View all compatible layers available in Toaster</a>
-            <li> <a href="{% url 'importlayer' project.id %}">Import a layer</a>
-            <li> <a href="https://www.yoctoproject.org/docs/1.6.1/dev-manual/dev-manual.html#understanding-and-creating-layers" target="_blank">Read about layers in the manual</a>
-          </ul>
-        Or type a layer name below.
-        </p>
-      </div>
-      <form data-ng-submit="layerAdd()">
         <div class="input-append">
-          <input type="text" style="width: 100%" id="layer" autocomplete="off" placeholder="Type a layer name" data-minLength="1" data-ng-model="layerAddName" data-typeahead="e for e in getLayersAutocompleteSuggestions($viewValue)" data-typeahead-template-url="layers_suggestion_details" data-typeahead-on-select="onLayerSelect($item, $model, $label)" data-typeahead-editable="false" data-ng-class="{ 'has-error': layerAddName.$invalid }" data-ng-disabled="!project.release" />
-          <input type="submit" id="add-layer" class="btn" value="Add" data-ng-disabled="!layerAddName.length"/>
+          <input id="layer-add-input" autocomplete="off" placeholder="Type a layer name" data-minlength="1" data-autocomplete="off" data-provide="typeahead" data-source="" type="text">
+            <button id="add-layer-btn" class="btn" disabled>Add</button>
         </div>
-        {% csrf_token %}
-      </form>
-      <p>
-        <a href="{% url 'projectlayers' project.id %}">View all compatible layers</a>
-        <i class="icon-question-sign get-help" title="View all the layers you can build with the release selected for this project, which is {[project.release.desc]}"></i>
-        |
-        <a href="{% url 'importlayer' project.id %}">Import layer</a></p>
-      <ul class="unstyled configuration-list">
-          <li data-ng-repeat="l in layers track by l.id" class="animate-repeat">
-            <a href="{[l.layerdetailurl]}" class="layer-info" data-toggle="tooltip" tooltip-placement="right" tooltip="{[l.giturl]} | {[l.branch.name]}">{[l.name]}</a>
-            <i class="icon-trash" data-ng-click="layerDel(l.id)" tooltip="Delete"></i>
-                      </li>
-      </ul>
-    </div>
 
-
-    <!-- project targets -->
-    <div id="target-container" class="well well-transparent span4">
-      <h3>
-        Recipes
-        <i class="icon-question-sign get-help heading-help" title="What you build, often an image recipe that produces a root file system file. Something like <code>core-image-minimal</code> or <code>core-image-sato</code>"></i>
-      </h3>
-        <form data-ng-submit="buildNamedTarget()">
-          <div class="input-append">
-            <input type="text" style="width: 100%" placeholder="Type the recipe(s) you want to build" autocomplete="off" data-minLength="1"  data-ng-model="targetName1" data-typeahead="a.name for a in getRecipesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="recipes_suggestion_details" data-ng-disabled="!project.release || !layers.length">
-            <button type="submit" class="btn btn-primary" data-ng-disabled="!targetName1.length">
-              Build </button>
-          </div>
-          {% csrf_token %}
-        </form>
-        <p>
-          <a href="{% url 'projecttargets' project.id %}">View all compatible recipes</a>
-          <i class="icon-question-sign get-help" title="View all the recipes you can build with the release selected for this project, which is {[project.release.desc]}"></i>
-        </p>
-        <div data-ng-if="frequenttargets.length">
-        <h4 class="air">
-            Most built recipes
-        </h4>
-          <ul class="unstyled configuration-list {[mutedtargets]}">
-          <li data-ng-repeat="t in frequenttargets">
-            <label class="checkbox">
-              <input type="checkbox" data-ng-model="mostBuiltTargets[t]" data-ng-disabled="disableBuildCheckbox(t)" data-ng-checked="mostBuiltTargets[t] && !disableBuildCheckbox(t)">{[t]}
-            </label>
-          </li>
-        </ul>
-        <button class="btn btn-large btn-primary" data-ng-disabled="enableBuildSelectedTargets()" data-ng-click="buildSelectedTargets()">Build selected recipes</button>
+        <div id="import-alert" class="alert alert-info" style="display:none;">
+          Toaster does not know about this layer. Please <a href="#">import it</a>
         </div>
-    </div>
 
-    <!-- project configuration -->
-    <div id="machine-distro" class="well well-transparent span4">
-      <h3>
-        Machine
-        <i class="icon-question-sign get-help heading-help" title="The machine is the hardware for which you want to build. You can only set one machine per project"></i>
-      </h3>
-      <p class="lead" id="select-machine-opposite">
-        <span>{[machine.name]}</span>
-        <i id="change-machine" class="icon-pencil" data-ng-click="toggle('#select-machine')"></i>
-      </p>
-      <div id="select-machine" style="display: none">
-        <div class="alert alert-info">
-          <strong>Machine changes have a big impact on build outcome.</strong>
-              You cannot really compare the builds for the new machine with the previous ones.
-        </div>
-        <form data-ng-submit="editProjectSettings('#select-machine')" class="input-append">
-              <input type="text" id="machine" autocomplete="off" data-ng-model="machineName" value="{[machine.name]}" data-typeahead="m.name for m in getMachinesAutocompleteSuggestions($viewValue)" data-typeahead-template-url="machines_suggestion_details" />
-              <input type="submit" id="apply-change-machine" class="btn" data-ng-disabled="machineName == machine.name || machineName.length == 0" value="Save"/>
-              <input type="reset" id="cancel-machine" class="btn btn-link" data-ng-click="toggle('#select-machine')" value="Cancel"/>
-              {% csrf_token %}
-        </form>
         <p>
-          <a href="{% url 'projectmachines' project.id %}" class="link">View all compatible machines</a>
-        <i class="icon-question-sign get-help" title="View all the machines you can set with the release selected for this project, which is {[project.release.desc]}"></i>
-      </p>
-      </div>
-      <p class="link-action">
-            <a href="{% url 'projectconf' project.id %}" class="link">Edit configuration variables</a>
-            <i data-original-title="You can set other project configuration options here. Each option, like everything else in the build system, is a variable - value pair" class="icon-question-sign get-help heading-help" title=""></i>
-            </p>
-    </div>
-  </div>
-
-
-  <h2>Project details</h2>
-
-  <!-- alerts section 3 -->
-  <div data-ng-repeat="a in zone3alerts">
-    <div class="alert alert-dismissible lead" role="alert" data-ng-class="a.type"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>
-      <span data-ng-bind-html="a.text"></span>
-    </div>
-  </div>
-
-
-  <div id="project-details" class="well well-transparent">
-    <h3>Project name</h3>
-    <p class="lead" id="change-project-name-opposite">
-      <span >{[project.name]}</span>
-      <i class="icon-pencil" data-ng-click="toggle('#change-project-name')" ></i>
-    </p>
-    <div id="change-project-name" style="display:none;">
-      <form data-ng-submit="editProjectSettings('#change-project-name')" class="input-append">
-        <input type="text" class="input-xlarge" id="type-project-name" data-ng-model="projectName" value="{[project.name]}">
-        <input type="submit" class="btn" value="Save" data-ng-disabled="project.name == projectName"/>
-        <input type="reset" class="btn btn-link" value="Cancel" data-ng-click="toggle('#change-project-name')">
-     </form>
-    </div>
-
-    <h3 data-ng-if="releases.length > 1">
-      Release
-      <i class="icon-question-sign get-help heading-help" title="The version of the build system you want to use"></i>
-    </h3>
-    <p data-ng-if="releases.length > 1" class="lead" id="change-project-version-opposite">
-      <span id="project-version">{[project.release.desc]}</span>
-      <i id="change-version" class="icon-pencil" data-ng-click="toggle('#change-project-version')" ></i>
-    </p>
-    <div class="div-inline" id="change-project-version" style="display:none;">
-      <form data-ng-submit="testProjectSettingsChange('#change-project-version')" class="input-append">
-        <select id="select-version" data-ng-model="projectVersion">
-          <option data-ng-repeat="r in releases" value="{[r.id]}" data-ng-selected="r.id == project.release.id">{[r.description]}</option>
-        </select>
-        <input type="submit" class="btn" style="margin-left:5px;" value="Save" data-ng-disabled="project.release.id == projectVersion"/>
-        <input type="reset"  class="btn btn-link" value="Cancel" data-ng-click="toggle('#change-project-version')"/>
-
+          <a href="{% url 'projectlayers' project.id %}" id="view-compatible-layers">View compatible layers</a>
+          <i data-original-title="View all the layers you can build with the release selected for this project, which is Yocto Project master" class="icon-question-sign get-help" title=""></i>
+          | <a href="{% url 'importlayer' project.id %}">Import layer</a>
+        </p>
       </form>
+
+      <ul class="unstyled configuration-list" id="layers-in-project-list">
+      </ul>
     </div>
   </div>
-
-</div> <!-- end main -->
-
-</div> <!-- end row -->
-
-
-
-<!-- load application logic !-->
-<script src="{% static "js/projectapp.js" %}"></script>
-
-<!-- dump initial data for use in the angular app -->
-<script>
-angular.element(document).ready(function() {
-  scope = angular.element("#main").scope();
-  scope.urls = {};
-  scope.urls.xhr_build = "{% url 'projectbuilds' project.id %}";
-  scope.urls.xhr_edit = "{% url 'project' project.id %}?format=json";
-  scope.urls.layers = "{% url 'projectlayers' project.id %}";
-  scope.urls.targets = "{% url 'projectavailabletargets' project.id %}";
-  scope.urls.machines = "{% url 'projectmachines' project.id %}";
-  scope.urls.importlayer = "{% url 'importlayer' project.id %}";
-  scope.urls.xhr_datatypeahead = {% url 'xhr_datatypeahead' project.id as xhrdta %}{{xhrdta|json}};
-  scope.project = {{prj|json}};
-  scope.builds = {{builds|json}};
-  scope.layers = {{layers|json}};
-  scope.targets = {{targets|json}};
-  scope.frequenttargets = {{freqtargets|json}};
-  scope.machine = {{machine|json}};
-  scope.releases = {{releases|json}};
-  scope.layerCount = scope.layers.length;
-  scope.mutedtargets = (scope.layerCount == 0 ? "muted" : "")
-  var now = (new Date()).getTime();
-  scope.todaydate = now - (now % 86400000);
-
-  scope.zone1alerts = [];
-  scope.zone2alerts = [];
-  scope.zone3alerts = [];
-
-  scope.mostBuiltTargets = {};
-
-  scope.updateDisplayWithCommands();
-  scope.validateData();
-
-  scope.init();
-  scope.$digest();
-
-  });
-</script>
-
-{% endif %} {# from lvs_nos check #}
+</div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index 46473cb..d4d1951 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -1,3 +1,8 @@
+<div class="alert alert-success lead" id="project-created-notification" style="margin-top:15px; display:none">
+  <button type="button" class="close" data-dismiss="alert">×</button>
+  Your project <strong>{{project.name}}</strong> has been created. You can now <a href="{% url 'projectmachines' project.id %}">select your target machine</a> and <a href="{% url 'projecttargets' project.id %}">choose image recipes</a> to build.
+</div>
+
 <!-- project name -->
 <div class="row-fluid page-header">
   <h1>{{project.name}}</h1>
@@ -7,7 +12,7 @@
   <ul class="nav nav-pills">
     <li>
       <a href="{% url 'projectbuilds' project.id %}">
-        Builds (<span class="total-builds"></span>)
+        Builds (<span class="total-builds">0</span>)
       </a>
     </li>
     <li id="topbar-configuration-tab">
@@ -15,6 +20,11 @@
         Configuration
       </a>
     </li>
+    <li>
+      <a href="{% url 'importlayer' project.id %}">
+        Import layer
+      </a>
+    </li>
     <!-- Coming soon
     <li>
       <a href="my-image-recipes.html">
@@ -23,16 +33,16 @@
     </li>
     -->
     <li class="pull-right">
-      <form class="form-inline" style="margin-bottom: 0">
 
         <i class="icon-question-sign get-help heading-help" data-placement="left" title="" data-original-title="Type the name of one or more recipes you want to build, separated by a space. You can also specify a task by appending a semicolon and a task name to the recipe name, like so: <code>busybox:clean</code>">
         </i>
         <div class="input-append">
-          <input type="text" class="input-xlarge build-target-input" placeholder="Type the recipe you want to build" autocomplete="off">
-            <button class="btn btn-primary build-button" data-project-id="{{project.id}}" disabled>Build
-            </button>
+          <form class="form-inline" style="margin-bottom: 0">
+            <input type="text" class="input-xlarge input-lg build-target-input" placeholder="Type the recipe you want to build" autocomplete="off" disabled>
+              <button class="btn btn-primary btn-large build-button" data-project-id="{{project.id}}" disabled>Build
+              </button>
+            </form>
           </div>
-        </form>
-      </li>
-    </ul>
+        </li>
+      </ul>
 </div>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 688a4c2..b43a01e 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2132,7 +2132,7 @@ if True:
                 prj = Project.objects.create_project(name = request.POST['projectname'], release = release)
                 prj.user_id = request.user.pk
                 prj.save()
-                return redirect(reverse(project, args=(prj.pk,)) + "#/newproject")
+                return redirect(reverse(project, args=(prj.pk,)) + "?notify=new-project")
 
             except (IntegrityError, BadParameterException) as e:
                 # fill in page with previously submitted values
@@ -2238,7 +2238,8 @@ if True:
         }
 
         if prj.release is not None:
-            context["prj"]["release"] = { "id": prj.release.pk, "name": prj.release.name, "desc": prj.release.description}
+            context['release'] = { "id": prj.release.pk, "name": prj.release.name, "description": prj.release.description}
+
 
         try:
             context["machine"] = {"name": prj.projectvariable_set.get(name="MACHINE").value}
-- 
2.1.4


