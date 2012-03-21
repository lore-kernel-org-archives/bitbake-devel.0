Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFH-0003Qs-Hu
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:31 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 21 Mar 2012 05:57:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121495241"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 21 Mar 2012 05:57:39 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:12 +0800
Message-Id: <7649986b3b6388177e87dc0f8c7bff46c239b2e0.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/17] Hob: Change parseConfigurationFiles API usage
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:31 -0000

parseConfigurationFiles API is changed to sync mode, therefore make
accordingly changes in Hob part.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 07cc039..e9d10c5 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -62,7 +62,7 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_CONFIG, PARSE_BBFILES, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(13)
+    (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_BBFILES, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(12)
     (LAYERS_REFRESH, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
 
     def __init__(self, server, recipe_model, package_model):
@@ -134,8 +134,6 @@ class HobHandler(gobject.GObject):
             self.server.runCommand(["findConfigFiles", "MACHINE-SDK"])
         elif next_command == self.FILES_MATCH_CLASS:
             self.server.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
-        elif next_command == self.PARSE_CONFIG:
-            self.server.runCommand(["parseConfigurationFiles", "", ""])
         elif next_command == self.PARSE_BBFILES:
             self.server.runCommand(["parseFiles"])
         elif next_command == self.GENERATE_TGTS:
@@ -265,10 +263,13 @@ class HobHandler(gobject.GObject):
     def init_cooker(self):
         self.server.runCommand(["initCooker"])
 
+    def parse_config(self):
+        self.server.runCommand(["parseConfigurationFiles", "", ""])
+
     def refresh_layers(self, bblayers):
         self.server.runCommand(["initCooker"])
         self.server.runCommand(["setVariable", "BBLAYERS", " ".join(bblayers)])
-        self.commands_async.append(self.PARSE_CONFIG)
+        self.parse_config()
         self.commands_async.append(self.CFG_FILES_DISTRO)
         self.commands_async.append(self.CFG_FILES_MACH)
         self.commands_async.append(self.CFG_FILES_SDKMACH)
@@ -336,7 +337,7 @@ class HobHandler(gobject.GObject):
         self.run_next_command(self.POPULATE_PACKAGEINFO)
 
     def generate_recipes(self):
-        self.commands_async.append(self.PARSE_CONFIG)
+        self.parse_config()
         self.commands_async.append(self.GENERATE_TGTS)
         self.run_next_command(self.GENERATE_RECIPES)
                  
@@ -344,7 +345,7 @@ class HobHandler(gobject.GObject):
         targets = []
         targets.extend(tgts)
         self.recipe_queue = targets
-        self.commands_async.append(self.PARSE_CONFIG)
+        self.parse_config()
         self.commands_async.append(self.PARSE_BBFILES)
         self.commands_async.append(self.BUILD_TARGET_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
@@ -352,7 +353,7 @@ class HobHandler(gobject.GObject):
     def generate_image(self, tgts, toolchain_build=False):
         self.package_queue = tgts
         self.toolchain_build = toolchain_build
-        self.commands_async.append(self.PARSE_CONFIG)
+        self.parse_config()
         self.commands_async.append(self.PARSE_BBFILES)
         self.commands_async.append(self.BUILD_TARGET_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
-- 
1.7.4.1



