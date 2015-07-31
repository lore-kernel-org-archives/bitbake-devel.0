Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 963FD73D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:38 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 31 Jul 2015 05:09:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="775177436"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 31 Jul 2015 05:09:39 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 3B39B6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:53 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:07 +0300
Message-Id: <af49e13a210e54d671988115757654fd77a2a5ff.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 06/22] bitbake: toastergui: Standardise the layer object property layerdetailurl
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

To be able to use the utility functions in libtoaster  we need to have a
single property name for the value that represents the url for the
layer details in the layer object.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js    |  6 +++---
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  4 ++--
 lib/toaster/toastergui/tables.py                   |  7 +++++--
 lib/toaster/toastergui/templates/layer_btn.html    |  4 ++--
 lib/toaster/toastergui/templates/layerdetails.html |  2 +-
 lib/toaster/toastergui/templates/machine_btn.html  |  2 +-
 lib/toaster/toastergui/templates/recipe_btn.html   |  2 +-
 lib/toaster/toastergui/views.py                    | 14 ++++++++++++--
 9 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index df48e84..560e25a 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -50,7 +50,7 @@ function importLayerPageInit (ctx) {
     newLayerDep.children("span").tooltip();
 
     var link = newLayerDep.children("a");
-    link.attr("href", currentLayerDepSelection.layerDetailsUrl);
+    link.attr("href", currentLayerDepSelection.layerdetailurl);
     link.text(currentLayerDepSelection.name);
     link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
 
@@ -65,10 +65,10 @@ function importLayerPageInit (ctx) {
 
     $("#layer-deps-list").append(newLayerDep);
 
-    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerDetailsUrl, function (data){
+    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerdetailurl, function (data){
         /* These are the dependencies of the layer added as a dependency */
         if (data.list.length > 0) {
-          currentLayerDepSelection.url = currentLayerDepSelection.layerDetailsUrl;
+          currentLayerDepSelection.url = currentLayerDepSelection.layerdetailurl;
           layerDeps[currentLayerDepSelection.id].deps = data.list;
         }
 
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index e522373..291ed98 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -78,7 +78,7 @@ function layerDetailsPageInit (ctx) {
       newLayerDep.children("span").tooltip();
 
       var link = newLayerDep.children("a");
-      link.attr("href", currentLayerDepSelection.layerDetailsUrl);
+      link.attr("href", currentLayerDepSelection.layerdetailurl);
       link.text(currentLayerDepSelection.name);
       link.tooltip({title: currentLayerDepSelection.tooltip, placement: "right"});
 
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 667aca2..0000c57 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -225,7 +225,7 @@ var libtoaster = (function (){
   function _addRmLayer(layerObj, add, doneCb){
     if (add === true) {
       /* If adding get the deps for this layer */
-      libtoaster.getLayerDepsForProject(layerObj.url,
+      libtoaster.getLayerDepsForProject(layerObj.layerdetailurl,
         function (layers) {
 
         /* got result for dependencies */
@@ -285,7 +285,7 @@ var libtoaster = (function (){
     }
 
     alertMsg.children("#layer-affected-name").text(layer.name);
-    alertMsg.children("#layer-affected-name").attr("href", layer.url);
+    alertMsg.children("#layer-affected-name").attr("href", layer.layerdetailurl);
     alertMsg.children("#project-affected-name").text(libtoaster.ctx.projectName);
     alertMsg.children("#project-affected-name").attr("href", libtoaster.ctx.projectPageUrl);
 
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 146a8dd..782ae80 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -193,7 +193,7 @@ class LayersTable(ToasterTable):
         project = Project.objects.get(pk=kwargs['pid'])
         self.add_column(title="LayerDetailsUrl",
                         displayable = False,
-                        field_name="layerDetailsUrl",
+                        field_name="layerdetailurl",
                         computation = lambda x: reverse('layerdetails', args=(project.id, x.id)))
 
 
@@ -208,7 +208,10 @@ class LayerDetails(ToasterTemplateView):
         context['layerversion'] = Layer_Version.objects.get(pk=kwargs['layerid'])
         context['layerdict'] = _lv_to_dict(context['project'], context['layerversion'])
         context['layerdeps'] = {"list": [
-            [{"id": y.id, "name": y.layer.name} for y in x.depends_on.get_equivalents_wpriority(context['project'])][0] for x in context['layerversion'].dependencies.all()]}
+            [ {"id": y.id,
+               "name": y.layer.name,
+               "layerdetailurl": reverse('layerdetails', args=(kwargs['pid'], y.id)),
+              } for y in x.depends_on.get_equivalents_wpriority(context['project'])][0] for x in context['layerversion'].dependencies.all()]}
         context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
 
         self.context_entries = ['project', 'layerversion', 'projectlayers', 'layerdict', 'layerdeps']
diff --git a/lib/toaster/toastergui/templates/layer_btn.html b/lib/toaster/toastergui/templates/layer_btn.html
index 6672017..a2e9393 100644
--- a/lib/toaster/toastergui/templates/layer_btn.html
+++ b/lib/toaster/toastergui/templates/layer_btn.html
@@ -1,8 +1,8 @@
-<button class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn" style="display:none;" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "url": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="remove" >
+<button class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn" style="display:none;" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="remove" >
   <i class="icon-trash"></i>
   Delete layer
 </button>
-<button class="btn btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "url": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add">
+<button class="btn btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add">
   <i class="icon-plus"></i>
   Add layer
 </button>
diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 6269b36..2f875eb 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -55,7 +55,7 @@
       {% else %}
         inCurrentPrj : false,
       {% endif %}
-        url : "{% url 'layerdetails' project.id layerversion.id  %}",
+        layerdetailurl : "{% url 'layerdetails' project.id layerversion.id  %}",
         sourceId: {{layerversion.layer_source_id|json}},
       }
     };
diff --git a/lib/toaster/toastergui/templates/machine_btn.html b/lib/toaster/toastergui/templates/machine_btn.html
index fffb536..54ff5de 100644
--- a/lib/toaster/toastergui/templates/machine_btn.html
+++ b/lib/toaster/toastergui/templates/machine_btn.html
@@ -1,6 +1,6 @@
 <a href="{% url 'project' extra.pid %}#/machineselect={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.id}}" style="margin-top: 5px; display:none">
   Select machine</a>
-<button class="btn btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "url": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add">
+<button class="btn btn-block layerbtn layer-add-{{data.layer_version.id}}" data-layer='{ "id": {{data.layer_version.id}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.id %}"}' data-directive="add">
   <i class="icon-plus"></i>
   Add layer
   <i title="" class="icon-question-sign get-help" data-original-title="To enable this machine, you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
diff --git a/lib/toaster/toastergui/templates/recipe_btn.html b/lib/toaster/toastergui/templates/recipe_btn.html
index 1c7c58c..d9ec3fa 100644
--- a/lib/toaster/toastergui/templates/recipe_btn.html
+++ b/lib/toaster/toastergui/templates/recipe_btn.html
@@ -1,7 +1,7 @@
 <a href="{% url 'project' extra.pid %}#/targetbuild={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.pk}}" style="display:none; margin-top: 5px;" >
   Build recipe
 </a>
-<button class="btn btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "url": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add">
+<button class="btn btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add">
   <i class="icon-plus"></i>
   Add layer
   <i title="" class="icon-question-sign get-help" data-original-title="To build this target, you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9c63aae..9e89714 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2434,7 +2434,8 @@ if True:
                             continue
 
                         if prj_layer_created:
-                            layers_added.append({'id': layer_dep_obj.id, 'name': Layer.objects.get(id=layer_dep_obj.layer_id).name})
+                            layerdepdetailurl = reverse('layerdetails', args=(prj.id, layer_dep_obj.pk))
+                            layers_added.append({'id': layer_dep_obj.id, 'name': Layer.objects.get(id=layer_dep_obj.layer_id).name, 'layerdetailurl': layerdepdetailurl })
 
 
                 # If an old layer version exists in our project then remove it
@@ -2453,8 +2454,17 @@ if True:
 
                 return HttpResponse(jsonfilter({"error": "Uncaught error: Could not create layer version"}), content_type = "application/json")
 
+        layerdetailurl = reverse('layerdetails', args=(prj.id, layer_version.pk))
 
-        return HttpResponse(jsonfilter({"error": "ok", "imported_layer" : { "name" : layer.name, "id": layer_version.id },  "deps_added": layers_added }), content_type = "application/json")
+        json_response = {"error": "ok",
+                         "imported_layer" : {
+                           "name" : layer.name,
+                           "id": layer_version.id,
+                           "layerdetailurl": layerdetailurl,
+                         },
+                         "deps_added": layers_added }
+
+        return HttpResponse(jsonfilter(json_response), content_type = "application/json")
 
     def xhr_updatelayer(request):
 
-- 
2.1.4


