Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SIMPt-0000mw-UL
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 17:58:38 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 12 Apr 2012 08:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="128444638"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 12 Apr 2012 08:49:16 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 23:46:26 +0800
Message-Id: <22b8af8e91b533bfbc6118a6894c29d974d10dfb.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334245432.git.dongxiao.xu@intel.com>
References: <cover.1334245432.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/3] Hob: Implement Hob config parse hook
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
X-List-Received-Date: Thu, 12 Apr 2012 15:58:38 -0000

To make Hob's specific variable settings take effect, we add a Hob
config hook at the end of parsing for each configuration file, and in
the hook function, Hob will set its own variables to the data store.

This fixes:
[YOCTO #2210]
[YOCTO #2254]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   26 ++++++++++++++++++++++++++
 lib/bb/ui/crumbs/hobeventhandler.py |   26 ++++++++++++++------------
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 10b9a77..410ff5f 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -210,6 +210,30 @@ class Parameters:
         self.tmpdir = params["tmpdir"]
         self.enable_proxy = False
 
+def hob_conf_filter(fn, data):
+    if fn.endswith("/local.conf"):
+        distro = data.getVar("DISTRO_HOB")
+        if distro:
+            if distro != "defaultsetup":
+                data.setVar("DISTRO", distro)
+            else:
+                data.delVar("DISTRO")
+
+        keys = ["MACHINE_HOB", "SDKMACHINE_HOB", "PACKAGE_CLASSES_HOB", \
+                "BB_NUMBER_THREADS_HOB", "PARALLEL_MAKE_HOB", "DL_DIR_HOB", \
+                "SSTATE_DIR_HOB", "SSTATE_MIRROR_HOB", "INCOMPATIBLE_LICENSE_HOB"]
+        for key in keys:
+            var_hob = data.getVar(key)
+            if var_hob:
+                data.setVar(key.split("_HOB")[0], var_hob)
+        return
+
+    if fn.endswith("/bblayers.conf"):
+        layers = data.getVar("BBLAYERS_HOB")
+        if layers:
+            data.setVar("BBLAYERS", layers)
+        return
+
 class Builder(gtk.Window):
 
     (MACHINE_SELECTION,
@@ -296,6 +320,8 @@ class Builder(gtk.Window):
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
 
+        self.handler.set_config_filter(hob_conf_filter)
+
         self.initiate_new_build_async()
 
     def create_visual_elements(self):
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 1a7427a..292d905 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -253,43 +253,42 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "INHERIT", inherits])
 
     def set_bblayers(self, bblayers):
-        self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
+        self.server.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
 
     def set_machine(self, machine):
         if machine:
-            self.server.runCommand(["setVariable", "MACHINE", machine])
+            self.server.runCommand(["setVariable", "MACHINE_HOB", machine])
 
     def set_sdk_machine(self, sdk_machine):
-        self.server.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
+        self.server.runCommand(["setVariable", "SDKMACHINE_HOB", sdk_machine])
 
     def set_image_fstypes(self, image_fstypes):
         self.server.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
 
     def set_distro(self, distro):
-        if distro != "defaultsetup":
-            self.server.runCommand(["setVariable", "DISTRO", distro])
+        self.server.runCommand(["setVariable", "DISTRO_HOB", distro])
 
     def set_package_format(self, format):
         package_classes = ""
         for pkgfmt in format.split():
             package_classes += ("package_%s" % pkgfmt + " ")
-        self.server.runCommand(["setVariable", "PACKAGE_CLASSES", package_classes])
+        self.server.runCommand(["setVariable", "PACKAGE_CLASSES_HOB", package_classes])
 
     def set_bbthreads(self, threads):
-        self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", threads])
+        self.server.runCommand(["setVariable", "BB_NUMBER_THREADS_HOB", threads])
 
     def set_pmake(self, threads):
         pmake = "-j %s" % threads
-        self.server.runCommand(["setVariable", "PARALLEL_MAKE", pmake])
+        self.server.runCommand(["setVariable", "PARALLEL_MAKE_HOB", pmake])
 
     def set_dl_dir(self, directory):
-        self.server.runCommand(["setVariable", "DL_DIR", directory])
+        self.server.runCommand(["setVariable", "DL_DIR_HOB", directory])
 
     def set_sstate_dir(self, directory):
-        self.server.runCommand(["setVariable", "SSTATE_DIR", directory])
+        self.server.runCommand(["setVariable", "SSTATE_DIR_HOB", directory])
 
     def set_sstate_mirror(self, url):
-        self.server.runCommand(["setVariable", "SSTATE_MIRROR", url])
+        self.server.runCommand(["setVariable", "SSTATE_MIRROR_HOB", url])
 
     def set_extra_size(self, image_extra_size):
         self.server.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
@@ -298,13 +297,16 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["setVariable", "IMAGE_ROOTFS_SIZE", str(image_rootfs_size)])
 
     def set_incompatible_license(self, incompat_license):
-        self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", incompat_license])
+        self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE_HOB", incompat_license])
 
     def set_extra_config(self, extra_setting):
         for key in extra_setting.keys():
             value = extra_setting[key]
             self.server.runCommand(["setVariable", key, value])
 
+    def set_config_filter(self, config_filter):
+        self.server.runCommand(["setConfFilter", config_filter])
+
     def set_http_proxy(self, http_proxy):
         self.server.runCommand(["setVariable", "http_proxy", http_proxy])
 
-- 
1.7.4.1



