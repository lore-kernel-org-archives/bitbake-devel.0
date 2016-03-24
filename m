Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 49CFE6018C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 12:12:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 24 Mar 2016 05:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,385,1455004800"; d="scan'208";a="917905741"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.9.87])
	by orsmga001.jf.intel.com with ESMTP; 24 Mar 2016 05:12:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 12:12:09 +0000
Message-Id: <1458821531-10484-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 1/3] toaster: show full list of dependents to remove
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
X-List-Received-Date: Thu, 24 Mar 2016 12:12:45 -0000

From: Dave Lerner <dave.lerner@windriver.com>

When a package is to be removed, show the full list of packages that are
dependent on that package, telling user that these packages will also be
removed.

[YOCTO #9121]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/static/js/customrecipe.js   | 72 ++++++++++++++++++++--
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
index 3c57899..f1b8afb 100644
--- a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
@@ -89,7 +89,21 @@ function customRecipePageInit(ctx) {
     var depsList = modal.find("#package-reverse-dep-list");
     var deps = pkgData.reverse_dependencies;
 
+    var depsCount = deps.length;
+    var vDepends = "depends";
+    var vPackage = "package";
+    var vThis = "this";
+    if (depsCount > 1) {
+      vDepends = "depend";
+      vPackage = "packages";
+      vThis = "these";
+    }
     modal.find(".package-to-rm-name").text(targetPkg.name);
+    modal.find(".reverse-deps-count").text(depsCount);
+    modal.find(".reverse-deps-count-plus1").text((depsCount+1) + " packages");
+    modal.find(".reverse-deps-depends").text(vDepends);
+    modal.find(".reverse-deps-package").text(vPackage);
+    modal.find(".reverse-deps-this").text(vThis);
 
     depsList.text("");
 
@@ -103,6 +117,8 @@ function customRecipePageInit(ctx) {
     modal.find("#package-reverse-deps-total-size").text(
       pkgData.reverse_dependencies_size_formatted);
 
+    targetPkg.depsRemoved = deps;
+
     rmdPkgReverseDepsModalBtn.data(targetPkg);
     modal.modal('show');
   }
@@ -121,6 +137,10 @@ function customRecipePageInit(ctx) {
     var btnCell = $("#package-btn-cell-" + targetPkg.id);
     var inlineNotify = btnCell.children(".inline-notification");
 
+    var i;
+    var dep;
+    var depBtnCell;
+
     if (targetPkg.directive === 'add') {
       method = 'PUT';
       /* If the package had dependencies also notify that they were added */
@@ -132,15 +152,15 @@ function customRecipePageInit(ctx) {
         msg += " packages to " + ctx.recipe.name + ": ";
         msg += "<strong>" + targetPkg.name + "</strong> and its dependencies";
 
-        for (var i in targetPkg.depsAdded){
-          var dep = targetPkg.depsAdded[i];
+        for (i in targetPkg.depsAdded){
+          dep = targetPkg.depsAdded[i];
 
           msg += " <strong>" + dep.name + "</strong>";
 
           /* Add any cells currently in view to the list of cells which get
            * an inline notification inside them and which change add/rm state
            */
-          var depBtnCell = $("#package-btn-cell-" + dep.pk);
+          depBtnCell = $("#package-btn-cell-" + dep.pk);
           btnCell = btnCell.add(depBtnCell);
 
           inlineNotify = inlineNotify.add(
@@ -159,9 +179,49 @@ function customRecipePageInit(ctx) {
 
     } else if (targetPkg.directive === 'remove') {
       method = 'DELETE';
-      msg += "removed 1 package from "+ctx.recipe.name+":";
-      msg += ' <strong>' + targetPkg.name + '<strong>';
-      inlineNotify.text("1 package removed");
+      var numPackageString = "1 package ";
+      var revDepList = "";
+      if (targetPkg.hasOwnProperty('depsRemoved') &&
+              targetPkg.depsRemoved.length > 0) {
+        var depsRemovedLength = targetPkg.depsRemoved.length;
+        var ending = "y: ";
+        var maxRevDepsDisplayed  = 5;
+        var d = 0;
+        if (depsRemovedLength > 1) {
+            ending = "ies: ";
+        }
+        numPackageString = (depsRemovedLength + 1) + " packages";
+        revDepList = " and its " + depsRemovedLength + " reverse dependenc" + ending;
+        for (i in targetPkg.depsRemoved){
+          /* include up to maxRevDepsDisplayed rev deps on the page notification */
+          var notShownCount = depsRemovedLength - maxRevDepsDisplayed;
+          dep = targetPkg.depsRemoved[i];
+          if (d < maxRevDepsDisplayed) {
+            if (d > 0) {
+                revDepList += ", ";
+            }
+            revDepList += dep.name;
+            d++;
+            if ((d === maxRevDepsDisplayed) && (notShownCount > 0)) {
+                revDepList += " and " + notShownCount + " more";
+            }
+          }
+
+          /* Add any cells currently in view to the list of cells which get
+           * an inline notification inside them and which change add/rm state
+           */
+          depBtnCell = $("#package-btn-cell-" + dep.pk);
+          btnCell = btnCell.add(depBtnCell);
+
+          inlineNotify = inlineNotify.add(
+            depBtnCell.children(".inline-notification"));
+        }
+      }
+      msg+= "removed " + numPackageString + " from " + ctx.recipe.name + ":";
+      msg += " <strong>" + targetPkg.name + "</strong>";
+      msg += revDepList;
+
+      inlineNotify.text(numPackageString + " removed");
     } else {
       throw("Unknown package directive: should be add or remove");
     }
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


