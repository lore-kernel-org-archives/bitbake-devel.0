Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0CC567704C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 14:43:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 03 Sep 2015 07:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,462,1437462000"; d="scan'208";a="797501671"
Received: from tmistat-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.10.21])
	by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2015 07:43:54 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Sep 2015 15:43:50 +0100
Message-Id: <2371961c2f0b587ac5c5dd1aee3277052c3b5486.1441291289.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1441291289.git.elliot.smith@intel.com>
References: <cover.1441291289.git.elliot.smith@intel.com>
Subject: [PATCH 1/2] toaster: disable build button as needed
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
X-List-Received-Date: Thu, 03 Sep 2015 14:43:56 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure that the 'build' button in the 'new build'
form is disabled whenever the 'recipe(s)' text
field is empty.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index eba9c16..e0df463 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -82,7 +82,6 @@ function basePageInit(ctx) {
     return;
   }
 
-
   /* Hide the change project icon when there is only one project */
   if (ctx.numProjects === 1) {
     $('#project .icon-pencil').hide();
@@ -140,7 +139,6 @@ function basePageInit(ctx) {
 
           /* we can build this project; enable input fields */
           newBuildTargetInput.removeAttr("disabled");
-          newBuildTargetBuildBtn.removeAttr("disabled");
        }
       }, null);
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


