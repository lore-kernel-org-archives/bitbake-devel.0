Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 9619275772
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 02:43:59 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so133661706pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=N6D92IvWTbi+/Z5G5AGDw/L6fj/lQQqCaWtFzsjAO1Q=;
	b=SWxn9Lz6/W1eNVPxtY1A47BULt5hpFaNt6s1M1pVjW6z+bTG49A6YG628lEterWC5+
	ClO1wCN0qI91xRs3ekN8d91TwtarvJ7Z+1cItsS3oL+Bk/ZqdAZF56eK/899LHp61pfC
	kmkAjo3NAWavqLC3NQ211b/aNrN8YAmy7VMe5EYUx9ZLl27wwfethK/KYCSlofLWlCDm
	JQD4arlmPp2e5w7UbQHKTiDxUXr0zh0seZPKZXmkPliHc3us7UPgarDxn70jr0NsNk8A
	l8crv1q8M4yvb2wJSXU0MAqaQIrAdwsHKbAgHJR2PRyveANTcnJvavQbarKmFl62fwFN
	YNBg==
X-Received: by 10.68.135.69 with SMTP id pq5mr28779996pbb.162.1442889839488;
	Mon, 21 Sep 2015 19:43:59 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	hh3sm27169029pbc.8.2015.09.21.19.43.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Sep 2015 19:43:58 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 19:45:24 -0700
Message-Id: <ec86eb34207710bb71d02bc2cbd0f9b66558b417.1442889863.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1442889863.git.avery.brian@gmail.com>
References: <cover.1442889863.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toaster: layerdetails Fix back button tab behaviour
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
X-List-Received-Date: Tue, 22 Sep 2015 02:43:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

This completes the behaviour fix of the back button in the layerdetails
page as we not only have parameters in our history we also have the hash
to indicate which tab is active. As we pop our history we need to show
the corresponding tab.

[YOCTO #8252]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js | 28 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 000e803..8817b47 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -7,6 +7,9 @@ function layerDetailsPageInit (ctx) {
   var layerDepsList = $("#layer-deps-list");
   var currentLayerDepSelection;
   var addRmLayerBtn = $("#add-remove-layer-btn");
+  var targetTab = $("#targets-tab");
+  var machineTab = $("#machines-tab");
+  var detailsTab = $("#details-tab");
 
   /* setup the dependencies typeahead */
   libtoaster.makeTypeahead(layerDepInput, libtoaster.ctx.layersTypeAheadUrl, { include_added: "true" }, function(item){
@@ -15,6 +18,21 @@ function layerDetailsPageInit (ctx) {
     layerDepBtn.removeAttr("disabled");
   });
 
+  $(window).on('hashchange', function(e){
+    switch(window.location.hash){
+      case '#machines':
+        machineTab.tab('show');
+        break;
+      case '#recipes':
+        targetTab.tab('show');
+        break;
+      default:
+        detailsTab.tab('show');
+        break;
+    }
+  });
+
+
   $(".breadcrumb li:first a").click(function(e){
     e.preventDefault();
     /* By default this link goes to the project configuration page. However
@@ -143,7 +161,7 @@ function layerDetailsPageInit (ctx) {
       addRmLayerBtn.removeClass("btn-danger");
   }
 
-  $("#details-tab").on('show', function(){
+  detailsTab.on('show', function(){
     if (!ctx.layerVersion.inCurrentPrj)
       defaultAddBtnText();
 
@@ -174,7 +192,7 @@ function layerDetailsPageInit (ctx) {
       $("#no-recipes-yet").hide();
     }
 
-    $("#targets-tab").removeClass("muted");
+    targetTab.removeClass("muted");
     if (window.location.hash === "#recipes"){
       /* re run the machinesTabShow to update the text */
       targetsTabShow();
@@ -189,7 +207,7 @@ function layerDetailsPageInit (ctx) {
     else
       $("#no-machines-yet").hide();
 
-    $("#machines-tab").removeClass("muted");
+    machineTab.removeClass("muted");
     if (window.location.hash === "#machines"){
       /* re run the machinesTabShow to update the text */
       machinesTabShow();
@@ -202,7 +220,7 @@ function layerDetailsPageInit (ctx) {
 
   });
 
-  $("#targets-tab").on('show', targetsTabShow);
+  targetTab.on('show', targetsTabShow);
 
   function machinesTabShow(){
     if (!ctx.layerVersion.inCurrentPrj) {
@@ -219,7 +237,7 @@ function layerDetailsPageInit (ctx) {
     window.location.hash = "machines";
   }
 
-  $("#machines-tab").on('show', machinesTabShow);
+  machineTab.on('show', machinesTabShow);
 
   $(".pagesize").change(function(){
     var search = libtoaster.parseUrlParams();
-- 
1.9.1


