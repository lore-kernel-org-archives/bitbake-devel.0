Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 322586213E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 09:50:54 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2013 02:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,718,1363158000"; d="scan'208";a="338121987"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 02:50:57 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 12:52:35 +0300
Message-Id: <1369216355-13788-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1369216355-13788-1-git-send-email-cristiana.voicu@intel.com>
References: <1369216355-13788-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 2/2] hob: Table sorting criteria should not change after deselecting recipes/packages
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 May 2013 09:50:54 -0000

After a recipe/package is deselected, the table is sorted as before the
fadeout animation.

[YOCTO #4453]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |   20 ++++++++++++++------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    8 +++++++-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    6 ++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 887be79..7f7d82f 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -63,6 +63,7 @@ class PackageListModel(gtk.ListStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
+        self.sort_column_id, self.sort_order = PackageListModel.COL_NAME, gtk.SORT_ASCENDING
 
     """
     Find the model path for the item_name
@@ -109,11 +110,11 @@ class PackageListModel(gtk.ListStore):
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
+        sort.connect ('sort-column-changed', self.sort_column_changed_cb)
         if initial:
             sort.set_sort_column_id(PackageListModel.COL_NAME, gtk.SORT_ASCENDING)
             sort.set_default_sort_func(None)
-
-        if excluded_items_ahead:
+        elif excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
         elif included_items_ahead:
             sort.set_default_sort_func(self.include_item_sort_func, search_data)
@@ -121,7 +122,7 @@ class PackageListModel(gtk.ListStore):
             if search_data and search_data!='Search recipes by name' and search_data!='Search package groups by name':
                 sort.set_default_sort_func(self.sort_func, search_data)
             else:
-                sort.set_sort_column_id(PackageListModel.COL_NAME, gtk.SORT_ASCENDING)
+                sort.set_sort_column_id(self.sort_column_id, self.sort_order)
                 sort.set_default_sort_func(None)
 
         sort.set_sort_func(PackageListModel.COL_INC, self.sort_column, PackageListModel.COL_INC)
@@ -130,6 +131,9 @@ class PackageListModel(gtk.ListStore):
         sort.set_sort_func(PackageListModel.COL_RCP, self.sort_column, PackageListModel.COL_RCP)
         return sort
 
+    def sort_column_changed_cb (self, data):
+        self.sort_column_id, self.sort_order = data.get_sort_column_id ()
+
     def sort_column(self, model, row1, row2, col):
         value1 = model.get_value(row1, col)
         value2 = model.get_value(row2, col)
@@ -501,6 +505,7 @@ class RecipeListModel(gtk.ListStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING)
+        self.sort_column_id, self.sort_order = RecipeListModel.COL_NAME, gtk.SORT_ASCENDING
 
     """
     Find the model path for the item_name
@@ -586,11 +591,11 @@ class RecipeListModel(gtk.ListStore):
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
+        sort.connect ('sort-column-changed', self.sort_column_changed_cb)
         if initial:
             sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
             sort.set_default_sort_func(None)
-
-        if excluded_items_ahead:
+        elif excluded_items_ahead:
             sort.set_default_sort_func(self.exclude_item_sort_func, search_data)
         elif included_items_ahead:
             sort.set_default_sort_func(self.include_item_sort_func, search_data)
@@ -598,7 +603,7 @@ class RecipeListModel(gtk.ListStore):
             if search_data and search_data!='Search recipes by name' and search_data!='Search package groups by name':
                 sort.set_default_sort_func(self.sort_func, search_data)
             else:
-                sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
+                sort.set_sort_column_id(self.sort_column_id, self.sort_order)
                 sort.set_default_sort_func(None)
 
         sort.set_sort_func(RecipeListModel.COL_INC, self.sort_column, RecipeListModel.COL_INC)
@@ -607,6 +612,9 @@ class RecipeListModel(gtk.ListStore):
         sort.set_sort_func(RecipeListModel.COL_LIC, self.sort_column, RecipeListModel.COL_LIC)
         return sort
 
+    def sort_column_changed_cb (self, data):
+        self.sort_column_id, self.sort_order = data.get_sort_column_id ()
+
     def sort_column(self, model, row1, row2, col):
         value1 = model.get_value(row1, col)
         value2 = model.get_value(row2, col)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index b4cd47f..70caa48 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -310,11 +310,15 @@ class PackageSelectionPage (HobPage):
         glib.idle_add(self.toggle_item_idle_cb, path, view_tree, cell, pagename)
 
     def pre_fadeout_checkout_include(self, tree):
+        #after the fadeout the table will be sorted as before
+        self.sort_column_id = self.package_model.sort_column_id
+        self.sort_order = self.package_model.sort_order
+
         self.package_model.resync_fadeout_column(self.package_model.get_iter_first())
         # Check out a model which base on the column COL_FADE_INC,
         # it's save the prev state of column COL_INC before do exclude_item
         filter = { PackageListModel.COL_FADE_INC  : [True]}
-        new_model = self.package_model.tree_model(filter)
+        new_model = self.package_model.tree_model(filter, excluded_items_ahead=True)
         tree.set_model(new_model)
         tree.expand_all()
 
@@ -341,6 +345,8 @@ class PackageSelectionPage (HobPage):
         cell.fadeout(tree, 1000, to_render_cells)
 
     def after_fadeout_checkin_include(self, table, ctrl, cell, tree, filter):
+        self.package_model.sort_column_id = self.sort_column_id
+        self.package_model.sort_order = self.sort_order
         tree.set_model(self.package_model.tree_model(filter))
         tree.expand_all()
 
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index ffe310a..58db43f 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -287,6 +287,10 @@ class RecipeSelectionPage (HobPage):
         glib.idle_add(self.toggle_item_idle_cb, path, view_tree, cell, pagename)
 
     def pre_fadeout_checkout_include(self, tree, pagename):
+        #after the fadeout the table will be sorted as before
+        self.sort_column_id = self.recipe_model.sort_column_id
+        self.sort_order = self.recipe_model.sort_order
+
         #resync the included items to a backup fade include column
         it = self.recipe_model.get_iter_first()
         while it:
@@ -323,6 +327,8 @@ class RecipeSelectionPage (HobPage):
         cell.fadeout(tree, 1000, to_render_cells)
 
     def after_fadeout_checkin_include(self, table, ctrl, cell, tree, filter):
+        self.recipe_model.sort_column_id = self.sort_column_id
+        self.recipe_model.sort_order = self.sort_order
         tree.set_model(self.recipe_model.tree_model(filter))
 
     def set_recipe_curr_tab(self, curr_page):
-- 
1.7.9.5


