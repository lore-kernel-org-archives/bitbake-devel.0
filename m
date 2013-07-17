Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 16D4D6B2A7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366549978"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:45 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:40 +0300
Message-Id: <1374057344-19708-11-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 10/14] hob: changes to image combo box
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
X-List-Received-Date: Wed, 17 Jul 2013 10:33:46 -0000

Added an item for the custom images.
Added a separator in the combo box.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index d5fc297..60d9eba 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -36,6 +36,7 @@ class ImageConfigurationPage (HobPage):
 
     __dummy_machine__ = "--select a machine--"
     __dummy_image__   = "--select a base image--"
+    __custom_image__  = "Select from my base images"
 
     def __init__(self, builder):
         super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
@@ -238,6 +239,7 @@ class ImageConfigurationPage (HobPage):
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
+        self.image_combo.set_row_separator_func(self.combo_separator_func, None)
         self.image_combo_id = self.image_combo.connect("changed", self.image_combo_changed_cb)
 
         self.image_desc = gtk.Label()
@@ -256,6 +258,11 @@ class ImageConfigurationPage (HobPage):
 
         self.image_separator = gtk.HSeparator()
 
+    def combo_separator_func(self, model, iter, user_data):
+        name = model.get_value(iter, 0)
+        if name == "--Separator--":
+            return True
+
     def set_config_baseimg_layout(self):
         self.gtable.attach(self.image_title, 0, 40, 15+self.warning_shift, 17+self.warning_shift)
         self.gtable.attach(self.image_title_desc, 0, 40, 18+self.warning_shift, 22+self.warning_shift)
@@ -358,6 +365,8 @@ class ImageConfigurationPage (HobPage):
     def image_combo_changed_cb(self, combo):
         self.builder.window_sensitive(False)
         selected_image = self.image_combo.get_active_text()
+        if selected_image == self.__custom_image__:
+            return
         if not selected_image or (selected_image == self.__dummy_image__):
             return
 
@@ -424,6 +433,10 @@ class ImageConfigurationPage (HobPage):
             self.image_combo.append_text(self.__dummy_image__)
             cnt = cnt + 1
 
+        self.image_combo.append_text(self.__custom_image__)
+        self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
+        self.image_combo.append_text("--Separator--")
+
         # append and set active
         while it:
             path = image_model.get_path(it)
@@ -453,7 +466,6 @@ class ImageConfigurationPage (HobPage):
                     active = cnt
                 cnt = cnt + 1
 
-        self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
         if selected_image == self.builder.recipe_model.__custom_image__:
             active = cnt
 
-- 
1.7.9.5


