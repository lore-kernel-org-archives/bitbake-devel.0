Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kEG-0005Is-G0
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:10:05 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113065934"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:01:34 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:09 +0800
Message-Id: <6caf36f36f6f49c49b1e26d51fe58d377a9e45bf.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 12/32] Hob: enable indicators on the "Included" tab in the recipe selection page and the package selection page
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
X-List-Received-Date: Wed, 29 Feb 2012 14:10:05 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    1 +
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index dab90ec..5459743 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -186,6 +186,7 @@ class PackageSelectionPage (HobPage):
 
         self.label.set_text("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
+        self.ins.show_indicator_icon("Included", selected_packages_num)
 
     """
     Helper function to convert the package size to string format.
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 416c613..8423714 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -190,6 +190,7 @@ class RecipeSelectionPage (HobPage):
         self.builder.configuration.selected_image = self.recipe_model.get_selected_image()
         _, self.builder.configuration.selected_recipes = self.recipe_model.get_selected_recipes()
         self.label.set_text("Recipes included: %s" % len(self.builder.configuration.selected_recipes))
+        self.ins.show_indicator_icon("Included", len(self.builder.configuration.selected_recipes))
 
     # Callback functions
     def reset_clicked_cb(self, button):
-- 
1.7.6



