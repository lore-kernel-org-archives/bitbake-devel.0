Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 711D56B486
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:57:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:57:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372875993"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:57:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:19 +0300
Message-Id: <1375102770-14079-6-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 05/16] hob: make changes in order to permit from UI to edit an image after saving it
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
X-List-Received-Date: Mon, 29 Jul 2013 12:57:02 -0000

Added the image name to the list model, in order to show the image name as
the user named it.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    4 ++++
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py        |   28 +++++++++++++++--------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py    |   10 ++++++--
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index b94e69f..9ea512f 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -119,7 +119,11 @@ class SaveImageDialog (CrumbsDialog):
         description_buffer = self.description_entry.get_buffer()
         description = description_buffer.get_text(description_buffer.get_start_iter(),description_buffer.get_end_iter())
         if new_text.islower() and new_text.isalnum():
+            self.builder.image_details_page.image_saved = True
             self.builder.generate_new_image(self.directory+text, description)
+            self.builder.recipe_model.set_in_list(text, description)
+            self.builder.recipe_model.set_selected_image(text)
+            self.builder.image_details_page.show_page(self.builder.IMAGE_GENERATED)
             self.destroy()
         else:
             self.show_invalid_input_error_dialog()
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index d8f3256..34ff76a 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -678,15 +678,8 @@ class RecipeListModel(gtk.ListStore):
         self.clear()
 
         # dummy image for prompt
-        self.set(self.append(), self.COL_NAME, self.__custom_image__,
-                 self.COL_DESC, "Use 'Edit image recipe' to customize recipes and packages " \
-                                "to be included in your image ",
-                 self.COL_LIC, "", self.COL_GROUP, "",
-                 self.COL_DEPS, "", self.COL_BINB, "",
-                 self.COL_TYPE, "image", self.COL_INC, False,
-                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__,
-                 self.COL_SUMMARY, "", self.COL_VERSION, "", self.COL_REVISION, "",
-                 self.COL_HOMEPAGE, "", self.COL_BUGTRACKER, "")
+        self.set_in_list(self.__custom_image__,  "Use 'Edit image recipe' to customize recipes and packages " \
+                                "to be included in your image ")
 
         for item in event_model["pn"]:
             name = item
@@ -732,6 +725,23 @@ class RecipeListModel(gtk.ListStore):
             self.pn_path[pn] = path
             it = self.iter_next(it)
 
+    def set_in_list(self, item, desc):
+        self.set(self.append(), self.COL_NAME, item,
+                 self.COL_DESC, desc,
+                 self.COL_LIC, "", self.COL_GROUP, "",
+                 self.COL_DEPS, "", self.COL_BINB, "",
+                 self.COL_TYPE, "image", self.COL_INC, False,
+                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, item,
+                 self.COL_SUMMARY, "", self.COL_VERSION, "", self.COL_REVISION, "",
+                 self.COL_HOMEPAGE, "", self.COL_BUGTRACKER, "")
+        self.pn_path = {}
+        it = self.get_iter_first()
+        while it:
+            pn = self.get_value(it, self.COL_NAME)
+            path = self.get_path(it)
+            self.pn_path[pn] = path
+            it = self.iter_next(it)
+
     """
     Update the model, send out the notification.
     """
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index f55d43f..eaa4588 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -189,6 +189,7 @@ class ImageDetailsPage (HobPage):
         self.image_store = []
         self.button_ids = {}
         self.details_bottom_buttons = gtk.HBox(False, 6)
+        self.image_saved = False
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -248,7 +249,7 @@ class ImageDetailsPage (HobPage):
         self.pack_start(self.group_align, expand=True, fill=True)
 
         self.build_result = None
-        if self.build_succeeded and self.builder.current_step == self.builder.IMAGE_GENERATING:
+        if self.image_saved or (self.build_succeeded and self.builder.current_step == self.builder.IMAGE_GENERATING):
             # building is the previous step
             icon = gtk.Image()
             pixmap_path = hic.ICON_INDI_CONFIRM_FILE
@@ -256,7 +257,10 @@ class ImageDetailsPage (HobPage):
             pix_buffer = gtk.gdk.pixbuf_new_from_file(pixmap_path)
             icon.set_from_pixbuf(pix_buffer)
             varlist = [""]
-            vallist = ["Your image is ready"]
+            if self.image_saved:
+                vallist = ["Your image recipe has been saved"]
+            else:
+                vallist = ["Your image is ready"]
             self.build_result = self.BuildDetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
@@ -397,6 +401,7 @@ class ImageDetailsPage (HobPage):
         self.show_all()
         if self.kernel_detail and (not is_runnable):
             self.kernel_detail.hide()
+        self.image_saved = False
 
     def view_files_clicked_cb(self, button, image_addr):
         subprocess.call("xdg-open /%s" % image_addr, shell=True)
@@ -583,6 +588,7 @@ class ImageDetailsPage (HobPage):
         name = "Save image recipe"
         if name in buttonlist and self.builder.recipe_model.is_custom_image():
             save_button = HobAltButton("Save image recipe")
+            save_button.set_sensitive(not self.image_saved)
             button_id = save_button.connect("clicked", self.save_button_clicked_cb)
             self.button_ids[button_id] = save_button
             self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
-- 
1.7.9.5


