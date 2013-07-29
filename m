Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 656916B446
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:56:57 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:56:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372875948"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:56:57 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:15 +0300
Message-Id: <1375102770-14079-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
References: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V3 01/16] hob: labelling changes in Hob
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 12:56:57 -0000

When the design document for templates in Hob was created, we've noticed
that some labels need to change.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    2 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    4 ++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   22 ++++++++------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   11 +++++++---
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8788083..4c6e6fd 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -174,7 +174,7 @@ class HobHandler(gobject.GObject):
                 targets.append(self.toolchain)
             if targets[0] == "hob-image":
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
-                if self.base_image != "Create your own image":
+                if self.base_image != "Start with an empty image recipe":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
                     version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
                     targets[0] += version
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 7f7d82f..94c2453 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -476,7 +476,7 @@ class RecipeListModel(gtk.ListStore):
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC, COL_SUMMARY, COL_VERSION,
      COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER) = range(17)
 
-    __custom_image__ = "Create your own image"
+    __custom_image__ = "Start with an empty image recipe"
 
     __gsignals__ = {
         "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
@@ -679,7 +679,7 @@ class RecipeListModel(gtk.ListStore):
 
         # dummy image for prompt
         self.set(self.append(), self.COL_NAME, self.__custom_image__,
-                 self.COL_DESC, "Use 'Edit image' to customize recipes and packages " \
+                 self.COL_DESC, "Use 'Edit image recipe' to customize recipes and packages " \
                                 "to be included in your image ",
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 1f7453a..e4c6606 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -35,7 +35,7 @@ from bb.ui.crumbs.hobpages import HobPage
 class ImageConfigurationPage (HobPage):
 
     __dummy_machine__ = "--select a machine--"
-    __dummy_image__   = "--select a base image--"
+    __dummy_image__   = "Select from my image recipes"
 
     def __init__(self, builder):
         super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
@@ -200,12 +200,9 @@ class ImageConfigurationPage (HobPage):
         markup += "http://www.yoctoproject.org/docs/current/dev-manual/"
         markup += "dev-manual.html#understanding-and-using-layers\">reference manual</a>."
         self.layer_info_icon = HobInfoButton("<b>Layers</b>" + "*" + markup, self.get_parent())
-#        self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
-#        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
         self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
-#        self.progress_box.pack_end(stop_button, expand=False, fill=False)
         self.machine_separator = gtk.HSeparator()
 
     def set_config_machine_layout(self, show_progress_bar = False):
@@ -229,14 +226,15 @@ class ImageConfigurationPage (HobPage):
     def create_config_baseimg(self):
         self.image_title = gtk.Label()
         self.image_title.set_alignment(0, 1.0)
-        mark = "<span %s>Select a base image</span>" % self.span_tag('x-large', 'bold')
+        mark = "<span %s>Select an image recipe</span>" % self.span_tag('x-large', 'bold')
         self.image_title.set_markup(mark)
 
         self.image_title_desc = gtk.Label()
         self.image_title_desc.set_alignment(0, 0.5)
-        mark = ("<span %s>Base images are a starting point for the type of image you want. "
+
+        mark = ("<span %s>Image recipes are a starting point for the type of image you want. "
                 "You can build them as \n"
-                "they are or customize them to your specific needs.\n</span>") % self.span_tag('medium')
+                "they are or edit them to suit your needs.\n</span>") % self.span_tag('medium')
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
@@ -272,15 +270,13 @@ class ImageConfigurationPage (HobPage):
 
         # create button "Build image"
         self.just_bake_button = HobButton("Build image")
-        #self.just_bake_button.set_size_request(205, 49)
-        self.just_bake_button.set_tooltip_text("Build target image")
+        self.just_bake_button.set_tooltip_text("Build the image recipe as it is")
         self.just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(self.just_bake_button, expand=False, fill=False)
 
-        # create button "Edit Image"
-        self.edit_image_button = HobAltButton("Edit image")
-        #self.edit_image_button.set_size_request(205, 49)
-        self.edit_image_button.set_tooltip_text("Edit target image")
+        # create button "Edit image recipe"
+        self.edit_image_button = HobAltButton("Edit image recipe")
+        self.edit_image_button.set_tooltip_text("Customize the recipes and packages to be included in your image")
         self.edit_image_button.connect("clicked", self.edit_image_button_clicked_cb)
         button_box.pack_end(self.edit_image_button, expand=False, fill=False)
 
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 268ac68..4b0e749 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -333,13 +333,18 @@ class ImageDetailsPage (HobPage):
         #    self.kernel_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=change_kernel_button)
         #    self.box_group_area.pack_start(self.kernel_detail, expand=True, fill=True)
 
-        # Machine, Base image and Layers
+        # Machine, Image recipe and Layers
         layer_num_limit = 15
-        varlist = ["Machine: ", "Base image: ", "Layers: "]
+        varlist = ["Machine: ", "Image recipe: ", "Layers: "]
         vallist = []
         self.setting_detail = None
         if self.build_succeeded:
             vallist.append(machine)
+            if base_image == self.builder.recipe_model.__custom_image__:
+                if self.builder.configuration.initial_selected_image == self.builder.recipe_model.__custom_image__:
+                    base_image ="New image recipe"
+                else:
+                    base_image = self.builder.configuration.initial_selected_image + " (edited)"
             vallist.append(base_image)
             i = 0
             for layer in layers:
@@ -359,7 +364,7 @@ class ImageDetailsPage (HobPage):
                 i += 1
 
             edit_config_button = HobAltButton("Edit configuration")
-            edit_config_button.set_tooltip_text("Edit machine, base image and recipes")
+            edit_config_button.set_tooltip_text("Edit machine and image recipe")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
             self.setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
             self.box_group_area.pack_start(self.setting_detail, expand=True, fill=True)
-- 
1.7.9.5


