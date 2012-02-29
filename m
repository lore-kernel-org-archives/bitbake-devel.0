Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kHN-0005PH-P1
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:13:18 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Feb 2012 06:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123197911"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2012 06:04:47 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:12 +0800
Message-Id: <48a43e02f5c7b9761fef9db7dd6340b9279c8d15.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 15/32] crumbs: move towards more standard dialogue spacing
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
X-List-Received-Date: Wed, 29 Feb 2012 14:13:18 -0000

Inherit from the base CrumbsDialog class which implements standard border and spacing.

Switch all explicitly set dialogue spacings to 6 to converge towards GNOME HIG.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   66 +++++++++++++++++----------------------
 1 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 85efbe6..fdff10b 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -113,7 +113,7 @@ class BinbDialog(gtk.Dialog):
 #
 # AdvancedSettings Dialog
 #
-class AdvancedSettingDialog (gtk.Dialog):
+class AdvancedSettingDialog (CrumbsDialog):
 
     def gen_label_widget(self, content):
         label = gtk.Label()
@@ -311,7 +311,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         scroll.set_size_request(200,60)
         pkgfmt_hbox.pack_start(scroll, False, False, 0)
 
-        vbox = gtk.VBox(False, 5)
+        vbox = gtk.VBox(False, 6)
         pkgfmt_hbox.pack_start(vbox, False, False, 15)
 
         up = gtk.Button()
@@ -483,8 +483,8 @@ class AdvancedSettingDialog (gtk.Dialog):
         self.show_all()
 
     def create_image_types_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
         rows = (len(self.image_types)+1)/2
         table = gtk.Table(rows + 1, 10, True)
@@ -515,10 +515,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_output_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
         tooltip = "Select package formats that will be used. "
@@ -527,7 +527,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image Rootfs Size: (MB)</span>")
         tooltip = "Sets the size of your target image.\nThis is the basic size of your target image, unless your selected package size exceeds this value, or you set value to \"Image Extra Size\"."
@@ -535,7 +535,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image Extra Size: (MB)</span>")
         tooltip = "Sets the extra free space of your target image.\nDefaultly, system will reserve 30% of your image size as your free space. If your image contains zypper, it will bring in 50MB more space. The maximum free space is 1024MB."
@@ -551,7 +551,7 @@ class AdvancedSettingDialog (gtk.Dialog):
             self.gplv3_checkbox.set_active(False)
         advanced_vbox.pack_start(self.gplv3_checkbox, expand=False, fill=False)
 
-        sub_hbox = gtk.HBox(False, 5)
+        sub_hbox = gtk.HBox(False, 6)
         advanced_vbox.pack_start(sub_hbox, expand=False, fill=False)
         self.toolchain_checkbox = gtk.CheckButton("Build Toolchain")
         self.toolchain_checkbox.set_tooltip_text("Check this box to build the related toolchain with your image")
@@ -565,10 +565,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_build_environment_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select Distro:</span>")
         tooltip = "This is the Yocto distribution you would like to use"
@@ -576,7 +576,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(distro_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">BB_NUMBER_THREADS:</span>")
         tooltip = "Sets the number of threads that bitbake tasks can run simultaneously"
@@ -584,7 +584,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">PARALLEL_MAKE:</span>")
         tooltip = "Sets the make parallism, as known as 'make -j'"
@@ -592,7 +592,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
@@ -600,7 +600,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
         tooltip = "Select a folder that caches your prebuilt results"
@@ -608,7 +608,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
         tooltip = "Select the prebuilt mirror that will fasten your build speed"
@@ -619,10 +619,10 @@ class AdvancedSettingDialog (gtk.Dialog):
         return advanced_vbox
 
     def create_others_page(self):
-        advanced_vbox = gtk.VBox(False, 15)
-        advanced_vbox.set_border_width(20)
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
 
-        sub_vbox = gtk.VBox(False, 5)
+        sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
         label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
         tooltip = "This is the key/value pair for your extra settings"
@@ -687,7 +687,7 @@ class AdvancedSettingDialog (gtk.Dialog):
 #
 # DeployImageDialog
 #
-class DeployImageDialog (gtk.Dialog):
+class DeployImageDialog (CrumbsDialog):
 
     __dummy_usb__ = "--select a usb drive--"
 
@@ -700,7 +700,6 @@ class DeployImageDialog (gtk.Dialog):
         self.connect("response", self.response_cb)
 
     def create_visual_elements(self):
-        self.set_border_width(20)
         self.set_default_size(500, 250)
 
         label = gtk.Label()
@@ -807,7 +806,7 @@ class DeployImageDialog (gtk.Dialog):
 #
 # LayerSelectionDialog
 #
-class LayerSelectionDialog (gtk.Dialog):
+class LayerSelectionDialog (CrumbsDialog):
 
     def gen_label_widget(self, content):
         label = gtk.Label()
@@ -864,7 +863,7 @@ class LayerSelectionDialog (gtk.Dialog):
 
 
     def gen_layer_widget(self, split_model, layers, layers_avail, window, tooltip=""):
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 6)
 
         layer_tv = gtk.TreeView()
         layer_tv.set_rules_hint(True)
@@ -917,13 +916,13 @@ class LayerSelectionDialog (gtk.Dialog):
             add_button = gtk.Button()
             add_button.set_image(image)
             add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
-            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
             image = gtk.Image()
             image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
             del_button = gtk.Button()
             del_button.set_image(image)
             del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
-            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
         layer_tv.set_model(layer_store)
 
         hbox.show_all()
@@ -948,11 +947,8 @@ class LayerSelectionDialog (gtk.Dialog):
         self.connect("response", self.response_cb)
                 
     def create_visual_elements(self):
-        self.set_border_width(20)
         self.set_default_size(400, 250)
-
         hbox_top = gtk.HBox()
-        self.set_border_width(12)
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
         if self.split_model:
@@ -1001,7 +997,7 @@ class LayerSelectionDialog (gtk.Dialog):
         self.layers_changed = (self.layers != layers)
         self.layers = layers
 
-class ImageSelectionDialog (gtk.Dialog):
+class ImageSelectionDialog (CrumbsDialog):
 
     __columns__ = [{
             'col_name' : 'Image name',
@@ -1034,11 +1030,7 @@ class ImageSelectionDialog (gtk.Dialog):
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
@@ -1048,7 +1040,7 @@ class ImageSelectionDialog (gtk.Dialog):
         hbox.pack_start(table, expand=False, fill=False)
         table.attach(entry, 0, 9, 0, 1)
         image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+        image.set_from_stock(gtk.STOCK_OPEN, gtk.ICON_SIZE_BUTTON)
         open_button = gtk.Button()
         open_button.set_image(image)
         open_button.connect("clicked", self.select_path_cb, self, entry)
-- 
1.7.6



