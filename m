Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id AE40A765D3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 31 Jul 2015 05:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="739515522"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 31 Jul 2015 05:09:48 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 863EC6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:03 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:16 +0300
Message-Id: <6fb70a53d3247dcae65e2f78c0b02c74f4c0f427.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 15/22] bitbake: toastergui: Fix Duplicate layer importlayer api calls
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

As the JSON response changed the duplicate layer functionality wasn't
wasn't working as the field names in the returned data changed. This
patch brings the field names back in sync with the response.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 03274c0..50bc4dd 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -195,8 +195,8 @@ function importLayerPageInit (ctx) {
     var dupLayerInfo = $("#duplicate-layer-info");
     dupLayerInfo.find(".dup-layer-name").text(layer.name);
     dupLayerInfo.find(".dup-layer-link").attr("href", layer.layerdetailurl);
-    dupLayerInfo.find("#dup-layer-vcs-url").text(layer.giturl);
-    dupLayerInfo.find("#dup-layer-revision").text(layer.revision);
+    dupLayerInfo.find("#dup-layer-vcs-url").text(layer.layer__vcs_url);
+    dupLayerInfo.find("#dup-layer-revision").text(layer.revision.commit);
 
     $(".fields-apart-from-layer-name").fadeOut(function(){
 
@@ -214,11 +214,11 @@ function importLayerPageInit (ctx) {
       $.getJSON(libtoaster.ctx.projectLayersUrl,
         { include_added: "true" , search: name, format: "json" },
         function(layer) {
-          if (layer.list.length > 0) {
-            for (var i in layer.list){
-              if (layer.list[i].name == name) {
-                console.log(layer.list[i])
-                layerExistsError(layer.list[i]);
+          if (layer.rows.length > 0) {
+            for (var i in layer.rows){
+              if (layer.rows[i].name == name) {
+                console.log(layer.rows[i])
+                layerExistsError(layer.rows[i]);
               }
             }
           }
-- 
2.1.4


