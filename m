Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kHO-0005PI-O3
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:13:19 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 29 Feb 2012 06:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130968957"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 29 Feb 2012 06:04:49 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:13 +0800
Message-Id: <8066a034a16b78a8d8b74d8e3779ac47d7b9f1c2.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 16/32] crumbs: fix button order in several dialogues
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
X-List-Received-Date: Wed, 29 Feb 2012 14:13:19 -0000

GNOME HIG and Gtk+ convention is for the buttons to be ordered
<secondary action> <primary action> so that the primary action can be
selected easily by navigating to the bottom right of the dialogue.

We should try and match the convention and the HIG standard so that we
aren't contrasting the rest of the users applications.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   39 +++++++++++++++++------------------
 bitbake/lib/bb/ui/crumbs/hig.py     |   12 +++++-----
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 3daa677..7772f56 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -602,9 +602,9 @@ class Builder(gtk.Window):
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-        dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
-        dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
-        dialog.set_default_response(gtk.RESPONSE_NO)
+        dialog.add_button("Keep using Hob", gtk.RESPONSE_NO)
+        dialog.add_button("Exit Hob", gtk.RESPONSE_YES)
+        dialog.set_default_response(gtk.RESPONSE_YES)
         response = dialog.run()
         dialog.destroy()
         if response == gtk.RESPONSE_YES:
@@ -667,8 +667,8 @@ class Builder(gtk.Window):
                      flags = gtk.DIALOG_MODAL
                          | gtk.DIALOG_DESTROY_WITH_PARENT
                          | gtk.DIALOG_NO_SEPARATOR,
-                     buttons = (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                     buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                gtk.STOCK_OK, gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration.layers = dialog.layers
@@ -679,9 +679,9 @@ class Builder(gtk.Window):
 
     def show_load_template_dialog(self):
         dialog = gtk.FileChooserDialog("Load Template Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_OPEN, gtk.RESPONSE_YES,
-                                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                       gtk.FILE_CHOOSER_ACTION_OPEN,
+                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         filter = gtk.FileFilter()
         filter.set_name("Hob Files")
         filter.add_pattern("*.hob")
@@ -696,8 +696,8 @@ class Builder(gtk.Window):
     def show_save_template_dialog(self):
         dialog = gtk.FileChooserDialog("Save Template Files", self,
                                        gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_SAVE, gtk.RESPONSE_YES,
-                                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                       gtk.STOCK_SAVE, gtk.RESPONSE_YES))
         dialog.set_current_name("hob")
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
@@ -709,9 +709,8 @@ class Builder(gtk.Window):
         dialog = ImageSelectionDialog(self.parameters.image_addr, self.parameters.image_types,
                                       "Open My Images", self,
                                        gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_OPEN, gtk.RESPONSE_YES,
-                                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
-
+                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             if not dialog.image_names:
@@ -742,8 +741,8 @@ class Builder(gtk.Window):
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
                     | gtk.DIALOG_NO_SEPARATOR,
-            buttons = ("Save", gtk.RESPONSE_YES,
-                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+            buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                       "Save", gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
@@ -771,8 +770,8 @@ class Builder(gtk.Window):
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
                     | gtk.DIALOG_NO_SEPARATOR,
-            buttons = ("Make usb image", gtk.RESPONSE_YES,
-                       "Close", gtk.RESPONSE_NO))
+            buttons = ("Close", gtk.RESPONSE_NO,
+                       "Make usb image", gtk.RESPONSE_YES))
         response = dialog.run()
         dialog.destroy()
 
@@ -787,8 +786,8 @@ class Builder(gtk.Window):
 
         dialog = gtk.FileChooserDialog("Load Kernel Files", self,
                                        gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_OPEN, gtk.RESPONSE_YES,
-                                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         filter = gtk.FileFilter()
         filter.set_name("Kernel Files")
         filter.add_pattern("*.bin")
@@ -830,8 +829,8 @@ class Builder(gtk.Window):
             lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
             lbl = lbl + " to get a full list (Yes) or just view the existing packages (No)?"
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
             dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
+            dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
             dialog.set_default_response(gtk.RESPONSE_YES)
             response = dialog.run()
             dialog.destroy()
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index fdff10b..ec9dbec 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -162,8 +162,8 @@ class AdvancedSettingDialog (CrumbsDialog):
     def entry_widget_select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             path = dialog.get_filename()
@@ -823,8 +823,8 @@ class LayerSelectionDialog (CrumbsDialog):
     def layer_widget_add_clicked_cb(self, action, layer_store, parent):
         dialog = gtk.FileChooserDialog("Add new layer", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         label = gtk.Label("Select the layer you wish to add")
         label.show()
         dialog.set_extra_widget(label)
@@ -1068,8 +1068,8 @@ class ImageSelectionDialog (CrumbsDialog):
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             path = dialog.get_filename()
-- 
1.7.6



