Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 0B63C605BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Nov 2015 16:44:48 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2015 08:44:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,347,1444719600"; d="scan'208";a="860355496"
Received: from snwijaya-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.69])
	by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2015 08:44:47 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2015 16:44:34 +0000
Message-Id: <e6d477095a3f524c34a29233ddd32435847e9566.1448556172.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
References: <7a60315f7183a0792c24c7e5a2c4b5688e6f18c8.1448556172.git.elliot.smith@intel.com>
In-Reply-To: <cover.1448556172.git.elliot.smith@intel.com>
References: <cover.1448556172.git.elliot.smith@intel.com>
Subject: [PATCH 4/5] toaster: tables Fix invalid field name on NewCustomImagesTable
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
X-List-Received-Date: Thu, 26 Nov 2015 16:44:48 -0000

From: Michael Wood <michael.g.wood@intel.com>

Correct the field name in the NewCustomImagesTable as it is a Recipe
object it's self and not a container.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/toastergui/tables.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index 44a89d9..74af507 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -545,7 +545,7 @@ class NewCustomImagesTable(ImageRecipesTable):
                                   "deploy to a machine",
                         hideable=False,
                         orderable=True,
-                        field_name="recipe__name")
+                        field_name="name")
 
         super(ImageRecipesTable, self).setup_columns(*args, **kwargs)
 
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


