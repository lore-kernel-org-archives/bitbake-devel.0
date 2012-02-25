Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16gJ-0007uz-Jj
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:16 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Feb 2012 17:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607566"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:45 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:40 -0800
Message-Id: <389dc9d651554099b08041aa138590445a5e5035.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
References: <03fda55b89fdc2ddb45a7bc08015989fc0eccb91.1330133412.git.josh@linux.intel.com>
In-Reply-To: <cover.1330133412.git.josh@linux.intel.com>
References: <cover.1330133412.git.josh@linux.intel.com>
Subject: [PATCH 3/6] crumbs: move towards more standard dialogue spacing
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

Inherit from the base CrumbsDialog class which implements standard border
and spacing.

Switch all explicitly set dialogue spacings to 6 to converge towards GNOME
HIG.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py       |   58 +++++++++++++++++-----------------------
 lib/bb/ui/crumbs/hobwidget.py |    6 ++--
 2 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 91edede..9f10348 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -116,7 +116,7 @@ class BinbDialog(gtk.Dialog):
 #
 # AdvancedSettings Dialog
 #
-class AdvancedSettingDialog (gtk.Dialog):
+class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
@@ -175,8 +175,8 @@ class AdvancedSettingDialog (gtk.Dialog):
         self.show_all()
 
     def create_image_types_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
         rows = (len(self.image_types)+1)/2
         table = gtk.Table(rows + 1, 10, True)
@@ -207,10 +207,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_output_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
         tooltip = "Select package formats that will be used. "
@@ -219,7 +219,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Image Rootfs Size: (MB)</span>")
         tooltip = "Sets the size of your target image.\nThis is the basic size of your target image, unless your selected package size exceeds this value, or you set value to \"Image Extra Size\"."
@@ -227,7 +227,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Image Extra Size: (MB)</span>")
         tooltip = "Sets the extra free space of your target image.\nDefaultly, system will reserve 30% of your image size as your free space. If your image contains zypper, it will bring in 50MB more space. The maximum free space is 1024MB."
@@ -243,7 +243,7 @@ class AdvancedSettingDialog (gtk.Dialog):
             self.gplv3_checkbox.set_active(False)
         advanced_vbox.pack_start(self.gplv3_checkbox, expand=False, fill=False)
 
-        sub_hbox = gtk.HBox(False, 5)
+        sub_hbox = gtk.HBox(False, 6)
         advanced_vbox.pack_start(sub_hbox, expand=False, fill=False)
         self.toolchain_checkbox = gtk.CheckButton("Build Toolchain")
         self.toolchain_checkbox.set_tooltip_text("Check this box to build the related toolchain with your image")
@@ -257,10 +257,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_build_environment_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Select Distro:</span>")
         tooltip = "This is the Yocto distribution you would like to use"
@@ -268,7 +268,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(distro_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">BB_NUMBER_THREADS:</span>")
         tooltip = "Sets the number of threads that bitbake tasks can run simultaneously"
@@ -276,7 +276,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">PARALLEL_MAKE:</span>")
         tooltip = "Sets the make parallism, as known as 'make -j'"
@@ -284,7 +284,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
@@ -292,7 +292,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
         tooltip = "Select a folder that caches your prebuilt results"
@@ -300,7 +300,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
         tooltip = "Select the prebuilt mirror that will fasten your build speed"
@@ -311,10 +311,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_others_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
         label = HobWidget.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
         tooltip = "This is the key/value pair for your extra settings"
@@ -379,7 +379,7 @@ class AdvancedSettingDialog (gtk.Dialog):
 #
 # DeployImageDialog
 #
-class DeployImageDialog (gtk.Dialog):
+class DeployImageDialog (CrumbsDialog):
 
     __dummy_usb__ = "--select a usb drive--"
 
@@ -392,7 +392,6 @@ class DeployImageDialog (gtk.Dialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_border_width(20)
         self.set_default_size(500, 250)
 
         label = gtk.Label()
@@ -499,7 +498,7 @@ class DeployImageDialog (gtk.Dialog):
 #
 # LayerSelectionDialog
 #
-class LayerSelectionDialog (gtk.Dialog):
+class LayerSelectionDialog (CrumbsDialog):
 
     def __init__(self, title, layers, all_layers, split_model,
             parent, flags, buttons):
@@ -519,11 +518,8 @@ class LayerSelectionDialog (gtk.Dialog):
         self.connect("response", self.response_cb)
                 
     def create_visual_elements(self):
-        self.set_border_width(20)
         self.set_default_size(400, 250)
-
         hbox_top = gtk.HBox()
-        self.set_border_width(12)
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
         if self.split_model:
@@ -572,7 +568,7 @@ class LayerSelectionDialog (gtk.Dialog):
         self.layers_changed = (self.layers != layers)
         self.layers = layers
 
-class ImageSelectionDialog (gtk.Dialog):
+class ImageSelectionDialog (CrumbsDialog):
 
     def __init__(self, image_folder, image_types, title, parent, flags, buttons):
         super(ImageSelectionDialog, self).__init__(title, parent, flags, buttons)
@@ -589,11 +585,7 @@ class ImageSelectionDialog (gtk.Dialog):
         self.fill_image_store()
 
     def create_visual_elements(self):
-        self.set_border_width(20)
-        self.set_default_size(600, 300)
-        self.vbox.set_spacing(10)
-
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 6)
         self.vbox.pack_start(hbox, expand=False, fill=False)
 
         entry = gtk.Entry()
@@ -603,7 +595,7 @@ class ImageSelectionDialog (gtk.Dialog):
         hbox.pack_start(table, expand=False, fill=False)
         table.attach(entry, 0, 9, 0, 1)
         image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+        image.set_from_stock(gtk.STOCK_OPEN, gtk.ICON_SIZE_BUTTON)
         open_button = gtk.Button()
         open_button.set_image(image)
         open_button.connect("clicked", self.select_path_cb, self, entry)
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index b6cb241..ab4169e 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -356,7 +356,7 @@ class HobWidget:
 
     @classmethod
     def gen_layer_widget(cls, split_model, layers, layers_avail, window, tooltip=""):
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 6)
 
         layer_tv = gtk.TreeView()
         layer_tv.set_rules_hint(True)
@@ -409,13 +409,13 @@ class HobWidget:
             add_button = gtk.Button()
             add_button.set_image(image)
             add_button.connect("clicked", cls._add_layer_cb, layer_store, window)
-            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
             image = gtk.Image()
             image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
             del_button = gtk.Button()
             del_button.set_image(image)
             del_button.connect("clicked", cls._del_layer_cb, tree_selection, layer_store)
-            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
         layer_tv.set_model(layer_store)
 
         hbox.show_all()
-- 
1.7.7.6



