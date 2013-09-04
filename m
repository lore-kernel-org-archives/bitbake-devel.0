Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 2ABDB6C083
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Sep 2013 15:41:32 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 04 Sep 2013 08:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,1021,1367996400"; d="scan'208";a="290765244"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Sep 2013 08:41:32 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Sep 2013 18:45:07 +0300
Message-Id: <1378309507-10638-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: remove custom image from the images list when not needed
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
X-List-Received-Date: Wed, 04 Sep 2013 15:41:32 -0000

Selected custom image recipes should be cleared from the combo the moment
you change your selection. The idea is to always perform the selection of
those images in the same way (i.e through the "Select from my image
recipes" option).

[YOCTO #5001]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 060fee2..3babc8e 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -387,6 +387,10 @@ class ImageConfigurationPage (HobPage):
                 selected_image = self.__dummy_image__
                 self.update_image_combo(self.builder.recipe_model, None)
             dialog.destroy()
+        else:
+            if self.custom_image_selected:
+                self.custom_image_selected = None
+                self.update_image_combo(self.builder.recipe_model, selected_image)
 
         if not selected_image or (selected_image == self.__dummy_image__):
             self.builder.window_sensitive(True)
-- 
1.7.9.5


