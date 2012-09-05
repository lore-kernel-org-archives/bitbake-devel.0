Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1T9Der-0003mz-Et
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Sep 2012 13:20:34 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 05 Sep 2012 04:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,372,1344236400"; d="scan'208";a="189038470"
Received: from hp.sh.intel.com ([10.239.47.150])
	by azsmga001.ch.intel.com with ESMTP; 05 Sep 2012 04:08:03 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Sep 2012 19:13:48 +0800
Message-Id: <302f1088dbc5d678b309a5bc766afbb414de9e81.1346842933.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1346842933.git.limingx.l.an@intel.com>
References: <cover.1346842933.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob: change view of 'recipes' and 'packages' tables as ui design
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
X-List-Received-Date: Wed, 05 Sep 2012 11:20:34 -0000

changed the order of task tables,
cancel the 'description' column,
add the binb total number indicator, and so on

[YOCTO 2195]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    9 ++++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |    7 +++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   48 +++++----------------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   37 +++++++----------
 4 files changed, 41 insertions(+), 60 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 3de9e5b..10b7c55 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -521,17 +521,24 @@ class RecipeListModel(gtk.ListStore):
         val2 = model.get_value(iter2, RecipeListModel.COL_INC)
         return ((val1 == True) and (val2 == False))
 
+    def include_item_sort_func(self, model, iter1, iter2):
+        val1 = model.get_value(iter1, RecipeListModel.COL_INC)
+        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+        return ((val1 == False) and (val2 == True))
+
     """
     Create, if required, and return a filtered gtk.TreeModelSort
     containing only the items which are items specified by filter
     """
-    def tree_model(self, filter, excluded_items_ahead=False):
+    def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True):
         model = self.filter_new()
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
         if excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func)
+        elif included_items_ahead:
+            sort.set_default_sort_func(self.include_item_sort_func)
         else:
             sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
             sort.set_default_sort_func(None)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index d10c56b..f6811a6 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -182,7 +182,12 @@ class HobViewTable (gtk.VBox):
         # Just display the first item
         if binb:
             bin = binb.split(', ')
-            cell.set_property('text', bin[0])
+            total_no = len(bin)
+            if total_no > 1 and bin[0] == "User Selected":
+                present_binb = bin[1] + ' (+' + str(total_no) + ')'
+            else:
+                present_binb = bin[0] + ' (+' + str(total_no) + ')'
+            cell.set_property('text', present_binb)
         else:
             cell.set_property('text', "")
         return True
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 3576ed5..93ade7c 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -34,38 +34,33 @@ class PackageSelectionPage (HobPage):
 
     pages = [
         {
-         'name'    : 'Included',
+         'name'    : 'Included packages',
          'filter'  : { PackageListModel.COL_INC : [True] },
          'columns' : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
-                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Brought in by',
-                       'col_id'   : PackageListModel.COL_BINB,
-                       'col_t_id' : PackageListModel.COL_FONT,
-                       'col_style': 'binb',
-                       'col_min'  : 100,
-                       'col_max'  : 350,
-                       'expand'   : 'True'
-                      }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
-                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
+                       'col_name' : 'Brought in by',
+                       'col_id'   : PackageListModel.COL_BINB,
+                       'col_style': 'binb',
+                       'col_min'  : 100,
+                       'col_max'  : 350,
+                       'expand'   : 'True'
+                      }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
-                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'check toggle',
-                       'col_group': 'tree store group',
                        'col_min'  : 100,
                        'col_max'  : 100
                      }]
@@ -75,7 +70,6 @@ class PackageSelectionPage (HobPage):
          'columns' : [{
                        'col_name' : 'Package name',
                        'col_id'   : PackageListModel.COL_NAME,
-                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400,
@@ -83,7 +77,6 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Size',
                        'col_id'   : PackageListModel.COL_SIZE,
-                       'col_t_id' : PackageListModel.COL_FONT,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 500,
@@ -92,7 +85,6 @@ class PackageSelectionPage (HobPage):
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
-                       'col_group': 'tree store group',
                        'col_min'  : 100,
                        'col_max'  : 100
                       }]
@@ -131,8 +123,7 @@ class PackageSelectionPage (HobPage):
             filter = page['filter']
             tab.set_model(self.package_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb, page['name'])
-            tab.connect_group_selection(self.table_selected_cb)
-            if page['name'] == "Included":
+            if page['name'] == "Included packages":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             self.ins.append_page(tab, page['name'])
@@ -221,13 +212,13 @@ class PackageSelectionPage (HobPage):
 
         self.label.set_label("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
-        self.ins.show_indicator_icon("Included", selected_packages_num)
+        self.ins.show_indicator_icon("Included packages", selected_packages_num)
 
     def toggle_item_idle_cb(self, path, view_tree, cell, pagename):
         if not self.package_model.path_included(path):
             self.package_model.include_item(item_path=path, binb="User Selected")
         else:
-            if pagename == "Included":
+            if pagename == "Included packages":
                 self.pre_fadeout_checkout_include(view_tree)
                 self.package_model.exclude_item(item_path=path)
                 self.render_fadeout(view_tree, cell)
@@ -284,21 +275,6 @@ class PackageSelectionPage (HobPage):
         tree.set_model(self.package_model.tree_model(self.pages[0]['filter']))
         tree.expand_all()
 
-    def foreach_cell_change_font(self, model, path, iter, paths=None):
-        # Changed the font for a group cells
-        if path and iter and path[0] == paths[0]:
-            self.package_model.set(iter, self.package_model.COL_FONT, "bold")
-        else:
-            if iter and model.iter_parent(iter) == None:
-                self.package_model.set(iter, self.package_model.COL_FONT, '11')
-            else:
-                self.package_model.set(iter, self.package_model.COL_FONT, '10')
-
-    def table_selected_cb(self, selection):
-        model, paths = selection.get_selected_rows()
-        if paths:
-            child_path = self.package_model.convert_vpath_to_path(model, paths[0])
-            self.package_model.foreach(self.foreach_cell_change_font, child_path)
-
     def set_packages_curr_tab(self, curr_page):
         self.ins.set_current_page(curr_page)
+
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index d8e71b0..81bf7b8 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -33,7 +33,7 @@ from bb.ui.crumbs.hobpages import HobPage
 class RecipeSelectionPage (HobPage):
     pages = [
         {
-         'name'    : 'Included',
+         'name'    : 'Included recipes',
          'tooltip' : 'The recipes currently included for your image',
          'filter'  : { RecipeListModel.COL_INC  : [True],
                        RecipeListModel.COL_TYPE : ['recipe', 'task'] },
@@ -45,13 +45,6 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 400,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Brought in by',
-                       'col_id'   : RecipeListModel.COL_BINB,
-                       'col_style': 'binb',
-                       'col_min'  : 100,
-                       'col_max'  : 500,
-                       'expand'   : 'True'
-                      }, {
                        'col_name' : 'Group',
                        'col_id'   : RecipeListModel.COL_GROUP,
                        'col_style': 'text',
@@ -59,6 +52,13 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
+                       'col_name' : 'Brought in by',
+                       'col_id'   : RecipeListModel.COL_BINB,
+                       'col_style': 'binb',
+                       'col_min'  : 100,
+                       'col_max'  : 500,
+                       'expand'   : 'True'
+                      }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
@@ -77,15 +77,15 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 400,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'License',
-                       'col_id'   : RecipeListModel.COL_LIC,
+                       'col_name' : 'Group',
+                       'col_id'   : RecipeListModel.COL_GROUP,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Group',
-                       'col_id'   : RecipeListModel.COL_GROUP,
+                       'col_name' : 'License',
+                       'col_id'   : RecipeListModel.COL_LIC,
                        'col_style': 'text',
                        'col_min'  : 100,
                        'col_max'  : 400,
@@ -109,13 +109,6 @@ class RecipeSelectionPage (HobPage):
                        'col_max'  : 400,
                        'expand'   : 'True'
                       }, {
-                       'col_name' : 'Description',
-                       'col_id'   : RecipeListModel.COL_DESC,
-                       'col_style': 'text',
-                       'col_min'  : 100,
-                       'col_max'  : 400,
-                       'expand'   : 'True'
-                      }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
                        'col_style': 'check toggle',
@@ -156,7 +149,7 @@ class RecipeSelectionPage (HobPage):
             filter = page['filter']
             tab.set_model(self.recipe_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb, page['name'])
-            if page['name'] == "Included":
+            if page['name'] == "Included recipes":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             self.ins.append_page(tab, page['name'], page['tooltip'])
@@ -205,13 +198,13 @@ class RecipeSelectionPage (HobPage):
     def refresh_selection(self):
         self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
         _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()
-        self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
+        self.ins.show_indicator_icon("Included recipes", len(self.builder.configuration.selected_recipes))
 
     def toggle_item_idle_cb(self, path, view_tree, cell, pagename):
         if not self.recipe_model.path_included(path):
             self.recipe_model.include_item(item_path=path, binb="User Selected", image_contents=False)
         else:
-            if pagename == "Included":
+            if pagename == "Included recipes":
                 self.pre_fadeout_checkout_include(view_tree)
                 self.recipe_model.exclude_item(item_path=path)
                 self.render_fadeout(view_tree, cell)
-- 
1.7.5.4



