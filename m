Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBJzq-0006sz-Eq
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 06:58:38 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 22:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132647295"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2012 22:49:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 13:47:20 +0800
Message-Id: <af25b1328f9a3087c2a0959d875c0a9f93631d22.1332567775.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332567775.git.dongxiao.xu@intel.com>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332567775.git.dongxiao.xu@intel.com>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/8] Hob: Cleanup for hobeventhandler.py
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
X-List-Received-Date: Sat, 24 Mar 2012 05:58:38 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    2 +-
 lib/bb/ui/crumbs/hobeventhandler.py |   75 ++++++++++++++--------------------
 lib/bb/ui/hob.py                    |    4 +-
 3 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 2fe67d9..0faef9b 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -409,7 +409,7 @@ class Builder(gtk.Window):
         self.parameters.all_layers = layers
 
     def handler_command_succeeded_cb(self, handler, initcmd):
-        if initcmd == self.handler.LAYERS_REFRESH:
+        if initcmd == self.handler.GENERATE_CONFIGURATION:
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 664f866..8094d2d 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -62,8 +62,8 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_CONFIG, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(12)
-    (LAYERS_REFRESH, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
+    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
+    (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(10)
 
     def __init__(self, server, recipe_model, package_model):
         super(HobHandler, self).__init__()
@@ -84,21 +84,6 @@ class HobHandler(gobject.GObject):
         self.error_msg = ""
         self.initcmd = None
 
-    def kick(self):
-        import xmlrpclib
-        try:
-            # kick the while thing off
-            self.commands_async.append(self.CFG_PATH_LAYERS)
-            self.commands_async.append(self.CFG_FILES_DISTRO)
-            self.commands_async.append(self.CFG_FILES_MACH)
-            self.commands_async.append(self.CFG_FILES_SDKMACH)
-            self.commands_async.append(self.FILES_MATCH_CLASS)
-            self.run_next_command()
-            return True
-        except xmlrpclib.Fault as x:
-            print("XMLRPC Fault getting commandline:\n %s" % x)
-            return False
- 
     def set_busy(self):
         if not self.generating:
             self.emit("generating-data")
@@ -122,30 +107,28 @@ class HobHandler(gobject.GObject):
                 self.emit("command-succeeded", self.initcmd)
             return
 
-        if next_command == self.CFG_AVAIL_LAYERS:
-            self.server.runCommand(["findCoreBaseFiles", "layers", "conf/layer.conf"])
-        elif next_command == self.CFG_PATH_LAYERS:
+        if next_command == self.SUB_PATH_LAYERS:
             self.server.runCommand(["findConfigFilePath", "bblayers.conf"])
-        elif next_command == self.CFG_FILES_DISTRO:
+        elif next_command == self.SUB_FILES_DISTRO:
             self.server.runCommand(["findConfigFiles", "DISTRO"])
-        elif next_command == self.CFG_FILES_MACH:
+        elif next_command == self.SUB_FILES_MACH:
             self.server.runCommand(["findConfigFiles", "MACHINE"])
-        elif next_command == self.CFG_FILES_SDKMACH:
+        elif next_command == self.SUB_FILES_SDKMACH:
             self.server.runCommand(["findConfigFiles", "MACHINE-SDK"])
-        elif next_command == self.FILES_MATCH_CLASS:
+        elif next_command == self.SUB_MATCH_CLASS:
             self.server.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
-        elif next_command == self.PARSE_CONFIG:
+        elif next_command == self.SUB_PARSE_CONFIG:
             self.server.runCommand(["parseConfigurationFiles", "", ""])
-        elif next_command == self.GENERATE_TGTS:
+        elif next_command == self.SUB_GNERATE_TGTS:
             self.server.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
-        elif next_command == self.GENERATE_PACKAGEINFO:
+        elif next_command == self.SUB_GENERATE_PKGINFO:
             self.server.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
-        elif next_command == self.BUILD_TARGET_RECIPES:
+        elif next_command == self.SUB_BUILD_RECIPES:
             self.clear_busy()
             self.building = True
             self.server.runCommand(["buildTargets", self.recipe_queue, "build"])
             self.recipe_queue = []
-        elif next_command == self.BUILD_TARGET_IMAGE:
+        elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
             self.building = True
             targets = ["hob-image"]
@@ -264,14 +247,10 @@ class HobHandler(gobject.GObject):
         self.server.runCommand(["initCooker"])
 
     def refresh_layers(self, bblayers):
-        self.server.runCommand(["initCooker"])
-        self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
-        self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.CFG_FILES_DISTRO)
-        self.commands_async.append(self.CFG_FILES_MACH)
-        self.commands_async.append(self.CFG_FILES_SDKMACH)
-        self.commands_async.append(self.FILES_MATCH_CLASS)
-        self.run_next_command(self.LAYERS_REFRESH)
+        self.init_cooker()
+        self.set_bblayers(bblayers)
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.generate_configuration()
 
     def set_extra_inherit(self, bbclass):
         inherits = self.server.runCommand(["getVariable", "INHERIT"]) or ""
@@ -330,27 +309,35 @@ class HobHandler(gobject.GObject):
             self.server.runCommand(["setVariable", key, value])
 
     def request_package_info_async(self):
-        self.commands_async.append(self.GENERATE_PACKAGEINFO)
+        self.commands_async.append(self.SUB_GENERATE_PKGINFO)
         self.run_next_command(self.POPULATE_PACKAGEINFO)
 
+    def generate_configuration(self):
+        self.commands_async.append(self.SUB_PATH_LAYERS)
+        self.commands_async.append(self.SUB_FILES_DISTRO)
+        self.commands_async.append(self.SUB_FILES_MACH)
+        self.commands_async.append(self.SUB_FILES_SDKMACH)
+        self.commands_async.append(self.SUB_MATCH_CLASS)
+        self.run_next_command(self.GENERATE_CONFIGURATION)
+
     def generate_recipes(self):
-        self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.GENERATE_TGTS)
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.commands_async.append(self.SUB_GNERATE_TGTS)
         self.run_next_command(self.GENERATE_RECIPES)
                  
     def generate_packages(self, tgts):
         targets = []
         targets.extend(tgts)
         self.recipe_queue = targets
-        self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.BUILD_TARGET_RECIPES)
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
     def generate_image(self, tgts, toolchain_build=False):
         self.package_queue = tgts
         self.toolchain_build = toolchain_build
-        self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.BUILD_TARGET_IMAGE)
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
     def build_failed_async(self):
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index daa708b..7c147c4 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -56,10 +56,10 @@ def main (server = None, eventHandler = None):
     package_model = PackageListModel()
 
     hobHandler = HobHandler(server, recipe_model, package_model)
-    if hobHandler.kick() == False:
-        return 1
     builder = Builder(hobHandler, recipe_model, package_model)
 
+    hobHandler.generate_configuration()
+
     # This timeout function regularly probes the event queue to find out if we
     # have any messages waiting for us.
     gobject.timeout_add(10, event_handle_idle_func, eventHandler, hobHandler)
-- 
1.7.4.1



