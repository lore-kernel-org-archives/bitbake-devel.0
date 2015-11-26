Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 90B20612E5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 14:54:45 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 26 Nov 2015 06:54:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="607563659"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2015 06:54:45 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 14:54:29 +0000
Message-Id: <1448549669-12306-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: projectpage Make sure build targets are space separated
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
X-List-Received-Date: Thu, 26 Nov 2015 14:54:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make sure the build targets are space separated when building multiple
targets. Also fix error path now that YOCTO #7995 is resolved.

[YOCTO #8450]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/static/js/projectpage.js    | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index ae08d9a..4a482d7 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -225,17 +225,21 @@ function projectPageInit(ctx) {
 
     var toBuild = "";
     freqBuildList.find(":checked").each(function(){
-      toBuild += $(this).val();
+      toBuild += $(this).val() + ' ';
     });
 
-    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl, libtoaster.ctx.projectId, toBuild, function(){
-      /* Build started */
-      window.location.replace(libtoaster.ctx.projectBuildsUrl);
-    },
-    function(){
-      /* Build start failed */
-      /* [YOCTO #7995] */
-      window.location.replace(libtoaster.ctx.projectBuildsUrl);
+    toBuild = toBuild.trim();
+
+    libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl,
+      libtoaster.ctx.projectId,
+      toBuild,
+      function(){
+        /* Build request started */
+        window.location.replace(libtoaster.ctx.projectBuildsUrl);
+      },
+      function(){
+        /* Build request failed */
+        console.warn("Build request failed to be created");
     });
   });
 
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


