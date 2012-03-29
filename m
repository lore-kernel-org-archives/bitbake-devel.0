Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDu-0007V7-5u
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:13:02 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Mar 2012 05:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="135069049"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2012 05:03:57 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:18 +0800
Message-Id: <529791558c195ef7e4c2203d42d2ed4123154e6a.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 12/14] Hob: Change the format to store image_fstype variable
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
X-List-Received-Date: Thu, 29 Mar 2012 12:13:02 -0000

Use string format to store image_fstype instead of a list.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    6 +++---
 lib/bb/ui/crumbs/hig.py             |    7 ++++---
 lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index fd61b31..b5a6919 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -93,7 +93,7 @@ class Configuration:
         self.curr_sdk_machine = params["sdk_machine"]
         self.conf_version = params["conf_version"]
         self.lconf_version = params["lconf_version"]
-        self.image_fstypes = params["image_fstypes"].split()
+        self.image_fstypes = params["image_fstypes"]
         # bblayers.conf
         self.layers = params["layer"].split()
 
@@ -115,7 +115,7 @@ class Configuration:
         self.lconf_version = template.getVar("LCONF_VERSION")
         self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
         self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
-        self.image_fstypes = template.getVar("IMAGE_FSTYPES").split()
+        self.image_fstypes = template.getVar("IMAGE_FSTYPES")
         # bblayers.conf
         self.layers = template.getVar("BBLAYERS").split()
         # image/recipes/packages
@@ -152,7 +152,7 @@ class Configuration:
         template.setVar("LCONF_VERSION", self.lconf_version)
         template.setVar("EXTRA_SETTING", self.extra_setting)
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
-        template.setVar("IMAGE_FSTYPES", " ".join(self.image_fstypes).lstrip(" "))
+        template.setVar("IMAGE_FSTYPES", self.image_fstypes)
         # image/recipes/packages
         self.selected_image = filename
         template.setVar("__SELECTED_IMAGE__", self.selected_image)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 4753c92..f5a7dd3 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -384,7 +384,7 @@ class AdvancedSettingDialog (CrumbsDialog):
             self.image_types_checkbuttons[image_type] = gtk.CheckButton(image_type)
             self.image_types_checkbuttons[image_type].set_tooltip_text("Build an %s image" % image_type)
             table.attach(self.image_types_checkbuttons[image_type], j, j + 4, i, i + 1)
-            if image_type in self.configuration.image_fstypes:
+            if image_type in self.configuration.image_fstypes.split():
                 self.image_types_checkbuttons[image_type].set_active(True)
             i += 1
             if i > rows:
@@ -608,10 +608,11 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.configuration.image_rootfs_size = self.rootfs_size_spinner.get_value_as_int() * 1024
         self.configuration.image_extra_size = self.extra_size_spinner.get_value_as_int() * 1024
 
-        self.configuration.image_fstypes = []
+        self.configuration.image_fstypes = ""
         for image_type in self.image_types:
             if self.image_types_checkbuttons[image_type].get_active():
-                self.configuration.image_fstypes.append(image_type)
+                self.configuration.image_fstypes += (" " + image_type)
+        self.configuration.image_fstypes.strip()
         self.variables["IMAGE_FSTYPES"] = self.configuration.image_fstypes
 
         if self.gplv3_checkbox.get_active():
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index d1f36e62..9204e62 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -263,7 +263,7 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
 
     def set_image_fstypes(self, image_fstypes):
-        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", " ".join(image_fstypes).lstrip(" ")])
+        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
 
     def set_distro(self, distro):
         if distro != "defaultsetup":
-- 
1.7.4.1



