Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 460F6772C6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 13:48:44 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 13 Nov 2015 05:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,287,1444719600"; d="scan'208";a="836998427"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.6.239])
	by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2015 05:48:45 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 13:48:35 +0000
Message-Id: <f11f93bf7b16aacb754790da1587d16bb21f080f.1447422301.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <8088ff54a9e386f47c332fa71d5db59efe2d5d34.1447422301.git.elliot.smith@intel.com>
References: <8088ff54a9e386f47c332fa71d5db59efe2d5d34.1447422301.git.elliot.smith@intel.com>
In-Reply-To: <cover.1447422301.git.elliot.smith@intel.com>
References: <cover.1447422301.git.elliot.smith@intel.com>
Subject: [PATCH 2/4] toaster: projectpage Disable/Enable build input if we have 0 layers
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
X-List-Received-Date: Fri, 13 Nov 2015 13:48:44 -0000

From: Michael Wood <michael.g.wood@intel.com>

If we've removed all the layers in the configuration, disable the build
button and build input.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/projectpage.js | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/projectpage.js b/lib/toaster/toastergui/static/js/projectpage.js
index e742ef2..ae08d9a 100644
--- a/lib/toaster/toastergui/static/js/projectpage.js
+++ b/lib/toaster/toastergui/static/js/projectpage.js
@@ -175,11 +175,18 @@ function projectPageInit(ctx) {
 
   function updateLayersCount(){
     var count = $("#layers-in-project-list").children().length;
+    var noLayerMsg = $("#no-layers-in-project");
+    var buildInput = $("#build-input");
 
-    if (count === 0)
+
+    if (count === 0) {
+      noLayerMsg.fadeIn();
       $("#no-layers-in-project").fadeIn();
-    else
-      $("#no-layers-in-project").hide();
+      buildInput.attr("disabled", "disabled");
+    } else {
+      noLayerMsg.hide();
+      buildInput.removeAttr("disabled");
+    }
 
     $("#project-layers-count").text(count);
 
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


