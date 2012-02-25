Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gH-0007uz-KQ
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:14 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607559"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:44 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:38 -0800
Message-Id: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 1/6] crumbs: Factor common dialogue configuration out
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
X-List-Received-Date: Sat, 25 Feb 2012 01:44:14 -0000

Factor out the base dialogue configuration into CrumbsDialog and create a
new CrumbsMessageDialog which acts as the CrumbsDialog did to handle
dialogues with buttons.

Adopt CrumbsMessageDialog wherever CrumbsDialog was used.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py   |   28 ++++++++++++++--------------
 lib/bb/ui/crumbs/hig.py       |   17 +++++++++++++++--
 lib/bb/ui/crumbs/hobwidget.py |    2 +-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 0071673..b52ba04 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -33,7 +33,7 @@ from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
 from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
 from bb.ui.crumbs.hobwidget import hwc
-from bb.ui.crumbs.hig import CrumbsDialog, BinbDialog, \
+from bb.ui.crumbs.hig import CrumbsMessageDialog, BinbDialog, \
                              AdvancedSettingDialog, LayerSelectionDialog, \
                              DeployImageDialog, ImageSelectionDialog
 
@@ -234,7 +234,7 @@ class Builder(gtk.Window):
         else:
             lbl = "<b>Screen dimension mismatched</b>\nfor better usability and visual effects,"
             lbl = lbl + " the screen dimension should be 1024x768 or above."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -441,7 +441,7 @@ class Builder(gtk.Window):
     def handler_command_failed_cb(self, handler, msg):
         lbl = "<b>Error</b>\n"
         lbl = lbl + "%s\n\n" % msg
-        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
         dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
         response = dialog.run()
         dialog.destroy()
@@ -588,7 +588,7 @@ class Builder(gtk.Window):
 
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
-        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
         dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
         dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
         dialog.set_default_response(gtk.RESPONSE_NO)
@@ -605,7 +605,7 @@ class Builder(gtk.Window):
         if not all_recipes:
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -617,7 +617,7 @@ class Builder(gtk.Window):
         if not selected_packages:      
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -632,7 +632,7 @@ class Builder(gtk.Window):
         if not (selected_packages or selected_image != self.recipe_model.__dummy_image__):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -703,7 +703,7 @@ class Builder(gtk.Window):
         if response == gtk.RESPONSE_YES:
             if not dialog.image_names:
                 lbl = "<b>No selections made</b>\nYou have not made any selections"
-                crumbs_dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
                 crumbs_dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
                 crumbs_dialog.run()
                 crumbs_dialog.destroy()
@@ -745,7 +745,7 @@ class Builder(gtk.Window):
     def deploy_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to deploy.</b>"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -766,7 +766,7 @@ class Builder(gtk.Window):
     def runqemu_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to launch in QEMU.</b>"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
             dialog.run()
             dialog.destroy()
@@ -806,7 +806,7 @@ class Builder(gtk.Window):
                 lbl = lbl + "kernel path:" + kernel_path + "\n"
                 lbl = lbl + "source environment path:" + source_env_path + "\n"
                 lbl = lbl + "tmp path: " + tmp_path + "."
-                dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
                 dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
                 dialog.run()
                 dialog.destroy()
@@ -816,7 +816,7 @@ class Builder(gtk.Window):
         if selected_recipes and ask:
             lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
             lbl = lbl + " to get a full list (Yes) or just view the existing packages (No)?"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             dialog.add_button(gtk.STOCK_YES, gtk.RESPONSE_YES)
             dialog.add_button(gtk.STOCK_NO, gtk.RESPONSE_NO)
             dialog.set_default_response(gtk.RESPONSE_YES)
@@ -847,7 +847,7 @@ class Builder(gtk.Window):
             lbl = lbl + "This will stop the build as quickly as possible but may"
             lbl = lbl + " well leave your build directory in an  unusable state"
             lbl = lbl + " that requires manual steps to fix.\n"
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
             dialog.add_button("Force Stop", gtk.RESPONSE_YES)
         else:
@@ -859,7 +859,7 @@ class Builder(gtk.Window):
             lbl = lbl + " progress build tasks are finished. However if a"
             lbl = lbl + " lengthy compilation phase is in progress this may take"
             lbl = lbl + " some time."
-            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
             dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
             dialog.add_button("Stop", gtk.RESPONSE_OK)
             dialog.add_button("Force Stop", gtk.RESPONSE_YES)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 89dfe03..91edede 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -45,10 +45,23 @@ class CrumbsDialog(gtk.Dialog):
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
         super(CrumbsDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
-        
-        #self.set_property("has-separator", False) # note: deprecated in 2.22
 
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 890151d..b6cb241 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -303,7 +303,7 @@ class HobWidget:
 
     @classmethod
     def conf_error(cls, parent, lbl):
-        dialog = CrumbsDialog(parent, lbl)
+        dialog = CrumbsMessageDialog(parent, lbl)
         dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
         response = dialog.run()
         dialog.destroy()
-- 
1.7.7.6



