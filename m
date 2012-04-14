Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ1H4-0000yH-5x
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 13:36:14 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Apr 2012 04:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130866619"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 14 Apr 2012 04:26:49 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 19:23:54 +0800
Message-Id: <a74a6a033e66a0ae7b47c84d842bdd54066c69a1.1334402345.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334402345.git.dongxiao.xu@intel.com>
References: <cover.1334402345.git.dongxiao.xu@intel.com>
Subject: [PATCH 3/4] Hob: Build selected image if not customized
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
X-List-Received-Date: Sat, 14 Apr 2012 11:36:14 -0000

If user selected a base image and didn't customize it, Hob will still
build the selected image instead of hob-image.

This fixes [YOCTO #2253]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   19 ++++++++++++++-----
 lib/bb/ui/crumbs/hobeventhandler.py |   17 +++++++++--------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 5e90219..3f26bac 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -395,16 +395,21 @@ class Builder(gtk.Window):
 
     def generate_image_async(self):
         self.switch_page(self.IMAGE_GENERATING)
+        self.handler.reset_build()
         # Build image
         self.set_user_config()
-        packages = self.package_model.get_selected_packages()
         toolchain_packages = []
         if self.configuration.toolchain_build:
             toolchain_packages = self.package_model.get_selected_packages_toolchain()
-        self.handler.reset_build()
-        self.handler.generate_image(packages,
-                                    self.hob_image,
+        if self.configuration.selected_image == self.recipe_model.__dummy_image__:
+            packages = self.package_model.get_selected_packages()
+            image = self.hob_image
+        else:
+            packages = []
+            image = self.configuration.selected_image
+        self.handler.generate_image(image,
                                     self.hob_toolchain,
+                                    packages,
                                     toolchain_packages)
 
     def get_parameters_sync(self):
@@ -690,7 +695,11 @@ class Builder(gtk.Window):
         elif self.current_step == self.IMAGE_GENERATING:
             fraction = 1.0
             self.parameters.image_names = []
-            linkname = 'hob-image-' + self.configuration.curr_mach
+            selected_image = self.recipe_model.get_selected_image()
+            if selected_image == self.recipe_model.__dummy_image__:
+                linkname = 'hob-image-' + self.configuration.curr_mach
+            else:
+                linkname = selected_image + '-' + self.configuration.curr_mach
             for image_type in self.parameters.image_types:
                 linkpath = self.parameters.image_addr + '/' + linkname + '.' + image_type
                 if os.path.exists(linkpath):
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 292d905..c297863 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -128,12 +128,13 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
             self.building = True
-            targets = [self.hob_image]
-            self.server.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
-            self.server.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
+            targets = [self.image]
+            if self.package_queue:
+                self.server.runCommand(["setVariable", "LINGUAS_INSTALL", ""])
+                self.server.runCommand(["setVariable", "PACKAGE_INSTALL", " ".join(self.package_queue)])
             if self.toolchain_packages:
                 self.server.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
-                targets.append(self.hob_toolchain)
+                targets.append(self.toolchain)
             self.server.runCommand(["buildTargets", targets, "build"])
 
     def handle_event(self, event):
@@ -352,10 +353,10 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, tgts, hob_image, hob_toolchain, toolchain_packages=[]):
-        self.package_queue = tgts
-        self.hob_image = hob_image
-        self.hob_toolchain = hob_toolchain
+    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[]):
+        self.image = image
+        self.toolchain = toolchain
+        self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_IMAGE)
-- 
1.7.4.1



