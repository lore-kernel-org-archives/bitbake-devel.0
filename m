Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCAiC-0008Fp-2D
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 16:15:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Mar 2012 07:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123336899"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 26 Mar 2012 07:06:57 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 22:33:05 +0800
Message-Id: <eee2635181e81fe8774fb5e1f2122e83d972b3b9.1332772309.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1332772309.git.shane.wang@intel.com>
References: <cover.1332772309.git.shane.wang@intel.com>
Subject: [PATCH 1/2] Hob: Set one of deployable images or runnable images as the default toggled item
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
X-List-Received-Date: Mon, 26 Mar 2012 14:15:57 -0000

With this patch, even though there are a lot of images built out, a default image which is either deployable or runnable is toggled by default. So, for users, one more action to select an image before running qemu or deploying is not needed any more.

Note: If there are more than one runnable or deployable images (such as ext2, ext3, jffs2 and btrfs), only the first image is toggled by default for run-qemu or deployment. If the user wants to run or deploy others, he/she needs to toggle them manually.

[Yocto #2155]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   72 ++++++++++++++++---------
 1 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 5a5ec3f..ce39ab2 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -176,14 +176,30 @@ class ImageDetailsPage (HobPage):
             build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(build_result, expand=False, fill=False)
 
+        # create the buttons at the bottom first because the buttons are used in apply_button_per_image()
+        if build_succeeded:
+            buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
+        else: # get to this page from "My images"
+            buttonlist = ["Build new image", "Run image", "Deploy image"]
+        details_bottom_buttons = self.create_bottom_buttons(buttonlist)
+
         # Name
         self.image_store.clear()
+        default_toggled = False
+        default_image_size = 0
         for image_name in image_names:
             image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
-            self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
+            if not default_toggled:
+                default_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
+                    or self.test_deployable(image_name)
+                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, default_toggled)
+                if default_toggled:
+                    default_image_size = image_size
+                self.apply_buttons_per_image(image_name)
+            else:
+                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
         image_table = HobViewTable(self.__columns__)
         image_table.set_model(self.image_store)
-        image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
         image_table.connect("toggled", self.toggled_cb)
         view_files_button = gtk.LinkButton("file://%s" % image_addr, "View files")
         self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
@@ -221,7 +237,7 @@ class ImageDetailsPage (HobPage):
         varlist = ["Packages included: ", "Total image size: "]
         vallist = []
         vallist.append(pkg_num)
-        vallist.append(image_size)
+        vallist.append(default_image_size)
         if build_succeeded:
             edit_packages_button = HobAltButton("Edit packages")
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
@@ -230,11 +246,7 @@ class ImageDetailsPage (HobPage):
         self.package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
         self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
 
-        if build_succeeded:
-            buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
-        else: # get to this page from "My images"
-            buttonlist = ["Build new image", "Run image", "Deploy image"]
-        details_bottom_buttons = self.create_bottom_buttons(buttonlist)
+        # pack the buttons at the bottom, at this time they are already created.
         self.box_group_area.pack_end(details_bottom_buttons, expand=False, fill=False)
 
         self.show_all()
@@ -242,41 +254,49 @@ class ImageDetailsPage (HobPage):
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
 
-    def toggled_cb(self, table, cell, path, columnid, tree):
-        model = tree.get_model()
-        if not model:
-            return
-        iter = model.get_iter_first()
-        while iter:
-            rowpath = model.get_path(iter)
-            model[rowpath][columnid] = False
-            iter = model.iter_next(iter)
-
-        model[path][columnid] = True
-        self.refresh_package_detail_box(model[path][1])
-
+    def test_type_runnable(self, image_name):
         type_runnable = False
-        mach_runnable = False
-        image_name = model[path][0]
         for t in self.builder.parameters.runnable_image_types:
             if image_name.endswith(t):
                 type_runnable = True
                 break
+        return type_runnable
 
+    def test_mach_runnable(self, image_name):
+        mach_runnable = False
         for t in self.builder.parameters.runnable_machine_patterns:
             if t in image_name:
                 mach_runnable = True
                 break
+        return mach_runnable
 
-        self.run_button.set_sensitive(type_runnable and mach_runnable)
-
+    def test_deployable(self, image_name):
         deployable = False
         for t in self.builder.parameters.deployable_image_types:
             if image_name.endswith(t):
                 deployable = True
                 break
+        return deployable
 
-        self.deploy_button.set_sensitive(deployable)
+    def apply_buttons_per_image(self, image_name):
+        self.run_button.set_sensitive(self.test_type_runnable(image_name) and self.test_mach_runnable(image_name))
+        self.deploy_button.set_sensitive(self.test_deployable(image_name))
+
+    def toggled_cb(self, table, cell, path, columnid, tree):
+        model = tree.get_model()
+        if not model:
+            return
+        iter = model.get_iter_first()
+        while iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][columnid] = False
+            iter = model.iter_next(iter)
+
+        model[path][columnid] = True
+        self.refresh_package_detail_box(model[path][1])
+
+        image_name = model[path][0]
+        self.apply_buttons_per_image(image_name)
 
     def create_bottom_buttons(self, buttonlist):
         # Create the buttons at the bottom
-- 
1.7.6



