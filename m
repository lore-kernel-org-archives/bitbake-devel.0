Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E08356E5CB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 12:04:23 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP; 07 Mar 2016 04:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,551,1449561600"; d="scan'208";a="61287069"
Received: from vivienne-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.236])
	by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2016 04:04:23 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 12:04:20 +0000
Message-Id: <1457352260-30982-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH] toaster: bring back the strict directive
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
X-List-Received-Date: Mon, 07 Mar 2016 12:04:24 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

This patch e0fd96442a20e3fe7953bf38fc02520cd0dd4d6a removed the
"use strict" directive from the projectpage.js file by mistake.

This patch makes amends.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/projectpage.js | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index 292ceb7..6655a18 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -1,4 +1,4 @@
-
+"use strict";
 
 function projectPageInit(ctx) {
 
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


