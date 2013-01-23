Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TxzNt-0007xT-CF
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 13:25:40 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Jan 2013 04:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,521,1355126400"; d="scan'208";a="277412527"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2013 04:09:17 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Jan 2013 14:13:44 +0200
Message-Id: <1358943224-21272-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] hob: hob do not use .hob dir for variables from local.conf and bblayers.conf
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
X-List-Received-Date: Wed, 23 Jan 2013 12:25:40 -0000

If .hob exists, hob takes the variable from there. Change to not override anymore
the variables which comes from bblayers.conf and local.conf

[YOCTO #2934]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   27 +++-----------------
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   11 ++++----
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index d57cf4c..9da926d 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -190,20 +190,6 @@ class Configuration:
         self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
     def load(self, template):
-        self.curr_mach = template.getVar("MACHINE")
-        self.curr_package_format = " ".join(template.getVar("PACKAGE_CLASSES").split("package_")).strip()
-        self.curr_distro = template.getVar("DISTRO")
-        self.dldir = template.getVar("DL_DIR")
-        self.sstatedir = template.getVar("SSTATE_DIR")
-        self.sstatemirror = template.getVar("SSTATE_MIRRORS")
-        try:
-            self.pmake = int(template.getVar("PARALLEL_MAKE").split()[1])
-        except:
-            pass
-        try:
-            self.bbthread = int(template.getVar("BB_NUMBER_THREADS"))
-        except:
-            pass
         try:
             self.image_rootfs_size = int(template.getVar("IMAGE_ROOTFS_SIZE"))
         except:
@@ -215,13 +201,9 @@ class Configuration:
         # image_overhead_factor is read-only.
         self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
         self.curr_sdk_machine = template.getVar("SDKMACHINE")
-        self.conf_version = template.getVar("CONF_VERSION")
-        self.lconf_version = template.getVar("LCONF_VERSION")
         self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
         self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
         self.image_fstypes = template.getVar("IMAGE_FSTYPES")
-        # bblayers.conf
-        self.layers = template.getVar("BBLAYERS").split()
         # image/recipes/packages
         self.selected_image = template.getVar("__SELECTED_IMAGE__")
         self.selected_recipes = template.getVar("DEPENDS").split()
@@ -561,11 +543,10 @@ class Builder(gtk.Window):
 
     def initiate_new_build_async(self):
         self.switch_page(self.MACHINE_SELECTION)
-        if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == False:
-            self.show_sanity_check_page()
-            self.handler.init_cooker()
-            self.handler.set_extra_inherit("image_types")
-            self.generate_configuration()
+        self.show_sanity_check_page()
+        self.handler.init_cooker()
+        self.handler.set_extra_inherit("image_types")
+        self.generate_configuration()
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index 3642e9b..50c7510 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -323,11 +323,12 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
                         sstatemirrors = sstatemirrors[1:]
 
                     sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
-                    if sstatemirror_fields[0] == "file://(.*)":
-                        sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
-                    else:
-                        sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
-                    self.sstatemirrors_list.append(sm_list)
+                    if len(sstatemirror_fields):
+                        if sstatemirror_fields[0] == "file://(.*)":
+                            sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
+                        else:
+                            sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+                        self.sstatemirrors_list.append(sm_list)
 
         index = 0
         for mirror in self.sstatemirrors_list:
-- 
1.7.9.5



