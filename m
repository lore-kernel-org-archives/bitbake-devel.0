Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 41969770D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Feb 2016 09:08:48 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 22 Feb 2016 01:08:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,483,1449561600"; d="scan'208";a="921077039"
Received: from mmisiak-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.233])
	by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2016 01:08:48 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 09:08:35 +0000
Message-Id: <c3db3e47811814738e06d85e41a819dd90f8a1a8.1456131920.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
References: <6a8294aab59563cd1d747764d140787648218458.1456131920.git.elliot.smith@intel.com>
In-Reply-To: <cover.1456131920.git.elliot.smith@intel.com>
References: <cover.1456131920.git.elliot.smith@intel.com>
Subject: [PATCH 4/9] toaster: disable add layer button on click
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
X-List-Received-Date: Mon, 22 Feb 2016 09:08:48 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The 'add layer' button in the project configuration page remains enabled
after you add a layer. If you click it again, the same layer you just
added is added again.

This patch disables the 'add layer' button on click, to avoid this bit
of weirdness.

[YOCTO #8905]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/projectpage.js | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index 4a482d7..0666bde 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -116,6 +116,8 @@ function projectPageInit(ctx) {
     addRmLayer(layerObj, true);
     /* Reset the text input */
     layerAddInput.val("");
+    /* Disable the add layer button*/
+    layerAddBtn.attr("disabled", "disabled");
   });
 
   function addRmLayer(layerObj, add){
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


