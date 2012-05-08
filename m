Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SRj1H-0006aT-Ld
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 May 2012 13:55:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 May 2012 04:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150484334"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 08 May 2012 04:46:02 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 May 2012 19:48:07 +0800
Message-Id: <826efc3bb7de5660779255c39a6cf0410dce48ab.1336477313.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
References: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1336477313.git.limingx.l.an@intel.com>
References: <cover.1336477313.git.limingx.l.an@intel.com>
Subject: [PATCH 3/4] Hob: add group number show and 'bold' visible effect for Package view
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
X-List-Received-Date: Tue, 08 May 2012 11:56:03 -0000

as ui design, add number of packages for each group, and make the
text font to 'bold' when row be selected

[YOCTO #2195]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    7 ++--
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   39 +++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   26 ++++++++++++++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 3f53432..0b54f91 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -34,7 +34,7 @@ class PackageListModel(gtk.TreeStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC, COL_FADE_INC) = range(12)
+    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC, COL_FADE_INC, COL_FONT) = range(13)
 
     __gsignals__ = {
         "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -65,7 +65,8 @@ class PackageListModel(gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_BOOLEAN,
-                                gobject.TYPE_BOOLEAN)
+                                gobject.TYPE_BOOLEAN,
+                                gobject.TYPE_STRING)
 
 
     """
@@ -189,7 +190,7 @@ class PackageListModel(gtk.TreeStore):
                      self.COL_SEC, section, self.COL_SUM, summary,
                      self.COL_RDEP, rdep + ' ' + rrec,
                      self.COL_RPROV, rprov, self.COL_SIZE, size,
-                     self.COL_BINB, "", self.COL_INC, False)
+                     self.COL_BINB, "", self.COL_INC, False, self.COL_FONT, '10')
 
     """
     Check whether the item at item_path is included or not
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 6cf73b0..3942827 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -119,6 +119,7 @@ class HobViewTable (gtk.VBox):
         self.table_tree.set_headers_clickable(True)
         self.table_tree.set_enable_search(True)
         self.table_tree.set_rules_hint(True)
+        self.table_tree.set_enable_tree_lines(True)
         self.table_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
         self.toggle_columns = []
         self.table_tree.connect("row-activated", self.row_activated_cb)
@@ -140,6 +141,8 @@ class HobViewTable (gtk.VBox):
                 cell = gtk.CellRendererText()
                 col.pack_start(cell, True)
                 col.set_attributes(cell, text=column['col_id'])
+                if 'col_t_id' in column.keys():
+                    col.add_attribute(cell, 'font', column['col_t_id'])
             elif column['col_style'] == 'check toggle':
                 cell = HobCellRendererToggle()
                 cell.set_property('activatable', True)
@@ -149,6 +152,8 @@ class HobViewTable (gtk.VBox):
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=column['col_id'])
                 self.toggle_columns.append(column['col_name'])
+                if 'col_group' in column.keys():
+                    col.set_cell_data_func(cell, self.set_group_number_cb)
             elif column['col_style'] == 'radio toggle':
                 cell = gtk.CellRendererToggle()
                 cell.set_property('activatable', True)
@@ -162,6 +167,8 @@ class HobViewTable (gtk.VBox):
                 cell = gtk.CellRendererText()
                 col.pack_start(cell, True)
                 col.set_cell_data_func(cell, self.display_binb_cb, column['col_id'])
+                if 'col_t_id' in column.keys():
+                    col.add_attribute(cell, 'font', column['col_t_id'])
 
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
@@ -204,6 +211,15 @@ class HobViewTable (gtk.VBox):
     def stop_cell_fadeinout_cb(self, ctrl, cell, tree):
         self.emit("cell-fadeinout-stopped", ctrl, cell, tree)
 
+    def set_group_number_cb(self, col, cell, model, iter):
+        if model and (model.iter_parent(iter) == None):
+            cell.cell_attr["number_of_children"] = model.iter_n_children(iter)
+        else:
+            cell.cell_attr["number_of_children"] = 0
+
+    def connect_group_selection(self, cb_func):
+        self.table_tree.get_selection().connect("changed", cb_func)
+
 """
 A method to calculate a softened value for the colour of widget when in the
 provided state.
@@ -1084,11 +1100,17 @@ class HobCellRendererToggle(gtk.CellRendererToggle):
         gtk.CellRendererToggle.__init__(self)
         self.ctrl = HobCellRendererController(is_draw_row=True)
         self.ctrl.running_mode = self.ctrl.MODE_ONE_SHORT
-        self.cell_attr = {"fadeout": False}
+        self.cell_attr = {"fadeout": False, "number_of_children": 0}
 
     def do_render(self, window, widget, background_area, cell_area, expose_area, flags):
         if (not self.ctrl) or (not widget):
             return
+
+        if flags & gtk.CELL_RENDERER_SELECTED:
+            state = gtk.STATE_SELECTED
+        else:
+            state = gtk.STATE_NORMAL
+
         if self.ctrl.is_active():
             path = widget.get_path_at_pos(cell_area.x + cell_area.width/2, cell_area.y + cell_area.height/2)
             # sometimes the parameters of cell_area will be a negative number,such as pull up down the scroll bar
@@ -1097,14 +1119,23 @@ class HobCellRendererToggle(gtk.CellRendererToggle):
             path = path[0]
             if path in self.ctrl.running_cell_areas:
                 cr = window.cairo_create()
-                color = gtk.gdk.Color(HobColors.WHITE)
+                color = widget.get_style().base[state]
 
                 row_x, _, row_width, _ = widget.get_visible_rect()
                 border_y = self.get_property("ypad")
                 self.ctrl.on_draw_fadeinout_cb(cr, color, row_x, cell_area.y - border_y, row_width, \
                                                cell_area.height + border_y * 2, self.cell_attr["fadeout"])
-
-        return gtk.CellRendererToggle.do_render(self, window, widget, background_area, cell_area, expose_area, flags)
+        # draw number of a group
+        if self.cell_attr["number_of_children"]:
+            text = "%d pkg" % self.cell_attr["number_of_children"]
+            pangolayout = widget.create_pango_layout(text)
+            textw, texth = pangolayout.get_pixel_size()
+            x = cell_area.x + (cell_area.width/2) - (textw/2)
+            y = cell_area.y + (cell_area.height/2) - (texth/2)
+
+            widget.style.paint_layout(window, state, True, cell_area, widget, "checkbox", x, y, pangolayout)
+        else:
+            return gtk.CellRendererToggle.do_render(self, window, widget, background_area, cell_area, expose_area, flags)
 
     '''delay: normally delay time is 1000ms
        cell_list: whilch cells need to be render
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 104d49d..238e2f9 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -39,6 +39,7 @@ class PackageSelectionPage (HobPage):
          'columns' : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 300,
@@ -46,6 +47,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Brought in by',
                        'col_id'   : PackageListModel.COL_BINB,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'binb',
                        'col_min'  : 100,
                        'col_max'  : 350,
@@ -53,6 +55,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 300,
@@ -60,7 +63,9 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'check toggle',
+                       'col_group': 'tree store group',
                        'col_min'  : 100,
                        'col_max'  : 100
                      }]
@@ -70,6 +75,7 @@ class PackageSelectionPage (HobPage):
          'columns' : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400,
@@ -77,6 +83,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
+                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 500,
@@ -85,6 +92,7 @@ class PackageSelectionPage (HobPage):
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
+                       'col_group': 'tree store group',
                        'col_min'  : 100,
                        'col_max'  : 100
                       }]
@@ -117,6 +125,7 @@ class PackageSelectionPage (HobPage):
             filter = page['filter']
             tab.set_model(self.package_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb, page['name'])
+            tab.connect_group_selection(self.table_selected_cb)
             if page['name'] == "Included":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
@@ -247,3 +256,20 @@ class PackageSelectionPage (HobPage):
     def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
         tree.set_model(self.package_model.tree_model(self.pages[0]['filter']))
         tree.expand_all()
+
+    def foreach_cell_change_font(self, model, path, iter, paths=None):
+        # Changed the font for a group cells
+        if path and iter and path[0] == paths[0]:
+            self.package_model.set(iter, self.package_model.COL_FONT, "bold")
+        else:
+            if iter and model.iter_parent(iter) == None:
+                self.package_model.set(iter, self.package_model.COL_FONT, '11')
+            else:
+                self.package_model.set(iter, self.package_model.COL_FONT, '10')
+
+    def table_selected_cb(self, selection):
+        model, paths = selection.get_selected_rows()
+        if paths:
+            child_path = self.package_model.convert_vpath_to_path(model, paths[0])
+            self.package_model.foreach(self.foreach_cell_change_font, child_path)
+
-- 
1.7.5.4



