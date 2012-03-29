Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDw-0007Rt-Bc
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:13:04 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Mar 2012 05:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124772137"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 29 Mar 2012 05:03:58 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:19 +0800
Message-Id: <72d2bc578dbd5643bb0b70b1ec6f2e2dc35f5e58.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 13/14] Hob: Fix the setting hash calculation
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
X-List-Received-Date: Thu, 29 Mar 2012 12:13:05 -0000

Sometimes even setting are not changed, the hash values differs due to
variable order issue. This commit fixes the issue.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hig.py |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index f5a7dd3..ad02033 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -337,19 +337,30 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.setting_store = None
         self.image_types_checkbuttons = {}
 
-        self.variables = {}
-        self.variables["PACKAGE_FORMAT"] = self.configuration.curr_package_format
-        self.variables["INCOMPATIBLE_LICENSE"] = self.configuration.incompat_license
-        self.variables["IMAGE_FSTYPES"] = self.configuration.image_fstypes
-        for key in self.configuration.extra_setting.keys():
-            self.variables[key] = self.configuration.extra_setting[key]
-        self.md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
+        self.md5 = self.config_md5()
         self.settings_changed = False
 
         # create visual elements on the dialog
         self.create_visual_elements()
         self.connect("response", self.response_cb)
 
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
+        for key in self.configuration.extra_setting.keys():
+            data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
+        return hashlib.md5(data).hexdigest()
+
     def create_visual_elements(self):
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(True)
@@ -589,15 +600,12 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.cvs_proxy_text.set_sensitive(self.enable_proxy)
 
     def response_cb(self, dialog, response_id):
-        self.variables = {}
-
         package_format = []
         package_format.append(self.rootfs_combo.get_active_text())
         for child in self.check_hbox:
             if isinstance(child, gtk.CheckButton) and child.get_active():
                 package_format.append(child.get_label())
         self.configuration.curr_package_format = " ".join(package_format)
-        self.variables["PACKAGE_FORMAT"] = self.configuration.curr_package_format
 
         self.configuration.curr_distro = self.distro_combo.get_active_text()
         self.configuration.dldir = self.dldir_text.get_text()
@@ -613,7 +621,6 @@ class AdvancedSettingDialog (CrumbsDialog):
             if self.image_types_checkbuttons[image_type].get_active():
                 self.configuration.image_fstypes += (" " + image_type)
         self.configuration.image_fstypes.strip()
-        self.variables["IMAGE_FSTYPES"] = self.configuration.image_fstypes
 
         if self.gplv3_checkbox.get_active():
             if "GPLv3" not in self.configuration.incompat_license.split():
@@ -623,7 +630,6 @@ class AdvancedSettingDialog (CrumbsDialog):
                 self.configuration.incompat_license = self.configuration.incompat_license.split().remove("GPLv3")
                 self.configuration.incompat_license = " ".join(self.configuration.incompat_license or [])
         self.configuration.incompat_license = self.configuration.incompat_license.strip()
-        self.variables["INCOMPATIBLE_LICENSE"] = self.configuration.incompat_license
 
         self.configuration.toolchain_build = self.toolchain_checkbox.get_active()
 
@@ -633,7 +639,6 @@ class AdvancedSettingDialog (CrumbsDialog):
             key = self.setting_store.get_value(it, 0)
             value = self.setting_store.get_value(it, 1)
             self.configuration.extra_setting[key] = value
-            self.variables[key] = value
             it = self.setting_store.iter_next(it)
 
         self.configuration.all_proxy = self.all_proxy_text.get_text()
@@ -643,7 +648,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.configuration.git_proxy_host, self.configuration.git_proxy_port = self.git_proxy_text.get_text().split(':')
         self.configuration.cvs_proxy_host, self.configuration.cvs_proxy_port = self.cvs_proxy_text.get_text().split(':')
 
-        md5 = hashlib.md5(str(sorted(self.variables.items()))).hexdigest()
+        md5 = self.config_md5()
         self.settings_changed = (self.md5 != md5)
 
 #
-- 
1.7.4.1



