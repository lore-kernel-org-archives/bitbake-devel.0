Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJK34-0002Ne-5b
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 09:39:02 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Apr 2012 00:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132648483"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 15 Apr 2012 00:29:34 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 15:26:38 +0800
Message-Id: <0b322150702aced498d102d4fae59cd60012b983.1334474635.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334474635.git.dongxiao.xu@intel.com>
References: <cover.1334474635.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334474635.git.dongxiao.xu@intel.com>
References: <cover.1334474635.git.dongxiao.xu@intel.com>
Subject: [PATCH 2/2] Hob: Simplify the init process
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
X-List-Received-Date: Sun, 15 Apr 2012 07:39:02 -0000

This commit merges some functionalities together and avoid unnecessary
signal handling. This can help to speed up the Hob startup.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   13 +++----------
 lib/bb/ui/crumbs/hobeventhandler.py |   11 ++---------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index dd59d59..cd66c3f 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -398,12 +398,12 @@ class Builder(gtk.Window):
         if self.load_template(TemplateMgr.convert_to_template_pathfilename("default", ".hob/")) == None:
             self.handler.init_cooker()
             self.handler.set_extra_inherit("image_types")
-            self.handler.parse_config()
+            self.handler.generate_configuration()
 
     def update_config_async(self):
         self.switch_page(self.MACHINE_SELECTION)
         self.set_user_config()
-        self.handler.parse_generate_configuration()
+        self.handler.generate_configuration()
 
     def populate_recipe_package_info_async(self):
         self.switch_page(self.RCPPKGINFO_POPULATING)
@@ -456,9 +456,6 @@ class Builder(gtk.Window):
     def cancel_build_sync(self, force=False):
         self.handler.cancel_build(force)
 
-    def generate_configuration_async(self):
-        self.handler.generate_configuration()
-
     def cancel_parse_sync(self):
         self.handler.cancel_parse()
 
@@ -604,11 +601,7 @@ class Builder(gtk.Window):
         self.parameters.all_package_formats = formats
 
     def handler_command_succeeded_cb(self, handler, initcmd):
-        if initcmd == self.handler.PARSE_CONFIG:
-            # settings
-            self.update_configuration_parameters(self.get_parameters_sync())
-            self.generate_configuration_async()
-        elif initcmd == self.handler.GENERATE_CONFIGURATION:
+        if initcmd == self.handler.GENERATE_CONFIGURATION:
             self.update_configuration_parameters(self.get_parameters_sync())
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index a61cca0..216b406 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -59,7 +59,7 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (PARSE_CONFIG, GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(6)
+    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
     (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(10)
 
     def __init__(self, server, recipe_model, package_model):
@@ -219,14 +219,6 @@ class HobHandler(gobject.GObject):
     def init_cooker(self):
         self.server.runCommand(["initCooker"])
 
-    def parse_config(self):
-        self.commands_async.append(self.SUB_PARSE_CONFIG)
-        self.run_next_command(self.PARSE_CONFIG)
-
-    def parse_generate_configuration(self):
-        self.commands_async.append(self.SUB_PARSE_CONFIG)
-        self.generate_configuration()
-
     def set_extra_inherit(self, bbclass):
         inherits = self.server.runCommand(["getVariable", "INHERIT"]) or ""
         inherits = inherits + " " + bbclass
@@ -312,6 +304,7 @@ class HobHandler(gobject.GObject):
         self.run_next_command(self.POPULATE_PACKAGEINFO)
 
     def generate_configuration(self):
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_PATH_LAYERS)
         self.commands_async.append(self.SUB_FILES_DISTRO)
         self.commands_async.append(self.SUB_FILES_MACH)
-- 
1.7.4.1



