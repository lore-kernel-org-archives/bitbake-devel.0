Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gJ-0007vM-Kp
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607567"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:45 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:41 -0800
Message-Id: <03a28fffec49fe1c93d1de5828e797a7bd40d640.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
References: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 4/6] crumbs: fix button order in several dialogues
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
X-List-Received-Date: Sat, 25 Feb 2012 01:44:16 -0000

GNOME HIG and Gtk+ convention is for the buttons to be ordered
<secondary action> <primary action> so that the primary action can be
selected easily by navigating to the bottom right of the dialogue.

We should try and match the convention and the HIG standard so that we
aren't contrasting the rest of the users applications.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builder.py   |   24 ++++++++++++------------
 lib/bb/ui/crumbs/hig.py       |    4 ++--
 lib/bb/ui/crumbs/hobwidget.py |    4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 21e5021..260eb32 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -589,9 +589,9 @@ class Builder(gtk.Window):
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
@@ -654,8 +654,8 @@ class Builder(gtk.Window):
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
@@ -666,9 +666,9 @@ class Builder(gtk.Window):
 
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
         dialog = ImageSelectionDialog(self.parameters.image_addr, self.parameters.image_types,
                                       "Open My Images", self,
                                        gtk.FILE_CHOOSER_ACTION_SAVE,
-                                      (gtk.STOCK_OPEN, gtk.RESPONSE_YES,
-                                       gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                      (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                       gtk.STOCK_OPEN, gtk.RESPONSE_YES))
 
         response = dialog.run()
         if response == gtk.RESPONSE_YES:
@@ -729,8 +729,8 @@ class Builder(gtk.Window):
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
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 9f10348..6d9bc5c 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -609,8 +609,8 @@ class ImageSelectionDialog (CrumbsDialog):
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
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index ab4169e..2faf51f 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -312,8 +312,8 @@ class HobWidget:
     def _add_layer_cb(cls, action, layer_store, parent):
         dialog = gtk.FileChooserDialog("Add new layer", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                        gtk.STOCK_OK, gtk.RESPONSE_YES))
         label = gtk.Label("Select the layer you wish to add")
         label.show()
         dialog.set_extra_widget(label)
-- 
1.7.7.6



