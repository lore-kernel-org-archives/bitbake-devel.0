Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHFFD-0008W4-HE
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:07:00 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 06:57:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126876247"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 06:57:44 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:50 +0800
Message-Id: <924ed6183d48915c8d27b647b70819de6dd29071.1333980506.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 20/21] Hob: show those appliable buttons on the image details page only
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
X-List-Received-Date: Mon, 09 Apr 2012 14:07:00 -0000

We don't use "grayed out" but use "show/hide" for those appliable buttons
in the image details page.

[Yocto #2143]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |  122 ++++++++++++++++++--------
 1 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 3eb6bcf..1d1cb9e 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -113,6 +113,8 @@ class ImageDetailsPage (HobPage):
         super(ImageDetailsPage, self).__init__(builder, "Image details")
 
         self.image_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
+        self.button_ids = {}
+        self.details_bottom_buttons = gtk.HBox(False, 6)
         self.create_visual_elements()
 
     def create_visual_elements(self):
@@ -150,6 +152,9 @@ class ImageDetailsPage (HobPage):
         children = self.box_group_area.get_children() or []
         for child in children:
             self.box_group_area.remove(child)
+        children = self.details_bottom_buttons.get_children() or []
+        for child in children:
+            self.details_bottom_buttons.remove(child)
 
     def show_page(self, step):
         build_succeeded = (step == self.builder.IMAGE_GENERATED)
@@ -163,10 +168,15 @@ class ImageDetailsPage (HobPage):
         else:
             pkg_num = "N/A"
 
+        # remove
+        for button_id, button in self.button_ids.items():
+            button.disconnect(button_id)
         self._remove_all_widget()
+        # repack
         self.pack_start(self.details_top_buttons, expand=False, fill=False)
         self.pack_start(self.group_align, expand=True, fill=True)
 
+        self.build_result = None
         if build_succeeded:
             # building is the previous step
             icon = gtk.Image()
@@ -176,43 +186,48 @@ class ImageDetailsPage (HobPage):
             icon.set_from_pixbuf(pix_buffer)
             varlist = [""]
             vallist = ["Your image is ready"]
-            build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
-            self.box_group_area.pack_start(build_result, expand=False, fill=False)
+            self.build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
+            self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
         # create the buttons at the bottom first because the buttons are used in apply_button_per_image()
         if build_succeeded:
-            buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
+            self.buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
         else: # get to this page from "My images"
-            buttonlist = ["Build new image", "Run image", "Deploy image"]
-        details_bottom_buttons = self.create_bottom_buttons(buttonlist)
+            self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
         self.image_store.clear()
         default_toggled = False
         default_image_size = 0
+        i = 0
         for image_name in image_names:
             image_size = HobPage._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
             if not default_toggled:
                 default_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
                     or self.test_deployable(image_name)
+                if i == (len(image_names) - 1):
+                    default_toggled = True
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, default_toggled)
                 if default_toggled:
                     default_image_size = image_size
-                self.apply_buttons_per_image(image_name)
+                    self.create_bottom_buttons(self.buttonlist, image_name)
             else:
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
+            i = i + 1
         image_table = HobViewTable(self.__columns__)
         image_table.set_model(self.image_store)
         image_table.connect("toggled", self.toggled_cb)
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         view_files_button.set_tooltip_text("Open the directory containing the image files")
-        self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
+        self.image_detail = self.DetailBox(widget=image_table, button=view_files_button)
+        self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
 
         # Machine, Base image and Layers
         layer_num_limit = 15
         varlist = ["Machine: ", "Base image: ", "Layers: "]
         vallist = []
+        self.setting_detail = None
         if build_succeeded:
             vallist.append(machine)
             vallist.append(base_image)
@@ -236,8 +251,8 @@ class ImageDetailsPage (HobPage):
             edit_config_button = HobAltButton("Edit configuration")
             edit_config_button.set_tooltip_text("Edit machine, base image and recipes")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
-            setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
-            self.box_group_area.pack_start(setting_detail, expand=False, fill=False)
+            self.setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
+            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
 
         # Packages included, and Total image size
         varlist = ["Packages included: ", "Total image size: "]
@@ -254,7 +269,7 @@ class ImageDetailsPage (HobPage):
         self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
 
         # pack the buttons at the bottom, at this time they are already created.
-        self.box_group_area.pack_end(details_bottom_buttons, expand=False, fill=False)
+        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
 
         self.show_all()
 
@@ -289,10 +304,6 @@ class ImageDetailsPage (HobPage):
                 break
         return deployable
 
-    def apply_buttons_per_image(self, image_name):
-        self.run_button.set_sensitive(self.test_type_runnable(image_name) and self.test_mach_runnable(image_name))
-        self.deploy_button.set_sensitive(self.test_deployable(image_name))
-
     def toggled_cb(self, table, cell, path, columnid, tree):
         model = tree.get_model()
         if not model:
@@ -307,50 +318,86 @@ class ImageDetailsPage (HobPage):
         self.refresh_package_detail_box(model[path][1])
 
         image_name = model[path][0]
-        self.apply_buttons_per_image(image_name)
 
-    def create_bottom_buttons(self, buttonlist):
+        # remove
+        for button_id, button in self.button_ids.items():
+            button.disconnect(button_id)
+        self._remove_all_widget()
+        # repack
+        self.pack_start(self.details_top_buttons, expand=False, fill=False)
+        self.pack_start(self.group_align, expand=True, fill=True)
+        if self.build_result:
+            self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
+        self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
+        if self.setting_detail:
+            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
+        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
+        self.create_bottom_buttons(self.buttonlist, image_name)
+        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
+        self.show_all()
+
+    def create_bottom_buttons(self, buttonlist, image_name):
         # Create the buttons at the bottom
-        bottom_buttons = gtk.HBox(False, 6)
         created = False
+        packed = False
+        self.button_ids = {}
 
         # create button "Deploy image"
         name = "Deploy image"
-        if name in buttonlist:
-            self.deploy_button = HobButton('Deploy image')
-            self.deploy_button.set_size_request(205, 49)
-            self.deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
-            self.deploy_button.set_flags(gtk.CAN_DEFAULT)
-            self.deploy_button.connect("clicked", self.deploy_button_clicked_cb)
-            bottom_buttons.pack_end(self.deploy_button, expand=False, fill=False)
+        if name in buttonlist and self.test_deployable(image_name):
+            deploy_button = HobButton('Deploy image')
+            deploy_button.set_size_request(205, 49)
+            deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
+            deploy_button.set_flags(gtk.CAN_DEFAULT)
+            button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb)
+            self.button_ids[button_id] = deploy_button
+            self.details_bottom_buttons.pack_end(deploy_button, expand=False, fill=False)
             created = True
+            packed = True
 
         name = "Run image"
-        if name in buttonlist:
+        if name in buttonlist and self.test_type_runnable(image_name) and self.test_mach_runnable(image_name):
             if created == True:
                 # separator
                 label = gtk.Label(" or ")
-                bottom_buttons.pack_end(label, expand=False, fill=False)
+                self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
 
-            # create button "Run image"
-            self.run_button = HobAltButton("Run image")
-            self.run_button.set_tooltip_text("Start up an image with qemu emulator")
-            self.run_button.connect("clicked", self.run_button_clicked_cb)
-            bottom_buttons.pack_end(self.run_button, expand=False, fill=False)
+                # create button "Run image"
+                run_button = HobAltButton("Run image")
+            else:
+                # create button "Run image" as the primary button
+                run_button = HobButton("Run image")
+                run_button.set_size_request(205, 49)
+                run_button.set_flags(gtk.CAN_DEFAULT)
+                packed = True
+            run_button.set_tooltip_text("Start up an image with qemu emulator")
+            button_id = run_button.connect("clicked", self.run_button_clicked_cb)
+            self.button_ids[button_id] = run_button
+            self.details_bottom_buttons.pack_end(run_button, expand=False, fill=False)
             created = True
 
+        if not packed:
+            box = gtk.HBox(False, 6)
+            box.show()
+            subbox = gtk.HBox(False, 0)
+            subbox.set_size_request(205, 49)
+            subbox.show()
+            box.add(subbox)
+            self.details_bottom_buttons.pack_end(box, False, False)
+
         name = "Save as template"
         if name in buttonlist:
             if created == True:
                 # separator
                 label = gtk.Label(" or ")
-                bottom_buttons.pack_end(label, expand=False, fill=False)
+                self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
 
             # create button "Save as template"
             save_button = HobAltButton("Save as template")
             save_button.set_tooltip_text("Save the image configuration for reuse")
-            save_button.connect("clicked", self.save_button_clicked_cb)
-            bottom_buttons.pack_end(save_button, expand=False, fill=False)
+            button_id = save_button.connect("clicked", self.save_button_clicked_cb)
+            self.button_ids[button_id] = save_button
+            self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
             create = True
 
         name = "Build new image"
@@ -358,10 +405,9 @@ class ImageDetailsPage (HobPage):
             # create button "Build new image"
             build_new_button = HobAltButton("Build new image")
             build_new_button.set_tooltip_text("Create a new image from scratch")
-            build_new_button.connect("clicked", self.build_new_button_clicked_cb)
-            bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
-
-        return bottom_buttons
+            button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
+            self.button_ids[button_id] = build_new_button
+            self.details_bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
 
     def _get_selected_image(self):
         image_name = ""
-- 
1.7.6



