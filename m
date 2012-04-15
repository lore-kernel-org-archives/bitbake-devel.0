Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJRgj-0007H1-Hq
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 17:48:30 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Apr 2012 08:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="142014883"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2012 08:39:04 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 00:09:25 +0800
Message-Id: <840c95c9d62045da4185849a1da1a65993c22dd8.1334505890.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1334505890.git.shane.wang@intel.com>
References: <cover.1334505890.git.shane.wang@intel.com>
Subject: [PATCH 1/1] Hob: add exception handling
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
X-List-Received-Date: Sun, 15 Apr 2012 15:48:30 -0000

Create a wrapper with exception handling to call self.server.runCommand() safely.
Again, add exception handling to load_template() and save_template()

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |   56 ++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |  175 ++++++++++++++-------------
 2 files changed, 128 insertions(+), 103 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 48053b3..d916199 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -466,11 +466,15 @@ class Builder(gtk.Window):
             return None
 
         self.template = TemplateMgr()
-        self.template.load(path)
-        self.configuration.load(self.template)
-
-        self.template.destroy()
-        self.template = None
+        try:
+            self.template.load(path)
+            self.configuration.load(self.template)
+        except Exception as e:
+            self.show_error_dialog("Hob Exception - %s" % (str(e)))
+            self.reset()
+        finally:
+            self.template.destroy()
+            self.template = None
 
         for layer in self.configuration.layers:
             if not os.path.exists(layer+'/conf/layer.conf'):
@@ -489,12 +493,17 @@ class Builder(gtk.Window):
             path = path[0:path.rfind("/")]
 
         self.template = TemplateMgr()
-        self.template.open(filename, path)
-        self.configuration.save(self.template, defaults)
+        try:
+            self.template.open(filename, path)
+            self.configuration.save(self.template, defaults)
 
-        self.template.save()
-        self.template.destroy()
-        self.template = None
+            self.template.save()
+        except Exception as e:
+            self.show_error_dialog("Hob Exception - %s" % (str(e)))
+            self.reset()
+        finally:
+            self.template.destroy()
+            self.template = None
 
     def save_defaults(self):
         if not os.path.exists(".hob/"):
@@ -589,6 +598,12 @@ class Builder(gtk.Window):
             self.configuration.update(params)
             self.parameters.update(params)
 
+    def reset(self):
+        self.configuration.curr_mach = ""
+        self.configuration.clear_selection()
+        self.image_configuration_page.switch_machine_combo()
+        self.switch_page(self.MACHINE_SELECTION)
+
     # Callback Functions
     def handler_config_updated_cb(self, handler, which, values):
         if which == "distro":
@@ -629,19 +644,20 @@ class Builder(gtk.Window):
             elif self.current_step == self.IMAGE_GENERATING:
                 self.switch_page(self.IMAGE_GENERATED)
 
+    def show_error_dialog(self, msg):
+        lbl = "<b>Error</b>\n"
+        lbl = lbl + "%s\n\n" % msg
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+        HobButton.style_button(button)
+        response = dialog.run()
+        dialog.destroy()
+
     def handler_command_failed_cb(self, handler, msg):
         if msg:
             msg = msg.replace("your local.conf", "Settings")
-            lbl = "<b>Error</b>\n"
-            lbl = lbl + "%s\n\n" % msg
-            dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
-            button = dialog.add_button("Close", gtk.RESPONSE_OK)
-            HobButton.style_button(button)
-            response = dialog.run()
-            dialog.destroy()
-        self.configuration.curr_mach = ""
-        self.image_configuration_page.switch_machine_combo()
-        self.switch_page(self.MACHINE_SELECTION)
+            self.show_error_dialog(msg)
+        self.reset()
 
     def window_sensitive(self, sensitive):
         self.image_configuration_page.machine_combo.set_sensitive(sensitive)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7a3cc6b..768878a 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -91,6 +91,15 @@ class HobHandler(gobject.GObject):
             self.emit("data-generated")
             self.generating = False
 
+    def runCommand(self, commandline):
+        try:
+            return self.server.runCommand(commandline)
+        except Exception as e:
+            self.commands_async = []
+            self.clear_busy()
+            self.emit("command-failed", "Hob Exception - %s" % (str(e)))
+            return None
+
     def run_next_command(self, initcmd=None):
         if initcmd != None:
             self.initcmd = initcmd
@@ -105,37 +114,37 @@ class HobHandler(gobject.GObject):
             return
 
         if next_command == self.SUB_PATH_LAYERS:
-            self.server.runCommand(["findConfigFilePath", "bblayers.conf"])
+            self.runCommand(["findConfigFilePath", "bblayers.conf"])
         elif next_command == self.SUB_FILES_DISTRO:
-            self.server.runCommand(["findConfigFiles", "DISTRO"])
+            self.runCommand(["findConfigFiles", "DISTRO"])
         elif next_command == self.SUB_FILES_MACH:
-            self.server.runCommand(["findConfigFiles", "MACHINE"])
+            self.runCommand(["findConfigFiles", "MACHINE"])
         elif next_command == self.SUB_FILES_SDKMACH:
-            self.server.runCommand(["findConfigFiles", "MACHINE-SDK"])
+            self.runCommand(["findConfigFiles", "MACHINE-SDK"])
         elif next_command == self.SUB_MATCH_CLASS:
-            self.server.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
+            self.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.SUB_PARSE_CONFIG:
-            self.server.runCommand(["parseConfigurationFiles", "", ""])
+            self.runCommand(["parseConfigurationFiles", "", ""])
         elif next_command == self.SUB_GNERATE_TGTS:
-            self.server.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
+            self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
-            self.server.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
+            self.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
         elif next_command == self.SUB_BUILD_RECIPES:
             self.clear_busy()
             self.building = True
-            self.server.runCommand(["buildTargets", self.recipe_queue, self.default_task])
+            self.runCommand(["buildTargets", self.recipe_queue, self.default_task])
             self.recipe_queue = []
         elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
             self.building = True
             targets = [self.image]
             if self.package_queue:
-                self.server.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
-                self.server.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
+                self.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
+                self.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
             if self.toolchain_packages:
-                self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
+                self.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.toolchain)
-            self.server.runCommand(["buildTargets", targets, self.default_task])
+            self.runCommand(["buildTargets", targets, self.default_task])
 
     def handle_event(self, event):
         if not event:
@@ -238,7 +247,7 @@ class HobHandler(gobject.GObject):
         return
 
     def init_cooker(self):
-        self.server.runCommand(["initCooker"])
+        self.runCommand(["initCooker"])
 
     def parse_config(self):
         self.commands_async.append(self.SUB_PARSE_CONFIG)
@@ -249,84 +258,84 @@ class HobHandler(gobject.GObject):
         self.generate_configuration()
 
     def set_extra_inherit(self, bbclass):
-        inherits = self.server.runCommand(["getVariable", "INHERIT"]) or ""
+        inherits = self.runCommand(["getVariable", "INHERIT"]) or ""
         inherits = inherits + " " + bbclass
-        self.server.runCommand(["setVariable", "INHERIT", inherits])
+        self.runCommand(["setVariable", "INHERIT", inherits])
 
     def set_bblayers(self, bblayers):
-        self.server.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
+        self.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
 
     def set_machine(self, machine):
         if machine:
-            self.server.runCommand(["setVariable", "MACHINE_HOB", machine])
+            self.runCommand(["setVariable", "MACHINE_HOB", machine])
 
     def set_sdk_machine(self, sdk_machine):
-        self.server.runCommand(["setVariable", "SDKMACHINE_HOB", sdk_machine])
+        self.runCommand(["setVariable", "SDKMACHINE_HOB", sdk_machine])
 
     def set_image_fstypes(self, image_fstypes):
-        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
+        self.runCommand(["setVariable", "IMAGE_FSTYPES", image_fstypes])
 
     def set_distro(self, distro):
-        self.server.runCommand(["setVariable", "DISTRO_HOB", distro])
+        self.runCommand(["setVariable", "DISTRO_HOB", distro])
 
     def set_package_format(self, format):
         package_classes = ""
         for pkgfmt in format.split():
             package_classes += ("package_%s" % pkgfmt + " ")
-        self.server.runCommand(["setVariable", "PACKAGE_CLASSES_HOB", package_classes])
+        self.runCommand(["setVariable", "PACKAGE_CLASSES_HOB", package_classes])
 
     def set_bbthreads(self, threads):
-        self.server.runCommand(["setVariable", "BB_NUMBER_THREADS_HOB", threads])
+        self.runCommand(["setVariable", "BB_NUMBER_THREADS_HOB", threads])
 
     def set_pmake(self, threads):
         pmake = "-j %s" % threads
-        self.server.runCommand(["setVariable", "PARALLEL_MAKE_HOB", pmake])
+        self.runCommand(["setVariable", "PARALLEL_MAKE_HOB", pmake])
 
     def set_dl_dir(self, directory):
-        self.server.runCommand(["setVariable", "DL_DIR_HOB", directory])
+        self.runCommand(["setVariable", "DL_DIR_HOB", directory])
 
     def set_sstate_dir(self, directory):
-        self.server.runCommand(["setVariable", "SSTATE_DIR_HOB", directory])
+        self.runCommand(["setVariable", "SSTATE_DIR_HOB", directory])
 
     def set_sstate_mirror(self, url):
-        self.server.runCommand(["setVariable", "SSTATE_MIRROR_HOB", url])
+        self.runCommand(["setVariable", "SSTATE_MIRROR_HOB", url])
 
     def set_extra_size(self, image_extra_size):
-        self.server.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
+        self.runCommand(["setVariable", "IMAGE_ROOTFS_EXTRA_SPACE", str(image_extra_size)])
 
     def set_rootfs_size(self, image_rootfs_size):
-        self.server.runCommand(["setVariable", "IMAGE_ROOTFS_SIZE", str(image_rootfs_size)])
+        self.runCommand(["setVariable", "IMAGE_ROOTFS_SIZE", str(image_rootfs_size)])
 
     def set_incompatible_license(self, incompat_license):
-        self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE_HOB", incompat_license])
+        self.runCommand(["setVariable", "INCOMPATIBLE_LICENSE_HOB", incompat_license])
 
     def set_extra_config(self, extra_setting):
         for key in extra_setting.keys():
             value = extra_setting[key]
-            self.server.runCommand(["setVariable", key, value])
+            self.runCommand(["setVariable", key, value])
 
     def set_config_filter(self, config_filter):
-        self.server.runCommand(["setConfFilter", config_filter])
+        self.runCommand(["setConfFilter", config_filter])
 
     def set_http_proxy(self, http_proxy):
-        self.server.runCommand(["setVariable", "http_proxy", http_proxy])
+        self.runCommand(["setVariable", "http_proxy", http_proxy])
 
     def set_https_proxy(self, https_proxy):
-        self.server.runCommand(["setVariable", "https_proxy", https_proxy])
+        self.runCommand(["setVariable", "https_proxy", https_proxy])
 
     def set_ftp_proxy(self, ftp_proxy):
-        self.server.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
+        self.runCommand(["setVariable", "ftp_proxy", ftp_proxy])
 
     def set_all_proxy(self, all_proxy):
-        self.server.runCommand(["setVariable", "all_proxy", all_proxy])
+        self.runCommand(["setVariable", "all_proxy", all_proxy])
 
     def set_git_proxy(self, host, port):
-        self.server.runCommand(["setVariable", "GIT_PROXY_HOST", host])
-        self.server.runCommand(["setVariable", "GIT_PROXY_PORT", port])
+        self.runCommand(["setVariable", "GIT_PROXY_HOST", host])
+        self.runCommand(["setVariable", "GIT_PROXY_PORT", port])
 
     def set_cvs_proxy(self, host, port):
-        self.server.runCommand(["setVariable", "CVS_PROXY_HOST", host])
-        self.server.runCommand(["setVariable", "CVS_PROXY_PORT", port])
+        self.runCommand(["setVariable", "CVS_PROXY_HOST", host])
+        self.runCommand(["setVariable", "CVS_PROXY_PORT", port])
 
     def request_package_info(self):
         self.commands_async.append(self.SUB_GENERATE_PKGINFO)
@@ -373,16 +382,16 @@ class HobHandler(gobject.GObject):
         self.building = False
 
     def cancel_parse(self):
-        self.server.runCommand(["stateStop"])
+        self.runCommand(["stateStop"])
 
     def cancel_build(self, force=False):
         if force:
             # Force the cooker to stop as quickly as possible
-            self.server.runCommand(["stateStop"])
+            self.runCommand(["stateStop"])
         else:
             # Wait for tasks to complete before shutting down, this helps
             # leave the workdir in a usable state
-            self.server.runCommand(["stateShutdown"])
+            self.runCommand(["stateShutdown"])
 
     def reset_build(self):
         self.build.reset()
@@ -397,19 +406,19 @@ class HobHandler(gobject.GObject):
     def get_parameters(self):
         # retrieve the parameters from bitbake
         params = {}
-        params["core_base"] = self.server.runCommand(["getVariable", "COREBASE"]) or ""
+        params["core_base"] = self.runCommand(["getVariable", "COREBASE"]) or ""
         hob_layer = params["core_base"] + "/meta-hob"
-        params["layer"] = self.server.runCommand(["getVariable", "BBLAYERS"]) or ""
+        params["layer"] = self.runCommand(["getVariable", "BBLAYERS"]) or ""
         if hob_layer not in params["layer"].split():
             params["layer"] += (" " + hob_layer)
-        params["dldir"] = self.server.runCommand(["getVariable", "DL_DIR"]) or ""
-        params["machine"] = self.server.runCommand(["getVariable", "MACHINE"]) or ""
-        params["distro"] = self.server.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
-        params["pclass"] = self.server.runCommand(["getVariable", "PACKAGE_CLASSES"]) or ""
-        params["sstatedir"] = self.server.runCommand(["getVariable", "SSTATE_DIR"]) or ""
-        params["sstatemirror"] = self.server.runCommand(["getVariable", "SSTATE_MIRROR"]) or ""
-
-        num_threads = self.server.runCommand(["getCpuCount"])
+        params["dldir"] = self.runCommand(["getVariable", "DL_DIR"]) or ""
+        params["machine"] = self.runCommand(["getVariable", "MACHINE"]) or ""
+        params["distro"] = self.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
+        params["pclass"] = self.runCommand(["getVariable", "PACKAGE_CLASSES"]) or ""
+        params["sstatedir"] = self.runCommand(["getVariable", "SSTATE_DIR"]) or ""
+        params["sstatemirror"] = self.runCommand(["getVariable", "SSTATE_MIRROR"]) or ""
+
+        num_threads = self.runCommand(["getCpuCount"])
         if not num_threads:
             num_threads = 1
             max_threads = 65536
@@ -422,7 +431,7 @@ class HobHandler(gobject.GObject):
                 max_threads = 65536
         params["max_threads"] = max_threads
 
-        bbthread = self.server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
+        bbthread = self.runCommand(["getVariable", "BB_NUMBER_THREADS"])
         if not bbthread:
             bbthread = num_threads
         else:
@@ -432,7 +441,7 @@ class HobHandler(gobject.GObject):
                 bbthread = num_threads
         params["bbthread"] = bbthread
 
-        pmake = self.server.runCommand(["getVariable", "PARALLEL_MAKE"])
+        pmake = self.runCommand(["getVariable", "PARALLEL_MAKE"])
         if not pmake:
             pmake = num_threads
         elif isinstance(pmake, int):
@@ -444,9 +453,9 @@ class HobHandler(gobject.GObject):
                 pmake = num_threads
         params["pmake"] = "-j %s" % pmake
 
-        params["image_addr"] = self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
+        params["image_addr"] = self.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
 
-        image_extra_size = self.server.runCommand(["getVariable", "IMAGE_ROOTFS_EXTRA_SPACE"])
+        image_extra_size = self.runCommand(["getVariable", "IMAGE_ROOTFS_EXTRA_SPACE"])
         if not image_extra_size:
             image_extra_size = 0
         else:
@@ -456,7 +465,7 @@ class HobHandler(gobject.GObject):
                 image_extra_size = 0
         params["image_extra_size"] = image_extra_size
 
-        image_rootfs_size = self.server.runCommand(["getVariable", "IMAGE_ROOTFS_SIZE"])
+        image_rootfs_size = self.runCommand(["getVariable", "IMAGE_ROOTFS_SIZE"])
         if not image_rootfs_size:
             image_rootfs_size = 0
         else:
@@ -466,7 +475,7 @@ class HobHandler(gobject.GObject):
                 image_rootfs_size = 0
         params["image_rootfs_size"] = image_rootfs_size
 
-        image_overhead_factor = self.server.runCommand(["getVariable", "IMAGE_OVERHEAD_FACTOR"])
+        image_overhead_factor = self.runCommand(["getVariable", "IMAGE_OVERHEAD_FACTOR"])
         if not image_overhead_factor:
             image_overhead_factor = 1
         else:
@@ -476,37 +485,37 @@ class HobHandler(gobject.GObject):
                 image_overhead_factor = 1
         params['image_overhead_factor'] = image_overhead_factor
 
-        params["incompat_license"] = self._remove_redundant(self.server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or "")
-        params["sdk_machine"] = self.server.runCommand(["getVariable", "SDKMACHINE"]) or self.server.runCommand(["getVariable", "SDK_ARCH"]) or ""
+        params["incompat_license"] = self._remove_redundant(self.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"]) or "")
+        params["sdk_machine"] = self.runCommand(["getVariable", "SDKMACHINE"]) or self.runCommand(["getVariable", "SDK_ARCH"]) or ""
 
-        params["image_fstypes"] = self._remove_redundant(self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]) or "")
+        params["image_fstypes"] = self._remove_redundant(self.runCommand(["getVariable", "IMAGE_FSTYPES"]) or "")
 
-        params["image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "IMAGE_TYPES"]) or "")
+        params["image_types"] = self._remove_redundant(self.runCommand(["getVariable", "IMAGE_TYPES"]) or "")
 
-        params["conf_version"] = self.server.runCommand(["getVariable", "CONF_VERSION"]) or ""
-        params["lconf_version"] = self.server.runCommand(["getVariable", "LCONF_VERSION"]) or ""
+        params["conf_version"] = self.runCommand(["getVariable", "CONF_VERSION"]) or ""
+        params["lconf_version"] = self.runCommand(["getVariable", "LCONF_VERSION"]) or ""
 
-        params["runnable_image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or "")
-        params["runnable_machine_patterns"] = self._remove_redundant(self.server.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or "")
-        params["deployable_image_types"] = self._remove_redundant(self.server.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or "")
-        params["tmpdir"] = self.server.runCommand(["getVariable", "TMPDIR"]) or ""
-        params["distro_version"] = self.server.runCommand(["getVariable", "DISTRO_VERSION"]) or ""
-        params["target_os"] = self.server.runCommand(["getVariable", "TARGET_OS"]) or ""
-        params["target_arch"] = self.server.runCommand(["getVariable", "TARGET_ARCH"]) or ""
-        params["tune_pkgarch"] = self.server.runCommand(["getVariable", "TUNE_PKGARCH"])  or ""
-        params["bb_version"] = self.server.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
+        params["runnable_image_types"] = self._remove_redundant(self.runCommand(["getVariable", "RUNNABLE_IMAGE_TYPES"]) or "")
+        params["runnable_machine_patterns"] = self._remove_redundant(self.runCommand(["getVariable", "RUNNABLE_MACHINE_PATTERNS"]) or "")
+        params["deployable_image_types"] = self._remove_redundant(self.runCommand(["getVariable", "DEPLOYABLE_IMAGE_TYPES"]) or "")
+        params["tmpdir"] = self.runCommand(["getVariable", "TMPDIR"]) or ""
+        params["distro_version"] = self.runCommand(["getVariable", "DISTRO_VERSION"]) or ""
+        params["target_os"] = self.runCommand(["getVariable", "TARGET_OS"]) or ""
+        params["target_arch"] = self.runCommand(["getVariable", "TARGET_ARCH"]) or ""
+        params["tune_pkgarch"] = self.runCommand(["getVariable", "TUNE_PKGARCH"])  or ""
+        params["bb_version"] = self.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
 
-        params["default_task"] = self.server.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
+        params["default_task"] = self.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
 
-        params["git_proxy_host"] = self.server.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
-        params["git_proxy_port"] = self.server.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
+        params["git_proxy_host"] = self.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
+        params["git_proxy_port"] = self.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
 
-        params["http_proxy"] = self.server.runCommand(["getVariable", "http_proxy"]) or ""
-        params["ftp_proxy"] = self.server.runCommand(["getVariable", "ftp_proxy"]) or ""
-        params["https_proxy"] = self.server.runCommand(["getVariable", "https_proxy"]) or ""
-        params["all_proxy"] = self.server.runCommand(["getVariable", "all_proxy"]) or ""
+        params["http_proxy"] = self.runCommand(["getVariable", "http_proxy"]) or ""
+        params["ftp_proxy"] = self.runCommand(["getVariable", "ftp_proxy"]) or ""
+        params["https_proxy"] = self.runCommand(["getVariable", "https_proxy"]) or ""
+        params["all_proxy"] = self.runCommand(["getVariable", "all_proxy"]) or ""
 
-        params["cvs_proxy_host"] = self.server.runCommand(["getVariable", "CVS_PROXY_HOST"]) or ""
-        params["cvs_proxy_port"] = self.server.runCommand(["getVariable", "CVS_PROXY_PORT"]) or ""
+        params["cvs_proxy_host"] = self.runCommand(["getVariable", "CVS_PROXY_HOST"]) or ""
+        params["cvs_proxy_port"] = self.runCommand(["getVariable", "CVS_PROXY_PORT"]) or ""
 
         return params
-- 
1.7.6



