Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1T8Xww-00071C-4K
	for bitbake-devel@lists.openembedded.org;
	Mon, 03 Sep 2012 16:48:27 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Sep 2012 07:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,360,1344236400"; d="scan'208";a="217233283"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2012 07:34:36 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Sep 2012 17:36:54 +0300
Message-Id: <1346683014-2845-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
X-Mailman-Approved-At: Thu, 06 Sep 2012 16:29:16 +0200
Subject: [PATCH] Implement 'settings' dialog as designed
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
X-List-Received-Date: Mon, 03 Sep 2012 14:48:27 -0000

From: Valentin Popa <valentin.popa@intel.com>

[YOCTO #2162]
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   34 +-
 bitbake/lib/bb/ui/crumbs/hig.py                    |  664 ++++++++++++--------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   23 +-
 3 files changed, 435 insertions(+), 286 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7de4798..e3bc9df 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -36,8 +36,8 @@ from bb.ui.crumbs.builddetailspage import BuildDetailsPage
 from bb.ui.crumbs.imagedetailspage import ImageDetailsPage
 from bb.ui.crumbs.hobwidget import hwc, HobButton, HobAltButton, hcc
 from bb.ui.crumbs.hig import CrumbsMessageDialog, ImageSelectionDialog, \
-                             AdvancedSettingDialog, LayerSelectionDialog, \
-                             DeployImageDialog
+                             AdvancedSettingDialog, SimpleSettingsDialog, \
+                             LayerSelectionDialog, DeployImageDialog
 from bb.ui.crumbs.persistenttooltip import PersistentTooltip
 import bb.ui.crumbs.utils
 
@@ -793,6 +793,7 @@ class Builder(gtk.Window):
         self.image_configuration_page.layer_button.set_sensitive(sensitive)
         self.image_configuration_page.layer_info_icon.set_sensitive(sensitive)
         self.image_configuration_page.toolbar.set_sensitive(sensitive)
+        self.image_configuration_page.view_adv_configuration_button.set_sensitive(sensitive)
         self.image_configuration_page.config_build_button.set_sensitive(sensitive)
 
         self.recipe_details_page.set_sensitive(sensitive)
@@ -1141,7 +1142,32 @@ class Builder(gtk.Window):
         dialog.destroy()
 
     def show_adv_settings_dialog(self):
-        dialog = AdvancedSettingDialog(title = "Settings",
+        dialog = AdvancedSettingDialog(title = "Advanced configuration",
+            configuration = copy.deepcopy(self.configuration),
+            all_image_types = self.parameters.image_types,
+            all_package_formats = self.parameters.all_package_formats,
+            all_distros = self.parameters.all_distros,
+            all_sdk_machines = self.parameters.all_sdk_machines,
+            max_threads = self.parameters.max_threads,
+            parent = self,
+            flags = gtk.DIALOG_MODAL
+                    | gtk.DIALOG_DESTROY_WITH_PARENT
+                    | gtk.DIALOG_NO_SEPARATOR)
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Save", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
+        response = dialog.run()
+        settings_changed = False
+        if response == gtk.RESPONSE_YES:
+            self.configuration = dialog.configuration
+            self.save_defaults() # remember settings
+            settings_changed = dialog.settings_changed
+        dialog.destroy()
+        return response == gtk.RESPONSE_YES, settings_changed
+
+    def show_simple_settings_dialog(self):
+        dialog = SimpleSettingsDialog(title = "Settings",
             configuration = copy.deepcopy(self.configuration),
             all_image_types = self.parameters.image_types,
             all_package_formats = self.parameters.all_package_formats,
@@ -1334,4 +1360,4 @@ class Builder(gtk.Window):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             self.consolelog.setFormatter(format)
 
-            self.logger.addHandler(self.consolelog)
\ No newline at end of file
+            self.logger.addHandler(self.consolelog)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2001ff4..2c77bf7 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -41,6 +41,88 @@ BitBake GUI's
 In summary: spacing = 12px, border-width = 6px
 """
 
+
+class SettingsUIHelper():
+
+    def gen_label_widget(self, content):
+        label = gtk.Label()
+        label.set_alignment(0, 0)
+        label.set_markup(content)
+        label.show()
+        return label
+
+    def gen_spinner_widget(self, content, lower, upper, tooltip=""):
+        hbox = gtk.HBox(False, 12)
+        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
+        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1, digits=0)
+
+        spinner.set_value(content)
+        hbox.pack_start(spinner, expand=False, fill=False)
+
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, spinner
+
+    def gen_combo_widget(self, curr_item, all_item, tooltip=""):
+        hbox = gtk.HBox(False, 12)
+        combo = gtk.combo_box_new_text()
+        hbox.pack_start(combo, expand=False, fill=False)
+
+        index = 0
+        for item in all_item or []:
+            combo.append_text(item)
+            if item == curr_item:
+                combo.set_active(index)
+            index += 1
+
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, combo
+
+    def entry_widget_select_path_cb(self, action, parent, entry):
+        dialog = gtk.FileChooserDialog("", parent,
+                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        text = entry.get_text()
+        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
+        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button = dialog.add_button("Open", gtk.RESPONSE_YES)
+        HobButton.style_button(button)
+        response = dialog.run()
+        if response == gtk.RESPONSE_YES:
+            path = dialog.get_filename()
+            entry.set_text(path)
+
+        dialog.destroy()
+
+    def gen_entry_widget(self, content, parent, tooltip="", need_button=True):
+        hbox = gtk.HBox(False, 12)
+        entry = gtk.Entry()
+        entry.set_text(content)
+
+        if need_button:
+            table = gtk.Table(1, 10, True)
+            hbox.pack_start(table, expand=True, fill=True)
+            table.attach(entry, 0, 9, 0, 1)
+            image = gtk.Image()
+            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+            open_button = gtk.Button()
+            open_button.set_image(image)
+            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
+            table.attach(open_button, 9, 10, 0, 1)
+        else:
+            hbox.pack_start(entry, expand=True, fill=True)
+
+        info = HobInfoButton(tooltip, self)
+        hbox.pack_start(info, expand=False, fill=False)
+
+        hbox.show_all()
+        return hbox, entry
+
 #
 # CrumbsDialog
 #
@@ -94,89 +176,309 @@ class CrumbsMessageDialog(CrumbsDialog):
         first_row.add(self.label)
 
 #
-# AdvancedSettings Dialog
+# SimpleSettings Dialog
 #
-class AdvancedSettingDialog (CrumbsDialog):
+class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
-    def gen_label_widget(self, content):
-        label = gtk.Label()
-        label.set_alignment(0, 0)
-        label.set_markup(content)
-        label.show()
-        return label
+    def __init__(self, title, configuration, all_image_types,
+            all_package_formats, all_distros, all_sdk_machines,
+            max_threads, parent, flags, buttons=None):
+        super(SimpleSettingsDialog, self).__init__(title, parent, flags, buttons)
 
-    def gen_spinner_widget(self, content, lower, upper, tooltip=""):
+        # class members from other objects
+        # bitbake settings from Builder.Configuration
+        self.configuration = configuration
+        self.image_types = all_image_types
+        self.all_package_formats = all_package_formats
+        self.all_distros = all_distros
+        self.all_sdk_machines = all_sdk_machines
+        self.max_threads = max_threads
+
+        # class members for internal use
+        self.distro_combo = None
+        self.dldir_text = None
+        self.sstatedir_text = None
+        self.sstatemirror_text = None
+        self.bb_spinner = None
+        self.pmake_spinner = None
+        self.rootfs_size_spinner = None
+        self.extra_size_spinner = None
+        self.gplv3_checkbox = None
+        self.toolchain_checkbox = None
+        self.setting_store = None
+        self.image_types_checkbuttons = {}
+
+        self.md5 = self.config_md5()
+        self.settings_changed = False
+
+        # create visual elements on the dialog
+        self.create_visual_elements()
+        self.connect("response", self.response_cb)
+
+    def _get_sorted_value(self, var):
+        return " ".join(sorted(str(var).split())) + "\n"
+
+    def config_md5(self):
+        data = ""
+        data += ("PACKAGE_CLASSES: "      + self.configuration.curr_package_format + '\n')
+        data += ("DISTRO: "               + self._get_sorted_value(self.configuration.curr_distro))
+        data += ("IMAGE_ROOTFS_SIZE: "    + self._get_sorted_value(self.configuration.image_rootfs_size))
+        data += ("IMAGE_EXTRA_SIZE: "     + self._get_sorted_value(self.configuration.image_extra_size))
+        data += ("INCOMPATIBLE_LICENSE: " + self._get_sorted_value(self.configuration.incompat_license))
+        data += ("SDK_MACHINE: "          + self._get_sorted_value(self.configuration.curr_sdk_machine))
+        data += ("TOOLCHAIN_BUILD: "      + self._get_sorted_value(self.configuration.toolchain_build))
+        data += ("IMAGE_FSTYPES: "        + self._get_sorted_value(self.configuration.image_fstypes))
+        data += ("ENABLE_PROXY: "         + self._get_sorted_value(self.configuration.enable_proxy))
+        if self.configuration.enable_proxy:
+            for protocol in self.configuration.proxies.keys():
+                data += (protocol + ": " + self._get_sorted_value(self.configuration.combine_proxy(protocol)))
+        for key in self.configuration.extra_setting.keys():
+            data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
+        return hashlib.md5(data).hexdigest()
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
+    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
         hbox = gtk.HBox(False, 12)
-        adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
-        spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1, digits=0)
 
-        spinner.set_value(content)
-        hbox.pack_start(spinner, expand=False, fill=False)
+        label = gtk.Label(protocol.upper() + " proxy")
+        hbox.pack_start(label, expand=True, fill=False, padding=24)
 
-        info = HobInfoButton(tooltip, self)
-        hbox.pack_start(info, expand=False, fill=False)
+        proxy_entry = gtk.Entry()
+        proxy_entry.set_size_request(300, -1)
+        hbox.pack_start(proxy_entry, expand=False, fill=False)
+
+        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
+
+        port_entry = gtk.Entry()
+        port_entry.set_size_request(60, -1)
+        hbox.pack_start(port_entry, expand=False, fill=False)
+
+        details_button = HobAltButton("Details")
+        details_button.connect("clicked", self.details_cb, parent, protocol)
+        hbox.pack_start(details_button, expand=False, fill=False)
 
         hbox.show_all()
-        return hbox, spinner
+        return hbox, proxy_entry, port_entry, details_button
 
-    def gen_combo_widget(self, curr_item, all_item, tooltip=""):
-        hbox = gtk.HBox(False, 12)
-        combo = gtk.combo_box_new_text()
-        hbox.pack_start(combo, expand=False, fill=False)
+    def refresh_proxy_components(self):
+        self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
 
-        index = 0
-        for item in all_item or []:
-            combo.append_text(item)
-            if item == curr_item:
-                combo.set_active(index)
-            index += 1
+        self.http_proxy.set_text(self.configuration.combine_host_only("http"))
+        self.http_proxy.set_editable(self.configuration.enable_proxy)
+        self.http_proxy.set_sensitive(self.configuration.enable_proxy)
+        self.http_proxy_port.set_text(self.configuration.combine_port_only("http"))
+        self.http_proxy_port.set_editable(self.configuration.enable_proxy)
+        self.http_proxy_port.set_sensitive(self.configuration.enable_proxy)
+        self.http_proxy_details.set_sensitive(self.configuration.enable_proxy)
+
+        self.https_proxy.set_text(self.configuration.combine_host_only("https"))
+        self.https_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_port.set_text(self.configuration.combine_port_only("https"))
+        self.https_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.https_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.ftp_proxy.set_text(self.configuration.combine_host_only("ftp"))
+        self.ftp_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_port.set_text(self.configuration.combine_port_only("ftp"))
+        self.ftp_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.git_proxy.set_text(self.configuration.combine_host_only("git"))
+        self.git_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
+        self.git_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+
+        self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
+        self.cvs_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_port.set_text(self.configuration.combine_port_only("cvs"))
+        self.cvs_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
+        self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
 
+    def proxy_checkbox_toggled_cb(self, button):
+        self.configuration.enable_proxy = self.proxy_checkbox.get_active()
+        if not self.configuration.enable_proxy:
+            self.configuration.same_proxy = False
+            self.same_checkbox.set_active(self.configuration.same_proxy)
+        self.refresh_proxy_components()
+
+    def same_checkbox_toggled_cb(self, button):
+        self.configuration.same_proxy = self.same_checkbox.get_active()
+        self.refresh_proxy_components()
+
+    def response_cb(self, dialog, response_id):        
+        #self.configuration.curr_distro = self.distro_combo.get_active_text()
+        self.configuration.dldir = self.dldir_text.get_text()
+        self.configuration.sstatedir = self.sstatedir_text.get_text()
+        self.configuration.sstatemirror = self.sstatemirror_text.get_text()
+        self.configuration.bbthread = self.bb_spinner.get_value_as_int()
+        self.configuration.pmake = self.pmake_spinner.get_value_as_int()
+                
+        self.configuration.split_proxy("http", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        if self.configuration.same_proxy:
+            self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
+        else:
+            self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
+            self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
+            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
+            self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
+
+        md5 = self.config_md5()
+        self.settings_changed = (self.md5 != md5)
+
+    def create_build_environment_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
+        tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
+        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
+        tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
+        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
+        tooltip = "Select a folder that caches the upstream project source code"
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
+        tooltip = "Select a folder that caches your prebuilt results"
+        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
+        tooltip = "Select the pre-built mirror that will speed your build"
+        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
+        sub_vbox.pack_start(label, expand=False, fill=False)
+        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
+
+        return advanced_vbox
+
+    def create_proxy_page(self):
+        advanced_vbox = gtk.VBox(False, 6)
+        advanced_vbox.set_border_width(6)
+
+        sub_vbox = gtk.VBox(False, 6)
+        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
+        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies that will be used during fetching source code</span>")
+        tooltip = "Set the proxies that will be used during fetching source code or set none for direct the Internet connection"
         info = HobInfoButton(tooltip, self)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(label, expand=True, fill=True)
         hbox.pack_start(info, expand=False, fill=False)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
 
-        hbox.show_all()
-        return hbox, combo
+        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
+        self.direct_checkbox.set_tooltip_text("Check this box to connect the Internet directly without any proxy")
+        self.direct_checkbox.set_active(not self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
 
-    def entry_widget_select_path_cb(self, action, parent, entry):
-        dialog = gtk.FileChooserDialog("", parent,
-                                       gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
-        text = entry.get_text()
-        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
-        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-        HobAltButton.style_button(button)
-        button = dialog.add_button("Open", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
-        response = dialog.run()
-        if response == gtk.RESPONSE_YES:
-            path = dialog.get_filename()
-            entry.set_text(path)
+        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
+        self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
+        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
+        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
+
+        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
+        self.same_checkbox.set_tooltip_text("Use the same proxy as the first proxy i.e. http proxy for all protocols")
+        self.same_checkbox.set_active(self.configuration.same_proxy)
+        hbox = gtk.HBox(False, 12)
+        hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
+        sub_vbox.pack_start(hbox, expand=False, fill=False)
+
+        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
+            "http", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
+            "https", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
+            "ftp", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
+            "git", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
+
+        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
+            "cvs", self, True)
+        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
 
-        dialog.destroy()
+        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
+        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_cb)
 
-    def gen_entry_widget(self, content, parent, tooltip="", need_button=True):
-        hbox = gtk.HBox(False, 12)
-        entry = gtk.Entry()
-        entry.set_text(content)
+        self.refresh_proxy_components()
+        return advanced_vbox
 
-        if need_button:
-            table = gtk.Table(1, 10, True)
-            hbox.pack_start(table, expand=True, fill=True)
-            table.attach(entry, 0, 9, 0, 1)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
-            open_button = gtk.Button()
-            open_button.set_image(image)
-            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
-            table.attach(open_button, 9, 10, 0, 1)
-        else:
-            hbox.pack_start(entry, expand=True, fill=True)
 
-        info = HobInfoButton(tooltip, self)
-        hbox.pack_start(info, expand=False, fill=False)
+    def create_visual_elements(self):
+        self.nb = gtk.Notebook()
+        self.nb.set_show_tabs(True)        
+        self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
+        self.nb.set_current_page(0)
+        self.vbox.pack_start(self.nb, expand=True, fill=True)
+        self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
+
+        self.show_all()
 
-        hbox.show_all()
-        return hbox, entry
 
+
+#
+# AdvancedSettings Dialog
+#
+class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
+    
     def details_cb(self, button, parent, protocol):
         dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
             user = self.configuration.proxies[protocol][1],
@@ -191,30 +493,7 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.configuration.proxies[protocol][1] = dialog.user
             self.configuration.proxies[protocol][2] = dialog.passwd
             self.refresh_proxy_components()
-        dialog.destroy()
-
-    def gen_proxy_entry_widget(self, protocol, parent, need_button=True):
-        hbox = gtk.HBox(False, 12)
-
-        label = gtk.Label(protocol.upper() + " proxy")
-        hbox.pack_start(label, expand=True, fill=False, padding=24)
-
-        proxy_entry = gtk.Entry()
-        proxy_entry.set_size_request(300, -1)
-        hbox.pack_start(proxy_entry, expand=False, fill=False)
-
-        hbox.pack_start(gtk.Label(":"), expand=False, fill=False)
-
-        port_entry = gtk.Entry()
-        port_entry.set_size_request(60, -1)
-        hbox.pack_start(port_entry, expand=False, fill=False)
-
-        details_button = HobAltButton("Details")
-        details_button.connect("clicked", self.details_cb, parent, protocol)
-        hbox.pack_start(details_button, expand=False, fill=False)
-
-        hbox.show_all()
-        return hbox, proxy_entry, port_entry, details_button
+        dialog.destroy()    
 
     def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
         combo_item = self.rootfs_combo.get_active_text()
@@ -412,8 +691,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.nb.set_show_tabs(True)
         self.nb.append_page(self.create_image_types_page(), gtk.Label("Image types"))
         self.nb.append_page(self.create_output_page(), gtk.Label("Output"))
-        self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
-        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
         self.vbox.pack_start(self.nb, expand=True, fill=True)
@@ -422,10 +699,22 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.show_all()
 
     def create_image_types_page(self):
+        main_vbox = gtk.VBox(False, 16)
+        main_vbox.set_border_width(6)
+
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
 
-        rows = (len(self.image_types)+1)/2
+        distro_vbox = gtk.VBox(False, 6)        
+        label = self.gen_label_widget("<span weight=\"bold\">Distro:</span>")
+        tooltip = "Selects the Yocto Project distribution you want"
+        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
+        distro_vbox.pack_start(label, expand=False, fill=False)
+        distro_vbox.pack_start(distro_widget, expand=False, fill=False)
+        main_vbox.pack_start(distro_vbox, expand=False, fill=False)
+
+
+        rows = (len(self.image_types)+1)/3
         table = gtk.Table(rows + 1, 10, True)
         advanced_vbox.pack_start(table, expand=False, fill=False)
 
@@ -451,7 +740,9 @@ class AdvancedSettingDialog (CrumbsDialog):
                 i = 1
                 j = j + 4
 
-        return advanced_vbox
+        main_vbox.pack_start(advanced_vbox, expand=False, fill=False)
+        
+        return main_vbox
 
     def create_output_page(self):
         advanced_vbox = gtk.VBox(False, 6)
@@ -503,122 +794,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
-    def create_build_environment_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
-        tooltip = "Selects the Yocto Project distribution you want"
-        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(distro_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
-        tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
-        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
-        bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
-        tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
-        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
-        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
-        pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
-        tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
-        tooltip = "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
-        tooltip = "Select the pre-built mirror that will speed your build"
-        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
-        sub_vbox.pack_start(label, expand=False, fill=False)
-        sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
-
-        return advanced_vbox
-
-    def create_proxy_page(self):
-        advanced_vbox = gtk.VBox(False, 6)
-        advanced_vbox.set_border_width(6)
-
-        sub_vbox = gtk.VBox(False, 6)
-        advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Set the proxies that will be used during fetching source code</span>")
-        tooltip = "Set the proxies that will be used during fetching source code or set none for direct the Internet connection"
-        info = HobInfoButton(tooltip, self)
-        hbox = gtk.HBox(False, 12)
-        hbox.pack_start(label, expand=True, fill=True)
-        hbox.pack_start(info, expand=False, fill=False)
-        sub_vbox.pack_start(hbox, expand=False, fill=False)
-
-        self.direct_checkbox = gtk.RadioButton(None, "Direct internet connection")
-        self.direct_checkbox.set_tooltip_text("Check this box to connect the Internet directly without any proxy")
-        self.direct_checkbox.set_active(not self.configuration.enable_proxy)
-        sub_vbox.pack_start(self.direct_checkbox, expand=False, fill=False)
-
-        self.proxy_checkbox = gtk.RadioButton(self.direct_checkbox, "Manual proxy configuration")
-        self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
-        self.proxy_checkbox.set_active(self.configuration.enable_proxy)
-        sub_vbox.pack_start(self.proxy_checkbox, expand=False, fill=False)
-
-        self.same_checkbox = gtk.CheckButton("Use the same proxy for all protocols")
-        self.same_checkbox.set_tooltip_text("Use the same proxy as the first proxy i.e. http proxy for all protocols")
-        self.same_checkbox.set_active(self.configuration.same_proxy)
-        hbox = gtk.HBox(False, 12)
-        hbox.pack_start(self.same_checkbox, expand=False, fill=False, padding=24)
-        sub_vbox.pack_start(hbox, expand=False, fill=False)
-
-        proxy_widget, self.http_proxy, self.http_proxy_port, self.http_proxy_details = self.gen_proxy_entry_widget(
-            "http", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.https_proxy, self.https_proxy_port, self.https_proxy_details = self.gen_proxy_entry_widget(
-            "https", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.ftp_proxy, self.ftp_proxy_port, self.ftp_proxy_details = self.gen_proxy_entry_widget(
-            "ftp", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.git_proxy, self.git_proxy_port, self.git_proxy_details = self.gen_proxy_entry_widget(
-            "git", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        proxy_widget, self.cvs_proxy, self.cvs_proxy_port, self.cvs_proxy_details = self.gen_proxy_entry_widget(
-            "cvs", self, True)
-        sub_vbox.pack_start(proxy_widget, expand=False, fill=False)
-
-        self.direct_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
-        self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
-        self.same_checkbox.connect("toggled", self.same_checkbox_toggled_cb)
-
-        self.refresh_proxy_components()
-        return advanced_vbox
-
+    
     def create_others_page(self):
         advanced_vbox = gtk.VBox(False, 6)
         advanced_vbox.set_border_width(6)
@@ -633,60 +809,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         return advanced_vbox
 
-    def refresh_proxy_components(self):
-        self.same_checkbox.set_sensitive(self.configuration.enable_proxy)
-
-        self.http_proxy.set_text(self.configuration.combine_host_only("http"))
-        self.http_proxy.set_editable(self.configuration.enable_proxy)
-        self.http_proxy.set_sensitive(self.configuration.enable_proxy)
-        self.http_proxy_port.set_text(self.configuration.combine_port_only("http"))
-        self.http_proxy_port.set_editable(self.configuration.enable_proxy)
-        self.http_proxy_port.set_sensitive(self.configuration.enable_proxy)
-        self.http_proxy_details.set_sensitive(self.configuration.enable_proxy)
-
-        self.https_proxy.set_text(self.configuration.combine_host_only("https"))
-        self.https_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.https_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.https_proxy_port.set_text(self.configuration.combine_port_only("https"))
-        self.https_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.https_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.https_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-
-        self.ftp_proxy.set_text(self.configuration.combine_host_only("ftp"))
-        self.ftp_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.ftp_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.ftp_proxy_port.set_text(self.configuration.combine_port_only("ftp"))
-        self.ftp_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.ftp_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.ftp_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-
-        self.git_proxy.set_text(self.configuration.combine_host_only("git"))
-        self.git_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_port.set_text(self.configuration.combine_port_only("git"))
-        self.git_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.git_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-
-        self.cvs_proxy.set_text(self.configuration.combine_host_only("cvs"))
-        self.cvs_proxy.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.cvs_proxy.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.cvs_proxy_port.set_text(self.configuration.combine_port_only("cvs"))
-        self.cvs_proxy_port.set_editable(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.cvs_proxy_port.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-        self.cvs_proxy_details.set_sensitive(self.configuration.enable_proxy and (not self.configuration.same_proxy))
-
-    def proxy_checkbox_toggled_cb(self, button):
-        self.configuration.enable_proxy = self.proxy_checkbox.get_active()
-        if not self.configuration.enable_proxy:
-            self.configuration.same_proxy = False
-            self.same_checkbox.set_active(self.configuration.same_proxy)
-        self.refresh_proxy_components()
-
-    def same_checkbox_toggled_cb(self, button):
-        self.configuration.same_proxy = self.same_checkbox.get_active()
-        self.refresh_proxy_components()
-
+    
     def response_cb(self, dialog, response_id):
         package_format = []
         package_format.append(self.rootfs_combo.get_active_text())
@@ -695,12 +818,7 @@ class AdvancedSettingDialog (CrumbsDialog):
                 package_format.append(child.get_label())
         self.configuration.curr_package_format = " ".join(package_format)
 
-        self.configuration.curr_distro = self.distro_combo.get_active_text()
-        self.configuration.dldir = self.dldir_text.get_text()
-        self.configuration.sstatedir = self.sstatedir_text.get_text()
-        self.configuration.sstatemirror = self.sstatemirror_text.get_text()
-        self.configuration.bbthread = self.bb_spinner.get_value_as_int()
-        self.configuration.pmake = self.pmake_spinner.get_value_as_int()
+        self.configuration.curr_distro = self.distro_combo.get_active_text()        
         self.configuration.image_rootfs_size = self.rootfs_size_spinner.get_value_as_int() * 1024
         self.configuration.image_extra_size = self.extra_size_spinner.get_value_as_int() * 1024
 
@@ -727,19 +845,7 @@ class AdvancedSettingDialog (CrumbsDialog):
             key = self.setting_store.get_value(it, 0)
             value = self.setting_store.get_value(it, 1)
             self.configuration.extra_setting[key] = value
-            it = self.setting_store.iter_next(it)
-
-        self.configuration.split_proxy("http", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-        if self.configuration.same_proxy:
-            self.configuration.split_proxy("https", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("ftp", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-            self.configuration.split_proxy("cvs", self.http_proxy.get_text() + ":" + self.http_proxy_port.get_text())
-        else:
-            self.configuration.split_proxy("https", self.https_proxy.get_text() + ":" + self.https_proxy_port.get_text())
-            self.configuration.split_proxy("ftp", self.ftp_proxy.get_text() + ":" + self.ftp_proxy_port.get_text())
-            self.configuration.split_proxy("git", self.git_proxy.get_text() + ":" + self.git_proxy_port.get_text())
-            self.configuration.split_proxy("cvs", self.cvs_proxy.get_text() + ":" + self.cvs_proxy_port.get_text())
+            it = self.setting_store.iter_next(it)        
 
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 6aeb6dc..e665f38 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -205,17 +205,26 @@ class ImageConfigurationPage (HobPage):
 
         self.image_desc = gtk.Label()
         self.image_desc.set_alignment(0.0, 0.5)
-        self.image_desc.set_size_request(360, -1)
+        self.image_desc.set_size_request(256, -1)
         self.image_desc.set_justify(gtk.JUSTIFY_LEFT)
         self.image_desc.set_line_wrap(True)
 
+        # button to view recipes
+        icon_file = hic.ICON_RCIPE_DISPLAY_FILE
+        hover_file = hic.ICON_RCIPE_HOVER_FILE
+        self.view_adv_configuration_button = HobImageButton("Advanced configuration",
+                                                                 "Select image types, package formats, etc",
+                                                                 icon_file, hover_file)        
+        self.view_adv_configuration_button.connect("clicked", self.view_adv_configuration_button_clicked_cb)
+
         self.image_separator = gtk.HSeparator()
 
     def set_config_baseimg_layout(self):
         self.gtable.attach(self.image_title, 0, 40, 15, 17)
         self.gtable.attach(self.image_title_desc, 0, 40, 18, 22)
         self.gtable.attach(self.image_combo, 0, 12, 23, 26)
-        self.gtable.attach(self.image_desc, 13, 38, 23, 28)
+        self.gtable.attach(self.image_desc, 0, 12, 27, 33)
+        self.gtable.attach(self.view_adv_configuration_button, 14, 36, 23, 28)
         self.gtable.attach(self.image_separator, 0, 40, 35, 36)
 
     def create_config_build_button(self):
@@ -413,6 +422,14 @@ class ImageConfigurationPage (HobPage):
     def layer_button_clicked_cb(self, button):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
+        
+    def view_adv_configuration_button_clicked_cb(self, button):
+        # Create an advanced settings dialog
+        response, settings_changed = self.builder.show_adv_settings_dialog()
+        if not response:
+            return
+        if settings_changed:
+            self.builder.reparse_post_adv_settings()        
 
     def just_bake_button_clicked_cb(self, button):
         self.builder.just_bake()
@@ -432,7 +449,7 @@ class ImageConfigurationPage (HobPage):
 
     def settings_button_clicked_cb(self, button):
         # Create an advanced settings dialog
-        response, settings_changed = self.builder.show_adv_settings_dialog()
+        response, settings_changed = self.builder.show_simple_settings_dialog()
         if not response:
             return
         if settings_changed:
-- 
1.7.9.5



