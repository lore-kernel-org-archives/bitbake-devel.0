Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SRj1J-0006wq-0D
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 May 2012 13:55:58 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 08 May 2012 04:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150484343"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 08 May 2012 04:46:04 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 May 2012 19:48:08 +0800
Message-Id: <54d73e0b38c138155e6abe2e0866ff26fdb34ef2.1336477313.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
References: <97b813663dd741e20295a0c19a2d4b46086e5afe.1336477313.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1336477313.git.limingx.l.an@intel.com>
References: <cover.1336477313.git.limingx.l.an@intel.com>
Subject: [PATCH 4/4] Hob: change the workflow about click 'Run Image' to run directly after builded a qemu image
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
X-List-Received-Date: Tue, 08 May 2012 11:56:03 -0000

[YOCTO #2155]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py          |   52 +++++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |  139 +++++++++++++------------
 2 files changed, 109 insertions(+), 82 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 4b274a7..42d0f2c 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1047,6 +1047,21 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
 
+    def get_kernel_file_name(self, image_path):
+        name_list = []
+        kernel_name = ""
+        if image_path:
+            files = [f for f in os.listdir(image_path) if f[0] <> '.']
+            for check_file in files:
+                if check_file.endswith(".bin"):
+                    name_splits = check_file.split(".")[0]
+                    if self.configuration.curr_mach in name_splits.split("-"):
+                        kernel_name = check_file
+                    if not os.path.islink(os.path.join(image_path, check_file)):
+                        name_list.append(check_file)
+
+        return kernel_name, len(name_list)
+
     def runqemu_image(self, image_name):
         if not image_name:
             lbl = "<b>Please select an image to launch in QEMU.</b>"
@@ -1057,24 +1072,31 @@ class Builder(gtk.Window):
             dialog.destroy()
             return
 
-        dialog = gtk.FileChooserDialog("Load Kernel Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE)
-        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-        HobAltButton.style_button(button)
-        button = dialog.add_button("Open", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
-        filter = gtk.FileFilter()
-        filter.set_name("Kernel Files")
-        filter.add_pattern("*.bin")
-        dialog.add_filter(filter)
+        kernel_name, kernels_number = self.get_kernel_file_name(self.parameters.image_addr)
+        if not kernel_name or kernels_number > 1:
+            dialog = gtk.FileChooserDialog("Load Kernel Files", self,
+                                           gtk.FILE_CHOOSER_ACTION_SAVE)
+            button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+            HobAltButton.style_button(button)
+            button = dialog.add_button("Open", gtk.RESPONSE_YES)
+            HobButton.style_button(button)
+            filter = gtk.FileFilter()
+            filter.set_name("Kernel Files")
+            filter.add_pattern("*.bin")
+            dialog.add_filter(filter)
 
-        dialog.set_current_folder(self.parameters.image_addr)
+            dialog.set_current_folder(self.parameters.image_addr)
 
-        response = dialog.run()
-        if response == gtk.RESPONSE_YES:
-            kernel_path = dialog.get_filename()
+            response = dialog.run()
+            if response == gtk.RESPONSE_YES:
+                kernel_path = dialog.get_filename()
+                image_path = os.path.join(self.parameters.image_addr, image_name)
+            dialog.destroy()
+
+        elif kernel_name:
+            kernel_path = os.path.join(self.parameters.image_addr, kernel_name)
             image_path = os.path.join(self.parameters.image_addr, image_name)
-        dialog.destroy()
+            response = gtk.RESPONSE_YES
 
         if response == gtk.RESPONSE_YES:
             source_env_path = os.path.join(self.parameters.core_base, "oe-init-build-env")
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index ac631b6..1cfef80 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -32,6 +32,12 @@ from bb.ui.crumbs.hobpages import HobPage
 class ImageDetailsPage (HobPage):
 
     __columns__ = [{
+            'col_name' : 'Selected',
+            'col_id'   : 2,
+            'col_style': 'radio toggle',
+            'col_min'  : 100,
+            'col_max'  : 100
+        },{
             'col_name' : 'Image name',
             'col_id'   : 0,
             'col_style': 'text',
@@ -43,13 +49,7 @@ class ImageDetailsPage (HobPage):
             'col_style': 'text',
             'col_min'  : 100,
             'col_max'  : 100
-        }, {
-            'col_name' : 'Select',
-            'col_id'   : 2,
-            'col_style': 'radio toggle',
-            'col_min'  : 100,
-            'col_max'  : 100
-    }]
+        }]
 
     class DetailBox (gtk.EventBox):
         def __init__(self, widget = None, varlist = None, vallist = None, icon = None, button = None, color = HobColors.LIGHT_GRAY):
@@ -64,27 +64,31 @@ class ImageDetailsPage (HobPage):
             self.hbox.set_border_width(15)
             self.add(self.hbox)
 
+            total_rows = 0
             if widget:
-                row = 1
-            elif varlist and vallist:
+                total_rows = 10
+            if varlist and vallist:
                 # pack the icon and the text on the left
-                row = len(varlist)
-            self.table = gtk.Table(row, 20, True)
+                total_rows += len(varlist)
+            self.table = gtk.Table(total_rows, 20, True)
+            self.table.set_row_spacings(6)
             self.table.set_size_request(100, -1)
             self.hbox.pack_start(self.table, expand=True, fill=True, padding=15)
 
             colid = 0
+            rowid = 0
             self.line_widgets = {}
             if icon:
                 self.table.attach(icon, colid, colid + 2, 0, 1)
                 colid = colid + 2
             if widget:
-                self.table.attach(widget, colid, 20, 0, 1)
-            elif varlist and vallist:
-                for line in range(0, row):
-                    self.line_widgets[varlist[line]] = self.text2label(varlist[line], vallist[line])
-                    self.table.attach(self.line_widgets[varlist[line]], colid, 20, line, line + 1)
-
+                self.table.attach(widget, colid, 20, 0, 10)
+                rowid = 10
+            if varlist and vallist:
+                for row in range(rowid, total_rows):
+                    index = row - rowid
+                    self.line_widgets[varlist[index]] = self.text2label(varlist[index], vallist[index])
+                    self.table.attach(self.line_widgets[varlist[index]], colid, 20, row, row + 1)
             # pack the button on the right
             if button:
                 self.hbox.pack_end(button, expand=False, fill=False)
@@ -172,6 +176,7 @@ class ImageDetailsPage (HobPage):
         for button_id, button in self.button_ids.items():
             button.disconnect(button_id)
         self._remove_all_widget()
+
         # repack
         self.pack_start(self.details_top_buttons, expand=False, fill=False)
         self.pack_start(self.group_align, expand=True, fill=True)
@@ -196,6 +201,9 @@ class ImageDetailsPage (HobPage):
             self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
+        varlist = [""]
+        vallist = ["Listed generated image and package files."]
+        t = ''
         self.image_store.clear()
         default_toggled = False
         default_image_size = 0
@@ -211,16 +219,33 @@ class ImageDetailsPage (HobPage):
                 if default_toggled:
                     default_image_size = image_size
                     self.create_bottom_buttons(self.buttonlist, image_name)
+                    if 'qemu' in image_name:
+                        t = ' (Selected QEMU items to be as runnable image)'
+                    else:
+                        t = ' (Selected Targeted item to be deploy)'
             else:
                 self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
             i = i + 1
-        image_table = HobViewTable(self.__columns__)
-        image_table.set_model(self.image_store)
-        image_table.connect("toggled", self.toggled_cb)
+
+        if build_succeeded:
+            varlist = ["Name: ", "Directory: ", ". "]
+            vallist = []
+            vallist.append(image_name.split('.')[0])
+            vallist.append(image_addr)
+            vallist.append(t)
+            image_table = None
+        else:
+            image_table = HobViewTable(self.__columns__)
+            image_table.set_model(self.image_store)
+            image_table.connect("row-activated", self.row_activated_cb)
+            if default_image_size and ('qemu' in image_name):
+                t = '\n(Selected QEMU items to be as runnable image, so you need to select prompted kernel to run)'
+            vallist[0] += t
+
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         view_files_button.set_tooltip_text("Open the directory containing the image files")
-        self.image_detail = self.DetailBox(widget=image_table, button=view_files_button)
+        self.image_detail = self.DetailBox(widget=image_table, varlist=varlist, vallist=vallist, button=view_files_button)
         self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
 
         # Machine, Base image and Layers
@@ -252,7 +277,7 @@ class ImageDetailsPage (HobPage):
             edit_config_button.set_tooltip_text("Edit machine, base image and recipes")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
             self.setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
-            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
+            self.box_group_area.pack_start(self.setting_detail, expand=True, fill=True)
 
         # Packages included, and Total image size
         varlist = ["Packages included: ", "Total image size: "]
@@ -303,37 +328,14 @@ class ImageDetailsPage (HobPage):
                 break
         return deployable
 
-    def toggled_cb(self, table, cell, path, columnid, tree):
-        model = tree.get_model()
+    def row_activated_cb(self, table, model, path):
         if not model:
             return
-        iter = model.get_iter_first()
-        while iter:
-            rowpath = model.get_path(iter)
-            model[rowpath][columnid] = False
-            iter = model.iter_next(iter)
-
-        model[path][columnid] = True
-        self.refresh_package_detail_box(model[path][1])
-
+        iter = model.get_iter(path)
         image_name = model[path][0]
-
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
-        if self.setting_detail:
-            self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
-        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
-        self.create_bottom_buttons(self.buttonlist, image_name)
-        self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
-        self.show_all()
+        if iter and model[path][2] == 'runnable':
+            kernel_name, kernel_number = self.get_kernel_file_name(image_name)
+            self.builder.runqemu_image(image_name, kernel_name, kernel_number)
 
     def create_bottom_buttons(self, buttonlist, image_name):
         # Create the buttons at the bottom
@@ -348,7 +350,7 @@ class ImageDetailsPage (HobPage):
             deploy_button.set_size_request(205, 49)
             deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
             deploy_button.set_flags(gtk.CAN_DEFAULT)
-            button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb)
+            button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb, image_name)
             self.button_ids[button_id] = deploy_button
             self.details_bottom_buttons.pack_end(deploy_button, expand=False, fill=False)
             created = True
@@ -370,7 +372,7 @@ class ImageDetailsPage (HobPage):
                 run_button.set_flags(gtk.CAN_DEFAULT)
                 packed = True
             run_button.set_tooltip_text("Start up an image with qemu emulator")
-            button_id = run_button.connect("clicked", self.run_button_clicked_cb)
+            button_id = run_button.connect("clicked", self.run_button_clicked_cb, image_name)
             self.button_ids[button_id] = run_button
             self.details_bottom_buttons.pack_end(run_button, expand=False, fill=False)
             created = True
@@ -408,27 +410,30 @@ class ImageDetailsPage (HobPage):
             self.button_ids[button_id] = build_new_button
             self.details_bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
 
-    def _get_selected_image(self):
-        image_name = ""
-        iter = self.image_store.get_iter_first()
-        while iter:
-            path = self.image_store.get_path(iter)
-            if self.image_store[path][2]:
-                image_name = self.image_store[path][0]
-                break
-            iter = self.image_store.iter_next(iter)
-
-        return image_name
+    def get_kernel_file_name(self, image_name):
+        name_list = []
+        kernel_name = ""
+        if image_name:
+            image_path = os.path.join(self.builder.parameters.image_addr)
+            files = [f for f in os.listdir(image_path) if f[0] <> '.']
+            for check_file in files:
+                if check_file.endswith(".bin"):
+                    if  self.test_mach_runnable(check_file):
+                        selected_machine = self.builder.configuration.curr_mach
+                        if selected_machine in check_file:
+                            kernel_name = check_file
+                    if not os.path.islink(os.path.join(image_path, check_file)):
+                        name_list.append(check_file)
+
+        return kernel_name, len(name_list)
 
     def save_button_clicked_cb(self, button):
         self.builder.show_save_template_dialog()
 
-    def deploy_button_clicked_cb(self, button):
-        image_name = self._get_selected_image()
+    def deploy_button_clicked_cb(self, button, image_name):
         self.builder.deploy_image(image_name)
 
-    def run_button_clicked_cb(self, button):
-        image_name = self._get_selected_image()
+    def run_button_clicked_cb(self, button, image_name):
         self.builder.runqemu_image(image_name)
 
     def build_new_button_clicked_cb(self, button):
-- 
1.7.5.4



