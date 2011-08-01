Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxGA-0001pg-9m
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:38 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344111"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:50 -0700
Message-Id: <1009ca570a750a00b0e60afcc30ead070c7b310a.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 8/8] hob: remove temporary directory on program shutdown
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:38 -0000

Move temp directory handling into the HobEventHandler and clean up the
temporary files on program close.

Fixes [YOCTO #1307]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   26 +++++++++++++++++++++-----
 lib/bb/ui/hob.py                    |   15 +++++++--------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 0b5b318..e8265f1 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -20,6 +20,8 @@
 
 import gobject
 import logging
+import tempfile
+import datetime
 
 progress_total = 0
 
@@ -75,6 +77,7 @@ class HobHandler(gobject.GObject):
         self.generating = False
         self.build_queue = []
         self.current_phase = None
+        self.image_dir = None
 
         self.model = taskmodel
         self.server = server
@@ -237,7 +240,7 @@ class HobHandler(gobject.GObject):
         pmake = "-j %s" % threads
         self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", pmake])
 
-    def build_image(self, image, image_path, configurator):
+    def build_image(self, image, configurator):
         targets = []
         targets.append(image)
         if self.build_toolchain and self.build_toolchain_headers:
@@ -248,24 +251,24 @@ class HobHandler(gobject.GObject):
 
         bbpath_ok = False
         bbpath = self.server.runCommand(["getVariable", "BBPATH"])
-        if image_path in bbpath.split(":"):
+        if self.image_dir in bbpath.split(":"):
             bbpath_ok = True
 
         bbfiles_ok = False
         bbfiles = self.server.runCommand(["getVariable", "BBFILES"]).split(" ")
         for files in bbfiles:
             import re
-            pattern = "%s/\*.bb" % image_path
+            pattern = "%s/\*.bb" % self.image_dir
             if re.match(pattern, files):
                 bbfiles_ok = True
 
         if not bbpath_ok:
-            nbbp = image_path
+            nbbp = self.image_dir
         else:
             nbbp = None
 
         if not bbfiles_ok:
-            nbbf = "%s/*.bb" % image_path
+            nbbf = "%s/*.bb" % self.image_dir
         else:
             nbbf = None
 
@@ -319,3 +322,16 @@ class HobHandler(gobject.GObject):
 
     def get_image_deploy_dir(self):
         return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
+
+    def make_temp_dir(self):
+        self.image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
+        bb.utils.mkdirhier(self.image_dir)
+
+    def remove_temp_dir(self):
+        bb.utils.remove(self.image_dir, True)
+
+    def get_temp_recipe_path(self, name):
+        timestamp = datetime.date.today().isoformat()
+        image_file = "hob-%s-variant-%s.bb" % (name, timestamp)
+        recipepath =  os.path.join(self.image_dir, image_file)
+        return recipepath
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 919c06e..b5c2342 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -114,6 +114,8 @@ class MainWindow (gtk.Window):
         # whilst the busy cursor is set
         self.set_busy_cursor(False)
 
+        self.handler.remove_temp_dir()
+
         gtk.main_quit()
 
     """
@@ -418,13 +420,10 @@ class MainWindow (gtk.Window):
                 rep.base_image = "empty"
 
         if build_image:
-            import tempfile, datetime
-
-            image_name = "hob-%s-variant-%s" % (rep.base_image, datetime.date.today().isoformat())
-            image_file = "%s.bb" % (image_name)
-            image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
-            bb.utils.mkdirhier(image_dir)
-            recipepath =  os.path.join(image_dir, image_file)
+            self.handler.make_temp_dir()
+            recipepath =  self.handler.get_temp_recipe_path(rep.base_image)
+            image_name = recipepath.rstrip(".bb")
+            path, sep, image_name = image_name.rpartition("/")
 
             rep.writeRecipe(recipepath, self.model)
             # In the case where we saved the file for the purpose of building
@@ -433,7 +432,7 @@ class MainWindow (gtk.Window):
             if not self.save_path:
                 self.files_to_clean.append(recipepath)
 
-            self.handler.build_image(image_name, image_dir, self.configurator)
+            self.handler.build_image(image_name, self.configurator)
         else:
             self.handler.build_packages(rep.allpkgs.split(" "))
 
-- 
1.7.6



