Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S8T03-0005q2-FO
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 09:59:03 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 16 Mar 2012 01:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129677034"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2012 01:50:15 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 16:48:13 +0800
Message-Id: <c26e0c87c427dd8f602dbe925c40dc7f49a62873.1331887394.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331887394.git.dongxiao.xu@intel.com>
References: <cover.1331887394.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331887394.git.dongxiao.xu@intel.com>
References: <cover.1331887394.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/3] Hob: save CONF_VERSION and LCONF_VERSION into template
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
X-List-Received-Date: Fri, 16 Mar 2012 08:59:03 -0000

To pass the sanity check, we need to define CONF_VERSION and
LCONF_VERSION in local.conf and bblayers.conf.

[YOCTO #2119]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    6 ++++++
 lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 lib/bb/ui/crumbs/template.py        |   10 +++++-----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 1d255ac..d1b0b52 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -55,6 +55,8 @@ class Configuration:
         self.image_overhead_factor = params['image_overhead_factor']
         self.incompat_license = params["incompat_license"]
         self.curr_sdk_machine = params["sdk_machine"]
+        self.conf_version = params["conf_version"]
+        self.lconf_version = params["lconf_version"]
         self.extra_setting = {}
         self.toolchain_build = False
         self.image_fstypes = params["image_fstypes"].split()
@@ -79,6 +81,8 @@ class Configuration:
         # image_overhead_factor is read-only.
         self.incompat_license = template.getVar("INCOMPATIBLE_LICENSE")
         self.curr_sdk_machine = template.getVar("SDKMACHINE")
+        self.conf_version = template.getVar("CONF_VERSION")
+        self.lconf_version = template.getVar("LCONF_VERSION")
         self.extra_setting = eval(template.getVar("EXTRA_SETTING"))
         self.toolchain_build = eval(template.getVar("TOOLCHAIN_BUILD"))
         self.image_fstypes = template.getVar("IMAGE_FSTYPES").split()
@@ -105,6 +109,8 @@ class Configuration:
         template.setVar("IMAGE_EXTRA_SPACE", self.image_extra_size)
         template.setVar("INCOMPATIBLE_LICENSE", self.incompat_license)
         template.setVar("SDKMACHINE", self.curr_sdk_machine)
+        template.setVar("CONF_VERSION", self.conf_version)
+        template.setVar("LCONF_VERSION", self.lconf_version)
         template.setVar("EXTRA_SETTING", self.extra_setting)
         template.setVar("TOOLCHAIN_BUILD", self.toolchain_build)
         template.setVar("IMAGE_FSTYPES", " ".join(self.image_fstypes).lstrip(" "))
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 790e2ef..e24c340 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -460,4 +460,7 @@ class HobHandler(gobject.GObject):
 
         # walkaround
         params["image_types"] = " ".join(hcc.SUPPORTED_IMAGE_TYPES.keys()).lstrip(" ")
+
+        params["conf_version"] = self.server.runCommand(["getVariable", "CONF_VERSION"]) or ""
+        params["lconf_version"] = self.server.runCommand(["getVariable", "LCONF_VERSION"]) or ""
         return params
diff --git a/lib/bb/ui/crumbs/template.py b/lib/bb/ui/crumbs/template.py
index d028354..a03063c 100644
--- a/lib/bb/ui/crumbs/template.py
+++ b/lib/bb/ui/crumbs/template.py
@@ -65,7 +65,7 @@ class ConfigFile(File):
         if header:
             self.header = header
         else:
-            self.header = "# Config generated by the HOB\n\n"
+            self.header = "# Config generated by Hob\n\n"
         self.dictionary = {}
 
     def setVar(self, var, val):
@@ -94,7 +94,7 @@ class HobTemplateFile(ConfigFile):
     This object does save or load hob specific file.
     """
     def __init__(self, pathfilename):
-        ConfigFile.__init__(self, pathfilename, ".hob", "# Hob Template generated by the HOB\n\n")
+        ConfigFile.__init__(self, pathfilename, ".hob", "# Hob Template generated by Hob\n\n")
 
     def getVar(self, var):
         if var in self.dictionary: 
@@ -121,12 +121,12 @@ class RecipeFile(ConfigFile):
     This object is for image bb file.
     """
     def __init__(self, pathfilename):
-        ConfigFile.__init__(self, pathfilename, ".bb", "# Recipe generated by the HOB\n\ninherit core-image\n")
+        ConfigFile.__init__(self, pathfilename, ".bb", "# Recipe generated by Hob\n\ninherit core-image\n")
 
 class TemplateMgr(gobject.GObject):
 
-    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREAD"]
-    __gBBLayersVars__ = ["BBLAYERS"]
+    __gLocalVars__ = ["MACHINE", "PACKAGE_CLASSES", "DISTRO", "DL_DIR", "SSTATE_DIR", "SSTATE_MIRROR", "PARALLEL_MAKE", "BB_NUMBER_THREAD", "CONF_VERSION"]
+    __gBBLayersVars__ = ["BBLAYERS", "LCONF_VERSION"]
     __gRecipeVars__ = ["DEPENDS", "IMAGE_INSTALL"]
 
     def __init__(self):
-- 
1.7.4.1



