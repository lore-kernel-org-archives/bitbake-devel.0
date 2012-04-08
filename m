Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGpI3-0004su-HI
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:24:11 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 08 Apr 2012 03:14:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151167356"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2012 03:14:57 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:23 +0800
Message-Id: <082019720337beea55d9cb110b127966313eb956.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 20/20] Hob: change the logic for rcppkglist_populated()
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
X-List-Received-Date: Sun, 08 Apr 2012 10:24:11 -0000

There are some bugs in the previous log of rcppkglist_populated. [Yocto #2255]
is one of them.

Once more, when the user loads a template, changes the base image to the other
one which is not the same as the one in the template, changes the machine, and
then you will find the base image specified in the template disappears.

This patch changes the logic as follows:
- If any template is loaded into this Hob session, its base image will be
  remembered always. After the recipe list and the package list are populated,
  the template base image will be appended.
  That is to fix the above bug.
- If the reason for reparsing recipes is any settings are changed, Hob will
  remember selected_recipes and selected_packages. The behaviour is the same
  as before, because we don't want to clear the user selection.
- If the reason for reparsing recipes is the machine is changed, including a
  template is loaded (which causes the machine is changed), Hob will forget
  selected_recipes and selected_packages the user selects. (see [Yocto #2255]
  for details)
- Again, we reuse the code for rcppkglist_populated() for any base image changing.
  I.e., when the user changes any base image, Hob will forget the previous
  selected_recipes and selected_packages.

In Hob code, two places will cause recipe parsing. One is settings are changed.
The other is machine is changed.

[Yocto #2255]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   65 +++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   30 ++--------
 2 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 4997cd4..849a1f0 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -26,6 +26,7 @@ import copy
 import os
 import subprocess
 import shlex
+import glib
 from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
@@ -259,6 +260,7 @@ class Builder(gtk.Window):
         self.handler = hobHandler
 
         self.template = None
+        self.loaded_images = []
 
         # build step
         self.current_step = None
@@ -339,7 +341,8 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.parse_generate_configuration()
 
-    def populate_recipe_package_info_async(self):
+    def populate_recipe_package_info_async(self, mach_changed = True):
+        self.mach_changed = mach_changed
         self.switch_page(self.RCPPKGINFO_POPULATING)
         # Parse recipes
         self.set_user_config()
@@ -395,6 +398,12 @@ class Builder(gtk.Window):
         self.template.load(path)
         self.configuration.load(self.template)
 
+        entry = {}
+        entry["image"] = self.configuration.selected_image
+        entry["recipes"] = self.configuration.selected_recipes[:]
+        entry["packages"] = self.configuration.selected_packages[:]
+        self.loaded_images.append(entry)
+
         for layer in self.configuration.layers:
             if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
@@ -589,17 +598,57 @@ class Builder(gtk.Window):
         self.window_sensitive(True)
 
     def rcppkglist_populated(self):
+        # remember those images loaded previously in this Hob session
+        for entry in self.loaded_images:
+            self.recipe_model.image_list_append(entry["image"],
+                " ".join(entry["recipes"]),
+                " ".join(entry["packages"]))
+
+        if self.mach_changed:
+            self.update_rcppkglist_forgotten(self.configuration.selected_image)
+        else:
+            self.update_rcppkglist_remembered()
+
+    def update_rcppkglist_idle(self, selected_image, selected_recipes, selected_packages):
+        self.update_recipe_model(selected_image, selected_recipes)
+        self.update_package_model(selected_packages)
+        self.window_sensitive(True)
+
+    def update_rcppkglist_forgotten(self, selected_image = None):
+        self.window_sensitive(False)
+
+        selected_recipes = selected_packages = []
+        self.recipe_model.reset()
+        self.package_model.reset()
+
+        selected_image_desc = ""
+        if selected_image:
+            image_path = self.recipe_model.pn_path[selected_image]
+            image_iter = self.recipe_model.get_iter(image_path)
+            selected_packages = self.recipe_model.get_value(image_iter, self.recipe_model.COL_INSTALL).split()
+            selected_image_desc = self.recipe_model.get_value(image_iter, self.recipe_model.COL_DESC)
+
+        self.image_configuration_page.update_image_combo(self.recipe_model, selected_image, selected_image_desc)
+
+        glib.idle_add(self.update_rcppkglist_idle, selected_image, selected_recipes, selected_packages)
+
+
+    def update_rcppkglist_remembered(self):
+        self.window_sensitive(False)
+
         selected_image = self.configuration.selected_image
         selected_recipes = self.configuration.selected_recipes[:]
         selected_packages = self.configuration.selected_packages[:]
 
-        self.recipe_model.image_list_append(selected_image,
-                                            " ".join(selected_recipes),
-                                            " ".join(selected_packages))
+        selected_image_desc = ""
+        if selected_image:
+            image_path = self.recipe_model.pn_path[selected_image]
+            image_iter = self.recipe_model.get_iter(image_path)
+            selected_image_desc = self.recipe_model.get_value(image_iter, self.recipe_model.COL_DESC)
 
-        self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
-        self.update_recipe_model(selected_image, selected_recipes)
-        self.update_package_model(selected_packages)
+        self.image_configuration_page.update_image_combo(self.recipe_model, selected_image, selected_image_desc)
+
+        glib.idle_add(self.update_rcppkglist_idle, selected_image, selected_recipes, selected_packages)
 
     def recipelist_changed_cb(self, recipe_model):
         self.recipe_details_page.refresh_selection()
@@ -905,7 +954,7 @@ class Builder(gtk.Window):
         if not self.configuration.curr_mach:
             self.update_config_async()
         else:
-            self.populate_recipe_package_info_async()
+            self.populate_recipe_package_info_async(mach_changed = False)
 
     def deploy_image(self, image_name):
         if not image_name:
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index c2e0f5f..c63fc61 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -21,7 +21,6 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import gtk
-import glib
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton, HobAltButton, HobButton
@@ -259,7 +258,7 @@ class ImageConfigurationPage (HobPage):
 
         self.builder.configuration.curr_mach = combo_item
         # Do reparse recipes
-        self.builder.populate_recipe_package_info_async()
+        self.builder.populate_recipe_package_info_async(mach_changed = True)
 
     def update_machine_combo(self):
         all_machines = self.builder.parameters.all_machines
@@ -280,32 +279,11 @@ class ImageConfigurationPage (HobPage):
             active += 1
         self.machine_combo.set_active(-1)
 
-    def image_combo_changed_idle_cb(self, selected_image, selected_recipes, selected_packages):
-        self.builder.update_recipe_model(selected_image, selected_recipes)
-        self.builder.update_package_model(selected_packages)
-        self.builder.window_sensitive(True)
-
     def image_combo_changed_cb(self, combo):
-        self.builder.window_sensitive(False)
         selected_image = self.image_combo.get_active_text()
         if not selected_image:
             return
-
-        selected_recipes = []
-
-        image_path = self.builder.recipe_model.pn_path[selected_image]
-        image_iter = self.builder.recipe_model.get_iter(image_path)
-        selected_packages = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_INSTALL).split()
-
-        mark = ("<span %s>%s</span>\n") % (self.span_tag('small'), self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC))
-        self.image_desc.set_markup(mark)
-
-        self.builder.recipe_model.reset()
-        self.builder.package_model.reset()
-
-        self.show_baseimg_selected()
-
-        glib.idle_add(self.image_combo_changed_idle_cb, selected_image, selected_recipes, selected_packages)
+        self.builder.update_rcppkglist_forgotten(selected_image)
 
     def _image_combo_connect_signal(self):
         if not self.image_combo_id:
@@ -316,7 +294,7 @@ class ImageConfigurationPage (HobPage):
             self.image_combo.disconnect(self.image_combo_id)
             self.image_combo_id = None
 
-    def update_image_combo(self, recipe_model, selected_image):
+    def update_image_combo(self, recipe_model, selected_image, selected_image_desc):
         # Update the image combo according to the images in the recipe_model
         # populate image combo
         filter = {RecipeListModel.COL_TYPE : ['image']}
@@ -348,6 +326,8 @@ class ImageConfigurationPage (HobPage):
 
         if active != -1:
             self.show_baseimg_selected()
+            mark = "<span %s>%s</span>\n" % (self.span_tag('small'), selected_image_desc)
+            self.image_desc.set_markup(mark)
 
         self._image_combo_connect_signal()
 
-- 
1.7.6



