Return-Path: <cristiana.voicu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 1006960FEE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2013 11:40:08 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 25 Jul 2013 04:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,742,1367996400"; d="scan'208";a="370781037"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2013 04:40:07 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jul 2013 14:42:17 +0300
Message-Id: <1374752549-29471-5-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
References: <1374752549-29471-1-git-send-email-cristiana.voicu@intel.com>
Subject: [PATCH_V2 04/16] hob/bitbake: save the description of a custom image
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
X-List-Received-Date: Thu, 25 Jul 2013 11:40:08 -0000

When an new image is saved, the dialog for this action has
a field for the description. Changed how an image is saved, by
appending the DESCRIPTION variable at the end of the .bb file.

[YOCTO #4193]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py                       |    3 ++-
 bitbake/lib/bb/cooker.py                        |    5 ++++-
 bitbake/lib/bb/ui/crumbs/builder.py             |    4 ++--
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py |    4 +++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py     |    6 +++---
 5 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 9017e49..c38eab7 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -215,8 +215,9 @@ class CommandsSync:
         base_image = params[1]
         package_queue = params[2]
         timestamp = params[3]
+        description = params[4]
         return command.cooker.generateNewImage(image, base_image,
-                                 package_queue, timestamp)
+                        package_queue, timestamp, description)
 
     def ensureDir(self, command, params):
         directory = params[0]
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7d54ab1..096391f 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1104,7 +1104,7 @@ class BBCooker:
         if not os.path.exists(d):
             os.makedirs(d)
 
-    def generateNewImage(self, image, base_image, package_queue, timestamp):
+    def generateNewImage(self, image, base_image, package_queue, timestamp, description):
         '''
         Create a new image with a "require"/"inherit" base_image statement
         '''
@@ -1129,6 +1129,9 @@ class BBCooker:
             package_install += "\"\n"
             imagefile.write(package_install)
 
+            description_var = "DESCRIPTION = \"" + description + "\"\n"
+            imagefile.write(description_var)
+
         self.state = state.initial
         if timestamp:
             return timestr
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 0a04c90..6bf4024 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -593,12 +593,12 @@ class Builder(gtk.Window):
                                     toolchain_packages,
                                     self.configuration.default_task)
 
-    def generate_new_image(self, image):
+    def generate_new_image(self, image, description):
         base_image = self.configuration.initial_selected_image
         if base_image == self.recipe_model.__custom_image__:
             base_image = None
         packages = self.package_model.get_selected_packages()
-        self.handler.generate_new_image(image, base_image, packages)
+        self.handler.generate_new_image(image, base_image, packages, description)
 
     def ensure_dir(self, directory):
         self.handler.ensure_dir(directory)
diff --git a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
index cb0c400..2f57706 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py
@@ -116,8 +116,10 @@ class SaveImageDialog (CrumbsDialog):
     def save_button_cb(self, button):
         text = self.name_entry.get_text()
         new_text = text.replace("-","")
+        description_buffer = self.description_entry.get_buffer()
+        description = description_buffer.get_text(description_buffer.get_start_iter(),description_buffer.get_end_iter())
         if new_text.islower() and new_text.isalnum():
-            self.builder.generate_new_image(self.directory+text)
+            self.builder.generate_new_image(self.directory+text, description)
             self.destroy()
         else:
             self.show_invalid_input_error_dialog()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 34cd347..42fd0b9 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -176,7 +176,7 @@ class HobHandler(gobject.GObject):
                 hobImage = self.runCommand(["matchFile", "hob-image.bb"])
                 if self.base_image != "Start with an empty image recipe":
                     baseImage = self.runCommand(["matchFile", self.base_image + ".bb"])
-                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True])
+                    version = self.runCommand(["generateNewImage", hobImage, baseImage, self.package_queue, True, ""])
                     targets[0] += version
                     self.recipe_model.set_custom_image_version(version)
 
@@ -426,9 +426,9 @@ class HobHandler(gobject.GObject):
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)
 
-    def generate_new_image(self, image, base_image, package_queue):
+    def generate_new_image(self, image, base_image, package_queue, description):
         base_image = self.runCommand(["matchFile", self.base_image + ".bb"])
-        self.runCommand(["generateNewImage", image, base_image, package_queue, False])
+        self.runCommand(["generateNewImage", image, base_image, package_queue, False, description])
 
     def ensure_dir(self, directory):
         self.runCommand(["ensureDir", directory])
-- 
1.7.9.5


