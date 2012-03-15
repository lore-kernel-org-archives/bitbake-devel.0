Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Eq-00067J-OS
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:48 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 15 Mar 2012 01:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129245737"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2012 01:32:02 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:53 +0800
Message-Id: <f576355686804631fd797e2a5d383a70f6fc42cd.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 05/12] Hob: Remove the reset button in recipe/package selection page
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:49 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py              |    6 ------
 lib/bb/ui/crumbs/packageselectionpage.py |   11 -----------
 lib/bb/ui/crumbs/recipeselectionpage.py  |    9 ---------
 3 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index a905030..f9844de 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -361,12 +361,6 @@ class Builder(gtk.Window):
         self.handler.set_extra_config(self.configuration.extra_setting)
         self.handler.set_extra_inherit("packageinfo")
 
-    def reset_recipe_model(self):
-        self.recipe_model.reset()
-
-    def reset_package_model(self):
-        self.package_model.reset()
-
     def update_recipe_model(self, selected_image, selected_recipes):
         self.recipe_model.set_selected_image(selected_image)
         self.recipe_model.set_selected_recipes(selected_recipes)
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index a8628ac..0427fe2 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -118,12 +118,6 @@ class PackageSelectionPage (HobPage):
             if self.pages[i]['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
 
-            reset_button = gtk.Button("Reset")
-            reset_button.connect("clicked", self.reset_clicked_cb)
-            hbox = gtk.HBox(False, 5)
-            hbox.pack_end(reset_button, expand=False, fill=False)
-            tab.pack_start(hbox, expand=False, fill=False)
-
             label = gtk.Label(self.pages[i]['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
@@ -206,11 +200,6 @@ class PackageSelectionPage (HobPage):
             size_str = str(size) + ' KB'
         return size_str
 
-    # Callback functions
-    def reset_clicked_cb(self, button):
-        self.package_model.reset()
-        self.builder.reset_package_model()
-
     def toggle_item_idle_cb(self, path):
         if not self.package_model.path_included(path):
             self.package_model.include_item(item_path=path, binb="User Selected")
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index aea9c0c..234734c 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -141,11 +141,6 @@ class RecipeSelectionPage (HobPage):
             tab.connect("toggled", self.table_toggled_cb)
             if self.pages[i]['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
-            reset_button = gtk.Button("Reset")
-            reset_button.connect("clicked", self.reset_clicked_cb)
-            hbox = gtk.HBox(False, 5)
-            hbox.pack_end(reset_button, expand=False, fill=False)
-            tab.pack_start(hbox, expand=False, fill=False)
 
             label = gtk.Label(self.pages[i]['name'])
             self.ins.append_page(tab, label)
@@ -201,10 +196,6 @@ class RecipeSelectionPage (HobPage):
         self.label.set_text("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
         self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
 
-    # Callback functions
-    def reset_clicked_cb(self, button):
-        self.builder.reset_recipe_model()
-
     def toggle_item_idle_cb(self, path):
         if not self.recipe_model.path_included(path):
             self.recipe_model.include_item(item_path=path, binb="User Selected", image_contents=False)
-- 
1.7.4.1



