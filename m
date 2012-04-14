Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ0cy-0008TR-CB
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 12:54:48 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Apr 2012 03:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132447941"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 14 Apr 2012 03:45:27 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 18:42:30 +0800
Message-Id: <894696b559b781edba711ad75452e8a2942d122f.1334400003.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334400003.git.dongxiao.xu@intel.com>
References: <cover.1334400003.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Sat, 14 Apr 2012 10:54:48 -0000

Originally we use hardcoded "build" as the default task. This commit
fixes it by using BB_DEFAULT_TASK.

This fixes [YOCTO #2283]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    6 +++++-
 lib/bb/ui/crumbs/hobeventhandler.py |    7 +++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 3f26bac..03a7caa 100755
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
index c297863..a46d838 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -135,7 +135,7 @@ class HobHandler(gobject.GObject):
             if self.toolchain_packages:
                 self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.toolchain)
-            self.server.runCommand(["buildTargets", targets, "build"])
+            self.server.runCommand(["buildTargets", targets, self.default_task])
 
     def handle_event(self, event):
         if not event:
@@ -353,11 +353,12 @@ class HobHandler(gobject.GObject):
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
@@ -495,6 +496,8 @@ class HobHandler(gobject.GObject):
         params["bb_version"] = self.server.runCommand(["getVariable", "BB_MIN_VERSION"]) or ""
         params["tune_arch"] = self.server.runCommand(["getVariable", "TUNE_ARCH"]) or ""
 
+        params["default_task"] = self.server.runCommand(["getVariable", "BB_DEFAULT_TASK"]) or "build"
+
         params["git_proxy_host"] = self.server.runCommand(["getVariable", "GIT_PROXY_HOST"]) or ""
         params["git_proxy_port"] = self.server.runCommand(["getVariable", "GIT_PROXY_PORT"]) or ""
 
-- 
1.7.4.1



