Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Tzp11-0006ad-Ew
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 14:44:52 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Jan 2013 05:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,551,1355126400"; d="scan'208";a="283050629"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2013 05:29:09 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Jan 2013 15:33:39 +0200
Message-Id: <1359380019-27550-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Use a GtkTreeView to present and configure the sstate mirrors
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
X-List-Received-Date: Mon, 28 Jan 2013 13:44:52 -0000

After some discussions about the design of the Shared State Settings tab in Hob,
we have decided that using a GtkTreeView to present and configure the sstate
mirrors is probably the best solution.

[YOCTO #3569]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/settingsuihelper.py   |   94 --------
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |  231 +++++++++++++++++---
 2 files changed, 204 insertions(+), 121 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/settingsuihelper.py b/bitbake/lib/bb/ui/crumbs/hig/settingsuihelper.py
index e10dd06..e0285c9 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/settingsuihelper.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/settingsuihelper.py
@@ -120,97 +120,3 @@ class SettingsUIHelper():
 
         hbox.show_all()
         return hbox, entry
-
-    def gen_mirror_entry_widget(self, content, index, match_content=""):
-        hbox = gtk.HBox(False)
-        entry = gtk.Entry()
-        content = content[:-2]
-        entry.set_text(content)
-        entry.set_size_request(350,30)
-
-        entry_match = gtk.Entry()
-        entry_match.set_text(match_content)
-        entry_match.set_size_request(100,30)
-
-        table = gtk.Table(2, 5, False)
-        table.set_row_spacings(12)
-        table.set_col_spacings(6)
-        hbox.pack_start(table, expand=True, fill=True)
-
-        label_configuration = gtk.Label("Configuration")
-        label_configuration.set_alignment(0.0,0.5)
-        label_mirror_url = gtk.Label("Mirror URL")
-        label_mirror_url.set_alignment(0.0,0.5)
-        label_match = gtk.Label("Match")
-        label_match.set_alignment(0.0,0.5)
-        label_replace_with = gtk.Label("Replace with")
-        label_replace_with.set_alignment(0.0,0.5)
-
-        combo = gtk.combo_box_new_text()
-        combo.append_text("Standard")
-        combo.append_text("Custom")
-        if match_content == "":
-            combo.set_active(0)
-        else:
-            combo.set_active(1)
-        combo.connect("changed", self.on_combo_changed, index)
-        combo.set_size_request(100,30)
-
-        delete_button = HobAltButton("Delete")
-        delete_button.connect("clicked", self.delete_cb, index, entry)
-        if content == "" and index == 0  and len(self.sstatemirrors_list) == 1:
-            delete_button.set_sensitive(False)
-        delete_button.set_size_request(100, 30)
-
-        entry_match.connect("changed", self.insert_entry_match_cb, index)
-        entry.connect("changed", self.insert_entry_cb, index, delete_button)
-
-        if match_content == "":
-            table.attach(label_configuration, 1, 2, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
-            table.attach(label_mirror_url, 2, 3, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
-            table.attach(combo, 1, 2, 1, 2, xoptions=gtk.SHRINK)
-            table.attach(entry, 2, 3, 1, 2, xoptions=gtk.SHRINK)
-            table.attach(delete_button, 3, 4, 1, 2, xoptions=gtk.SHRINK)
-        else:
-            table.attach(label_configuration, 1, 2, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
-            table.attach(label_match, 2, 3, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
-            table.attach(label_replace_with, 3, 4, 0, 1, xoptions=gtk.SHRINK|gtk.FILL)
-            table.attach(combo, 1, 2, 1, 2, xoptions=gtk.SHRINK)
-            table.attach(entry_match, 2, 3, 1, 2, xoptions=gtk.SHRINK)
-            table.attach(entry, 3, 4, 1, 2, xoptions=gtk.SHRINK)
-            table.attach(delete_button, 4, 5, 1, 2, xoptions=gtk.SHRINK)
-
-        hbox.show_all()
-        return hbox
-
-    def insert_entry_match_cb(self, entry_match, index):
-        self.sstatemirrors_list[index][2] = entry_match.get_text()
-
-    def insert_entry_cb(self, entry, index, button):
-        self.sstatemirrors_list[index][1] = entry.get_text()
-        if entry.get_text() == "" and index == 0:
-            button.set_sensitive(False)
-        else:
-            button.set_sensitive(True)
-
-    def on_combo_changed(self, combo, index):
-        if combo.get_active_text() == "Standard":
-            self.sstatemirrors_list[index][0] = 0
-            self.sstatemirrors_list[index][2] = "file://(.*)"
-        else:
-            self.sstatemirrors_list[index][0] = 1
-        self.refresh_shared_state_page()
-
-    def delete_cb(self, button, index, entry):
-        if index == 0 and len(self.sstatemirrors_list)==1:
-            entry.set_text("")
-        else:
-            self.sstatemirrors_list.pop(index)
-            self.refresh_shared_state_page()
-
-    def add_mirror(self, button):
-        tooltip = "Select the pre-built mirror that will speed your build"
-        index = len(self.sstatemirrors_list)
-        sm_list = [0, "", "file://(.*)"]
-        self.sstatemirrors_list.append(sm_list)
-        self.refresh_shared_state_page()
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index 50c7510..5f316ae 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -50,6 +50,13 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
      TEST_NETWORK_FAILED,
      TEST_NETWORK_CANCELED) = range(6)
 
+    TARGETS = [
+        ("MY_TREE_MODEL_ROW", gtk.TARGET_SAME_WIDGET, 0),
+        ("text/plain", 0, 1),
+        ("TEXT", 0, 2),
+        ("STRING", 0, 3),
+        ]
+
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
             max_threads, parent, flags, handler, buttons=None):
@@ -84,6 +91,8 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.proxy_settings_changed = False
         self.handler = handler
         self.proxy_test_ran = False
+        self.selected_mirror_row = 0
+        self.new_mirror = False
 
         # create visual elements on the dialog
         self.create_visual_elements()
@@ -219,7 +228,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.configuration.sstatedir = self.sstatedir_text.get_text()
         self.configuration.sstatemirror = ""
         for mirror in self.sstatemirrors_list:
-            if mirror[1] != "":
+            if mirror[1] != "" and mirror[2].startswith("file://"):
                 if mirror[1].endswith("\\1"):
                     smirror = mirror[2] + " " + mirror[1] + " \\n "
                 else:
@@ -287,7 +296,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         label = self.gen_label_info_widget(content, tooltip)
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self)
         sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=12)
+        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False, padding=6)
 
         content = "<span weight=\"bold\">Shared state mirrors</span>"
         tooltip = "URLs pointing to pre-built mirrors that will speed your build. "
@@ -297,21 +306,17 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#shared-state\">Yocto Project Reference Manual</a>."
         table = self.gen_label_info_widget(content, tooltip)
-        advanced_vbox.pack_start(table, expand=False, fill=False)
+        advanced_vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         sub_vbox = gtk.VBox(False)
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.add_with_viewport(sub_vbox)
-        scroll.connect('size-allocate', self.scroll_changed)
-        advanced_vbox.pack_start(scroll, gtk.TRUE, gtk.TRUE, 0)
+        advanced_vbox.pack_start(sub_vbox, gtk.TRUE, gtk.TRUE, 0)
         searched_string = "file://"
 
         if self.sstatemirrors_changed == 0:
             self.sstatemirrors_changed = 1
             sstatemirrors = self.configuration.sstatemirror
             if sstatemirrors == "":
-                sm_list = [ 0, "", "file://(.*)"]
+                sm_list = ["Standard", "", "file://(.*)"]
                 self.sstatemirrors_list.append(sm_list)
             else:
                 while sstatemirrors.find(searched_string) != -1:
@@ -325,30 +330,206 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                     sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
                     if len(sstatemirror_fields):
                         if sstatemirror_fields[0] == "file://(.*)":
-                            sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
+                            sm_list = ["Standard", sstatemirror_fields[1], "file://(.*)"]
                         else:
-                            sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+                            sm_list = ["Custom", sstatemirror_fields[1], sstatemirror_fields[0]]
                         self.sstatemirrors_list.append(sm_list)
 
-        index = 0
-        for mirror in self.sstatemirrors_list:
-            if mirror[0] == 0:
-                sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index)
-            else:
-                sstatemirror_widget = self.gen_mirror_entry_widget(mirror[1], index, mirror[2])
-            sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False, padding=9)
-            index += 1
+        sstatemirrors_widget, sstatemirrors_store = self.gen_shared_sstate_widget(self.sstatemirrors_list, self)
+        sub_vbox.pack_start(sstatemirrors_widget, expand=True, fill=True)
 
-        table = gtk.Table(1, 1, False)
+        table = gtk.Table(1, 10, False)
         table.set_col_spacings(6)
-        add_mirror_button = HobAltButton("Add another mirror")
+        add_mirror_button = HobAltButton("Add mirror")
         add_mirror_button.connect("clicked", self.add_mirror)
-        add_mirror_button.set_size_request(150,30)
+        add_mirror_button.set_size_request(120,30)
         table.attach(add_mirror_button, 1, 2, 0, 1, xoptions=gtk.SHRINK)
-        advanced_vbox.pack_start(table, expand=False, fill=False, padding=9)
+
+        self.delete_button = HobAltButton("Delete mirror")
+        self.delete_button.connect("clicked", self.delete_cb)
+        self.delete_button.set_size_request(120, 30)
+        table.attach(self.delete_button, 3, 4, 0, 1, xoptions=gtk.SHRINK)
+
+        advanced_vbox.pack_start(table, expand=False, fill=False, padding=6)
 
         return advanced_vbox
 
+    def gen_shared_sstate_widget(self, sstatemirrors_list, window):
+        hbox = gtk.HBox(False)
+
+        sstatemirrors_store = gtk.ListStore(str, str, str)
+        for sstatemirror in sstatemirrors_list:
+            sstatemirrors_store.append(sstatemirror)
+
+        self.sstatemirrors_tv = gtk.TreeView()
+        self.sstatemirrors_tv.set_rules_hint(True)
+        self.sstatemirrors_tv.set_headers_visible(True)
+        tree_selection = self.sstatemirrors_tv.get_selection()
+        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+
+        # Allow enable drag and drop of rows including row move
+        self.sstatemirrors_tv.enable_model_drag_source( gtk.gdk.BUTTON1_MASK,
+            self.TARGETS,
+            gtk.gdk.ACTION_DEFAULT|
+            gtk.gdk.ACTION_MOVE)
+        self.sstatemirrors_tv.enable_model_drag_dest(self.TARGETS,
+            gtk.gdk.ACTION_DEFAULT)
+        self.sstatemirrors_tv.connect("drag_data_get", self.drag_data_get_cb)
+        self.sstatemirrors_tv.connect("drag_data_received", self.drag_data_received_cb)
+
+
+        self.scroll = gtk.ScrolledWindow()
+        self.scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
+        self.scroll.set_shadow_type(gtk.SHADOW_IN)
+        self.scroll.connect('size-allocate', self.scroll_changed)
+        self.scroll.add(self.sstatemirrors_tv)
+
+        #list store for cell renderer
+        m = gtk.ListStore(gobject.TYPE_STRING)
+        m.append(["Standard"])
+        m.append(["Custom"])
+
+        cell0 = gtk.CellRendererCombo()
+        cell0.set_property("model",m)
+        cell0.set_property("text-column", 0)
+        cell0.set_property("editable", True)
+        cell0.set_property("has-entry", False)
+        col0 = gtk.TreeViewColumn("Configuration")
+        col0.pack_start(cell0, False)
+        col0.add_attribute(cell0, "text", 0)
+        col0.set_cell_data_func(cell0, self.configuration_field)
+        self.sstatemirrors_tv.append_column(col0)
+
+        cell0.connect("edited", self.combo_changed, sstatemirrors_store)
+
+        self.cell1 = gtk.CellRendererText()
+        self.cell1.set_padding(5,2)
+        col1 = gtk.TreeViewColumn('Regex', self.cell1)
+        col1.set_cell_data_func(self.cell1, self.regex_field)
+        self.sstatemirrors_tv.append_column(col1)
+
+        self.cell1.connect("edited", self.regex_changed, sstatemirrors_store)
+
+        cell2 = gtk.CellRendererText()
+        cell2.set_padding(5,2)
+        cell2.set_property("editable", True)
+        col2 = gtk.TreeViewColumn('URL', cell2)
+        col2.set_cell_data_func(cell2, self.url_field)
+        self.sstatemirrors_tv.append_column(col2)
+
+        cell2.connect("edited", self.url_changed, sstatemirrors_store)
+
+        self.sstatemirrors_tv.set_model(sstatemirrors_store)
+        self.sstatemirrors_tv.set_cursor(self.selected_mirror_row)
+        hbox.pack_start(self.scroll, expand=True, fill=True)
+        hbox.show_all()
+
+        return hbox, sstatemirrors_store
+
+    def drag_data_get_cb(self, treeview, context, selection, target_id, etime):
+        treeselection = treeview.get_selection()
+        model, iter = treeselection.get_selected()
+        data = model.get_string_from_iter(iter)
+        selection.set(selection.target, 8, data)
+
+    def drag_data_received_cb(self, treeview, context, x, y, selection, info, etime):
+        model = treeview.get_model()
+        data = []
+        tree_iter = model.get_iter_from_string(selection.data)
+        data.append(model.get_value(tree_iter, 0))
+        data.append(model.get_value(tree_iter, 1))
+        data.append(model.get_value(tree_iter, 2))
+
+        drop_info = treeview.get_dest_row_at_pos(x, y)
+        if drop_info:
+            path, position = drop_info
+            iter = model.get_iter(path)
+            if (position == gtk.TREE_VIEW_DROP_BEFORE or position == gtk.TREE_VIEW_DROP_INTO_OR_BEFORE):
+                model.insert_before(iter, data)
+            else:
+                model.insert_after(iter, data)
+        else:
+            model.append(data)
+        if context.action == gtk.gdk.ACTION_MOVE:
+            context.finish(True, True, etime)
+        return
+
+    def delete_cb(self, button):
+        selection = self.sstatemirrors_tv.get_selection()
+        tree_model, tree_iter = selection.get_selected()
+        index = int(tree_model.get_string_from_iter(tree_iter))
+        if index == 0:
+            self.selected_mirror_row = index
+        else:
+            self.selected_mirror_row = index - 1
+        self.sstatemirrors_list.pop(index)
+        self.refresh_shared_state_page()
+        if not self.sstatemirrors_list:
+            self.delete_button.set_sensitive(False)
+
+    def add_mirror(self, button):
+        self.new_mirror = True
+        tooltip = "Select the pre-built mirror that will speed your build"
+        index = len(self.sstatemirrors_list)
+        self.selected_mirror_row = index
+        sm_list = ["Standard", "", "file://(.*)"]
+        self.sstatemirrors_list.append(sm_list)
+        self.refresh_shared_state_page()
+
+    def scroll_changed(self, widget, event, data=None):
+        if self.new_mirror == True:
+            adj = widget.get_vadjustment()
+            adj.set_value(adj.upper - adj.page_size)
+            self.new_mirror = False
+
+    def combo_changed(self, widget, path, text, model):
+        model[path][0] = text
+        selection = self.sstatemirrors_tv.get_selection()
+        tree_model, tree_iter = selection.get_selected()
+        index = int(tree_model.get_string_from_iter(tree_iter))
+        self.sstatemirrors_list[index][0] = text
+
+    def regex_changed(self, cell, path, new_text, user_data):
+        user_data[path][2] = new_text
+        selection = self.sstatemirrors_tv.get_selection()
+        tree_model, tree_iter = selection.get_selected()
+        index = int(tree_model.get_string_from_iter(tree_iter))
+        self.sstatemirrors_list[index][2] = new_text
+        return
+
+    def url_changed(self, cell, path, new_text, user_data):
+        if new_text!="Enter the mirror URL" and new_text!="Match regex and replace it with this URL":
+            user_data[path][1] = new_text
+            selection = self.sstatemirrors_tv.get_selection()
+            tree_model, tree_iter = selection.get_selected()
+            index = int(tree_model.get_string_from_iter(tree_iter))
+            self.sstatemirrors_list[index][1] = new_text
+        return
+
+    def configuration_field(self, column, cell, model, iter):
+        cell.set_property('text', model.get_value(iter, 0))
+        if model.get_value(iter, 0) == "Standard":
+            self.cell1.set_property("sensitive", False)
+            self.cell1.set_property("editable", False)
+        else:
+            self.cell1.set_property("sensitive", True)
+            self.cell1.set_property("editable", True)
+        return
+
+    def regex_field(self, column, cell, model, iter):
+        cell.set_property('text', model.get_value(iter, 2))
+        return
+
+    def url_field(self, column, cell, model, iter):
+        text = model.get_value(iter, 1)
+        if text == "":
+            if model.get_value(iter, 0) == "Standard":
+                text = "Enter the mirror URL"
+            else:
+                text = "Match regex and replace it with this URL"
+        cell.set_property('text', text)
+        return
+
     def refresh_shared_state_page(self):
         page_num = self.nb.get_current_page()
         self.nb.remove_page(page_num);
@@ -717,7 +898,3 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.handler.disconnect(self.proxy_test_passed_id)
         self.handler.disconnect(self.proxy_test_failed_id)
         super(SimpleSettingsDialog, self).destroy()
-
-    def scroll_changed(self, widget, event, data=None):
-        adj = widget.get_vadjustment()
-        adj.set_value(adj.upper - adj.page_size)
-- 
1.7.9.5



