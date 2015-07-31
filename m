Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7D38F7660E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 31 Jul 2015 05:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="739515599"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 31 Jul 2015 05:09:58 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 7D05A6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:13 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:23 +0300
Message-Id: <d9e5330375aa02aff3484043dd2b681aebbd89dd.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 22/22] bitbake: toastergui: project page Add inline project name change feature
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

This feature allows the project name to be changed from where ever it is
displayed in the project pages.

[YOCTO #7329]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js           | 29 ++++++++++++++++++++++
 .../toastergui/templates/projecttopbar.html        | 11 +++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 09c3ef1..f253361 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -5,6 +5,10 @@ function basePageInit(ctx) {
   var newBuildButton = $("#new-build-button");
   var newBuildTargetInput;
   var newBuildTargetBuildBtn;
+  var projectNameForm = $("#project-name-change-form");
+  var projectName = $("#project-name");
+  var projectNameFormToggle = $("#project-change-form-toggle");
+  var projectNameChangeCancel = $("#project-name-change-cancel");
 
   /* initially the current project is used unless overridden by the new build
    * button in top right nav
@@ -16,6 +20,31 @@ function basePageInit(ctx) {
   var newBuildProjectInput = $("#new-build-button #project-name-input");
   var newBuildProjectSaveBtn = $("#new-build-button #save-project-button");
 
+  /* Project name change functionality */
+  projectNameFormToggle.click(function(e){
+    e.preventDefault();
+
+    $(this).add(projectName).hide();
+    projectNameForm.fadeIn();
+  });
+
+  projectNameChangeCancel.click(function(e){
+    e.preventDefault();
+
+    projectNameForm.hide();
+    projectName.add(projectNameFormToggle).fadeIn();
+  });
+
+  $("#project-name-change-btn").click(function(e){
+    var newProjectName = $("#project-name-change-input").val();
+
+    libtoaster.editCurrentProject({ projectName: newProjectName },function (){
+
+      projectName.text(newProjectName);
+      libtoaster.ctx.projectName = newProjectName;
+      projectNameChangeCancel.click();
+    });
+  });
 
   _checkProjectBuildable();
 
diff --git a/lib/toaster/toastergui/templates/projecttopbar.html b/lib/toaster/toastergui/templates/projecttopbar.html
index d4d1951..79f6d1e 100644
--- a/lib/toaster/toastergui/templates/projecttopbar.html
+++ b/lib/toaster/toastergui/templates/projecttopbar.html
@@ -5,7 +5,16 @@
 
 <!-- project name -->
 <div class="row-fluid page-header">
-  <h1>{{project.name}}</h1>
+  <h1><span id="project-name">{{project.name}}</span>
+    <i class="icon-pencil" data-original-title="" id="project-change-form-toggle" title=""></i>
+  </h1>
+  <form id="project-name-change-form" style="margin-bottom: 0px; display: none;">
+    <div class="input-append">
+      <input class="huge input-xxlarge" type="text" id="project-name-change-input" autocomplete="off" value="{{project.name}}">
+        <button id="project-name-change-btn" class="btn btn-large" type="button">Save</button>
+        <a href="#" id="project-name-change-cancel" class="btn btn-large btn-link">Cancel</a>
+    </div>
+  </form>
 </div>
 
 <div class="row-fluid" id="project-topbar">
-- 
2.1.4


