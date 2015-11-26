Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 540996011D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 15:59:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 07:59:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="694948424"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by orsmga003.jf.intel.com with ESMTP; 26 Nov 2015 07:59:19 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 15:59:01 +0000
Message-Id: <1448553541-1835-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: tablejs Make sure click handlers consume click event
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
X-List-Received-Date: Thu, 26 Nov 2015 15:59:21 -0000

From: Michael Wood <michael.g.wood@intel.com>

Avoid the click event from propagating and causing strange side effects
in toaster tables.

[YOCTO #8527]
[YOCTO #8148]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/static/js/table.js | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/table.js b/bitbake/lib/toaster/toastergui/static/js/table.js
index 40b5022..c69c205 100644
--- a/bitbake/lib/toaster/toastergui/static/js/table.js
+++ b/bitbake/lib/toaster/toastergui/static/js/table.js
@@ -340,7 +340,8 @@ function tableInit(ctx){
     }
   }
 
-  function sortColumnClicked(){
+  function sortColumnClicked(e){
+    e.preventDefault();
 
     /* We only have one sort at a time so remove any existing sort indicators */
     $("#"+ctx.tableName+" th .icon-caret-down").hide();
@@ -476,6 +477,7 @@ function tableInit(ctx){
   });
 
   $("#search-submit-"+ctx.tableName).click(function(e){
+    e.preventDefault();
     var searchTerm = $("#search-input-"+ctx.tableName).val();
 
     tableParams.page = 1;
@@ -489,8 +491,6 @@ function tableInit(ctx){
     }
 
     loadData(tableParams);
-
-    e.preventDefault();
   });
 
   $('.remove-search-btn-'+ctx.tableName).click(function(e){
@@ -514,7 +514,9 @@ function tableInit(ctx){
     e.preventDefault();
   });
 
-  $("#clear-filter-btn-"+ctx.tableName).click(function(){
+  $("#clear-filter-btn-"+ctx.tableName).click(function(e){
+    e.preventDefault();
+
     var filterBtn = $("#" + tableParams.filter.split(":")[0]);
     filterBtnActive(filterBtn, false);
 
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


