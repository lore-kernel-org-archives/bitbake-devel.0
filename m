Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 67AD262131
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:42 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 08:44:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="860355472"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2015 08:44:42 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:32 +0000
Message-Id: <ff34afb3fd58ea9a601e25e6b47e056c4a58a502.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
References: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
In-Reply-To: <cover.1448556172.git.elliot.smith@intel.com>
References: <cover.1448556172.git.elliot.smith@intel.com>
Subject: [PATCH 2/5] toaster: CustomImageRecipe add search_allowed_fields to this model
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:42 -0000

From: Michael Wood <michael.g.wood@intel.com>

In order to search the model from the UI some fields must be nominated
as searchable.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/orm/models.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 0ac94b9..0174233 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1238,6 +1238,7 @@ class ProjectLayer(models.Model):
         unique_together = (("project", "layercommit"),)
 
 class CustomImageRecipe(models.Model):
+    search_allowed_fields = ['name']
     name = models.CharField(max_length=100)
     base_recipe = models.ForeignKey(Recipe)
     packages = models.ManyToManyField(Package)
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


