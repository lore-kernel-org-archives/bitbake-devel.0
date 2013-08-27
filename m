Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E51246ABA5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 10:24:17 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 27 Aug 2013 03:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,967,1367996400"; d="scan'208";a="387042670"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2013 03:24:17 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Aug 2013 13:27:37 +0300
Message-Id: <1377599257-29089-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: fixes for image combo box
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
X-List-Received-Date: Tue, 27 Aug 2013 10:24:19 -0000

When an image from scratch is selected, and recipes parsing
is canceled, the image shown by the combo box isn't correct.

[YOCTO #5000]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index ca168bc..060fee2 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -496,16 +496,15 @@ class ImageConfigurationPage (HobPage):
                 cnt = cnt + 1
         self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
 
+        if selected_image == self.builder.recipe_model.__custom_image__:
+            active = cnt
+
         if self.custom_image_selected:
             self.image_combo.append_text("--Separator--")
-            cnt = cnt + 1
             self.image_combo.append_text(self.custom_image_selected)
+            cnt = cnt + 2
             if self.custom_image_selected == selected_image:
                 active = cnt
-            cnt = cnt + 1
-
-        if selected_image == self.builder.recipe_model.__custom_image__:
-            active = cnt
 
         self.image_combo.set_active(active)
 
-- 
1.7.9.5


