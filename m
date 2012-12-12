Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Til1s-0000tM-Un
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 13:03:14 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 12 Dec 2012 03:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,266,1355126400"; d="scan'208";a="262925356"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga002.fm.intel.com with ESMTP; 12 Dec 2012 03:48:37 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Dec 2012 13:51:51 +0200
Message-Id: <1355313111-28624-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PatchV3] hob/bitbake: custom image is now using the base image
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
X-List-Received-Date: Wed, 12 Dec 2012 12:03:14 -0000

Till now, a custom image made in Hob was using only the packages from
the base image. Now it is using everything declared in the base image.
Also next to hob-image.bb, it creates another .bb file which is used
in building process. Those images are ignored by git.

[YOCTO #2601]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .gitignore                                  |    1 +
 bitbake/lib/bb/command.py                   |   10 ++++++++++
 bitbake/lib/bb/cooker.py                    |   19 +++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/builder.py         |    6 +++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   10 +++++++++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py    |    6 ++++++
 6 files changed, 50 insertions(+), 2 deletions(-)

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
index 3f28bca..28b4c5d 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -197,6 +197,16 @@ class CommandsSync:
         filterfunc = params[0]
         bb.parse.parse_py.ConfHandler.confFilters.append(filterfunc)
 
+    def matchFile(self, command, params):
+        fMatch = params[0]
+        return command.cooker.matchFile(fMatch)
+
+    def generateNewImage(self, command, params):
+        image = params[0]
+        base_image = params[1]
+        package_queue = params[2]
+        return command.cooker.generateNewImage(image, base_image, package_queue)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 6b58f91..1d38164 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1188,6 +1188,25 @@ class BBCooker:
 
         self.server_registration_cb(buildTargetsIdle, rq)
 
+    def generateNewImage(self, image, base_image, package_queue):
+        '''
+        Create a new image with a "require" base_image statement
+        '''
+        image_name = os.path.splitext(image)[0]
+        timestr = time.strftime("-%Y%m%d-%H%M%S")
+        dest = image_name + str(timestr) + ".bb"
+
+        with open(dest, "w") as imagefile:
+            imagefile.write("require " + base_image + "\n")
+            package_install = "PACKAGE_INSTALL_forcevariable = \""
+            for package in package_queue:
+                package_install += str(package) + " "
+            package_install += "\"\n"
+            imagefile.write(package_install)
+
+        self.state = state.initial
+        return timestr
+
     def updateCache(self):
         if self.state == state.running:
             return
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 2f3d6d0..023ac93 100755
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
@@ -1017,7 +1020,8 @@ class Builder(gtk.Window):
             self.parameters.image_names = []
             selected_image = self.recipe_model.get_selected_image()
             if selected_image == self.recipe_model.__custom_image__:
-                linkname = 'hob-image-' + self.configuration.curr_mach
+                version = self.recipe_model.get_custom_image_version()
+                linkname = 'hob-image' + version+ "-" + self.configuration.curr_mach
             else:
                 linkname = selected_image + '-' + self.configuration.curr_mach
             image_extension = self.get_image_extension()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8a2ac5f..ae853ee 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -166,6 +166,13 @@ class HobHandler(gobject.GObject):
             if self.toolchain_packages:
                 self.runCommand(["setVariable", "TOOLCHAIN_TARGET_TASK", " ".join(self.toolchain_packages)])
                 targets.append(self.toolchain)
+            if targets[0] == "hob-image":
+                hobImage = self.runCommand(["matchFile", "hob-image.bb"])
+                baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
+                version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
+                targets[0] += version
+                self.recipe_model.set_custom_image_version(version)
+
             self.runCommand(["buildTargets", targets, self.default_task])
 
     def display_error(self):
@@ -386,8 +393,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
 
-    def generate_image(self, image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
+    def generate_image(self, image, base_image, toolchain, image_packages=[], toolchain_packages=[], default_task="build"):
         self.image = image
+        self.base_image = base_image
         self.toolchain = toolchain
         self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index f4ccbc3..85c4f51 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -766,3 +766,9 @@ class RecipeListModel(gtk.ListStore):
                           binb="User Selected",
                           image_contents=True)
         self.selection_change_notification()
+
+    def set_custom_image_version(self, version):
+        self.custom_image_version = version
+
+    def get_custom_image_version(self):
+        return self.custom_image_version
-- 
1.7.9.5



