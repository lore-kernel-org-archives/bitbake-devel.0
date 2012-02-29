Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kC1-0005ES-7r
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:07:46 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 05:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116102188"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Feb 2012 05:58:13 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:00 +0800
Message-Id: <b3bb177ec870a6942a3757b7b47e9a0626aaac3d.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
X-Mailman-Approved-At: Thu, 01 Mar 2012 16:44:20 +0100
Subject: [PATCH 03/32] Hob: cleanup those class methods in HobWidget
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
X-List-Received-Date: Wed, 29 Feb 2012 14:07:46 -0000

Some dialogs like advanced settings dialog, and layer selection dialog are using the class methods in HobWidget to create widgets for themselves, which is not a good design for OO.

Clean up the code, and split the functions into the separate classes which use them actually.
Finally, remove the class HobWidget.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py                 |  486 +++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hobwidget.py           |  465 ----------------------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 3 files changed, 460 insertions(+), 493 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 9aa6fdf..2de7b2a 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobWidget, HobViewTable
+from bb.ui.crumbs.hobwidget import HobViewTable
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -105,6 +105,317 @@ class BinbDialog(gtk.Dialog):
 #
 class AdvancedSettingDialog (gtk.Dialog):
 
+    def gen_label_widget(self, content):
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup(content)
+        label.show()
+        return label
+
+    def gen_spinner_widget(self, content, lower, upper, tooltip=""):
+        hbox = gtk.HBox(False, 10)
+        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
+        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1, digits=0)
+
+        spinner.set_value(content)
+        hbox.pack_start(spinner, expand=False, fill=False)
+
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
+        image.set_tooltip_text(tooltip)
+        hbox.pack_start(image, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, spinner
+
+    def gen_combo_widget(self, curr_item, all_item, tooltip=""):
+        hbox = gtk.HBox(False, 10)
+        combo = gtk.combo_box_new_text()
+        hbox.pack_start(combo, expand=False, fill=False)
+
+        index = 0
+        for item in all_item or []:
+            combo.append_text(item)
+            if item == curr_item:
+                combo.set_active(index)
+            index += 1
+
+        image = gtk.Image()
+        image.show()
+        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
+        image.set_tooltip_text(tooltip)
+        hbox.pack_start(image, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, combo
+
+    def entry_widget_select_path_cb(self, action, parent, entry):
+        dialog = gtk.FileChooserDialog("", parent,
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
+                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
+                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+        response = dialog.run()
+        if response == gtk.RESPONSE_YES:
+            path = dialog.get_filename()
+            entry.set_text(path)
+
+        dialog.destroy()
+
+    def gen_entry_widget(self, split_model, content, parent, tooltip=""):
+        hbox = gtk.HBox(False, 10)
+        entry = gtk.Entry()
+        entry.set_text(content)
+
+        if split_model:
+            hbox.pack_start(entry, expand=True, fill=True)
+        else:
+            table = gtk.Table(1, 10, True)
+            hbox.pack_start(table, expand=True, fill=True)
+            table.attach(entry, 0, 9, 0, 1)
+            image = gtk.Image()
+            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+            open_button = gtk.Button()
+            open_button.set_image(image)
+            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
+            table.attach(open_button, 9, 10, 0, 1)
+
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
+        image.set_tooltip_text(tooltip)
+        hbox.pack_start(image, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, entry
+
+    def pkgfmt_widget_sort_func(self, model, iter1, iter2, data):
+        val1 = model.get_value(iter1, 0)
+        val2 = model.get_value(iter2, 0)
+        inc1 = model.get_value(iter1, 2)
+        inc2 = model.get_value(iter2, 2)
+        if inc1 != inc2:
+            return inc2 - inc1
+        else:
+            return val1 - val2
+
+    def pkgfmt_widget_tree_selection_changed_cb(self, tree_selection, button1, button2):
+        (model, it) = tree_selection.get_selected()
+        inc = model.get_value(it, 2)
+        if inc:
+            button1.set_sensitive(True)
+            button2.set_sensitive(True)
+        else:
+            button1.set_sensitive(False)
+            button2.set_sensitive(False)
+
+    def pkgfmt_widget_up_clicked_cb(self, button, tree_selection):
+        (model, it) = tree_selection.get_selected()
+        if not it:
+            return
+        path = model.get_path(it)
+        if path[0] <= 0:
+            return
+
+        pre_it = model.get_iter_first()
+        if not pre_it:
+            return
+        else:
+            while model.iter_next(pre_it) :
+                if model.get_value(model.iter_next(pre_it), 1) != model.get_value(it, 1):
+                    pre_it = model.iter_next(pre_it)
+                else:
+                    break
+
+            cur_index = model.get_value(it, 0)
+            pre_index = cur_index
+            if pre_it:
+                model.set(pre_it, 0, pre_index)
+            cur_index = cur_index - 1
+            model.set(it, 0, cur_index)
+
+    def pkgfmt_widget_down_clicked_cb(self, button, tree_selection):
+        (model, it) = tree_selection.get_selected()
+        if not it:
+            return
+        next_it = model.iter_next(it)
+        if not next_it:
+            return
+        cur_index = model.get_value(it, 0)
+        next_index = cur_index
+        model.set(next_it, 0, next_index)
+        cur_index = cur_index + 1
+        model.set(it, 0, cur_index)
+
+    def pkgfmt_widget_toggle_cb(self, cell, path, model, column):
+        it = model.get_iter(path)
+        val = model.get_value(it, column)
+        val = not val
+        model.set(it, column, val)
+
+    def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip=""):
+        pkgfmt_hbox = gtk.HBox(False, 15)
+
+        pkgfmt_store = gtk.ListStore(int, str, gobject.TYPE_BOOLEAN)
+        for format in curr_package_format.split():
+            pkgfmt_store.set(pkgfmt_store.append(), 1, format, 2, True)
+        for format in all_package_format:
+            if format not in curr_package_format:
+                pkgfmt_store.set(pkgfmt_store.append(), 1, format, 2, False)
+        pkgfmt_tree = gtk.TreeView(pkgfmt_store)
+        pkgfmt_tree.set_headers_clickable(True)
+        pkgfmt_tree.set_headers_visible(False)
+        tree_selection = pkgfmt_tree.get_selection()
+        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+
+        col = gtk.TreeViewColumn('NO')
+        col.set_sort_column_id(0)
+        col.set_sort_order(gtk.SORT_ASCENDING)
+        col.set_clickable(False)
+        col1 = gtk.TreeViewColumn('TYPE')
+        col1.set_min_width(130)
+        col1.set_max_width(140)
+        col2 = gtk.TreeViewColumn('INCLUDED')
+        col2.set_min_width(60)
+        col2.set_max_width(70)
+        pkgfmt_tree.append_column(col1)
+        pkgfmt_tree.append_column(col2)
+        cell = gtk.CellRendererText()
+        cell1 = gtk.CellRendererText()
+        cell1.set_property('width-chars', 10)
+        cell2 = gtk.CellRendererToggle()
+        cell2.set_property('activatable', True)
+        cell2.connect("toggled", self.pkgfmt_widget_toggle_cb, pkgfmt_store, 2)
+        col.pack_start(cell, True)
+        col1.pack_start(cell1, True)
+        col2.pack_end(cell2, True)
+        col.set_attributes(cell, text=0)
+        col1.set_attributes(cell1, text=1)
+        col2.set_attributes(cell2, active=2)
+
+        pkgfmt_store.set_sort_func(0, self.pkgfmt_widget_sort_func, None)
+        pkgfmt_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
+
+        scroll = gtk.ScrolledWindow()
+        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
+        scroll.set_shadow_type(gtk.SHADOW_IN)
+        scroll.add(pkgfmt_tree)
+        scroll.set_size_request(200,60)
+        pkgfmt_hbox.pack_start(scroll, False, False, 0)
+
+        vbox = gtk.VBox(False, 5)
+        pkgfmt_hbox.pack_start(vbox, False, False, 15)
+
+        up = gtk.Button()
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_GO_UP, gtk.ICON_SIZE_MENU)
+        up.set_image(image)
+        up.set_size_request(50,30)
+        up.connect("clicked", self.pkgfmt_widget_up_clicked_cb, tree_selection)
+        vbox.pack_start(up, False, False, 5)
+
+        down = gtk.Button()
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_GO_DOWN, gtk.ICON_SIZE_MENU)
+        down.set_image(image)
+        down.set_size_request(50,30)
+        down.connect("clicked", self.pkgfmt_widget_down_clicked_cb, tree_selection)
+        vbox.pack_start(down, False, False, 5)
+        tree_selection.connect("changed", self.pkgfmt_widget_tree_selection_changed_cb, up, down)
+
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
+        image.set_tooltip_text(tooltip)
+        pkgfmt_hbox.pack_start(image, expand=False, fill=False)
+
+        pkgfmt_hbox.show_all()
+
+        return pkgfmt_hbox, pkgfmt_store
+
+    def editable_settings_cell_edited(self, cell, path_string, new_text, model):
+        it = model.get_iter_from_string(path_string)
+        column = cell.get_data("column")
+        model.set(it, column, new_text)
+
+    def editable_settings_add_item_clicked(self, button, model):
+        new_item = ["##KEY##", "##VALUE##"]
+
+        iter = model.append()
+        model.set (iter,
+            0, new_item[0],
+            1, new_item[1],
+       )
+
+    def editable_settings_remove_item_clicked(self, button, treeview):
+        selection = treeview.get_selection()
+        model, iter = selection.get_selected()
+
+        if iter:
+            path = model.get_path(iter)[0]
+            model.remove(iter)
+
+    def gen_editable_settings(self, setting, tooltip=""):
+        setting_hbox = gtk.HBox(False, 10)
+
+        vbox = gtk.VBox(False, 10)
+        setting_hbox.pack_start(vbox, expand=True, fill=True)
+
+        setting_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
+        for key in setting.keys():
+            setting_store.set(setting_store.append(), 0, key, 1, setting[key])
+
+        setting_tree = gtk.TreeView(setting_store)
+        setting_tree.set_headers_visible(True)
+        setting_tree.set_size_request(300, 100)
+
+        col = gtk.TreeViewColumn('Key')
+        col.set_min_width(100)
+        col.set_max_width(150)
+        col.set_resizable(True)
+        col1 = gtk.TreeViewColumn('Value')
+        col1.set_min_width(100)
+        col1.set_max_width(150)
+        col1.set_resizable(True)
+        setting_tree.append_column(col)
+        setting_tree.append_column(col1)
+        cell = gtk.CellRendererText()
+        cell.set_property('width-chars', 10)
+        cell.set_property('editable', True)
+        cell.set_data("column", 0)
+        cell.connect("edited", self.editable_settings_cell_edited, setting_store)
+        cell1 = gtk.CellRendererText()
+        cell1.set_property('width-chars', 10)
+        cell1.set_property('editable', True)
+        cell1.set_data("column", 1)
+        cell1.connect("edited", self.editable_settings_cell_edited, setting_store)
+        col.pack_start(cell, True)
+        col1.pack_end(cell1, True)
+        col.set_attributes(cell, text=0)
+        col1.set_attributes(cell1, text=1)
+
+        scroll = gtk.ScrolledWindow()
+        scroll.set_shadow_type(gtk.SHADOW_IN)
+        scroll.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        scroll.add(setting_tree)
+        vbox.pack_start(scroll, expand=True, fill=True)
+
+        # some buttons
+        hbox = gtk.HBox(True, 4)
+        vbox.pack_start(hbox, False, False)
+
+        button = gtk.Button(stock=gtk.STOCK_ADD)
+        button.connect("clicked", self.editable_settings_add_item_clicked, setting_store)
+        hbox.pack_start(button)
+
+        button = gtk.Button(stock=gtk.STOCK_REMOVE)
+        button.connect("clicked", self.editable_settings_remove_item_clicked, setting_tree)
+        hbox.pack_start(button)
+
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
+        image.set_tooltip_text(tooltip)
+        setting_hbox.pack_start(image, expand=False, fill=False)
+
+        return setting_hbox, setting_store
+
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
             max_threads, split_model, parent, flags, buttons):
@@ -174,7 +485,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         image.show()
         image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
         image.set_tooltip_text(tooltip)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Select image types:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select image types:</span>")
         table.attach(label, 0, 9, 0, 1)
         table.attach(image, 9, 10, 0, 1)
 
@@ -199,26 +510,26 @@ class AdvancedSettingDialog (gtk.Dialog):
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
         tooltip = "Select package formats that will be used. "
         tooltip += "The first format will be used for final image"
-        pkgfmt_widget, self.pkgfmt_store = HobWidget.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
+        pkgfmt_widget, self.pkgfmt_store = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Image Rootfs Size: (MB)</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Image Rootfs Size: (MB)</span>")
         tooltip = "Sets the size of your target image.\nThis is the basic size of your target image, unless your selected package size exceeds this value, or you set value to \"Image Extra Size\"."
-        rootfs_size_widget, self.rootfs_size_spinner = HobWidget.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 1024, tooltip)
+        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Image Extra Size: (MB)</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Image Extra Size: (MB)</span>")
         tooltip = "Sets the extra free space of your target image.\nDefaultly, system will reserve 30% of your image size as your free space. If your image contains zypper, it will bring in 50MB more space. The maximum free space is 1024MB."
-        extra_size_widget, self.extra_size_spinner = HobWidget.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 1024, tooltip)
+        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
 
@@ -238,7 +549,7 @@ class AdvancedSettingDialog (gtk.Dialog):
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
 
         tooltip = "This is the Host platform you would like to run the toolchain"
-        sdk_machine_widget, self.sdk_machine_combo = HobWidget.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
+        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
         return advanced_vbox
@@ -249,49 +560,49 @@ class AdvancedSettingDialog (gtk.Dialog):
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Select Distro:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select Distro:</span>")
         tooltip = "This is the Yocto distribution you would like to use"
-        distro_widget, self.distro_combo = HobWidget.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
+        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(distro_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">BB_NUMBER_THREADS:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">BB_NUMBER_THREADS:</span>")
         tooltip = "Sets the number of threads that bitbake tasks can run simultaneously"
-        bbthread_widget, self.bb_spinner = HobWidget.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
+        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">PARALLEL_MAKE:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">PARALLEL_MAKE:</span>")
         tooltip = "Sets the make parallism, as known as 'make -j'"
-        pmake_widget, self.pmake_spinner = HobWidget.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
+        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = HobWidget.gen_entry_widget(self.split_model, self.configuration.dldir, self, tooltip)
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.split_model, self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
         tooltip = "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text = HobWidget.gen_entry_widget(self.split_model, self.configuration.sstatedir, self, tooltip)
+        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.split_model, self.configuration.sstatedir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
         tooltip = "Select the prebuilt mirror that will fasten your build speed"
-        sstatemirror_widget, self.sstatemirror_text = HobWidget.gen_entry_widget(self.split_model, self.configuration.sstatemirror, self, tooltip)
+        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.split_model, self.configuration.sstatemirror, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
 
@@ -303,9 +614,9 @@ class AdvancedSettingDialog (gtk.Dialog):
 
         sub_vbox = gtk.VBox(False, 5)
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
-        label = HobWidget.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
         tooltip = "This is the key/value pair for your extra settings"
-        setting_widget, self.setting_store = HobWidget.gen_editable_settings(self.configuration.extra_setting, tooltip)
+        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(setting_widget, expand=True, fill=True)
 
@@ -488,6 +799,127 @@ class DeployImageDialog (gtk.Dialog):
 #
 class LayerSelectionDialog (gtk.Dialog):
 
+    def gen_label_widget(self, content):
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup(content)
+        label.show()
+        return label
+
+    def layer_widget_toggled_cb(self, cell, path, layer_store):
+        name = layer_store[path][0]
+        toggle = not layer_store[path][1]
+        layer_store[path][1] = toggle
+
+    def layer_widget_add_clicked_cb(self, action, layer_store, parent):
+        dialog = gtk.FileChooserDialog("Add new layer", parent,
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
+                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
+                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
+        label = gtk.Label("Select the layer you wish to add")
+        label.show()
+        dialog.set_extra_widget(label)
+        response = dialog.run()
+        path = dialog.get_filename()
+        dialog.destroy()
+
+        lbl = "<b>Error</b>\nUnable to load layer <i>%s</i> because " % path
+        if response == gtk.RESPONSE_YES:
+            import os
+            import os.path
+            layers = []
+            it = layer_store.get_iter_first()
+            while it:
+                layers.append(layer_store.get_value(it, 0))
+                it = layer_store.iter_next(it)
+
+            if not path:
+                lbl += "it is an invalid path."
+            elif not os.path.exists(path+"/conf/layer.conf"):
+                lbl += "there is no layer.conf inside the directory."
+            elif path in layers:
+                lbl += "it is already in loaded layers."
+            else:
+                layer_store.append([path])
+                return
+            dialog = CrumbsDialog(parent, lbl)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            response = dialog.run()
+            dialog.destroy()
+
+    def layer_widget_del_clicked_cb(self, action, tree_selection, layer_store):
+        model, iter = tree_selection.get_selected()
+        if iter:
+            layer_store.remove(iter)
+
+
+    def gen_layer_widget(self, split_model, layers, layers_avail, window, tooltip=""):
+        hbox = gtk.HBox(False, 10)
+
+        layer_tv = gtk.TreeView()
+        layer_tv.set_rules_hint(True)
+        layer_tv.set_headers_visible(False)
+        tree_selection = layer_tv.get_selection()
+        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+
+        col0= gtk.TreeViewColumn('Path')
+        cell0 = gtk.CellRendererText()
+        cell0.set_padding(5,2)
+        col0.pack_start(cell0, True)
+        col0.set_attributes(cell0, text=0)
+        layer_tv.append_column(col0)
+
+        scroll = gtk.ScrolledWindow()
+        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
+        scroll.set_shadow_type(gtk.SHADOW_IN)
+        scroll.add(layer_tv)
+
+        table_layer = gtk.Table(2, 10, False)
+        hbox.pack_start(table_layer, expand=True, fill=True)
+
+        if split_model:
+            table_layer.attach(scroll, 0, 10, 0, 2)
+
+            layer_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
+            for layer in layers:
+                layer_store.set(layer_store.append(), 0, layer, 1, True)
+            for layer in layers_avail:
+                if layer not in layers:
+                    layer_store.set(layer_store.append(), 0, layer, 1, False)
+
+            col1 = gtk.TreeViewColumn('Included')
+            layer_tv.append_column(col1)
+
+            cell1 = gtk.CellRendererToggle()
+            cell1.connect("toggled", self.layer_widget_toggled_cb, layer_store)
+            col1.pack_start(cell1, True)
+            col1.set_attributes(cell1, active=1)
+
+        else:
+            table_layer.attach(scroll, 0, 10, 0, 1)
+
+            layer_store = gtk.ListStore(gobject.TYPE_STRING)
+            for layer in layers:
+                layer_store.set(layer_store.append(), 0, layer)
+
+            image = gtk.Image()
+            image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
+            add_button = gtk.Button()
+            add_button.set_image(image)
+            add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
+            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+            image = gtk.Image()
+            image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
+            del_button = gtk.Button()
+            del_button.set_image(image)
+            del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
+            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
+        layer_tv.set_model(layer_store)
+
+        hbox.show_all()
+
+        return hbox, layer_store
+
     def __init__(self, title, layers, all_layers, split_model,
             parent, flags, buttons):
         super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
@@ -514,9 +946,9 @@ class LayerSelectionDialog (gtk.Dialog):
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
         if self.split_model:
-            label = HobWidget.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>\n(Available layers under '${COREBASE}/layers/' directory)")
+            label = self.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>\n(Available layers under '${COREBASE}/layers/' directory)")
         else:
-            label = HobWidget.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>")
+            label = self.gen_label_widget("<span weight=\"bold\" font_desc='12'>Select Layers:</span>")
         hbox_top.pack_start(label, expand=False, fill=False)
 
         tooltip = "Layer is a collection of bb files and conf files"
@@ -525,7 +957,7 @@ class LayerSelectionDialog (gtk.Dialog):
         image.set_tooltip_text(tooltip)
         hbox_top.pack_end(image, expand=False, fill=False)
 
-        layer_widget, self.layer_store = HobWidget.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
+        layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
 
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
@@ -537,7 +969,7 @@ class LayerSelectionDialog (gtk.Dialog):
         self.vbox.pack_end(hbox_button, expand=False, fill=False)
         hbox_button.show()
 
-        label = HobWidget.gen_label_widget("<i>'meta' is Core layer for Yocto images</i>\n"
+        label = self.gen_label_widget("<i>'meta' is Core layer for Yocto images</i>\n"
         "<span weight=\"bold\">Please do not remove it</span>")
         hbox_button.pack_start(label, expand=False, fill=False)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 141c4ef..4bbbed6 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -50,471 +50,6 @@ class hic:
     ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
     ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
 
-class HobWidget:
-    @classmethod
-    def resize_widget(cls, screen, widget, widget_width, widget_height):
-        screen_width, screen_height = screen.get_size_request()
-        ratio_height = screen_width * hwc.MAIN_WIN_HEIGHT/hwc.MAIN_WIN_WIDTH
-        if ratio_height < screen_height:
-            screen_height = ratio_height
-        widget_width = widget_width * screen_width/hwc.MAIN_WIN_WIDTH
-        widget_height = widget_height * screen_height/hwc.MAIN_WIN_HEIGHT
-        widget.set_size_request(widget_width, widget_height)
-
-    @classmethod
-    def _toggle_cb(cls, cell, path, model, column):
-        it = model.get_iter(path)
-        val = model.get_value(it, column)
-        val = not val
-        model.set(it, column, val)
-
-    @classmethod
-    def _pkgfmt_up_clicked_cb(cls, button, tree_selection):
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
-    @classmethod
-    def _pkgfmt_down_clicked_cb(cls, button, tree_selection):
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
-    @classmethod
-    def _tree_selection_changed_cb(cls, tree_selection, button1, button2):
-        (model, it) = tree_selection.get_selected()        
-        inc = model.get_value(it, 2)
-        if inc:
-            button1.set_sensitive(True)
-            button2.set_sensitive(True)
-        else:
-            button1.set_sensitive(False)
-            button2.set_sensitive(False)
-
-    @classmethod
-    def _sort_func(cls, model, iter1, iter2, data):
-        val1 = model.get_value(iter1, 0)
-        val2 = model.get_value(iter2, 0)
-        inc1 = model.get_value(iter1, 2)
-        inc2 = model.get_value(iter2, 2)
-        if inc1 != inc2:
-            return inc2 - inc1
-        else:
-            return val1 - val2
-
-    @classmethod
-    def gen_pkgfmt_widget(cls, curr_package_format, all_package_format, tooltip=""):
-        pkgfmt_hbox = gtk.HBox(False, 15)
-
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
-
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
-        cell2.connect("toggled", cls._toggle_cb, pkgfmt_store, 2)
-        col.pack_start(cell, True)
-        col1.pack_start(cell1, True)
-        col2.pack_end(cell2, True)
-        col.set_attributes(cell, text=0)
-        col1.set_attributes(cell1, text=1)
-        col2.set_attributes(cell2, active=2)
-
-        pkgfmt_store.set_sort_func(0, cls._sort_func, None)
-        pkgfmt_store.set_sort_column_id(0, gtk.SORT_ASCENDING)
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(pkgfmt_tree)
-        scroll.set_size_request(200,60)
-        pkgfmt_hbox.pack_start(scroll, False, False, 0)
-
-        vbox = gtk.VBox(False, 5)
-        pkgfmt_hbox.pack_start(vbox, False, False, 15)
-
-        up = gtk.Button()
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_GO_UP, gtk.ICON_SIZE_MENU)
-        up.set_image(image)
-        up.set_size_request(50,30)
-        up.connect("clicked", cls._pkgfmt_up_clicked_cb, tree_selection)
-        vbox.pack_start(up, False, False, 5)
-
-        down = gtk.Button()
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_GO_DOWN, gtk.ICON_SIZE_MENU)
-        down.set_image(image)
-        down.set_size_request(50,30)
-        down.connect("clicked", cls._pkgfmt_down_clicked_cb, tree_selection)
-        vbox.pack_start(down, False, False, 5)
-        tree_selection.connect("changed", cls._tree_selection_changed_cb, up, down)
-
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        pkgfmt_hbox.pack_start(image, expand=False, fill=False)
-
-        pkgfmt_hbox.show_all()
-
-        return pkgfmt_hbox, pkgfmt_store
-
-    @classmethod
-    def gen_combo_widget(cls, curr_item, all_item, tooltip=""):
-        hbox = gtk.HBox(False, 10)
-        combo = gtk.combo_box_new_text()
-        hbox.pack_start(combo, expand=False, fill=False)
-
-        index = 0
-        for item in all_item or []:
-            combo.append_text(item)
-            if item == curr_item:
-                combo.set_active(index)
-            index += 1
-
-        image = gtk.Image()
-        image.show()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-
-        hbox.pack_start(image, expand=False, fill=False)
-
-        hbox.show_all()
-
-        return hbox, combo
-
-    @classmethod
-    def gen_label_widget(cls, content):
-        label = gtk.Label()
-        label.set_alignment(0, 0)
-        label.set_markup(content)
-        label.show()
-        return label
-
-    @classmethod
-    def _select_path_cb(cls, action, parent, entry):
-        dialog = gtk.FileChooserDialog("", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
-        response = dialog.run()
-        if response == gtk.RESPONSE_YES:
-            path = dialog.get_filename()
-            entry.set_text(path)
-
-        dialog.destroy()
-
-    @classmethod
-    def gen_entry_widget(cls, split_model, content, parent, tooltip=""):
-        hbox = gtk.HBox(False, 10)
-        entry = gtk.Entry()
-        entry.set_text(content)
-
-        if split_model:
-            hbox.pack_start(entry, expand=True, fill=True)
-        else:
-            table = gtk.Table(1, 10, True)
-            hbox.pack_start(table, expand=True, fill=True)
-            table.attach(entry, 0, 9, 0, 1)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
-            open_button = gtk.Button()
-            open_button.set_image(image)
-            open_button.connect("clicked", cls._select_path_cb, parent, entry)
-            table.attach(open_button, 9, 10, 0, 1)
-
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox.pack_start(image, expand=False, fill=False)
-
-        hbox.show_all()
-
-        return hbox, entry
-
-    @classmethod
-    def gen_spinner_widget(cls, content, lower, upper, tooltip=""):
-        hbox = gtk.HBox(False, 10)
-        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
-        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1, digits=0)
-                        
-        spinner.set_value(content)
-        hbox.pack_start(spinner, expand=False, fill=False)
-
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        hbox.pack_start(image, expand=False, fill=False)
-
-        hbox.show_all()
-
-        return hbox, spinner
-
-    @classmethod
-    def conf_error(cls, parent, lbl):
-        dialog = CrumbsDialog(parent, lbl)
-        dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
-        response = dialog.run()
-        dialog.destroy()
-
-    @classmethod
-    def _add_layer_cb(cls, action, layer_store, parent):
-        dialog = gtk.FileChooserDialog("Add new layer", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
-                                       (gtk.STOCK_OK, gtk.RESPONSE_YES,
-                                        gtk.STOCK_CANCEL, gtk.RESPONSE_NO))
-        label = gtk.Label("Select the layer you wish to add")
-        label.show()
-        dialog.set_extra_widget(label)
-        response = dialog.run()
-        path = dialog.get_filename()
-        dialog.destroy()
-
-        lbl = "<b>Error</b>\nUnable to load layer <i>%s</i> because " % path
-        if response == gtk.RESPONSE_YES:
-            import os
-            import os.path
-            layers = []
-            it = layer_store.get_iter_first()
-            while it:
-                layers.append(layer_store.get_value(it, 0))
-                it = layer_store.iter_next(it)
-
-            if not path:
-                lbl += "it is an invalid path."
-            elif not os.path.exists(path+"/conf/layer.conf"):
-                lbl += "there is no layer.conf inside the directory."
-            elif path in layers:
-                lbl += "it is already in loaded layers."
-            else:
-                layer_store.append([path])
-                return
-            cls.conf_error(parent, lbl)
-
-    @classmethod
-    def _del_layer_cb(cls, action, tree_selection, layer_store):
-        model, iter = tree_selection.get_selected()
-        if iter:
-            layer_store.remove(iter)
-
-    @classmethod
-    def _toggle_layer_cb(cls, cell, path, layer_store):
-        name = layer_store[path][0]
-        toggle = not layer_store[path][1]
-        layer_store[path][1] = toggle
-
-    @classmethod
-    def gen_layer_widget(cls, split_model, layers, layers_avail, window, tooltip=""):
-        hbox = gtk.HBox(False, 10)
-
-        layer_tv = gtk.TreeView()
-        layer_tv.set_rules_hint(True)
-        layer_tv.set_headers_visible(False)
-        tree_selection = layer_tv.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_SINGLE)
-
-        col0= gtk.TreeViewColumn('Path')
-        cell0 = gtk.CellRendererText()
-        cell0.set_padding(5,2)
-        col0.pack_start(cell0, True)
-        col0.set_attributes(cell0, text=0)
-        layer_tv.append_column(col0)
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(layer_tv)
-
-        table_layer = gtk.Table(2, 10, False)
-        hbox.pack_start(table_layer, expand=True, fill=True)
-
-        if split_model:
-            table_layer.attach(scroll, 0, 10, 0, 2)
-
-            layer_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
-            for layer in layers:
-                layer_store.set(layer_store.append(), 0, layer, 1, True)
-            for layer in layers_avail:
-                if layer not in layers:
-                    layer_store.set(layer_store.append(), 0, layer, 1, False)
-
-            col1 = gtk.TreeViewColumn('Included')
-            layer_tv.append_column(col1)
-
-            cell1 = gtk.CellRendererToggle()
-            cell1.connect("toggled", cls._toggle_layer_cb, layer_store)
-            col1.pack_start(cell1, True)
-            col1.set_attributes(cell1, active=1)
-
-        else:
-            table_layer.attach(scroll, 0, 10, 0, 1)
-
-            layer_store = gtk.ListStore(gobject.TYPE_STRING)
-            for layer in layers:
-                layer_store.set(layer_store.append(), 0, layer)
-
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
-            add_button = gtk.Button()
-            add_button.set_image(image)
-            add_button.connect("clicked", cls._add_layer_cb, layer_store, window)
-            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
-            del_button = gtk.Button()
-            del_button.set_image(image)
-            del_button.connect("clicked", cls._del_layer_cb, tree_selection, layer_store)
-            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 0)
-        layer_tv.set_model(layer_store)
-
-        hbox.show_all()
-
-        return hbox, layer_store
-
-    @classmethod
-    def _on_add_item_clicked(cls, button, model):
-        new_item = ["##KEY##", "##VALUE##"]
-
-        iter = model.append()
-        model.set (iter,
-            0, new_item[0],
-            1, new_item[1],
-       )
-
-
-    @classmethod
-    def _on_remove_item_clicked(cls, button, treeview):
-
-        selection = treeview.get_selection()
-        model, iter = selection.get_selected()
-
-        if iter:
-            path = model.get_path(iter)[0]
-            model.remove(iter)
-
-    @classmethod
-    def _on_cell_edited(cls, cell, path_string, new_text, model):
-        it = model.get_iter_from_string(path_string)
-        column = cell.get_data("column")
-        model.set(it, column, new_text)
-
-
-    @classmethod
-    def gen_editable_settings(cls, setting, tooltip=""):
-        setting_hbox = gtk.HBox(False, 10)
-
-        vbox = gtk.VBox(False, 10)
-        setting_hbox.pack_start(vbox, expand=True, fill=True)
-
-        setting_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
-        for key in setting.keys():
-            setting_store.set(setting_store.append(), 0, key, 1, setting[key])
-
-        setting_tree = gtk.TreeView(setting_store)
-        setting_tree.set_headers_visible(True)
-        setting_tree.set_size_request(300, 100)
-
-        col = gtk.TreeViewColumn('Key')
-        col.set_min_width(100)
-        col.set_max_width(150)
-        col.set_resizable(True)
-        col1 = gtk.TreeViewColumn('Value')
-        col1.set_min_width(100)
-        col1.set_max_width(150)
-        col1.set_resizable(True)
-        setting_tree.append_column(col)
-        setting_tree.append_column(col1)
-        cell = gtk.CellRendererText()
-        cell.set_property('width-chars', 10)
-        cell.set_property('editable', True)
-        cell.set_data("column", 0)
-        cell.connect("edited", cls._on_cell_edited, setting_store)
-        cell1 = gtk.CellRendererText()
-        cell1.set_property('width-chars', 10)
-        cell1.set_property('editable', True)
-        cell1.set_data("column", 1)
-        cell1.connect("edited", cls._on_cell_edited, setting_store)
-        col.pack_start(cell, True)
-        col1.pack_end(cell1, True)
-        col.set_attributes(cell, text=0)
-        col1.set_attributes(cell1, text=1)
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        scroll.add(setting_tree)
-        vbox.pack_start(scroll, expand=True, fill=True)
-
-        # some buttons
-        hbox = gtk.HBox(True, 4)
-        vbox.pack_start(hbox, False, False)
-
-        button = gtk.Button(stock=gtk.STOCK_ADD)
-        button.connect("clicked", cls._on_add_item_clicked, setting_store)
-        hbox.pack_start(button)
-
-        button = gtk.Button(stock=gtk.STOCK_REMOVE)
-        button.connect("clicked", cls._on_remove_item_clicked, setting_tree)
-        hbox.pack_start(button)
-
-        image = gtk.Image()
-        image.set_from_stock(gtk.STOCK_INFO, gtk.ICON_SIZE_BUTTON)
-        image.set_tooltip_text(tooltip)
-        setting_hbox.pack_start(image, expand=False, fill=False)
-
-        return setting_hbox, setting_store
-
 class HobViewTable (gtk.VBox):
     """
     A VBox to contain the table for different recipe views and package view
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 93540b2..cf8504a 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -23,7 +23,7 @@
 import gtk
 import glib
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobWidget, HobViewBar, HobViewTable
+from bb.ui.crumbs.hobwidget import HobViewBar, HobViewTable
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
-- 
1.7.6



