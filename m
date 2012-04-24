Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SMb7N-00059y-S5
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Apr 2012 10:29:02 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 24 Apr 2012 01:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="133143283"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 24 Apr 2012 01:19:25 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Apr 2012 16:16:12 +0800
Message-Id: <1aa63ea4ec4d4e9857728cc6d4d47ee177a5bbe4.1335254750.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/3] Hob: Issue sanity check after parse is completed
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
X-List-Received-Date: Tue, 24 Apr 2012 08:29:02 -0000

In original scheme, sanity check is part of the parsing process. If a
sanity check fails, it means the parsing is failed and values in Hob
GUI may not correct.

With this commit, Hob will actively issue sanity_check() after the
parsing is completed.

This fixes [YOCTO #2361]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    7 +++++--
 lib/bb/ui/crumbs/hobeventhandler.py |   16 +++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index cbcb3f1..4b274a7 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -405,6 +405,9 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.generate_configuration()
 
+    def sanity_check(self):
+        self.handler.trigger_sanity_check()
+
     def populate_recipe_package_info_async(self):
         self.switch_page(self.RCPPKGINFO_POPULATING)
         # Parse recipes
@@ -557,8 +560,6 @@ class Builder(gtk.Window):
         self.handler.init_cooker()
         # set bb layers
         self.handler.set_bblayers(self.configuration.layers)
-        # Re-enable sanity checks
-        self.handler.enable_sanity()
         # set local configuration
         self.handler.set_machine(self.configuration.curr_mach)
         self.handler.set_package_format(self.configuration.curr_package_format)
@@ -620,6 +621,8 @@ class Builder(gtk.Window):
     def handler_command_succeeded_cb(self, handler, initcmd):
         if initcmd == self.handler.GENERATE_CONFIGURATION:
             self.update_configuration_parameters(self.get_parameters_sync())
+            self.sanity_check()
+        elif initcmd == self.handler.SANITY_CHECK:
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index c918aad..a07afdd 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -59,8 +59,8 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
-    (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(10)
+    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO, SANITY_CHECK) = range(6)
+    (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_SANITY_CHECK, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(11)
 
     def __init__(self, server, recipe_model, package_model):
         super(HobHandler, self).__init__()
@@ -129,6 +129,8 @@ class HobHandler(gobject.GObject):
             self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
             self.runCommand(["triggerEvent", "bb.event.RequestPackageInfo()"])
+        elif next_command == self.SUB_SANITY_CHECK:
+            self.runCommand(["triggerEvent", "bb.event.SanityCheck()"])
         elif next_command == self.SUB_BUILD_RECIPES:
             self.clear_busy()
             self.building = True
@@ -158,6 +160,9 @@ class HobHandler(gobject.GObject):
             self.package_model.populate(event._pkginfolist)
             self.run_next_command()
 
+        elif isinstance(event, bb.event.SanityCheckPassed):
+            self.run_next_command()
+
         elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
                 self.error_msg += event.msg + '\n'
@@ -233,9 +238,6 @@ class HobHandler(gobject.GObject):
         inherits = inherits + " " + bbclass
         self.runCommand(["setVariable", "INHERIT", inherits])
 
-    def enable_sanity(self):
-        self.runCommand(["setVariable", "DISABLE_SANITY_CHECKS", "0"])
-
     def set_bblayers(self, bblayers):
         self.runCommand(["setVariable", "BBLAYERS_HOB", " ".join(bblayers)])
 
@@ -315,6 +317,10 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_GENERATE_PKGINFO)
         self.run_next_command(self.POPULATE_PACKAGEINFO)
 
+    def trigger_sanity_check(self):
+        self.commands_async.append(self.SUB_SANITY_CHECK)
+        self.run_next_command(self.SANITY_CHECK)
+
     def generate_configuration(self):
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_PATH_LAYERS)
-- 
1.7.4.1



