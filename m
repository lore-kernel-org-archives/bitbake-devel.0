Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BEEF475E2D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 12:43:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 14 Oct 2015 05:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; d="scan'208";a="810776550"
Received: from marcinko-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.75])
	by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2015 05:43:50 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:43:18 +0100
Message-Id: <1444826598-2511-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Disable add layer button when input is empty
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
X-List-Received-Date: Wed, 14 Oct 2015 12:43:55 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The 'add layer' button in the project configuration page
is enabled when you select a layer from the type ahead.
However, if you delete the layer name, the 'add layer'
button remains enabled, and if you click it, the last
selected layer from the type ahead will be added to the
project.

It is probably better to disable the 'add layer' button
when the input field is empty.

[YOCTO #8449]

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/projectpage.js | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/toaster/toastergui/static/js/projectpage.js b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
index 30989a0..b0fe451 100644
--- a/bitbake/lib/toaster/toastergui/static/js/projectpage.js
+++ b/bitbake/lib/toaster/toastergui/static/js/projectpage.js
@@ -103,6 +103,12 @@ function projectPageInit(ctx) {
     layerAddBtn.removeAttr("disabled");
   });
 
+  layerAddInput.keyup(function() {
+    if ($(this).val().length == 0) {
+      layerAddBtn.attr("disabled", "disabled")
+    }
+  });
+
   layerAddBtn.click(function(e){
     e.preventDefault();
     var layerObj = currentLayerAddSelection;
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


