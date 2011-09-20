Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R61uq-0000rF-49
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Sep 2011 17:07:20 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,411,1312182000"; d="scan'208";a="18826191"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.183])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Sep 2011 08:01:59 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Sep 2011 08:01:50 -0700
Message-Id: <ab6c63f35739c30df0e8a9d0f1ae982b96e538ed.1316530820.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
In-Reply-To: <cover.1316530819.git.josh@linux.intel.com>
References: <cover.1316530819.git.josh@linux.intel.com>
Subject: [PATCH 2/3] hob: fix build again when building packages only
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
X-List-Received-Date: Tue, 20 Sep 2011 15:07:20 -0000

The different code paths for package vs image builds have lead to some bit
rot in the package only build and an incompatability between package only
builds and the build again mechanism.

This patch unifies the code paths and fixes build again for package only
builds.

Fixes [YOCTO #1480]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   13 +++++--------
 lib/bb/ui/hob.py                    |   11 +++++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 8bf599f..393b407 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -71,7 +71,7 @@ class HobHandler(gobject.GObject):
         gobject.GObject.__init__(self)
 
         self.current_command = None
-        self.building = None
+        self.building = False
         self.build_toolchain = False
         self.build_toolchain_headers = False
         self.generating = False
@@ -128,10 +128,10 @@ class HobHandler(gobject.GObject):
             self.server.runCommand(["resetCooker"])
             self.server.runCommand(["reparseFiles"])
         elif self.current_command == self.BUILD_IMAGE:
-            self.building = "image"
             if self.generating:
                 self.emit("data-generated")
                 self.generating = False
+            self.building = True
             self.server.runCommand(["buildTargets", self.build_queue, "build"])
             self.build_queue = []
             self.current_command = None
@@ -247,11 +247,12 @@ class HobHandler(gobject.GObject):
         pmake = "-j %s" % threads
         self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", pmake])
 
-    def build_image(self, image, configurator):
+    def build_targets(self, tgts, configurator, build_type="image"):
+        self.build_type = build_type
         targets = []
         nbbp = None
         nbbf = None
-        targets.append(image)
+        targets.extend(tgts)
         if self.build_toolchain and self.build_toolchain_headers:
             targets.append("meta-toolchain-sdk")
         elif self.build_toolchain:
@@ -284,10 +285,6 @@ class HobHandler(gobject.GObject):
         self.current_command = self.REPARSE_FILES
         self.run_next_command()
 
-    def build_packages(self, pkgs):
-        self.building = "packages"
-        self.server.runCommand(["buildTargets", pkgs, "build"])
-
     def cancel_build(self, force=False):
         if force:
             # Force the cooker to stop as quickly as possible
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 51a995e..0f738ce 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -459,6 +459,9 @@ class MainWindow (gtk.Window):
             image_name = recipepath.rstrip(".bb")
             path, sep, image_name = image_name.rpartition("/")
 
+            image = []
+            image.append(image_name)
+
             rep.writeRecipe(recipepath, self.model)
             # In the case where we saved the file for the purpose of building
             # it we should then delete it so that the users workspace doesn't
@@ -466,9 +469,9 @@ class MainWindow (gtk.Window):
             if not self.save_path:
                 self.files_to_clean.append(recipepath)
 
-            self.handler.build_image(image_name, self.configurator)
+            self.handler.build_targets(image, self.configurator)
         else:
-            self.handler.build_packages(self.model.get_selected_pn())
+            self.handler.build_targets(self.model.get_selected_pn(), self.configurator, "packages")
 
         # Disable parts of the menu which shouldn't be used whilst building
         self.set_menus_sensitive(False)
@@ -490,7 +493,7 @@ class MainWindow (gtk.Window):
 
     def build_complete_cb(self, running_build):
         # Have the handler process BB events again
-        self.handler.building = None
+        self.handler.building = False
         self.stopping = False
         self.back.connect("clicked", self.back_button_clicked_cb)
         self.back.set_sensitive(True)
@@ -504,7 +507,7 @@ class MainWindow (gtk.Window):
         self.files_to_clean = []
 
         lbl = "<b>Build completed</b>\n\nClick 'Edit Image' to start another build or 'View Messages' to view the messages output during the build."
-        if self.handler.building == "image" and self.build_succeeded:
+        if self.handler.build_type == "image" and self.build_succeeded:
             deploy = self.handler.get_image_deploy_dir()
             lbl = lbl + "\n<a href=\"file://%s\" title=\"%s\">Browse folder of built images</a>." % (deploy, deploy)
 
-- 
1.7.6.2



