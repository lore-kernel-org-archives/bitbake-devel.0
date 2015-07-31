Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id EC2DA765C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:35 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 31 Jul 2015 05:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="533657539"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 05:09:36 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id E54346A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:08:50 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:05 +0300
Message-Id: <f531f053c4e7d235ccff75cb4f81e9b827a00f5a.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 04/22] bitbake: toastergui: importlayer Add format type to JSON calls
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

After API was changed we now need to pass the parameter "format=json" as
a get parameter when requesting a json payload. Otherwise we get the
html version of the page instead of the data we need.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index e9d7ae8..df48e84 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -28,9 +28,11 @@ function importLayerPageInit (ctx) {
   /* We automatically add "openembedded-core" layer for convenience as a
    * dependency as pretty much all layers depend on this one
    */
-  $.getJSON(libtoaster.ctx.projectLayersUrl, { include_added: "true" , search: "openembedded-core" }, function(layer) {
-    if (layer.list.length == 1) {
-      currentLayerDepSelection = layer.list[0];
+  $.getJSON(libtoaster.ctx.projectLayersUrl,
+    { include_added: "true" , search: "openembedded-core", format: "json" },
+    function(layer) {
+    if (layer.rows.length > 0) {
+      currentLayerDepSelection = layer.rows[0];
       layerDepBtn.click();
     }
   });
@@ -211,16 +213,18 @@ function importLayerPageInit (ctx) {
       var name = $(this).val();
 
       /* Check if the layer name exists */
-      $.getJSON(libtoaster.ctx.projectLayersUrl, { include_added: "true" , search: name }, function(layer) {
-      if (layer.list.length > 0) {
-        for (var i in layer.list){
-          if (layer.list[i].name == name) {
-            console.log(layer.list[i])
-            layerExistsError(layer.list[i]);
+      $.getJSON(libtoaster.ctx.projectLayersUrl,
+        { include_added: "true" , search: name, format: "json" },
+        function(layer) {
+          if (layer.list.length > 0) {
+            for (var i in layer.list){
+              if (layer.list[i].name == name) {
+                console.log(layer.list[i])
+                layerExistsError(layer.list[i]);
+              }
+            }
           }
-        }
-      }
-    });
+      });
   });
 
   vcsURLInput.on('input', function() {
-- 
2.1.4


