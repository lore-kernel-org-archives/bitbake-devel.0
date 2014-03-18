Return-Path: <marius.avram@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 09C6F6F7A6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Mar 2014 12:12:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 18 Mar 2014 05:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,677,1389772800"; d="scan'208";a="501124016"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by fmsmga002.fm.intel.com with ESMTP; 18 Mar 2014 05:12:04 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Mar 2014 14:17:06 +0200
Message-Id: <1395145026-14112-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: output filenames based on initial recipe name
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 18 Mar 2014 12:12:05 -0000

If a recipe for an image was edited from the hob interface the name
of the files outputed in the <build_dir>/tmp/deploy/images/${MACHINE}/ and the
temporary recipes from <build_dir>/recipes/images/ contained only the
generic name "hob-image". From now on both the temporary recipes and
the output from the deploy/ directory will contain the name of the base
recipe appended by the "-edited" suffix, in the case when a base image recipe was
edited. The base recipe can be a standard recipe (e.g core-image-minimal) or
a custom created and saved by the user.

For example, if core-image-minimal is edited the deploy/ directory will contain
core-image-minimal-edited-20140318-140428-qemux86.ext3 and the recipes/images/
directory will contain the recipe core-image-minimal-edited-20140318-140428.bb.

[YOCTO #5002]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    7 +++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   22 ++++++++++++--------
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    2 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 ++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    2 +-
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1c8469b..9adb1f7 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -447,7 +447,6 @@ class Builder(gtk.Window):
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
         self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/custom/*.bb")
-        self.handler.generate_hob_base_image()
         self.initiate_new_build_async()
 
         signal.signal(signal.SIGINT, self.event_handle_SIGINT)
@@ -738,6 +737,10 @@ class Builder(gtk.Window):
             self.configuration.update(params)
             self.parameters.update(params)
 
+    def set_base_image(self):
+        self.configuration.initial_selected_image = self.configuration.selected_image
+        self.hob_image = self.configuration.selected_image + "-edited"
+
     def reset(self):
         self.configuration.curr_mach = ""
         self.configuration.clear_selection()
@@ -962,7 +965,7 @@ class Builder(gtk.Window):
             if selected_image == self.recipe_model.__custom_image__:
                 if self.configuration.initial_selected_image != selected_image:
                     version = self.recipe_model.get_custom_image_version()
-                linkname = 'hob-image' + version+ "-" + self.configuration.curr_mach
+                linkname = self.hob_image + version + "-" + self.configuration.curr_mach
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
             image_extension = self.get_image_extension()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 46f36d8..73d5f98 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -165,14 +165,17 @@ class HobHandler(gobject.GObject):
             self.clear_busy()
             self.building = True
             target = self.image
-            if target == "hob-image":
+
+            if self.base_image:
+                # Request the build of a custom image
+                self.generate_hob_base_image(target)
                 self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
-                hobImage = self.runCommand(["matchFile", "hob-image.bb"])
-                if self.base_image != "Start with an empty image recipe":
-                    baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
-                    target += version
-                    self.recipe_model.set_custom_image_version(version)
+                hobImage = self.runCommand(["matchFile", target + ".bb"])
+                baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
+                version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
+                target += version
+                self.recipe_model.set_custom_image_version(version)
+
             targets = [target]
             if self.toolchain_packages:
                 self.set_var_in_file("TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages), "local.conf")
@@ -440,10 +443,11 @@ class HobHandler(gobject.GObject):
             base_image = self.runCommand(["matchFile", self.base_image + ".bb"])
         self.runCommand(["generateNewImage", image, base_image, package_queue, False, description])
 
-    def generate_hob_base_image(self):
+    def generate_hob_base_image(self, hob_image):
         image_dir = self.get_topdir() + "/recipes/images/"
+        recipe_name = hob_image + ".bb"
         self.ensure_dir(image_dir)
-        self.generate_new_image(image_dir+"hob-image.bb", None, [], "")
+        self.generate_new_image(image_dir + recipe_name, None, [], "")
         self.append_to_bbfiles(image_dir + "*.bb")
 
     def ensure_dir(self, directory):
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index cffe6e1..02d6332 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -704,7 +704,7 @@ class RecipeListModel(gtk.ListStore):
             if ('packagegroup.bbclass' in " ".join(inherits)):
                 atype = 'packagegroup'
             elif ('image.bbclass' in " ".join(inherits)):
-                if name != "hob-image":
+                if "edited" not in name:
                     atype = 'image'
                     install = event_model["rdepends-pkg"].get(item, []) + event_model["rrecs-pkg"].get(item, [])
             elif ('meta-' in name):
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index c4fd3f7..2766bea 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -459,6 +459,7 @@ class ImageConfigurationPage (HobPage):
             for i in self.builder.parameters.image_black_pattern.split():
                 black_pattern.append(re.compile(i))
         black_pattern.append(re.compile("hob-image"))
+        black_pattern.append(re.compile("edited(-[0-9]*)*.bb$"))
 
         it = image_model.get_iter_first()
         self._image_combo_disconnect_signal()
@@ -545,7 +546,7 @@ class ImageConfigurationPage (HobPage):
         self.builder.just_bake()
 
     def edit_image_button_clicked_cb(self, button):
-        self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
+        self.builder.set_base_image()
         self.builder.show_recipes()
 
     def my_images_button_clicked_cb(self, button):
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 780f026..7c62b36e 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -293,7 +293,7 @@ class PackageSelectionPage (HobPage):
         self.refresh_selection()
         if not self.builder.customized:
             self.builder.customized = True
-            self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
+            self.builder.set_base_image()
             self.builder.configuration.selected_image = self.recipe_model.__custom_image__
             self.builder.rcppkglist_populated()
 
-- 
1.7.9.5


