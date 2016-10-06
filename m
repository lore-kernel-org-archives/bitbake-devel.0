Return-Path: <brian.avery@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8858B71AA1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Oct 2016 00:07:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 05 Oct 2016 17:07:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,451,1473145200"; d="scan'208";a="1040898353"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2016 17:07:27 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Oct 2016 17:08:52 -0700
Message-Id: <cd4d3d865e12ea4113c8452ca57cc8d33a370af6.1475712223.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
References: <9be76de394b4a43c7dc6326545b33e2ee25b50e2.1475712223.git.brian.avery@intel.com>
In-Reply-To: <cover.1475712223.git.brian.avery@intel.com>
References: <cover.1475712223.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 4/6] toaster: importlayer Fix layer dependencies button state toggle
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

Fix regression introduced by switching typeahead library. Make sure we
enable and disable the add button based on whether the selection event
has fired or not.

[YOCTO #9936]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: bavery <brian.avery@intel.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 30 +++++--------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 570ca33..30dc282 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -21,21 +21,11 @@ function importLayerPageInit (ctx) {
                            libtoaster.ctx.layersTypeAheadUrl,
                            { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
+    layerDepBtn.removeAttr("disabled");
   });
 
-  // choices available in the typeahead
-  var layerDepsChoices = {};
-
-  // when the typeahead choices change, store an array of the available layer
-  // choices locally, to use for enabling/disabling the "Add layer" button
-  layerDepInput.on("typeahead-choices-change", function (event, data) {
-    layerDepsChoices = {};
-
-    if (data.choices) {
-      data.choices.forEach(function (item) {
-        layerDepsChoices[item.name] = item;
-      });
-    }
+  layerDepInput.on("typeahead:select", function(event, data){
+    currentLayerDepSelection = data;
   });
 
   // Disable local dir repo when page is loaded.
@@ -43,18 +33,8 @@ function importLayerPageInit (ctx) {
 
   // disable the "Add layer" button when the layer input typeahead is empty
   // or not in the typeahead choices
-  layerDepInput.on("input change", function () {
-    // get the choices from the typeahead
-    var choice = layerDepsChoices[$(this).val()];
-
-    if (choice) {
-      layerDepBtn.removeAttr("disabled");
-      currentLayerDepSelection = choice;
-    }
-    else {
-      layerDepBtn.attr("disabled","disabled");
-      currentLayerDepSelection = undefined;
-    }
+  layerDepInput.on("input change", function(){
+    layerDepBtn.attr("disabled","disabled");
   });
 
   /* We automatically add "openembedded-core" layer for convenience as a
-- 
1.9.1


