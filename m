Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 44F1076903
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 13:55:27 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 07 Oct 2015 06:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="786677480"
Received: from cdoyle2-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.38])
	by orsmga001.jf.intel.com with ESMTP; 07 Oct 2015 06:55:17 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 14:55:07 +0100
Message-Id: <1870fdfb0c4c5abd8b562b1839f1696bca380b8f.1444225939.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1444225939.git.elliot.smith@intel.com>
References: <cover.1444225939.git.elliot.smith@intel.com>
Subject: [PATCH 1/2] toaster: buildinfohelper associate build data with built_recipe
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
X-List-Received-Date: Wed, 07 Oct 2015 13:55:27 -0000

From: Michael Wood <michael.g.wood@intel.com>

Make sure we associate build data with the built recipe rather than
toaster's configuration copy of the recipe.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 793418a..9195584 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -285,6 +285,7 @@ class ORMWrapper(object):
 
         update_recipe_obj(recipe)
 
+        built_recipe = None
         # Create a copy of the recipe for historical puposes and update it
         for built_layer in self.layer_version_built:
             if built_layer.layer == recipe_information['layer_version'].layer:
@@ -300,7 +301,7 @@ class ORMWrapper(object):
         if created and must_exist:
             raise NotExisting("Recipe object created when expected to exist", recipe_information)
 
-        return recipe
+        return built_recipe
 
     def get_update_layer_version_object(self, build_obj, layer_obj, layer_version_information):
         if isinstance(layer_obj, Layer_Version):
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


