Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAMO-00076R-Jf
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:05 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Apr 2012 01:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151415319"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2012 01:44:49 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:42:01 +0800
Message-Id: <4f3c8cd321b16cee3a0430df9df8bbf447d00266.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333960654.git.dongxiao.xu@intel.com>
References: <cover.1333960654.git.dongxiao.xu@intel.com>
Subject: [PATCH 5/6] Hob: Fix tooltips in Settings dialog
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:05 -0000

This fixes [YOCTO #2229]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py                 |   38 ++++++++++++++++--------------
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 9adb281..016fb59 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -182,7 +182,7 @@ class AdvancedSettingDialog (CrumbsDialog):
                 check_hbox.pack_start(check_button, expand=False, fill=False)
         check_hbox.show_all()
 
-    def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip=""):
+    def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip_combo="", tooltip_extra=""):
         pkgfmt_hbox = gtk.HBox(False, 24)
 
         rootfs_vbox = gtk.VBox(False, 6)
@@ -195,8 +195,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         if curr_package_format:
             rootfs_format = curr_package_format.split()[0]
 
-        tooltip = "Package format that is used to generate rootfs"
-        rootfs_format_widget, rootfs_combo = self.gen_combo_widget(rootfs_format, all_package_format, tooltip)
+        rootfs_format_widget, rootfs_combo = self.gen_combo_widget(rootfs_format, all_package_format, tooltip_combo)
         rootfs_vbox.pack_start(rootfs_format_widget, expand=False, fill=False)
 
         extra_vbox = gtk.VBox(False, 6)
@@ -214,8 +213,7 @@ class AdvancedSettingDialog (CrumbsDialog):
                 check_button.set_active(is_active)
                 check_hbox.pack_start(check_button, expand=False, fill=False)
 
-        tooltip = "Extra package formats to build"
-        info = HobInfoButton(tooltip, self)
+        info = HobInfoButton(tooltip_extra, self)
         check_hbox.pack_end(info, expand=False, fill=False)
 
         rootfs_combo.connect("changed", self.rootfs_combo_changed_cb, all_package_format, check_hbox)
@@ -383,7 +381,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         table = gtk.Table(rows + 1, 10, True)
         advanced_vbox.pack_start(table, expand=False, fill=False)
 
-        tooltip = "Select image file system types that will be used."
+        tooltip = "Image file system types you want."
         info = HobInfoButton(tooltip, self)
         label = self.gen_label_widget("<span weight=\"bold\">Select image types:</span>")
         table.attach(label, 0, 9, 0, 1)
@@ -411,16 +409,16 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Packaging format:</span>")
-        tooltip = "Select package formats that will be used. "
-        tooltip += "The first format will be used for final image"
-        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
+        tooltip_combo = "Selects the package format used to generate rootfs."
+        tooltip_extra = "Selects extra package formats to build"
+        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip_combo, tooltip_extra)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image rootfs size: (MB)</span>")
-        tooltip = "Sets the size of your target image.\nThis is the basic size of your target image, unless your selected package size exceeds this value, or you set value to \"Image Extra Size\"."
+        tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
         rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
@@ -428,7 +426,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Image extra size: (MB)</span>")
-        tooltip = "Sets the extra free space of your target image.\nDefaultly, system will reserve 30% of your image size as your free space. If your image contains zypper, it will bring in 50MB more space. The maximum free space is 1024MB."
+        tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 1024MB."
         extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
@@ -448,7 +446,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.toolchain_checkbox.set_active(self.configuration.toolchain_build)
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
 
-        tooltip = "This is the Host platform you would like to run the toolchain"
+        tooltip = "Selects the Host platform for which you want to run the toolchain"
         sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
@@ -461,7 +459,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
-        tooltip = "This is the Yocto distribution you would like to use"
+        tooltip = "Selects the Yocto Project distribution you want"
         distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(distro_widget, expand=False, fill=False)
@@ -469,7 +467,9 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
-        tooltip = "Sets the number of threads that bitbake tasks can run simultaneously"
+        tooltip = "Sets the number of threads that BitBake tasks can simultaneously run. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-BB_NUMBER_THREADS\">Poky reference manual</a> for information"
         bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(bbthread_widget, expand=False, fill=False)
@@ -477,14 +477,16 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
-        tooltip = "Sets the make parallism, as known as 'make -j'"
+        tooltip = "Sets the maximum number of threads the host can use during the build. See the <a href=\""
+        tooltip += "http://www.yoctoproject.org/docs/current/poky-ref-manual/"
+        tooltip += "poky-ref-manual.html#var-PARALLEL_MAKE\">Poky reference manual</a> for information"
         pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Set download directory:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select download directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
         dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -501,7 +503,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
-        tooltip = "Select the prebuilt mirror that will fasten your build speed"
+        tooltip = "Select the pre-built mirror that will speed your build"
         sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
@@ -577,7 +579,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=True, fill=True)
         label = self.gen_label_widget("<span weight=\"bold\">Add your own variables:</span>")
-        tooltip = "This is the key/value pair for your extra settings"
+        tooltip = "These are key/value pairs for your extra settings. Click \'Add\' and then directly edit the key and the value"
         setting_widget, self.setting_store = self.gen_editable_settings(self.configuration.extra_setting, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(setting_widget, expand=True, fill=True)
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 2d438d5..44c94bf 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -153,7 +153,7 @@ class RecipeSelectionPage (HobPage):
 
         self.build_packages_button = HobButton('Build packages')
         self.build_packages_button.set_size_request(205, 49)
-        self.build_packages_button.set_tooltip_text("Build packages for customization")
+        self.build_packages_button.set_tooltip_text("Build selected recipes into packages")
         self.build_packages_button.set_flags(gtk.CAN_DEFAULT)
         self.build_packages_button.grab_default()
         self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
-- 
1.7.4.1



