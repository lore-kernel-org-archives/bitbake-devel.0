Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 609F576538
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Aug 2015 16:24:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 06 Aug 2015 09:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,623,1432623600"; d="scan'208";a="537210581"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2015 09:24:02 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id EE0DD6A4083;
	Thu,  6 Aug 2015 09:23:14 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Aug 2015 19:23:49 +0300
Message-Id: <fa254ca1912d1c32221cf8ecdd6eb3224e5daca9.1438877744.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
References: <5d76198acb4ff2606733eecf82debb8b3221adba.1438877744.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438877744.git.ed.bartosh@linux.intel.com>
References: <cover.1438877744.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 4/4] bitbake: toastergui: layerBtn Fix build trigger mechanism
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
X-List-Received-Date: Thu, 06 Aug 2015 16:24:02 -0000

From: Michael Wood <michael.g.wood@intel.com>

The new project page is no longer responsible for triggering the build so
add a handler for this in layerBtn which is used in the layerdetails and
layers pages. This also removes the conflicting and  redundant handler
for this in the layerdetails.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/layerBtn.js     | 13 +++++++++++++
 bitbake/lib/toaster/toastergui/static/js/layerdetails.js |  8 --------
 bitbake/lib/toaster/toastergui/tables.py                 |  2 +-
 bitbake/lib/toaster/toastergui/templates/recipe_btn.html |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
index 4243c2b..a0509f9 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
@@ -55,6 +55,19 @@ function layerBtnsInit(ctx) {
     });
   });
 
+  $(".build-recipe-btn").unbind('click');
+  $(".build-recipe-btn").click(function(e){
+    e.preventDefault();
+    var recipe = $(this).data('recipe-name');
+
+    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
+      libtoaster.ctx.projectId, recipe,
+      function(){
+        /* Success */
+        window.location.replace(libtoaster.ctx.projectBuildsUrl);
+      });
+  });
+
   /* Setup the initial state of the buttons */
 
   for (var i in ctx.projectLayers){
diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index d12d3ae..3f5d7a9 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -179,14 +179,6 @@ function layerDetailsPageInit (ctx) {
       /* re run the machinesTabShow to update the text */
       targetsTabShow();
     }
-
-    $(".build-target-btn").unbind('click');
-    $(".build-target-btn").click(function(){
-      /* fire a build */
-      var target = $(this).data('target-name');
-      libtoaster.startABuild(ctx.projectBuildsUrl, libtoaster.ctx.projectId, target, null, null);
-      window.location.replace(libtoaster.ctx.projectPageUrl);
-    });
   });
 
   $("#machinestable").on('table-done', function(e, total, tableParams){
diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 51fe4b6..810e101 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -465,7 +465,7 @@ class LayerRecipesTable(RecipesTable):
                         field_name="get_description_or_summary")
 
 
-        build_recipe_template ='<button class="btn btn-block build-target-btn" data-target-name="{{data.name}}" {%if extra.in_prj == 0 %}disabled="disabled"{%endif%}>Build recipe</button>'
+        build_recipe_template ='<button class="btn btn-block build-recipe-btn" data-recipe-name="{{data.name}}" {%if extra.in_prj == 0 %}disabled="disabled"{%endif%}>Build recipe</button>'
 
         self.add_column(title="Build recipe",
                         static_data_name="add-del-layers",
diff --git a/bitbake/lib/toaster/toastergui/templates/recipe_btn.html b/bitbake/lib/toaster/toastergui/templates/recipe_btn.html
index d9ec3fa..77c1b23 100644
--- a/bitbake/lib/toaster/toastergui/templates/recipe_btn.html
+++ b/bitbake/lib/toaster/toastergui/templates/recipe_btn.html
@@ -1,6 +1,6 @@
-<a href="{% url 'project' extra.pid %}#/targetbuild={{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.pk}}" style="display:none; margin-top: 5px;" >
+<button data-recipe-name="{{data.name}}" class="btn btn-block layer-exists-{{data.layer_version.pk}} build-recipe-btn" style="display:none; margin-top: 5px;" >
   Build recipe
-</a>
+</button>
 <button class="btn btn-block layerbtn layer-add-{{data.layer_version.pk}}" data-layer='{ "id": {{data.layer_version.pk}}, "name":  "{{data.layer_version.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.layer_version.pk%}"}' data-directive="add">
   <i class="icon-plus"></i>
   Add layer
-- 
2.1.4


