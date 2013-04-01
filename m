Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UMcHa-0008Na-V0
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Apr 2013 12:48:12 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Apr 2013 03:31:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,385,1363158000"; d="scan'208";a="278976104"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 01 Apr 2013 03:31:00 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Apr 2013 13:36:25 +0300
Message-Id: <1364812585-25371-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: giving focus to the search field loses the table sorting
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
X-List-Received-Date: Mon, 01 Apr 2013 10:48:12 -0000

Giving focus to the search text field should not impact the table
sorting.

[YOCTO #4113]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |    4 ++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   45 +++++++++++++---------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   45 +++++++++++++---------
 4 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 67d40e0..0bd9734 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -91,7 +91,7 @@ class PackageListModel(gtk.ListStore):
         for key in filter.keys():
             if key == self.COL_NAME:
                 if filter[key] != 'Search packages by name':
-                    if filter[key] not in name:
+                    if name and filter[key] not in name:
                         return False
             else:
                 if model.get_value(it, key) not in filter[key]:
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 9b4261a..1d1ae1a 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -481,6 +481,8 @@ class HobNotebook(gtk.Notebook):
         self.pages = []
 
         self.search = None
+        self.search_focus = False
+        self.page_changed = False
 
         self.connect("switch-page", self.page_changed_cb)
 
@@ -494,6 +496,7 @@ class HobNotebook(gtk.Notebook):
                 lbl.set_active(False)
 
         if self.search:
+            self.page_changed = True
             self.reset_entry(self.search, page_num)
 
     def append_page(self, child, tab_label, tab_tooltip=None):
@@ -537,6 +540,7 @@ class HobNotebook(gtk.Notebook):
                 child.set_count(0)
 
     def set_search_entry_editable_cb(self, search, event):
+        self.search_focus = True
         search.set_editable(True)
         text = search.get_text()
         if text in self.search_names:
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 781d579..89f67c6 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -181,24 +181,33 @@ class PackageSelectionPage (HobPage):
 
     def search_entry_changed(self, entry):
         text = entry.get_text()
-        if text not in self.ins.search_names:
-            current_tab = self.ins.get_current_page()
-            filter = self.pages[current_tab]['filter']
-            filter[PackageListModel.COL_NAME] = text
-            self.tables[current_tab].set_model(self.package_model.tree_model(filter, search_data=text))
-            if self.package_model.filtered_nb == 0:
-                if not self.ins.get_nth_page(current_tab).top_bar:
-                    self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
-                self.ins.get_nth_page(current_tab).top_bar.show()
-                self.ins.get_nth_page(current_tab).scroll.hide()
-            else:
-                if self.ins.get_nth_page(current_tab).top_bar:
-                    self.ins.get_nth_page(current_tab).top_bar.hide()
-                self.ins.get_nth_page(current_tab).scroll.show()
-            if entry.get_text() == '':
-                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
-            else:
-                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+        if self.ins.search_focus:
+            self.ins.search_focus = False
+        elif self.ins.page_changed:
+            self.ins.page_change = False
+            self.filter_search(entry)
+        elif text not in self.ins.search_names:
+            self.filter_search(entry)
+
+    def filter_search(self, entry):
+        text = entry.get_text()
+        current_tab = self.ins.get_current_page()
+        filter = self.pages[current_tab]['filter']
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
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 47bb253..b29de2c 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -196,24 +196,33 @@ class RecipeSelectionPage (HobPage):
 
     def search_entry_changed(self, entry):
         text = entry.get_text()
-        if text not in self.ins.search_names:
-            current_tab = self.ins.get_current_page()
-            filter = self.pages[current_tab]['filter']
-            filter[RecipeListModel.COL_NAME] = text
-            self.tables[current_tab].set_model(self.recipe_model.tree_model(filter, search_data=text))
-            if self.recipe_model.filtered_nb == 0:
-                if not self.ins.get_nth_page(current_tab).top_bar:
-                    self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
-                self.ins.get_nth_page(current_tab).top_bar.show()
-                self.ins.get_nth_page(current_tab).scroll.hide()
-            else:
-                if self.ins.get_nth_page(current_tab).top_bar:
-                    self.ins.get_nth_page(current_tab).top_bar.hide()
-                self.ins.get_nth_page(current_tab).scroll.show()
-            if entry.get_text() == '':
-                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
-            else:
-                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+        if self.ins.search_focus:
+            self.ins.search_focus = False
+        elif self.ins.page_changed:
+            self.ins.page_change = False
+            self.filter_search(entry)
+        elif text not in self.ins.search_names:
+            self.filter_search(entry)
+
+    def filter_search(self, entry):
+        text = entry.get_text()
+        current_tab = self.ins.get_current_page()
+        filter = self.pages[current_tab]['filter']
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
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
-- 
1.7.9.5



