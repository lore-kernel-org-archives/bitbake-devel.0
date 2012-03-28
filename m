Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvap-0005xU-EM
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 09:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="122715054"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 28 Mar 2012 09:10:26 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:58 +0800
Message-Id: <4379b2b2984f379816e7ea6dbf17bda3353db4e3.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
References: <ba0cac313670c2e9f5c77d04e1eb07ef3aec9352.1332952559.git.shane.wang@intel.com>
In-Reply-To: <cover.1332952559.git.shane.wang@intel.com>
References: <cover.1332952559.git.shane.wang@intel.com>
Subject: [PATCH 5/5] Hob: change some words in settings dialog to make them consistent
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:28 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4753c92..1aa055e 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -399,7 +399,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Packaging Format:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Packaging format:</span>")
         tooltip = "Select package formats that will be used. "
         tooltip += "The first format will be used for final image"
         pkgfmt_widget, self.rootfs_combo, self.check_hbox = self.gen_pkgfmt_widget(self.configuration.curr_package_format, self.all_package_formats, tooltip)
@@ -408,7 +408,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Image Rootfs Size: (MB)</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Image rootfs size: (MB)</span>")
         tooltip = "Sets the size of your target image.\nThis is the basic size of your target image, unless your selected package size exceeds this value, or you set value to \"Image Extra Size\"."
         rootfs_size_widget, self.rootfs_size_spinner = self.gen_spinner_widget(int(self.configuration.image_rootfs_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -416,7 +416,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Image Extra Size: (MB)</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Image extra size: (MB)</span>")
         tooltip = "Sets the extra free space of your target image.\nDefaultly, system will reserve 30% of your image size as your free space. If your image contains zypper, it will bring in 50MB more space. The maximum free space is 1024MB."
         extra_size_widget, self.extra_size_spinner = self.gen_spinner_widget(int(self.configuration.image_extra_size*1.0/1024), 0, 1024, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -432,7 +432,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_hbox = gtk.HBox(False, 6)
         advanced_vbox.pack_start(sub_hbox, expand=False, fill=False)
-        self.toolchain_checkbox = gtk.CheckButton("Build Toolchain")
+        self.toolchain_checkbox = gtk.CheckButton("Build toolchain")
         self.toolchain_checkbox.set_tooltip_text("Check this box to build the related toolchain with your image")
         self.toolchain_checkbox.set_active(self.configuration.toolchain_build)
         sub_hbox.pack_start(self.toolchain_checkbox, expand=False, fill=False)
@@ -449,7 +449,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select Distro:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select distro:</span>")
         tooltip = "This is the Yocto distribution you would like to use"
         distro_widget, self.distro_combo = self.gen_combo_widget(self.configuration.curr_distro, self.all_distros, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -457,7 +457,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">BB_NUMBER_THREADS:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">BB number threads:</span>")
         tooltip = "Sets the number of threads that bitbake tasks can run simultaneously"
         bbthread_widget, self.bb_spinner = self.gen_spinner_widget(self.configuration.bbthread, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -465,7 +465,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">PARALLEL_MAKE:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Parallel make:</span>")
         tooltip = "Sets the make parallism, as known as 'make -j'"
         pmake_widget, self.pmake_spinner = self.gen_spinner_widget(self.configuration.pmake, 1, self.max_threads, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -473,7 +473,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Set download directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
         dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -481,7 +481,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE directory:</span>")
         tooltip = "Select a folder that caches your prebuilt results"
         sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -489,7 +489,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
+        label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE mirror:</span>")
         tooltip = "Select the prebuilt mirror that will fasten your build speed"
         sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
@@ -503,7 +503,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         sub_vbox = gtk.VBox(False, 6)
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
-        self.proxy_checkbox = gtk.CheckButton("Enable Proxy")
+        self.proxy_checkbox = gtk.CheckButton("Enable proxy")
         self.proxy_checkbox.set_tooltip_text("Check this box to setup the proxy you specified")
         self.proxy_checkbox.set_active(self.enable_proxy)
         self.proxy_checkbox.connect("toggled", self.proxy_checkbox_toggled_cb)
-- 
1.7.6



