Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UKsKQ-00040C-PY
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 16:31:56 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 27 Mar 2013 08:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,920,1355126400"; d="scan'208";a="219466818"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 08:14:50 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Mar 2013 17:20:07 +0200
Message-Id: <1364397607-22670-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Search strings and results should be persistent
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
X-List-Received-Date: Wed, 27 Mar 2013 15:31:58 -0000

Now, the search results stay until I clear the search field,
so that I can manipulate the search results.

[YOCTO #4112 & #4117]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |    9 ++++--
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   35 +++++++++++-----------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   35 +++++++++++-----------
 3 files changed, 43 insertions(+), 36 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 17d9cee..51ae782 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -537,14 +537,18 @@ class HobNotebook(gtk.Notebook):
 
     def set_search_entry_editable_cb(self, search, event):
         search.set_editable(True)
-        search.set_text("")
+        text = search.get_text()
+        if text in self.search_names:
+            search.set_text("")
         style = self.search.get_style()
         style.text[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(HobColors.BLACK, False, False)
         search.set_style(style)
 
     def set_search_entry_reset_cb(self, search, event):
         page_num = self.get_current_page()
-        self.reset_entry(search, page_num)
+        text = search.get_text()
+        if not text:
+            self.reset_entry(search, page_num)
 
     def reset_entry(self, entry, page_num):
         style = entry.get_style()
@@ -559,6 +563,7 @@ class HobNotebook(gtk.Notebook):
         if search.get_editable() == True:
             search.set_text("")
         search.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+        search.grab_focus()
 
     def set_page(self, title):
         for child in self.pages:
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index ce2deab..0bb4cb1 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -180,24 +180,25 @@ class PackageSelectionPage (HobPage):
         self.button_box.pack_end(self.back_button, expand=False, fill=False)
 
     def search_entry_changed(self, entry):
-        current_tab = self.ins.get_current_page()
-        filter = self.pages[current_tab]['filter']
         text = entry.get_text()
-        filter[PackageListModel.COL_NAME] = text
-        self.tables[current_tab].set_model(self.package_model.tree_model(filter, search_data=text))
-        if self.package_model.filtered_nb == 0:
-            if not self.ins.get_nth_page(current_tab).top_bar:
-                self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
-            self.ins.get_nth_page(current_tab).top_bar.show()
-            self.ins.get_nth_page(current_tab).scroll.hide()
-        else:
-            if self.ins.get_nth_page(current_tab).top_bar:
-                self.ins.get_nth_page(current_tab).top_bar.hide()
-            self.ins.get_nth_page(current_tab).scroll.show()
-        if entry.get_text() == '':
-            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
-        else:
-            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+        if text not in self.ins.search_names:
+            current_tab = self.ins.get_current_page()
+            filter = self.pages[current_tab]['filter']
+            filter[PackageListModel.COL_NAME] = text
+            self.tables[current_tab].set_model(self.package_model.tree_model(filter, search_data=text))
+            if self.package_model.filtered_nb == 0:
+                if not self.ins.get_nth_page(current_tab).top_bar:
+                    self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+                self.ins.get_nth_page(current_tab).top_bar.show()
+                self.ins.get_nth_page(current_tab).scroll.hide()
+            else:
+                if self.ins.get_nth_page(current_tab).top_bar:
+                    self.ins.get_nth_page(current_tab).top_bar.hide()
+                self.ins.get_nth_page(current_tab).scroll.show()
+            if entry.get_text() == '':
+                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+            else:
+                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index aa0cd60..47bb253 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -195,24 +195,25 @@ class RecipeSelectionPage (HobPage):
         button_box.pack_end(self.back_button, expand=False, fill=False)
 
     def search_entry_changed(self, entry):
-        current_tab = self.ins.get_current_page()
-        filter = self.pages[current_tab]['filter']
         text = entry.get_text()
-        filter[RecipeListModel.COL_NAME] = text
-        self.tables[current_tab].set_model(self.recipe_model.tree_model(filter, search_data=text))
-        if self.recipe_model.filtered_nb == 0:
-            if not self.ins.get_nth_page(current_tab).top_bar:
-                self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
-            self.ins.get_nth_page(current_tab).top_bar.show()
-            self.ins.get_nth_page(current_tab).scroll.hide()
-        else:
-            if self.ins.get_nth_page(current_tab).top_bar:
-                self.ins.get_nth_page(current_tab).top_bar.hide()
-            self.ins.get_nth_page(current_tab).scroll.show()
-        if entry.get_text() == '':
-            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
-        else:
-            entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
+        if text not in self.ins.search_names:
+            current_tab = self.ins.get_current_page()
+            filter = self.pages[current_tab]['filter']
+            filter[RecipeListModel.COL_NAME] = text
+            self.tables[current_tab].set_model(self.recipe_model.tree_model(filter, search_data=text))
+            if self.recipe_model.filtered_nb == 0:
+                if not self.ins.get_nth_page(current_tab).top_bar:
+                    self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+                self.ins.get_nth_page(current_tab).top_bar.show()
+                self.ins.get_nth_page(current_tab).scroll.hide()
+            else:
+                if self.ins.get_nth_page(current_tab).top_bar:
+                    self.ins.get_nth_page(current_tab).top_bar.hide()
+                self.ins.get_nth_page(current_tab).scroll.show()
+            if entry.get_text() == '':
+                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, False)
+            else:
+                entry.set_icon_sensitive(gtk.ENTRY_ICON_SECONDARY, True)
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
-- 
1.7.9.5



