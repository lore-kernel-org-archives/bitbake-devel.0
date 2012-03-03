Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8j-00064Q-Ub
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:48:02 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997897"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:21 -0800
Message-Id: <83a9ae7584b38f0a0dfd81c18355a7732944419b.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 5/6] ui/crumbs/hig: use HobInfoButton in place of gtk.Image with tooltip
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
X-List-Received-Date: Sat, 03 Mar 2012 00:48:02 -0000

Replace all instances of the stock info icon with an attached tooltip with
the new HobInfoButton with associated PersistentTooltip.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |   46 +++++++++++++++-------------------------------
 1 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index c5bd27a..b109c0a 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, HobViewTable
+from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -130,10 +130,8 @@ class AdvancedSettingDialog (CrumbsDialog):
         spinner.set_value(content)
         hbox.pack_start(spinner, expand=False, fill=False)
 
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox.pack_start(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
 
         hbox.show_all()
         return hbox, spinner
@@ -150,11 +148,8 @@ class AdvancedSettingDialog (CrumbsDialog):
                 combo.set_active(index)
             index += 1
 
-        image = gtk.Image()
-        image.show()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox.pack_start(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
 
         hbox.show_all()
         return hbox, combo
@@ -189,10 +184,8 @@ class AdvancedSettingDialog (CrumbsDialog):
             open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
             table.attach(open_button, 9, 10, 0, 1)
 
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox.pack_start(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
 
         hbox.show_all()
         return hbox, entry
@@ -331,10 +324,8 @@ class AdvancedSettingDialog (CrumbsDialog):
         vbox.pack_start(down, False, False, 5)
         tree_selection.connect("changed", self.pkgfmt_widget_tree_selection_changed_cb, up, down)
 
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        pkgfmt_hbox.pack_start(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        pkgfmt_hbox.pack_start(info, expand=False, fill=False)
 
         pkgfmt_hbox.show_all()
 
@@ -419,10 +410,8 @@ class AdvancedSettingDialog (CrumbsDialog):
         button.connect("clicked", self.editable_settings_remove_item_clicked, setting_tree)
         hbox.pack_start(button)
 
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        setting_hbox.pack_start(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        setting_hbox.pack_start(info, expand=False, fill=False)
 
         return setting_hbox, setting_store
 
@@ -489,13 +478,10 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(table, expand=False, fill=False)
 
         tooltip = "Select image file system types that will be used."
-        image = gtk.Image()
-        image.show()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
+        info = HobInfoButton(tooltip, self)
         label = self.gen_label_widget("<span weight=\"bold\">Select image types:</span>")
         table.attach(label, 0, 9, 0, 1)
-        table.attach(image, 9, 10, 0, 1)
+        table.attach(info, 9, 10, 0, 1)
 
         i = 1
         j = 1
@@ -953,10 +939,8 @@ class LayerSelectionDialog (CrumbsDialog):
         hbox_top.pack_start(label, expand=False, fill=False)
 
         tooltip = "Layer is a collection of bb files and conf files"
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox_top.pack_end(image, expand=False, fill=False)
+        info = HobInfoButton(tooltip, self)
+        hbox_top.pack_end(info, expand=False, fill=False)
 
         layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
         layer_widget.set_size_request(-1, 180)
-- 
1.7.7.6



