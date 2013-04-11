Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UQGZ4-0007IV-7X
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Apr 2013 14:25:27 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 11 Apr 2013 05:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,454,1363158000"; d="scan'208";a="317684789"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2013 05:07:23 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Apr 2013 15:07:59 +0300
Message-Id: <1365682079-14594-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Refine sorting mechanisms in Hob
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
X-List-Received-Date: Thu, 11 Apr 2013 12:25:27 -0000

-refine sorting functions for each column from recipe list page
and package list page
-sort correctly size column from packages list page
-set default sroting order and secondary sorting criteria
-make included on included recipes/packages no sortable

[YOCTO #2346 & #4194]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/imageselectiondialog.py   |    2 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |  107 +++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   16 ++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   11 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   14 +--
 5 files changed, 116 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py b/bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py
index 17f6bff..21216ad 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/imageselectiondialog.py
@@ -84,7 +84,7 @@ class ImageSelectionDialog (CrumbsDialog):
         open_button.connect("clicked", self.select_path_cb, self, entry)
         table.attach(open_button, 9, 10, 0, 1)
 
-        self.image_table = HobViewTable(self.__columns__)
+        self.image_table = HobViewTable(self.__columns__, "Images")
         self.image_table.set_size_request(-1, 300)
         self.image_table.connect("toggled", self.toggled_cb)
         self.image_table.connect_group_selection(self.table_selected_cb)
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 0bd9734..547c1ca 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -103,25 +103,55 @@ class PackageListModel(gtk.ListStore):
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items specified by filter
     """
-    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True, search_data=None):
+    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=False, search_data=None, initial=False):
         model = self.filter_new()
         self.filtered_nb = 0
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
+        if initial:
+            sort.set_sort_column_id(PackageListModel.COL_NAME, gtk.SORT_ASCENDING)
+            sort.set_default_sort_func(None)
+
         if excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
         elif included_items_ahead:
             sort.set_default_sort_func(self.include_item_sort_func, search_data)
         else:
-            sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
-            sort.set_default_sort_func(None)
+            if search_data and search_data!='Search recipes by name' and search_data!='Search package groups by name':
+                sort.set_default_sort_func(self.sort_func, search_data)
+            else:
+                sort.set_sort_column_id(PackageListModel.COL_NAME, gtk.SORT_ASCENDING)
+                sort.set_default_sort_func(None)
+
+        sort.set_sort_func(PackageListModel.COL_INC, self.sort_column, PackageListModel.COL_INC)
+        sort.set_sort_func(PackageListModel.COL_SIZE, self.sort_column, PackageListModel.COL_SIZE)
+        sort.set_sort_func(PackageListModel.COL_BINB, self.sort_column, PackageListModel.COL_BINB)
+        sort.set_sort_func(PackageListModel.COL_RCP, self.sort_column, PackageListModel.COL_RCP)
         return sort
 
+    def sort_column(self, model, row1, row2, col):
+        value1 = model.get_value(row1, col)
+        value2 = model.get_value(row2, col)
+        if col==PackageListModel.COL_SIZE:
+            value1 = HobPage._string_to_size(value1)
+            value2 = HobPage._string_to_size(value2)
+
+        cmp_res = cmp(value1, value2)
+        if cmp_res!=0:
+            if col==PackageListModel.COL_INC:
+                return -cmp_res
+            else:
+                return cmp_res
+        else:
+            name1 = model.get_value(row1, PackageListModel.COL_NAME)
+            name2 = model.get_value(row2, PackageListModel.COL_NAME)
+            return cmp(name1,name2)
+
     def exclude_item_sort_func(self, model, iter1, iter2, user_data=None):
         if user_data:
-            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
-            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            val1 = model.get_value(iter1, PackageListModel.COL_NAME)
+            val2 = model.get_value(iter2, PackageListModel.COL_NAME)
             if val1.startswith(user_data) and not val2.startswith(user_data):
                 return -1
             elif not val1.startswith(user_data) and val2.startswith(user_data):
@@ -129,14 +159,14 @@ class PackageListModel(gtk.ListStore):
             else:
                 return 0
         else:
-            val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
-            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            val1 = model.get_value(iter1, PackageListModel.COL_FADE_INC)
+            val2 = model.get_value(iter2, PackageListModel.COL_INC)
             return ((val1 == True) and (val2 == False))
 
     def include_item_sort_func(self, model, iter1, iter2, user_data=None):
         if user_data:
-            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
-            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            val1 = model.get_value(iter1, PackageListModel.COL_NAME)
+            val2 = model.get_value(iter2, PackageListModel.COL_NAME)
             if val1.startswith(user_data) and not val2.startswith(user_data):
                 return -1
             elif not val1.startswith(user_data) and val2.startswith(user_data):
@@ -144,10 +174,20 @@ class PackageListModel(gtk.ListStore):
             else:
                 return 0
         else:
-            val1 = model.get_value(iter1, RecipeListModel.COL_INC)
-            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            val1 = model.get_value(iter1, PackageListModel.COL_INC)
+            val2 = model.get_value(iter2, PackageListModel.COL_INC)
             return ((val1 == False) and (val2 == True))
 
+    def sort_func(self, model, iter1, iter2, user_data):
+        val1 = model.get_value(iter1, PackageListModel.COL_NAME)
+        val2 = model.get_value(iter2, PackageListModel.COL_NAME)
+        if val1.startswith(user_data) and not val2.startswith(user_data):
+            return -1
+        elif not val1.startswith(user_data) and val2.startswith(user_data):
+            return 1
+        else:
+            return 0
+
     def convert_vpath_to_path(self, view_model, view_path):
         # view_model is the model sorted
         # get the path of the model filtered
@@ -162,7 +202,7 @@ class PackageListModel(gtk.ListStore):
         it = view_model.get_iter_first()
         while it:
             name = self.find_item_for_path(path)
-            view_name = view_model.get_value(it, RecipeListModel.COL_NAME)
+            view_name = view_model.get_value(it, PackageListModel.COL_NAME)
             if view_name == name:
                 view_path = view_model.get_path(it)
                 return view_path
@@ -213,7 +253,6 @@ class PackageListModel(gtk.ListStore):
 
             # pkgsize is in KB
             size = HobPage._size_to_string(HobPage._string_to_size(pkgsize + ' KB'))
-
             self.set(self.append(), self.COL_NAME, pkg, self.COL_VER, pkgv,
                      self.COL_REV, pkgr, self.COL_RNM, pkg_rename,
                      self.COL_SEC, section, self.COL_SUM, summary,
@@ -520,25 +559,61 @@ class RecipeListModel(gtk.ListStore):
             val2 = model.get_value(iter2, RecipeListModel.COL_INC)
             return ((val1 == False) and (val2 == True))
 
+    def sort_func(self, model, iter1, iter2, user_data):
+        val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
+        val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+        if val1.startswith(user_data) and not val2.startswith(user_data):
+            return -1
+        elif not val1.startswith(user_data) and val2.startswith(user_data):
+            return 1
+        else:
+            return 0
+
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items specified by filter
     """
-    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True, search_data=None):
+    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=False, search_data=None, initial=False):
         model = self.filter_new()
         self.filtered_nb = 0
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
+        if initial:
+            sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+            sort.set_default_sort_func(None)
+
         if excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
         elif included_items_ahead:
             sort.set_default_sort_func(self.include_item_sort_func, search_data)
         else:
-            sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
-            sort.set_default_sort_func(None)
+            if search_data and search_data!='Search recipes by name' and search_data!='Search package groups by name':
+                sort.set_default_sort_func(self.sort_func, search_data)
+            else:
+                sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+                sort.set_default_sort_func(None)
+
+        sort.set_sort_func(RecipeListModel.COL_INC, self.sort_column, RecipeListModel.COL_INC)
+        sort.set_sort_func(RecipeListModel.COL_GROUP, self.sort_column, RecipeListModel.COL_GROUP)
+        sort.set_sort_func(RecipeListModel.COL_BINB, self.sort_column, RecipeListModel.COL_BINB)
+        sort.set_sort_func(RecipeListModel.COL_LIC, self.sort_column, RecipeListModel.COL_LIC)
         return sort
 
+    def sort_column(self, model, row1, row2, col):
+        value1 = model.get_value(row1, col)
+        value2 = model.get_value(row2, col)
+        cmp_res = cmp(value1, value2)
+        if cmp_res!=0:
+            if col==RecipeListModel.COL_INC:
+                return -cmp_res
+            else:
+                return cmp_res
+        else:
+            name1 = model.get_value(row1, RecipeListModel.COL_NAME)
+            name2 = model.get_value(row2, RecipeListModel.COL_NAME)
+            return cmp(name1,name2)
+
     def convert_vpath_to_path(self, view_model, view_path):
         filtered_model_path = view_model.convert_path_to_child_path(view_path)
         filtered_model = view_model.get_model()
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 1d1ae1a..eece930 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -83,7 +83,7 @@ class HobViewTable (gtk.VBox):
                             gobject.TYPE_PYOBJECT,)),
     }
 
-    def __init__(self, columns):
+    def __init__(self, columns, name):
         gtk.VBox.__init__(self, False, 6)
         self.table_tree = gtk.TreeView()
         self.table_tree.set_headers_visible(True)
@@ -94,12 +94,18 @@ class HobViewTable (gtk.VBox):
         self.toggle_columns = []
         self.table_tree.connect("row-activated", self.row_activated_cb)
         self.top_bar = None
+        self.tab_name = name
 
         for i, column in enumerate(columns):
-            col = gtk.TreeViewColumn(column['col_name'])
+            col_name = column['col_name']
+            col = gtk.TreeViewColumn(col_name)
             col.set_clickable(True)
             col.set_resizable(True)
-            col.set_sort_column_id(column['col_id'])
+            if self.tab_name.startswith('Included'):
+                if col_name!='Included':
+                    col.set_sort_column_id(column['col_id'])
+            else:
+                col.set_sort_column_id(column['col_id'])
             if 'col_min' in column.keys():
                 col.set_min_width(column['col_min'])
             if 'col_max' in column.keys():
@@ -122,7 +128,7 @@ class HobViewTable (gtk.VBox):
                 self.toggle_id = i
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=column['col_id'])
-                self.toggle_columns.append(column['col_name'])
+                self.toggle_columns.append(col_name)
                 if 'col_group' in column.keys():
                     col.set_cell_data_func(cell, self.set_group_number_cb)
             elif column['col_style'] == 'radio toggle':
@@ -133,7 +139,7 @@ class HobViewTable (gtk.VBox):
                 self.toggle_id = i
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=column['col_id'])
-                self.toggle_columns.append(column['col_name'])
+                self.toggle_columns.append(col_name)
             elif column['col_style'] == 'binb':
                 cell = gtk.CellRendererText()
                 col.pack_start(cell, True)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index fb9afcb..66cb7ff 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -142,17 +142,18 @@ class PackageSelectionPage (HobPage):
         # append the tab
         for page in self.pages:
             columns = page['columns']
-            tab = HobViewTable(columns)
+            name = page['name']
+            tab = HobViewTable(columns, name)
             search_names.append(page['search'])
             search_tips.append(page['searchtip'])
             filter = page['filter']
-            sort_model = self.package_model.tree_model(filter)
+            sort_model = self.package_model.tree_model(filter, initial=True)
             tab.set_model(sort_model)
-            tab.connect("toggled", self.table_toggled_cb, page['name'])
-            if page['name'] == "Included packages":
+            tab.connect("toggled", self.table_toggled_cb, name)
+            if name == "Included packages":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if page['name'] == "All packages":
+            if name == "All packages":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             self.ins.append_page(tab, page['name'], page['tooltip'])
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index d1e5b69..8573b81 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -154,20 +154,21 @@ class RecipeSelectionPage (HobPage):
         # append the tabs in order
         for page in self.pages:
             columns = page['columns']
-            tab = HobViewTable(columns)
+            name = page['name']
+            tab = HobViewTable(columns, name)
             search_names.append(page['search'])
             search_tips.append(page['searchtip'])
             filter = page['filter']
-            sort_model = self.recipe_model.tree_model(filter)
+            sort_model = self.recipe_model.tree_model(filter, initial=True)
             tab.set_model(sort_model)
-            tab.connect("toggled", self.table_toggled_cb, page['name'])
-            if page['name'] == "Included recipes":
+            tab.connect("toggled", self.table_toggled_cb, name)
+            if name == "Included recipes":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if page['name'] == "Package Groups":
+            if name == "Package Groups":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if page['name'] == "All recipes":
+            if name == "All recipes":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.button_click_cb)
             self.ins.append_page(tab, page['name'], page['tooltip'])
@@ -241,7 +242,6 @@ class RecipeSelectionPage (HobPage):
             properties['description'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_DESC)
             self.builder.show_recipe_property_dialog(properties)
 
-
     def build_packages_clicked_cb(self, button):
         self.builder.build_packages()
 
-- 
1.7.9.5



