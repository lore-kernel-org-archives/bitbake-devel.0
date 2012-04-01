Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJrB-00045X-Pd
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:26:05 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 01 Apr 2012 05:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="84032729"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 01 Apr 2012 05:16:59 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:17 +0800
Message-Id: <ee2f10ed2092ed21c7f8a0798c18404fdb30063a.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333269705.git.dongxiao.xu@intel.com>
References: <cover.1333269705.git.dongxiao.xu@intel.com>
Subject: [PATCH 09/10] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Sun, 01 Apr 2012 12:26:06 -0000

Once user did customization to his base image, we change the base image
to be "Create your own image" to avoid some issues caused by the
relationship between base image and its default recipes and packages.

This fixes [YOCTO #2211]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py                |    3 +++
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 ++
 lib/bb/ui/crumbs/packageselectionpage.py   |    6 ++++++
 lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +++++
 4 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 8427623..20d4652 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -258,6 +258,9 @@ class Builder(gtk.Window):
         self.recipe_model = recipe_model
         self.package_model = package_model
 
+        # Indicate whether user has customized the image
+        self.customized = False
+
         # create visual elements
         self.create_visual_elements()
 
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 9271c48..d3cae9d 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -289,6 +289,8 @@ class ImageConfigurationPage (HobPage):
         if not selected_image:
             return
 
+        self.builder.customized = False
+
         selected_recipes = []
 
         image_path = self.builder.recipe_model.pn_path[selected_image]
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index d855e58..e071b07 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -90,6 +90,7 @@ class PackageSelectionPage (HobPage):
         super(PackageSelectionPage, self).__init__(builder, "Packages")
 
         # set invisiable members
+        self.recipe_model = self.builder.recipe_model
         self.package_model = self.builder.package_model
 
         # create visual elements
@@ -193,6 +194,11 @@ class PackageSelectionPage (HobPage):
             self.package_model.exclude_item(item_path=path)
 
         self.refresh_selection()
+        if not self.builder.customized:
+            self.builder.customized = True
+            self.builder.configuration.selected_image = self.recipe_model.__dummy_image__
+            self.builder.rcppkglist_populated()
+
         self.builder.window_sensitive(True)
 
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index e4616a8..2d438d5 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -187,6 +187,11 @@ class RecipeSelectionPage (HobPage):
             self.recipe_model.exclude_item(item_path=path)
 
         self.refresh_selection()
+        if not self.builder.customized:
+            self.builder.customized = True
+            self.builder.configuration.selected_image = self.recipe_model.__dummy_image__
+            self.builder.rcppkglist_populated()
+
         self.builder.window_sensitive(True)
 
     def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
-- 
1.7.4.1



