Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <constantinx.musca@intel.com>) id 1TIeqk-0004S3-UE
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Oct 2012 14:11:51 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Oct 2012 04:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,515,1344236400"; d="scan'208";a="229034847"
Received: from costin-desktop (HELO localhost.localdomain) ([10.237.105.66])
	by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2012 04:57:47 -0700
From: Constantin Musca <constantinx.musca@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2012 14:03:22 +0300
Message-Id: <1349089402-13747-1-git-send-email-constantinx.musca@intel.com>
X-Mailer: git-send-email 1.7.9.5
Cc: Constantin Musca <constantinx.musca@intel.com>
Subject: [PATCH] hob: Fix 'User selected' tag functionality
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
X-List-Received-Date: Mon, 01 Oct 2012 12:11:51 -0000

- the 'User selected' tag is only used when the user
selects a package
- fix hob to remember which packages are 'User selected'
- if the package is already brought in by some other package,
it should not appear as 'User selected'

[YOCTO #3108]

Signed-off-by: Constantin Musca <constantinx.musca@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py      |   11 +++++++++--
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    8 ++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index fd555b0..6ddc5b6 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -127,6 +127,7 @@ class Configuration:
         self.selected_recipes = []
         self.selected_packages = []
         self.initial_selected_packages = []
+        self.initial_user_selected_packages = []
 
     def split_proxy(self, protocol, proxy):
         entry = []
@@ -576,6 +577,7 @@ class Builder(gtk.Window):
         self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
     def restore_initial_selected_packages(self):
+        self.package_model.set_selected_packages(self.configuration.initial_user_selected_packages, True)
         self.package_model.set_selected_packages(self.configuration.initial_selected_packages)
         for package in self.configuration.selected_packages:
             if package not in self.configuration.initial_selected_packages:
@@ -709,6 +711,7 @@ class Builder(gtk.Window):
 
         elif next_step == self.PACKAGE_SELECTION:
             self.configuration.initial_selected_packages = self.configuration.selected_packages
+            self.configuration.initial_user_selected_packages = self.configuration.user_selected_packages
             self.package_details_page.set_title("Edit packages")
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
@@ -782,7 +785,10 @@ class Builder(gtk.Window):
         self.recipe_model.set_selected_image(selected_image)
         self.recipe_model.set_selected_recipes(selected_recipes)
 
-    def update_package_model(self, selected_packages):
+    def update_package_model(self, selected_packages, user_selected_packages=None):
+        if user_selected_packages:
+            left = self.package_model.set_selected_packages(user_selected_packages, True)
+            self.configuration.user_selected_packages += left
         left = self.package_model.set_selected_packages(selected_packages)
         self.configuration.selected_packages += left
 
@@ -924,11 +930,12 @@ class Builder(gtk.Window):
         selected_image = self.configuration.selected_image
         selected_recipes = self.configuration.selected_recipes[:]
         selected_packages = self.configuration.selected_packages[:]
+        user_selected_packages = self.configuration.user_selected_packages[:]
 
         self.image_configuration_page.update_image_combo(self.recipe_model, selected_image)
         self.image_configuration_page.update_image_desc()
         self.update_recipe_model(selected_image, selected_recipes)
-        self.update_package_model(selected_packages)
+        self.update_package_model(selected_packages, user_selected_packages)
 
     def recipelist_changed_cb(self, recipe_model):
         self.recipe_details_page.refresh_selection()
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index fe58adf..3885319 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -337,13 +337,13 @@ class PackageListModel(gtk.TreeStore):
     set_selected_packages(), some packages will not be set included.
     Return the un-set packages list.
     """
-    def set_selected_packages(self, packagelist):
+    def set_selected_packages(self, packagelist, user_selected=False):
         left = []
+        binb = 'User Selected' if user_selected else ''
         for pn in packagelist:
             if pn in self.pkg_path.keys():
                 path = self.pkg_path[pn]
-                self.include_item(item_path=path,
-                                  binb="User Selected")
+                self.include_item(item_path=path, binb=binb)
             else:
                 left.append(pn)
 
@@ -359,7 +359,7 @@ class PackageListModel(gtk.TreeStore):
             while child_it:
                 if self.get_value(child_it, self.COL_INC):
                     binb = self.get_value(child_it, self.COL_BINB)
-                    if not binb or binb == "User Selected":
+                    if binb == "User Selected":
                         name = self.get_value(child_it, self.COL_NAME)
                         packagelist.append(name)
                 child_it = self.iter_next(child_it)
-- 
1.7.9.5



