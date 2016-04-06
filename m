Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id CBA90770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:27 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id n3so71349751wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=EQ6zJ9UjrsqTYnWKze73ezORgkugoD+jg9T51cic8vk=;
	b=SfpKwprnpM6zeXUCdjEPiNErdkXMta+8jjpp7weB86PsanW7CUYZMJQnvEE2RYjmQ8
	GK7eBa2D/Sii5XWE0U358KMMscoN2yQ8JsktsvRWLUKjro8U/a94GExKHptbtW0YUZX9
	UZQUViw6rB4WUaBb8lx4QyN8XiETEXsLmfGgCN90FpUJA3wT4ifF+LSwxpWQwBOG2wP+
	k34ZGziRs1BAxuTgmChR89sgluhMHiIkXch7uW85bHcBcJqmMjcKBQiAlrILFE4oErIB
	OwLWhZoMHbAo4ACycLKRwr3a7JfNFL5y+Ja112U2TIhpAQp5S4/UbBYq5CQCXFojSROA
	ACCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=EQ6zJ9UjrsqTYnWKze73ezORgkugoD+jg9T51cic8vk=;
	b=PZMm77GCb1U3/igHl2cW29qa71+fM27YSu0p6WCCaJX06IaahGkGu8UlsScsI5i+zY
	TSTrIr9pT0YcFU+OS7zIzWNLCMuQMgZMya5L2VN3QxehD9uv9YeaDpP9wD2WNJqJ9akv
	dVLSo2V9/8NIMyC8QbQXuHT9zdD9j1PTNisUkrBKQHYannnQXND0qGlQCSDz1aFtumSQ
	l6UTuYbsobCZQAQHUHrEz1m2UjoR/QIRAq2K5iSAJDKZT5Bvt3OZlEO6gbmnQM6hZlIY
	W3tQCLaBxjESd9Skn0cbfPRSnAu711XTN/pmlnB3KLNAKgz9QSXzmSClhEl3AByOsDKx
	99Vg==
X-Gm-Message-State: AD7BkJIrOx1176AEXBRE6W2zwS7WTh7W7F7vTgKkN1YLvdOlPjlSxqDHtD4ZwWTlAu4OzJle
X-Received: by 10.194.216.227 with SMTP id ot3mr24595020wjc.69.1459961248356; 
	Wed, 06 Apr 2016 09:47:28 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.27
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:27 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:32 +0100
Message-Id: <7738c40592fa0e2a2c3702a420ec6bb6a5c14507.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 22/38] toaster: libtoaster Update implementation of startABuild and cancelABuild
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:28 -0000

Update the implementation of startABuild and cancelAbuild to reflect
changes to the backend api. We now have a dedicated endpoint to make
calls into so add this url to libtoaster.ctx and allow passing null in
as a url value to indicate that we want to use the current project

Also:
 - Fix some documentation comments
 - Add the convenience of passing in an array of targets to startABuild

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/customrecipe.js  |  4 +--
 lib/toaster/toastergui/static/js/layerBtn.js      |  3 +-
 lib/toaster/toastergui/static/js/libtoaster.js    | 41 ++++++++++++++---------
 lib/toaster/toastergui/static/js/projectpage.js   |  4 +--
 lib/toaster/toastergui/static/js/projecttopbar.js |  6 ++--
 lib/toaster/toastergui/static/js/recipedetails.js |  4 +--
 lib/toaster/toastergui/templates/base.html        |  1 +
 7 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/customrecipe.js b/lib/toaster/toastergui/static/js/customrecipe.js
index f1b8afb..a31c268 100644
--- a/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/lib/toaster/toastergui/static/js/customrecipe.js
@@ -267,9 +267,7 @@ function customRecipePageInit(ctx) {
 
   /* Trigger a build of your custom image */
   $(".build-custom-image").click(function(){
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
-      libtoaster.ctx.projectId,
-      ctx.recipe.name,
+    libtoaster.startABuild(null, ctx.recipe.name,
       function(){
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
     });
diff --git a/lib/toaster/toastergui/static/js/layerBtn.js b/lib/toaster/toastergui/static/js/layerBtn.js
index b2666ab..aa43284 100644
--- a/lib/toaster/toastergui/static/js/layerBtn.js
+++ b/lib/toaster/toastergui/static/js/layerBtn.js
@@ -60,8 +60,7 @@ function layerBtnsInit() {
     e.preventDefault();
     var recipe = $(this).data('recipe-name');
 
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
-      libtoaster.ctx.projectId, recipe,
+    libtoaster.startABuild(null, recipe,
       function(){
         /* Success */
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index b6b49b6..8d1d20f 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -90,27 +90,35 @@ var libtoaster = (function (){
     jQElement.data('typeahead').render = customRenderFunc;
   }
 
-  /*
-   * url - the url of the xhr build */
-  function _startABuild (url, project_id, targets, onsuccess, onfail) {
+  /* startABuild:
+   * url: xhr_buildrequest or null for current project
+   * targets: an array or space separated list of targets to build
+   * onsuccess: callback for successful execution
+   * onfail: callback for failed execution
+   */
+  function _startABuild (url, targets, onsuccess, onfail) {
 
-    var data = {
-      project_id : project_id,
-      targets : targets,
+    if (!url)
+      url = libtoaster.ctx.xhrBuildRequestUrl;
+
+    /* Flatten the array of targets into a space spearated list */
+    if (targets instanceof Array){
+      targets = targets.reduce(function(prevV, nextV){
+        return prev + ' ' + next;
+      });
     }
 
     $.ajax( {
         type: "POST",
         url: url,
-        data: data,
+        data: { 'targets' : targets },
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
-          /* No proper reponse YOCTO #7995
           if (_data.error !== "ok") {
             console.warn(_data.error);
-          } else { */
+          } else {
             if (onsuccess !== undefined) onsuccess(_data);
-        //  }
+          }
         },
         error: function (_data) {
           console.warn("Call failed");
@@ -120,22 +128,25 @@ var libtoaster = (function (){
   }
 
   /* cancelABuild:
-   * url: projectbuilds
-   * builds_ids: space separated list of build request ids
+   * url: xhr_buildrequest url or null for current project
+   * buildRequestIds: space separated list of build request ids
    * onsuccess: callback for successful execution
    * onfail: callback for failed execution
    */
-  function _cancelABuild(url, build_ids, onsuccess, onfail){
+  function _cancelABuild(url, buildRequestIds, onsuccess, onfail){
+    if (!url)
+      url = libtoaster.ctx.xhrBuildRequestUrl;
+
     $.ajax( {
         type: "POST",
         url: url,
-        data: { 'buildCancel': build_ids },
+        data: { 'buildCancel': buildRequestIds },
         headers: { 'X-CSRFToken' : $.cookie('csrftoken')},
         success: function (_data) {
           if (_data.error !== "ok") {
             console.warn(_data.error);
           } else {
-            if (onsuccess !== undefined) onsuccess(_data);
+            if (onsuccess) onsuccess(_data);
           }
         },
         error: function (_data) {
diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 6655a18..3013416 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -232,9 +232,7 @@ function projectPageInit(ctx) {
 
     toBuild = toBuild.trim();
 
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
-      libtoaster.ctx.projectId,
-      toBuild,
+    libtoaster.startABuild(null, toBuild,
       function(){
         /* Build request started */
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
diff --git a/lib/toaster/toastergui/static/js/projecttopbar.js b/lib/toaster/toastergui/static/js/projecttopbar.js
index 58a32a0..b09f974 100644
--- a/lib/toaster/toastergui/static/js/projecttopbar.js
+++ b/lib/toaster/toastergui/static/js/projecttopbar.js
@@ -82,9 +82,9 @@ function projectTopBarInit(ctx) {
     selectedTarget = { name: newBuildTargetInput.val() };
 
     /* Fire off the build */
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
-      null, selectedTarget.name, function(){
-      window.location.replace(libtoaster.ctx.projectBuildsUrl);
+    libtoaster.startABuild(null, selectedTarget.name,
+      function(){
+        window.location.replace(libtoaster.ctx.projectBuildsUrl);
     }, null);
   });
 }
diff --git a/lib/toaster/toastergui/static/js/recipedetails.js b/lib/toaster/toastergui/static/js/recipedetails.js
index 2bfd0a4..d5f9eac 100644
--- a/lib/toaster/toastergui/static/js/recipedetails.js
+++ b/lib/toaster/toastergui/static/js/recipedetails.js
@@ -42,9 +42,7 @@ function recipeDetailsPageInit(ctx){
 
   /* Trigger a build of your custom image */
   $(".build-recipe-btn").click(function(){
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
-      libtoaster.ctx.projectId,
-      ctx.recipe.name,
+    libtoaster.startABuild(null, ctx.recipe.name,
       function(){
         window.location.replace(libtoaster.ctx.projectBuildsUrl);
     });
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 121a75c..192f9fb 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -47,6 +47,7 @@
         projectBuildsUrl: {% url 'projectbuilds' project.id as pburl %}{{pburl|json}},
         xhrCustomRecipeUrl : "{% url 'xhr_customrecipe' %}",
         projectId : {{project.id}},
+        xhrBuildRequestUrl: "{% url 'xhr_buildrequest' project.id %}",
         {% else %}
         projectId : undefined,
         projectPageUrl : undefined,
-- 
2.1.4


