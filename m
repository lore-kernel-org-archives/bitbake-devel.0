Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id F08247702A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:54 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Oct 2015 02:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373710"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:55 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:42 +0100
Message-Id: <407673b7783835902abf3f65e91ef7283a3a44a7.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
References: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444383025.git.elliot.smith@intel.com>
References: <cover.1444383025.git.elliot.smith@intel.com>
Subject: [PATCH 4/5] toaster: Fix stale layer state buttons
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:55 -0000

From: Michael Wood <michael.g.wood@intel.com>

Move the "is available to the project" state computation to the template
for the Layer add/remove buttons, Recipe build/Add layer as done for the
Package add/remove. This is more reliable as we can get an inconsistent
state on the front end JS as there are many opportunities for hitting
out of date project information.

[YOCTO #8294]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/layerBtn.js       |  9 +--------
 lib/toaster/toastergui/static/js/table.js          |  2 +-
 lib/toaster/toastergui/static/js/tests/test.js     |  2 +-
 lib/toaster/toastergui/tables.py                   |  7 ++++---
 lib/toaster/toastergui/templates/layer_btn.html    | 12 ++++++++++--
 lib/toaster/toastergui/templates/recipe_btn.html   | 12 ++++++++++--
 lib/toaster/toastergui/templates/toastertable.html |  1 -
 7 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index da0241c..7318b3f 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -1,6 +1,6 @@
 "use strict";
 
-function layerBtnsInit(ctx) {
+function layerBtnsInit() {
 
   /* Remove any current bindings to avoid duplicated binds */
   $(".layerbtn").unbind('click');
@@ -80,11 +80,4 @@ function layerBtnsInit(ctx) {
     imgCustomModal.data('recipe', $(this).data('recipe'));
     imgCustomModal.modal('show');
   });
-
-  /* Setup the initial state of the buttons */
-
-  for (var i in ctx.projectLayers){
-      $(".layer-exists-" + ctx.projectLayers[i]).show();
-      $(".layer-add-" + ctx.projectLayers[i]).hide();
-  }
 }
diff --git a/lib/toaster/toastergui/static/js/table.js b/lib/toaster/toastergui/static/js/table.js
index bc81e67..40b5022 100644
--- a/lib/toaster/toastergui/static/js/table.js
+++ b/lib/toaster/toastergui/static/js/table.js
@@ -130,7 +130,7 @@ function tableInit(ctx){
       tableBody.append(row);
 
       /* If we have layerbtns then initialise them */
-      layerBtnsInit(ctx);
+      layerBtnsInit();
 
       /* If we have popovers initialise them now */
       $('td > a.btn').popover({
diff --git a/lib/toaster/toastergui/static/js/tests/test.js b/lib/toaster/toastergui/static/js/tests/test.js
index d610113..f0df6e4 100644
--- a/lib/toaster/toastergui/static/js/tests/test.js
+++ b/lib/toaster/toastergui/static/js/tests/test.js
@@ -152,7 +152,7 @@ QUnit.test("Layer details page init", function(assert){
 });
 
 QUnit.test("Layer btns init", function(assert){
-  assert.throws(layerBtnsInit({ projectLayers : [] }));
+  assert.throws(layerBtnsInit());
 });
 
 QUnit.test("Table init", function(assert){
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 4f24772..b10445b 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -57,9 +57,7 @@ class LayersTable(ToasterTable):
         context = super(LayersTable, self).get_context_data(**kwargs)
 
         project = Project.objects.get(pk=kwargs['pid'])
-
         context['project'] = project
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
 
         return context
 
@@ -93,7 +91,10 @@ class LayersTable(ToasterTable):
 
     def setup_queryset(self, *args, **kwargs):
         prj = Project.objects.get(pk = kwargs['pid'])
-        compatible_layers = prj.compatible_layerversions()
+        compatible_layers = prj.get_all_compatible_layer_versions()
+
+        self.static_context_extra['current_layers'] = \
+                prj.get_project_layer_versions(pk=True)
 
         self.queryset = compatible_layers.order_by(self.default_orderby)
 
diff --git a/lib/toaster/toastergui/templates/layer_btn.html b/lib/toaster/toastergui/templates/layer_btn.html
index a2e9393..314eec7 100644
--- a/lib/toaster/toastergui/templates/layer_btn.html
+++ b/lib/toaster/toastergui/templates/layer_btn.html
@@ -1,8 +1,16 @@
-<button class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn" style="display:none;" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="remove" >
+<button class="btn btn-danger btn-block layer-exists-{{data.pk}} layerbtn"  data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="remove"
+    {% if data.pk not in extra.current_layers %}
+    style="display:none;"
+    {% endif %}
+  >
   <i class="icon-trash"></i>
   Delete layer
 </button>
-<button class="btn btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add">
+<button class="btn btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add"
+    {% if data.pk in extra.current_layers %}
+    style="display:none;"
+    {% endif %}
+  >
   <i class="icon-plus"></i>
   Add layer
 </button>
diff --git a/lib/toaster/toastergui/templates/recipe_btn.html b/lib/toaster/toastergui/templates/recipe_btn.html
index 77c1b23..baab06e 100644
--- a/lib/toaster/toastergui/templates/recipe_btn.html
+++ b/lib/toaster/toastergui/templates/recipe_btn.html
@@ -1,7 +1,15 @@
-<button data-recipe-name="{{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.pk}} build-recipe-btn" style="display:none; margin-top: 5px;" >
+<button data-recipe-name="{{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.pk}} build-recipe-btn" style="margin-top: 5px;
+  {% if data.layer_version.pk not in extra.current_layers %}
+    display:none;
+  {% endif %}"
+ >
   Build recipe
 </button>
-<button class="btn btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add">
+<button class="btn btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add"
+    {% if data.layer_version.pk in extra.current_layers %}
+     style="display:none;"
+    {% endif %}
+>
   <i class="icon-plus"></i>
   Add layer
   <i title="" class="icon-question-sign get-help" data-original-title="To build this target, you must first add the {{data.layer_version.layer.name}} layer to your project"></i>
diff --git a/lib/toaster/toastergui/templates/toastertable.html b/lib/toaster/toastergui/templates/toastertable.html
index 9ef4c6f..98a715f 100644
--- a/lib/toaster/toastergui/templates/toastertable.html
+++ b/lib/toaster/toastergui/templates/toastertable.html
@@ -12,7 +12,6 @@
       tableName : "{{table_name}}",
       url : "{{ xhr_table_url }}?format=json",
       title : "{{title}}",
-      projectLayers : {{projectlayers|json}},
     };
 
     try {
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


