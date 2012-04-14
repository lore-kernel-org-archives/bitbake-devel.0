Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ1HG-00011V-PI
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 13:36:27 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 14 Apr 2012 04:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="89019029"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 14 Apr 2012 04:26:50 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 19:23:55 +0800
Message-Id: <7540f8d446345559ea9b47f4ff71d203ffdfaf8d.1334402345.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
Subject: [PATCH 4/4] Hob: Use BB_DEFAULT_TASK as build task instead of hardcoded "build"
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
X-List-Received-Date: Sat, 14 Apr 2012 11:36:27 -0000

Originally we use hardcoded "build" as the default task. This commit
fixes it by using BB_DEFAULT_TASK.

This fixes [YOCTO #2283]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   10 +++++++---
 lib/bb/ui/crumbs/hobeventhandler.py |   12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 3f26bac..de9685d 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -71,6 +71,8 @@ class Configuration:
 
         self.user_selected_packages = []
 
+        self.default_task = params["default_task"]
+
         # proxy settings
         self.all_proxy = params["all_proxy"]
         self.http_proxy = params["http_proxy"]
@@ -105,6 +107,7 @@ class Configuration:
         self.tune_pkgarch = params["tune_pkgarch"]
         # bblayers.conf
         self.layers = params["layer"].split()
+        self.default_task = params["default_task"]
 
     def load(self, template):
         self.curr_mach = template.getVar("MACHINE")
@@ -383,7 +386,7 @@ class Builder(gtk.Window):
         _, all_recipes = self.recipe_model.get_selected_recipes()
         self.set_user_config()
         self.handler.reset_build()
-        self.handler.generate_packages(all_recipes)
+        self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
     def fast_generate_image_async(self):
         self.switch_page(self.FAST_IMAGE_GENERATING)
@@ -391,7 +394,7 @@ class Builder(gtk.Window):
         _, all_recipes = self.recipe_model.get_selected_recipes()
         self.set_user_config()
         self.handler.reset_build()
-        self.handler.generate_packages(all_recipes)
+        self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
     def generate_image_async(self):
         self.switch_page(self.IMAGE_GENERATING)
@@ -410,7 +413,8 @@ class Builder(gtk.Window):
         self.handler.generate_image(image,
                                     self.hob_toolchain,
                                     packages,
-                                    toolchain_packages)
+                                    toolchain_packages,
+                                    self.configuration.default_task)
 
     def get_parameters_sync(self):
         return self.handler.get_parameters()
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index c297863..17d3fe4 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -123,7 +123,7 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_BUILD_RECIPES:
             self.clear_busy()
             self.building = True
-            self.server.runCommand(["buildTargets", self.recipe_queue, "build"])
+            self.server.runCommand(["buildTargets", self.recipe_queue, self.default_task])
             self.recipe_queue = []
         elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
@@ -135,7 +135,7 @@ class HobHandler(gobject.GObject):
             if self.toolchain_packages:
                 self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.toolchain)
-            self.server.runCommand(["buildTargets", targets, "build"])
+            self.server.runCommand(["buildTargets", targets, self.default_task])
 
     def handle_event(self, event):
         if not event:
@@ -345,19 +345,21 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_GNERATE_TGTS)
         self.run_next_command(self.GENERATE_RECIPES)
                  
-    def generate_packages(self, tgts):
+    def generate_packages(self, tgts, default_task="build"):
         targets = []
         targets.extend(tgts)
         self.recipe_queue = targets
+        self.default_task = default_task
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[]):
+    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
         self.image = image
         self.toolchain = toolchain
         self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
+        self.default_task = default_task
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
@@ -495,6 +497,8 @@ class HobHandler(gobject.GObject):
         params["bb_version"] = self.server.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
         params["tune_arch"] = self.server.runCommand(["getVariable", "TUNE_ARCH"]) or ""
 
+        params["default_task"] = self.server.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
+
         params["git_proxy_host"] = self.server.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
         params["git_proxy_port"] = self.server.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
 
-- 
1.7.4.1



