Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86F0-0006Bn-GT
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:58 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 15 Mar 2012 01:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129245772"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2012 01:32:11 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:59 +0800
Message-Id: <5ad7c54f4b8739b9ae097c68978093a53f950ed7.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 11/12] Hob: improve recipe/package selection performance
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:58 -0000

Originally we will send selection chagned notification in each
include_item and exclude_item, which is time cost since these are
recursive functions and we may select hundreds of recipes/packages.

The improvement is to move the notification from include_item and
exclude_item to the place where the two functions are called.
This could greatly improve the selection/deselection speed for recipe
and package lists.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hoblistmodel.py         |   10 +++-------
 lib/bb/ui/crumbs/packageselectionpage.py |    1 +
 lib/bb/ui/crumbs/recipeselectionpage.py  |    1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index edd61b5..caf31bc 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -216,8 +216,6 @@ class PackageListModel(gtk.TreeStore):
 
         self[item_path][self.COL_INC] = True
 
-        self.selection_change_notification()
-
         it = self.get_iter(item_path)
 
         # If user explicitly selects a recipe, all its providing packages are selected.
@@ -276,8 +274,6 @@ class PackageListModel(gtk.TreeStore):
 
         self[item_path][self.COL_INC] = False
 
-        self.selection_change_notification()
-
         item_name = self[item_path][self.COL_NAME]
         item_rdep = self[item_path][self.COL_RDEP]
         it = self.get_iter(item_path)
@@ -343,6 +339,7 @@ class PackageListModel(gtk.TreeStore):
             else:
                 left.append(pn)
 
+        self.selection_change_notification()
         return left
 
     def get_selected_packages(self):
@@ -604,7 +601,6 @@ class RecipeListModel(gtk.ListStore):
         item_deps = self[item_path][self.COL_DEPS]
 
         self[item_path][self.COL_INC] = True
-        self.selection_change_notification()
 
         item_bin = self[item_path][self.COL_BINB].split(', ')
         if binb and not binb in item_bin:
@@ -642,8 +638,6 @@ class RecipeListModel(gtk.ListStore):
 
         self[item_path][self.COL_INC] = False
 
-        self.selection_change_notification()
-
         item_name = self[item_path][self.COL_NAME]
         item_deps = self[item_path][self.COL_DEPS]
         if item_deps:
@@ -703,6 +697,7 @@ class RecipeListModel(gtk.ListStore):
                 path = self.pn_path[pn]
                 self.include_item(item_path=path,
                                   binb="User Selected")
+        self.selection_change_notification()
 
     def get_selected_image(self):
         it = self.get_iter_first()
@@ -724,3 +719,4 @@ class RecipeListModel(gtk.ListStore):
         self.include_item(item_path=path,
                           binb="User Selected",
                           image_contents=True)
+        self.selection_change_notification()
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 0427fe2..4fb199e 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -206,6 +206,7 @@ class PackageSelectionPage (HobPage):
         else:
             self.package_model.exclude_item(item_path=path)
 
+        self.refresh_selection()
         self.builder.window_sensitive(True)
 
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 234734c..50d4363 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -202,6 +202,7 @@ class RecipeSelectionPage (HobPage):
         else:
             self.recipe_model.exclude_item(item_path=path)
 
+        self.refresh_selection()
         self.builder.window_sensitive(True)
 
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
-- 
1.7.4.1



