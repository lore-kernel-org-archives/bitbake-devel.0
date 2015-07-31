Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A26C8765E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 12:09:49 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 31 Jul 2015 05:09:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,584,1432623600"; d="scan'208";a="774000146"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2015 05:09:50 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id A72376A4083
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 05:09:04 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 15:09:17 +0300
Message-Id: <088898412cae6922d2e8b519d7fe6b706473853a.1438343854.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438343854.git.ed.bartosh@linux.intel.com>
References: <cover.1438343854.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 16/22] bitbake: toastergui: base Use removeAttr / attr
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
X-List-Received-Date: Fri, 31 Jul 2015 12:09:49 -0000

From: Michael Wood <michael.g.wood@intel.com>

Use removeAttr and attr calls to enable and disable the build button and
build input field.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 0fb1f8b..c99f8cd 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -62,7 +62,9 @@ function basePageInit(ctx) {
   libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
         /* successfully selected a target */
       selectedTarget = item;
-  });
+      newBuildTargetBuildBtn.removeAttr("disabled");
+    });
+  }
 
   newBuildTargetInput.on('input', function () {
     if ($(this).val().length === 0) {
@@ -105,8 +107,8 @@ function basePageInit(ctx) {
           $("#new-build-button .alert").hide();
 
           /* we can build this project; enable input fields */
-          newBuildTargetInput.prop("disabled", false);
-          newBuildTargetBuildBtn.prop("disabled", false);
+          newBuildTargetInput.removeAttr("disabled");
+          newBuildTargetBuildBtn.removeAttr("disabled");
        }
       }, null);
   }
@@ -144,13 +146,13 @@ function basePageInit(ctx) {
       /* Update the typeahead project_id paramater */
       _checkProjectBuildable();
 
-      newBuildTargetInput.prop("disabled", false);
-      newBuildTargetBuildBtn.prop("disabled", false);
+      newBuildTargetInput.removeAttr("disabled");
 
       /* Update the typeahead to use the new selectedProject */
       libtoaster.makeTypeahead(newBuildTargetInput, selectedProject.projectTargetsUrl, { format: "json" }, function (item) {
         /* successfully selected a target */
         selectedTarget = item;
+        newBuildTargetBuildBtn.removeAttr("disabled");
       });
 
       newBuildTargetInput.val("");
-- 
2.1.4


