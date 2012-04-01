Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SELNN-0005wU-1w
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 16:03:25 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 01 Apr 2012 06:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127514736"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 01 Apr 2012 06:54:18 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 22:21:39 +0800
Message-Id: <117e6e804f78fda6fd8c57e2f9ef3ce0b540e7b9.1333289684.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333289684.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333289684.git.shane.wang@intel.com>
In-Reply-To: <cover.1333289684.git.shane.wang@intel.com>
References: <cover.1333289684.git.shane.wang@intel.com>
Subject: [PATCH 3/7] Hob: unify _size_to_string() and _string_to_size()
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
X-List-Received-Date: Sun, 01 Apr 2012 14:03:25 -0000

We call intsize_to_string (and string_to_intsize) in 3 different places.
We unify the implementations into one place.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |   18 +++-------
 bitbake/lib/bb/ui/crumbs/hobpages.py             |   39 ++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   11 +-----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   21 +++---------
 4 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index a09c7c7..7587adc 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -22,6 +22,7 @@
 
 import gtk
 import gobject
+from bb.ui.crumbs.hobpages import HobPage
 
 #
 # PackageListModel
@@ -175,10 +176,8 @@ class PackageListModel(gtk.TreeStore):
             if pkgsize == "0" and not allow_empty:
                 continue
 
-            if len(pkgsize) > 3:
-                size = '%.1f' % (int(pkgsize)*1.0/1024) + ' MB'
-            else:
-                size = pkgsize + ' KB'
+            # pkgsize is in KB
+            size = HobPage._size_to_string(HobPage._string_to_size(pkgsize + ' KB'))
 
             it = self.append(pniter)
             self.pkg_path[pkg] = self.get_path(it)
@@ -358,7 +357,7 @@ class PackageListModel(gtk.TreeStore):
         return packagelist
 
     """
-    Return the selected package size, unit is KB.
+    Return the selected package size, unit is B.
     """
     def get_packages_size(self):
         packages_size = 0
@@ -371,16 +370,11 @@ class PackageListModel(gtk.TreeStore):
                     if not str_size:
                         continue
 
-                    unit = str_size.split()
-                    if unit[1] == 'MB':
-                        size = float(unit[0])*1024
-                    else:
-                        size = float(unit[0])
-                    packages_size += size
+                    packages_size += HobPage._string_to_size(str_size)
 
                 child_it = self.iter_next(child_it)
             it = self.iter_next(it)
-        return "%f" % packages_size
+        return packages_size
 
     """
     Empty self.contents by setting the include of each entry to None
diff --git a/bitbake/lib/bb/ui/crumbs/hobpages.py b/bitbake/lib/bb/ui/crumbs/hobpages.py
index d8e59c4..5045ea2 100755
--- a/bitbake/lib/bb/ui/crumbs/hobpages.py
+++ b/bitbake/lib/bb/ui/crumbs/hobpages.py
@@ -83,3 +83,42 @@ class HobPage (gtk.VBox):
         tip_text = tip
         button = toolbar.append_item(buttonname, tip, None, icon, cb)
         return button
+
+    @staticmethod
+    def _size_to_string(size):
+        try:
+            if not size:
+                size_str = "0 B"
+            else:
+                if len(str(int(size))) > 6:
+                    size_str = '%.1f' % (size*1.0/(1024*1024)) + ' MB'
+                elif len(str(int(size))) > 3:
+                    size_str = '%.1f' % (size*1.0/1024) + ' KB'
+                else:
+                    size_str = str(size) + ' B'
+        except:
+            size_str = "0 B"
+        return size_str
+
+    @staticmethod
+    def _string_to_size(str_size):
+        try:
+            if not str_size:
+                size = 0
+            else:
+                unit = str_size.split()
+                if len(unit) > 1:
+                    if unit[1] == 'MB':
+                        size = float(unit[0])*1024*1024
+                    elif unit[1] == 'KB':
+                        size = float(unit[0])*1024
+                    elif unit[1] == 'B':
+                        size = float(unit[0])
+                    else:
+                        size = 0
+                else:
+                    size = float(unit[0])
+        except:
+            size = 0
+        return size
+
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index b70440d..a5d0ad8 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -151,15 +151,6 @@ class ImageDetailsPage (HobPage):
         for child in children:
             self.box_group_area.remove(child)
 
-    def _size_to_string(self, size):
-        if len(str(int(size))) > 6:
-            size_str = '%.1f' % (size*1.0/(1024*1024)) + ' MB'
-        elif len(str(int(size))) > 3:
-            size_str = '%.1f' % (size*1.0/1024) + ' KB'
-        else:
-            size_str = str(size) + ' B'
-        return size_str
-
     def show_page(self, step):
         build_succeeded = (step == self.builder.IMAGE_GENERATED)
         image_addr = self.builder.parameters.image_addr
@@ -200,7 +191,7 @@ class ImageDetailsPage (HobPage):
         default_toggled = False
         default_image_size = 0
         for image_name in image_names:
-            image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
+            image_size = HobPage._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
             if not default_toggled:
                 default_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
                     or self.test_deployable(image_name)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index d855e58..0bb7fe3 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -161,31 +161,20 @@ class PackageSelectionPage (HobPage):
 
         self.builder.configuration.selected_packages = self.package_model.get_selected_packages()
         selected_packages_num = len(self.builder.configuration.selected_packages)
-        selected_packages_size = float(self.package_model.get_packages_size())
-        selected_packages_size_str = self._size_to_string(selected_packages_size)
+        selected_packages_size = self.package_model.get_packages_size()
+        selected_packages_size_str = HobPage._size_to_string(selected_packages_size)
 
         image_overhead_factor = self.builder.configuration.image_overhead_factor
-        image_rootfs_size = self.builder.configuration.image_rootfs_size
-        image_extra_size = self.builder.configuration.image_extra_size
+        image_rootfs_size = self.builder.configuration.image_rootfs_size * 1024 # image_rootfs_size is KB
+        image_extra_size = self.builder.configuration.image_extra_size * 1024 # image_extra_size is KB
         base_size = image_overhead_factor * selected_packages_size
         image_total_size = max(base_size, image_rootfs_size) + image_extra_size
-        image_total_size_str = self._size_to_string(image_total_size)
+        image_total_size_str = HobPage._size_to_string(image_total_size)
 
         self.label.set_text("Packages included: %s\nSelected packages size: %s\nTotal image size: %s" %
                             (selected_packages_num, selected_packages_size_str, image_total_size_str))
         self.ins.show_indicator_icon("Included", selected_packages_num)
 
-    """
-    Helper function to convert the package size to string format.
-    The unit of size is KB
-    """
-    def _size_to_string(self, size):
-        if len(str(int(size))) > 3:
-            size_str = '%.1f' % (size*1.0/1024) + ' MB'
-        else:
-            size_str = str(size) + ' KB'
-        return size_str
-
     def toggle_item_idle_cb(self, path):
         if not self.package_model.path_included(path):
             self.package_model.include_item(item_path=path, binb="User Selected")
-- 
1.7.6



