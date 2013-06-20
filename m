Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E80C26AD80
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 10:18:09 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jun 2013 03:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,903,1363158000"; d="scan'208";a="356656144"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2013 03:18:09 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 13:19:45 +0300
Message-Id: <1371723585-27966-6-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
References: <1371723585-27966-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 5/5] hob: save variables in conf/ directory
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
X-List-Received-Date: Thu, 20 Jun 2013 10:18:10 -0000

Until now the variables were saved in bitbake configuration,
now they are saved in configuration files, in order to be read by
bitbake-worker. This helps to assure the consistency for the rest
of the variables.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   62 ++++++++++++++-------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8fd989b..421a1f3 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -146,9 +146,7 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_MATCH_CLASS:
             self.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.SUB_PARSE_CONFIG:
-            self.runCommand(["enableDataTracking"])
-            self.runCommand(["parseConfigurationFiles", "", ""])
-            self.runCommand(["disableDataTracking"])
+            self.runCommand(["parseConfigurationFiles", "conf/.hob.conf", ""])
         elif next_command == self.SUB_GNERATE_TGTS:
             self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
@@ -167,10 +165,10 @@ class HobHandler(gobject.GObject):
             self.building = True
             targets = [self.image]
             if self.package_queue:
-                self.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
-                self.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
+                self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
+                self.set_var_in_file("PACKAGE_INSTALL", " ".join(self.package_queue), "local.conf")
             if self.toolchain_packages:
-                self.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
+                self.set_var_in_file("TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages), "local.conf")
                 targets.append(self.toolchain)
             if targets[0] == "hob-image":
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
@@ -204,8 +202,8 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, bb.event.SanityCheckPassed):
             reparse = self.runCommand(["getVariable", "BB_INVALIDCONF"]) or None
             if reparse is True:
-                self.runCommand(["setVariable", "BB_INVALIDCONF", False])
-                self.runCommand(["parseConfigurationFiles", "", ""])
+                self.set_var_in_file("BB_INVALIDCONF", False, "local.conf")
+                self.runCommand(["parseConfigurationFiles", "conf/.hob.conf", ""])
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckFailed):
@@ -300,79 +298,83 @@ class HobHandler(gobject.GObject):
 
     def init_cooker(self):
         self.runCommand(["initCooker"])
+        self.runCommand(["createConfigFile", ".hob.conf"])
+
+    def reset_cooker(self):
+        self.runCommand(["resetCooker"])
 
     def set_extra_inherit(self, bbclass):
         inherits = self.runCommand(["getVariable", "INHERIT"]) or ""
         inherits = inherits + " " + bbclass
-        self.runCommand(["setVariable", "INHERIT", inherits])
+        self.set_var_in_file("INHERIT", inherits, ".hob.conf")
 
     def set_bblayers(self, bblayers):
-        self.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
+        self.set_var_in_file("BBLAYERS", " ".join(bblayers), "bblayers.conf")
 
     def set_machine(self, machine):
         if machine:
-            self.runCommand(["setVariable", "MACHINE", machine])
+            self.set_var_in_file("MACHINE", machine, "local.conf")
 
     def set_sdk_machine(self, sdk_machine):
-        self.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
+        self.set_var_in_file("SDKMACHINE", sdk_machine, "local.conf")
 
     def set_image_fstypes(self, image_fstypes):
-        self.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
+        self.set_var_in_file("IMAGE_FSTYPES", image_fstypes, "local.conf")
 
     def set_distro(self, distro):
-        self.runCommand(["setVariable", "DISTRO", distro])
+        self.set_var_in_file("DISTRO", distro, "local.conf")
 
     def set_package_format(self, format):
         package_classes = ""
         for pkgfmt in format.split():
             package_classes += ("package_%s" % pkgfmt + " ")
-        self.runCommand(["setVariable", "PACKAGE_CLASSES", package_classes])
+        self.set_var_in_file("PACKAGE_CLASSES", package_classes, "local.conf")
 
     def set_bbthreads(self, threads):
-        self.runCommand(["setVariable", "BB_NUMBER_THREADS", threads])
+        self.set_var_in_file("BB_NUMBER_THREADS", threads, "local.conf")
 
     def set_pmake(self, threads):
         pmake = "-j %s" % threads
-        self.runCommand(["setVariable", "PARALLEL_MAKE", pmake])
+        self.set_var_in_file("PARALLEL_MAKE", pmake, "local.conf")
 
     def set_dl_dir(self, directory):
-        self.runCommand(["setVariable", "DL_DIR", directory])
+        self.set_var_in_file("DL_DIR", directory, "local.conf")
 
     def set_sstate_dir(self, directory):
-        self.runCommand(["setVariable", "SSTATE_DIR", directory])
+        self.set_var_in_file("SSTATE_DIR", directory, "local.conf")
 
     def set_sstate_mirrors(self, url):
-        self.runCommand(["setVariable", "SSTATE_MIRRORS", url])
+        self.set_var_in_file("SSTATE_MIRRORS", url, "local.conf")
 
     def set_extra_size(self, image_extra_size):
-        self.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
+        self.set_var_in_file("IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size), "local.conf")
 
     def set_rootfs_size(self, image_rootfs_size):
-        self.runCommand(["setVariable", "IMAGE_ROOTFS_SIZE", str(image_rootfs_size)])
+        self.set_var_in_file("IMAGE_ROOTFS_SIZE", str(image_rootfs_size), "local.conf")
 
     def set_incompatible_license(self, incompat_license):
-        self.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", incompat_license])
+        self.set_var_in_file("INCOMPATIBLE_LICENSE", incompat_license, "local.conf")
 
     def set_extra_config(self, extra_setting):
         for key in extra_setting.keys():
             value = extra_setting[key]
-            self.runCommand(["setVariable", key, value])
+            self.set_var_in_file(key, value, "local.conf")
 
     def set_http_proxy(self, http_proxy):
-        self.runCommand(["setVariable", "http_proxy", http_proxy])
+        self.set_var_in_file("http_proxy", http_proxy, "local.conf")
 
     def set_https_proxy(self, https_proxy):
-        self.runCommand(["setVariable", "https_proxy", https_proxy])
+        self.set_var_in_file("https_proxy", https_proxy, "local.conf")
 
     def set_ftp_proxy(self, ftp_proxy):
-        self.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
+        self.set_var_in_file("ftp_proxy", ftp_proxy, "local.conf")
 
     def set_socks_proxy(self, socks_proxy):
-        self.runCommand(["setVariable", "all_proxy", socks_proxy])
+        self.set_var_in_file("all_proxy", socks_proxy, "local.conf")
 
     def set_cvs_proxy(self, host, port):
-        self.runCommand(["setVariable", "CVS_PROXY_HOST", host])
-        self.runCommand(["setVariable", "CVS_PROXY_PORT", port])
+        self.set_var_in_file("CVS_PROXY_HOST", host, "local.conf")
+        self.set_var_in_file("CVS_PROXY_PORT", port, "local.conf")
 
     def request_package_info(self):
         self.commands_async.append(self.SUB_GENERATE_PKGINFO)
-- 
1.7.9.5


