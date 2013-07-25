Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 868676B343
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2013 11:40:06 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 25 Jul 2013 04:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,742,1367996400"; d="scan'208";a="370781016"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2013 04:40:06 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2013 14:42:16 +0300
Message-Id: <1374752549-29471-4-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 03/16] hob/bitbake: create a template (a .bb file) from hob through bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 25 Jul 2013 11:40:07 -0000

Modified generateNewImage function from cooker, in order to be used to
save a template in Hob.
Created a command to ensure that some dirs are created. The templates
(recipes) will be saved in {TOPDIR}/recipes/images folder.
Called these methods from Hob.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                       |    8 ++++++-
 bitbake/lib/bb/cooker.py                        |   28 +++++++++++++++++------
 bitbake/lib/bb/ui/crumbs/builder.py             |   10 ++++++++
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py     |    9 +++++++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py    |    2 ++
 6 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 1727654..9017e49 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -214,7 +214,13 @@ class CommandsSync:
         image = params[0]
         base_image = params[1]
         package_queue = params[2]
-        return command.cooker.generateNewImage(image, base_image, package_queue)
+        timestamp = params[3]
+        return command.cooker.generateNewImage(image, base_image,
+                                 package_queue, timestamp)
+
+    def ensureDir(self, command, params):
+        directory = params[0]
+        command.cooker.ensureDir(directory)
 
     def setVarFile(self, command, params):
         """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 49e6345..7d54ab1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1100,16 +1100,29 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(buildTargetsIdle, rq)
 
-    def generateNewImage(self, image, base_image, package_queue):
+    def ensureDir(self, d):
+        if not os.path.exists(d):
+            os.makedirs(d)
+
+    def generateNewImage(self, image, base_image, package_queue, timestamp):
         '''
-        Create a new image with a "require" base_image statement
+        Create a new image with a "require"/"inherit" base_image statement
         '''
-        image_name = os.path.splitext(image)[0]
-        timestr = time.strftime("-%Y%m%d-%H%M%S")
-        dest = image_name + str(timestr) + ".bb"
+        if timestamp:
+            image_name = os.path.splitext(image)[0]
+            timestr = time.strftime("-%Y%m%d-%H%M%S")
+            dest = image_name + str(timestr) + ".bb"
+        else:
+            if not image.endswith(".bb"):
+                dest = image + ".bb"
+            else:
+                dest = image
 
         with open(dest, "w") as imagefile:
-            imagefile.write("require " + base_image + "\n")
+            if base_image is None:
+                imagefile.write("inherit image\n")
+            else:
+                imagefile.write("require " + base_image + "\n")
             package_install = "PACKAGE_INSTALL_forcevariable = \""
             for package in package_queue:
                 package_install += str(package) + " "
@@ -1117,7 +1130,8 @@ class BBCooker:
             imagefile.write(package_install)
 
         self.state = state.initial
-        return timestr
+        if timestamp:
+            return timestr
 
     def updateCache(self):
         if self.state == state.running:
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 317a2fe..0a04c90 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -593,6 +593,16 @@ class Builder(gtk.Window):
                                     toolchain_packages,
                                     self.configuration.default_task)
 
+    def generate_new_image(self, image):
+        base_image = self.configuration.initial_selected_image
+        if base_image == self.recipe_model.__custom_image__:
+            base_image = None
+        packages = self.package_model.get_selected_packages()
+        self.handler.generate_new_image(image, base_image, packages)
+
+    def ensure_dir(self, directory):
+        self.handler.ensure_dir(directory)
+
     def get_parameters_sync(self):
         return self.handler.get_parameters()
 
diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index d998a47..cb0c400 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -117,7 +117,7 @@ class SaveImageDialog (CrumbsDialog):
         text = self.name_entry.get_text()
         new_text = text.replace("-","")
         if new_text.islower() and new_text.isalnum():
-            print(text)
+            self.builder.generate_new_image(self.directory+text)
             self.destroy()
         else:
             self.show_invalid_input_error_dialog()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 294eb5d..34cd347 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -176,7 +176,7 @@ class HobHandler(gobject.GObject):
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
                 if self.base_image != "Start with an empty image recipe":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue])
+                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True])
                     targets[0] += version
                     self.recipe_model.set_custom_image_version(version)
 
@@ -426,6 +426,13 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
+    def generate_new_image(self, image, base_image, package_queue):
+        base_image = self.runCommand(["matchFile", self.base_image + ".bb"])
+        self.runCommand(["generateNewImage", image, base_image, package_queue, False])
+
+    def ensure_dir(self, directory):
+        self.runCommand(["ensureDir", directory])
+
     def build_succeeded_async(self):
         self.building = False
 
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index a02ab61..f55d43f 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -624,6 +624,8 @@ class ImageDetailsPage (HobPage):
     def save_button_clicked_cb(self, button):
         topdir = self.builder.get_topdir()
         images_dir = topdir + "/recipes/images/"
+        self.builder.ensure_dir(images_dir)
+
         dialog = SaveImageDialog(images_dir, "Save image recipe", self.builder,
                               gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
         response = dialog.run()
-- 
1.7.9.5


