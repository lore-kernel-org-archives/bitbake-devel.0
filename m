Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id BA25C77055
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 11:10:15 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 14 Oct 2015 04:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; d="scan'208";a="792422051"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 14 Oct 2015 04:10:15 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 0DD196A4005;
	Wed, 14 Oct 2015 04:09:15 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 14:10:10 +0300
Message-Id: <1444821010-9830-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] toaster: importlayer Update property names for importlayer api calls
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
X-List-Received-Date: Wed, 14 Oct 2015 11:10:18 -0000

Update the property names used in checking for existing layers. The
server side API changed but not all references were updated.

[YOCTO #8300]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/importlayer.js | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/importlayer.js b/bitbake/lib/toaster/toastergui/static/js/importlayer.js
index 2fadbc0..c68f366 100644
--- a/bitbake/lib/toaster/toastergui/static/js/importlayer.js
+++ b/bitbake/lib/toaster/toastergui/static/js/importlayer.js
@@ -195,8 +195,8 @@ function importLayerPageInit (ctx) {
     var dupLayerInfo = $("#duplicate-layer-info");
     dupLayerInfo.find(".dup-layer-name").text(layer.name);
     dupLayerInfo.find(".dup-layer-link").attr("href", layer.layerdetailurl);
-    dupLayerInfo.find("#dup-layer-vcs-url").text(layer.layer__vcs_url);
-    dupLayerInfo.find("#dup-layer-revision").text(layer.revision.commit);
+    dupLayerInfo.find("#dup-layer-vcs-url").text(layer.vcs_url);
+    dupLayerInfo.find("#dup-layer-revision").text(layer.vcs_reference);
 
     $(".fields-apart-from-layer-name").fadeOut(function(){
 
@@ -214,11 +214,10 @@ function importLayerPageInit (ctx) {
       $.getJSON(libtoaster.ctx.layersTypeAheadUrl,
         { include_added: "true" , search: name, format: "json" },
         function(layer) {
-          if (layer.rows.length > 0) {
-            for (var i in layer.rows){
-              if (layer.rows[i].name == name) {
-                console.log(layer.rows[i])
-                layerExistsError(layer.rows[i]);
+          if (layer.results.length > 0) {
+            for (var i in layer.results){
+              if (layer.results[i].name == name) {
+                layerExistsError(layer.results[i]);
               }
             }
           }
-- 
2.1.4


