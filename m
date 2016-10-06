Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5F05171A9B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 05 Oct 2016 17:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="1040898357"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:53 -0700
Message-Id: <e7c565f71fdfbae9a72f73c59175a2968a44c12d.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
References: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
In-Reply-To: <cover.1475712223.git.brian.avery@intel.com>
References: <cover.1475712223.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 5/6] toaster: Delete notification update front end implementation to design
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
X-List-Received-Date: Thu, 06 Oct 2016 00:07:26 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update the delete notifications to reflect feedback from design
review comments.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/api.py                       | 2 +-
 lib/toaster/toastergui/static/js/layerdetails.js    | 2 ++
 lib/toaster/toastergui/static/js/libtoaster.js      | 2 +-
 lib/toaster/toastergui/templates/base.html          | 2 +-
 lib/toaster/toastergui/templates/basebuildpage.html | 6 +++++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/api.py b/lib/toaster/toastergui/api.py
index b01d4ba..ae1f150 100644
--- a/lib/toaster/toastergui/api.py
+++ b/lib/toaster/toastergui/api.py
@@ -224,7 +224,7 @@ class XhrLayer(View):
 
         return JsonResponse({
             "error": "ok",
-            "gotoUrl": reverse('project', args=(kwargs['pid'],))
+            "gotoUrl": reverse('projectlayers', args=(kwargs['pid'],))
         })
 
 
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 4c0d042..9ead393 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -392,6 +392,8 @@ function layerDetailsPageInit (ctx) {
 
   $("#layer-delete-confirmed").click(function(){
 
+    $("#delete-layer-modal button[data-dismiss='modal']").hide();
+
     var message = $('<span>You have deleted <strong>1</strong> layer from your project: <strong id="deleted-layer-name"></strong>');
     message.find("#deleted-layer-name").text(ctx.layerVersion.name);
 
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 0832ba4..86662b7 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -342,7 +342,7 @@ var libtoaster = (function () {
   }
 
   function _showChangeNotification(message){
-    $(".alert").fadeOut().promise().done(function(){
+    $(".alert-dismissible").fadeOut().promise().done(function(){
       var alertMsg = $("#change-notification-msg");
 
       alertMsg.html(message);
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index c1b1417..496dd6e 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -74,7 +74,7 @@
     </div>
 
     <div id="change-notification" class="alert alert-info alert-dismissible change-notification" style="display:none">
-      <button type="button" class="close" id="hide-alert" data-dismiss="alert">&times;</button>
+      <button type="button" class="close" id="hide-alert" data-toggle="alert">&times;</button>
       <span id="change-notification-msg"></span>
     </div>
 
diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index 0b6ef56..f5eee96 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -28,6 +28,8 @@
             if (data.error !== "ok") {
               console.warn(data.error);
             } else {
+              libtoaster.setNotification("build-deleted",
+                $("#deleted-build-message").html());
              window.location.replace(data.gotoUrl);
             }
           },
@@ -61,7 +63,9 @@
   });
  </script>
 
-
+<span style="display:none" id="deleted-build-message">
+  You have deleted 1 build: <strong>{{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}}</strong> completed on <strong>{{build.completed_on|date:"d/m/y H:i"}}</strong>
+</span>
 
 <div class="modal fade" tabindex="-1" role="dialog" id="delete-build-modal" style="display: none;" data-backdrop="static" data-keyboard="false">
   <div class="modal-dialog">
-- 
1.9.1


