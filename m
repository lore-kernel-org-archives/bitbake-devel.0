Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BB8F6765F4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:50 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 05:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="774000155"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2015 05:09:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id D1A5C6A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:05 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:18 +0300
Message-Id: <3a9911b9afaf945ee6522de2f14a24442dc83186.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 17/22] bitbake: toastergui: Change build button popover to a build-button
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:50 -0000

From: Michael Wood <michael.g.wood@intel.com>

To share the build-button mechanism from the pop over and project
topbar build button we now use a build-button class to reference them
and share the event handlers.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js   | 15 +++++++++------
 lib/toaster/toastergui/templates/base.html |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index c99f8cd..dda2549 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -42,7 +42,7 @@ function basePageInit(ctx) {
       $(".build-target-input").length === 1) {
 
     newBuildTargetInput = $("#new-build-button .build-target-input");
-    newBuildTargetBuildBtn = $("#new-build-button .build-button");
+    newBuildTargetBuildBtn = $("#new-build-button").find(".build-button");
 
     _setupNewBuildButton();
     newBuildButton.show();
@@ -59,8 +59,9 @@ function basePageInit(ctx) {
     $('#project .icon-pencil').hide();
   }
 
-  libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
-        /* successfully selected a target */
+  /* If we have a project setup the typeahead */
+  if (selectedProject.projectTargetsUrl){
+    libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
       selectedTarget = item;
       newBuildTargetBuildBtn.removeAttr("disabled");
     });
@@ -81,9 +82,11 @@ function basePageInit(ctx) {
       return;
     }
 
-    if (!selectedTarget) {
-      selectedTarget = { name: newBuildTargetInput.val() };
-    }
+    /* We use the value of the input field so as to maintain any command also
+     * added e.g. core-image-minimal:clean
+     */
+    selectedTarget = { name: newBuildTargetInput.val() };
+
     /* Fire off the build */
     libtoaster.startABuild(selectedProject.projectBuildsUrl,
       selectedProject.projectId, selectedTarget.name, function(){
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index 4c6676c..4bef04f 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -143,8 +143,8 @@
                 <h6>Recipe(s):</h6>
                 <form>
                   <input type="text" class="input-xlarge build-target-input" placeholder="Type a recipe name" autocomplete="off" data-minLength="1" data-autocomplete="off" data-provide="typeahead" disabled/>
-                  <div>
-                    <button class="btn btn-primary" id="build-button" disabled>Build</button>
+                  <div class="row-fluid">
+                    <button class="btn btn-primary build-button" disabled>Build</button>
                   </div>
                 </form>
               </li>
-- 
2.1.4


