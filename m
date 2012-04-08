Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGp2d-0004cC-Na
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:08:15 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 Apr 2012 02:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="139106062"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2012 02:58:55 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:11 +0800
Message-Id: <b39b4c6c802019a81db8a729defe320b64e57712.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 08/20] Hob: clean up and unify the steps for RCPPKGINFO_POPULATING to call populate_recipe_package_info_async()
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
X-List-Received-Date: Sun, 08 Apr 2012 10:08:15 -0000

For the steps in RCPPKGINFO_POPULATING, This patch consolidates them into
populate_recipe_package_info_async() to call.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   14 +++++++-------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6b8e9f3..a0ad5a0 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -339,6 +339,12 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.parse_generate_configuration()
 
+    def populate_recipe_package_info_async(self):
+        self.switch_page(self.RCPPKGINFO_POPULATING)
+        # Parse recipes
+        self.set_user_config()
+        self.handler.generate_recipes()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -380,7 +386,6 @@ class Builder(gtk.Window):
             # MACHINE CHANGED action or SETTINGS CHANGED
             # show the progress bar
             self.image_configuration_page.show_info_populating()
-            self.generate_recipes()
 
         elif next_step == self.RCPPKGINFO_POPULATED:
             self.image_configuration_page.show_info_populated()
@@ -462,11 +467,6 @@ class Builder(gtk.Window):
         self.handler.reset_build()
         self.handler.generate_packages(all_recipes)
 
-    def generate_recipes(self):
-        # Parse recipes
-        self.set_user_config()
-        self.handler.generate_recipes()
-
     def generate_image(self):
         # Build image
         self.set_user_config()
@@ -885,7 +885,7 @@ class Builder(gtk.Window):
         if not self.configuration.curr_mach:
             self.update_config_async()
         else:
-            self.switch_page(self.RCPPKGINFO_POPULATING)
+            self.populate_recipe_package_info_async()
 
     def deploy_image(self, image_name):
         if not image_name:
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index d8cb752..204d1c6 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -259,7 +259,7 @@ class ImageConfigurationPage (HobPage):
 
         self.builder.configuration.curr_mach = combo_item
         # Do reparse recipes
-        self.builder.switch_page(self.builder.RCPPKGINFO_POPULATING)
+        self.builder.populate_recipe_package_info_async()
 
     def update_machine_combo(self):
         all_machines = self.builder.parameters.all_machines
-- 
1.7.6



