Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Er-00067J-Oo
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:49 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 15 Mar 2012 01:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="139193666"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2012 01:32:04 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:55 +0800
Message-Id: <0c766a8c69782b2dd35a363dc9573b78f9d41995.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 07/12] Hob: Remove the recipe/package populated signal
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:50 -0000

Handle the recipe and package list update in
handler_command_succeeded_cb(), which could avoid potential race
condition when doing recipe/package list updating and page switching.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py      |   18 ++++++++----------
 lib/bb/ui/crumbs/hoblistmodel.py |   14 --------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index f9844de..c6b1a3d 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -200,8 +200,6 @@ class Builder(gtk.Window):
         self.connect("delete-event", self.destroy_window_cb)
         self.recipe_model.connect ("recipe-selection-changed",  self.recipelist_changed_cb)
         self.package_model.connect("package-selection-changed", self.packagelist_changed_cb)
-        self.recipe_model.connect ("recipelist-populated",      self.recipelist_populated_cb)
-        self.package_model.connect("packagelist-populated",     self.packagelist_populated_cb)
         self.handler.connect("config-updated",           self.handler_config_updated_cb)
         self.handler.connect("package-formats-updated",  self.handler_package_formats_updated_cb)
         self.handler.connect("layers-updated",           self.handler_layers_updated_cb)
@@ -413,10 +411,14 @@ class Builder(gtk.Window):
                          self.handler.GENERATE_IMAGE]:
             self.handler.request_package_info_async()
         elif initcmd == self.handler.POPULATE_PACKAGEINFO:
+            if self.current_step == self.RCPPKGINFO_POPULATING:
+                self.switch_page(self.RCPPKGINFO_POPULATED)
+                self.rcppkglist_populated()
+                return
+
+            self.rcppkglist_populated()
             if self.current_step == self.FAST_IMAGE_GENERATING:
                 self.switch_page(self.IMAGE_GENERATING)
-            elif self.current_step == self.RCPPKGINFO_POPULATING:
-                self.switch_page(self.RCPPKGINFO_POPULATED)
             elif self.current_step == self.PACKAGE_GENERATING:
                 self.switch_page(self.PACKAGE_GENERATED)
             elif self.current_step == self.IMAGE_GENERATING:
@@ -448,7 +450,7 @@ class Builder(gtk.Window):
     def handler_data_generated_cb(self, handler):
         self.window_sensitive(True)
 
-    def recipelist_populated_cb(self, recipe_model):
+    def rcppkglist_populated(self):
         selected_image = self.configuration.selected_image
         selected_recipes = self.configuration.selected_recipes[:]
         selected_packages = self.configuration.selected_packages[:]
@@ -458,11 +460,7 @@ class Builder(gtk.Window):
                                             " ".join(selected_packages))
 
         self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
-
         self.update_recipe_model(selected_image, selected_recipes)
-
-    def packagelist_populated_cb(self, package_model):
-        selected_packages = self.configuration.selected_packages[:]
         self.update_package_model(selected_packages)
 
     def recipelist_changed_cb(self, recipe_model):
@@ -825,7 +823,7 @@ class Builder(gtk.Window):
         self.switch_page(self.RECIPE_SELECTION)
 
     def initiate_new_build(self):
-	self.configuration.curr_mach = ""
+        self.configuration.curr_mach = ""
         self.image_configuration_page.switch_machine_combo()
         self.switch_page(self.MACHINE_SELECTION)
 
diff --git a/lib/bb/ui/crumbs/hoblistmodel.py b/lib/bb/ui/crumbs/hoblistmodel.py
index c19aaa8..edd61b5 100644
--- a/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/lib/bb/ui/crumbs/hoblistmodel.py
@@ -36,9 +36,6 @@ class PackageListModel(gtk.TreeStore):
     (COL_NAME, COL_VER, COL_REV, COL_RNM, COL_SEC, COL_SUM, COL_RDEP, COL_RPROV, COL_SIZE, COL_BINB, COL_INC) = range(11)
 
     __gsignals__ = {
-        "packagelist-populated" : (gobject.SIGNAL_RUN_LAST,
-                                gobject.TYPE_NONE,
-                                ()),
         "package-selection-changed" : (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                 ()),
@@ -135,8 +132,6 @@ class PackageListModel(gtk.TreeStore):
     """
     The populate() function takes as input the data from a
     bb.event.PackageInfo event and populates the package list.
-    Once the population is done it emits gsignal packagelist-populated
-    to notify any listeners that the model is ready
     """
     def populate(self, pkginfolist):
         self.clear()
@@ -194,8 +189,6 @@ class PackageListModel(gtk.TreeStore):
                      self.COL_RPROV, rprov, self.COL_SIZE, size,
                      self.COL_BINB, "", self.COL_INC, False)
 
-        self.emit("packagelist-populated")
-
     """
     Check whether the item at item_path is included or not
     """
@@ -425,9 +418,6 @@ class RecipeListModel(gtk.ListStore):
     __dummy_image__ = "Start from scratch"
 
     __gsignals__ = {
-        "recipelist-populated" : (gobject.SIGNAL_RUN_LAST,
-                                gobject.TYPE_NONE,
-                                ()),
         "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                  ()),
@@ -524,8 +514,6 @@ class RecipeListModel(gtk.ListStore):
     """
     The populate() function takes as input the data from a
     bb.event.TargetsTreeGenerated event and populates the RecipeList.
-    Once the population is done it emits gsignal recipelist-populated
-    to notify any listeners that the model is ready
     """
     def populate(self, event_model):
         # First clear the model, in case repopulating
@@ -580,8 +568,6 @@ class RecipeListModel(gtk.ListStore):
             self.pn_path[pn] = path
             it = self.iter_next(it)
 
-        self.emit("recipelist-populated")
-
     """
     Update the model, send out the notification.
     """
-- 
1.7.4.1



