Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHFFE-0008W6-Lw
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:07:00 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 09 Apr 2012 06:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151486408"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2012 06:57:43 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:49 +0800
Message-Id: <12ad7292573ede50af811f5c2d636f5a023125bd.1333980506.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 19/21] Hob: forget selected_recipes and selected_packages after users change the machine
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
X-List-Received-Date: Mon, 09 Apr 2012 14:07:00 -0000

The patch is to fix [Yocto #2255]. Now the logic is:

- If users change the machine, the image combo is empty for users to select.
- If users load the template, the image combo should set the value of
  selected_image specified in the template.
- After loading a template, if users change the machine, the selected_image
  specified in the template should be removed from the image combo because
  it is probably invalid for a new machine.
- If users customize the recipe/package list, and change the settings which
  causes reparsing, selected_recipes and selected_packages should be remembered.
- If users add more layers, selected_recipes and selected_packages should be
  remembered.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    1 +
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   26 +++++++++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index afd1d1b..9e2495a 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -598,6 +598,7 @@ class Builder(gtk.Window):
                                             " ".join(selected_packages))
 
         self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
+        self.image_configuration_page.update_image_desc(selected_image)
         self.update_recipe_model(selected_image, selected_recipes)
         self.update_package_model(selected_packages)
 
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index c2e0f5f..2385eb8 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -37,6 +37,10 @@ class ImageConfigurationPage (HobPage):
         super(ImageConfigurationPage, self).__init__(builder, "Image configuration")
 
         self.image_combo_id = None
+        # we use machine_combo_changed_by_manual to identify the machine is changed by code
+        # or by manual. If by manual, all user's recipe selection and package selection are
+        # cleared.
+        self.machine_combo_changed_by_manual = True
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -258,6 +262,13 @@ class ImageConfigurationPage (HobPage):
             return
 
         self.builder.configuration.curr_mach = combo_item
+        if self.machine_combo_changed_by_manual:
+            self.builder.configuration.selected_image = None
+            self.builder.configuration.selected_recipes = []
+            self.builder.configuration.selected_packages = []
+        # reset machine_combo_changed_by_manual
+        self.machine_combo_changed_by_manual = True
+
         # Do reparse recipes
         self.builder.populate_recipe_package_info_async()
 
@@ -271,6 +282,7 @@ class ImageConfigurationPage (HobPage):
         self.machine_combo.set_active(-1)
 
     def switch_machine_combo(self):
+        self.machine_combo_changed_by_manual = False
         model = self.machine_combo.get_model()
         active = 0
         while active < len(model):
@@ -280,6 +292,16 @@ class ImageConfigurationPage (HobPage):
             active += 1
         self.machine_combo.set_active(-1)
 
+    def update_image_desc(self, selected_image):
+        desc = ""
+        if selected_image and selected_image in self.builder.recipe_model.pn_path.keys():
+            image_path = self.builder.recipe_model.pn_path[selected_image]
+            image_iter = self.builder.recipe_model.get_iter(image_path)
+            desc = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC)
+
+        mark = ("<span %s>%s</span>\n") % (self.span_tag('small'), desc)
+        self.image_desc.set_markup(mark)
+
     def image_combo_changed_idle_cb(self, selected_image, selected_recipes, selected_packages):
         self.builder.update_recipe_model(selected_image, selected_recipes)
         self.builder.update_package_model(selected_packages)
@@ -296,9 +318,7 @@ class ImageConfigurationPage (HobPage):
         image_path = self.builder.recipe_model.pn_path[selected_image]
         image_iter = self.builder.recipe_model.get_iter(image_path)
         selected_packages = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_INSTALL).split()
-
-        mark = ("<span %s>%s</span>\n") % (self.span_tag('small'), self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_DESC))
-        self.image_desc.set_markup(mark)
+        self.update_image_desc(selected_image)
 
         self.builder.recipe_model.reset()
         self.builder.package_model.reset()
-- 
1.7.6



