Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 092996CA74
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Oct 2013 13:25:25 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Oct 2013 06:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,586,1378882800"; d="scan'208";a="423965542"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by fmsmga002.fm.intel.com with ESMTP; 28 Oct 2013 06:25:25 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Oct 2013 15:30:21 +0200
Message-Id: <1382967021-7783-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: do not display the "Package list may be incomplete!" dialog
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 28 Oct 2013 13:25:26 -0000

This dialog is not needed. Instead "Edit packages" button should
redirect to Packages list.

[YOCTO #5257]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/builder.py          |   21 ++-------------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 171a7a6..1899956 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -423,7 +423,7 @@ class BuildDetailsPage (HobPage):
         if "recipes" in action:
             self.builder.show_recipes()
         elif "packages" in action:
-            self.builder.show_packages(ask=False)
+            self.builder.show_packages()
         elif "image" in action:
             self.builder.show_configuration()
 
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ab6750b..de1458c 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1384,25 +1384,8 @@ class Builder(gtk.Window):
             dialog.run()
             dialog.destroy()
 
-    def show_packages(self, ask=True):
-        _, selected_recipes = self.recipe_model.get_selected_recipes()
-        if selected_recipes and ask:
-            lbl = "<b>Package list may be incomplete!</b>\nDo you want to build selected recipes"
-            lbl = lbl + " to get a full list or just view the existing packages?"
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-            button = dialog.add_button("View packages", gtk.RESPONSE_NO)
-            HobAltButton.style_button(button)
-            button = dialog.add_button("Build packages", gtk.RESPONSE_YES)
-            HobButton.style_button(button)
-            dialog.set_default_response(gtk.RESPONSE_YES)
-            response = dialog.run()
-            dialog.destroy()
-            if response == gtk.RESPONSE_YES:
-                self.generate_packages_async(True)
-            else:
-                self.switch_page(self.PACKAGE_SELECTION)
-        else:
-            self.switch_page(self.PACKAGE_SELECTION)
+    def show_packages(self):
+        self.switch_page(self.PACKAGE_SELECTION)
 
     def show_recipes(self):
         self.switch_page(self.RECIPE_SELECTION)
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index b5d9660..4c86247 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -655,7 +655,7 @@ class ImageDetailsPage (HobPage):
         self.builder.show_configuration()
 
     def edit_packages_button_clicked_cb(self, button):
-        self.builder.show_packages(ask=False)
+        self.builder.show_packages()
 
     def my_images_button_clicked_cb(self, button):
         self.builder.show_load_my_images_dialog()
-- 
1.7.9.5


