Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SkDQt-0006SP-FG
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Jun 2012 14:02:48 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 28 Jun 2012 04:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="161744406"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 28 Jun 2012 04:51:51 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Jun 2012 19:55:31 +0800
Message-Id: <a8d8da710f9797910a77883034caf09854c74a66.1340884340.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340884340.git.limingx.l.an@intel.com>
References: <cover.1340884340.git.limingx.l.an@intel.com>
Subject: [PATCH 1/1] Hob: change 'run image' and 'deploy' Gui and work flow for building detail page
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
X-List-Received-Date: Thu, 28 Jun 2012 12:02:48 -0000

In build detail page, the response action of clicked the 'run image'
or 'deploy' button will accroding to below as ui design:
1)if there has one file in building result, it will responsed the
'run image'(now, we only support the qemu) or 'deploy' directly
2)if there has more than one file, it will popup a dialog with listed
created files type, they are has same action attributes 'deploy'
or 'runnable'.
Note: because the qemu image (runnable file) can't be deployed and
we can't generated a image that has the two attributes now, can be run
or can be deployed,  so the code will not deal with this case.

[YOCTO #2155]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |  212 ++++++++++++--------------
 1 files changed, 98 insertions(+), 114 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index ba0ad7e..07fc3a8 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -32,26 +32,6 @@ from bb.ui.crumbs.hig import CrumbsDialog
 #
 class ImageDetailsPage (HobPage):
 
-    __columns__ = [{
-            'col_name' : 'Image name',
-            'col_id'   : 0,
-            'col_style': 'text',
-            'col_min'  : 500,
-            'col_max'  : 500
-        },{
-            'col_name' : 'Image size',
-            'col_id'   : 1,
-            'col_style': 'text',
-            'col_min'  : 100,
-            'col_max'  : 100
-        },{
-            'col_name' : 'Select',
-            'col_id'   : 2,
-            'col_style': 'radio toggle',
-            'col_min'  : 100,
-            'col_max'  : 100
-        }]
-
     class DetailBox (gtk.EventBox):
         def __init__(self, widget = None, varlist = None, vallist = None, icon = None, button = None, color = HobColors.LIGHT_GRAY):
             gtk.EventBox.__init__(self)
@@ -62,7 +42,7 @@ class ImageDetailsPage (HobPage):
             self.set_style(style)
 
             self.hbox = gtk.HBox()
-            self.hbox.set_border_width(15)
+            self.hbox.set_border_width(10)
             self.add(self.hbox)
 
             total_rows = 0
@@ -131,7 +111,7 @@ class ImageDetailsPage (HobPage):
     def __init__(self, builder):
         super(ImageDetailsPage, self).__init__(builder, "Image details")
 
-        self.image_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_BOOLEAN, gobject.TYPE_STRING)
+        self.image_store = []
         self.button_ids = {}
         self.details_bottom_buttons = gtk.HBox(False, 6)
         self.create_visual_elements()
@@ -216,7 +196,7 @@ class ImageDetailsPage (HobPage):
             self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
-        self.image_store.clear()
+        self.image_store = []
         self.toggled_image = ""
         default_image_size = 0
         self.num_toggled = 0
@@ -224,44 +204,47 @@ class ImageDetailsPage (HobPage):
         for image_name in image_names:
             image_size = HobPage._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
 
-            image_attr = ("runnable" if (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) else \
+            image_attr = ("run" if (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) else \
                           ("deploy" if self.test_deployable(image_name) else ""))
             is_toggled = (image_attr != "")
 
             if not self.toggled_image:
                 if i == (len(image_names) - 1):
                     is_toggled = True
-                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, is_toggled, 3, image_attr)
                 if is_toggled:
                     default_image_size = image_size
                     self.toggled_image = image_name
 
+            split_stuff = image_name.split('.')
+            if "rootfs" in split_stuff:
+                image_type = image_name[(len(split_stuff[0]) + len(".rootfs") + 1):]
             else:
-                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False, 3, image_attr)
+                image_type = image_name[(len(split_stuff[0]) + 1):]
+
+            self.image_store.append({'name': image_name,
+                                    'type': image_type,
+                                    'size': image_size,
+                                    'is_toggled': is_toggled,
+                                    'action_attr': image_attr,})
+
             i = i + 1
             self.num_toggled += is_toggled
 
         is_runnable = self.create_bottom_buttons(self.buttonlist, self.toggled_image)
 
-        if self.build_succeeded:
-            varlist = ["Name: ", "Directory: "]
-            vallist = []
-            vallist.append(image_name.split('.')[0])
-            vallist.append(image_addr)
-            image_table = None
-        else:
-            varlist = None
-            vallist = None
-            image_table = HobViewTable(self.__columns__)
-            image_table.set_model(self.image_store)
-            image_table.connect("row-activated", self.row_activated_cb)
-            image_table.connect_group_selection(self.table_selected_cb)
+        #if self.build_succeeded:
+        varlist = ["Name: ", "FileCreated: ", "Directory: "]
+        vallist = []
+
+        vallist.append(image_name.split('.')[0])
+        vallist.append(',  '.join(fileitem['type'] for fileitem in self.image_store))
+        vallist.append(image_addr)
 
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         view_files_button.set_tooltip_text("Open the directory containing the image files")
-        self.image_detail = self.DetailBox(widget=image_table, varlist=varlist, vallist=vallist, button=view_files_button)
-        self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
+        self.image_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=view_files_button)
+        self.box_group_area.pack_start(self.image_detail, expand=False, fill=True)
 
         # The default kernel box for the qemu images
         self.sel_kernel = ""
@@ -324,7 +307,12 @@ class ImageDetailsPage (HobPage):
         self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
 
         # pack the buttons at the bottom, at this time they are already created.
-        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
+        if self.build_succeeded:
+            self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
+        else: # for "My images" page
+            self.details_separator = gtk.HSeparator()
+            self.box_group_area.pack_start(self.details_separator, expand=False, fill=False)
+            self.box_group_area.pack_start(self.details_bottom_buttons, expand=False, fill=False)
 
         self.show_all()
         if not is_runnable:
@@ -376,25 +364,57 @@ class ImageDetailsPage (HobPage):
 
         return kernel_name
 
-    def show_builded_images_dialog(self, widget):
-        dialog = CrumbsDialog("Your builded images", self.builder,
+    def show_builded_images_dialog(self, widget, primary_action=""):
+        title = primary_action if primary_action else "Your builded images"
+        dialog = CrumbsDialog(title, self.builder,
                               gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
-        dialog.set_size_request(-1, 350)
+        dialog.set_border_width(12)
 
         label = gtk.Label()
         label.set_use_markup(True)
         label.set_alignment(0.0, 0.5)
-        label.set_markup("<span font_desc='12'>Please select a image to run or deploy</span>")
+        label.set_markup("<span font_desc='12'>Select the image file you want to %s</span>" % primary_action)
         dialog.vbox.pack_start(label, expand=False, fill=False)
 
-        image_table = HobViewTable(self.__columns__)
-        image_table.set_model(self.image_store)
-        image_table.connect("row-activated", self.row_activated_cb)
-        image_table.connect_group_selection(self.table_selected_cb)
-        dialog.vbox.pack_start(image_table, expand=True, fill=True)
+        # filter created images as action attribution (deploy or run)
+        action_attr = ""
+        action_images = []
+        for fileitem in self.image_store:
+            action_attr = fileitem['action_attr']
+            if  (action_attr == 'run' and primary_action == "Run image") \
+             or (action_attr == 'deploy' and primary_action == "Deploy image"):
+                action_images.append(fileitem)
+
+        # pack the corresponding 'runnable' or 'deploy' radio_buttons, if there has no more than one file.
+        # assume that there does not both have 'deploy' and 'runnable' files in the same building result
+        # in possible as design.
+        curr_row = 0
+        rows = (len(action_images)) if len(action_images) < 10 else 10
+        table = gtk.Table(rows, 10, True)
+        table.set_row_spacings(6)
+        table.set_col_spacing(0, 12)
+        table.set_col_spacing(5, 12)
+
+        sel_parent_btn = None
+        for fileitem in action_images:
+            sel_btn = gtk.RadioButton(sel_parent_btn, fileitem['type'])
+            sel_parent_btn = sel_btn if not sel_parent_btn else sel_parent_btn
+            sel_btn.set_active(fileitem['is_toggled'])
+            sel_btn.connect('toggled', self.table_selected_cb, fileitem)
+            if curr_row < 10:
+                table.attach(sel_btn, 2, 5, curr_row, curr_row + 1)
+            else:
+                table.attach(sel_btn, 7, 10, curr_row - 10, curr_row - 9)
+            curr_row += 1
+
+        dialog.vbox.pack_start(table, expand=False, fill=False, padding = 6)
 
-        button = dialog.add_button(" OK ", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_CANCEL)
+        HobAltButton.style_button(button)
+
+        if primary_action:
+            button = dialog.add_button(primary_action, gtk.RESPONSE_YES)
+            HobButton.style_button(button)
 
         dialog.show_all()
 
@@ -404,58 +424,17 @@ class ImageDetailsPage (HobPage):
         if response != gtk.RESPONSE_YES:
             return
 
-        it = self.image_store.get_iter_first()
-        while it:
-            image_attr = self.image_store.get_value(it, 3)
-            is_select = self.image_store.get_value(it, 2)
-            if is_select:
-                image_name = self.image_store.get_value(it, 0)
-                if image_attr == 'runnable':
-                    self.builder.runqemu_image(image_name, self.sel_kernel)
+        for fileitem in self.image_store:
+            if fileitem['is_toggled']:
+                if fileitem['action_attr'] == 'run':
+                    self.builder.runqemu_image(fileitem['name'], self.sel_kernel)
                 elif image_attr == 'deploy':
-                    self.builder.deploy_image(image_name)
-            it = self.image_store.iter_next(it)
-
-    def repack_box_group(self, image_name=None):
-        # remove
-        for button_id, button in self.button_ids.items():
-            button.disconnect(button_id)
-        self._remove_all_widget()
-        # repack
-        self.pack_start(self.details_top_buttons, expand=False, fill=False)
-        self.pack_start(self.group_align, expand=True, fill=True)
-        if self.build_result:
-            self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
-        self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
-        if self.kernel_detail:
-            self.box_group_area.pack_start(self.kernel_detail, expand=False, fill=False)
-        if self.setting_detail:
-            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
-        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
-        is_runnable = self.create_bottom_buttons(self.buttonlist, image_name)
-        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
-        self.show_all()
-        if not is_runnable:
-            self.kernel_detail.hide()
+                    self.builder.deploy_image(fileitem['name'])
 
-    def table_selected_cb(self, selection):
-        model, paths = selection.get_selected_rows()
-        if (not model) or (not paths):
-            return
-
-        path = paths[0]
-        columnid = 2
-        iter = model.get_iter_first()
-        while iter:
-            rowpath = model.get_path(iter)
-            model[rowpath][columnid] = False
-            iter = model.iter_next(iter)
-
-        model[path][columnid] = True
-        self.refresh_package_detail_box(model[path][1])
-
-        self.toggled_image = model[path][0]
-        self.repack_box_group(self.toggled_image)
+    def table_selected_cb(self, tbutton, image):
+        image['is_toggled'] = tbutton.get_active()
+        if image['is_toggled']:
+            self.toggled_image = image['name']
 
     def change_kernel_cb(self, widget):
         kernel_path = self.builder.show_load_kernel_dialog()
@@ -541,12 +520,11 @@ class ImageDetailsPage (HobPage):
             # create button "Build new image"
             if packed:
                 build_new_button = HobAltButton("Build new image")
-                self.details_bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
             else:
                 build_new_button = HobButton("Build new image")
-                build_new_button.set_size_request(205, 49)
                 build_new_button.set_flags(gtk.CAN_DEFAULT)
-                self.details_bottom_buttons.pack_end(build_new_button, expand=False, fill=False)
+            build_new_button.set_size_request(205, 49)
+            self.details_bottom_buttons.pack_end(build_new_button, expand=False, fill=False)
             build_new_button.set_tooltip_text("Create a new image from scratch")
             button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             self.button_ids[button_id] = build_new_button
@@ -557,16 +535,22 @@ class ImageDetailsPage (HobPage):
         self.builder.show_save_template_dialog()
 
     def deploy_button_clicked_cb(self, button):
-        if self.build_succeeded and self.num_toggled > 1:
-            self.show_builded_images_dialog()
-            return
-        self.builder.deploy_image(self.toggled_image)
+        if self.toggled_image:
+            if self.build_succeeded or self.num_toggled > 1:
+                self.set_sensitive(False)
+                self.show_builded_images_dialog(None, "Deploy image")
+                self.set_sensitive(True)
+            else:
+                self.builder.deploy_image(self.toggled_image)
 
     def run_button_clicked_cb(self, button):
-        if self.build_succeeded and self.num_toggled > 1:
-            self.show_builded_images_dialog()
-            return
-        self.builder.runqemu_image(self.toggled_image, self.sel_kernel)
+        if self.toggled_image:
+            if self.num_toggled > 1:
+                self.set_sensitive(False)
+                self.show_builded_images_dialog(None, "Run image")
+                self.set_sensitive(True)
+            else:
+                self.builder.runqemu_image(self.toggled_image, self.sel_kernel)
 
     def build_new_button_clicked_cb(self, button):
         self.builder.initiate_new_build_async()
-- 
1.7.5.4



