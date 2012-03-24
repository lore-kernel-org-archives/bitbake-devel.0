Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBJzr-0006t1-2U
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 06:58:39 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2012 22:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121155820"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 22:49:40 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 13:47:19 +0800
Message-Id: <3facae31225584a5cc1b8ba4b479d86fb362abd3.1332567775.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332567775.git.dongxiao.xu@intel.com>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332567775.git.dongxiao.xu@intel.com>
References: <cover.1332567775.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/8] Hob: Remove unnecessary PARSE_BBFILES command
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
X-List-Received-Date: Sat, 24 Mar 2012 05:58:39 -0000

The ASYNC commands can automatically detect if BB file parsing is needed.
Therefore remove this explicit parsing command.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 07cc039..664f866 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -62,7 +62,7 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_CONFIG, PARSE_BBFILES, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(13)
+    (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_CONFIG, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(12)
     (LAYERS_REFRESH, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
 
     def __init__(self, server, recipe_model, package_model):
@@ -136,8 +136,6 @@ class HobHandler(gobject.GObject):
             self.server.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.PARSE_CONFIG:
             self.server.runCommand(["parseConfigurationFiles", "", ""])
-        elif next_command == self.PARSE_BBFILES:
-            self.server.runCommand(["parseFiles"])
         elif next_command == self.GENERATE_TGTS:
             self.server.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.GENERATE_PACKAGEINFO:
@@ -345,7 +343,6 @@ class HobHandler(gobject.GObject):
         targets.extend(tgts)
         self.recipe_queue = targets
         self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.PARSE_BBFILES)
         self.commands_async.append(self.BUILD_TARGET_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
@@ -353,7 +350,6 @@ class HobHandler(gobject.GObject):
         self.package_queue = tgts
         self.toolchain_build = toolchain_build
         self.commands_async.append(self.PARSE_CONFIG)
-        self.commands_async.append(self.PARSE_BBFILES)
         self.commands_async.append(self.BUILD_TARGET_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
-- 
1.7.4.1



