Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 994F565CB6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Mar 2016 08:29:22 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2016 01:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; d="scan'208";a="769709458"
Received: from rmoran-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.1.250])
	by orsmga003.jf.intel.com with ESMTP; 23 Mar 2016 01:28:52 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Mar 2016 08:28:40 +0000
Message-Id: <59805259d6d41e5b33dee70a74a6892be37d253d.1458721297.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <867f3199ac6e68411ba49fc0f20e6ad8f9a743f7.1458721297.git.elliot.smith@intel.com>
References: <867f3199ac6e68411ba49fc0f20e6ad8f9a743f7.1458721297.git.elliot.smith@intel.com>
In-Reply-To: <cover.1458721297.git.elliot.smith@intel.com>
References: <cover.1458721297.git.elliot.smith@intel.com>
Subject: [PATCH 5/5] toaster: orm generate CustomImageRecipe contents try secondary path
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
X-List-Received-Date: Wed, 23 Mar 2016 08:29:22 -0000

From: Michael Wood <michael.g.wood@intel.com>

Try a secondary file path if the first does not exist. When we get the
recipe paths and layer information from the layer index it is not a
complete path but we are usually able to reconstruct it. If the complete
real path has been discovered by building then use this instead.

[YOCTO #9206]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/orm/models.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index a8b0408..6ae6316 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1533,10 +1533,13 @@ class CustomImageRecipe(Recipe):
                 packages_conf += pkg.name+' '
 
         packages_conf += "\""
-
-        base_recipe = open("%s/%s" %
-                           (self.base_recipe.layer_version.dirpath,
-                            self.base_recipe.file_path), 'r').read()
+        try:
+            base_recipe = open("%s/%s" %
+                               (self.base_recipe.layer_version.dirpath,
+                                self.base_recipe.file_path), 'r').read()
+        except IOError:
+            # The path may now be the full path if the recipe has been built
+            base_recipe = open(self.base_recipe.file_path, 'r').read()
 
         # Add a special case for when the recipe we have based a custom image
         # recipe on requires another recipe.
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


