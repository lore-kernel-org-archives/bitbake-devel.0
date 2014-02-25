Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id C6FF96E760
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Feb 2014 07:07:33 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 24 Feb 2014 23:07:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,538,1389772800"; d="scan'208";a="487584166"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 23:07:33 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Feb 2014 09:15:31 +0200
Message-Id: <1393312531-699-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: replace the use of hob-toolchain with populate_sdk task
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Feb 2014 07:07:34 -0000

Now bitbake has an API to run individual task for targets.
Hob can use this to build the sdk, instead of using the hob-
toolchain.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 --
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   16 ++++++++--------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1e26d44..5ae1ddb 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -380,7 +380,6 @@ class Builder(gtk.Window):
         super(Builder, self).__init__()
 
         self.hob_image = "hob-image"
-        self.hob_toolchain = "hob-toolchain"
 
         # handler
         self.handler = hobHandler
@@ -597,7 +596,6 @@ class Builder(gtk.Window):
             image = self.configuration.selected_image
         self.handler.generate_image(image,
                                     base_image,
-                                    self.hob_toolchain,
                                     packages,
                                     toolchain_packages,
                                     self.configuration.default_task)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 3792328..1282070 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -164,18 +164,19 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_BUILD_IMAGE:
             self.clear_busy()
             self.building = True
-            targets = [self.image]
-            if self.toolchain_packages:
-                self.set_var_in_file("TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages), "local.conf")
-                targets.append(self.toolchain)
-            if targets[0] == "hob-image":
+            target = self.image
+            if target == "hob-image":
                 self.set_var_in_file("LINGUAS_INSTALL", "", "local.conf")
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
                 if self.base_image != "Start with an empty image recipe":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
                     version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
-                    targets[0] += version
+                    target += version
                     self.recipe_model.set_custom_image_version(version)
+            targets = [target]
+            if self.toolchain_packages:
+                self.set_var_in_file("TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages), "local.conf")
+                targets.append(target + ":do_populate_sdk")
 
             self.runCommand(["buildTargets", targets, self.default_task])
 
@@ -423,10 +424,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, image, base_image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
+    def generate_image(self, image, base_image, image_packages=[], toolchain_packages=[], default_task="build"):
         self.image = image
         self.base_image = base_image
-        self.toolchain = toolchain
         self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
         self.default_task = default_task
-- 
1.7.9.5


