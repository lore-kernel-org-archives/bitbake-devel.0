Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kEY-0005Ko-Gk
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:10:23 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Feb 2012 06:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="112766617"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 29 Feb 2012 06:01:36 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:10 +0800
Message-Id: <38049db3534b24633964ecab276ab2f44951944c.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 13/32] crumbs: Factor common dialogue configuration out
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
X-List-Received-Date: Wed, 29 Feb 2012 14:10:23 -0000

Factor out the base dialogue configuration into CrumbsDialog and create a new CrumbsMessageDialog which acts as the CrumbsDialog did to handle dialogues with buttons.

Adopt CrumbsMessageDialog wherever CrumbsDialog was used.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   28 ++++++++++++++--------------
 bitbake/lib/bb/ui/crumbs/hig.py     |   21 +++++++++++++++++----
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index fc231ef..8573213 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -33,7 +33,7 @@ from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
 from bb.ui.crumbs.hobwidget import hwc
-from bb.ui.crumbs.hig import CrumbsDialog, BinbDialog, \
+from bb.ui.crumbs.hig import CrumbsMessageDialog, BinbDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog, ImageSelectionDialog
 
@@ -237,7 +237,7 @@ class Builder(gtk.Window):
         else:
             lbl = "<b>Screen dimension mismatched</b>\nfor better usability and visual effects,"
             lbl = lbl + " the screen dimension should be 1024x768 or above."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -447,7 +447,7 @@ class Builder(gtk.Window):
         if self.ignore_all_errors == False:
             lbl = "<b>Error</b>\n"
             lbl = lbl + "%s\n\n" % msg
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.add_button("Ignore All", gtk.RESPONSE_REJECT)
             response = dialog.run()
@@ -601,7 +601,7 @@ class Builder(gtk.Window):
 
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
-        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
         dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
         dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
         dialog.set_default_response(gtk.RESPONSE_NO)
@@ -618,7 +618,7 @@ class Builder(gtk.Window):
         if not all_recipes:
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -630,7 +630,7 @@ class Builder(gtk.Window):
         if not selected_packages:      
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -645,7 +645,7 @@ class Builder(gtk.Window):
         if not (selected_packages or selected_image != self.recipe_model.__dummy_image__):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -716,7 +716,7 @@ class Builder(gtk.Window):
         if response == gtk.RESPONSE_YES:
             if not dialog.image_names:
                 lbl = "<b>No selections made</b>\nYou have not made any selections"
-                crumbs_dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
                 crumbs_dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
                 crumbs_dialog.run()
                 crumbs_dialog.destroy()
@@ -758,7 +758,7 @@ class Builder(gtk.Window):
     def deploy_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to deploy.</b>"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -779,7 +779,7 @@ class Builder(gtk.Window):
     def runqemu_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to launch in QEMU.</b>"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -819,7 +819,7 @@ class Builder(gtk.Window):
                 lbl = lbl + "kernel path:" + kernel_path + "\n"
                 lbl = lbl + "source environment path:" + source_env_path + "\n"
                 lbl = lbl + "tmp path: " + tmp_path + "."
-                dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
                 dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
                 dialog.run()
                 dialog.destroy()
@@ -829,7 +829,7 @@ class Builder(gtk.Window):
         if selected_recipes and ask:
             lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
             lbl = lbl + " to get a full list (Yes) or just view the existing packages (No)?"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
             dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
             dialog.set_default_response(gtk.RESPONSE_YES)
@@ -860,7 +860,7 @@ class Builder(gtk.Window):
             lbl = lbl + "This will stop the build as quickly as possible but may"
             lbl = lbl + " well leave your build directory in an  unusable state"
             lbl = lbl + " that requires manual steps to fix.\n"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
             dialog.add_button("Force Stop", gtk.RESPONSE_YES)
         else:
@@ -872,7 +872,7 @@ class Builder(gtk.Window):
             lbl = lbl + " progress build tasks are finished. However if a"
             lbl = lbl + " lengthy compilation phase is in progress this may take"
             lbl = lbl + " some time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
             dialog.add_button("Stop", gtk.RESPONSE_OK)
             dialog.add_button("Force Stop", gtk.RESPONSE_YES)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index cbad899..85efbe6 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -45,11 +45,24 @@ class CrumbsDialog(gtk.Dialog):
     A GNOME HIG compliant dialog widget.
     Add buttons with gtk.Dialog.add_button or gtk.Dialog.add_buttons
     """
+    def __init__(self, title="", parent=None, flags=0, buttons=None):
+        super(CrumbsDialog, self).__init__(title, parent, flags, buttons)
+
+        self.set_property("has-separator", False) # note: deprecated in 2.22
+
+        self.set_border_width(6)
+        self.vbox.set_property("spacing", 12)
+        self.action_area.set_property("spacing", 12)
+        self.action_area.set_property("border-width", 6)
+
+class CrumbsMessageDialog(CrumbsDialog):
+    """
+    A GNOME HIG compliant dialog widget.
+    Add buttons with gtk.Dialog.add_button or gtk.Dialog.add_buttons
+    """
     def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO):
-        super(CrumbsDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
+        super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
         
-        #self.set_property("has-separator", False) # note: deprecated in 2.22
-
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
         self.action_area.set_property("spacing", 12)
@@ -839,7 +852,7 @@ class LayerSelectionDialog (gtk.Dialog):
             else:
                 layer_store.append([path])
                 return
-            dialog = CrumbsDialog(parent, lbl)
+            dialog = CrumbsMessageDialog(parent, lbl)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             response = dialog.run()
             dialog.destroy()
-- 
1.7.6



