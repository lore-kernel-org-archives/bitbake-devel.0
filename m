Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 6D2EC6B376
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2013 11:40:28 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 25 Jul 2013 04:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,742,1367996400"; d="scan'208";a="370781280"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2013 04:40:28 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2013 14:42:29 +0300
Message-Id: <1374752549-29471-17-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 16/16] hob/imageconfigurationpage: changes to image combobox
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 Jul 2013 11:40:29 -0000

Place the "Create your own image recipe" field to the
end of the image recipes list.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index e1211bc..dcf1334 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -456,7 +456,6 @@ class ImageConfigurationPage (HobPage):
             cnt = cnt + 1
 
         self.image_combo.append_text(self.__custom_image__)
-        self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
         self.image_combo.append_text("--Separator--")
         cnt = cnt + 3
 
@@ -493,6 +492,7 @@ class ImageConfigurationPage (HobPage):
                 if image_name == selected_image:
                     active = cnt
                 cnt = cnt + 1
+        self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
 
         if self.custom_image_selected:
             self.image_combo.append_text("--Separator--")
-- 
1.7.9.5


