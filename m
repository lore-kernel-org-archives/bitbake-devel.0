Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id DCF2D60657
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 May 2013 09:50:49 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2013 02:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,718,1363158000"; d="scan'208";a="338121965"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 22 May 2013 02:50:54 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 May 2013 12:52:34 +0300
Message-Id: <1369216355-13788-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1369216355-13788-1-git-send-email-cristiana.voicu@intel.com>
References: <1369216355-13788-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 1/2] hob: apply a fade out animation when deselecting from tables
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
X-List-Received-Date: Wed, 22 May 2013 09:50:50 -0000

-applied a fade out mechanism for deselctiong on all the tabs of
recipes and packages list page
-set cursor on the package/recipe when it is included(important
when the its place is changing; like when the tree si order by
included tab)

[YOCTO #4342]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   24 ++++++-------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   40 +++++++++++-----------
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 0cac92f..b4cd47f 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -150,12 +150,8 @@ class PackageSelectionPage (HobPage):
             sort_model = self.package_model.tree_model(filter, initial=True)
             tab.set_model(sort_model)
             tab.connect("toggled", self.table_toggled_cb, name)
-            if name == "Included packages":
-                tab.connect("button-release-event", self.button_click_cb)
-                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if name == "All packages":
-                tab.connect("button-release-event", self.button_click_cb)
-                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            tab.connect("button-release-event", self.button_click_cb)
+            tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include, filter)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -290,12 +286,9 @@ class PackageSelectionPage (HobPage):
         if not self.package_model.path_included(path):
             self.package_model.include_item(item_path=path, binb="User Selected")
         else:
-            if pagename == "Included packages":
-                self.pre_fadeout_checkout_include(view_tree)
-                self.package_model.exclude_item(item_path=path)
-                self.render_fadeout(view_tree, cell)
-            else:
-                self.package_model.exclude_item(item_path=path)
+            self.pre_fadeout_checkout_include(view_tree)
+            self.package_model.exclude_item(item_path=path)
+            self.render_fadeout(view_tree, cell)
 
         self.refresh_selection()
         if not self.builder.customized:
@@ -305,6 +298,9 @@ class PackageSelectionPage (HobPage):
             self.builder.rcppkglist_populated()
 
         self.builder.window_sensitive(True)
+        view_model = view_tree.get_model()
+        vpath = self.package_model.convert_path_to_vpath(view_model, path)
+        view_tree.set_cursor(vpath)
 
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree, pagename):
         # Click to include a package
@@ -344,8 +340,8 @@ class PackageSelectionPage (HobPage):
 
         cell.fadeout(tree, 1000, to_render_cells)
 
-    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
-        tree.set_model(self.package_model.tree_model(self.pages[0]['filter']))
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree, filter):
+        tree.set_model(self.package_model.tree_model(filter))
         tree.expand_all()
 
     def set_packages_curr_tab(self, curr_page):
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 9c138b2..ffe310a 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -162,15 +162,8 @@ class RecipeSelectionPage (HobPage):
             sort_model = self.recipe_model.tree_model(filter, initial=True)
             tab.set_model(sort_model)
             tab.connect("toggled", self.table_toggled_cb, name)
-            if name == "Included recipes":
-                tab.connect("button-release-event", self.button_click_cb)
-                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if name == "Package Groups":
-                tab.connect("button-release-event", self.button_click_cb)
-                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            if name == "All recipes":
-                tab.connect("button-release-event", self.button_click_cb)
-                tab.connect("cell-fadeinout-stopped", self.button_click_cb)
+            tab.connect("button-release-event", self.button_click_cb)
+            tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include, filter)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -270,12 +263,9 @@ class RecipeSelectionPage (HobPage):
         if not self.recipe_model.path_included(path):
             self.recipe_model.include_item(item_path=path, binb="User Selected", image_contents=False)
         else:
-            if pagename == "Included recipes":
-                self.pre_fadeout_checkout_include(view_tree)
-                self.recipe_model.exclude_item(item_path=path)
-                self.render_fadeout(view_tree, cell)
-            else:
-                self.recipe_model.exclude_item(item_path=path)
+            self.pre_fadeout_checkout_include(view_tree, pagename)
+            self.recipe_model.exclude_item(item_path=path)
+            self.render_fadeout(view_tree, cell)
 
         self.refresh_selection()
         if not self.builder.customized:
@@ -285,6 +275,10 @@ class RecipeSelectionPage (HobPage):
 
         self.builder.window_sensitive(True)
 
+        view_model = view_tree.get_model()
+        vpath = self.recipe_model.convert_path_to_vpath(view_model, path)
+        view_tree.set_cursor(vpath)
+
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree, pagename):
         # Click to include a recipe
         self.builder.window_sensitive(False)
@@ -292,7 +286,7 @@ class RecipeSelectionPage (HobPage):
         path = self.recipe_model.convert_vpath_to_path(view_model, view_path)
         glib.idle_add(self.toggle_item_idle_cb, path, view_tree, cell, pagename)
 
-    def pre_fadeout_checkout_include(self, tree):
+    def pre_fadeout_checkout_include(self, tree, pagename):
         #resync the included items to a backup fade include column
         it = self.recipe_model.get_iter_first()
         while it:
@@ -301,8 +295,14 @@ class RecipeSelectionPage (HobPage):
             it = self.recipe_model.iter_next(it)
         # Check out a model which base on the column COL_FADE_INC,
         # it's save the prev state of column COL_INC before do exclude_item
-        filter = { RecipeListModel.COL_FADE_INC  : [True],
-                   RecipeListModel.COL_TYPE      : ['recipe', 'packagegroup'] }
+        filter = { RecipeListModel.COL_FADE_INC:[True] }
+        if pagename == "Included recipes":
+            filter[RecipeListModel.COL_TYPE] = ['recipe', 'packagegroup']
+        elif pagename == "All recipes":
+            filter[RecipeListModel.COL_TYPE] = ['recipe']
+        else:
+            filter[RecipeListModel.COL_TYPE] = ['packagegroup']
+
         new_model = self.recipe_model.tree_model(filter, excluded_items_ahead=True)
         tree.set_model(new_model)
 
@@ -322,8 +322,8 @@ class RecipeSelectionPage (HobPage):
 
         cell.fadeout(tree, 1000, to_render_cells)
 
-    def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
-        tree.set_model(self.recipe_model.tree_model(self.pages[0]['filter']))
+    def after_fadeout_checkin_include(self, table, ctrl, cell, tree, filter):
+        tree.set_model(self.recipe_model.tree_model(filter))
 
     def set_recipe_curr_tab(self, curr_page):
         self.ins.set_current_page(curr_page)
-- 
1.7.9.5


