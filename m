Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF8u-0008Kw-JH
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:00:28 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Apr 2012 06:51:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151485066"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2012 06:51:11 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:40 +0800
Message-Id: <b07f24ba2fde9906cef4f5a946c9eeab03da79cf.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 10/21] Hob: clean up and unify the steps for IMAGE_GENERATING to call generate_image_async()
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
X-List-Received-Date: Mon, 09 Apr 2012 14:00:28 -0000

For the steps in IMAGE_GENERATING, the patch consolidates them into
generate_image_async() to call.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 8a95b94..959d8c1 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -361,6 +361,20 @@ class Builder(gtk.Window):
         self.handler.reset_build()
         self.handler.generate_packages(all_recipes)
 
+    def generate_image_async(self):
+        self.switch_page(self.IMAGE_GENERATING)
+        # Build image
+        self.set_user_config()
+        packages = self.package_model.get_selected_packages()
+        toolchain_packages = []
+        if self.configuration.toolchain_build:
+            toolchain_packages = self.package_model.get_selected_packages_toolchain()
+        self.handler.reset_build()
+        self.handler.generate_image(packages,
+                                    self.hob_image,
+                                    self.hob_toolchain,
+                                    toolchain_packages)
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -426,7 +440,6 @@ class Builder(gtk.Window):
             # after packages are generated, selected_packages need to
             # be updated in package_model per selected_image in recipe_model
             self.build_details_page.show_page(next_step)
-            self.generate_image()
 
         elif next_step == self.IMAGE_GENERATED:
             self.image_details_page.show_page(next_step)
@@ -475,19 +488,6 @@ class Builder(gtk.Window):
         left = self.package_model.set_selected_packages(selected_packages)
         self.configuration.selected_packages += left
 
-    def generate_image(self):
-        # Build image
-        self.set_user_config()
-        packages = self.package_model.get_selected_packages()
-        toolchain_packages = []
-        if self.configuration.toolchain_build:
-            toolchain_packages = self.package_model.get_selected_packages_toolchain()
-        self.handler.reset_build()
-        self.handler.generate_image(packages,
-                                    self.hob_image,
-                                    self.hob_toolchain,
-                                    toolchain_packages)
-
     # Callback Functions
     def handler_config_updated_cb(self, handler, which, values):
         if which == "distro":
@@ -526,7 +526,7 @@ class Builder(gtk.Window):
 
             self.rcppkglist_populated()
             if self.current_step == self.FAST_IMAGE_GENERATING:
-                self.switch_page(self.IMAGE_GENERATING)
+                self.generate_image_async()
             elif self.current_step == self.PACKAGE_GENERATING:
                 self.switch_page(self.PACKAGE_GENERATED)
             elif self.current_step == self.IMAGE_GENERATING:
@@ -758,7 +758,7 @@ class Builder(gtk.Window):
             dialog.run()
             dialog.destroy()
             return
-        self.switch_page(self.IMAGE_GENERATING)
+        self.generate_image_async()
 
     def just_bake(self):
         selected_image = self.recipe_model.get_selected_image()
-- 
1.7.6



