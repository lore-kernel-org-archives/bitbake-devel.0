Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A5D12765C5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 19:46:52 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 04 Aug 2015 12:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,610,1432623600"; d="scan'208";a="619261999"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 04 Aug 2015 12:46:53 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 833FB6A4083;
	Tue,  4 Aug 2015 12:46:06 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 22:46:34 +0300
Message-Id: <45cce14756e2d1f87d72587c5e3a6899540366de.1438717072.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
References: <691696f2b87d41540b14b10ef08762f8529b4909.1438717072.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438717072.git.ed.bartosh@linux.intel.com>
References: <cover.1438717072.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/12] bitbake: toastergui: Switch to using the new toaster typeahead widget
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
X-List-Received-Date: Tue, 04 Aug 2015 19:46:52 -0000

From: Michael Wood <michael.g.wood@intel.com>

Switch the existing typeahead inputs to use the new typeahead widget.
This means we have a defined mechanism and end point for typeaheads
which meets the design specification.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js         | 26 ++++++++++++++++--------
 lib/toaster/toastergui/static/js/importlayer.js  | 12 +++++------
 lib/toaster/toastergui/static/js/layerdetails.js |  2 +-
 lib/toaster/toastergui/static/js/libtoaster.js   |  5 ++---
 lib/toaster/toastergui/static/js/projectpage.js  |  4 ++--
 lib/toaster/toastergui/templates/base.html       |  8 +++++---
 lib/toaster/toastergui/views.py                  |  6 ++++--
 7 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index f253361..eba9c16 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -89,8 +89,8 @@ function basePageInit(ctx) {
   }
 
   /* If we have a project setup the typeahead */
-  if (selectedProject.projectTargetsUrl){
-    libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
+  if (selectedProject.recipesTypeAheadUrl){
+    libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.recipesTypeAheadUrl, { format: "json" }, function (item) {
       selectedTarget = item;
       newBuildTargetBuildBtn.removeAttr("disabled");
     });
@@ -156,7 +156,7 @@ function basePageInit(ctx) {
       $('#project .icon-pencil').hide();
     }
 
-    libtoaster.makeTypeahead(newBuildProjectInput, selectedProject.projectsUrl, { format : "json" }, function (item) {
+    libtoaster.makeTypeahead(newBuildProjectInput, selectedProject.projectsTypeAheadUrl, { format : "json" }, function (item) {
       /* successfully selected a project */
       newBuildProjectSaveBtn.removeAttr("disabled");
       selectedProject = item;
@@ -180,13 +180,21 @@ function basePageInit(ctx) {
 
       newBuildTargetInput.removeAttr("disabled");
 
-      /* Update the typeahead to use the new selectedProject */
-      libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
-        /* successfully selected a target */
-        selectedTarget = item;
-        newBuildTargetBuildBtn.removeAttr("disabled");
-      });
+      /* We've got a new project so now we need to update the
+       * target urls. We can get this from the new project's info
+       */
+      $.getJSON(selectedProject.projectPageUrl, { format: "json" },
+        function(projectInfo){
+          /* Update the typeahead to use the new selectedProject */
+          selectedProject = projectInfo;
+
+          libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.recipesTypeAheadUrl, { format: "json" }, function (item) {
+              /* successfully selected a target */
+              selectedTarget = item;
+              newBuildTargetBuildBtn.removeAttr("disabled");
+          });
 
+      });
       newBuildTargetInput.val("");
 
       /* set up new form aspect */
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 50bc4dd..2fadbc0 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -16,7 +16,7 @@ function importLayerPageInit (ctx) {
   var currentLayerDepSelection;
   var validLayerName = /^(\w|-)+$/;
 
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.projectLayersUrl, { include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
@@ -26,11 +26,11 @@ function importLayerPageInit (ctx) {
   /* We automatically add "openembedded-core" layer for convenience as a
    * dependency as pretty much all layers depend on this one
    */
-  $.getJSON(libtoaster.ctx.projectLayersUrl,
-    { include_added: "true" , search: "openembedded-core", format: "json" },
+  $.getJSON(libtoaster.ctx.layersTypeAheadUrl,
+    { include_added: "true" , search: "openembedded-core" },
     function(layer) {
-    if (layer.rows.length > 0) {
-      currentLayerDepSelection = layer.rows[0];
+    if (layer.results.length > 0) {
+      currentLayerDepSelection = layer.results[0];
       layerDepBtn.click();
     }
   });
@@ -211,7 +211,7 @@ function importLayerPageInit (ctx) {
       var name = $(this).val();
 
       /* Check if the layer name exists */
-      $.getJSON(libtoaster.ctx.projectLayersUrl,
+      $.getJSON(libtoaster.ctx.layersTypeAheadUrl,
         { include_added: "true" , search: name, format: "json" },
         function(layer) {
           if (layer.rows.length > 0) {
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index be6bbcd..96372f0 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -9,7 +9,7 @@ function layerDetailsPageInit (ctx) {
   var addRmLayerBtn = $("#add-remove-layer-btn");
 
   /* setup the dependencies typeahead */
-  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.projectLayersUrl, { include_added: "true" }, function(item){
+  libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
 
     layerDepBtn.removeAttr("disabled");
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 22377f0..51054c7 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -19,14 +19,13 @@ var libtoaster = (function (){
     jQElement.typeahead({
         source: function(query, process){
           xhrParams.search = query;
-          xhrParams.format = "json";
           $.getJSON(xhrUrl, this.options.xhrParams, function(data){
             if (data.error !== "ok") {
               console.log("Error getting data from server "+data.error);
               return;
             }
 
-            return process (data.rows);
+            return process(data.results);
           });
         },
         updater: function(item) {
@@ -40,7 +39,7 @@ var libtoaster = (function (){
             return 0;
           }
 
-          return ~item.name.toLowerCase().indexOf(this.query.toLowerCase());
+          return 1;
         },
         highlighter: function (item) {
           if (item.hasOwnProperty('detail'))
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index b7cb074..b82f740 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -98,7 +98,7 @@ function projectPageInit(ctx) {
 
   /* Add/Rm layer functionality */
 
-  libtoaster.makeTypeahead(layerAddInput, libtoaster.ctx.projectLayersUrl, { include_added: "false" }, function(item){
+  libtoaster.makeTypeahead(layerAddInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "false" }, function(item){
     currentLayerAddSelection = item;
     layerAddBtn.removeAttr("disabled");
   });
@@ -251,7 +251,7 @@ function projectPageInit(ctx) {
     machineNameTitle.text(machineName);
   }
 
-  libtoaster.makeTypeahead(machineChangeInput, libtoaster.ctx.projectMachinesUrl, { }, function(item){
+  libtoaster.makeTypeahead(machineChangeInput, libtoaster.ctx.machinesTypeAheadUrl, { }, function(item){
     currentMachineAddSelection = item;
     machineChangeBtn.removeAttr("disabled");
   });
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index c16fd65..cd4269d 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -32,14 +32,16 @@
         jsUrl : "{% static 'js/' %}",
         htmlUrl : "{% static 'html/' %}",
         projectsUrl : "{% url 'all-projects' %}",
+        projectsTypeAheadUrl: {% url 'xhr_projectstypeahead' as prjurl%}{{prjurl|json}},
         {% if project.id %}
         projectId : {{project.id}},
         projectPageUrl : {% url 'project' project.id as purl%}{{purl|json}},
         projectName : {{project.name|json}},
-        projectTargetsUrl: {% url 'projectavailabletargets' project.id as paturl%}{{paturl|json}},
+        recipesTypeAheadUrl: {% url 'xhr_recipestypeahead' project.id as paturl%}{{paturl|json}},
+        layersTypeAheadUrl: {% url 'xhr_layerstypeahead' project.id as paturl%}{{paturl|json}},
+        machinesTypeAheadUrl: {% url 'xhr_machinestypeahead' project.id as paturl%}{{paturl|json}},
+
         projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
-        projectLayersUrl: {% url 'projectlayers' project.id as plurl %}{{plurl|json}},
-        projectMachinesUrl: {% url 'projectmachines' project.id as pmurl %}{{pmurl|json}},
         projectId : {{project.id}},
         {% else %}
         projectId : undefined,
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b43a01e..b7bfb9a 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2235,6 +2235,8 @@ if True:
             "freqtargets": freqtargets[:5],
             "releases": map(lambda x: {"id": x.pk, "name": x.name, "description":x.description}, Release.objects.all()),
             "project_html": 1,
+            "recipesTypeAheadUrl": reverse('xhr_recipestypeahead', args=(prj.pk,)),
+            "projectBuildsUrl": reverse('projectbuilds', args=(prj.pk,)),
         }
 
         if prj.release is not None:
@@ -2784,9 +2786,9 @@ if True:
         for p in project_info.object_list:
             p.id = p.pk
             p.projectPageUrl = reverse('project', args=(p.id,))
-            p.projectLayersUrl = reverse('projectlayers', args=(p.id,))
+            p.layersTypeAheadUrl = reverse('xhr_layerstypeahead', args=(p.id,))
+            p.recipesTypeAheadUrl = reverse('xhr_recipestypeahead', args=(p.id,))
             p.projectBuildsUrl = reverse('projectbuilds', args=(p.id,))
-            p.projectTargetsUrl = reverse('projectavailabletargets', args=(p.id,))
 
         # build view-specific information; this is rendered specifically in the builds page, at the top of the page (i.e. Recent builds)
         build_mru = _get_latest_builds()
-- 
2.1.4


