Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TgbTD-0000FW-6V
	for bitbake-devel@lists.openembedded.org;
	Thu, 06 Dec 2012 14:26:34 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 06 Dec 2012 05:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,230,1355126400"; d="scan'208";a="229807896"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga001.jf.intel.com with ESMTP; 06 Dec 2012 05:12:03 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Dec 2012 15:15:06 +0200
Message-Id: <1354799706-9226-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/bitbake: custom image is now using the base image
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
X-List-Received-Date: Thu, 06 Dec 2012 13:26:34 -0000

Till now, a custom image made in Hob was using only the packages from
the base image. Now it is using everything declared in the base image.
Also next to hob-image.bb, it creates another .bb file which is used
in building process. Those images are ignored by git.

[YOCTO #2601]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .gitignore                                  |    1 +
 bitbake/lib/bb/command.py                   |    8 +++++--
 bitbake/lib/bb/cooker.py                    |   31 +++++++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/builder.py         |    3 +++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    5 +++--
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index 88c91f6..003f09a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -15,3 +15,4 @@ meta-*
 *~
 !meta-yocto
 !meta-yocto-bsp
+hob-image-*.bb
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3f28bca..48b09e4 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -220,8 +220,12 @@ class CommandsAsync:
         """
         pkgs_to_build = params[0]
         task = params[1]
-
-        command.cooker.buildTargets(pkgs_to_build, task)
+        if len(params) > 2:
+            base_image = params[2]
+            package_queue = params[3]
+            command.cooker.buildTargets(pkgs_to_build, task, base_image, package_queue)
+        else:
+            command.cooker.buildTargets(pkgs_to_build, task)
     buildTargets.needcache = True
 
     def generateDepTreeEvent(self, command, params):
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 6b58f91..22d8bd1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -23,7 +23,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from __future__ import print_function
-import sys, os, glob, os.path, re, time
+import sys, os, glob, os.path, re, time, shutil
 import atexit
 import itertools
 import logging
@@ -1127,11 +1127,14 @@ class BBCooker:
 
         self.server_registration_cb(buildFileIdle, rq)
 
-    def buildTargets(self, targets, task):
+    def buildTargets(self, targets, task, base_image=None, package_queue=None):
         """
         Attempt to build the targets specified
         """
 
+        if base_image != None and targets[0] == "hob-image":
+            self.prepareHobImage(base_image, package_queue)
+
         # Need files parsed
         self.updateCache()
 
@@ -1188,6 +1191,30 @@ class BBCooker:
 
         self.server_registration_cb(buildTargetsIdle, rq)
 
+    def prepareHobImage(self, base_image, package_queue):
+        '''
+        Create a new hob-image with a "require" base_image statement
+        '''
+        hob_image = self.matchFile("hob-image.bb")
+        base_image = self.matchFile(str(base_image) + ".bb")
+        with open(hob_image, "a") as hobimagefile:
+            hobimagefile.write("require " + base_image + "\n")
+            package_install = "PACKAGE_INSTALL_forcevariable = \""
+            for package in package_queue:
+                package_install += str(package) + " "
+            package_install += "\"\n"
+            hobimagefile.write(package_install)
+
+        dir_hob_image = os.path.dirname(hob_image)
+        timestr = time.strftime("%Y%m%d-%H%M%S")
+        dest = dir_hob_image + "/hob-image-" + str(timestr) + ".bb"
+        shutil.copyfile(hob_image, dest)
+
+        self.parser.reparse(hob_image)
+
+        with open(hob_image, "w") as hobimagefile:
+            hobimagefile.write("inherit image\n")
+
     def updateCache(self):
         if self.state == state.running:
             return
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2f3d6d0..663c322 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -611,15 +611,18 @@ class Builder(gtk.Window):
         # Build image
         self.set_user_config()
         toolchain_packages = []
+        base_image = None
         if self.configuration.toolchain_build:
             toolchain_packages = self.package_model.get_selected_packages_toolchain()
         if self.configuration.selected_image == self.recipe_model.__custom_image__:
             packages = self.package_model.get_selected_packages()
             image = self.hob_image
+            base_image = self.configuration.initial_selected_image
         else:
             packages = []
             image = self.configuration.selected_image
         self.handler.generate_image(image,
+                                    base_image,
                                     self.hob_toolchain,
                                     packages,
                                     toolchain_packages,
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8a2ac5f..1583f76 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -166,7 +166,7 @@ class HobHandler(gobject.GObject):
             if self.toolchain_packages:
                 self.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.toolchain)
-            self.runCommand(["buildTargets", targets, self.default_task])
+            self.runCommand(["buildTargets", targets, self.default_task, self.base_image, self.package_queue])
 
     def display_error(self):
         self.clear_busy()
@@ -386,8 +386,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
+    def generate_image(self, image, base_image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
         self.image = image
+        self.base_image = base_image
         self.toolchain = toolchain
         self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
-- 
1.7.9.5



