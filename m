Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 4028160F86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Sep 2013 10:44:26 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 17 Sep 2013 03:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,922,1371106800"; d="scan'208";a="361669928"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by azsmga001.ch.intel.com with ESMTP; 17 Sep 2013 03:44:26 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Sep 2013 13:48:21 +0300
Message-Id: <1379414901-28041-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: populate "Save image" dialog when saving changes to a custom image recipe If my build starts from a YP standard image recipe, the 'Save image recipe' dialog should be empty.
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
X-List-Received-Date: Tue, 17 Sep 2013 10:44:28 -0000

If my build starts from a custom image recipe, the 'Save image recipe'
dialog should populate the 'Name' and 'Description' fields with the values
set for the custom image recipe.

[YOCTO #5004]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index ca33e08..b5d9660 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -635,6 +635,14 @@ class ImageDetailsPage (HobPage):
         images_dir = topdir + "/recipes/images/"
         self.builder.ensure_dir(images_dir)
 
+        self.name_field_template = self.builder.image_configuration_page.custom_image_selected
+        if self.name_field_template:
+            image_path = self.builder.recipe_model.pn_path[self.name_field_template]
+            image_iter = self.builder.recipe_model.get_iter(image_path)
+            self.description_field_template = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC)
+        else:
+            self.name_field_template = ""
+
         dialog = SaveImageDialog(images_dir, self.name_field_template, self.description_field_template,
                  "Save image recipe", self.builder, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
         response = dialog.run()
-- 
1.7.9.5


