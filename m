Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TMeYh-0001lc-21
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Oct 2012 14:41:43 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 12 Oct 2012 05:28:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,576,1344236400"; d="scan'208";a="203706184"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 12 Oct 2012 05:28:28 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Oct 2012 15:29:46 +0300
Message-Id: <1350044986-21937-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: change behavior for "cancel" button from the Recipe selection page
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
X-List-Received-Date: Fri, 12 Oct 2012 12:41:43 -0000

-when returned to the Image configuration page, after canceling on the
Recipe selection page, the image selected previously is now shown corectly

[YOCTO #3205}
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    1 +
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    1 +
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    3 +++
 3 files changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6ddc5b6..7a30b7c 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -126,6 +126,7 @@ class Configuration:
         self.selected_image = None
         self.selected_recipes = []
         self.selected_packages = []
+        self.initial_selected_image = None
         self.initial_selected_packages = []
         self.initial_user_selected_packages = []
 
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 8988df0..cbef85a 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -432,6 +432,7 @@ class ImageConfigurationPage (HobPage):
         self.builder.just_bake()
 
     def edit_image_button_clicked_cb(self, button):
+        self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
         self.builder.show_recipes()
 
     def template_button_clicked_cb(self, button):
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 8655c29..79c7790 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -193,6 +193,9 @@ class RecipeSelectionPage (HobPage):
         self.builder.build_packages()
 
     def back_button_clicked_cb(self, button):
+        self.builder.recipe_model.set_selected_image(self.builder.configuration.initial_selected_image)
+        self.builder.image_configuration_page.update_image_combo(self.builder.recipe_model, self.builder.configuration.initial_selected_image)
+        self.builder.image_configuration_page.update_image_desc()
         self.builder.show_configuration()
 
     def refresh_selection(self):
-- 
1.7.9.5



