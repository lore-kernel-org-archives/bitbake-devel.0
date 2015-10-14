Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9E9E175E2D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 12:20:57 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 14 Oct 2015 05:20:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,681,1437462000"; d="scan'208";a="580548959"
Received: from marcinko-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.75])
	by FMSMGA003.fm.intel.com with ESMTP; 14 Oct 2015 05:20:54 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Oct 2015 13:20:50 +0100
Message-Id: <1444825250-1188-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Have 'Version' next to recipe name
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
X-List-Received-Date: Wed, 14 Oct 2015 12:20:58 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In all Toaster tables we show the version next to the recipe
or package names, with one exception: the recipes table in
the layer details page, where we are showing the version
next to the recipe description.

This patch moves the version column next to the recipe name,
for consistency with all other Toaster tables.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tables.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/tables.py b/bitbake/lib/toaster/toastergui/tables.py
index b10445b..9c9cda4 100644
--- a/bitbake/lib/toaster/toastergui/tables.py
+++ b/bitbake/lib/toaster/toastergui/tables.py
@@ -432,12 +432,12 @@ class LayerRecipesTable(RecipesTable):
                         orderable=True,
                         field_name="name")
 
-        self.add_column(title="Description",
-                        field_name="get_description_or_summary")
-
         self.add_column(title="Version",
                         field_name="version")
 
+        self.add_column(title="Description",
+                        field_name="get_description_or_summary")
+
         build_recipe_template ='<button class="btn btn-block build-recipe-btn" data-recipe-name="{{data.name}}" {%if extra.in_prj == 0 %}disabled="disabled"{%endif%}>Build recipe</button>'
 
         self.add_column(title="Build recipe",
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


