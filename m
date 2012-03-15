Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Ev-00069n-Of
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:53 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 01:32:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="117883775"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 15 Mar 2012 01:32:06 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:56 +0800
Message-Id: <5290d99f4d0f36076c59ec0b59e3f69b04d69ebf.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/12] Hob: Show recipe/package editing button after base image is selected
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:54 -0000

Only show recipe and package editing button after base image is selected.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py                |    9 +++++++--
 lib/bb/ui/crumbs/imageconfigurationpage.py |   14 +++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index c6b1a3d..f52b475 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -136,6 +136,7 @@ class Builder(gtk.Window):
      LAYER_CHANGED,
      RCPPKGINFO_POPULATING,
      RCPPKGINFO_POPULATED,
+     BASEIMG_SELECTED,
      RECIPE_SELECTION,
      PACKAGE_GENERATING,
      PACKAGE_GENERATED,
@@ -145,7 +146,7 @@ class Builder(gtk.Window):
      IMAGE_GENERATED,
      MY_IMAGE_OPENED,
      BACK,
-     END_NOOP) = range(14)
+     END_NOOP) = range(15)
 
     (IMAGE_CONFIGURATION,
      RECIPE_DETAILS,
@@ -159,6 +160,7 @@ class Builder(gtk.Window):
         LAYER_CHANGED         : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATING : IMAGE_CONFIGURATION,
         RCPPKGINFO_POPULATED  : IMAGE_CONFIGURATION,
+        BASEIMG_SELECTED      : IMAGE_CONFIGURATION,
         RECIPE_SELECTION      : RECIPE_DETAILS,
         PACKAGE_GENERATING    : BUILD_DETAILS,
         PACKAGE_GENERATED     : PACKAGE_DETAILS,
@@ -309,6 +311,9 @@ class Builder(gtk.Window):
         elif next_step == self.RCPPKGINFO_POPULATED:
             self.image_configuration_page.show_info_populated()
 
+        elif next_step == self.BASEIMG_SELECTED:
+            self.image_configuration_page.show_baseimg_selected()
+
         elif next_step == self.RECIPE_SELECTION:
             pass
 
@@ -828,7 +833,7 @@ class Builder(gtk.Window):
         self.switch_page(self.MACHINE_SELECTION)
 
     def show_configuration(self):
-        self.switch_page(self.RCPPKGINFO_POPULATED)
+        self.switch_page(self.BASEIMG_SELECTED)
 
     def stop_build(self):
         if self.stopping:
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 3b1201e..f386281 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -109,9 +109,17 @@ class ImageConfigurationPage (HobPage):
 
     def show_info_populated(self):
         self.progress_bar.reset()
+        self._pack_components(pack_config_build_button = False)
+        self.set_config_machine_layout(show_progress_bar = False)
+        self.set_config_baseimg_layout()
+        self.show_all()
+
+    def show_baseimg_selected(self):
+        self.progress_bar.reset()
         self._pack_components(pack_config_build_button = True)
         self.set_config_machine_layout(show_progress_bar = False)
         self.set_config_baseimg_layout()
+        self.set_rcppkg_layout()
         self.show_all()
 
     def create_config_machine(self):
@@ -196,9 +204,11 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.image_title_desc, 0, 40, 17, 22)
         self.gtable.attach(self.image_combo, 0, 12, 22, 25)
         self.gtable.attach(self.image_desc, 14, 38, 22, 27)
+        self.gtable.attach(self.image_separator, 0, 40, 35, 36)
+
+    def set_rcppkg_layout(self):
         self.gtable.attach(self.view_recipes_button, 0, 20, 28, 32)
         self.gtable.attach(self.view_packages_button, 20, 40, 28, 32)
-        self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
@@ -280,6 +290,8 @@ class ImageConfigurationPage (HobPage):
         self.builder.recipe_model.reset()
         self.builder.package_model.reset()
 
+        self.show_baseimg_selected()
+
         glib.idle_add(self.image_combo_changed_idle_cb, selected_image, selected_recipes, selected_packages)
 
     def _image_combo_connect_signal(self):
-- 
1.7.4.1



