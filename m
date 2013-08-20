Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6003C6B84D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Aug 2013 13:27:32 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Aug 2013 06:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,920,1367996400"; d="scan'208";a="365539691"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 20 Aug 2013 06:27:16 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Aug 2013 16:30:22 +0300
Message-Id: <1377005422-6409-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: changes to image combo box from image configuration page
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
X-List-Received-Date: Tue, 20 Aug 2013 13:27:32 -0000

In some cases when a new machine is selected, the image combo
shows the same option. Fixed this issue, because the image
combo box should be reseted.

Fix the counter for the options in the combobox. This bug
was introduced by the templates functionality. The combo box had some
last changes, and I forgot about this counter.

[YOCTO #4858 & #5000]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index dcf1334..ca168bc 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -319,6 +319,8 @@ class ImageConfigurationPage (HobPage):
         # reset machine_combo_changed_by_manual
         self.machine_combo_changed_by_manual = True
 
+        self.builder.configuration.selected_image = None
+
         # Do reparse recipes
         self.builder.populate_recipe_package_info_async()
 
@@ -457,7 +459,7 @@ class ImageConfigurationPage (HobPage):
 
         self.image_combo.append_text(self.__custom_image__)
         self.image_combo.append_text("--Separator--")
-        cnt = cnt + 3
+        cnt = cnt + 2
 
         topdir = self.builder.get_topdir()
         # append and set active
-- 
1.7.9.5


