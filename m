Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 15B6B76D72
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Aug 2015 13:26:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 27 Aug 2015 06:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,422,1437462000"; d="scan'208";a="792002819"
Received: from mozel-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.17.173])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2015 06:26:44 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Aug 2015 14:25:58 +0100
Message-Id: <1440681958-749-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Subject: [PATCH] toaster: Fix extra checkbox in most recently built recipes section
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
X-List-Received-Date: Thu, 27 Aug 2015 13:26:48 -0000

From: Sujith Haridasan <Sujith_Haridasan@mentor.com>

This patch fixes an extra checkbox which is due to an extra space
in the target.

[YOCTO #8202]

Signed-off-by: Sujith Haridasan <sujith.h@gmail.com>
Signed-off-by: Sujith Haridasan <Sujith_Haridasan@mentor.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/projectpage.js | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index 146319e..d367047 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -216,7 +216,6 @@ function projectPageInit(ctx) {
     var toBuild = "";
     freqBuildList.find(":checked").each(function(){
       toBuild += $(this).val();
-      toBuild += " ";
     });
 
     libtoaster.startABuild(libtoaster.ctx.projectBuildsUrl, libtoaster.ctx.projectId, toBuild, function(){
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


