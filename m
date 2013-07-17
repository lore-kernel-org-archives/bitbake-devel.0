Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9DE896B26A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:48 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366549995"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:48 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:42 +0300
Message-Id: <1374057344-19708-13-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 12/14] hob: implement the "retrieve image dialog" + changes to image combo box
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
X-List-Received-Date: Wed, 17 Jul 2013 10:33:48 -0000

Tha changes related to the image combo box are related to the
action done in the retrieveImageDialog. When the user wants to select
a customize image, but then he cancels the action, the combo box is set to
--select a base image--.
If the user selects an image using the new dialog, a new item with its name
is added to the combo box list and then it is activated.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    1 +
 .../lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   49 ++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   37 +++++++++++++--
 3 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7e33f92..c9c36bc 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -520,6 +520,7 @@ class Builder(gtk.Window):
         self.handler.generate_configuration()
 
     def initiate_new_build_async(self):
+        self.configuration.selected_image = None
         self.switch_page(self.MACHINE_SELECTION)
         self.handler.init_cooker()
         self.handler.set_extra_inherit("image_types")
diff --git a/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
new file mode 100644
index 0000000..896c117
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
@@ -0,0 +1,49 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011-2012   Intel Corporation
+#
+# Authored by Cristiana Voicu <cristiana.voicu@intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gtk
+
+class RetrieveImageDialog (gtk.FileChooserDialog):
+    """
+    This class is used to create a dialog that permits to retrieve
+    a custom image saved previously from Hob.
+    """
+    def __init__(self, directory,title, parent, flags, buttons=None):
+        super(RetrieveImageDialog, self).__init__(title, None, gtk.FILE_CHOOSER_ACTION_OPEN,
+            (gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,gtk.STOCK_OPEN, gtk.RESPONSE_OK))
+        self.directory = directory
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def create_visual_elements(self):
+        self.set_show_hidden(True)
+        self.set_default_response(gtk.RESPONSE_OK)
+        self.set_current_folder(self.directory)
+
+        vbox = self.get_children()[0].get_children()[0].get_children()[0]
+        for child in vbox.get_children()[0].get_children()[0].get_children()[0].get_children():
+            vbox.get_children()[0].get_children()[0].get_children()[0].remove(child)
+
+        label1 = gtk.Label()
+        label1.set_text("File system:  " + self.directory)
+        label1.show()
+        vbox.get_children()[0].get_children()[0].get_children()[0].pack_start(label1, expand=False, fill=False, padding=0)
+        vbox.get_children()[0].get_children()[1].get_children()[0].hide()
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index b0a5e7a..b0a2bd8 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -28,6 +28,7 @@ from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton, HobAltButton, HobButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
+from bb.ui.crumbs.hig.retrieveimagedialog import RetrieveImageDialog
 
 #
 # ImageConfigurationPage
@@ -48,6 +49,7 @@ class ImageConfigurationPage (HobPage):
         self.machine_combo_changed_by_manual = True
         self.stopping = False
         self.warning_shift = 0
+        self.custom_image_selected = None
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -366,8 +368,28 @@ class ImageConfigurationPage (HobPage):
         self.builder.window_sensitive(False)
         selected_image = self.image_combo.get_active_text()
         if selected_image == self.__custom_image__:
-            return
+            topdir = self.builder.get_topdir()
+            images_dir = topdir + "/recipes/images/"
+            self.builder.ensure_dir(images_dir)
+
+            dialog = RetrieveImageDialog(images_dir, "Select a base image",
+                            self.builder, gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
+            response = dialog.run()
+            if response == gtk.RESPONSE_OK:
+                image_name = dialog.get_filename()
+                head, tail = os.path.split(image_name)
+                selected_image = os.path.splitext(tail)[0]
+                self.custom_image_selected = selected_image
+                self.update_image_combo(self.builder.recipe_model, selected_image)
+            else:
+                selected_image = self.__dummy_image__
+                self.update_image_combo(self.builder.recipe_model, None)
+            dialog.destroy()
+
         if not selected_image or (selected_image == self.__dummy_image__):
+            self.builder.window_sensitive(True)
+            self.just_bake_button.hide()
+            self.edit_image_button.hide()
             return
 
         # remove __dummy_image__ item from the store list after first user selection
@@ -436,6 +458,7 @@ class ImageConfigurationPage (HobPage):
         self.image_combo.append_text(self.__custom_image__)
         self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
         self.image_combo.append_text("--Separator--")
+        cnt = cnt + 3
 
         topdir = self.builder.get_topdir()
         # append and set active
@@ -471,6 +494,14 @@ class ImageConfigurationPage (HobPage):
                     active = cnt
                 cnt = cnt + 1
 
+        if self.custom_image_selected:
+            self.image_combo.append_text("--Separator--")
+            cnt = cnt + 1
+            self.image_combo.append_text(self.custom_image_selected)
+            if self.custom_image_selected == selected_image:
+                active = cnt
+            cnt = cnt + 1
+
         if selected_image == self.builder.recipe_model.__custom_image__:
             active = cnt
 
@@ -484,14 +515,14 @@ class ImageConfigurationPage (HobPage):
     def layer_button_clicked_cb(self, button):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
-        
+
     def view_adv_configuration_button_clicked_cb(self, button):
         # Create an advanced settings dialog
         response, settings_changed = self.builder.show_adv_settings_dialog()
         if not response:
             return
         if settings_changed:
-            self.builder.reparse_post_adv_settings()        
+            self.builder.reparse_post_adv_settings()
 
     def just_bake_button_clicked_cb(self, button):
         self.builder.parsing_warnings = []
-- 
1.7.9.5


