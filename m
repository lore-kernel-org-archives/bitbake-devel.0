Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TB3cv-0007dd-JV
	for bitbake-devel@lists.openembedded.org;
	Mon, 10 Sep 2012 15:02:09 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 10 Sep 2012 05:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,398,1344236400"; d="scan'208";a="190870313"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 10 Sep 2012 05:49:31 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Sep 2012 15:49:57 +0300
Message-Id: <1347281397-15677-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/packageselectionpage: restore selected packages
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
X-List-Received-Date: Mon, 10 Sep 2012 13:02:09 -0000

After "Cancel" action, selected packages are restored to default.

[YOCTO #2984]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py              |    2 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 833577f..18261c2 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -660,6 +660,7 @@ class Builder(gtk.Window):
                 self.recipe_details_page.set_recipe_curr_tab(self.recipe_details_page.INCLUDED)
 
         elif next_step == self.PACKAGE_SELECTION:
+            self.configuration.initial_selected_packages = self.configuration.selected_packages
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
             else:
@@ -672,7 +673,6 @@ class Builder(gtk.Window):
             self.build_details_page.show_page(next_step)
 
         elif next_step == self.PACKAGE_GENERATED:
-            self.configuration.initial_selected_packages = self.configuration.selected_packages
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
             else:
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index c73697b..e3d35ef 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -187,12 +187,11 @@ class PackageSelectionPage (HobPage):
         self.builder.build_image()
 
     def back_button_clicked_cb(self, button):
-        self.builder.restore_initial_selected_packages()
-        self.refresh_selection()
-
         if self.builder.current_step ==  self.builder.PACKAGE_GENERATED:
             self.builder.show_recipes()
         elif self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
+            self.builder.restore_initial_selected_packages()
+            self.refresh_selection()
             self.builder.show_image_details()
 
     def _expand_all(self):
-- 
1.7.9.5



