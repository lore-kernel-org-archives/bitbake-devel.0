Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B35E277254
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 14:26:56 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 25 Feb 2016 06:26:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="911115716"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.2.6])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2016 06:26:56 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 14:26:54 +0000
Message-Id: <1456410414-32085-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: change 'delete layer' to 'remove layer'
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
X-List-Received-Date: Thu, 25 Feb 2016 14:26:57 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

I have received quite a few complaints about the use of the word
'delete' for layer removal, so change it to 'remove'. That also matches
the language we use for packages in image customisation.

[YOCTO #9165]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/layerBtn.js       | 2 +-
 bitbake/lib/toaster/toastergui/static/js/layerdetails.js   | 2 +-
 bitbake/lib/toaster/toastergui/static/js/libtoaster.js     | 2 +-
 bitbake/lib/toaster/toastergui/static/js/projectpage.js    | 6 +++---
 bitbake/lib/toaster/toastergui/tables.py                   | 4 ++--
 bitbake/lib/toaster/toastergui/templates/layer_btn.html    | 2 +-
 bitbake/lib/toaster/toastergui/templates/layerdetails.html | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
index 7318b3f..b2666ab 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerBtn.js
@@ -42,7 +42,7 @@ function layerBtnsInit() {
           });
         });
       } else {
-        notification.text("1 layer deleted");
+        notification.text("1 layer removed");
         /* Deleting a layer we only hanlde the one button */
         thisBtn.fadeOut(function(){
           notification.fadeIn().delay(500).fadeOut(function(){
diff --git a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
index 663b3c6..d545406 100644
--- a/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/bitbake/lib/toaster/toastergui/static/js/layerdetails.js
@@ -243,7 +243,7 @@ function layerDetailsPageInit (ctx) {
       $(".select-machine-btn").removeAttr("disabled");
       addRmLayerBtn.addClass("btn-danger");
       addRmLayerBtn.data('directive', "remove");
-      addRmLayerBtn.text(" Delete the "+ctx.layerVersion.name+" layer from your project");
+      addRmLayerBtn.text(" Remove the "+ctx.layerVersion.name+" layer from your project");
       addRmLayerBtn.prepend("<span class=\"icon-trash\"></span>");
 
     } else {
diff --git a/bitbake/lib/toaster/toastergui/static/js/libtoaster.js b/bitbake/lib/toaster/toastergui/static/js/libtoaster.js
index a3858ec..b6b49b6 100644
--- a/bitbake/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/bitbake/lib/toaster/toastergui/static/js/libtoaster.js
@@ -316,7 +316,7 @@ var libtoaster = (function (){
     } else if (layerDepsList.length === 0 && add === true) {
       alertMsg = $("<span>You have added <strong>1</strong> layer to your project: <a id=\"layer-affected-name\"></a></span></span>");
     } else if (add === false) {
-      alertMsg = $("<span>You have deleted <strong>1</strong> layer from your project: <a id=\"layer-affected-name\"></a></span>");
+      alertMsg = $("<span>You have removed <strong>1</strong> layer from your project: <a id=\"layer-affected-name\"></a></span>");
     }
 
     alertMsg.children("#layer-affected-name").text(layer.name);
diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index 0666bde..292ceb7 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -1,4 +1,4 @@
-"use strict";
+
 
 function projectPageInit(ctx) {
 
@@ -145,7 +145,7 @@ function projectPageInit(ctx) {
     for (var i in layers){
       var layerObj = layers[i];
 
-      var projectLayer = $("<li><a></a><span class=\"icon-trash\" data-toggle=\"tooltip\" title=\"Delete\"></span></li>");
+      var projectLayer = $("<li><a></a><span class=\"icon-trash\" data-toggle=\"tooltip\" title=\"Remove\"></span></li>");
 
       projectLayer.data('layer', layerObj);
       projectLayer.children("span").tooltip();
@@ -393,7 +393,7 @@ function projectPageInit(ctx) {
     /* Layers removed */
     if (layersToRm && layersToRm.length > 0){
       if (layersToRm.length == 1)
-        li = '<li><strong>1</strong> layer deleted: '+layersToRm[0].name+'</li>';
+        li = '<li><strong>1</strong> layer removed: '+layersToRm[0].name+'</li>';
       else
         li = '<li><strong>'+layersToRm.length+'</strong> layers deleted: '+layersDelList+'</li>';
 
diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index 9115309..71892e2 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -183,8 +183,8 @@ class LayersTable(ToasterTable):
                         static_data_name="dependencies",
                         static_data_template=deps_template)
 
-        self.add_column(title="Add | Delete",
-                        help_text="Add or delete layers to / from your project",
+        self.add_column(title="Add | Remove",
+                        help_text="Add or remove layers to / from your project",
                         hideable=False,
                         filter_name="in_current_project",
                         static_data_name="add-del-layers",
diff --git a/bitbake/lib/toaster/toastergui/templates/layer_btn.html b/bitbake/lib/toaster/toastergui/templates/layer_btn.html
index 314eec7..10de37d 100644
--- a/bitbake/lib/toaster/toastergui/templates/layer_btn.html
+++ b/bitbake/lib/toaster/toastergui/templates/layer_btn.html
@@ -4,7 +4,7 @@
     {% endif %}
   >
   <i class="icon-trash"></i>
-  Delete layer
+  Remove layer
 </button>
 <button class="btn btn-block layer-add-{{data.pk}} layerbtn" data-layer='{ "id": {{data.pk}}, "name":  "{{data.layer.name}}", "layerdetailurl": "{%url 'layerdetails' extra.pid data.pk%}"}' data-directive="add"
     {% if data.pk in extra.current_layers %}
diff --git a/bitbake/lib/toaster/toastergui/templates/layerdetails.html b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
index 61ae52c..f960061 100644
--- a/bitbake/lib/toaster/toastergui/templates/layerdetails.html
+++ b/bitbake/lib/toaster/toastergui/templates/layerdetails.html
@@ -106,7 +106,7 @@
       {% else %}
       <button id="add-remove-layer-btn" data-directive="remove" class="btn btn-block btn-large btn-danger">
         <span class="icon-trash"></span>
-        Delete the {{layerversion.layer.name}} layer from your project
+        Remove the {{layerversion.layer.name}} layer from your project
       </button>
       {% endif %}
     </span>
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


