Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1TIgTR-0006mf-UK
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Oct 2012 15:55:54 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Oct 2012 06:42:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,517,1344236400"; d="scan'208";a="217514154"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by orsmga002.jf.intel.com with ESMTP; 01 Oct 2012 06:42:54 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2012 16:45:25 +0300
Message-Id: <1349099125-27055-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [hob] Yet another round of fixes for #2162
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
X-List-Received-Date: Mon, 01 Oct 2012 13:55:54 -0000

1. Replace some labels in the "Build environment" tab
2. 'defaultsetup' changed to 'Default' in the "Image types" tab
3. Fixed the moving icon in the "Output" tab

For more details: https://bugzilla.yoctoproject.org/show_bug.cgi?id=2162

[Yocto #2162]

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2ef8e36..a629d8f 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -507,10 +507,10 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(pmake_widget, expand=False, fill=False)
 
-        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Cache directories and mirror</span>'), expand=False, fill=False)
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Downloaded source code</span>'), expand=False, fill=False)
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("Download directory")
+        label = self.gen_label_widget("Downloads directory")
         tooltip = "Select a folder that caches the upstream project source code"
         dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -855,13 +855,19 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
 
     def rootfs_combo_changed_cb(self, rootfs_combo, all_package_format, check_hbox):
         combo_item = self.rootfs_combo.get_active_text()
+        modified = False
         for child in check_hbox.get_children():
             if isinstance(child, gtk.CheckButton):
                 check_hbox.remove(child)
+                modified = True
         for format in all_package_format:
             if format != combo_item:
                 check_button = gtk.CheckButton(format)
                 check_hbox.pack_start(check_button, expand=False, fill=False)
+                modified = True
+        if modified:
+            check_hbox.remove(self.pkgfmt_info)
+            check_hbox.pack_start(self.pkgfmt_info, expand=False, fill=False)
         check_hbox.show_all()
 
     def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip_combo="", tooltip_extra=""):
@@ -889,8 +895,8 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
                 check_button.set_active(is_active)
                 check_hbox.pack_start(check_button, expand=False, fill=False)
 
-        info = HobInfoButton(tooltip_extra, self)
-        check_hbox.pack_start(info, expand=False, fill=False)
+        self.pkgfmt_info = HobInfoButton(tooltip_extra, self)
+        check_hbox.pack_start(self.pkgfmt_info, expand=False, fill=False)
 
         rootfs_combo.connect("changed", self.rootfs_combo_changed_cb, all_package_format, check_hbox)
 
@@ -908,7 +914,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         self.configuration = configuration
         self.image_types = all_image_types
         self.all_package_formats = all_package_formats
-        self.all_distros = all_distros
+        self.all_distros = all_distros[:]
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
 
@@ -991,6 +997,14 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         distro_vbox = gtk.VBox(False, 6)        
         label = self.gen_label_widget("Distro:")
         tooltip = "Selects the Yocto Project distribution you want"
+        try:
+            i = self.all_distros.index( "defaultsetup" )
+        except ValueError:
+            i = -1
+        if i != -1:
+            self.all_distros[ i ] = "Default"
+            if self.configuration.curr_distro == "defaultsetup":
+                self.configuration.curr_distro = "Default"
         distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
         distro_vbox.pack_start(label, expand=False, fill=False)
         distro_vbox.pack_start(distro_widget, expand=False, fill=False)
@@ -1091,7 +1105,10 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
                 package_format.append(child.get_label())
         self.configuration.curr_package_format = " ".join(package_format)
 
-        self.configuration.curr_distro = self.distro_combo.get_active_text()        
+        distro = self.distro_combo.get_active_text()
+        if distro == "Default":
+            distro = "defaultsetup"
+        self.configuration.curr_distro = distro
         self.configuration.image_rootfs_size = self.rootfs_size_spinner.get_value_as_int() * 1024
         self.configuration.image_extra_size = self.extra_size_spinner.get_value_as_int() * 1024
 
-- 
1.7.9.5



