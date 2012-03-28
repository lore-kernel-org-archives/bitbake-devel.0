Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvam-0005xg-V2
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:25 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 28 Mar 2012 09:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="134115142"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2012 09:10:21 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:54 +0800
Message-Id: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
Subject: [PATCH 1/5] Hob: add Templates and Settings on image details screen
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:25 -0000

This patch is to add Templates and Settings tool buttons on the image details screen, which makes things easier and simplier.
In order to fulfill that, the code splits the functions show_load_template_dialog() and show_adv_settings_dialog() in builder.py because they will possibly be called from different screens later.

[Yocto #2163]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   19 ++++++++-----
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   12 +++++++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   29 ++++++++++++++++++++
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2af14dc..1a06dd7 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -757,10 +757,11 @@ class Builder(gtk.Window):
         dialog.add_filter(filter)
 
         response = dialog.run()
+        path = None
         if response == gtk.RESPONSE_YES:
             path = dialog.get_filename()
-            self.load_template(path)
         dialog.destroy()
+        return response == gtk.RESPONSE_YES, path
 
     def show_save_template_dialog(self):
         dialog = gtk.FileChooserDialog("Save Template Files", self,
@@ -820,16 +821,20 @@ class Builder(gtk.Window):
         button = dialog.add_button("Save", gtk.RESPONSE_YES)
         HobButton.style_button(button)
         response = dialog.run()
+        settings_changed = False
         if response == gtk.RESPONSE_YES:
             self.parameters.enable_proxy = dialog.enable_proxy
             self.configuration = dialog.configuration
-            # DO reparse recipes
-            if dialog.settings_changed:
-                if self.configuration.curr_mach == "":
-                    self.switch_page(self.MACHINE_SELECTION)
-                else:
-                    self.switch_page(self.RCPPKGINFO_POPULATING)
+            settings_changed = dialog.settings_changed
         dialog.destroy()
+        return response == gtk.RESPONSE_YES, settings_changed
+
+    def reparse_post_adv_settings(self):
+        # DO reparse recipes
+        if self.configuration.curr_mach == "":
+            self.switch_page(self.MACHINE_SELECTION)
+        else:
+            self.switch_page(self.RCPPKGINFO_POPULATING)
 
     def deploy_image(self, image_name):
         if not image_name:
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index d7437a9..9ad1ea4 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -360,11 +360,19 @@ class ImageConfigurationPage (HobPage):
         self.builder.build_packages()
 
     def template_button_clicked_cb(self, button):
-        self.builder.show_load_template_dialog()
+        response, path = self.builder.show_load_template_dialog()
+        if not response:
+            return
+        if path:
+            self.builder.load_template(path)
 
     def my_images_button_clicked_cb(self, button):
         self.builder.show_load_my_images_dialog()
 
     def settings_button_clicked_cb(self, button):
         # Create an advanced settings dialog
-        self.builder.show_adv_settings_dialog()
+        response, settings_changed = self.builder.show_adv_settings_dialog()
+        if not response:
+            return
+        if settings_changed:
+            self.builder.reparse_post_adv_settings()
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 7d06124..f15aad3 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -122,12 +122,24 @@ class ImageDetailsPage (HobPage):
         self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
         self.toolbar.set_style(gtk.TOOLBAR_BOTH)
 
+        template_button = self.append_toolbar_button(self.toolbar,
+            "Templates",
+            hic.ICON_TEMPLATES_DISPLAY_FILE,
+            hic.ICON_TEMPLATES_HOVER_FILE,
+            "Load a hob building template saved before",
+            self.template_button_clicked_cb)
         my_images_button = self.append_toolbar_button(self.toolbar,
             "My images",
             hic.ICON_IMAGES_DISPLAY_FILE,
             hic.ICON_IMAGES_HOVER_FILE,
             "Open images built out previously for running or deployment",
             self.my_images_button_clicked_cb)
+        settings_button = self.append_toolbar_button(self.toolbar,
+            "Settings",
+            hic.ICON_SETTINGS_DISPLAY_FILE,
+            hic.ICON_SETTINGS_HOVER_FILE,
+            "Other advanced settings for build",
+            self.settings_button_clicked_cb)
 
         self.details_top_buttons = self.add_onto_top_bar(self.toolbar)
 
@@ -386,5 +398,22 @@ class ImageDetailsPage (HobPage):
     def edit_packages_button_clicked_cb(self, button):
         self.builder.show_packages(ask=False)
 
+    def template_button_clicked_cb(self, button):
+        response, path = self.builder.show_load_template_dialog()
+        if not response:
+            return
+        self.builder.initiate_new_build()
+        if path:
+            self.builder.load_template(path)
+
     def my_images_button_clicked_cb(self, button):
         self.builder.show_load_my_images_dialog()
+
+    def settings_button_clicked_cb(self, button):
+        # Create an advanced settings dialog
+        response, settings_changed = self.builder.show_adv_settings_dialog()
+        if not response:
+            return
+        self.builder.initiate_new_build()
+        if settings_changed:
+            self.builder.reparse_post_adv_settings()
-- 
1.7.6



