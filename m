Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UIIPw-0000N0-M6
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Mar 2013 13:47:01 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2013 05:30:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,877,1355126400"; d="scan'208";a="273565673"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 20 Mar 2013 05:30:02 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Mar 2013 14:35:06 +0200
Message-Id: <1363782906-26116-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V2] hob: implementation of search functionality in Hob
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
X-List-Received-Date: Wed, 20 Mar 2013 12:47:02 -0000

Implemented the search functionality for recipes and packages using
filters on the listmodel. I have used the design which can be found in
bugzilla.

[YOCTO #3529]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |  118 ++++++++++++++++------
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   75 ++++++++++----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   57 ++++++++---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   67 ++++++++----
 4 files changed, 234 insertions(+), 83 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 0f37a06..9b8db23 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -85,34 +85,67 @@ class PackageListModel(gtk.ListStore):
     Helper function to determine whether an item is an item specified by filter
     """
     def tree_model_filter(self, model, it, filter):
-        for key in filter.keys():
-            if model.get_value(it, key) not in filter[key]:
-                return False
+        name = model.get_value(it, self.COL_NAME)
 
+        for key in filter.keys():
+            if key == self.COL_NAME:
+                if filter[key] != 'Search packages by name':
+                    if filter[key] not in name:
+                        return False
+            else:
+                if model.get_value(it, key) not in filter[key]:
+                    return False
+        self.filtered_nb += 1
         return True
 
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items specified by filter
     """
-    def tree_model(self, filter):
+    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True, search_data=None):
         model = self.filter_new()
+        self.filtered_nb = 0
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
-        sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
-        sort.set_default_sort_func(None)
+        if excluded_items_ahead:
+            sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
+        elif included_items_ahead:
+            sort.set_default_sort_func(self.include_item_sort_func, search_data)
+        else:
+            sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+            sort.set_default_sort_func(None)
         return sort
 
-    def exclude_item_sort_func(self, model, iter1, iter2):
-        val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
-        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
-        return ((val1 == True) and (val2 == False))
-
-    def include_item_sort_func(self, model, iter1, iter2):
-        val1 = model.get_value(iter1, RecipeListModel.COL_INC)
-        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
-        return ((val1 == False) and (val2 == True))
+    def exclude_item_sort_func(self, model, iter1, iter2, user_data=None):
+        if user_data:
+            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
+            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            if val1.startswith(user_data) and not val2.startswith(user_data):
+                return -1
+            elif not val1.startswith(user_data) and val2.startswith(user_data):
+                return 1
+            else:
+                return 0
+        else:
+            val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
+            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            return ((val1 == True) and (val2 == False))
+
+    def include_item_sort_func(self, model, iter1, iter2, user_data=None):
+        if user_data:
+            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
+            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            if val1.startswith(user_data) and not val2.startswith(user_data):
+                return -1
+            elif not val1.startswith(user_data) and val2.startswith(user_data):
+                return 1
+            else:
+                return 0
+        else:
+            val1 = model.get_value(iter1, RecipeListModel.COL_INC)
+            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            return ((val1 == False) and (val2 == True))
 
     def convert_vpath_to_path(self, view_model, view_path):
         # view_model is the model sorted
@@ -444,34 +477,61 @@ class RecipeListModel(gtk.ListStore):
             return False
 
         for key in filter.keys():
-            if model.get_value(it, key) not in filter[key]:
-                return False
+            if key == self.COL_NAME:
+                if filter[key] != 'Search recipes by name' and filter[key] != 'Search package groups by name':
+                    if filter[key] not in name:
+                        return False
+            else:
+                if model.get_value(it, key) not in filter[key]:
+                    return False
+        self.filtered_nb += 1
 
         return True
 
-    def exclude_item_sort_func(self, model, iter1, iter2):
-        val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
-        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
-        return ((val1 == True) and (val2 == False))
-
-    def include_item_sort_func(self, model, iter1, iter2):
-        val1 = model.get_value(iter1, RecipeListModel.COL_INC)
-        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
-        return ((val1 == False) and (val2 == True))
+    def exclude_item_sort_func(self, model, iter1, iter2, user_data=None):
+        if user_data:
+            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
+            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            if val1.startswith(user_data) and not val2.startswith(user_data):
+                return -1
+            elif not val1.startswith(user_data) and val2.startswith(user_data):
+                return 1
+            else:
+                return 0
+        else:
+            val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
+            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            return ((val1 == True) and (val2 == False))
+
+    def include_item_sort_func(self, model, iter1, iter2, user_data=None):
+        if user_data:
+            val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
+            val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+            if val1.startswith(user_data) and not val2.startswith(user_data):
+                return -1
+            elif not val1.startswith(user_data) and val2.startswith(user_data):
+                return 1
+            else:
+                return 0
+        else:
+            val1 = model.get_value(iter1, RecipeListModel.COL_INC)
+            val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+            return ((val1 == False) and (val2 == True))
 
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items specified by filter
     """
-    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True):
+    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True, search_data=None):
         model = self.filter_new()
+        self.filtered_nb = 0
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
         if excluded_items_ahead:
-            sort.set_default_sort_func(self.exclude_item_sort_func)
+            sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
         elif included_items_ahead:
-            sort.set_default_sort_func(self.include_item_sort_func)
+            sort.set_default_sort_func(self.include_item_sort_func, search_data)
         else:
             sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
             sort.set_default_sort_func(None)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 9a00e94..17d9cee 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -88,12 +88,12 @@ class HobViewTable (gtk.VBox):
         self.table_tree = gtk.TreeView()
         self.table_tree.set_headers_visible(True)
         self.table_tree.set_headers_clickable(True)
-        self.table_tree.set_enable_search(True)
         self.table_tree.set_rules_hint(True)
         self.table_tree.set_enable_tree_lines(True)
         self.table_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
         self.toggle_columns = []
         self.table_tree.connect("row-activated", self.row_activated_cb)
+        self.top_bar = None
 
         for i, column in enumerate(columns):
             col = gtk.TreeViewColumn(column['col_name'])
@@ -141,10 +141,41 @@ class HobViewTable (gtk.VBox):
                 if 'col_t_id' in column.keys():
                     col.add_attribute(cell, 'font', column['col_t_id'])
 
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
-        scroll.add(self.table_tree)
-        self.pack_start(scroll, True, True, 0)
+        self.scroll = gtk.ScrolledWindow()
+        self.scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
+        self.scroll.add(self.table_tree)
+
+        self.pack_end(self.scroll, True, True, 0)
+
+    def add_no_result_bar(self, entry):
+        color = HobColors.KHAKI
+        self.top_bar = gtk.EventBox()
+        self.top_bar.set_size_request(-1, 70)
+        self.top_bar.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
+        self.top_bar.set_flags(gtk.CAN_DEFAULT)
+        self.top_bar.grab_default()
+
+        no_result_tab = gtk.Table(5, 20, True)
+        self.top_bar.add(no_result_tab)
+
+        label = gtk.Label()
+        label.set_alignment(0.0, 0.5)
+        title = "No results matching your search"
+        label.set_markup("<span size='x-large'><b>%s</b></span>" % title)
+        no_result_tab.attach(label, 1, 14, 1, 4)
+
+        clear_button = HobButton("Clear search")
+        clear_button.connect('clicked', self.set_search_entry_clear_cb, entry)
+        no_result_tab.attach(clear_button, 16, 19, 1, 4)
+
+        self.pack_start(self.top_bar, False, True, 12)
+        self.top_bar.show_all()
+
+    def set_search_entry_clear_cb(self, button, search):
+        if search.get_editable() == True:
+            search.set_text("")
+        search.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+        search.grab_focus()
 
     def display_binb_cb(self, col, cell, model, it, col_id):
         binb =  model.get_value(it, col_id)
@@ -170,10 +201,6 @@ class HobViewTable (gtk.VBox):
     def set_model(self, tree_model):
         self.table_tree.set_model(tree_model)
 
-    def set_search_entry(self, search_column_id, entry):
-        self.table_tree.set_search_column(search_column_id)
-        self.table_tree.set_search_entry(entry)
-
     def toggle_default(self):
         model = self.table_tree.get_model()
         if not model:
@@ -453,7 +480,6 @@ class HobNotebook(gtk.Notebook):
         self.pages = []
 
         self.search = None
-        self.search_name = ""
 
         self.connect("switch-page", self.page_changed_cb)
 
@@ -466,6 +492,9 @@ class HobNotebook(gtk.Notebook):
             else:
                 lbl.set_active(False)
 
+        if self.search:
+            self.reset_entry(self.search, page_num)
+
     def append_page(self, child, tab_label, tab_tooltip=None):
         label = HobTabLabel(tab_label)
         if tab_tooltip:
@@ -474,16 +503,22 @@ class HobNotebook(gtk.Notebook):
         self.pages.append(label)
         gtk.Notebook.append_page(self, child, label)
 
-    def set_entry(self, name="Search:"):
+    def set_entry(self, names, tips):
         self.search = gtk.Entry()
-        self.search_name = name
+        self.search_names = names
+        self.search_tips = tips
         style = self.search.get_style()
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
         self.search.set_style(style)
-        self.search.set_text(name)
+        self.search.set_text(names[0])
+        self.search.set_tooltip_text(self.search_tips[0])
+        self.search.props.has_tooltip = True
+
         self.search.set_editable(False)
         self.search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, gtk.STOCK_CLEAR)
+        self.search.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
         self.search.connect("icon-release", self.set_search_entry_clear_cb)
+        self.search.set_width_chars(30)
         self.search.show()
 
         self.search.connect("focus-in-event", self.set_search_entry_editable_cb)
@@ -507,19 +542,23 @@ class HobNotebook(gtk.Notebook):
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
         search.set_style(style)
 
-    def reset_entry(self, entry):
+    def set_search_entry_reset_cb(self, search, event):
+        page_num = self.get_current_page()
+        self.reset_entry(search, page_num)
+
+    def reset_entry(self, entry, page_num):
         style = entry.get_style()
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.GRAY, False, False)
         entry.set_style(style)
-        entry.set_text(self.search_name)
+        entry.set_text(self.search_names[page_num])
+        entry.set_tooltip_text(self.search_tips[page_num])
         entry.set_editable(False)
-
-    def set_search_entry_reset_cb(self, search, event):
-        self.reset_entry(search)
+        entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
 
     def set_search_entry_clear_cb(self, search, icon_pos, event):
         if search.get_editable() == True:
             search.set_text("")
+        search.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
 
     def set_page(self, title):
         for child in self.pages:
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 6f9a4e2..ce2deab 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -34,10 +34,12 @@ class PackageSelectionPage (HobPage):
 
     pages = [
         {
-         'name'    : 'Included packages',
-         'tooltip' : 'The packages currently included for your image',
-         'filter'  : { PackageListModel.COL_INC : [True] },
-         'columns' : [{
+         'name'      : 'Included packages',
+         'tooltip'   : 'The packages currently included for your image',
+         'filter'    : { PackageListModel.COL_INC : [True] },
+         'search'    : 'Search packages by name',
+         'searchtip' : 'Enter a package name to find it',
+         'columns'   : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
@@ -73,10 +75,12 @@ class PackageSelectionPage (HobPage):
                        'col_max'  : 100
                      }]
         }, {
-         'name'    : 'All packages',
-         'tooltip' : 'All packages that have been built',
-         'filter'  : {},
-         'columns' : [{
+         'name'      : 'All packages',
+         'tooltip'   : 'All packages that have been built',
+         'filter'    : {},
+         'search'    : 'Search packages by name',
+         'searchtip' : 'Enter a package name to find it',
+         'columns'   : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
                        'col_style': 'text',
@@ -132,12 +136,18 @@ class PackageSelectionPage (HobPage):
         # set visible members
         self.ins = HobNotebook()
         self.tables = [] # we need to modify table when the dialog is shown
+
+        search_names = []
+        search_tips = []
         # append the tab
         for page in self.pages:
             columns = page['columns']
             tab = HobViewTable(columns)
+            search_names.append(page['search'])
+            search_tips.append(page['searchtip'])
             filter = page['filter']
-            tab.set_model(self.package_model.tree_model(filter))
+            sort_model = self.package_model.tree_model(filter)
+            tab.set_model(sort_model)
             tab.connect("toggled", self.table_toggled_cb, page['name'])
             if page['name'] == "Included packages":
                 tab.connect("button-release-event", self.button_click_cb)
@@ -148,13 +158,8 @@ class PackageSelectionPage (HobPage):
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
-        self.ins.set_entry("Search packages:")
-        # set the search entry for each table
-        for tab in self.tables:
-            search_tip = "Enter a package name to find it"
-            self.ins.search.set_tooltip_text(search_tip)
-            self.ins.search.props.has_tooltip = True
-            tab.set_search_entry(0, self.ins.search)
+        self.ins.set_entry(search_names, search_tips)
+        self.ins.search.connect("changed", self.search_entry_changed)
 
         # add all into the dialog
         self.box_group_area.pack_start(self.ins, expand=True, fill=True)
@@ -174,6 +179,26 @@ class PackageSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_end(self.back_button, expand=False, fill=False)
 
+    def search_entry_changed(self, entry):
+        current_tab = self.ins.get_current_page()
+        filter = self.pages[current_tab]['filter']
+        text = entry.get_text()
+        filter[PackageListModel.COL_NAME] = text
+        self.tables[current_tab].set_model(self.package_model.tree_model(filter, search_data=text))
+        if self.package_model.filtered_nb == 0:
+            if not self.ins.get_nth_page(current_tab).top_bar:
+                self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+            self.ins.get_nth_page(current_tab).top_bar.show()
+            self.ins.get_nth_page(current_tab).scroll.hide()
+        else:
+            if self.ins.get_nth_page(current_tab).top_bar:
+                self.ins.get_nth_page(current_tab).top_bar.hide()
+            self.ins.get_nth_page(current_tab).scroll.show()
+        if entry.get_text() == '':
+            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+        else:
+            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 636762e..aa0cd60 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -33,11 +33,13 @@ from bb.ui.crumbs.hobpages import HobPage
 class RecipeSelectionPage (HobPage):
     pages = [
         {
-         'name'    : 'Included recipes',
-         'tooltip' : 'The recipes currently included for your image',
-         'filter'  : { RecipeListModel.COL_INC  : [True],
+         'name'      : 'Included recipes',
+         'tooltip'   : 'The recipes currently included for your image',
+         'filter'    : { RecipeListModel.COL_INC  : [True],
                        RecipeListModel.COL_TYPE : ['recipe', 'packagegroup'] },
-         'columns' : [{
+         'search'    : 'Search recipes by name',
+         'searchtip' : 'Enter a recipe name to find it',
+         'columns'   : [{
                        'col_name' : 'Recipe name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
@@ -66,10 +68,12 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 100
                       }]
         }, {
-         'name'    : 'All recipes',
-         'tooltip' : 'All recipes in your configured layers',
-         'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
-         'columns' : [{
+         'name'      : 'All recipes',
+         'tooltip'   : 'All recipes in your configured layers',
+         'filter'    : { RecipeListModel.COL_TYPE : ['recipe'] },
+         'search'    : 'Search recipes by name',
+         'searchtip' : 'Enter a recipe name to find it',
+         'columns'   : [{
                        'col_name' : 'Recipe name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
@@ -98,10 +102,12 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 100
                       }]
         }, {
-         'name'    : 'Package Groups',
-         'tooltip' : 'All package groups in your configured layers',
-         'filter'  : { RecipeListModel.COL_TYPE : ['packagegroup'] },
-         'columns' : [{
+         'name'      : 'Package Groups',
+         'tooltip'   : 'All package groups in your configured layers',
+         'filter'    : { RecipeListModel.COL_TYPE : ['packagegroup'] },
+         'search'    : 'Search package groups by name',
+         'searchtip' : 'Enter a package group name to find it',
+         'columns'   : [{
                        'col_name' : 'Package group name',
                        'col_id'   : RecipeListModel.COL_NAME,
                        'col_style': 'text',
@@ -142,12 +148,18 @@ class RecipeSelectionPage (HobPage):
         # set visible members
         self.ins = HobNotebook()
         self.tables = [] # we need modify table when the dialog is shown
+
+        search_names = []
+        search_tips = []
         # append the tabs in order
         for page in self.pages:
             columns = page['columns']
             tab = HobViewTable(columns)
+            search_names.append(page['search'])
+            search_tips.append(page['searchtip'])
             filter = page['filter']
-            tab.set_model(self.recipe_model.tree_model(filter))
+            sort_model = self.recipe_model.tree_model(filter)
+            tab.set_model(sort_model)
             tab.connect("toggled", self.table_toggled_cb, page['name'])
             if page['name'] == "Included recipes":
                 tab.connect("button-release-event", self.button_click_cb)
@@ -161,13 +173,8 @@ class RecipeSelectionPage (HobPage):
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
-        self.ins.set_entry("Search recipes:")
-        # set the search entry for each table
-        for tab in self.tables:
-            search_tip = "Enter a recipe's or task's name to find it"
-            self.ins.search.set_tooltip_text(search_tip)
-            self.ins.search.props.has_tooltip = True
-            tab.set_search_entry(0, self.ins.search)
+        self.ins.set_entry(search_names, search_tips)
+        self.ins.search.connect("changed", self.search_entry_changed)
 
         # add all into the window
         self.box_group_area.pack_start(self.ins, expand=True, fill=True)
@@ -187,6 +194,26 @@ class RecipeSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_end(self.back_button, expand=False, fill=False)
 
+    def search_entry_changed(self, entry):
+        current_tab = self.ins.get_current_page()
+        filter = self.pages[current_tab]['filter']
+        text = entry.get_text()
+        filter[RecipeListModel.COL_NAME] = text
+        self.tables[current_tab].set_model(self.recipe_model.tree_model(filter, search_data=text))
+        if self.recipe_model.filtered_nb == 0:
+            if not self.ins.get_nth_page(current_tab).top_bar:
+                self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+            self.ins.get_nth_page(current_tab).top_bar.show()
+            self.ins.get_nth_page(current_tab).scroll.hide()
+        else:
+            if self.ins.get_nth_page(current_tab).top_bar:
+                self.ins.get_nth_page(current_tab).top_bar.hide()
+            self.ins.get_nth_page(current_tab).scroll.show()
+        if entry.get_text() == '':
+            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+        else:
+            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
-- 
1.7.9.5



