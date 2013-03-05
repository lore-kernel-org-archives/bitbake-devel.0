Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBV-0003eO-SH
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:46 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343627"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:13 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:24 +0200
Message-Id: <1362497791-30020-5-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 04/11] added information for the information dialogs
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:49 -0000

added information so that it would display
 correctly in the information dialogs.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index f5397c3..2911906 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -208,7 +208,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.all_distros[ i ] = "Default"
             if self.configuration.curr_distro == "defaultsetup":
                 self.configuration.curr_distro = "Default"
-        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
+        distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros,"<b>Distro</b>" + "*" + tooltip)
         distro_vbox.pack_start(label, expand=False, fill=False)
         distro_vbox.pack_start(distro_widget, expand=False, fill=False)
         main_vbox.pack_start(distro_vbox, expand=False, fill=False)
@@ -219,7 +219,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(table, expand=False, fill=False)
 
         tooltip = "Image file system types you want."
-        info = HobInfoButton(tooltip, self)
+        info = HobInfoButton("<b>Image types</b>" + "*" + tooltip, self)
         label = self.gen_label_widget("Image types:")
         align = gtk.Alignment(0, 0.5, 0, 0)
         table.attach(align, 0, 4, 0, 1)
@@ -257,7 +257,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         tooltip_combo = "Selects the package format used to generate rootfs."
         tooltip_extra = "Selects extra package formats to build"
-        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip_combo, tooltip_extra)
+        pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats,"<b>Root file system package format</b>" + "*" + tooltip_combo,"<b>Additional package formats</b>" + "*" + tooltip_extra)
         sub_vbox.pack_start(pkgfmt_widget, expand=False, fill=False)
 
         advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Image size</span>'), expand=False, fill=False)
@@ -265,7 +265,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Image basic size (in MB)")
         tooltip = "Sets the basic size of your target image.\nThis is the basic size of your target image unless your selected package size exceeds this value or you select \'Image Extra Size\'."
-        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536, tooltip)
+        rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 65536,"<b>Image basic size</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(rootfs_size_widget, expand=False, fill=False)
 
@@ -273,7 +273,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("Additional free space (in MB)")
         tooltip = "Sets the extra free space of your target image.\nBy default, the system reserves 30% of your image size as free space. If your image contains zypper, it brings in 50MB more space. The maximum free space is 64GB."
-        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536, tooltip)
+        extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 65536,"<b>Additional free space</b>" + "*" + tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(extra_size_widget, expand=False, fill=False)
 
@@ -295,7 +295,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
 
         tooltip = "Selects the host platform for which you want to run the toolchain"
-        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines, tooltip)
+        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines,"<b>Build toolchain</b>" + "*" + tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
         return advanced_vbox
-- 
1.7.9.5



