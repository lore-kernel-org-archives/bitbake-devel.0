Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCNG4-0004Nd-Ja
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 05:39:45 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145976524"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.109])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 20:30:35 -0700
Message-Id: <6ef83f5b4a0ef4bef9e604113098b83d34c7e15b.1332818913.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
In-Reply-To: <cover.1332818913.git.josh@linux.intel.com>
References: <cover.1332818913.git.josh@linux.intel.com>
Subject: [PATCH 1/4] lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 27 Mar 2012 03:39:45 -0000

The design calls for primary buttons which are orange and large and
secondary buttons which are subtle with pale blue text. This is so that the
user is drawn towards the primary action and their use of the application
is more guided.

This patch uses HobButton and HobAltButton classes to style all dialogue
buttons accordingly.

Fixes [YOCTO #2125]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py |  108 +++++++++++++++++++++++++++---------------
 lib/bb/ui/crumbs/hig.py     |   34 ++++++++------
 2 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index f32a066..f57a855 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -32,7 +32,7 @@ from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
-from bb.ui.crumbs.hobwidget import hwc
+from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog
@@ -444,7 +444,8 @@ class Builder(gtk.Window):
             lbl = "<b>Error</b>\n"
             lbl = lbl + "%s\n\n" % msg
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             response = dialog.run()
             dialog.destroy()
         self.handler.clear_busy()
@@ -620,8 +621,10 @@ class Builder(gtk.Window):
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
-        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         dialog.set_default_response(gtk.RESPONSE_YES)
         response = dialog.run()
         dialog.destroy()
@@ -637,7 +640,8 @@ class Builder(gtk.Window):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             dialog.run()
             dialog.destroy()
             return
@@ -649,7 +653,8 @@ class Builder(gtk.Window):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             dialog.run()
             dialog.destroy()
             return
@@ -664,7 +669,8 @@ class Builder(gtk.Window):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             dialog.run()
             dialog.destroy()
             return
@@ -684,8 +690,9 @@ class Builder(gtk.Window):
                      parent = self,
                      flags = gtk.DIALOG_MODAL
                          | gtk.DIALOG_DESTROY_WITH_PARENT
-                         | gtk.DIALOG_NO_SEPARATOR,
-                     buttons = (gtk.STOCK_CLOSE, gtk.RESPONSE_YES))
+                         | gtk.DIALOG_NO_SEPARATOR)
+        button = dialog.add_button("Close", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration.layers = dialog.layers
@@ -696,9 +703,11 @@ class Builder(gtk.Window):
 
     def show_load_template_dialog(self):
         dialog = gtk.FileChooserDialog("Load Template Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_OPEN,
-                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_OPEN)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         filter = gtk.FileFilter()
         filter.set_name("Hob Files")
         filter.add_pattern("*.hob")
@@ -712,9 +721,11 @@ class Builder(gtk.Window):
 
     def show_save_template_dialog(self):
         dialog = gtk.FileChooserDialog("Save Template Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                       gtk.STOCK_SAVE, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Save", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         dialog.set_current_name("hob")
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
@@ -725,15 +736,18 @@ class Builder(gtk.Window):
     def show_load_my_images_dialog(self):
         dialog = ImageSelectionDialog(self.parameters.image_addr, self.parameters.image_types,
                                       "Open My Images", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             if not dialog.image_names:
                 lbl = "<b>No selections made</b>\nYou have not made any selections"
                 crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-                crumbs_dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
+                HobButton.style_button(button)
                 crumbs_dialog.run()
                 crumbs_dialog.destroy()
                 dialog.destroy()
@@ -756,9 +770,11 @@ class Builder(gtk.Window):
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
-                    | gtk.DIALOG_NO_SEPARATOR,
-            buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                       "Save", gtk.RESPONSE_YES))
+                    | gtk.DIALOG_NO_SEPARATOR)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Save", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
@@ -774,7 +790,8 @@ class Builder(gtk.Window):
         if not image_name:
             lbl = "<b>Please select an image to deploy.</b>"
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             dialog.run()
             dialog.destroy()
             return
@@ -785,9 +802,11 @@ class Builder(gtk.Window):
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
-                    | gtk.DIALOG_NO_SEPARATOR,
-            buttons = ("Close", gtk.RESPONSE_NO,
-                       "Make usb image", gtk.RESPONSE_YES))
+                    | gtk.DIALOG_NO_SEPARATOR)
+        button = dialog.add_button("Close", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Make usb image", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         dialog.destroy()
 
@@ -795,15 +814,18 @@ class Builder(gtk.Window):
         if not image_name:
             lbl = "<b>Please select an image to launch in QEMU.</b>"
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
             dialog.run()
             dialog.destroy()
             return
 
         dialog = gtk.FileChooserDialog("Load Kernel Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         filter = gtk.FileFilter()
         filter.set_name("Kernel Files")
         filter.add_pattern("*.bin")
@@ -835,7 +857,8 @@ class Builder(gtk.Window):
                 lbl = lbl + "source environment path:" + source_env_path + "\n"
                 lbl = lbl + "tmp path: " + tmp_path + "."
                 dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-                dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+                button = dialog.add_button("Close", gtk.RESPONSE_OK)
+                HobButton.style_button(button)
                 dialog.run()
                 dialog.destroy()
 
@@ -843,10 +866,12 @@ class Builder(gtk.Window):
         _, selected_recipes = self.recipe_model.get_selected_recipes()
         if selected_recipes and ask:
             lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
-            lbl = lbl + " to get a full list (Yes) or just view the existing packages (No)?"
+            lbl = lbl + " to get a full list or just view the existing packages?"
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
-            dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
+            button = dialog.add_button("View packages", gtk.RESPONSE_NO)
+            HobAltButton.style_button(button)
+            button = dialog.add_button("Build packages", gtk.RESPONSE_YES)
+            HobButton.style_button(button)
             dialog.set_default_response(gtk.RESPONSE_YES)
             response = dialog.run()
             dialog.destroy()
@@ -879,8 +904,10 @@ class Builder(gtk.Window):
             lbl = lbl + " well leave your build directory in an  unusable state"
             lbl = lbl + " that requires manual steps to fix.\n"
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
-            dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+            button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
+            HobAltButton.style_button(button)
+            button = dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+            HobButton.style_button(button)
         else:
             lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this"
             lbl = lbl + " build?\n\n'Force Stop' will stop the build as quickly as"
@@ -891,9 +918,12 @@ class Builder(gtk.Window):
             lbl = lbl + " lengthy compilation phase is in progress this may take"
             lbl = lbl + " some time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
-            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
-            dialog.add_button("Stop", gtk.RESPONSE_OK)
-            dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+            button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
+            HobAltButton.style_button(button)
+            button = dialog.add_button("Stop", gtk.RESPONSE_OK)
+            HobAltButton.style_button(button)
+            button = dialog.add_button("Force Stop", gtk.RESPONSE_YES)
+            HobButton.style_button(button)
         response = dialog.run()
         dialog.destroy()
         if response != gtk.RESPONSE_CANCEL:
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 6ae682b..a30e7d9 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton
+from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -137,9 +137,11 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def entry_widget_select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             path = dialog.get_filename()
@@ -307,7 +309,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, parent, flags, buttons):
+            max_threads, parent, flags, buttons=None):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -563,7 +565,7 @@ class DeployImageDialog (CrumbsDialog):
 
     __dummy_usb__ = "--select a usb drive--"
 
-    def __init__(self, title, image_path, parent, flags, buttons):
+    def __init__(self, title, image_path, parent, flags, buttons=None):
         super(DeployImageDialog, self).__init__(title, parent, flags, buttons)
 
         self.image_path = image_path
@@ -713,9 +715,11 @@ class LayerSelectionDialog (CrumbsDialog):
 
     def layer_widget_add_clicked_cb(self, action, layer_store, parent):
         dialog = gtk.FileChooserDialog("Add new layer", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         label = gtk.Label("Select the layer you wish to add")
         label.show()
         dialog.set_extra_widget(label)
@@ -827,7 +831,7 @@ class LayerSelectionDialog (CrumbsDialog):
     def add_leave_cb(self, button, event):
         self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
 
-    def __init__(self, title, layers, all_layers, parent, flags, buttons):
+    def __init__(self, title, layers, all_layers, parent, flags, buttons=None):
         super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -921,7 +925,7 @@ class ImageSelectionDialog (CrumbsDialog):
     }]
 
 
-    def __init__(self, image_folder, image_types, title, parent, flags, buttons):
+    def __init__(self, image_folder, image_types, title, parent, flags, buttons=None):
         super(ImageSelectionDialog, self).__init__(title, parent, flags, buttons)
         self.connect("response", self.response_cb)
 
@@ -975,9 +979,11 @@ class ImageSelectionDialog (CrumbsDialog):
 
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
-                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             path = dialog.get_filename()
-- 
1.7.7.6



