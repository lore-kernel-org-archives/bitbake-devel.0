Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 17A9F7ED4E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Oct 2019 23:19:30 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x91NJVN1007990
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 1 Oct 2019 16:19:31 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.209.225) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.468.0; Tue, 1 Oct 2019 16:19:24 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 1 Oct 2019 16:17:50 -0700
Message-ID: <247eb8a652145bddf9703718b1c068ef0502ba06.1569971660.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1569971660.git.David.Reyna@windriver.com>
References: <cover.1569971660.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.209.225]
Subject: [PATCH 1/2] toaster: issues in import layer when clicking 'add layer'
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
X-List-Received-Date: Tue, 01 Oct 2019 23:19:30 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

There were three issues in this one bug.
  1) The Add Layer button allows empty layers
  2) The internal XHR URL was wrong, which caused a hidden AJAX error
     and did not correctly complete the action nor disable the button
     after an add.
  3) There was a race condition between typing in the dependent layer
     select text box (which would normally disable the add button), and
     the typeahead pull-down selection (which would normally enable the
     add button). This forced the user to select the typedahead layer twice.

[YOCTO #13385]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/js/importlayer.js | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index 2964839..8e2032d 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -17,11 +17,15 @@ function importLayerPageInit (ctx) {
   var currentLayerDepSelection;
   var validLayerName = /^(\w|-)+$/;
 
+  /* Catch 'disable' race condition between type-ahead started and "input change" */
+  var typeAheadStarted = 0;
+
   libtoaster.makeTypeahead(layerDepInput,
                            libtoaster.ctx.layersTypeAheadUrl,
                            { include_added: "true" }, function(item){
     currentLayerDepSelection = item;
     layerDepBtn.removeAttr("disabled");
+    typeAheadStarted = 1;
   });
 
   layerDepInput.on("typeahead:select", function(event, data){
@@ -34,7 +38,10 @@ function importLayerPageInit (ctx) {
   // disable the "Add layer" button when the layer input typeahead is empty
   // or not in the typeahead choices
   layerDepInput.on("input change", function(){
-    layerDepBtn.attr("disabled","disabled");
+    if (0 == typeAheadStarted) {
+      layerDepBtn.attr("disabled","disabled");
+    }
+    typeAheadStarted = 0;
   });
 
   /* We automatically add "openembedded-core" layer for convenience as a
@@ -50,6 +57,7 @@ function importLayerPageInit (ctx) {
   });
 
   layerDepBtn.click(function(){
+    typeAheadStarted = 0;
     if (currentLayerDepSelection == undefined)
       return;
 
@@ -77,7 +85,7 @@ function importLayerPageInit (ctx) {
 
     $("#layer-deps-list").append(newLayerDep);
 
-    libtoaster.getLayerDepsForProject(currentLayerDepSelection.layerdetailurl,
+    libtoaster.getLayerDepsForProject(currentLayerDepSelection.xhrLayerUrl,
                                       function (data){
         /* These are the dependencies of the layer added as a dependency */
         if (data.list.length > 0) {
-- 
1.9.1


