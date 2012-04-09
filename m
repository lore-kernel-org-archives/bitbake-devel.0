Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMM-00076S-Cz
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:02 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 09 Apr 2012 01:44:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="130225456"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 09 Apr 2012 01:44:44 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:41:57 +0800
Message-Id: <dd78b73c5af03552bc63a118f5a8b0e26709b321.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/6] Hob: Change base image to "Create your own image" if customized
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:02 -0000

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
index a3410d4..bc7e610 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -272,6 +272,9 @@ class Builder(gtk.Window):
         self.recipe_model = recipe_model
         self.package_model = package_model
 
+        # Indicate whether user has customized the image
+        self.customized = False
+
         # create visual elements
         self.create_visual_elements()
 
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index d8cb752..5c2539d 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -291,6 +291,8 @@ class ImageConfigurationPage (HobPage):
         if not selected_image:
             return
 
+        self.builder.customized = False
+
         selected_recipes = []
 
         image_path = self.builder.recipe_model.pn_path[selected_image]
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 7926636..dd0df25 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -90,6 +90,7 @@ class PackageSelectionPage (HobPage):
         super(PackageSelectionPage, self).__init__(builder, "Packages")
 
         # set invisiable members
+        self.recipe_model = self.builder.recipe_model
         self.package_model = self.builder.package_model
 
         # create visual elements
@@ -183,6 +184,11 @@ class PackageSelectionPage (HobPage):
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



