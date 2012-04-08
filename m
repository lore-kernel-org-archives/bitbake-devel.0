Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGozP-0004XW-T4
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:04:56 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Apr 2012 02:55:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151164316"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2012 02:55:39 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:06 +0800
Message-Id: <1b402179e218701541a0d2ec97a13d7f1c93a0d9.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 03/20] Hob: add fadeout display effection for package view include page
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
X-List-Received-Date: Sun, 08 Apr 2012 10:04:56 -0000

From: Liming An <limingx.l.an@intel.com>

[YOCTO #2100]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |   17 ++++++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |    6 ++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   52 +++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 523a591..f5e3740 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -428,6 +428,19 @@ class PackageListModel(gtk.TreeStore):
 
         self.selection_change_notification()
 
+    """
+    Resync the state of included items to a backup column before performing the fadeout visible effect
+    """
+    def resync_fadeout_column(self, model_first_iter=None):
+        it = model_first_iter
+        while it:
+            active = self.get_value(it, self.COL_INC)
+            self.set(it, self.COL_FADE_INC, active)
+            if self.iter_has_child(it):
+                self.resync_fadeout_column(self.iter_children(it))
+
+            it = self.iter_next(it)
+
 #
 # RecipeListModel
 #
@@ -509,12 +522,12 @@ class RecipeListModel(gtk.ListStore):
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items which are items specified by filter
     """
-    def tree_model(self, filter, excluded_items_head=False):
+    def tree_model(self, filter, excluded_items_ahead=False):
         model = self.filter_new()
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
-        if excluded_items_head:
+        if excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func)
         else:
             sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 41a59bd..21836f7 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -1057,7 +1057,11 @@ class HobCellRendererToggle(gtk.CellRendererToggle):
         if (not self.ctrl) or (not widget):
             return
         if self.ctrl.is_active():
-            path = widget.get_path_at_pos(cell_area.x + cell_area.width/2, cell_area.y + cell_area.height/2)[0]
+            path = widget.get_path_at_pos(cell_area.x + cell_area.width/2, cell_area.y + cell_area.height/2)
+            # sometimes the parameters of cell_area will be a negative number,such as pull up down the scroll bar
+            # it's over the tree container range, so the path will be bad
+            if not path: return
+            path = path[0]
             if path in self.ctrl.running_cell_areas:
                 cr = window.cairo_create()
                 color = gtk.gdk.Color(HobColors.WHITE)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 7926636..8391e29 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -110,10 +110,10 @@ class PackageSelectionPage (HobPage):
             tab = HobViewTable(columns)
             filter = page['filter']
             tab.set_model(self.package_model.tree_model(filter))
-            tab.connect("toggled", self.table_toggled_cb)
+            tab.connect("toggled", self.table_toggled_cb, page['name'])
             if page['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
-
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
@@ -176,18 +176,58 @@ class PackageSelectionPage (HobPage):
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
         self.ins.show_indicator_icon("Included", selected_packages_num)
 
-    def toggle_item_idle_cb(self, path):
+    def toggle_item_idle_cb(self, path, view_tree, cell, pagename):
         if not self.package_model.path_included(path):
             self.package_model.include_item(item_path=path, binb="User Selected")
         else:
-            self.package_model.exclude_item(item_path=path)
+            if pagename == "Included":
+                self.pre_fadeout_checkout_include(view_tree)
+                self.package_model.exclude_item(item_path=path)
+                self.render_fadeout(view_tree, cell)
+            else:
+                self.package_model.exclude_item(item_path=path)
 
         self.refresh_selection()
         self.builder.window_sensitive(True)
 
-    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
+    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree, pagename):
         # Click to include a package
         self.builder.window_sensitive(False)
         view_model = view_tree.get_model()
         path = self.package_model.convert_vpath_to_path(view_model, view_path)
-        glib.idle_add(self.toggle_item_idle_cb, path)
+        glib.idle_add(self.toggle_item_idle_cb, path, view_tree, cell, pagename)
+
+    def pre_fadeout_checkout_include(self, tree):
+        self.package_model.resync_fadeout_column(self.package_model.get_iter_first())
+        # Check out a model which base on the column COL_FADE_INC,
+        # it's save the prev state of column COL_INC before do exclude_item
+        filter = { PackageListModel.COL_FADE_INC  : [True]}
+        new_model = self.package_model.tree_model(filter)
+        tree.set_model(new_model)
+        tree.expand_all()
+
+    def get_excluded_rows(self, to_render_cells, model, it):
+        while it:
+            path = model.get_path(it)
+            prev_cell_is_active = model.get_value(it, PackageListModel.COL_FADE_INC)
+            curr_cell_is_active = model.get_value(it, PackageListModel.COL_INC)
+            if (prev_cell_is_active == True) and (curr_cell_is_active == False):
+                to_render_cells.append(path)
+            if model.iter_has_child(it):
+                self.get_excluded_rows(to_render_cells, model, model.iter_children(it))
+            it = model.iter_next(it)
+
+        return to_render_cells
+
+    def render_fadeout(self, tree, cell):
+        if (not cell) or (not tree):
+            return
+        to_render_cells = []
+        view_model = tree.get_model()
+        self.get_excluded_rows(to_render_cells, view_model, view_model.get_iter_first())
+
+        cell.fadeout(tree, 1000, to_render_cells)
+
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
+        tree.set_model(self.package_model.tree_model(self.pages[0]['filter']))
+        tree.expand_all()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 0568032..a2f7982 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -212,7 +212,7 @@ class RecipeSelectionPage (HobPage):
         # it's save the prev state of column COL_INC before do exclude_item
         filter = { RecipeListModel.COL_FADE_INC  : [True],
                    RecipeListModel.COL_TYPE      : ['recipe', 'task'] }
-        new_model = self.recipe_model.tree_model(filter, excluded_items_head=True)
+        new_model = self.recipe_model.tree_model(filter, excluded_items_ahead=True)
         tree.set_model(new_model)
 
     def render_fadeout(self, tree, cell):
-- 
1.7.6



