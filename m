Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
	[209.85.212.181])
	by mail.openembedded.org (Postfix) with ESMTP id 5F30775909
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:40:16 +0000 (UTC)
Received: by wigg3 with SMTP id g3so50876949wig.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Mi+KoRL2cKzbWebnwLuhy0wXLz58Rtb4DbXmxlmfkEY=;
	b=RWFVM13udKdaMS/TKnZ/YgrCdL/iuoEq7Odbru7984N8Rp16rA82ZVp8v/iwqusLTR
	nvy9zPnyd2jjjllTNZloD/w3xSVIp0IobJ/vDgLJimPnvPaE7cssE7BMd4sTUJlprTfA
	DPuv3LGuaHUGgYDhCOC2SxzrEGEQ4Mz7K+zVVur/gnkHx8wGecUdgc21vcnYsa2DWc20
	vxwU9sezA9IgRWSZB2drAe6Wizxdp0lZMtgrjrq3z2zmL+3IPHM3yoG8WLqn+dOOc59Q
	jnWBuZqz+rJLol8MltDGrUdhbhuVQo8cQwbHajlccUwb9PUqmeqSEAVI7rNYWaCRYppN
	Wotg==
X-Gm-Message-State: ALoCoQk+irnzjBQ9nezMkK1iJKN+ulXpb4ZW5tUnBqjhJyCHAnQ4wCr0IoQCAD+lEuF5ltL/+3IS
X-Received: by 10.180.77.136 with SMTP id s8mr9047614wiw.7.1433947217468;
	Wed, 10 Jun 2015 07:40:17 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fi6sm8256319wib.6.2015.06.10.07.40.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:40:16 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2AF11561274; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:07 +0100
Message-Id: <937665bd57dad04dd6bb46d06488b699f5c54d29.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 19/19] toastergui: prevent contamination of libtoaster context
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
X-List-Received-Date: Wed, 10 Jun 2015 14:40:16 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch modifies the New Build button to use a local
copy of the default libtoaster project context in order
to prevent page contamination when a different project is
selected in the drop-down menu.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 38 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 06d0676..d079f23 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -11,7 +11,8 @@ function basePageInit(ctx) {
     return;
   }
 
-  var currentProjectId = libtoaster.ctx.projectId;
+  var selectedProject = libtoaster.ctx;
+  var selectedTarget;
 
   /* Hide the change project icon when there is only one project */
   if (ctx.numProjects === 1) {
@@ -27,18 +28,16 @@ function basePageInit(ctx) {
   var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
 
 
-  var selectedTarget;
-
   _checkProjectBuildable();
   _setupNewBuildButton();
 
 
   function _checkProjectBuildable() {
-    if (libtoaster.ctx.projectId === undefined) {
+    if (selectedProject.projectId === undefined) {
       return;
     }
 
-    libtoaster.getProjectInfo(libtoaster.ctx.projectPageUrl,
+    libtoaster.getProjectInfo(selectedProject.projectPageUrl,
       function (data) {
         if (data.machine.name === undefined || data.layers.length === 0) {
           /* we can't build anything with out a machine and some layers */
@@ -52,9 +51,14 @@ function basePageInit(ctx) {
           newBuildTargetInput.prop("disabled", false);
           newBuildTargetBuildBtn.prop("disabled", false);
 
-          libtoaster.makeTypeahead(newBuildTargetInput, libtoaster.ctx.projectTargetsUrl, { format: "json" }, function (item) {
+          libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
             /* successfully selected a target */
-            selectedTarget = item;
+            selectedProject.projectPageUrl = item.projectPageUrl;
+            selectedProject.projectName = item.name;
+            selectedProject.projectId = item.id;
+            selectedProject.projectBuildsUrl = item.projectBuildsUrl;
+
+
           });
 
         }
@@ -63,18 +67,17 @@ function basePageInit(ctx) {
 
   function _setupNewBuildButton() {
     /* Setup New build button */
-    var selectedProject;
 
     /* If we don't have a current project then present the set project
      * form.
      */
-    if (libtoaster.ctx.projectId === undefined) {
+    if (selectedProject.projectId === undefined) {
       $('#change-project-form').show();
       $('#project .icon-pencil').hide();
     }
 
 
-    libtoaster.makeTypeahead(newBuildProjectInput, libtoaster.ctx.projectsUrl, { format : "json" }, function (item) {
+    libtoaster.makeTypeahead(newBuildProjectInput, selectedProject.projectsUrl, { format : "json" }, function (item) {
       /* successfully selected a project */
       newBuildProjectSaveBtn.removeAttr("disabled");
       selectedProject = item;
@@ -107,23 +110,18 @@ function basePageInit(ctx) {
         selectedTarget = { name: newBuildTargetInput.val() };
       }
       /* fire and forget */
-      libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl, libtoaster.ctx.projectId, selectedTarget.name, null, null);
-      window.location.replace(libtoaster.ctx.projectPageUrl);
+      libtoaster.startABuild(selectedProject.projectBuildsUrl, selectedProject.projectId, selectedTarget.name, null, null);
+      window.location.replace(selectedProject.projectPageUrl);
     });
 
     newBuildProjectSaveBtn.click(function () {
-      libtoaster.ctx.projectId = selectedProject.pk;
+      selectedProject.projectId = selectedProject.pk;
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
 
       /* we set the effective context of the page to the currently selected project */
       /* TBD: do we override even if we already have a context project ?? */
       /* TODO: replace global library context with references to the "selected" project */
-      libtoaster.ctx.projectPageUrl = selectedProject.projectPageUrl;
-      libtoaster.ctx.projectName = selectedProject.name;
-      libtoaster.ctx.projectId = selectedProject.id;
-
-      ctx.projectBuildsUrl = selectedProject.projectBuildsUrl;
 
       /* we can create a target typeahead only after we have a project selected */
       newBuildTargetInput.prop("disabled", false);
@@ -137,8 +135,8 @@ function basePageInit(ctx) {
       newBuildTargetInput.val("");
 
       /* set up new form aspect */
-      $("#new-build-button #project a").text(selectedProject.name).attr('href', libtoaster.ctx.projectPageUrl);
-      $("#new-build-button .alert a").attr('href', libtoaster.ctx.projectPageUrl);
+      $("#new-build-button #project a").text(selectedProject.name).attr('href', selectedProject.projectPageUrl);
+      $("#new-build-button .alert a").attr('href', selectedProject.projectPageUrl);
       $("#project .icon-pencil").show();
 
       $("#change-project-form").slideUp({ 'complete' : function () {
-- 
1.9.1


