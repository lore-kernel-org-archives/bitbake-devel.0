Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UZdFR-0000zF-PI
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 10:27:46 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 07 May 2013 01:07:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,627,1363158000"; d="scan'208";a="330103983"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 07 May 2013 01:09:43 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 11:07:54 +0300
Message-Id: <1367914076-4863-3-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
References: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 2/4] hob: "Brought in by" sorting should take into account the (+#) information
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
X-List-Received-Date: Tue, 07 May 2013 08:27:57 -0000
X-List-Received-Date: Tue, 07 May 2013 08:27:57 -0000

[YOCTO #4332]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   46 ++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 42fd6ce..887be79 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -126,7 +126,7 @@ class PackageListModel(gtk.ListStore):
 
         sort.set_sort_func(PackageListModel.COL_INC, self.sort_column, PackageListModel.COL_INC)
         sort.set_sort_func(PackageListModel.COL_SIZE, self.sort_column, PackageListModel.COL_SIZE)
-        sort.set_sort_func(PackageListModel.COL_BINB, self.sort_column, PackageListModel.COL_BINB)
+        sort.set_sort_func(PackageListModel.COL_BINB, self.sort_binb_column)
         sort.set_sort_func(PackageListModel.COL_RCP, self.sort_column, PackageListModel.COL_RCP)
         return sort
 
@@ -148,6 +148,27 @@ class PackageListModel(gtk.ListStore):
             name2 = model.get_value(row2, PackageListModel.COL_NAME)
             return cmp(name1,name2)
 
+    def sort_binb_column(self, model, row1, row2):
+        value1 = model.get_value(row1, PackageListModel.COL_BINB)
+        value2 = model.get_value(row2, PackageListModel.COL_BINB)
+        value1_list = value1.split(', ')
+        value2_list = value2.split(', ')
+
+        value1 = value1_list[0]
+        value2 = value2_list[0]
+
+        cmp_res = cmp(value1, value2)
+        if cmp_res==0:
+            cmp_size = cmp(len(value1_list), len(value2_list))
+            if cmp_size==0:
+                name1 = model.get_value(row1, PackageListModel.COL_NAME)
+                name2 = model.get_value(row2, PackageListModel.COL_NAME)
+                return cmp(name1,name2)
+            else:
+                return cmp_size
+        else:
+            return cmp_res
+
     def exclude_item_sort_func(self, model, iter1, iter2, user_data=None):
         if user_data:
             val1 = model.get_value(iter1, PackageListModel.COL_NAME)
@@ -582,7 +603,7 @@ class RecipeListModel(gtk.ListStore):
 
         sort.set_sort_func(RecipeListModel.COL_INC, self.sort_column, RecipeListModel.COL_INC)
         sort.set_sort_func(RecipeListModel.COL_GROUP, self.sort_column, RecipeListModel.COL_GROUP)
-        sort.set_sort_func(RecipeListModel.COL_BINB, self.sort_column, RecipeListModel.COL_BINB)
+        sort.set_sort_func(RecipeListModel.COL_BINB, self.sort_binb_column)
         sort.set_sort_func(RecipeListModel.COL_LIC, self.sort_column, RecipeListModel.COL_LIC)
         return sort
 
@@ -600,6 +621,27 @@ class RecipeListModel(gtk.ListStore):
             name2 = model.get_value(row2, RecipeListModel.COL_NAME)
             return cmp(name1,name2)
 
+    def sort_binb_column(self, model, row1, row2):
+        value1 = model.get_value(row1, RecipeListModel.COL_BINB)
+        value2 = model.get_value(row2, RecipeListModel.COL_BINB)
+        value1_list = value1.split(', ')
+        value2_list = value2.split(', ')
+
+        value1 = value1_list[0]
+        value2 = value2_list[0]
+
+        cmp_res = cmp(value1, value2)
+        if cmp_res==0:
+            cmp_size = cmp(len(value1_list), len(value2_list))
+            if cmp_size==0:
+                name1 = model.get_value(row1, RecipeListModel.COL_NAME)
+                name2 = model.get_value(row2, RecipeListModel.COL_NAME)
+                return cmp(name1,name2)
+            else:
+                return cmp_size
+        else:
+            return cmp_res
+
     def convert_vpath_to_path(self, view_model, view_path):
         filtered_model_path = view_model.convert_path_to_child_path(view_path)
         filtered_model = view_model.get_model()
-- 
1.7.9.5



