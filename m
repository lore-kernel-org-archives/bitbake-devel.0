Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 45DF060807
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 11:00:26 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga105.fm.intel.com with ESMTP; 26 Sep 2016 04:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,399,1470726000"; d="scan'208";a="766007887"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2016 04:00:28 -0700
Received: from ed.fi.intel.com (ed.fi.intel.com [10.237.72.179])
	by linux.intel.com (Postfix) with ESMTP id 6A94B6A4006
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Sep 2016 04:00:01 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Sep 2016 13:59:32 +0300
Message-Id: <38ee52641c1503bab6fb697c9e80d8068832095c.1474887106.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1474887106.git.ed.bartosh@linux.intel.com>
References: <cover.1474887106.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 05/10] toaster: alerts and modals Avoid modals and alerts overlaying each other
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
X-List-Received-Date: Mon, 26 Sep 2016 11:00:27 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make sure that when we spawn a modal we clear any notifications and also
make sure that old notifications are cleared before showing a new one.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/layerDepsModal.js | 12 ++++++++++--
 lib/toaster/toastergui/static/js/libtoaster.js     | 13 ++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerDepsModal.js b/lib/toaster/toastergui/static/js/layerDepsModal.js
index b79049e..e962224 100644
--- a/lib/toaster/toastergui/static/js/layerDepsModal.js
+++ b/lib/toaster/toastergui/static/js/layerDepsModal.js
@@ -6,7 +6,12 @@
  * addToProject: Whether to add layers to project on accept
  * successAdd: function to run on success
  */
-function showLayerDepsModal(layer, dependencies, title, body, addToProject, successAdd) {
+function showLayerDepsModal(layer,
+                            dependencies,
+                            title,
+                            body,
+                            addToProject,
+                            successAdd) {
 
   if ($("#dependencies-modal").length === 0) {
     $.get(libtoaster.ctx.htmlUrl + "/layer_deps_modal.html", function(html){
@@ -43,7 +48,10 @@ function showLayerDepsModal(layer, dependencies, title, body, addToProject, succ
 
     $("#dependencies-modal").data("deps", dependencies);
 
-    $('#dependencies-modal').modal('show');
+    /* Clear any alert notifications before showing the modal */
+    $(".alert").fadeOut(function(){
+      $('#dependencies-modal').modal('show');
+    });
 
     /* Discard the old submission function */
     $("#dependencies-modal-form").unbind('submit');
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 8e2221d..0832ba4 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -342,10 +342,12 @@ var libtoaster = (function () {
   }
 
   function _showChangeNotification(message){
-    var alertMsg = $("#change-notification-msg");
+    $(".alert").fadeOut().promise().done(function(){
+      var alertMsg = $("#change-notification-msg");
 
-    alertMsg.html(message);
-    $("#change-notification, #change-notification *").fadeIn();
+      alertMsg.html(message);
+      $("#change-notification, #change-notification *").fadeIn();
+    });
   }
 
   function _createCustomRecipe(name, baseRecipeId, doneCb){
@@ -716,6 +718,11 @@ $(document).ready(function() {
       });
     }
 
+    /* Make sure we don't have a notification overlay a modal */
+    $(".modal").on('show.bs.modal', function(){
+      $(".alert-dismissible").fadeOut();
+    });
+
     if (libtoaster.debug) {
       check_for_duplicate_ids();
     } else {
-- 
2.6.6


