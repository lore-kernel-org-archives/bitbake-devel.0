Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1UZdFT-0000zS-Cl
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 10:27:51 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 07 May 2013 01:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,627,1363158000"; d="scan'208";a="330104017"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 07 May 2013 01:09:46 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 11:07:56 +0300
Message-Id: <1367914076-4863-5-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
References: <1367914076-4863-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH 4/4] hob: assure consistency for image size label
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
X-List-Received-Date: Tue, 07 May 2013 08:27:57 -0000

After the image was build, update the image size in the packagelistpage.

[YOCTO #4388]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py              |    2 ++
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |    2 ++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   20 ++++++++++++--------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index b347f6d..07118aa 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -108,6 +108,8 @@ class Configuration:
         self.extra_setting = {}
         self.toolchain_build = False
         self.image_fstypes = ""
+        self.image_size = None
+        self.image_packages = []
         # bblayers.conf
         self.layers = []
         # image/recipes/packages
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index d586413..268ac68 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -369,6 +369,8 @@ class ImageDetailsPage (HobPage):
         vallist = []
         vallist.append(pkg_num)
         vallist.append(default_image_size)
+        self.builder.configuration.image_size = default_image_size
+        self.builder.configuration.image_packages = self.builder.configuration.selected_packages
         if self.build_succeeded:
             edit_packages_button = HobAltButton("Edit packages")
             edit_packages_button.set_tooltip_text("Edit the packages included in your image")
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index a4d86bd..0cac92f 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -270,14 +270,17 @@ class PackageSelectionPage (HobPage):
         selected_packages_size = self.package_model.get_packages_size()
         selected_packages_size_str = HobPage._size_to_string(selected_packages_size)
 
-        image_overhead_factor = self.builder.configuration.image_overhead_factor
-        image_rootfs_size = self.builder.configuration.image_rootfs_size / 1024 # image_rootfs_size is KB
-        image_extra_size = self.builder.configuration.image_extra_size / 1024 # image_extra_size is KB
-        base_size = image_overhead_factor * selected_packages_size
-        image_total_size = max(base_size, image_rootfs_size) + image_extra_size
-        if "zypper" in self.builder.configuration.selected_packages:
-            image_total_size += (51200 * 1024)
-        image_total_size_str = HobPage._size_to_string(image_total_size)
+        if self.builder.configuration.image_packages == self.builder.configuration.selected_packages:
+            image_total_size_str = self.builder.configuration.image_size
+        else:
+            image_overhead_factor = self.builder.configuration.image_overhead_factor
+            image_rootfs_size = self.builder.configuration.image_rootfs_size / 1024 # image_rootfs_size is KB
+            image_extra_size = self.builder.configuration.image_extra_size / 1024 # image_extra_size is KB
+            base_size = image_overhead_factor * selected_packages_size
+            image_total_size = max(base_size, image_rootfs_size) + image_extra_size
+            if "zypper" in self.builder.configuration.selected_packages:
+                image_total_size += (51200 * 1024)
+            image_total_size_str = HobPage._size_to_string(image_total_size)
 
         self.label.set_label("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
@@ -297,6 +300,7 @@ class PackageSelectionPage (HobPage):
         self.refresh_selection()
         if not self.builder.customized:
             self.builder.customized = True
+            self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
             self.builder.configuration.selected_image = self.recipe_model.__custom_image__
             self.builder.rcppkglist_populated()
 
-- 
1.7.9.5



