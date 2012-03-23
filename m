Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB6Gg-0005x7-4s
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:19:06 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 08:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144030926"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 08:10:11 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 23:07:52 +0800
Message-Id: <583567d6afc0fcabc73df36d15fc6c599c3decbe.1332514895.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
Subject: [PATCH 4/7] Hob: Change the Hob initialization process
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
X-List-Received-Date: Fri, 23 Mar 2012 15:19:06 -0000

This change allows adding extra inherits before getting all the
parameters.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   17 +++++++++++------
 lib/bb/ui/crumbs/hobeventhandler.py |    6 +++++-
 lib/bb/ui/hob.py                    |    2 --
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 0faef9b..d348497 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -186,11 +186,6 @@ class Builder(gtk.Window):
 
         self.template = None
 
-        # settings
-        params = self.handler.get_parameters()
-        self.configuration = Configuration(params)
-        self.parameters = Parameters(params)
-
         # build step
         self.current_step = None
         self.previous_step = None
@@ -224,6 +219,10 @@ class Builder(gtk.Window):
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
         self.handler.connect("command-failed",           self.handler_command_failed_cb)
 
+        self.handler.init_cooker()
+        self.handler.set_extra_inherit("image_types")
+        self.handler.parse_config()
+
         self.switch_page(self.MACHINE_SELECTION)
 
     def create_visual_elements(self):
@@ -409,7 +408,13 @@ class Builder(gtk.Window):
         self.parameters.all_layers = layers
 
     def handler_command_succeeded_cb(self, handler, initcmd):
-        if initcmd == self.handler.GENERATE_CONFIGURATION:
+        if initcmd == self.handler.PARSE_CONFIG:
+            # settings
+            params = self.handler.get_parameters()
+            self.configuration = Configuration(params)
+            self.parameters = Parameters(params)
+            self.handler.generate_configuration()
+        elif initcmd == self.handler.GENERATE_CONFIGURATION:
             self.image_configuration_page.switch_machine_combo()
         elif initcmd in [self.handler.GENERATE_RECIPES,
                          self.handler.GENERATE_PACKAGES,
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 8094d2d..308ef4d 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -62,7 +62,7 @@ class HobHandler(gobject.GObject):
                                      (gobject.TYPE_PYOBJECT,)),
     }
 
-    (GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
+    (PARSE_CONFIG, GENERATE_CONFIGURATION, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(6)
     (SUB_PATH_LAYERS, SUB_FILES_DISTRO, SUB_FILES_MACH, SUB_FILES_SDKMACH, SUB_MATCH_CLASS, SUB_PARSE_CONFIG, SUB_GNERATE_TGTS, SUB_GENERATE_PKGINFO, SUB_BUILD_RECIPES, SUB_BUILD_IMAGE) = range(10)
 
     def __init__(self, server, recipe_model, package_model):
@@ -246,6 +246,10 @@ class HobHandler(gobject.GObject):
     def init_cooker(self):
         self.server.runCommand(["initCooker"])
 
+    def parse_config(self):
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.run_next_command(self.PARSE_CONFIG)
+
     def refresh_layers(self, bblayers):
         self.init_cooker()
         self.set_bblayers(bblayers)
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 7c147c4..e72ab23 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -58,8 +58,6 @@ def main (server = None, eventHandler = None):
     hobHandler = HobHandler(server, recipe_model, package_model)
     builder = Builder(hobHandler, recipe_model, package_model)
 
-    hobHandler.generate_configuration()
-
     # This timeout function regularly probes the event queue to find out if we
     # have any messages waiting for us.
     gobject.timeout_add(10, event_handle_idle_func, eventHandler, hobHandler)
-- 
1.7.4.1



