Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDh-0007Oa-K0
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Mar 2012 05:03:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126516858"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 29 Mar 2012 05:03:46 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:09 +0800
Message-Id: <9c35bb0afc4005cafccdfca52ceed9595622ba61.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 03/14] Hob: Define a variable to store the image name and toolchain
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:50 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |    9 +++++++--
 lib/bb/ui/crumbs/hobeventhandler.py |    8 +++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 6b16ac8..6b56a25 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -221,6 +221,9 @@ class Builder(gtk.Window):
     def __init__(self, hobHandler, recipe_model, package_model):
         super(Builder, self).__init__()
 
+        self.hob_image = "hob-image"
+        self.hob_toolchain = "hob-toolchain"
+
         # handler
         self.handler = hobHandler
 
@@ -435,8 +438,10 @@ class Builder(gtk.Window):
         self.set_user_config()
         all_packages = self.package_model.get_selected_packages()
         self.handler.reset_build()
-        self.handler.generate_image(all_packages, self.configuration.toolchain_build)
-
+        self.handler.generate_image(all_packages,
+                                    self.hob_image,
+                                    self.hob_toolchain,
+                                    self.configuration.toolchain_build)
 
     # Callback Functions
     def handler_config_updated_cb(self, handler, which, values):
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 1cbb027..e5e0b42 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -128,13 +128,13 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
             self.building = True
-            targets = ["hob-image"]
+            targets = [self.hob_image]
             self.server.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
             self.server.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
             if self.toolchain_build:
                 pkgs = self.package_queue + [i+'-dev' for i in self.package_queue] + [i+'-dbg' for i in self.package_queue]
                 self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(pkgs)])
-                targets.append("hob-toolchain")
+                targets.append(self.hob_toolchain)
             self.server.runCommand(["buildTargets", targets, "build"])
 
     def handle_event(self, event):
@@ -351,8 +351,10 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, tgts, toolchain_build=False):
+    def generate_image(self, tgts, hob_image, hob_toolchain, toolchain_build=False):
         self.package_queue = tgts
+        self.hob_image = hob_image
+        self.hob_toolchain = hob_toolchain
         self.toolchain_build = toolchain_build
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_IMAGE)
-- 
1.7.4.1



