Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UZdFT-0000z9-6n
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 10:27:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 07 May 2013 01:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,627,1363158000"; d="scan'208";a="330104002"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 07 May 2013 01:09:45 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 11:07:55 +0300
Message-Id: <1367914076-4863-4-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
References: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 3/4] hob: clicking on "cancel" should reset table sorting to default
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

Changed the "cancel" callback function for both recipes and packages
list page.

[YOCTO #4333]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    9 +++++++++
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 66cb7ff..a4d86bd 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -199,6 +199,7 @@ class PackageSelectionPage (HobPage):
         if self.package_model.filtered_nb == 0:
             if not self.ins.get_nth_page(current_tab).top_bar:
                 self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+                self.ins.get_nth_page(current_tab).top_bar.set_no_show_all(True)
             self.ins.get_nth_page(current_tab).top_bar.show()
             self.ins.get_nth_page(current_tab).scroll.hide()
         else:
@@ -246,6 +247,13 @@ class PackageSelectionPage (HobPage):
         self.builder.parsing_warnings = []
         self.builder.build_image()
 
+    def refresh_tables(self):
+        self.ins.reset_entry(self.ins.search, 0)
+        for tab in self.tables:
+            index = self.tables.index(tab)
+            filter = self.pages[index]['filter']
+            tab.set_model(self.package_model.tree_model(filter, initial=True))
+
     def back_button_clicked_cb(self, button):
         if self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
             self.builder.restore_initial_selected_packages()
@@ -253,6 +261,7 @@ class PackageSelectionPage (HobPage):
             self.builder.show_image_details()
         else:
             self.builder.show_configuration()
+        self.refresh_tables()
 
     def refresh_selection(self):
         self.builder.configuration.selected_packages = self.package_model.get_selected_packages()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 8573b81..9c138b2 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -214,6 +214,7 @@ class RecipeSelectionPage (HobPage):
         if self.recipe_model.filtered_nb == 0:
             if not self.ins.get_nth_page(current_tab).top_bar:
                 self.ins.get_nth_page(current_tab).add_no_result_bar(entry)
+                self.ins.get_nth_page(current_tab).top_bar.set_no_show_all(True)
             self.ins.get_nth_page(current_tab).top_bar.show()
             self.ins.get_nth_page(current_tab).scroll.hide()
         else:
@@ -243,13 +244,22 @@ class RecipeSelectionPage (HobPage):
             self.builder.show_recipe_property_dialog(properties)
 
     def build_packages_clicked_cb(self, button):
+        self.refresh_tables()
         self.builder.build_packages()
 
+    def refresh_tables(self):
+        self.ins.reset_entry(self.ins.search, 0)
+        for tab in self.tables:
+            index = self.tables.index(tab)
+            filter = self.pages[index]['filter']
+            tab.set_model(self.recipe_model.tree_model(filter, search_data="", initial=True))
+
     def back_button_clicked_cb(self, button):
         self.builder.recipe_model.set_selected_image(self.builder.configuration.initial_selected_image)
         self.builder.image_configuration_page.update_image_combo(self.builder.recipe_model, self.builder.configuration.initial_selected_image)
         self.builder.image_configuration_page.update_image_desc()
         self.builder.show_configuration()
+        self.refresh_tables()
 
     def refresh_selection(self):
         self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
-- 
1.7.9.5



