Return-Path: <valentin.popa@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id D57CB610DC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Sep 2013 11:16:40 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 25 Sep 2013 04:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,978,1371106800"; d="scan'208";a="365327362"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by azsmga001.ch.intel.com with ESMTP; 25 Sep 2013 04:16:39 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 Sep 2013 14:18:19 +0300
Message-Id: <1380107900-4395-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 1/2] HOB: HIG compliant message dialogs
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
X-List-Received-Date: Wed, 25 Sep 2013 11:16:42 -0000

"More" HIG compliant dialogs for HOB.

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                | 99 ++++++++++++----------
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |  5 +-
 .../lib/bb/ui/crumbs/hig/crumbsmessagedialog.py    | 56 ++++--------
 bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py  | 12 ++-
 .../lib/bb/ui/crumbs/hig/layerselectiondialog.py   | 11 +--
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py    |  5 +-
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  4 +-
 7 files changed, 90 insertions(+), 102 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 86fdbfe..433ff11 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -793,8 +793,8 @@ class Builder(gtk.Window):
                 self.generate_image_async(True)
 
     def show_error_dialog(self, msg):
-        lbl = "<b>Hob found an error</b>\n"
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR, msg)
+        lbl = "<b>Hob found an error</b>"
+        dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_ERROR, msg)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         response = dialog.run()
@@ -810,10 +810,9 @@ class Builder(gtk.Window):
         dialog.destroy()
 
     def show_network_error_dialog(self):
-        lbl = "<b>Hob cannot connect to the network</b>\n"
-        msg = "Please check your network connection. If you are using a proxy server, please make sure it is configured correctly."
-        lbl = lbl + "%s\n\n" % glib.markup_escape_text(msg)
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        lbl = "<b>Hob cannot connect to the network</b>"
+        msg = msg + "Please check your network connection. If you are using a proxy server, please make sure it is configured correctly."
+        dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_ERROR, msg)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         button = dialog.add_button("Proxy settings", gtk.RESPONSE_CANCEL)
@@ -1036,7 +1035,7 @@ class Builder(gtk.Window):
         self.build_failed()
 
     def handler_no_provider_cb(self, running_build, msg):
-        dialog = CrumbsMessageDialog(self, glib.markup_escape_text(msg), gtk.STOCK_DIALOG_INFO)
+        dialog = CrumbsMessageDialog(self, glib.markup_escape_text(msg), gtk.MESSAGE_INFO)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         dialog.run()
@@ -1099,9 +1098,10 @@ class Builder(gtk.Window):
     def build_packages(self):
         _, all_recipes = self.recipe_model.get_selected_recipes()
         if not all_recipes:
-            lbl = "<b>No selections made</b>\nYou have not made any selections"
-            lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            lbl = "<b>No selections made</b>"
+            msg = "You have not made any selections"
+            msg = msg + " so there isn't anything to bake at this time."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1112,9 +1112,10 @@ class Builder(gtk.Window):
     def build_image(self):
         selected_packages = self.package_model.get_selected_packages()
         if not selected_packages:      
-            lbl = "<b>No selections made</b>\nYou have not made any selections"
-            lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            lbl = "<b>No selections made</b>"
+            msg = "You have not made any selections"
+            msg = msg + " so there isn't anything to bake at this time."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1128,9 +1129,10 @@ class Builder(gtk.Window):
 
         # If no base image and no selected packages don't build anything
         if not (selected_packages or selected_image != self.recipe_model.__custom_image__):
-            lbl = "<b>No selections made</b>\nYou have not made any selections"
-            lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            lbl = "<b>No selections made</b>"
+            msg = "You have not made any selections"
+            msg = msg + " so there isn't anything to bake at this time."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1214,8 +1216,9 @@ class Builder(gtk.Window):
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
             if not dialog.image_names:
-                lbl = "<b>No selections made</b>\nYou have not made any selections"
-                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                lbl = "<b>No selections made</b>"
+                msg = "You have not made any selections"
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
                 button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
                 HobButton.style_button(button)
                 crumbs_dialog.run()
@@ -1302,7 +1305,7 @@ class Builder(gtk.Window):
     def deploy_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to deploy.</b>"
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1349,7 +1352,7 @@ class Builder(gtk.Window):
     def runqemu_image(self, image_name, kernel_name):
         if not image_name or not kernel_name:
             lbl = "<b>Please select an %s to launch in QEMU.</b>" % ("kernel" if image_name else "image")
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1370,14 +1373,15 @@ class Builder(gtk.Window):
             cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"
             subprocess.Popen(shlex.split(cmdline))
         else:
-            lbl = "<b>Path error</b>\nOne of your paths is wrong,"
-            lbl = lbl + " please make sure the following paths exist:\n"
-            lbl = lbl + "image path:" + image_path + "\n"
-            lbl = lbl + "kernel path:" + kernel_path + "\n"
-            lbl = lbl + "source environment path:" + source_env_path + "\n"
-            lbl = lbl + "tmp path: " + tmp_path + "."
-            lbl = lbl + "You may be missing either xterm or vte for terminal services."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+            lbl = "<b>Path error</b>"
+            msg = "One of your paths is wrong,"
+            msg = msg + " please make sure the following paths exist:\n"
+            msg = msg + "image path:" + image_path + "\n"
+            msg = msg + "kernel path:" + kernel_path + "\n"
+            msg = msg + "source environment path:" + source_env_path + "\n"
+            msg = msg + "tmp path: " + tmp_path + "."
+            msg = msg + "You may be missing either xterm or vte for terminal services."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_ERROR, msg)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             dialog.run()
@@ -1386,9 +1390,10 @@ class Builder(gtk.Window):
     def show_packages(self, ask=True):
         _, selected_recipes = self.recipe_model.get_selected_recipes()
         if selected_recipes and ask:
-            lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
-            lbl = lbl + " to get a full list or just view the existing packages?"
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            lbl = "<b>Package list may be incomplete!</b>"
+            msg = "Do you want to build selected recipes"
+            msg = msg + " to get a full list or just view the existing packages?"
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
             button = dialog.add_button("View packages", gtk.RESPONSE_NO)
             HobAltButton.style_button(button)
             button = dialog.add_button("Build packages", gtk.RESPONSE_YES)
@@ -1414,26 +1419,28 @@ class Builder(gtk.Window):
 
     def stop_build(self):
         if self.stopping:
-            lbl = "<b>Force Stop build?</b>\nYou've already selected Stop once,"
-            lbl = lbl + " would you like to 'Force Stop' the build?\n\n"
-            lbl = lbl + "This will stop the build as quickly as possible but may"
-            lbl = lbl + " well leave your build directory in an  unusable state"
-            lbl = lbl + " that requires manual steps to fix.\n"
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            lbl = "<b>Force Stop build?</b>"
+            msg = "You've already selected Stop once,"
+            msg = msg + " would you like to 'Force Stop' the build?\n\n"
+            msg = msg + "This will stop the build as quickly as possible but may"
+            msg = msg + " well leave your build directory in an  unusable state"
+            msg = msg + " that requires manual steps to fix."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_WARNING, msg)
             button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
             HobAltButton.style_button(button)
             button = dialog.add_button("Force Stop", gtk.RESPONSE_YES)
             HobButton.style_button(button)
         else:
-            lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this"
-            lbl = lbl + " build?\n\n'Stop' will stop the build as soon as all in"
-            lbl = lbl + " progress build tasks are finished. However if a"
-            lbl = lbl + " lengthy compilation phase is in progress this may take"
-            lbl = lbl + " some time.\n\n"
-            lbl = lbl + "'Force Stop' will stop the build as quickly as"
-            lbl = lbl + " possible but may well leave your build directory in an"
-            lbl = lbl + " unusable state that requires manual steps to fix."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            lbl = "<b>Stop build?</b>"
+            msg = "Are you sure you want to stop this"
+            msg = msg + " build?\n\n'Stop' will stop the build as soon as all in"
+            msg = msg + " progress build tasks are finished. However if a"
+            msg = msg + " lengthy compilation phase is in progress this may take"
+            msg = msg + " some time.\n\n"
+            msg = msg + "'Force Stop' will stop the build as quickly as"
+            msg = msg + " possible but may well leave your build directory in an"
+            msg = msg + " unusable state that requires manual steps to fix."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_WARNING, msg)
             button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
             HobAltButton.style_button(button)
             button = dialog.add_button("Force stop", gtk.RESPONSE_YES)
diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index 86a65ae..5b449cd 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -183,8 +183,9 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.set_save_button_state()
         if self.get_num_checked_image_types() == 0:
             # Show an error dialog
-            lbl = "<b>Select an image type</b>\n\nYou need to select at least one image type."
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            lbl = "<b>Select an image type</b>"
+            msg = "You need to select at least one image type."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_WARNING, msg)
             button = dialog.add_button("OK", gtk.RESPONSE_OK)
             HobButton.style_button(button)
             response = dialog.run()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/crumbsmessagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/crumbsmessagedialog.py
index 097ce7b..b9a32ae 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/crumbsmessagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/crumbsmessagedialog.py
@@ -31,51 +31,28 @@ BitBake GUI's
 In summary: spacing = 12px, border-width = 6px
 """
 
-class CrumbsMessageDialog(CrumbsDialog):
+class CrumbsMessageDialog(gtk.MessageDialog):
     """
     A GNOME HIG compliant dialog widget.
     Add buttons with gtk.Dialog.add_button or gtk.Dialog.add_buttons
     """
-    def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO, msg=""):
-        super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_MODAL)
+    def __init__(self, parent = None, label="", dialog_type = gtk.MESSAGE_QUESTION, msg=""):
+        super(CrumbsMessageDialog, self).__init__(None, 
+                                                  gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
+                                                  dialog_type,
+                                                  gtk.BUTTONS_NONE,
+                                                  None)
 
-        self.set_border_width(6)
-        self.vbox.set_property("spacing", 12)
-        self.action_area.set_property("spacing", 12)
-        self.action_area.set_property("border-width", 6)
+        self.set_skip_taskbar_hint(False)
 
-        first_column = gtk.HBox(spacing=12)
-        first_column.set_property("border-width", 6)
-        first_column.show()
-        self.vbox.add(first_column)
-
-        self.icon = gtk.Image()
-        # We have our own Info icon which should be used in preference of the stock icon
-        self.icon_chk = HobIconChecker()
-        self.icon.set_from_stock(self.icon_chk.check_stock_icon(icon), gtk.ICON_SIZE_DIALOG)
-        self.icon.set_property("yalign", 0.00)
-        self.icon.show()
-        first_column.pack_start(self.icon, expand=False, fill=True, padding=0)
+        self.set_markup(label)
         
-        if 0 <= len(msg) < 200:
-            lbl = label + "%s" % glib.markup_escape_text(msg)
-            self.label_short = gtk.Label()
-            self.label_short.set_use_markup(True)
-            self.label_short.set_line_wrap(True)
-            self.label_short.set_markup(lbl)
-            self.label_short.set_property("yalign", 0.00)
-            self.label_short.show()
-            first_column.add(self.label_short)
+        if 0 <= len(msg) < 300:
+            self.format_secondary_markup(msg)
         else:
-            second_row = gtk.VBox(spacing=12)
-            second_row.set_property("border-width", 6)
-            self.label_long = gtk.Label()
-            self.label_long.set_use_markup(True)
-            self.label_long.set_line_wrap(True)
-            self.label_long.set_markup(label)
-            self.label_long.set_alignment(0.0, 0.0)
-            second_row.pack_start(self.label_long, expand=False, fill=False, padding=0)
-            self.label_long.show()
+            vbox = self.get_message_area()
+            vbox.set_border_width(1)
+            vbox.set_property("spacing", 12)
             self.textWindow = gtk.ScrolledWindow()
             self.textWindow.set_shadow_type(gtk.SHADOW_IN)
             self.textWindow.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
@@ -89,7 +66,6 @@ class CrumbsMessageDialog(CrumbsDialog):
             self.msgView.set_buffer(self.buf)
             self.textWindow.add(self.msgView)
             self.msgView.show()
-            second_row.add(self.textWindow)
+            vbox.add(self.textWindow)
             self.textWindow.show()
-            first_column.add(second_row)
-            second_row.show()
+
diff --git a/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
index bc1efbb..f64fbd6 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/deployimagedialog.py
@@ -160,6 +160,7 @@ class DeployImageDialog (CrumbsDialog):
     def response_cb(self, dialog, response_id):
         if response_id == gtk.RESPONSE_YES:
             lbl = ''
+            msg = ''
             combo_item = self.usb_combo.get_active_text()
             if combo_item and combo_item != self.__dummy_usb__ and self.image_path:
                 cmdline = bb.ui.crumbs.utils.which_terminal()
@@ -172,15 +173,18 @@ class DeployImageDialog (CrumbsDialog):
                     if int(tmpfile.readline().strip()) == 0:
                         lbl = "<b>Deploy image successfully.</b>"
                     else:
-                        lbl = "<b>Failed to deploy image.</b>\nPlease check image <b>%s</b> exists and USB device <b>%s</b> is writable." % (self.image_path, combo_item)
+                        lbl = "<b>Failed to deploy image.</b>"
+                        msg = "Please check image <b>%s</b> exists and USB device <b>%s</b> is writable." % (self.image_path, combo_item)
                     tmpfile.close()
             else:
                 if not self.image_path:
-                    lbl = "<b>No selection made.</b>\nYou have not selected an image to deploy."
+                    lbl = "<b>No selection made.</b>"
+                    msg = "You have not selected an image to deploy."
                 else:
-                    lbl = "<b>No selection made.</b>\nYou have not selected a USB device."
+                    lbl = "<b>No selection made.</b>"
+                    msg = "You have not selected a USB device."
             if len(lbl):
-                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO, msg)
                 button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
                 HobButton.style_button(button)
                 crumbs_dialog.run()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py b/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
index 783ee73..1d100c5 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/layerselectiondialog.py
@@ -92,7 +92,8 @@ class LayerSelectionDialog (CrumbsDialog):
         path = dialog.get_filename()
         dialog.destroy()
 
-        lbl = "<b>Error</b>\nUnable to load layer <i>%s</i> because " % path
+        lbl = "<b>Error</b>"
+        msg = "Unable to load layer <i>%s</i> because " % path
         if response == gtk.RESPONSE_YES:
             import os
             import os.path
@@ -103,15 +104,15 @@ class LayerSelectionDialog (CrumbsDialog):
                 it = layer_store.iter_next(it)
 
             if not path:
-                lbl += "it is an invalid path."
+                msg += "it is an invalid path."
             elif not os.path.exists(path+"/conf/layer.conf"):
-                lbl += "there is no layer.conf inside the directory."
+                msg += "there is no layer.conf inside the directory."
             elif path in layers:
-                lbl += "it is already in loaded layers."
+                msg += "it is already in loaded layers."
             else:
                 layer_store.append([path])
                 return
-            dialog = CrumbsMessageDialog(parent, lbl)
+            dialog = CrumbsMessageDialog(parent, lbl, gtk.MESSAGE_ERROR, msg)
             dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
             response = dialog.run()
             dialog.destroy()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index e940cee..4195f70 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -146,12 +146,11 @@ class SaveImageDialog (CrumbsDialog):
             self.show_invalid_input_error_dialog()
 
     def show_invalid_input_error_dialog(self):
-        lbl = "<b>Invalid characters in image recipe name</b>\n"
+        lbl = "<b>Invalid characters in image recipe name</b>"
         msg = "Image recipe names should be all lowercase and\n"
         msg += "include only alphanumeric characters. The only\n"
         msg += "special character you can use is the ASCII hyphen (-)."
-        lbl = lbl + "\n%s\n" % glib.markup_escape_text(msg)
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_ERROR, msg)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index de924b1..5229a3d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -214,9 +214,9 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
             # Check that all proxy entries have a corresponding port
             for proxy, port in zip(self.all_proxy_addresses, self.all_proxy_ports):
                 if proxy.get_text() and not port.get_text():
-                    lbl = "<b>Enter all port numbers</b>\n\n"
+                    lbl = "<b>Enter all port numbers</b>"
                     msg = "Proxy servers require a port number. Please make sure you have entered a port number for each proxy server."
-                    dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING, msg)
+                    dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_WARNING, msg)
                     button = dialog.add_button("Close", gtk.RESPONSE_OK)
                     HobButton.style_button(button)
                     response = dialog.run()
-- 
1.8.1.2


