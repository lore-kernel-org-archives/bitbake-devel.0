Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFJ-0003SX-1B
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:33 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Mar 2012 05:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123374997"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 21 Mar 2012 05:57:33 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:08 +0800
Message-Id: <6951f66b1e0d9ed4624b68a7c9bf469a7429b271.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 04/17] Hob: change package classes selection GUI
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:33 -0000

This commit change the GUI for package classes selection in advanced
setting dialog, which conforms with UI team's design.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |  183 ++++++++++++-----------------------------------
 1 files changed, 46 insertions(+), 137 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index bd27375..e675f39 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -191,146 +191,58 @@ class AdvancedSettingDialog (CrumbsDialog):
         hbox.show_all()
         return hbox, entry
 
-    def pkgfmt_widget_sort_func(self, model, iter1, iter2, data):
-        val1 = model.get_value(iter1, 0)
-        val2 = model.get_value(iter2, 0)
-        inc1 = model.get_value(iter1, 2)
-        inc2 = model.get_value(iter2, 2)
-        if inc1 != inc2:
-            return inc2 - inc1
-        else:
-            return val1 - val2
-
-    def pkgfmt_widget_tree_selection_changed_cb(self, tree_selection, button1, button2):
-        (model, it) = tree_selection.get_selected()
-        inc = model.get_value(it, 2)
-        if inc:
-            button1.set_sensitive(True)
-            button2.set_sensitive(True)
-        else:
-            button1.set_sensitive(False)
-            button2.set_sensitive(False)
-
-    def pkgfmt_widget_up_clicked_cb(self, button, tree_selection):
-        (model, it) = tree_selection.get_selected()
-        if not it:
-            return
-        path = model.get_path(it)
-        if path[0] <= 0:
-            return
-
-        pre_it = model.get_iter_first()
-        if not pre_it:
-            return
-        else:
-            while model.iter_next(pre_it) :
-                if model.get_value(model.iter_next(pre_it), 1) != model.get_value(it, 1):
-                    pre_it = model.iter_next(pre_it)
-                else:
-                    break
-
-            cur_index = model.get_value(it, 0)
-            pre_index = cur_index
-            if pre_it:
-                model.set(pre_it, 0, pre_index)
-            cur_index = cur_index - 1
-            model.set(it, 0, cur_index)
-
-    def pkgfmt_widget_down_clicked_cb(self, button, tree_selection):
-        (model, it) = tree_selection.get_selected()
-        if not it:
-            return
-        next_it = model.iter_next(it)
-        if not next_it:
-            return
-        cur_index = model.get_value(it, 0)
-        next_index = cur_index
-        model.set(next_it, 0, next_index)
-        cur_index = cur_index + 1
-        model.set(it, 0, cur_index)
-
-    def pkgfmt_widget_toggle_cb(self, cell, path, model, column):
-        it = model.get_iter(path)
-        val = model.get_value(it, column)
-        val = not val
-        model.set(it, column, val)
+    def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
+        combo_item = self.rootfs_combo.get_active_text()
+        for child in check_hbox.get_children():
+            if isinstance(child, gtk.CheckButton):
+                check_hbox.remove(child)
+        for format in all_package_format:
+            if format != combo_item:
+                check_button = gtk.CheckButton(format)
+                check_hbox.pack_start(check_button, expand=False, fill=False)
+        check_hbox.show_all()
 
     def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip=""):
-        pkgfmt_hbox = gtk.HBox(False, 12)
+        pkgfmt_hbox = gtk.HBox(False, 24)
 
-        pkgfmt_store = gtk.ListStore(int, str, gobject.TYPE_BOOLEAN)
-        for format in curr_package_format.split():
-            pkgfmt_store.set(pkgfmt_store.append(), 1, format, 2, True)
-        for format in all_package_format:
-            if format not in curr_package_format:
-                pkgfmt_store.set(pkgfmt_store.append(), 1, format, 2, False)
-        pkgfmt_tree = gtk.TreeView(pkgfmt_store)
-        pkgfmt_tree.set_headers_clickable(True)
-        pkgfmt_tree.set_headers_visible(False)
-        tree_selection = pkgfmt_tree.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+        rootfs_vbox = gtk.VBox(False, 6)
+        pkgfmt_hbox.pack_start(rootfs_vbox, expand=False, fill=False)
 
-        col = gtk.TreeViewColumn('NO')
-        col.set_sort_column_id(0)
-        col.set_sort_order(gtk.SORT_ASCENDING)
-        col.set_clickable(False)
-        col1 = gtk.TreeViewColumn('TYPE')
-        col1.set_min_width(130)
-        col1.set_max_width(140)
-        col2 = gtk.TreeViewColumn('INCLUDED')
-        col2.set_min_width(60)
-        col2.set_max_width(70)
-        pkgfmt_tree.append_column(col1)
-        pkgfmt_tree.append_column(col2)
-        cell = gtk.CellRendererText()
-        cell1 = gtk.CellRendererText()
-        cell1.set_property('width-chars', 10)
-        cell2 = gtk.CellRendererToggle()
-        cell2.set_property('activatable', True)
-        cell2.connect("toggled", self.pkgfmt_widget_toggle_cb, pkgfmt_store, 2)
-        col.pack_start(cell, True)
-        col1.pack_start(cell1, True)
-        col2.pack_end(cell2, True)
-        col.set_attributes(cell, text=0)
-        col1.set_attributes(cell1, text=1)
-        col2.set_attributes(cell2, active=2)
+        label = self.gen_label_widget("Root file system package format")
+        rootfs_vbox.pack_start(label, expand=False, fill=False)
 
-        pkgfmt_store.set_sort_func(0, self.pkgfmt_widget_sort_func, None)
-        pkgfmt_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
+        rootfs_format = ""
+        if curr_package_format:
+            rootfs_format = curr_package_format.split()[0]
 
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(pkgfmt_tree)
-        scroll.set_size_request(200,60)
-        pkgfmt_hbox.pack_start(scroll, False, False, 0)
+        tooltip = "Package format that is used to generate rootfs"
+        rootfs_format_widget, rootfs_combo = self.gen_combo_widget(rootfs_format, all_package_format, tooltip)
+        rootfs_vbox.pack_start(rootfs_format_widget, expand=False, fill=False)
 
-        vbox = gtk.VBox(False, 6)
-        pkgfmt_hbox.pack_start(vbox, False, False, 15)
+        extra_vbox = gtk.VBox(False, 6)
+        pkgfmt_hbox.pack_start(extra_vbox, expand=False, fill=False)
 
-        up = gtk.Button()
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_GO_UP, gtk.ICON_SIZE_MENU)
-        up.set_image(image)
-        up.set_size_request(50,30)
-        up.connect("clicked", self.pkgfmt_widget_up_clicked_cb, tree_selection)
-        vbox.pack_start(up, False, False, 5)
+        label = self.gen_label_widget("Additional package formats")
+        extra_vbox.pack_start(label, expand=False, fill=False)
 
-        down = gtk.Button()
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_GO_DOWN, gtk.ICON_SIZE_MENU)
-        down.set_image(image)
-        down.set_size_request(50,30)
-        down.connect("clicked", self.pkgfmt_widget_down_clicked_cb, tree_selection)
-        vbox.pack_start(down, False, False, 5)
-        tree_selection.connect("changed", self.pkgfmt_widget_tree_selection_changed_cb, up, down)
+        check_hbox = gtk.HBox(False, 12)
+        extra_vbox.pack_start(check_hbox, expand=False, fill=False)
+        for format in all_package_format:
+            if format != rootfs_format:
+                check_button = gtk.CheckButton(format)
+                is_active = (format in curr_package_format.split())
+                check_button.set_active(is_active)
+                check_hbox.pack_start(check_button, expand=False, fill=False)
 
+        tooltip = "Extra package formats to build"
         info = HobInfoButton(tooltip, self)
-        pkgfmt_hbox.pack_start(info, expand=False, fill=False)
+        check_hbox.pack_end(info, expand=False, fill=False)
+
+        rootfs_combo.connect("changed", self.rootfs_combo_changed_cb, all_package_format, check_hbox)
 
         pkgfmt_hbox.show_all()
 
-        return pkgfmt_hbox, pkgfmt_store
+        return pkgfmt_hbox, rootfs_combo, check_hbox
 
     def editable_settings_cell_edited(self, cell, path_string, new_text, model):
         it = model.get_iter_from_string(path_string)
@@ -431,7 +343,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.max_threads = max_threads
 
         # class members for internal use
-        self.pkgfmt_store = None
         self.distro_combo = None
         self.dldir_text = None
         self.sstatedir_text = None
@@ -509,7 +420,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         label = self.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
         tooltip = "Select package formats that will be used. "
         tooltip += "The first format will be used for final image"
-        pkgfmt_widget, self.pkgfmt_store = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
+        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
@@ -621,14 +532,12 @@ class AdvancedSettingDialog (CrumbsDialog):
     def response_cb(self, dialog, response_id):
         self.variables = {}
 
-        self.configuration.curr_package_format = ""
-        it = self.pkgfmt_store.get_iter_first()
-        while it:
-            value = self.pkgfmt_store.get_value(it, 2)
-            if value:
-                self.configuration.curr_package_format += (self.pkgfmt_store.get_value(it, 1) + " ")
-            it = self.pkgfmt_store.iter_next(it)
-        self.configuration.curr_package_format = self.configuration.curr_package_format.strip()
+        package_format = []
+        package_format.append(self.rootfs_combo.get_active_text())
+        for child in self.check_hbox:
+            if isinstance(child, gtk.CheckButton) and child.get_active():
+                package_format.append(child.get_label())
+        self.configuration.curr_package_format = " ".join(package_format)
         self.variables["PACKAGE_FORMAT"] = self.configuration.curr_package_format
 
         self.configuration.curr_distro = self.distro_combo.get_active_text()
-- 
1.7.4.1



