Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 948806B26A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2013 10:33:35 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 17 Jul 2013 03:31:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,683,1367996400"; d="scan'208";a="366549930"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2013 03:33:35 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Jul 2013 13:35:31 +0300
Message-Id: <1374057344-19708-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
References: <1374057344-19708-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 01/14] hob: labelling changes in Hob
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
X-List-Received-Date: Wed, 17 Jul 2013 10:33:36 -0000

When the design document for templates in Hob was created, we've noticed
that some labels need to change.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    2 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    2 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   16 ++++++----------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |    5 +++++
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8788083..ebcb846 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -174,7 +174,7 @@ class HobHandler(gobject.GObject):
                 targets.append(self.toolchain)
             if targets[0] == "hob-image":
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
-                if self.base_image != "Create your own image":
+                if self.base_image != "Create a new base image":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
                     version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
                     targets[0] += version
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 7f7d82f..f114419 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -476,7 +476,7 @@ class RecipeListModel(gtk.ListStore):
     (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG, COL_INSTALL, COL_PN, COL_FADE_INC, COL_SUMMARY, COL_VERSION,
      COL_REVISION, COL_HOMEPAGE, COL_BUGTRACKER) = range(17)
 
-    __custom_image__ = "Create your own image"
+    __custom_image__ = "Create a new base image"
 
     __gsignals__ = {
         "recipe-selection-changed" : (gobject.SIGNAL_RUN_LAST,
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 1f7453a..d5fc297 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
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
@@ -234,9 +231,10 @@ class ImageConfigurationPage (HobPage):
 
         self.image_title_desc = gtk.Label()
         self.image_title_desc.set_alignment(0, 0.5)
+
         mark = ("<span %s>Base images are a starting point for the type of image you want. "
                 "You can build them as \n"
-                "they are or customize them to your specific needs.\n</span>") % self.span_tag('medium')
+                "they are or edit them to suit your needs.\n</span>") % self.span_tag('medium')
         self.image_title_desc.set_markup(mark)
 
         self.image_combo = gtk.combo_box_new_text()
@@ -270,16 +268,14 @@ class ImageConfigurationPage (HobPage):
         # Create the "Build packages" and "Build image" buttons at the bottom
         button_box = gtk.HBox(False, 6)
 
-        # create button "Build image"
-        self.just_bake_button = HobButton("Build image")
-        #self.just_bake_button.set_size_request(205, 49)
+        # create button "Build base image"
+        self.just_bake_button = HobButton("Build base image")
         self.just_bake_button.set_tooltip_text("Build target image")
         self.just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(self.just_bake_button, expand=False, fill=False)
 
-        # create button "Edit Image"
-        self.edit_image_button = HobAltButton("Edit image")
-        #self.edit_image_button.set_size_request(205, 49)
+        # create button "Edit base image"
+        self.edit_image_button = HobAltButton("Edit base image")
         self.edit_image_button.set_tooltip_text("Edit target image")
         self.edit_image_button.connect("clicked", self.edit_image_button_clicked_cb)
         button_box.pack_end(self.edit_image_button, expand=False, fill=False)
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 268ac68..79ac80b 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -340,6 +340,11 @@ class ImageDetailsPage (HobPage):
         self.setting_detail = None
         if self.build_succeeded:
             vallist.append(machine)
+            if base_image == self.builder.recipe_model.__custom_image__:
+                if self.builder.configuration.initial_selected_image == self.builder.recipe_model.__custom_image__:
+                    base_image ="New base image"
+                else:
+                    base_image = self.builder.configuration.initial_selected_image + " (edited)"
             vallist.append(base_image)
             i = 0
             for layer in layers:
-- 
1.7.9.5


