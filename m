Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 8411F73D5B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:43 +0000 (UTC)
Received: by wizk4 with SMTP id k4so197983305wiz.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+lmnNWIGOSK2i01wJRfyHQIQys836etSS/JGTYo5Zxc=;
	b=kJt4cN8I57ZhOjpm3rkR5RxfXGFvDsvgd9G6sMm286WVMJ8pBcYudl3L1eHDFTwTwf
	Y+sUzPujsA5xxoJUnZkXoj+gGWnTMXBPEQA1jRkfvezzkzAifgaMHE/+tB2R8Va8Cnon
	xSkaN2xVIb9Yb8O7XGnmbQGjC7lZNZz9r30FbbGyttLs8BpO+OtGzLuRnS/Ko8vjs7BN
	a02l1KoOCFXxDyIumuck5GcEqBXAkZd+yHFWVJFkveg7gEZWcJPAW0YG0CqUb49l5gpq
	2VBw6rAc6VVZ/MJ3/e6g3WHpKcS9Jr8fnFuJMPE4ol4w0TOOJhKSLhXVq9qQ6zHvXM+y
	L/8w==
X-Gm-Message-State: ALoCoQkZqQqDhRH1pxEi8fic1p6nbn+xlD1srYV98ycSu0+XZRHVv05GkVxrNbmCXagG4AL1Bkbi
X-Received: by 10.180.102.74 with SMTP id fm10mr5931475wib.25.1429195664158;
	Thu, 16 Apr 2015 07:47:44 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dg8sm10722287wjc.9.2015.04.16.07.47.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BAC5C560A13; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:34 +0100
Message-Id: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Subject: [PATCH 1/8] toaster: base.js minor jshint fixes
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

Fixing errors identified by jshint, some missing semicolons and
preference for === operator. Also pass the urldata in libtoaster as an
object rather than constructing a query string.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js       | 19 +++++++++----------
 lib/toaster/toastergui/static/js/libtoaster.js |  9 ++++-----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 777ab43..241c5d2 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -6,7 +6,7 @@ function basePageInit (ctx) {
   /* Hide the button if we're on the project,newproject or importlyaer page
    * or if there are no projects yet defined
    */
-  if (ctx.numProjects == 0 || ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
+  if (ctx.numProjects === 0 || ctx.currentUrl.search('newproject|project/\\d/$|importlayer/$') > 0){
       newBuildButton.hide();
       return;
   }
@@ -18,17 +18,17 @@ function basePageInit (ctx) {
 
   newBuildButton.show().removeAttr("disabled");
 
-  _checkProjectBuildable()
+  _checkProjectBuildable();
   _setupNewBuildButton();
 
 
   function _checkProjectBuildable(){
-    if (ctx.projectId == undefined)
+    if (ctx.projectId === undefined)
       return;
 
     libtoaster.getProjectInfo(ctx.projectInfoUrl, ctx.projectId,
       function(data){
-        if (data.machine.name == undefined || data.layers.length == 0) {
+        if (data.machine.name === undefined || data.layers.length === 0) {
           /* we can't build anything with out a machine and some layers */
           $("#new-build-button #targets-form").hide();
           $("#new-build-button .alert").show();
@@ -51,7 +51,7 @@ function basePageInit (ctx) {
     /* If we don't have a current project then present the set project
      * form.
      */
-    if (ctx.projectId == undefined) {
+    if (ctx.projectId === undefined) {
       $('#change-project-form').show();
       $('#project .icon-pencil').hide();
     }
@@ -72,13 +72,13 @@ function basePageInit (ctx) {
      * the value that has been set by selecting a suggestion from the typeahead
      */
     newBuildProjectInput.on('input', function(event) {
-        if (event.keyCode == 13)
+        if (event.keyCode === 13)
           return;
         newBuildProjectSaveBtn.attr("disabled", "disabled");
     });
 
     newBuildTargetInput.on('input', function() {
-      if ($(this).val().length == 0)
+      if ($(this).val().length === 0)
         newBuildTargetBuildBtn.attr("disabled", "disabled");
       else
         newBuildTargetBuildBtn.removeAttr("disabled");
@@ -96,7 +96,7 @@ function basePageInit (ctx) {
     });
 
     newBuildProjectSaveBtn.click(function() {
-      ctx.projectId = selectedProject.id
+      ctx.projectId = selectedProject.id;
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
       newBuildTargetInput.data('typeahead').options.xhrParams.project_id = ctx.projectId;
@@ -131,6 +131,5 @@ function basePageInit (ctx) {
     $(".new-build").click (function(event) {
       event.stopPropagation();
     });
-  };
-
+  }
 }
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index fcf82ac..ae9e455 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -67,12 +67,11 @@ var libtoaster = (function (){
   /*
    * url - the url of the xhr build */
   function _startABuild (url, project_id, targets, onsuccess, onfail) {
-    var data;
 
-    if (project_id)
-      data = 'project_id='+project_id+'&targets='+targets;
-    else
-      data = 'targets='+targets;
+    var data = {
+      project_id : project_id,
+      targets : targets,
+    }
 
     $.ajax( {
         type: "POST",
-- 
1.9.1


