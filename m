Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 93DB9766DD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:46 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Oct 2015 02:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373642"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:46 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:39 +0100
Message-Id: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1444383025.git.elliot.smith@intel.com>
References: <cover.1444383025.git.elliot.smith@intel.com>
Subject: [PATCH 1/5] toaster: layerdetails update build recipe button class name
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:47 -0000

From: Michael Wood <michael.g.wood@intel.com>

Update the class name which we are using for the recipe build button.
This fixes a regression in the buttons being enabled/disabled when
adding and removing the layer being viewed from the project.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/static/js/layerdetails.js | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/layerdetails.js b/lib/toaster/toastergui/static/js/layerdetails.js
index 8817b47..8c2ec4c 100644
--- a/lib/toaster/toastergui/static/js/layerdetails.js
+++ b/lib/toaster/toastergui/static/js/layerdetails.js
@@ -254,7 +254,7 @@ function layerDetailsPageInit (ctx) {
 
     if (added){
       /* enable and switch all the button states */
-      $(".build-target-btn").removeAttr("disabled");
+      $(".build-recipe-btn").removeAttr("disabled");
       $(".select-machine-btn").removeAttr("disabled");
       addRmLayerBtn.addClass("btn-danger");
       addRmLayerBtn.data('directive', "remove");
@@ -263,7 +263,7 @@ function layerDetailsPageInit (ctx) {
 
     } else {
       /* disable and switch all the button states */
-      $(".build-target-btn").attr("disabled","disabled");
+      $(".build-recipe-btn").attr("disabled","disabled");
       $(".select-machine-btn").attr("disabled", "disabled");
       addRmLayerBtn.removeClass("btn-danger");
       addRmLayerBtn.data('directive', "add");
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


