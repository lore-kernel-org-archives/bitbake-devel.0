Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmio-0003hd-Pw
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353974"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:52 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:37 -0700
Message-Id: <5840d59098141e773c12bea8ed8d9f4f1a706132.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 03/10] ui/hob: switch from buildFile to buildTargets for custom image builds
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:15 -0000

We need to use the buildTargets command to ensure dependencies, such as
native tools to build the rootfs, are correctly included. This patch
achieves this by modifying BBPATH and BBFILES to include matches for the
location of the generated recipe file and reparsing the metadata before
calling buildTargets.

Fixes [YOCTO #1228]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |   18 +++++++++
 lib/bb/ui/crumbs/hobeventhandler.py |   67 +++++++++++++++++++++++++---------
 lib/bb/ui/hob.py                    |   24 +++++-------
 3 files changed, 77 insertions(+), 32 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index 6481608..ec48a4f 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -244,6 +244,24 @@ class Configurator(gobject.GObject):
         del self.orig_config
         self.orig_config = copy.deepcopy(self.config)
 
+    def insertTempBBPath(self, bbpath, bbfiles):
+        # Create a backup of the local.conf
+        bkup = "%s~" % self.local
+        os.rename(self.local, bkup)
+
+        # read the original conf into a list
+        with open(bkup, 'r') as config:
+            config_lines = config.readlines()
+
+        if bbpath:
+            config_lines.append("BBPATH := \"${BBPATH}:%s\"\n" % bbpath)
+        if bbfiles:
+            config_lines.append("BBFILES := \"${BBFILES} %s\"\n" % bbfiles)
+
+        # Write the updated lines list object to the local.conf
+        with open(self.local, "w") as n:
+            n.write("".join(config_lines))
+
     def writeLayerConf(self):
         # If we've not added/removed new layers don't write
         if not self._isLayerConfDirty():
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index d10c858..4897bcc 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -52,16 +52,13 @@ class HobHandler(gobject.GObject):
          "error"               : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                   (gobject.TYPE_STRING,)),
-         "build-complete"      : (gobject.SIGNAL_RUN_LAST,
-                                  gobject.TYPE_NONE,
-                                  ()),
          "reload-triggered"    : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                   (gobject.TYPE_STRING,
                                    gobject.TYPE_STRING)),
     }
 
-    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES) = range(9)
+    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES, BUILD_IMAGE) = range(10)
 
     def __init__(self, taskmodel, server):
         gobject.GObject.__init__(self)
@@ -111,8 +108,21 @@ class HobHandler(gobject.GObject):
                 self.generating = False
             self.current_command = None
         elif self.current_command == self.REPARSE_FILES:
-            self.current_command = self.CFG_PATH_LAYERS
+            if self.build_queue:
+                self.current_command = self.BUILD_IMAGE
+            else:
+                self.current_command = self.CFG_PATH_LAYERS
             self.server.runCommand(["reparseFiles"])
+        elif self.current_command == self.BUILD_IMAGE:
+            self.building = "image"
+            if self.generating:
+                self.emit("data-generated")
+                self.generating = False
+            bbpath = self.server.runCommand(["getVariable", "BBPATH"])
+            bbfiles = self.server.runCommand(["getVariable", "BBFILES"])
+            self.server.runCommand(["buildTargets", self.build_queue, "build"])
+            self.build_queue = []
+            self.current_command = None
 
     def handle_event(self, event, running_build, pbar):
         if not event:
@@ -208,27 +218,48 @@ class HobHandler(gobject.GObject):
         pmake = "-j %s" % threads
         self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", pmake])
 
-    def run_build(self, tgts):
-        self.building = "image"
+    def build_image(self, image, image_path, configurator):
         targets = []
-        targets.append(tgts)
+        targets.append(image)
         if self.build_toolchain and self.build_toolchain_headers:
-            targets = ["meta-toolchain-sdk"] + targets
+            targets.append("meta-toolchain-sdk")
         elif self.build_toolchain:
-            targets = ["meta-toolchain"] + targets
-        self.server.runCommand(["buildTargets", targets, "build"])
+            targets.append("meta-toolchain")
+        self.build_queue = targets
+
+        bbpath_ok = False
+        bbpath = self.server.runCommand(["getVariable", "BBPATH"])
+        if image_path in bbpath.split(":"):
+            bbpath_ok = True
+
+        bbfiles_ok = False
+        bbfiles = self.server.runCommand(["getVariable", "BBFILES"]).split(" ")
+        for files in bbfiles:
+            import re
+            pattern = "%s/\*.bb" % image_path
+            if re.match(pattern, files):
+                bbfiles_ok = True
+
+        if not bbpath_ok:
+            nbbp = image_path
+        else:
+            nbbp = None
+
+        if not bbfiles_ok:
+            nbbf = "%s/*.bb" % image_path
+        else:
+            nbbf = None
+
+        if not bbfiles_ok or not bbpath_ok:
+            configurator.insertTempBBPath(nbbp, nbbf)
+
+        self.current_command = self.REPARSE_FILES
+        self.run_next_command()
 
     def build_packages(self, pkgs):
         self.building = "packages"
-        if 'meta-toolchain' in self.build_queue:
-            self.build_queue.remove('meta-toolchain')
-            pkgs.extend('meta-toolchain')
         self.server.runCommand(["buildTargets", pkgs, "build"])
 
-    def build_file(self, image):
-        self.building = "image"
-        self.server.runCommand(["buildFile", image, "build"])
-
     def cancel_build(self, force=False):
         if force:
             # Force the cooker to stop as quickly as possible
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 448d590..654d2df 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -65,10 +65,8 @@ class MainWindow (gtk.Window):
 
         self.build = RunningBuild()
         self.build.connect("build-failed", self.running_build_failed_cb)
-        self.build.connect("build-complete", self.handler.build_complete_cb)
         self.build.connect("build-started", self.build_started_cb)
-
-        self.handler.connect("build-complete", self.build_complete_cb)
+        self.build.connect("build-complete", self.build_complete_cb)
 
         vbox = gtk.VBox(False, 0)
         vbox.set_border_width(0)
@@ -373,16 +371,15 @@ class MainWindow (gtk.Window):
             dialog.destroy()
             if response == gtk.RESPONSE_CANCEL:
                 return
-        else:
-            # TODO: show a confirmation dialog ?
-            if not self.save_path:
-                import tempfile, datetime
-                image_name = "hob-%s-variant-%s.bb" % (rep.base_image, datetime.date.today().isoformat())
-                image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
-                bb.utils.mkdirhier(image_dir)
-                recipepath =  os.path.join(image_dir, image_name)
             else:
-                recipepath = self.save_path
+                self.handler.build_packages(rep.allpkgs.split(" "))
+        else:
+            import tempfile, datetime
+            image_name = "hob-%s-variant-%s" % (rep.base_image, datetime.date.today().isoformat())
+            image_file = "%s.bb" % (image_name)
+            image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
+            bb.utils.mkdirhier(image_dir)
+            recipepath =  os.path.join(image_dir, image_file)
 
             rep.writeRecipe(recipepath, self.model)
             # In the case where we saved the file for the purpose of building
@@ -391,9 +388,8 @@ class MainWindow (gtk.Window):
             if not self.save_path:
                 self.files_to_clean.append(recipepath)
 
-            self.handler.queue_image_recipe_path(recipepath)
+            self.handler.build_image(image_name, image_dir, self.configurator)
 
-        self.handler.build_packages(rep.allpkgs.split(" "))
         self.nb.set_current_page(1)
 
     def back_button_clicked_cb(self, button):
-- 
1.7.6



