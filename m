Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1U0spV-0000pN-P9
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 13:01:25 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 31 Jan 2013 03:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,575,1355126400"; d="scan'208";a="280796556"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2013 03:45:36 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 13:50:16 +0200
Message-Id: <1359633016-6883-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: eliminate the "by recipe" grouping in the packages table
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
X-List-Received-Date: Thu, 31 Jan 2013 12:01:31 -0000

We have agreed to change how we show the packages. Now they are not grouped by
recipe. Until now, it was implemented using  TreeStore and I've changed it to
extend a ListStore. I have modified all the function in according to this.

[YOCTO #2180]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |  272 ++++++++--------------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   22 +-
 2 files changed, 112 insertions(+), 182 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 85c4f51..06c90d3 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -27,14 +27,15 @@ from bb.ui.crumbs.hobpages import HobPage
 #
 # PackageListModel
 #
-class PackageListModel(gtk.TreeStore):
+class PackageListModel(gtk.ListStore):
     """
-    This class defines an gtk.TreeStore subclass which will convert the output
-    of the bb.event.TargetsTreeGenerated event into a gtk.TreeStore whilst also
+    This class defines an gtk.ListStore subclass which will convert the output
+    of the bb.event.TargetsTreeGenerated event into a gtk.ListStore whilst also
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC, COL_FADE_INC, COL_FONT) = range(13)
+
+    (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_RCP, COL_BINB, COL_INC, COL_FADE_INC, COL_FONT) = range(14)
 
     __gsignals__ = {
         "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -45,15 +46,9 @@ class PackageListModel(gtk.TreeStore):
     __toolchain_required_packages__ = ["packagegroup-core-standalone-sdk-target", "packagegroup-core-standalone-sdk-target-dbg"]
 
     def __init__(self):
-
-        self.contents = None
-        self.images = None
-        self.pkgs_size = 0
-        self.pn_path = {}
-        self.pkg_path = {}
         self.rprov_pkg = {}
-        
-        gtk.TreeStore.__init__ (self,
+        gtk.ListStore.__init__ (self,
+                                gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
@@ -68,21 +63,20 @@ class PackageListModel(gtk.TreeStore):
                                 gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_STRING)
 
-
     """
     Find the model path for the item_name
     Returns the path in the model or None
     """
     def find_path_for_item(self, item_name):
         pkg = item_name
-        if item_name not in self.pkg_path.keys():
+        if item_name not in self.pn_path.keys():
             if item_name not in self.rprov_pkg.keys():
                 return None
             pkg = self.rprov_pkg[item_name]
-            if pkg not in self.pkg_path.keys():
+            if pkg not in self.pn_path.keys():
                 return None
 
-        return self.pkg_path[pkg]
+        return self.pn_path[pkg]
 
     def find_item_for_path(self, item_path):
         return self[item_path][self.COL_NAME]
@@ -106,10 +100,20 @@ class PackageListModel(gtk.TreeStore):
         model.set_visible_func(self.tree_model_filter, filter)
 
         sort = gtk.TreeModelSort(model)
-        sort.set_sort_column_id(PackageListModel.COL_NAME, gtk.SORT_ASCENDING)
+        sort.set_sort_column_id(RecipeListModel.COL_NAME, gtk.SORT_ASCENDING)
         sort.set_default_sort_func(None)
         return sort
 
+    def exclude_item_sort_func(self, model, iter1, iter2):
+        val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
+        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+        return ((val1 == True) and (val2 == False))
+
+    def include_item_sort_func(self, model, iter1, iter2):
+        val1 = model.get_value(iter1, RecipeListModel.COL_INC)
+        val2 = model.get_value(iter2, RecipeListModel.COL_INC)
+        return ((val1 == False) and (val2 == True))
+
     def convert_vpath_to_path(self, view_model, view_path):
         # view_model is the model sorted
         # get the path of the model filtered
@@ -121,16 +125,13 @@ class PackageListModel(gtk.TreeStore):
         return path
 
     def convert_path_to_vpath(self, view_model, path):
-        name = self.find_item_for_path(path)
         it = view_model.get_iter_first()
         while it:
-            child_it = view_model.iter_children(it)
-            while child_it:
-                view_name = view_model.get_value(child_it, self.COL_NAME)
-                if view_name == name:
-                    view_path = view_model.get_path(child_it)
-                    return view_path
-                child_it = view_model.iter_next(child_it)
+            name = self.find_item_for_path(path)
+            view_name = view_model.get_value(it, RecipeListModel.COL_NAME)
+            if view_name == name:
+                view_path = view_model.get_path(it)
+                return view_path
             it = view_model.iter_next(it)
         return None
 
@@ -139,11 +140,8 @@ class PackageListModel(gtk.TreeStore):
     bb.event.PackageInfo event and populates the package list.
     """
     def populate(self, pkginfolist):
+        # First clear the model, in case repopulating
         self.clear()
-        self.pkgs_size = 0
-        self.pn_path = {}
-        self.pkg_path = {}
-        self.rprov_pkg = {}
 
         def getpkgvalue(pkgdict, key, pkgname, defaultval = None):
             value = pkgdict.get('%s_%s' % (key, pkgname), None)
@@ -155,15 +153,6 @@ class PackageListModel(gtk.TreeStore):
             pn = pkginfo['PN']
             pv = pkginfo['PV']
             pr = pkginfo['PR']
-            if pn in self.pn_path.keys():
-                pniter = self.get_iter(self.pn_path[pn])
-            else:
-                pniter = self.append(None)
-                self.set(pniter, self.COL_NAME, pn + '-' + pv + '-' + pr,
-                                 self.COL_INC, False)
-                self.pn_path[pn] = self.get_path(pniter)
-
-            # PKG is always present
             pkg = pkginfo['PKG']
             pkgv = getpkgvalue(pkginfo, 'PKGV', pkg)
             pkgr = getpkgvalue(pkginfo, 'PKGR', pkg)
@@ -180,6 +169,8 @@ class PackageListModel(gtk.TreeStore):
             for i in rprov.split():
                 self.rprov_pkg[i] = pkg
 
+            recipe = pn + '-' + pv + '-' + pr
+
             allow_empty = getpkgvalue(pkginfo, 'ALLOW_EMPTY', pkg, "")
 
             if pkgsize == "0" and not allow_empty:
@@ -188,20 +179,21 @@ class PackageListModel(gtk.TreeStore):
             # pkgsize is in KB
             size = HobPage._size_to_string(HobPage._string_to_size(pkgsize + ' KB'))
 
-            it = self.append(pniter)
-            self.pkg_path[pkg] = self.get_path(it)
-            self.set(it, self.COL_NAME, pkg, self.COL_VER, pkgv,
+            self.set(self.append(), self.COL_NAME, pkg, self.COL_VER, pkgv,
                      self.COL_REV, pkgr, self.COL_RNM, pkg_rename,
                      self.COL_SEC, section, self.COL_SUM, summary,
                      self.COL_RDEP, rdep + ' ' + rrec,
                      self.COL_RPROV, rprov, self.COL_SIZE, size,
-                     self.COL_BINB, "", self.COL_INC, False, self.COL_FONT, '10')
+                     self.COL_RCP, recipe, self.COL_BINB, "",
+                     self.COL_INC, False, self.COL_FONT, '10')
 
-    """
-    Check whether the item at item_path is included or not
-    """
-    def path_included(self, item_path):
-        return self[item_path][self.COL_INC]
+        self.pn_path = {}
+        it = self.get_iter_first()
+        while it:
+            pn = self.get_value(it, self.COL_NAME)
+            path = self.get_path(it)
+            self.pn_path[pn] = path
+            it = self.iter_next(it)
 
     """
     Update the model, send out the notification.
@@ -210,48 +202,32 @@ class PackageListModel(gtk.TreeStore):
         self.emit("package-selection-changed")
 
     """
-    Mark a certain package as selected.
-    All its dependencies are marked as selected.
-    The recipe provides the package is marked as selected.
-    If user explicitly selects a recipe, all its providing packages are selected
+    Check whether the item at item_path is included or not
+    """
+    def path_included(self, item_path):
+        return self[item_path][self.COL_INC]
+
+    """
+    Add this item, and any of its dependencies, to the image contents
     """
     def include_item(self, item_path, binb=""):
         if self.path_included(item_path):
             return
 
         item_name = self[item_path][self.COL_NAME]
-        item_rdep = self[item_path][self.COL_RDEP]
+        item_deps = self[item_path][self.COL_RDEP]
 
         self[item_path][self.COL_INC] = True
 
-        it = self.get_iter(item_path)
-
-        # If user explicitly selects a recipe, all its providing packages are selected.
-        if not self[item_path][self.COL_VER] and binb == "User Selected":
-            child_it = self.iter_children(it)
-            while child_it:
-                child_path = self.get_path(child_it)
-                child_included = self.path_included(child_path)
-                if not child_included:
-                    self.include_item(child_path, binb="User Selected")
-                child_it = self.iter_next(child_it)
-            return
-
-        # The recipe provides the package is also marked as selected
-        parent_it = self.iter_parent(it)
-        if parent_it:
-            parent_path = self.get_path(parent_it)
-            self[parent_path][self.COL_INC] = True
-
         item_bin = self[item_path][self.COL_BINB].split(', ')
         if binb and not binb in item_bin:
             item_bin.append(binb)
             self[item_path][self.COL_BINB] = ', '.join(item_bin).lstrip(', ')
 
-        if item_rdep:
+        if item_deps:
             # Ensure all of the items deps are included and, where appropriate,
             # add this item to their COL_BINB
-            for dep in item_rdep.split(" "):
+            for dep in item_deps.split(" "):
                 if dep.startswith('('):
                     continue
                 # If the contents model doesn't already contain dep, add it
@@ -270,12 +246,6 @@ class PackageListModel(gtk.TreeStore):
                 elif not dep_included:
                     self.include_item(dep_path, binb=item_name)
 
-    """
-    Mark a certain package as de-selected.
-    All other packages that depends on this package are marked as de-selected.
-    If none of the packages provided by the recipe, the recipe should be marked as de-selected.
-    If user explicitly de-select a recipe, all its providing packages are de-selected.
-    """
     def exclude_item(self, item_path):
         if not self.path_included(item_path):
             return
@@ -283,37 +253,9 @@ class PackageListModel(gtk.TreeStore):
         self[item_path][self.COL_INC] = False
 
         item_name = self[item_path][self.COL_NAME]
-        item_rdep = self[item_path][self.COL_RDEP]
-        it = self.get_iter(item_path)
-
-        # If user explicitly de-select a recipe, all its providing packages are de-selected.
-        if not self[item_path][self.COL_VER]:
-            child_it = self.iter_children(it)
-            while child_it:
-                child_path = self.get_path(child_it)
-                child_included = self[child_path][self.COL_INC]
-                if child_included:
-                    self.exclude_item(child_path)
-                child_it = self.iter_next(child_it)
-            return
-
-        # If none of the packages provided by the recipe, the recipe should be marked as de-selected.
-        parent_it = self.iter_parent(it)
-        peer_iter = self.iter_children(parent_it)
-        enabled = 0
-        while peer_iter:
-            peer_path = self.get_path(peer_iter)
-            if self[peer_path][self.COL_INC]:
-                enabled = 1
-                break
-            peer_iter = self.iter_next(peer_iter)
-        if not enabled:
-            parent_path = self.get_path(parent_it)
-            self[parent_path][self.COL_INC] = False
-
-        # All packages that depends on this package are de-selected.
-        if item_rdep:
-            for dep in item_rdep.split(" "):
+        item_deps = self[item_path][self.COL_RDEP]
+        if item_deps:
+            for dep in item_deps.split(" "):
                 if dep.startswith('('):
                     continue
                 dep_path = self.find_path_for_item(dep)
@@ -333,51 +275,40 @@ class PackageListModel(gtk.TreeStore):
                 self.exclude_item(binb_path)
 
     """
-    Package model may be incomplete, therefore when calling the
-    set_selected_packages(), some packages will not be set included.
-    Return the un-set packages list.
+    Empty self.contents by setting the include of each entry to None
     """
-    def set_selected_packages(self, packagelist, user_selected=False):
-        left = []
-        binb = 'User Selected' if user_selected else ''
-        for pn in packagelist:
-            if pn in self.pkg_path.keys():
-                path = self.pkg_path[pn]
-                self.include_item(item_path=path, binb=binb)
-            else:
-                left.append(pn)
+    def reset(self):
+        it = self.get_iter_first()
+        while it:
+            self.set(it,
+                     self.COL_INC, False,
+                     self.COL_BINB, "")
+            it = self.iter_next(it)
 
         self.selection_change_notification()
-        return left
 
-    def get_user_selected_packages(self):
+    def get_selected_packages(self):
         packagelist = []
 
         it = self.get_iter_first()
         while it:
-            child_it = self.iter_children(it)
-            while child_it:
-                if self.get_value(child_it, self.COL_INC):
-                    binb = self.get_value(child_it, self.COL_BINB)
-                    if binb == "User Selected":
-                        name = self.get_value(child_it, self.COL_NAME)
-                        packagelist.append(name)
-                child_it = self.iter_next(child_it)
+            if self.get_value(it, self.COL_INC):
+                name = self.get_value(it, self.COL_NAME)
+                packagelist.append(name)
             it = self.iter_next(it)
 
         return packagelist
 
-    def get_selected_packages(self):
+    def get_user_selected_packages(self):
         packagelist = []
 
         it = self.get_iter_first()
         while it:
-            child_it = self.iter_children(it)
-            while child_it:
-                if self.get_value(child_it, self.COL_INC):
-                    name = self.get_value(child_it, self.COL_NAME)
+            if self.get_value(it, self.COL_INC):
+                binb = self.get_value(it, self.COL_BINB)
+                if binb == "User Selected":
+                    name = self.get_value(it, self.COL_NAME)
                     packagelist.append(name)
-                child_it = self.iter_next(child_it)
             it = self.iter_next(it)
 
         return packagelist
@@ -388,16 +319,31 @@ class PackageListModel(gtk.TreeStore):
         it = self.get_iter_first()
         while it:
             if self.get_value(it, self.COL_INC):
-                child_it = self.iter_children(it)
-                while child_it:
-                    name = self.get_value(child_it, self.COL_NAME)
-                    inc = self.get_value(child_it, self.COL_INC)
-                    if inc or name.endswith("-dev") or name.endswith("-dbg"):
-                        packagelist.append(name)
-                    child_it = self.iter_next(child_it)
+                name = self.get_value(it, self.COL_NAME)
+                if name.endswith("-dev") or name.endswith("-dbg"):
+                    packagelist.append(name)
             it = self.iter_next(it)
 
         return list(set(packagelist + self.__toolchain_required_packages__));
+
+    """
+    Package model may be incomplete, therefore when calling the
+    set_selected_packages(), some packages will not be set included.
+    Return the un-set packages list.
+    """
+    def set_selected_packages(self, packagelist, user_selected=False):
+        left = []
+        binb = 'User Selected' if user_selected else ''
+        for pn in packagelist:
+            if pn in self.pn_path.keys():
+                path = self.pn_path[pn]
+                self.include_item(item_path=path, binb=binb)
+            else:
+                left.append(pn)
+
+        self.selection_change_notification()
+        return left
+
     """
     Return the selected package size, unit is B.
     """
@@ -405,38 +351,17 @@ class PackageListModel(gtk.TreeStore):
         packages_size = 0
         it = self.get_iter_first()
         while it:
-            child_it = self.iter_children(it)
-            while child_it:
-                if self.get_value(child_it, self.COL_INC):
-                    str_size = self.get_value(child_it, self.COL_SIZE)
-                    if not str_size:
-                        continue
+            if self.get_value(it, self.COL_INC):
+                str_size = self.get_value(it, self.COL_SIZE)
+                if not str_size:
+                    continue
 
-                    packages_size += HobPage._string_to_size(str_size)
+                packages_size += HobPage._string_to_size(str_size)
 
-                child_it = self.iter_next(child_it)
             it = self.iter_next(it)
         return packages_size
 
     """
-    Empty self.contents by setting the include of each entry to None
-    """
-    def reset(self):
-        self.pkgs_size = 0
-        it = self.get_iter_first()
-        while it:
-            self.set(it, self.COL_INC, False)
-            child_it = self.iter_children(it)
-            while child_it:
-                self.set(child_it,
-                         self.COL_INC, False,
-                         self.COL_BINB, "")
-                child_it = self.iter_next(child_it)
-            it = self.iter_next(it)
-
-        self.selection_change_notification()
-
-    """
     Resync the state of included items to a backup column before performing the fadeout visible effect
     """
     def resync_fadeout_column(self, model_first_iter=None):
@@ -444,9 +369,6 @@ class PackageListModel(gtk.TreeStore):
         while it:
             active = self.get_value(it, self.COL_INC)
             self.set(it, self.COL_FADE_INC, active)
-            if self.iter_has_child(it):
-                self.resync_fadeout_column(self.iter_children(it))
-
             it = self.iter_next(it)
 
 #
@@ -533,7 +455,7 @@ class RecipeListModel(gtk.ListStore):
 
     """
     Create, if required, and return a filtered gtk.TreeModelSort
-    containing only the items which are items specified by filter
+    containing only the items specified by filter
     """
     def tree_model(self, filter, excluded_items_ahead=False, included_items_ahead=True):
         model = self.filter_new()
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index b879cc5..4544543 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -52,6 +52,13 @@ class PackageSelectionPage (HobPage):
                        'col_max'  : 300,
                        'expand'   : 'True'
                       }, {
+                       'col_name' : 'Recipe',
+                       'col_id'   : PackageListModel.COL_RCP,
+                       'col_style': 'text',
+                       'col_min'  : 100,
+                       'col_max'  : 250,
+                       'expand'   : 'True'
+                      }, {
                        'col_name' : 'Brought in by (+others)',
                        'col_id'   : PackageListModel.COL_BINB,
                        'col_style': 'binb',
@@ -84,6 +91,13 @@ class PackageSelectionPage (HobPage):
                        'col_max'  : 500,
                        'expand'   : 'True'
                       }, {
+                       'col_name' : 'Recipe',
+                       'col_id'   : PackageListModel.COL_RCP,
+                       'col_style': 'text',
+                       'col_min'  : 100,
+                       'col_max'  : 250,
+                       'expand'   : 'True'
+                      }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
                        'col_style': 'check toggle',
@@ -99,7 +113,7 @@ class PackageSelectionPage (HobPage):
     def __init__(self, builder):
         super(PackageSelectionPage, self).__init__(builder, "Edit packages")
 
-        # set invisiable members
+        # set invisible members
         self.recipe_model = self.builder.recipe_model
         self.package_model = self.builder.package_model
 
@@ -196,13 +210,7 @@ class PackageSelectionPage (HobPage):
         else:
             self.builder.show_configuration()
 
-    def _expand_all(self):
-        for tab in self.tables:
-            tab.table_tree.expand_all()
-
     def refresh_selection(self):
-        self._expand_all()
-
         self.builder.configuration.selected_packages = self.package_model.get_selected_packages()
         self.builder.configuration.user_selected_packages = self.package_model.get_user_selected_packages()
         selected_packages_num = len(self.builder.configuration.selected_packages)
-- 
1.7.9.5



