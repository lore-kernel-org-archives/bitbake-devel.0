Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SbV0l-0002hc-Ji
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Jun 2012 12:59:48 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Jun 2012 03:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="152298153"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 04 Jun 2012 03:49:24 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jun 2012 18:52:13 +0800
Message-Id: <4ebc546e7ec432cbeebc0662fc8096d1904cd344.1338806537.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
References: <57f497956749ad3a4c41051cb12f7a3b97f0254e.1338806537.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1338806537.git.limingx.l.an@intel.com>
References: <cover.1338806537.git.limingx.l.an@intel.com>
Subject: [PATCH 4/5] Hob: Change 'run image' work flow and image detail screen as ui design
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
X-List-Received-Date: Mon, 04 Jun 2012 10:59:48 -0000

Added the qemu_image_kernel selection view box to image detail screen GUI, and
changed the 'run image' button clicked work flow.

[YOCTO #2155]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py          |  118 +++++++---------
 bitbake/lib/bb/ui/crumbs/hig.py              |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    3 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |  201 ++++++++++++++++++++------
 4 files changed, 211 insertions(+), 113 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 899d0e0..ab336d3 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -300,6 +300,7 @@ class Parameters:
         self.tmpdir = params["tmpdir"]
         self.image_white_pattern = params["image_white_pattern"]
         self.image_black_pattern = params["image_black_pattern"]
+        self.kernel_image_type = params["kernel_image_type"]
         # for build log to show
         self.bb_version = params["bb_version"]
         self.target_arch = params["target_arch"]
@@ -1141,25 +1142,32 @@ class Builder(gtk.Window):
         response = dialog.run()
         dialog.destroy()
 
-    def get_kernel_file_name(self):
-        name_list = []
-        kernel_name = ""
-        image_path = self.parameters.image_addr
-        if image_path:
-            files = [f for f in os.listdir(image_path) if f[0] <> '.']
-            for check_file in files:
-                if check_file.endswith(".bin"):
-                    name_splits = check_file.split(".")[0]
-                    if self.configuration.curr_mach in name_splits.split("-"):
-                        kernel_name = check_file
-                    if not os.path.islink(os.path.join(image_path, check_file)):
-                        name_list.append(check_file)
-
-        return kernel_name, len(name_list)
-
-    def runqemu_image(self, image_name):
-        if not image_name:
-            lbl = "<b>Please select an image to launch in QEMU.</b>"
+    def show_load_kernel_dialog(self):
+        dialog = gtk.FileChooserDialog("Load Kernel Files", self,
+                                       gtk.FILE_CHOOSER_ACTION_SAVE)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
+        filter = gtk.FileFilter()
+        filter.set_name("Kernel Files")
+        filter.add_pattern("*.bin")
+        dialog.add_filter(filter)
+
+        dialog.set_current_folder(self.parameters.image_addr)
+
+        response = dialog.run()
+        kernel_path = ""
+        if response == gtk.RESPONSE_YES:
+            kernel_path = dialog.get_filename()
+
+        dialog.destroy()
+
+        return kernel_path
+
+    def runqemu_image(self, image_name, kernel_name):
+        if not image_name or not kernel_name:
+            lbl = "<b>Please select an %s to launch in QEMU.</b>" % ("kernel" if image_name else "image")
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
@@ -1167,57 +1175,33 @@ class Builder(gtk.Window):
             dialog.destroy()
             return
 
-        kernel_name, kernels_number = self.get_kernel_file_name()
-        if not kernel_name or kernels_number > 1:
-            dialog = gtk.FileChooserDialog("Load Kernel Files", self,
-                                           gtk.FILE_CHOOSER_ACTION_SAVE)
-            button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-            HobAltButton.style_button(button)
-            button = dialog.add_button("Open", gtk.RESPONSE_YES)
-            HobButton.style_button(button)
-            filter = gtk.FileFilter()
-            filter.set_name("Kernel Files")
-            filter.add_pattern("*.bin")
-            dialog.add_filter(filter)
-
-            dialog.set_current_folder(self.parameters.image_addr)
+        kernel_path = os.path.join(self.parameters.image_addr, kernel_name)
+        image_path = os.path.join(self.parameters.image_addr, image_name)
 
-            response = dialog.run()
-            if response == gtk.RESPONSE_YES:
-                kernel_path = dialog.get_filename()
-                image_path = os.path.join(self.parameters.image_addr, image_name)
+        source_env_path = os.path.join(self.parameters.core_base, "oe-init-build-env")
+        tmp_path = self.parameters.tmpdir
+        cmdline = bb.ui.crumbs.utils.which_terminal()
+        if os.path.exists(image_path) and os.path.exists(kernel_path) \
+           and os.path.exists(source_env_path) and os.path.exists(tmp_path) \
+           and cmdline:
+            cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
+            cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
+            cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"
+            subprocess.Popen(shlex.split(cmdline))
+        else:
+            lbl = "<b>Path error</b>\nOne of your paths is wrong,"
+            lbl = lbl + " please make sure the following paths exist:\n"
+            lbl = lbl + "image path:" + image_path + "\n"
+            lbl = lbl + "kernel path:" + kernel_path + "\n"
+            lbl = lbl + "source environment path:" + source_env_path + "\n"
+            lbl = lbl + "tmp path: " + tmp_path + "."
+            lbl = lbl + "You may be missing either xterm or vte for terminal services."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+            button = dialog.add_button("Close", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
+            dialog.run()
             dialog.destroy()
 
-        elif kernel_name:
-            kernel_path = os.path.join(self.parameters.image_addr, kernel_name)
-            image_path = os.path.join(self.parameters.image_addr, image_name)
-            response = gtk.RESPONSE_YES
-
-        if response == gtk.RESPONSE_YES:
-            source_env_path = os.path.join(self.parameters.core_base, "oe-init-build-env")
-            tmp_path = self.parameters.tmpdir
-            cmdline = bb.ui.crumbs.utils.which_terminal()
-            if os.path.exists(image_path) and os.path.exists(kernel_path) \
-               and os.path.exists(source_env_path) and os.path.exists(tmp_path) \
-               and cmdline:
-                cmdline += "\' bash -c \"export OE_TMPDIR=" + tmp_path + "; "
-                cmdline += "source " + source_env_path + " " + os.getcwd() + "; "
-                cmdline += "runqemu " + kernel_path + " " + image_path + "\"\'"
-                subprocess.Popen(shlex.split(cmdline))
-            else:
-                lbl = "<b>Path error</b>\nOne of your paths is wrong,"
-                lbl = lbl + " please make sure the following paths exist:\n"
-                lbl = lbl + "image path:" + image_path + "\n"
-                lbl = lbl + "kernel path:" + kernel_path + "\n"
-                lbl = lbl + "source environment path:" + source_env_path + "\n"
-                lbl = lbl + "tmp path: " + tmp_path + "."
-                lbl = lbl + "You may be missing either xterm or vte for terminal services."
-                dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
-                button = dialog.add_button("Close", gtk.RESPONSE_OK)
-                HobButton.style_button(button)
-                dialog.run()
-                dialog.destroy()
-
     def show_packages(self, ask=True):
         _, selected_recipes = self.recipe_model.get_selected_recipes()
         if selected_recipes and ask:
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 7c9e73f..f64f1be 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1210,7 +1210,7 @@ class ImageSelectionDialog (CrumbsDialog):
                         if f.endswith('.' + real_image_type):
                             imageset.add(f.rsplit('.' + real_image_type)[0].rsplit('.rootfs')[0])
                             self.image_list.append(f)
-        
+
         for image in imageset:
             self.image_store.set(self.image_store.append(), 0, image, 1, False)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 1db9c44..a00fcd8 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -347,7 +347,7 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_GNERATE_TGTS)
         self.run_next_command(self.GENERATE_RECIPES)
-                 
+
     def generate_packages(self, tgts, default_task="build"):
         targets = []
         targets.extend(tgts)
@@ -492,6 +492,7 @@ class HobHandler(gobject.GObject):
         params["runnable_image_types"] = self._remove_redundant(self.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or "")
         params["runnable_machine_patterns"] = self._remove_redundant(self.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or "")
         params["deployable_image_types"] = self._remove_redundant(self.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or "")
+        params["kernel_image_type"] = self.runCommand(["getVariable", "KERNEL_IMAGETYPE"]) or ""
         params["tmpdir"] = self.runCommand(["getVariable", "TMPDIR"]) or ""
         params["distro_version"] = self.runCommand(["getVariable", "DISTRO_VERSION"]) or ""
         params["target_os"] = self.runCommand(["getVariable", "TARGET_OS"]) or ""
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 1ab80f8..ba0ad7e 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -26,7 +26,7 @@ from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton, HobButton
 from bb.ui.crumbs.hobpages import HobPage
 import subprocess
-
+from bb.ui.crumbs.hig import CrumbsDialog
 #
 # ImageDetailsPage
 #
@@ -101,9 +101,23 @@ class ImageDetailsPage (HobPage):
                 return
             self.line_widgets[variable].set_markup(self.format_line(variable, value))
 
+        def wrap_line(self, inputs):
+            # wrap the long text of inputs
+            wrap_width_chars = 75
+            outputs = ""
+            tmps = inputs
+            less_chars = len(inputs)
+            while (less_chars - wrap_width_chars) > 0:
+                less_chars -= wrap_width_chars
+                outputs += tmps[:wrap_width_chars] + "\n               "
+                tmps = inputs[less_chars:]
+            outputs += tmps
+            return outputs
+
         def format_line(self, variable, value):
+            wraped_value = self.wrap_line(value)
             markup = "<span weight=\'bold\'>%s</span>" % variable
-            markup += "<span weight=\'normal\' foreground=\'#1c1c1c\' font_desc=\'14px\'>%s</span>" % value
+            markup += "<span weight=\'normal\' foreground=\'#1c1c1c\' font_desc=\'14px\'>%s</span>" % wraped_value
             return markup
 
         def text2label(self, variable, value):
@@ -117,7 +131,7 @@ class ImageDetailsPage (HobPage):
     def __init__(self, builder):
         super(ImageDetailsPage, self).__init__(builder, "Image details")
 
-        self.image_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
+        self.image_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_BOOLEAN, gobject.TYPE_STRING)
         self.button_ids = {}
         self.details_bottom_buttons = gtk.HBox(False, 6)
         self.create_visual_elements()
@@ -162,10 +176,10 @@ class ImageDetailsPage (HobPage):
             self.details_bottom_buttons.remove(child)
 
     def show_page(self, step):
-        build_succeeded = (step == self.builder.IMAGE_GENERATED)
+        self.build_succeeded = (step == self.builder.IMAGE_GENERATED)
         image_addr = self.builder.parameters.image_addr
         image_names = self.builder.parameters.image_names
-        if build_succeeded:
+        if self.build_succeeded:
             machine = self.builder.configuration.curr_mach
             base_image = self.builder.recipe_model.get_selected_image()
             layers = self.builder.configuration.layers
@@ -183,7 +197,7 @@ class ImageDetailsPage (HobPage):
         self.pack_start(self.group_align, expand=True, fill=True)
 
         self.build_result = None
-        if build_succeeded:
+        if self.build_succeeded:
             # building is the previous step
             icon = gtk.Image()
             pixmap_path = hic.ICON_INDI_CONFIRM_FILE
@@ -196,38 +210,40 @@ class ImageDetailsPage (HobPage):
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
         # create the buttons at the bottom first because the buttons are used in apply_button_per_image()
-        if build_succeeded:
+        if self.build_succeeded:
             self.buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
         else: # get to this page from "My images"
             self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
         self.image_store.clear()
-        default_toggled = ""
+        self.toggled_image = ""
         default_image_size = 0
-        num_toggled = 0
+        self.num_toggled = 0
         i = 0
         for image_name in image_names:
             image_size = HobPage._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
-            is_toggled = (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) \
-                or self.test_deployable(image_name)
 
-            if not default_toggled:
+            image_attr = ("runnable" if (self.test_type_runnable(image_name) and self.test_mach_runnable(image_name)) else \
+                          ("deploy" if self.test_deployable(image_name) else ""))
+            is_toggled = (image_attr != "")
+
+            if not self.toggled_image:
                 if i == (len(image_names) - 1):
                     is_toggled = True
-                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, is_toggled)
+                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, is_toggled, 3, image_attr)
                 if is_toggled:
                     default_image_size = image_size
-                    default_toggled = image_name
+                    self.toggled_image = image_name
 
             else:
-                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
+                self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False, 3, image_attr)
             i = i + 1
-            num_toggled += is_toggled
+            self.num_toggled += is_toggled
 
-        self.create_bottom_buttons(self.buttonlist, default_toggled)
+        is_runnable = self.create_bottom_buttons(self.buttonlist, self.toggled_image)
 
-        if build_succeeded and (num_toggled < 2):
+        if self.build_succeeded:
             varlist = ["Name: ", "Directory: "]
             vallist = []
             vallist.append(image_name.split('.')[0])
@@ -247,12 +263,27 @@ class ImageDetailsPage (HobPage):
         self.image_detail = self.DetailBox(widget=image_table, varlist=varlist, vallist=vallist, button=view_files_button)
         self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
 
+        # The default kernel box for the qemu images
+        self.sel_kernel = ""
+        if 'qemu' in image_name:
+            self.sel_kernel = self.get_kernel_file_name()
+
+            varlist = ["Kernel: "]
+            vallist = []
+            vallist.append(self.sel_kernel)
+
+            change_kernel_button = HobAltButton("Change")
+            change_kernel_button.connect("clicked", self.change_kernel_cb)
+            change_kernel_button.set_tooltip_text("Change qemu kernel file")
+            self.kernel_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=change_kernel_button)
+            self.box_group_area.pack_start(self.kernel_detail, expand=False, fill=False)
+
         # Machine, Base image and Layers
         layer_num_limit = 15
         varlist = ["Machine: ", "Base image: ", "Layers: "]
         vallist = []
         self.setting_detail = None
-        if build_succeeded:
+        if self.build_succeeded:
             vallist.append(machine)
             vallist.append(base_image)
             i = 0
@@ -283,7 +314,7 @@ class ImageDetailsPage (HobPage):
         vallist = []
         vallist.append(pkg_num)
         vallist.append(default_image_size)
-        if build_succeeded:
+        if self.build_succeeded:
             edit_packages_button = HobAltButton("Edit packages")
             edit_packages_button.set_tooltip_text("Edit the packages included in your image")
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
@@ -296,6 +327,8 @@ class ImageDetailsPage (HobPage):
         self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
 
         self.show_all()
+        if not is_runnable:
+            self.kernel_detail.hide()
 
     def view_files_clicked_cb(self, button, image_addr):
         subprocess.call("xdg-open /%s" % image_addr, shell=True)
@@ -327,24 +360,63 @@ class ImageDetailsPage (HobPage):
                 break
         return deployable
 
-    def table_selected_cb(self, selection):
-        model, paths = selection.get_selected_rows()
-        if (not model) or (not paths):
-            return
+    def get_kernel_file_name(self, kernel_addr=""):
+        kernel_name = ""
 
-        path = paths[0]
-        columnid = 2
-        iter = model.get_iter_first()
-        while iter:
-            rowpath = model.get_path(iter)
-            model[rowpath][columnid] = False
-            iter = model.iter_next(iter)
+        if not kernel_addr:
+            kernel_addr = self.builder.parameters.image_addr
 
-        model[path][columnid] = True
-        self.refresh_package_detail_box(model[path][1])
+        files = [f for f in os.listdir(kernel_addr) if f[0] <> '.']
+        for check_file in files:
+            if check_file.endswith(".bin"):
+                name_splits = check_file.split(".")[0]
+                if self.builder.parameters.kernel_image_type in name_splits.split("-"):
+                    kernel_name = check_file
+                    break
 
-        image_name = model[path][0]
+        return kernel_name
+
+    def show_builded_images_dialog(self, widget):
+        dialog = CrumbsDialog("Your builded images", self.builder,
+                              gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
+        dialog.set_size_request(-1, 350)
+
+        label = gtk.Label()
+        label.set_use_markup(True)
+        label.set_alignment(0.0, 0.5)
+        label.set_markup("<span font_desc='12'>Please select a image to run or deploy</span>")
+        dialog.vbox.pack_start(label, expand=False, fill=False)
+
+        image_table = HobViewTable(self.__columns__)
+        image_table.set_model(self.image_store)
+        image_table.connect("row-activated", self.row_activated_cb)
+        image_table.connect_group_selection(self.table_selected_cb)
+        dialog.vbox.pack_start(image_table, expand=True, fill=True)
+
+        button = dialog.add_button(" OK ", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
 
+        dialog.show_all()
+
+        response = dialog.run()
+        dialog.destroy()
+
+        if response != gtk.RESPONSE_YES:
+            return
+
+        it = self.image_store.get_iter_first()
+        while it:
+            image_attr = self.image_store.get_value(it, 3)
+            is_select = self.image_store.get_value(it, 2)
+            if is_select:
+                image_name = self.image_store.get_value(it, 0)
+                if image_attr == 'runnable':
+                    self.builder.runqemu_image(image_name, self.sel_kernel)
+                elif image_attr == 'deploy':
+                    self.builder.deploy_image(image_name)
+            it = self.image_store.iter_next(it)
+
+    def repack_box_group(self, image_name=None):
         # remove
         for button_id, button in self.button_ids.items():
             button.disconnect(button_id)
@@ -355,27 +427,59 @@ class ImageDetailsPage (HobPage):
         if self.build_result:
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
         self.box_group_area.pack_start(self.image_detail, expand=True, fill=True)
+        if self.kernel_detail:
+            self.box_group_area.pack_start(self.kernel_detail, expand=False, fill=False)
         if self.setting_detail:
             self.box_group_area.pack_start(self.setting_detail, expand=False, fill=False)
         self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
-        self.create_bottom_buttons(self.buttonlist, image_name)
+        is_runnable = self.create_bottom_buttons(self.buttonlist, image_name)
         self.box_group_area.pack_end(self.details_bottom_buttons, expand=False, fill=False)
         self.show_all()
+        if not is_runnable:
+            self.kernel_detail.hide()
+
+    def table_selected_cb(self, selection):
+        model, paths = selection.get_selected_rows()
+        if (not model) or (not paths):
+            return
+
+        path = paths[0]
+        columnid = 2
+        iter = model.get_iter_first()
+        while iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][columnid] = False
+            iter = model.iter_next(iter)
+
+        model[path][columnid] = True
+        self.refresh_package_detail_box(model[path][1])
+
+        self.toggled_image = model[path][0]
+        self.repack_box_group(self.toggled_image)
+
+    def change_kernel_cb(self, widget):
+        kernel_path = self.builder.show_load_kernel_dialog()
+        if kernel_path and self.kernel_detail:
+            import os.path
+            self.sel_kernel = os.path.basename(kernel_path)
+            markup = self.kernel_detail.format_line("Kernel: ", self.sel_kernel)
+            label = ((self.kernel_detail.get_children()[0]).get_children()[0]).get_children()[0]
+            label.set_markup(markup)
 
     def row_activated_cb(self, table, model, path):
         if not model:
             return
         iter = model.get_iter(path)
         image_name = model[path][0]
-        if iter and model[path][2] == 'runnable':
-            kernel_name, kernel_number = self.builder.parameters.get_kernel_file_name()
-            self.builder.runqemu_image(image_name, kernel_name, kernel_number)
+        if iter and model[path][2] == True:
+            self.builder.runqemu_image(image_name, self.sel_kernel)
 
     def create_bottom_buttons(self, buttonlist, image_name):
         # Create the buttons at the bottom
         created = False
         packed = False
         self.button_ids = {}
+        is_runnable = False
 
         # create button "Deploy image"
         name = "Deploy image"
@@ -384,7 +488,7 @@ class ImageDetailsPage (HobPage):
             deploy_button.set_size_request(205, 49)
             deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
             deploy_button.set_flags(gtk.CAN_DEFAULT)
-            button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb, image_name)
+            button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb)
             self.button_ids[button_id] = deploy_button
             self.details_bottom_buttons.pack_end(deploy_button, expand=False, fill=False)
             created = True
@@ -406,10 +510,11 @@ class ImageDetailsPage (HobPage):
                 run_button.set_flags(gtk.CAN_DEFAULT)
                 packed = True
             run_button.set_tooltip_text("Start up an image with qemu emulator")
-            button_id = run_button.connect("clicked", self.run_button_clicked_cb, image_name)
+            button_id = run_button.connect("clicked", self.run_button_clicked_cb)
             self.button_ids[button_id] = run_button
             self.details_bottom_buttons.pack_end(run_button, expand=False, fill=False)
             created = True
+            is_runnable = True
 
         name = "Save as template"
         if name in buttonlist:
@@ -446,14 +551,22 @@ class ImageDetailsPage (HobPage):
             button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             self.button_ids[button_id] = build_new_button
 
+        return is_runnable
+
     def save_button_clicked_cb(self, button):
         self.builder.show_save_template_dialog()
 
-    def deploy_button_clicked_cb(self, button, image_name):
-        self.builder.deploy_image(image_name)
+    def deploy_button_clicked_cb(self, button):
+        if self.build_succeeded and self.num_toggled > 1:
+            self.show_builded_images_dialog()
+            return
+        self.builder.deploy_image(self.toggled_image)
 
-    def run_button_clicked_cb(self, button, image_name):
-        self.builder.runqemu_image(image_name)
+    def run_button_clicked_cb(self, button):
+        if self.build_succeeded and self.num_toggled > 1:
+            self.show_builded_images_dialog()
+            return
+        self.builder.runqemu_image(self.toggled_image, self.sel_kernel)
 
     def build_new_button_clicked_cb(self, button):
         self.builder.initiate_new_build_async()
-- 
1.7.5.4



