Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BDCBA6B452
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:56:58 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372875960"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:56:58 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:16 +0300
Message-Id: <1375102770-14079-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 02/16] hob: create save image dialog used to save a template
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
X-List-Received-Date: Mon, 29 Jul 2013 12:56:59 -0000

Implemented a new dialog used by Hob. This dialog was desinged
in order to permit to save only in a particular directory.
Also, it has a field where the user can type a description
for the image.
Implemented in the handler a method to retrieve the topdir variable,
because the changes will be saved in {topdir}/recipes/images directory.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py             |    3 +
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |  136 +++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py     |    3 +
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py        |    3 +
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py    |   20 +++-
 5 files changed, 163 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index a7bd21c..317a2fe 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1451,3 +1451,6 @@ class Builder(gtk.Window):
             self.consolelog.setFormatter(format)
 
             self.logger.addHandler(self.consolelog)
+
+    def get_topdir(self):
+        return self.handler.get_topdir()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
new file mode 100644
index 0000000..3fc389a
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -0,0 +1,136 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2013   Intel Corporation
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
+import glib
+from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
+from bb.ui.crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
+from bb.ui.crumbs.hobwidget import HobButton
+
+class SaveImageDialog (CrumbsDialog):
+    """
+    This class is used to create a dialog that permits to save
+    a custom image in a predefined directory.
+    """
+    def __init__(self, directory, title, parent, flags, buttons=None):
+        super(SaveImageDialog, self).__init__(title, parent, flags, buttons)
+        self.directory = directory
+        self.builder = parent
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+
+    def create_visual_elements(self):
+        self.set_default_response(gtk.RESPONSE_OK)
+        self.vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 12)
+        self.vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup("<b>Name</b>")
+        sub_label = gtk.Label()
+        sub_label.set_alignment(0, 0)
+        content = "Image recipe names should be all lowercase and include only alphanumeric\n"
+        content += "characters. The only special character you can use is the ASCII hyphen (-)."
+        sub_label.set_markup(content)
+        self.name_entry = gtk.Entry()
+        self.name_entry.set_size_request(350,30)
+        self.name_entry.connect("changed", self.name_entry_changed)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sub_label, expand=False, fill=False)
+        sub_vbox.pack_start(self.name_entry, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 12)
+        self.vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup("<b>Description</b> (optional)")
+        sub_label = gtk.Label()
+        sub_label.set_alignment(0, 0)
+        sub_label.set_markup("The description should be less than 150 characters long.")
+        self.description_entry = gtk.TextView()
+        self.description_entry.set_wrap_mode(gtk.WRAP_WORD)
+        self.description_entry.set_size_request(350,150)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sub_label, expand=False, fill=False)
+        sub_vbox.pack_start(self.description_entry, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 12)
+        self.vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup("Your image recipe will be saved to:")
+        sub_label = gtk.Label()
+        sub_label.set_alignment(0, 0)
+        sub_label.set_markup(self.directory)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sub_label, expand=False, fill=False)
+
+        table = gtk.Table(1, 4, True)
+
+        cancel_button = gtk.Button()
+        cancel_button.set_label("Cancel")
+        cancel_button.connect("clicked", self.cancel_button_cb)
+        cancel_button.set_size_request(110, 30)
+
+        self.save_button = gtk.Button()
+        self.save_button.set_label("Save")
+        self.save_button.connect("clicked", self.save_button_cb)
+        self.save_button.set_size_request(110, 30)
+        self.save_button.set_sensitive(False)
+
+        table.attach(cancel_button, 2, 3, 0, 1)
+        table.attach(self.save_button, 3, 4, 0, 1)
+        self.vbox.pack_end(table, expand=False, fill=False)
+
+        self.show_all()
+
+    def name_entry_changed(self, entry):
+        text = entry.get_text()
+        if text == '':
+            self.save_button.set_sensitive(False)
+        else:
+            self.save_button.set_sensitive(True)
+
+    def cancel_button_cb(self, button):
+        self.destroy()
+
+    def save_button_cb(self, button):
+        text = self.name_entry.get_text()
+        new_text = text.replace("-","")
+        if new_text.islower() and new_text.isalnum():
+            print(text)
+            self.destroy()
+        else:
+            self.show_invalid_input_error_dialog()
+
+    def show_invalid_input_error_dialog(self):
+        lbl = "<b>Invalid characters in image recipe name</b>\n"
+        msg = "Image recipe names should be all lowercase and\n"
+        msg += "include only alphanumeric characters. The only\n"
+        msg += "special character you can use is the ASCII hyphen (-)."
+        lbl = lbl + "\n%s\n" % glib.markup_escape_text(msg)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+        HobButton.style_button(button)
+
+        res = dialog.run()
+        dialog.destroy()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 4c6e6fd..294eb5d 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -452,6 +452,9 @@ class HobHandler(gobject.GObject):
     def get_logfile(self):
         return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])[0]
 
+    def get_topdir(self):
+        return self.runCommand(["getVariable", "TOPDIR"]) or ""
+
     def _remove_redundant(self, string):
         ret = []
         for i in string.split():
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 94c2453..d8f3256 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -882,3 +882,6 @@ class RecipeListModel(gtk.ListStore):
 
     def get_custom_image_version(self):
         return self.custom_image_version
+
+    def is_custom_image(self):
+        return self.get_selected_image() == self.__custom_image__
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 4b0e749..a02ab61 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -27,6 +27,7 @@ from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
 import subprocess
 from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
+from bb.ui.crumbs.hig.saveimagedialog import SaveImageDialog
 
 #
 # ImageDetailsPage
@@ -259,7 +260,7 @@ class ImageDetailsPage (HobPage):
             self.build_result = self.BuildDetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
-        self.buttonlist = ["Build new image", "Run image", "Deploy image"]
+        self.buttonlist = ["Build new image", "Save image recipe", "Run image", "Deploy image"]
 
         # Name
         self.image_store = []
@@ -340,7 +341,7 @@ class ImageDetailsPage (HobPage):
         self.setting_detail = None
         if self.build_succeeded:
             vallist.append(machine)
-            if base_image == self.builder.recipe_model.__custom_image__:
+            if self.builder.recipe_model.is_custom_image():
                 if self.builder.configuration.initial_selected_image == self.builder.recipe_model.__custom_image__:
                     base_image ="New image recipe"
                 else:
@@ -579,6 +580,13 @@ class ImageDetailsPage (HobPage):
             created = True
             is_runnable = True
 
+        name = "Save image recipe"
+        if name in buttonlist and self.builder.recipe_model.is_custom_image():
+            save_button = HobAltButton("Save image recipe")
+            button_id = save_button.connect("clicked", self.save_button_clicked_cb)
+            self.button_ids[button_id] = save_button
+            self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
+
         name = "Build new image"
         if name in buttonlist:
             # create button "Build new image"
@@ -613,6 +621,14 @@ class ImageDetailsPage (HobPage):
             else:
                 self.builder.runqemu_image(self.toggled_image, self.sel_kernel)
 
+    def save_button_clicked_cb(self, button):
+        topdir = self.builder.get_topdir()
+        images_dir = topdir + "/recipes/images/"
+        dialog = SaveImageDialog(images_dir, "Save image recipe", self.builder,
+                              gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
+        response = dialog.run()
+        dialog.destroy()
+
     def build_new_button_clicked_cb(self, button):
         self.builder.initiate_new_build_async()
 
-- 
1.7.9.5


