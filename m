Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id C72BE6A9E1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2013 14:55:26 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 02 Aug 2013 07:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,801,1367996400"; d="scan'208";a="276838573"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Aug 2013 07:55:25 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2013 17:57:55 +0300
Message-Id: <1375455475-15015-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/advancedsettings: change toolchain labels to sdk labels
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 02 Aug 2013 14:55:26 -0000

In order to be easier for the user to understand, we have changed the
toolchain labels to sdk.

[YOCTO #3808]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |   21 ++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
index bbcaba8..86a65ae 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/advancedsettingsdialog.py
@@ -131,7 +131,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.rootfs_size_spinner = None
         self.extra_size_spinner = None
         self.gplv3_checkbox = None
-        self.toolchain_checkbox = None
+        self.sdk_checkbox = None
         self.image_types_checkbuttons = {}
 
         self.md5 = self.config_md5()
@@ -286,16 +286,17 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
             self.gplv3_checkbox.set_active(False)
         advanced_vbox.pack_start(self.gplv3_checkbox, expand=False, fill=False)
 
-        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">Toolchain</span>'), expand=False, fill=False)
+        advanced_vbox.pack_start(self.gen_label_widget('<span weight="bold">SDK</span>'), expand=False, fill=False)
         sub_hbox = gtk.HBox(False, 6)
         advanced_vbox.pack_start(sub_hbox, expand=False, fill=False)
-        self.toolchain_checkbox = gtk.CheckButton("Build toolchain")
-        self.toolchain_checkbox.set_tooltip_text("Check this box to build the related toolchain with your image")
-        self.toolchain_checkbox.set_active(self.configuration.toolchain_build)
-        sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
-
-        tooltip = "Selects the host platform for which you want to run the toolchain"
-        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines,"<b>Build toolchain</b>" + "*" + tooltip)
+        self.sdk_checkbox = gtk.CheckButton("Populate SDK")
+        tooltip = "Check this box to generate an SDK tarball that consists of the cross-toolchain and a sysroot that contains development packages for your image."
+        self.sdk_checkbox.set_tooltip_text(tooltip)
+        self.sdk_checkbox.set_active(self.configuration.toolchain_build)
+        sub_hbox.pack_start(self.sdk_checkbox, expand=False, fill=False)
+
+        tooltip = "Select the host platform for which you want to run the toolchain contained in the SDK tarball."
+        sdk_machine_widget, self.sdk_machine_combo = self.gen_combo_widget(self.configuration.curr_sdk_machine, self.all_sdk_machines,"<b>Populate SDK</b>" + "*" + tooltip)
         sub_hbox.pack_start(sdk_machine_widget, expand=False, fill=False)
 
         return advanced_vbox
@@ -330,7 +331,7 @@ class AdvancedSettingsDialog (CrumbsDialog, SettingsUIHelper):
                 self.configuration.incompat_license = " ".join(self.configuration.incompat_license or [])
         self.configuration.incompat_license = self.configuration.incompat_license.strip()
 
-        self.configuration.toolchain_build = self.toolchain_checkbox.get_active()
+        self.configuration.toolchain_build = self.sdk_checkbox.get_active()
         self.configuration.curr_sdk_machine = self.sdk_machine_combo.get_active_text()
         md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
-- 
1.7.9.5


