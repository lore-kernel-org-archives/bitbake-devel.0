Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SWfgO-0007Q3-Qt
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 05:22:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 21 May 2012 20:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="155467237"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 21 May 2012 20:12:39 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 May 2012 11:08:35 +0800
Message-Id: <ccffe5d313f12b319ad29b00cd1418fa5fcb26c8.1337655950.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1337655950.git.dongxiao.xu@intel.com>
References: <cover.1337655950.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1337655950.git.dongxiao.xu@intel.com>
References: <cover.1337655950.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/2] Hob: Get image name internally when updating the image description
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
X-List-Received-Date: Tue, 22 May 2012 03:22:49 -0000

The image name shouldn't be passed from outside caller, since the image
name may not in the combobox list. Getting the name from
update_image_desc() internally.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py                |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index a4fb5eb..d78b17c 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -692,7 +692,7 @@ class Builder(gtk.Window):
         selected_packages = self.configuration.selected_packages[:]
 
         self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
-        self.image_configuration_page.update_image_desc(selected_image)
+        self.image_configuration_page.update_image_desc()
         self.update_recipe_model(selected_image, selected_recipes)
         self.update_package_model(selected_packages)
 
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 20a398c..c33474b 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -292,8 +292,9 @@ class ImageConfigurationPage (HobPage):
             active += 1
         self.machine_combo.set_active(-1)
 
-    def update_image_desc(self, selected_image):
+    def update_image_desc(self):
         desc = ""
+        selected_image = self.image_combo.get_active_text()
         if selected_image and selected_image in self.builder.recipe_model.pn_path.keys():
             image_path = self.builder.recipe_model.pn_path[selected_image]
             image_iter = self.builder.recipe_model.get_iter(image_path)
@@ -320,7 +321,7 @@ class ImageConfigurationPage (HobPage):
         image_path = self.builder.recipe_model.pn_path[selected_image]
         image_iter = self.builder.recipe_model.get_iter(image_path)
         selected_packages = self.builder.recipe_model.get_value(image_iter, self.builder.recipe_model.COL_INSTALL).split()
-        self.update_image_desc(selected_image)
+        self.update_image_desc()
 
         self.builder.recipe_model.reset()
         self.builder.package_model.reset()
-- 
1.7.4.1



