Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E26C86B492
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:57:04 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372876010"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:57:04 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:21 +0300
Message-Id: <1375102770-14079-8-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 07/16] hob: change the name and description for the saveimagedialog
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
X-List-Received-Date: Mon, 29 Jul 2013 12:57:05 -0000

The image name and description should be saved for a future
save.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    8 +++++++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py    |    6 ++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index 9ea512f..a20afcd 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -29,10 +29,12 @@ class SaveImageDialog (CrumbsDialog):
     This class is used to create a dialog that permits to save
     a custom image in a predefined directory.
     """
-    def __init__(self, directory, title, parent, flags, buttons=None):
+    def __init__(self, directory, name, description, title, parent, flags, buttons=None):
         super(SaveImageDialog, self).__init__(title, parent, flags, buttons)
         self.directory = directory
         self.builder = parent
+        self.name_field = name
+        self.description_field = description
 
         # create visual elements on the dialog
         self.create_visual_elements()
@@ -52,6 +54,7 @@ class SaveImageDialog (CrumbsDialog):
         content += "characters. The only special character you can use is the ASCII hyphen (-)."
         sub_label.set_markup(content)
         self.name_entry = gtk.Entry()
+        self.name_entry.set_text(self.name_field)
         self.name_entry.set_size_request(350,30)
         self.name_entry.connect("changed", self.name_entry_changed)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -67,6 +70,7 @@ class SaveImageDialog (CrumbsDialog):
         sub_label.set_alignment(0, 0)
         sub_label.set_markup("The description should be less than 150 characters long.")
         self.description_entry = gtk.TextView()
+        self.description_entry.get_buffer().set_text(self.description_field)
         self.description_entry.set_wrap_mode(gtk.WRAP_WORD)
         self.description_entry.set_size_request(350,150)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -124,6 +128,8 @@ class SaveImageDialog (CrumbsDialog):
             self.builder.recipe_model.set_in_list(text, description)
             self.builder.recipe_model.set_selected_image(text)
             self.builder.image_details_page.show_page(self.builder.IMAGE_GENERATED)
+            self.builder.image_details_page.name_field_template = text
+            self.builder.image_details_page.description_field_template = description
             self.destroy()
         else:
             self.show_invalid_input_error_dialog()
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index eaa4588..f50552f 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -191,6 +191,8 @@ class ImageDetailsPage (HobPage):
         self.details_bottom_buttons = gtk.HBox(False, 6)
         self.image_saved = False
         self.create_visual_elements()
+        self.name_field_template = ""
+        self.description_field_template = ""
 
     def create_visual_elements(self):
         # create visual elements
@@ -632,8 +634,8 @@ class ImageDetailsPage (HobPage):
         images_dir = topdir + "/recipes/images/"
         self.builder.ensure_dir(images_dir)
 
-        dialog = SaveImageDialog(images_dir, "Save image recipe", self.builder,
-                              gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
+        dialog = SaveImageDialog(images_dir, self.name_field_template, self.description_field_template,
+                 "Save image recipe", self.builder, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
         response = dialog.run()
         dialog.destroy()
 
-- 
1.7.9.5


