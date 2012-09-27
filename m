Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1THF0c-00087O-Jy
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Sep 2012 16:24:11 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Sep 2012 07:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,496,1344236400"; d="scan'208";a="214400709"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by orsmga002.jf.intel.com with ESMTP; 27 Sep 2012 07:11:16 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Sep 2012 17:13:45 +0300
Message-Id: <1348755225-454-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH v2] [hob] Multiple user interface fixes in settings
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
X-List-Received-Date: Thu, 27 Sep 2012 14:24:11 -0000

1. Move the "Others" tab from advanced settings to simple settings
2. Organize content of tabs into headings
3. Match various labels in the settings with the design
4. Clean up config_md5 in both simple and advanced settings

This patch implements a part of the changes requested by Belen in the settings dialogs.
The second version of the patch addresses all the UI changes requested by Belen (more
details are in the bug description): alphabetical ordering of the image types and
warnings if no image type is selected.

[YOCTO #2162]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    1 +
 bitbake/lib/bb/ui/crumbs/hig.py     |  292 ++++++++++++++++++-----------------
 2 files changed, 152 insertions(+), 141 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 267fde1..cc5b5e4 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1187,6 +1187,7 @@ class Builder(gtk.Window):
         HobAltButton.style_button(button)
         button = dialog.add_button("Save", gtk.RESPONSE_YES)
         HobButton.style_button(button)
+        dialog.set_save_button(button)
         response = dialog.run()
         settings_changed = False
         if response == gtk.RESPONSE_YES:
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index f304a68..d683be0 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -219,14 +219,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
     def config_md5(self):
         data = ""
-        data += ("PACKAGE_CLASSES: "      + self.configuration.curr_package_format + '\n')
-        data += ("DISTRO: "               + self._get_sorted_value(self.configuration.curr_distro))
-        data += ("IMAGE_ROOTFS_SIZE: "    + self._get_sorted_value(self.configuration.image_rootfs_size))
-        data += ("IMAGE_EXTRA_SIZE: "     + self._get_sorted_value(self.configuration.image_extra_size))
-        data += ("INCOMPATIBLE_LICENSE: " + self._get_sorted_value(self.configuration.incompat_license))
-        data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
-        data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
-        data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
         data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
         if self.configuration.enable_proxy:
             for protocol in self.configuration.proxies.keys():
@@ -347,6 +339,14 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
             self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
 
+        self.configuration.extra_setting = {}
+        it = self.setting_store.get_iter_first()
+        while it:
+            key = self.setting_store.get_value(it, 0)
+            value = self.setting_store.get_value(it, 1)
+            self.configuration.extra_setting[key] = value
+            it = self.setting_store.iter_next(it)
+
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
 
@@ -354,9 +354,10 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Parallel threads</span>'), expand=False, fill=False)
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
+        label = self.gen_label_widget("BitBake parallel threads")
         tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
@@ -366,7 +367,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
+        label = self.gen_label_widget("Make parallel threads")
         tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
         tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
         tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
@@ -374,9 +375,10 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Cache directories and mirror</span>'), expand=False, fill=False)
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
+        label = self.gen_label_widget("Download directory")
         tooltip = "Select a folder that caches the upstream project source code"
         dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -384,7 +386,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
+        label = self.gen_label_widget("Shared state directory")
         tooltip = "Select a folder that caches your prebuilt results"
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -392,7 +394,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
+        label = self.gen_label_widget("Shared mirror directory")
         tooltip = "Select the pre-built mirror that will speed your build"
         sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -458,91 +460,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.refresh_proxy_components()
         return advanced_vbox
 
-
-    def create_visual_elements(self):
-        self.nb = gtk.Notebook()
-        self.nb.set_show_tabs(True)        
-        self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
-        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
-        self.nb.set_current_page(0)
-        self.vbox.pack_start(self.nb, expand=True, fill=True)
-        self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
-
-        self.show_all()
-
-
-#
-# AdvancedSettings Dialog
-#
-class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
-    
-    def details_cb(self, button, parent, protocol):
-        dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
-            user = self.configuration.proxies[protocol][1],
-            passwd = self.configuration.proxies[protocol][2],
-            parent = parent,
-            flags = gtk.DIALOG_MODAL
-                    | gtk.DIALOG_DESTROY_WITH_PARENT
-                    | gtk.DIALOG_NO_SEPARATOR)
-        dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
-        response = dialog.run()
-        if response == gtk.RESPONSE_OK:
-            self.configuration.proxies[protocol][1] = dialog.user
-            self.configuration.proxies[protocol][2] = dialog.passwd
-            self.refresh_proxy_components()
-        dialog.destroy()    
-
-    def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
-        combo_item = self.rootfs_combo.get_active_text()
-        for child in check_hbox.get_children():
-            if isinstance(child, gtk.CheckButton):
-                check_hbox.remove(child)
-        for format in all_package_format:
-            if format != combo_item:
-                check_button = gtk.CheckButton(format)
-                check_hbox.pack_start(check_button, expand=False, fill=False)
-        check_hbox.show_all()
-
-    def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip_combo="", tooltip_extra=""):
-        pkgfmt_hbox = gtk.HBox(False, 24)
-
-        rootfs_vbox = gtk.VBox(False, 6)
-        pkgfmt_hbox.pack_start(rootfs_vbox, expand=False, fill=False)
-
-        label = self.gen_label_widget("Root file system package format")
-        rootfs_vbox.pack_start(label, expand=False, fill=False)
-
-        rootfs_format = ""
-        if curr_package_format:
-            rootfs_format = curr_package_format.split()[0]
-
-        rootfs_format_widget, rootfs_combo = self.gen_combo_widget(rootfs_format, all_package_format, tooltip_combo)
-        rootfs_vbox.pack_start(rootfs_format_widget, expand=False, fill=False)
-
-        extra_vbox = gtk.VBox(False, 6)
-        pkgfmt_hbox.pack_start(extra_vbox, expand=False, fill=False)
-
-        label = self.gen_label_widget("Additional package formats")
-        extra_vbox.pack_start(label, expand=False, fill=False)
-
-        check_hbox = gtk.HBox(False, 12)
-        extra_vbox.pack_start(check_hbox, expand=False, fill=False)
-        for format in all_package_format:
-            if format != rootfs_format:
-                check_button = gtk.CheckButton(format)
-                is_active = (format in curr_package_format.split())
-                check_button.set_active(is_active)
-                check_hbox.pack_start(check_button, expand=False, fill=False)
-
-        info = HobInfoButton(tooltip_extra, self)
-        check_hbox.pack_end(info, expand=False, fill=False)
-
-        rootfs_combo.connect("changed", self.rootfs_combo_changed_cb, all_package_format, check_hbox)
-
-        pkgfmt_hbox.show_all()
-
-        return pkgfmt_hbox, rootfs_combo, check_hbox
-
     def editable_settings_cell_edited(self, cell, path_string, new_text, model):
         it = model.get_iter_from_string(path_string)
         column = cell.get_data("column")
@@ -564,7 +481,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         if iter:
             path = model.get_path(iter)[0]
             model.remove(iter)
-
+ 
     def gen_editable_settings(self, setting, tooltip=""):
         setting_hbox = gtk.HBox(False, 12)
 
@@ -627,6 +544,102 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
         return setting_hbox, setting_store
 
+    def create_others_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
+        label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
+        tooltip = "These are key/value pairs for your extra settings. Click \'Add\' and then directly edit the key and the value"
+        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(setting_widget, expand=True, fill=True)
+
+        return advanced_vbox
+
+    def create_visual_elements(self):
+        self.nb = gtk.Notebook()
+        self.nb.set_show_tabs(True)        
+        self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
+        self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
+        self.nb.set_current_page(0)
+        self.vbox.pack_start(self.nb, expand=True, fill=True)
+        self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
+
+        self.show_all()
+
+
+#
+# AdvancedSettings Dialog
+#
+class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
+    
+    def details_cb(self, button, parent, protocol):
+        dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
+            user = self.configuration.proxies[protocol][1],
+            passwd = self.configuration.proxies[protocol][2],
+            parent = parent,
+            flags = gtk.DIALOG_MODAL
+                    | gtk.DIALOG_DESTROY_WITH_PARENT
+                    | gtk.DIALOG_NO_SEPARATOR)
+        dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
+        response = dialog.run()
+        if response == gtk.RESPONSE_OK:
+            self.configuration.proxies[protocol][1] = dialog.user
+            self.configuration.proxies[protocol][2] = dialog.passwd
+            self.refresh_proxy_components()
+        dialog.destroy()
+
+    def set_save_button(self, button):
+        self.save_button = button
+
+    def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
+        combo_item = self.rootfs_combo.get_active_text()
+        for child in check_hbox.get_children():
+            if isinstance(child, gtk.CheckButton):
+                check_hbox.remove(child)
+        for format in all_package_format:
+            if format != combo_item:
+                check_button = gtk.CheckButton(format)
+                check_hbox.pack_start(check_button, expand=False, fill=False)
+        check_hbox.show_all()
+
+    def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip_combo="", tooltip_extra=""):
+        pkgfmt_vbox = gtk.VBox(False, 6)
+
+        label = self.gen_label_widget("Root file system package format")
+        pkgfmt_vbox.pack_start(label, expand=False, fill=False)
+
+        rootfs_format = ""
+        if curr_package_format:
+            rootfs_format = curr_package_format.split()[0]
+
+        rootfs_format_widget, rootfs_combo = self.gen_combo_widget(rootfs_format, all_package_format, tooltip_combo)
+        pkgfmt_vbox.pack_start(rootfs_format_widget, expand=False, fill=False)
+
+        label = self.gen_label_widget("Additional package formats")
+        pkgfmt_vbox.pack_start(label, expand=False, fill=False)
+
+        check_hbox = gtk.HBox(False, 12)
+        pkgfmt_vbox.pack_start(check_hbox, expand=False, fill=False)
+        for format in all_package_format:
+            if format != rootfs_format:
+                check_button = gtk.CheckButton(format)
+                is_active = (format in curr_package_format.split())
+                check_button.set_active(is_active)
+                check_hbox.pack_start(check_button, expand=False, fill=False)
+
+        info = HobInfoButton(tooltip_extra, self)
+        check_hbox.pack_start(info, expand=False, fill=False)
+
+        rootfs_combo.connect("changed", self.rootfs_combo_changed_cb, all_package_format, check_hbox)
+
+        pkgfmt_vbox.show_all()
+
+        return pkgfmt_vbox, rootfs_combo, check_hbox
+
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
             max_threads, parent, flags, buttons=None):
@@ -652,13 +665,13 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         self.extra_size_spinner = None
         self.gplv3_checkbox = None
         self.toolchain_checkbox = None
-        self.setting_store = None
         self.image_types_checkbuttons = {}
 
         self.md5 = self.config_md5()
         self.settings_changed = False
 
         # create visual elements on the dialog
+        self.save_button = None
         self.create_visual_elements()
         self.connect("response", self.response_cb)
 
@@ -675,12 +688,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
         data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
         data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
-        data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
-        if self.configuration.enable_proxy:
-            for protocol in self.configuration.proxies.keys():
-                data += (protocol + ": " + self._get_sorted_value(self.configuration.combine_proxy(protocol)))
-        for key in self.configuration.extra_setting.keys():
-            data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
         return hashlib.md5(data).hexdigest()
 
     def create_visual_elements(self):
@@ -688,13 +695,34 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         self.nb.set_show_tabs(True)
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
         self.nb.append_page(self.create_output_page(), gtk.Label("Output"))
-        self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
         self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
 
         self.show_all()
 
+    def get_num_checked_image_types(self):
+        total = 0
+        for b in self.image_types_checkbuttons.values():
+            if b.get_active():
+              total = total + 1
+        return total
+
+    def set_save_button_state(self):
+        if self.save_button:
+            self.save_button.set_sensitive(self.get_num_checked_image_types() > 0)
+
+    def image_type_checkbutton_clicked_cb(self, button):
+        self.set_save_button_state()
+        if self.get_num_checked_image_types() == 0:
+            # Show an error dialog
+            lbl = "<b>Select an image type</b>\n\nYou need to select at least one image type."
+            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            button = dialog.add_button("OK", gtk.RESPONSE_OK)
+            HobButton.style_button(button)
+            response = dialog.run()
+            dialog.destroy()
+
     def create_image_types_page(self):
         main_vbox = gtk.VBox(False, 16)
         main_vbox.set_border_width(6)
@@ -703,7 +731,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.set_border_width(6)
 
         distro_vbox = gtk.VBox(False, 6)        
-        label = self.gen_label_widget("<span weight=\"bold\">Distro:</span>")
+        label = self.gen_label_widget("Distro:")
         tooltip = "Selects the Yocto Project distribution you want"
         distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
         distro_vbox.pack_start(label, expand=False, fill=False)
@@ -717,19 +745,22 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
         tooltip = "Image file system types you want."
         info = HobInfoButton(tooltip, self)
-        label = self.gen_label_widget("<span weight=\"bold\">Select image types:</span>")
-        table.attach(label, 0, 9, 0, 1)
-        table.attach(info, 9, 10, 0, 1)
+        label = self.gen_label_widget("Image types:")
+        align = gtk.Alignment(0, 0.5, 0, 0)
+        table.attach(align, 0, 4, 0, 1)
+        align.add(label)
+        table.attach(info, 4, 5, 0, 1)
 
         i = 1
         j = 1
-        for image_type in self.image_types:
+        for image_type in sorted(self.image_types):
             self.image_types_checkbuttons[image_type] = gtk.CheckButton(image_type)
+            self.image_types_checkbuttons[image_type].connect("toggled", self.image_type_checkbutton_clicked_cb)
             article = ""
             if image_type.startswith(("a", "e", "i", "o", "u")):
                 article = "n"
             self.image_types_checkbuttons[image_type].set_tooltip_text("Build a%s %s image" % (article, image_type))
-            table.attach(self.image_types_checkbuttons[image_type], j, j + 4, i, i + 1)
+            table.attach(self.image_types_checkbuttons[image_type], j - 1, j + 3, i, i + 1)
             if image_type in self.configuration.image_fstypes.split():
                 self.image_types_checkbuttons[image_type].set_active(True)
             i += 1
@@ -738,6 +769,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
                 j = j + 4
 
         main_vbox.pack_start(advanced_vbox, expand=False, fill=False)
+        self.set_save_button_state()
         
         return main_vbox
 
@@ -745,18 +777,18 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Package format</span>'), expand=False, fill=False)
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Packaging format:</span>")
         tooltip_combo = "Selects the package format used to generate rootfs."
         tooltip_extra = "Selects extra package formats to build"
         pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip_combo, tooltip_extra)
-        sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Image size</span>'), expand=False, fill=False)
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Image rootfs size: (MB)</span>")
+        label = self.gen_label_widget("Image basic size (in MB)")
         tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
         rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -764,12 +796,13 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Image extra size: (MB)</span>")
+        label = self.gen_label_widget("Additional free space (in MB)")
         tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 64GB."
         extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Licensing</span>'), expand=False, fill=False)
         self.gplv3_checkbox = gtk.CheckButton("Exclude GPLv3 packages")
         self.gplv3_checkbox.set_tooltip_text("Check this box to prevent GPLv3 packages from being included in your image")
         if "GPLv3" in self.configuration.incompat_license.split():
@@ -778,6 +811,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
             self.gplv3_checkbox.set_active(False)
         advanced_vbox.pack_start(self.gplv3_checkbox, expand=False, fill=False)
 
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Toolchain</span>'), expand=False, fill=False)
         sub_hbox = gtk.HBox(False, 6)
         advanced_vbox.pack_start(sub_hbox, expand=False, fill=False)
         self.toolchain_checkbox = gtk.CheckButton("Build toolchain")
@@ -791,21 +825,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
         return advanced_vbox
 
-    def create_others_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
-        label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
-        tooltip = "These are key/value pairs for your extra settings. Click \'Add\' and then directly edit the key and the value"
-        setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(setting_widget, expand=True, fill=True)
-
-        return advanced_vbox
-
-    
     def response_cb(self, dialog, response_id):
         package_format = []
         package_format.append(self.rootfs_combo.get_active_text())
@@ -834,15 +853,6 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         self.configuration.incompat_license = self.configuration.incompat_license.strip()
 
         self.configuration.toolchain_build = self.toolchain_checkbox.get_active()
-
-        self.configuration.extra_setting = {}
-        it = self.setting_store.get_iter_first()
-        while it:
-            key = self.setting_store.get_value(it, 0)
-            value = self.setting_store.get_value(it, 1)
-            self.configuration.extra_setting[key] = value
-            it = self.setting_store.iter_next(it)        
-
         self.configuration.curr_sdk_machine = self.sdk_machine_combo.get_active_text()
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
-- 
1.7.9.5



