Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SWTuv-0000IU-Aw
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 16:49:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 May 2012 07:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="146430729"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 21 May 2012 07:38:52 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 May 2012 22:41:20 +0800
Message-Id: <be9df903825ec31825cd12c0d5d20d0ca0e8d88a.1337610738.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1337610738.git.limingx.l.an@intel.com>
References: <cover.1337610738.git.limingx.l.an@intel.com>
Subject: [PATCH 1/5] Hob: add '--select a machine--' and '--select a base image--' to GUI
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
X-List-Received-Date: Mon, 21 May 2012 14:49:01 -0000

[YOCTO #2175]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    6 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    6 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   43 +++++++++++++++-----
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
 4 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 42d0f2c..eb60b89 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -438,7 +438,7 @@ class Builder(gtk.Window):
         toolchain_packages = []
         if self.configuration.toolchain_build:
             toolchain_packages = self.package_model.get_selected_packages_toolchain()
-        if self.configuration.selected_image == self.recipe_model.__dummy_image__:
+        if self.configuration.selected_image == self.recipe_model.__custom_image__:
             packages = self.package_model.get_selected_packages()
             image = self.hob_image
         else:
@@ -752,7 +752,7 @@ class Builder(gtk.Window):
             fraction = 1.0
             self.parameters.image_names = []
             selected_image = self.recipe_model.get_selected_image()
-            if selected_image == self.recipe_model.__dummy_image__:
+            if selected_image == self.recipe_model.__custom_image__:
                 linkname = 'hob-image-' + self.configuration.curr_mach
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
@@ -890,7 +890,7 @@ class Builder(gtk.Window):
         selected_packages = self.package_model.get_selected_packages() or []
 
         # If no base image and no selected packages don't build anything
-        if not (selected_packages or selected_image != self.recipe_model.__dummy_image__):
+        if not (selected_packages or selected_image != self.recipe_model.__custom_image__):
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 0b54f91..37cee78 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -456,7 +456,7 @@ class RecipeListModel(gtk.ListStore):
     """
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC) = range(12)
 
-    __dummy_image__ = "Create your own image"
+    __custom_image__ = "Create your own image"
 
     __gsignals__ = {
         "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -565,14 +565,14 @@ class RecipeListModel(gtk.ListStore):
         self.clear()
 
         # dummy image for prompt
-        self.set(self.append(), self.COL_NAME, self.__dummy_image__,
+        self.set(self.append(), self.COL_NAME, self.__custom_image__,
                  self.COL_DESC, "Use the 'View recipes' and 'View packages' " \
                                 "options to select what you want to include " \
                                 "in your image.",
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
                  self.COL_TYPE, "image", self.COL_INC, False,
-                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__dummy_image__)
+                 self.COL_IMG, False, self.COL_INSTALL, "", self.COL_PN, self.__custom_image__)
 
         for item in event_model["pn"]:
             name = item
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 95d48b9..d17ea8f 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -33,6 +33,9 @@ from bb.ui.crumbs.hobpages import HobPage
 #
 class ImageConfigurationPage (HobPage):
 
+    __dummy_machine__ = "--select a machine--"
+    __dummy_image__   = "--select a base image--"
+
     def __init__(self, builder):
         super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
 
@@ -259,9 +262,15 @@ class ImageConfigurationPage (HobPage):
 
     def machine_combo_changed_cb(self, machine_combo):
         combo_item = machine_combo.get_active_text()
-        if not combo_item:
+        if not combo_item or combo_item == self.__dummy_machine__:
             return
 
+        # remove __dummy_machine__ item from the store list after first user selection
+        # because it is no longer valid
+        combo_store = machine_combo.get_model()
+        if len(combo_store) and (combo_store[0][0] == self.__dummy_machine__):
+            machine_combo.remove_text(0)
+
         self.builder.configuration.curr_mach = combo_item
         if self.machine_combo_changed_by_manual:
             self.builder.configuration.clear_selection()
@@ -272,13 +281,13 @@ class ImageConfigurationPage (HobPage):
         self.builder.populate_recipe_package_info_async()
 
     def update_machine_combo(self):
-        all_machines = self.builder.parameters.all_machines
+        all_machines = [self.__dummy_machine__] + self.builder.parameters.all_machines
 
         model = self.machine_combo.get_model()
         model.clear()
         for machine in all_machines:
             self.machine_combo.append_text(machine)
-        self.machine_combo.set_active(-1)
+        self.machine_combo.set_active(0)
 
     def switch_machine_combo(self):
         self.machine_combo_changed_by_manual = False
@@ -289,7 +298,11 @@ class ImageConfigurationPage (HobPage):
                 self.machine_combo.set_active(active)
                 return
             active += 1
-        self.machine_combo.set_active(-1)
+
+        if model[0][0] != self.__dummy_machine__:
+            self.machine_combo.insert_text(0, self.__dummy_machine__)
+
+        self.machine_combo.set_active(0)
 
     def update_image_desc(self, selected_image):
         desc = ""
@@ -309,9 +322,15 @@ class ImageConfigurationPage (HobPage):
     def image_combo_changed_cb(self, combo):
         self.builder.window_sensitive(False)
         selected_image = self.image_combo.get_active_text()
-        if not selected_image:
+        if not selected_image or (selected_image == self.__dummy_image__):
             return
 
+        # remove __dummy_image__ item from the store list after first user selection
+        # because it is no longer valid
+        combo_store = combo.get_model()
+        if len(combo_store) and (combo_store[0][0] == self.__dummy_image__):
+            combo.remove_text(0)
+
         self.builder.customized = False
 
         selected_recipes = []
@@ -342,32 +361,34 @@ class ImageConfigurationPage (HobPage):
         # populate image combo
         filter = {RecipeListModel.COL_TYPE : ['image']}
         image_model = recipe_model.tree_model(filter)
-        active = -1
+        active = 0
         cnt = 0
 
         it = image_model.get_iter_first()
         self._image_combo_disconnect_signal()
         model = self.image_combo.get_model()
         model.clear()
+        # Set a indicator text to combo store when first open
+        self.image_combo.append_text(self.__dummy_image__)
         # append and set active
         while it:
             path = image_model.get_path(it)
             it = image_model.iter_next(it)
             image_name = image_model[path][recipe_model.COL_NAME]
-            if image_name == self.builder.recipe_model.__dummy_image__:
+            if image_name == self.builder.recipe_model.__custom_image__:
                 continue
             self.image_combo.append_text(image_name)
             if image_name == selected_image:
                 active = cnt
             cnt = cnt + 1
-        self.image_combo.append_text(self.builder.recipe_model.__dummy_image__)
-        if selected_image == self.builder.recipe_model.__dummy_image__:
+        self.image_combo.append_text(self.builder.recipe_model.__custom_image__)
+        if selected_image == self.builder.recipe_model.__custom_image__:
             active = cnt
 
-        self.image_combo.set_active(-1)
+        self.image_combo.set_active(0)
         self.image_combo.set_active(active)
 
-        if active != -1:
+        if active != 0:
             self.show_baseimg_selected()
 
         self._image_combo_connect_signal()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 7c1ecdd..ece37e0 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -222,7 +222,7 @@ class RecipeSelectionPage (HobPage):
         self.refresh_selection()
         if not self.builder.customized:
             self.builder.customized = True
-            self.builder.configuration.selected_image = self.recipe_model.__dummy_image__
+            self.builder.configuration.selected_image = self.recipe_model.__custom_image__
             self.builder.rcppkglist_populated()
 
         self.builder.window_sensitive(True)
-- 
1.7.5.4



