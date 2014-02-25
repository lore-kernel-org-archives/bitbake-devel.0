Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id DF8E06E717
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2014 13:22:43 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 25 Feb 2014 05:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,540,1389772800"; d="scan'208";a="481450520"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2014 05:22:16 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2014 15:30:10 +0200
Message-Id: <1393335012-26237-2-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
References: <y> <1393335012-26237-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 1/3] hob: create a base hob image used to create custom images
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
X-List-Received-Date: Tue, 25 Feb 2014 13:22:44 -0000

In order to remove hob-image.bb from meta-hob, a hob-image.bb should
be created somewhere in the build directory. I've saved it in build/recipes/images
directory, and moved the templates to recipes/images/custom (here are those
templates saved by the user).
The image is created when hob starts. Also it appends to BBFILES the directory
where it is created.

Removed images directory from meta-hob.

[YOCTO #5118]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    3 ++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    9 ++++++++-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 meta-hob/recipes-core/images/hob-image.bb          |    1 -
 5 files changed, 12 insertions(+), 5 deletions(-)
 delete mode 100644 meta-hob/recipes-core/images/hob-image.bb

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 5ae1ddb..1c8469b 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -446,7 +446,8 @@ class Builder(gtk.Window):
         self.handler.connect("recipe-populated",         self.handler_recipe_populated_cb)
         self.handler.connect("package-populated",        self.handler_package_populated_cb)
 
-        self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/*.bb")
+        self.handler.append_to_bbfiles("${TOPDIR}/recipes/images/custom/*.bb")
+        self.handler.generate_hob_base_image()
         self.initiate_new_build_async()
 
         signal.signal(signal.SIGINT, self.event_handle_SIGINT)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 1282070..e848405 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -436,9 +436,16 @@ class HobHandler(gobject.GObject):
         self.run_next_command(self.GENERATE_IMAGE)
 
     def generate_new_image(self, image, base_image, package_queue, description):
-        base_image = self.runCommand(["matchFile", self.base_image + ".bb"])
+        if base_image:
+            base_image = self.runCommand(["matchFile", self.base_image + ".bb"])
         self.runCommand(["generateNewImage", image, base_image, package_queue, False, description])
 
+    def generate_hob_base_image(self):
+        image_dir = self.get_topdir() + "/recipes/images/"
+        self.ensure_dir(image_dir)
+        self.generate_new_image(image_dir+"hob-image.bb", None, [], "")
+        self.append_to_bbfiles(image_dir + "*.bb")
+
     def ensure_dir(self, directory):
         self.runCommand(["ensureDir", directory])
 
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 6372592..c4fd3f7 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -379,7 +379,7 @@ class ImageConfigurationPage (HobPage):
         selected_image = self.image_combo.get_active_text()
         if selected_image == self.__custom_image__:
             topdir = self.builder.get_topdir()
-            images_dir = topdir + "/recipes/images/"
+            images_dir = topdir + "/recipes/images/custom/"
             self.builder.ensure_dir(images_dir)
 
             dialog = RetrieveImageDialog(images_dir, "Select from my image recipes",
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 271635f..352e948 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -632,7 +632,7 @@ class ImageDetailsPage (HobPage):
 
     def save_button_clicked_cb(self, button):
         topdir = self.builder.get_topdir()
-        images_dir = topdir + "/recipes/images/"
+        images_dir = topdir + "/recipes/images/custom/"
         self.builder.ensure_dir(images_dir)
 
         self.name_field_template = self.builder.image_configuration_page.custom_image_selected
diff --git a/meta-hob/recipes-core/images/hob-image.bb b/meta-hob/recipes-core/images/hob-image.bb
deleted file mode 100644
index c8d6f49..0000000
--- a/meta-hob/recipes-core/images/hob-image.bb
+++ /dev/null
@@ -1 +0,0 @@
-inherit image
-- 
1.7.9.5


