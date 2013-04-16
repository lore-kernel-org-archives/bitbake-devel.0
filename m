Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1US50f-0006lu-IX
	for bitbake-devel@lists.openembedded.org;
	Tue, 16 Apr 2013 14:29:19 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 16 Apr 2013 05:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,485,1363158000"; d="scan'208";a="323047753"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2013 05:11:45 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 16 Apr 2013 15:12:30 +0300
Message-Id: <1366114350-16405-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: sort alphabetically results in groups of recipes/packages
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
X-List-Received-Date: Tue, 16 Apr 2013 12:29:20 -0000

When you search a string, there are 2 groups: recipes/packages starting
with that string, and the rest. These 2 groups are now sorted.

[YOCTO #4111]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |   38 ++++++++++--------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 547c1ca..42fd6ce 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -152,12 +152,7 @@ class PackageListModel(gtk.ListStore):
         if user_data:
             val1 = model.get_value(iter1, PackageListModel.COL_NAME)
             val2 = model.get_value(iter2, PackageListModel.COL_NAME)
-            if val1.startswith(user_data) and not val2.startswith(user_data):
-                return -1
-            elif not val1.startswith(user_data) and val2.startswith(user_data):
-                return 1
-            else:
-                return 0
+            return self.cmp_vals(val1, val2, user_data)
         else:
             val1 = model.get_value(iter1, PackageListModel.COL_FADE_INC)
             val2 = model.get_value(iter2, PackageListModel.COL_INC)
@@ -167,12 +162,7 @@ class PackageListModel(gtk.ListStore):
         if user_data:
             val1 = model.get_value(iter1, PackageListModel.COL_NAME)
             val2 = model.get_value(iter2, PackageListModel.COL_NAME)
-            if val1.startswith(user_data) and not val2.startswith(user_data):
-                return -1
-            elif not val1.startswith(user_data) and val2.startswith(user_data):
-                return 1
-            else:
-                return 0
+            return self.cmp_vals(val1, val2, user_data)
         else:
             val1 = model.get_value(iter1, PackageListModel.COL_INC)
             val2 = model.get_value(iter2, PackageListModel.COL_INC)
@@ -181,12 +171,15 @@ class PackageListModel(gtk.ListStore):
     def sort_func(self, model, iter1, iter2, user_data):
         val1 = model.get_value(iter1, PackageListModel.COL_NAME)
         val2 = model.get_value(iter2, PackageListModel.COL_NAME)
+        return self.cmp_vals(val1, val2, user_data)
+
+    def cmp_vals(self, val1, val2, user_data):
         if val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
         else:
-            return 0
+            return cmp(val1, val2)
 
     def convert_vpath_to_path(self, view_model, view_path):
         # view_model is the model sorted
@@ -533,12 +526,7 @@ class RecipeListModel(gtk.ListStore):
         if user_data:
             val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
             val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
-            if val1.startswith(user_data) and not val2.startswith(user_data):
-                return -1
-            elif not val1.startswith(user_data) and val2.startswith(user_data):
-                return 1
-            else:
-                return 0
+            return self.cmp_vals(val1, val2, user_data)
         else:
             val1 = model.get_value(iter1, RecipeListModel.COL_FADE_INC)
             val2 = model.get_value(iter2, RecipeListModel.COL_INC)
@@ -548,12 +536,7 @@ class RecipeListModel(gtk.ListStore):
         if user_data:
             val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
             val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
-            if val1.startswith(user_data) and not val2.startswith(user_data):
-                return -1
-            elif not val1.startswith(user_data) and val2.startswith(user_data):
-                return 1
-            else:
-                return 0
+            return self.cmp_vals(val1, val2, user_data)
         else:
             val1 = model.get_value(iter1, RecipeListModel.COL_INC)
             val2 = model.get_value(iter2, RecipeListModel.COL_INC)
@@ -562,12 +545,15 @@ class RecipeListModel(gtk.ListStore):
     def sort_func(self, model, iter1, iter2, user_data):
         val1 = model.get_value(iter1, RecipeListModel.COL_NAME)
         val2 = model.get_value(iter2, RecipeListModel.COL_NAME)
+        return self.cmp_vals(val1, val2, user_data)
+
+    def cmp_vals(self, val1, val2, user_data):
         if val1.startswith(user_data) and not val2.startswith(user_data):
             return -1
         elif not val1.startswith(user_data) and val2.startswith(user_data):
             return 1
         else:
-            return 0
+            return cmp(val1, val2)
 
     """
     Create, if required, and return a filtered gtk.TreeModelSort
-- 
1.7.9.5



