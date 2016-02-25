Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 83F5077254
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 14:25:02 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 25 Feb 2016 06:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="894537150"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.2.6])
	by orsmga001.jf.intel.com with ESMTP; 25 Feb 2016 06:24:55 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 14:24:49 +0000
Message-Id: <1456410289-31796-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH] toaster: fix banner after customimage package add
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
X-List-Received-Date: Thu, 25 Feb 2016 14:25:04 -0000

From: Dave Lerner <dave.lerner@windriver.com>

Correct formatting of the banner message after adding a package to a
custom image.

[YOCTO #9101]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/customrecipe.js | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
index a1fe486..3c57899 100644
--- a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
@@ -127,7 +127,8 @@ function customRecipePageInit(ctx) {
       if (targetPkg.hasOwnProperty('depsAdded') &&
         targetPkg.depsAdded.length > 0) {
 
-        msg += "added " + (targetPkg.depsAdded.length + 1);
+        msg += "added ";
+        msg += "<strong>" + (targetPkg.depsAdded.length + 1) + "</strong>";
         msg += " packages to " + ctx.recipe.name + ": ";
         msg += "<strong>" + targetPkg.name + "</strong> and its dependencies";
 
@@ -150,7 +151,9 @@ function customRecipePageInit(ctx) {
           (targetPkg.depsAdded.length + 1) + " packages added");
 
       } else {
-        msg += ' <strong>' + targetPkg.name + '<strong>';
+        msg += "added <strong>1</strong>";
+        msg += " package to " + ctx.recipe.name + ": ";
+        msg += "<strong>" + targetPkg.name + "</strong>";
         inlineNotify.text("1 package added");
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


