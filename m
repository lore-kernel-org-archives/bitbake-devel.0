Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 1FBB573556
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:26 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id hi2so26731266wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=1TkX4ttaUIk6JXrYnTMSRndZxFQFuDT0kVki3zSYn54=;
	b=JNXYhO2ZstxnF5BjDdg52PPMGHIx6vlG0D63aDTKR4nW5r51nVZdeB87MHqiMw1gpa
	DzdXZ0dq417X3yQo8m1QPkx48vDk/5J6murBfvUwbyIZiAettkxJejYS4BzlKmMx39En
	sA51XSbpOWldTCYl33kTVn20EOANTcEVQIhQJVl04eJw0O8+w6M8NQZl9f6Zb7/8vDtB
	pj+hLWEnIUPB79SfxaBejn8tqQbRAcYrXqKrzRtBkFWUiLi008kXaFY2ElHM4I6WcuZZ
	oLfZUlyvdTEApz1HD3S3rCHKR8m67LxrlorR5mNhebjS3qQzogfB66YLBpHcdW7iRCpi
	aPzw==
X-Gm-Message-State: ALoCoQkkSDGllTicXedHL5ueh5pMRkL7LOFjGgj1PKC59o57uN5RLWUe5nNY39zH5jXJAIwaXUyd
X-Received: by 10.180.210.203 with SMTP id mw11mr49340044wic.53.1424109207439; 
	Mon, 16 Feb 2015 09:53:27 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id qb8sm17745919wjc.4.2015.02.16.09.53.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:26 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 3977A5605A7; Mon, 16 Feb 2015 17:53:28 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:17 +0000
Message-Id: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 01/10] toaster: Use on input event for validation rather than keyup
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:27 -0000

From: Michael Wood <michael.g.wood@intel.com>

Avoid using keyup event to trigger form validation as this won't fire
for events such as pasting or autofill from the browser.

[YOCTO #7292]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js          | 4 ++--
 lib/toaster/toastergui/static/js/importlayer.js   | 6 +++---
 lib/toaster/toastergui/static/js/layerdetails.js  | 2 +-
 lib/toaster/toastergui/templates/newproject.html  | 2 +-
 lib/toaster/toastergui/templates/projectconf.html | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 619ad28..0302b80 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -71,13 +71,13 @@ function basePageInit (ctx) {
     /* Any typing in the input apart from enter key is going to invalidate
      * the value that has been set by selecting a suggestion from the typeahead
      */
-    newBuildProjectInput.keyup(function(event) {
+    newBuildProjectInput.on('input', function(event) {
         if (event.keyCode == 13)
           return;
         newBuildProjectSaveBtn.attr("disabled", "disabled");
     });
 
-    newBuildTargetInput.keyup(function() {
+    newBuildTargetInput.on('input', function() {
       if ($(this).val().length == 0)
         newBuildTargetBuildBtn.attr("disabled", "disabled");
       else
diff --git a/lib/toaster/toastergui/static/js/importlayer.js b/lib/toaster/toastergui/static/js/importlayer.js
index d6e140f..e782bda 100644
--- a/lib/toaster/toastergui/static/js/importlayer.js
+++ b/lib/toaster/toastergui/static/js/importlayer.js
@@ -245,15 +245,15 @@ function importLayerPageInit (ctx) {
       enable_import_btn(true);
   }
 
-  vcsURLInput.keyup(function() {
+  vcsURLInput.on('input', function() {
     check_form();
   });
 
-  gitRefInput.keyup(function() {
+  gitRefInput.on('input', function() {
     check_form();
   });
 
-  layerNameInput.keyup(function() {
+  layerNameInput.on('input', function() {
     if ($(this).val() && !validLayerName.test($(this).val())){
       layerNameCtrl.addClass("error")
       $("#invalid-layer-name-hint").show();
diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 99552de..2e713d5 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -353,7 +353,7 @@ function layerDetailsPageInit (ctx) {
   });
 
   /* Disable the change button when we have no data in the input */
-  $("dl input, dl textarea").keyup(function() {
+  $("dl input, dl textarea").on("input",function() {
     if ($(this).val().length == 0)
       $(this).parent().children(".change-btn").attr("disabled", "disabled");
     else
diff --git a/lib/toaster/toastergui/templates/newproject.html b/lib/toaster/toastergui/templates/newproject.html
index 0265564..dcb6590 100644
--- a/lib/toaster/toastergui/templates/newproject.html
+++ b/lib/toaster/toastergui/templates/newproject.html
@@ -72,7 +72,7 @@
             $('.btn-primary').attr('disabled', 'disabled');
 
             // enable submit button when all required fields are populated
-            $("input#new-project-name").keyup(function() {
+            $("input#new-project-name").on('input', function() {
                 if ($("input#new-project-name").val().length > 0 ){
                     $('.btn-primary').removeAttr('disabled');
                     $(".help-inline").css('visibility','hidden');
diff --git a/lib/toaster/toastergui/templates/projectconf.html b/lib/toaster/toastergui/templates/projectconf.html
index edcad18..0d38a92 100644
--- a/lib/toaster/toastergui/templates/projectconf.html
+++ b/lib/toaster/toastergui/templates/projectconf.html
@@ -269,7 +269,7 @@
                 });
             });
 
-            $(".js-new-config_var").keyup(function(){
+            $(".js-new-config_var").on('input', function(){
                 if ($(this).val().length == 0) {
                     $(".js-apply-change-config_var").attr("disabled","disabled");
                 }
@@ -386,7 +386,7 @@
                 });
             });
 
-            $("#new-distro").keyup(function(){
+            $("#new-distro").on('input', function(){
                 if ($(this).val().length == 0) {
                     $("#apply-change-distro").attr("disabled","disabled");
                 }
@@ -469,7 +469,7 @@
                 });
             });
 
-            $("#new-image_install").keyup(function(){
+            $("#new-image_install").on('input', function(){
                 if ($(this).val().length == 0) {
                     $("#apply-change-image_install").attr("disabled","disabled");
                 }
@@ -629,7 +629,7 @@
             });
 
             //activate / deactivate save added variable button
-            $("#variable, #value").keyup(function() {
+            $("#variable, #value").on('input', function() {
                 if ( $("#variable").val().length > 0  && $("#value").val().trim().length > 0 ) {
                     $(".save").removeAttr("disabled");
                 }
-- 
1.9.1


