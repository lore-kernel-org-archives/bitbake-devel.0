Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1T3qTd-0007bE-40
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 17:34:45 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 08:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,802,1336374000"; d="scan'208";a="211703950"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.53])
	by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2012 08:21:35 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 18:21:23 +0300
Message-Id: <1345562483-973-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] Hob wizard-like reorganization
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
X-List-Received-Date: Tue, 21 Aug 2012 15:34:45 -0000

Hob is now more context-sensitive regarding
user changes/options. Also, the workflow have been
streamlined and resembles more of a wizard.
Beautified some hardcoded values.
Fixed typo.
New streamlined Image Configuration page.
Build and/or Edit image buttons presence
is context sensitive.
Recipes and packages tabs selected automatically
based on custom image or pre-defined target image
(included or all).
Context sensitive Back button.

Fixes [YOCTO 2165]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |    2 +-
 bitbake/lib/bb/ui/crumbs/builder.py                |   23 +++++--
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    5 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   68 +++++++-------------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   16 +++--
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   15 +++--
 6 files changed, 69 insertions(+), 60 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 30eab29..4d2d947 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -165,7 +165,7 @@ class BuildDetailsPage (HobPage):
         self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
 
         self.button_box = gtk.HBox(False, 6)
-        self.back_button = HobAltButton("<< Back to image configuration")
+        self.back_button = HobAltButton('<< Back')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index cb2338e..dd7ebe1 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -41,7 +41,7 @@ from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 import bb.ui.crumbs.utils
 
-hobVer = 20120530
+hobVer = 20120808
 
 class Configuration:
     '''Represents the data structure of configuration.'''
@@ -640,16 +640,28 @@ class Builder(gtk.Window):
             self.image_configuration_page.show_baseimg_selected()
 
         elif next_step == self.RECIPE_SELECTION:
-            pass
+            if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
+                self.recipe_details_page.set_recipe_curr_tab(self.recipe_details_page.ALL)
+            else:
+                self.recipe_details_page.set_recipe_curr_tab(self.recipe_details_page.INCLUDED)
 
         elif next_step == self.PACKAGE_SELECTION:
+            if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
+                self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
+            else:
+                self.package_details_page.set_packages_curr_tab(self.package_details_page.INCLUDED)
             self.package_details_page.show_page(self.current_logfile)
 
+
         elif next_step == self.PACKAGE_GENERATING or next_step == self.FAST_IMAGE_GENERATING:
-            # both PACKAGE_GENEATING and FAST_IMAGE_GENERATING share the same page
+            # both PACKAGE_GENERATING and FAST_IMAGE_GENERATING share the same page
             self.build_details_page.show_page(next_step)
 
         elif next_step == self.PACKAGE_GENERATED:
+            if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
+                self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
+            else:
+                self.package_details_page.set_packages_curr_tab(self.package_details_page.INCLUDED)
             self.package_details_page.show_page(self.current_logfile)
 
         elif next_step == self.IMAGE_GENERATING:
@@ -781,8 +793,6 @@ class Builder(gtk.Window):
         self.image_configuration_page.layer_button.set_sensitive(sensitive)
         self.image_configuration_page.layer_info_icon.set_sensitive(sensitive)
         self.image_configuration_page.toolbar.set_sensitive(sensitive)
-        self.image_configuration_page.view_recipes_button.set_sensitive(sensitive)
-        self.image_configuration_page.view_packages_button.set_sensitive(sensitive)
         self.image_configuration_page.config_build_button.set_sensitive(sensitive)
 
         self.recipe_details_page.set_sensitive(sensitive)
@@ -1270,6 +1280,9 @@ class Builder(gtk.Window):
     def show_recipes(self):
         self.switch_page(self.RECIPE_SELECTION)
 
+    def show_image_details(self):
+        self.switch_page(self.IMAGE_GENERATED)
+
     def show_configuration(self):
         self.switch_page(self.BASEIMG_SELECTED)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 37cee78..3de9e5b 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -566,9 +566,8 @@ class RecipeListModel(gtk.ListStore):
 
         # dummy image for prompt
         self.set(self.append(), self.COL_NAME, self.__custom_image__,
-                 self.COL_DESC, "Use the 'View recipes' and 'View packages' " \
-                                "options to select what you want to include " \
-                                "in your image.",
+                 self.COL_DESC, "Use 'Edit image' to customize recipes and packages " \
+                                "to be included in your image ",
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
                  self.COL_TYPE, "image", self.COL_INC, False,
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 80332fe..6aeb6dc 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -135,8 +135,10 @@ class ImageConfigurationPage (HobPage):
         self._pack_components(pack_config_build_button = True)
         self.set_config_machine_layout(show_progress_bar = False)
         self.set_config_baseimg_layout()
-        self.set_rcppkg_layout()
         self.show_all()
+        if self.builder.recipe_model.get_selected_image() == self.builder.recipe_model.__custom_image__:
+            self.just_bake_button.hide()
+            self.or_label.hide()
 
     def create_config_machine(self):
         self.machine_title = gtk.Label()
@@ -207,22 +209,6 @@ class ImageConfigurationPage (HobPage):
         self.image_desc.set_justify(gtk.JUSTIFY_LEFT)
         self.image_desc.set_line_wrap(True)
 
-        # button to view recipes
-        icon_file = hic.ICON_RCIPE_DISPLAY_FILE
-        hover_file = hic.ICON_RCIPE_HOVER_FILE
-        self.view_recipes_button = HobImageButton("View recipes",
-                                        "Add/remove recipes and tasks",
-                                        icon_file, hover_file)
-        self.view_recipes_button.connect("clicked", self.view_recipes_button_clicked_cb)
-
-        # button to view packages
-        icon_file = hic.ICON_PACKAGES_DISPLAY_FILE
-        hover_file = hic.ICON_PACKAGES_HOVER_FILE
-        self.view_packages_button = HobImageButton("View packages",
-                                        "Add/remove previously built packages",
-                                        icon_file, hover_file)
-        self.view_packages_button.connect("clicked", self.view_packages_button_clicked_cb)
-
         self.image_separator = gtk.HSeparator()
 
     def set_config_baseimg_layout(self):
@@ -232,29 +218,27 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.image_desc, 13, 38, 23, 28)
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
-    def set_rcppkg_layout(self):
-        self.gtable.attach(self.view_recipes_button, 0, 20, 28, 33)
-        self.gtable.attach(self.view_packages_button, 20, 40, 28, 33)
-
     def create_config_build_button(self):
         # Create the "Build packages" and "Build image" buttons at the bottom
         button_box = gtk.HBox(False, 6)
 
         # create button "Build image"
-        just_bake_button = HobButton("Build image")
-        just_bake_button.set_size_request(205, 49)
-        just_bake_button.set_tooltip_text("Build target image")
-        just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
-        button_box.pack_end(just_bake_button, expand=False, fill=False)
-
-        label = gtk.Label(" or ")
-        button_box.pack_end(label, expand=False, fill=False)
-
-        # create button "Build Packages"
-        build_packages_button = HobAltButton("Build packages")
-        build_packages_button.connect("clicked", self.build_packages_button_clicked_cb)
-        build_packages_button.set_tooltip_text("Build recipes into packages")
-        button_box.pack_end(build_packages_button, expand=False, fill=False)
+        self.just_bake_button = HobButton("Build image")
+        self.just_bake_button.set_size_request(205, 49)
+        self.just_bake_button.set_tooltip_text("Build target image")
+        self.just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
+        button_box.pack_end(self.just_bake_button, expand=False, fill=False)
+
+        # create separator label
+        self.or_label = gtk.Label(" or ")
+        button_box.pack_end(self.or_label, expand=False, fill=False)
+
+        # create button "Edit Image"
+        self.edit_image_button = HobButton("Edit image")
+        self.edit_image_button.set_size_request(205, 49)
+        self.edit_image_button.set_tooltip_text("Edit target image")
+        self.edit_image_button.connect("clicked", self.edit_image_button_clicked_cb)
+        button_box.pack_end(self.edit_image_button, expand=False, fill=False)
 
         return button_box
 
@@ -347,6 +331,10 @@ class ImageConfigurationPage (HobPage):
 
         self.show_baseimg_selected()
 
+        if selected_image == self.builder.recipe_model.__custom_image__:
+            self.just_bake_button.hide()
+            self.or_label.hide()
+
         glib.idle_add(self.image_combo_changed_idle_cb, selected_image, selected_recipes, selected_packages)
 
     def _image_combo_connect_signal(self):
@@ -426,17 +414,11 @@ class ImageConfigurationPage (HobPage):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
 
-    def view_recipes_button_clicked_cb(self, button):
-        self.builder.show_recipes()
-
-    def view_packages_button_clicked_cb(self, button):
-        self.builder.show_packages()
-
     def just_bake_button_clicked_cb(self, button):
         self.builder.just_bake()
 
-    def build_packages_button_clicked_cb(self, button):
-        self.builder.build_packages()
+    def edit_image_button_clicked_cb(self, button):
+        self.builder.show_recipes()
 
     def template_button_clicked_cb(self, button):
         response, path = self.builder.show_load_template_dialog()
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index d101535..3576ed5 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -98,9 +98,12 @@ class PackageSelectionPage (HobPage):
                       }]
         }
     ]
+    
+    (INCLUDED,
+     ALL) = range(2)
 
     def __init__(self, builder):
-        super(PackageSelectionPage, self).__init__(builder, "Packages")
+        super(PackageSelectionPage, self).__init__(builder, "Edit packages")
 
         # set invisiable members
         self.recipe_model = self.builder.recipe_model
@@ -110,7 +113,7 @@ class PackageSelectionPage (HobPage):
         self.create_visual_elements()
 
     def included_clicked_cb(self, button):
-        self.ins.set_current_page(0)
+        self.ins.set_current_page(self.INCLUDED)
 
     def create_visual_elements(self):
         self.label = gtk.Label("Packages included: 0\nSelected packages size: 0 MB")
@@ -154,7 +157,7 @@ class PackageSelectionPage (HobPage):
         self.build_image_button.connect("clicked", self.build_image_clicked_cb)
         self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
 
-        self.back_button = HobAltButton("<< Back to image configuration")
+        self.back_button = HobAltButton('<< Back')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
@@ -189,7 +192,10 @@ class PackageSelectionPage (HobPage):
         self.builder.build_image()
 
     def back_button_clicked_cb(self, button):
-        self.builder.show_configuration()
+        if self.builder.current_step ==  self.builder.PACKAGE_GENERATED:
+            self.builder.show_recipes()
+        elif self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
+            self.builder.show_image_details()
 
     def _expand_all(self):
         for tab in self.tables:
@@ -294,3 +300,5 @@ class PackageSelectionPage (HobPage):
             child_path = self.package_model.convert_vpath_to_path(model, paths[0])
             self.package_model.foreach(self.foreach_cell_change_font, child_path)
 
+    def set_packages_curr_tab(self, curr_page):
+        self.ins.set_current_page(curr_page)
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index af68f2a..d8e71b0 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -124,18 +124,22 @@ class RecipeSelectionPage (HobPage):
                       }]
         }
     ]
+    
+    (INCLUDED,
+     ALL,
+     TASKS) = range(3)
 
     def __init__(self, builder = None):
-        super(RecipeSelectionPage, self).__init__(builder, "Recipes")
+        super(RecipeSelectionPage, self).__init__(builder, "Edit recipes")
 
-        # set invisiable members
+        # set invisible members
         self.recipe_model = self.builder.recipe_model
 
         # create visual elements
         self.create_visual_elements()
 
     def included_clicked_cb(self, button):
-        self.ins.set_current_page(0)
+        self.ins.set_current_page(self.INCLUDED)
 
     def create_visual_elements(self):
         self.eventbox = self.add_onto_top_bar(None, 73)
@@ -180,7 +184,7 @@ class RecipeSelectionPage (HobPage):
         self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
         button_box.pack_end(self.build_packages_button, expand=False, fill=False)
 
-        self.back_button = HobAltButton("<< Back to image configuration")
+        self.back_button = HobAltButton('<< Back')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
@@ -261,3 +265,6 @@ class RecipeSelectionPage (HobPage):
 
     def after_fadeout_checkin_include(self, table, ctrl, cell, tree):
         tree.set_model(self.recipe_model.tree_model(self.pages[0]['filter']))
+
+    def set_recipe_curr_tab(self, curr_page):
+        self.ins.set_current_page(curr_page)
-- 
1.7.9.5



