Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGozO-0004XS-QR
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:04:55 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2012 02:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129970280"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 08 Apr 2012 02:55:38 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:05 +0800
Message-Id: <74fc60a72163541aea9ff5f30f1da60fb49dc249.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 02/20] Hob: add fadeout display effection for recipe view include page
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
X-List-Received-Date: Sun, 08 Apr 2012 10:04:55 -0000

From: Liming An <limingx.l.an@intel.com>

As UI request, in recipes selection page, if user exclude a item,
the related depends recipes will be excluded together,so the view
clearly to add it.

[YOCTO #2100]

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py        |   22 +++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py           |  129 +++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |   50 ++++++++-
 3 files changed, 166 insertions(+), 35 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 4934ba8..523a591 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -34,7 +34,7 @@ class PackageListModel(gtk.TreeStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC) = range(11)
+    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC, COL_FADE_INC) = range(12)
 
     __gsignals__ = {
         "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -62,6 +62,7 @@ class PackageListModel(gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
+                                gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN)
 
 
@@ -437,7 +438,7 @@ class RecipeListModel(gtk.ListStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN) = range(11)
+    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC) = range(12)
 
     __dummy_image__ = "Create your own image"
 
@@ -461,7 +462,8 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING,
-                                gobject.TYPE_STRING)
+                                gobject.TYPE_STRING,
+                                gobject.TYPE_BOOLEAN)
 
     """
     Find the model path for the item_name
@@ -498,17 +500,25 @@ class RecipeListModel(gtk.ListStore):
 
         return True
 
+    def exclude_item_sort_func(self, model, iter1, iter2):
+        val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
+        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+        return ((val1 == True) and (val2 == False))
+
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items which are items specified by filter
     """
-    def tree_model(self, filter):
+    def tree_model(self, filter, excluded_items_head=False):
         model = self.filter_new()
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
-        sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
-        sort.set_default_sort_func(None)
+        if excluded_items_head:
+            sort.set_default_sort_func(self.exclude_item_sort_func)
+        else:
+            sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+            sort.set_default_sort_func(None)
         return sort
 
     def convert_vpath_to_path(self, view_model, view_path):
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index edb85db..41a59bd 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -105,6 +105,11 @@ class HobViewTable (gtk.VBox):
                             gobject.TYPE_NONE,
                            (gobject.TYPE_PYOBJECT,
                             gobject.TYPE_PYOBJECT,)),
+         "cell-fadeinout-stopped" : (gobject.SIGNAL_RUN_LAST,
+                            gobject.TYPE_NONE,
+                           (gobject.TYPE_PYOBJECT,
+                            gobject.TYPE_PYOBJECT,
+                            gobject.TYPE_PYOBJECT,)),
     }
 
     def __init__(self, columns):
@@ -134,9 +139,10 @@ class HobViewTable (gtk.VBox):
                 col.pack_start(cell, True)
                 col.set_attributes(cell, text=column['col_id'])
             elif column['col_style'] == 'check toggle':
-                cell = gtk.CellRendererToggle()
+                cell = HobCellRendererToggle()
                 cell.set_property('activatable', True)
                 cell.connect("toggled", self.toggled_cb, i, self.table_tree)
+                cell.connect_render_state_changed(self.stop_cell_fadeinout_cb, self.table_tree)
                 self.toggle_id = i
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=column['col_id'])
@@ -180,6 +186,9 @@ class HobViewTable (gtk.VBox):
         if not view_column.get_title() in self.toggle_columns:
             self.emit("row-activated", tree.get_model(), path)
 
+    def stop_cell_fadeinout_cb(self, ctrl, cell, tree):
+        self.emit("cell-fadeinout-stopped", ctrl, cell, tree)
+
 """
 A method to calculate a softened value for the colour of widget when in the
 provided state.
@@ -843,14 +852,23 @@ class HobIconChecker(hic):
 
         return valid_stock_id
 
-class RefreshRuningController(gobject.GObject):
-    def __init__(self, widget=None, iter=None):
+class HobCellRendererController(gobject.GObject):
+    (MODE_CYCLE_RUNNING, MODE_ONE_SHORT) = range(2)
+    __gsignals__ = {
+        "run-timer-stopped" : (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                                ()),
+    }
+    def __init__(self, runningmode=MODE_CYCLE_RUNNING, is_draw_row=False):
         gobject.GObject.__init__(self)
         self.timeout_id = None
         self.current_angle_pos = 0.0
         self.step_angle = 0.0
         self.tree_headers_height = 0
         self.running_cell_areas = []
+        self.running_mode = runningmode
+        self.is_queue_draw_row_area = is_draw_row
+        self.force_stop_enable = False
 
     def is_active(self):
         if self.timeout_id:
@@ -858,10 +876,10 @@ class RefreshRuningController(gobject.GObject):
         else:
             return False
 
-    def reset(self):
-        self.force_stop(True)
+    def reset_run(self):
+        self.force_stop()
+        self.running_cell_areas = []
         self.current_angle_pos = 0.0
-        self.timeout_id = None
         self.step_angle = 0.0
 
     ''' time_iterval: (1~1000)ms, which will be as the basic interval count for timer
@@ -881,15 +899,16 @@ class RefreshRuningController(gobject.GObject):
         self.timeout_id = gobject.timeout_add(int(time_iterval),
         self.make_image_on_progressing_cb, tree)
         self.tree_headers_height = self.get_treeview_headers_height(tree)
+        self.force_stop_enable = False
 
-    def force_stop(self, after_hide_or_not=False):
+    def force_stop(self):
+        self.emit("run-timer-stopped")
+        self.force_stop_enable = True
         if self.timeout_id:
-            gobject.source_remove(self.timeout_id)
-            self.timeout_id = None
-        if self.running_cell_areas:
-            self.running_cell_areas = []
+            if gobject.source_remove(self.timeout_id):
+                self.timeout_id = None
 
-    def on_draw_cb(self, pixbuf, cr, x, y, img_width, img_height, do_refresh=True):
+    def on_draw_pixbuf_cb(self, pixbuf, cr, x, y, img_width, img_height, do_refresh=True):
         if pixbuf:
             r = max(img_width/2, img_height/2)
             cr.translate(x + r, y + r)
@@ -899,6 +918,16 @@ class RefreshRuningController(gobject.GObject):
             cr.set_source_pixbuf(pixbuf, -img_width/2, -img_height/2)
             cr.paint()
 
+    def on_draw_fadeinout_cb(self, cr, color, x, y, width, height, do_fadeout=True):
+        if do_fadeout:
+            alpha = self.current_angle_pos * 0.8
+        else:
+            alpha = (1.0 - self.current_angle_pos) * 0.8
+
+        cr.set_source_rgba(color.red, color.green, color.blue, alpha)
+        cr.rectangle(x, y, width, height)
+        cr.fill()
+
     def get_treeview_headers_height(self, tree):
         if tree and (tree.get_property("headers-visible") == True):
             height = tree.get_allocation().height - tree.get_bin_window().get_size()[1]
@@ -908,13 +937,24 @@ class RefreshRuningController(gobject.GObject):
 
     def make_image_on_progressing_cb(self, tree):
         self.current_angle_pos += self.step_angle
-        if (self.current_angle_pos >= 1):
-            self.current_angle_pos = self.step_angle
-
-        for rect in self.running_cell_areas:
-            tree.queue_draw_area(rect.x, rect.y + self.tree_headers_height, rect.width, rect.height)
+        if self.running_mode == self.MODE_CYCLE_RUNNING:
+            if (self.current_angle_pos >= 1):
+                self.current_angle_pos = self.step_angle
+        else:
+            if self.current_angle_pos > 1:
+                self.force_stop()
+                return False
+
+        if self.is_queue_draw_row_area:
+            for path in self.running_cell_areas:
+                rect = tree.get_cell_area(path, tree.get_column(0))
+                row_x, _, row_width, _ = tree.get_visible_rect()
+                tree.queue_draw_area(row_x, rect.y + self.tree_headers_height, row_width, rect.height)
+        else:
+            for rect in self.running_cell_areas:
+                tree.queue_draw_area(rect.x, rect.y + self.tree_headers_height, rect.width, rect.height)
 
-        return True
+        return (not self.force_stop_enable)
 
     def append_running_cell_area(self, cell_area):
         if cell_area and (cell_area not in self.running_cell_areas):
@@ -924,14 +964,14 @@ class RefreshRuningController(gobject.GObject):
         if cell_area in self.running_cell_areas:
             self.running_cell_areas.remove(cell_area)
         if not self.running_cell_areas:
-            self.reset()
+            self.reset_run()
 
-gobject.type_register(RefreshRuningController)
+gobject.type_register(HobCellRendererController)
 
 class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
     def __init__(self):
         gtk.CellRendererPixbuf.__init__(self)
-        self.control = RefreshRuningController()
+        self.control = HobCellRendererController()
         # add icon checker for make the gtk-icon transfer to hob-icon
         self.checker = HobIconChecker()
         self.set_property("stock-size", gtk.ICON_SIZE_DND)
@@ -982,12 +1022,12 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         if stock_id == 'hic-task-refresh':
             self.control.append_running_cell_area(cell_area)
             if self.control.is_active():
-                self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, True)
+                self.control.on_draw_pixbuf_cb(pix, window.cairo_create(), x, y, w, h, True)
             else:
                 self.control.start_run(200, 0, 0, 1000, 200, tree)
         else:
             self.control.remove_running_cell_area(cell_area)
-            self.control.on_draw_cb(pix, window.cairo_create(), x, y, w, h, False)
+            self.control.on_draw_pixbuf_cb(pix, window.cairo_create(), x, y, w, h, False)
 
     def on_get_size(self, widget, cell_area):
         if self.props.icon_name or self.props.pixbuf or self.props.stock_id:
@@ -1005,3 +1045,46 @@ class HobCellRendererPixbuf(gtk.CellRendererPixbuf):
         return 0, 0, 0, 0
 
 gobject.type_register(HobCellRendererPixbuf)
+
+class HobCellRendererToggle(gtk.CellRendererToggle):
+    def __init__(self):
+        gtk.CellRendererToggle.__init__(self)
+        self.ctrl = HobCellRendererController(is_draw_row=True)
+        self.ctrl.running_mode = self.ctrl.MODE_ONE_SHORT
+        self.cell_attr = {"fadeout": False}
+
+    def do_render(self, window, widget, background_area, cell_area, expose_area, flags):
+        if (not self.ctrl) or (not widget):
+            return
+        if self.ctrl.is_active():
+            path = widget.get_path_at_pos(cell_area.x + cell_area.width/2, cell_area.y + cell_area.height/2)[0]
+            if path in self.ctrl.running_cell_areas:
+                cr = window.cairo_create()
+                color = gtk.gdk.Color(HobColors.WHITE)
+
+                row_x, _, row_width, _ = widget.get_visible_rect()
+                border_y = self.get_property("ypad")
+                self.ctrl.on_draw_fadeinout_cb(cr, color, row_x, cell_area.y - border_y, row_width, \
+                                               cell_area.height + border_y * 2, self.cell_attr["fadeout"])
+
+        return gtk.CellRendererToggle.do_render(self, window, widget, background_area, cell_area, expose_area, flags)
+
+    '''delay: normally delay time is 1000ms
+       cell_list: whilch cells need to be render
+    '''
+    def fadeout(self, tree, delay, cell_list=None):
+        if (delay < 200) or (not tree):
+            return
+        self.cell_attr["fadeout"] = True
+        self.ctrl.running_cell_areas = cell_list
+        self.ctrl.start_run(200, 0, 0, delay, (delay * 200 / 1000), tree)
+
+    def connect_render_state_changed(self, func, usrdata=None):
+        if not func:
+            return
+        if usrdata:
+            self.ctrl.connect("run-timer-stopped", func, self, usrdata)
+        else:
+            self.ctrl.connect("run-timer-stopped", func, self)
+
+gobject.type_register(HobCellRendererToggle)
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index e4616a8..0568032 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -132,10 +132,10 @@ class RecipeSelectionPage (HobPage):
             tab = HobViewTable(columns)
             filter = page['filter']
             tab.set_model(self.recipe_model.tree_model(filter))
-            tab.connect("toggled", self.table_toggled_cb)
+            tab.connect("toggled", self.table_toggled_cb, page['name'])
             if page['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
-
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
@@ -180,18 +180,56 @@ class RecipeSelectionPage (HobPage):
         self.label.set_text("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
         self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
 
-    def toggle_item_idle_cb(self, path):
+    def toggle_item_idle_cb(self, path, view_tree, cell, pagename):
         if not self.recipe_model.path_included(path):
             self.recipe_model.include_item(item_path=path, binb="User Selected", image_contents=False)
         else:
-            self.recipe_model.exclude_item(item_path=path)
+            if pagename == "Included":
+                self.pre_fadeout_checkout_include(view_tree)
+                self.recipe_model.exclude_item(item_path=path)
+                self.render_fadeout(view_tree, cell)
+            else:
+                self.recipe_model.exclude_item(item_path=path)
 
         self.refresh_selection()
         self.builder.window_sensitive(True)
 
-    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
+    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree, pagename):
         # Click to include a recipe
         self.builder.window_sensitive(False)
         view_model = view_tree.get_model()
         path = self.recipe_model.convert_vpath_to_path(view_model, view_path)
-        glib.idle_add(self.toggle_item_idle_cb, path)
+        glib.idle_add(self.toggle_item_idle_cb, path, view_tree, cell, pagename)
+
+    def pre_fadeout_checkout_include(self, tree):
+        #resync the included items to a backup fade include column
+        it = self.recipe_model.get_iter_first()
+        while it:
+            active = self.recipe_model.get_value(it, self.recipe_model.COL_INC)
+            self.recipe_model.set(it, self.recipe_model.COL_FADE_INC, active)
+            it = self.recipe_model.iter_next(it)
+        # Check out a model which base on the column COL_FADE_INC,
+        # it's save the prev state of column COL_INC before do exclude_item
+        filter = { RecipeListModel.COL_FADE_INC  : [True],
+                   RecipeListModel.COL_TYPE      : ['recipe', 'task'] }
+        new_model = self.recipe_model.tree_model(filter, excluded_items_head=True)
+        tree.set_model(new_model)
+
+    def render_fadeout(self, tree, cell):
+        if (not cell) or (not tree):
+            return
+        to_render_cells = []
+        model = tree.get_model()
+        it = model.get_iter_first()
+        while it:
+            path = model.get_path(it)
+            prev_cell_is_active = model.get_value(it, RecipeListModel.COL_FADE_INC)
+            curr_cell_is_active = model.get_value(it, RecipeListModel.COL_INC)
+            if (prev_cell_is_active == True) and (curr_cell_is_active == False):
+                to_render_cells.append(path)
+            it = model.iter_next(it)
+
+        cell.fadeout(tree, 1000, to_render_cells)
+
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
+        tree.set_model(self.recipe_model.tree_model(self.pages[0]['filter']))
-- 
1.7.6



