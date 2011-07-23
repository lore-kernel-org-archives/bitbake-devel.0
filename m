Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkUIa-0005rY-N3
	for bitbake-devel@lists.openembedded.org;
	Sat, 23 Jul 2011 06:58:49 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 21:54:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,251,1309762800"; d="scan'208";a="31029064"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.127])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 21:54:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 21:54:27 -0700
Message-Id: <8e741f42b1209f6b02701b62e1c05961dfc8e9fd.1311396521.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
In-Reply-To: <cover.1311396520.git.josh@linux.intel.com>
References: <cover.1311396520.git.josh@linux.intel.com>
Subject: [PATCH 8/8] hob: rework image output type setting
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
X-List-Received-Date: Sat, 23 Jul 2011 04:58:49 -0000

The preferences UI to set the image output type only supported setting a
single value whereas it's common practice, particularly for those making
use of the ADT, to set multiple values. This is also the default in Poky.

This reworked preferences UI dynamically generates check boxes for each
available image type and sets an appropriate string representing all image
types when checkboxes are toggled.

Includes fixes for [YOCTO #1273]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |    6 +++-
 lib/bb/ui/crumbs/hobeventhandler.py |   21 +++++++++++++-
 lib/bb/ui/crumbs/hobprefs.py        |   50 +++++++++++++++++++++--------------
 lib/bb/ui/hob.py                    |    5 ++-
 4 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index e7c524a..6481608 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -90,12 +90,14 @@ class Configurator(gobject.GObject):
         pclass = getString('PACKAGE_CLASSES')
         if pclass and pclass != self.config.get('PACKAGE_CLASSES', ''):
             self.config['PACKAGE_CLASSES'] = pclass
+        fstypes = getString('IMAGE_FSTYPES')
+        if fstypes and fstypes != self.config.get('IMAGE_FSTYPES', ''):
+            self.config['IMAGE_FSTYPES'] = fstypes
 
         self.orig_config = copy.deepcopy(self.config)
 
     def setLocalConfVar(self, var, val):
-        if var in self.config:
-            self.config[var] = val
+        self.config[var] = val
 
     def _loadLayerConf(self, path):
         self.bblayers = path
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index fa79e0c..2f45350 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -74,6 +74,8 @@ class HobHandler(gobject.GObject):
         self.model = taskmodel
         self.server = server
 
+        self.image_output_types = self.server.runCommand(["getVariable", "IMAGE_FSTYPES"]).split(" ")
+
         self.command_map = {
             "findConfigFilePathLocal" : ("findConfigFilePath", ["hob.local.conf"], "findConfigFilePathHobLocal"),
             "findConfigFilePathHobLocal" : ("findConfigFilePath", ["bblayers.conf"], "findConfigFilePathLayers"),
@@ -258,8 +260,23 @@ class HobHandler(gobject.GObject):
             self.building = None
             self.emit("build-complete")
 
-    def set_image_output_type(self, output_type):
-        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", output_type])
+    def set_fstypes(self, fstypes):
+        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", fstypes])
+
+    def add_image_output_type(self, output_type):
+        if output_type not in self.image_output_types:
+            self.image_output_types.append(output_type)
+            fstypes = " ".join(self.image_output_types)
+            self.set_fstypes(fstypes)
+        return fstypes
+
+    def remove_image_output_type(self, output_type):
+        if output_type in self.image_output_types:
+            ind = self.image_output_types.index(output_type)
+            self.image_output_types.pop(ind)
+            fstypes = " ".join(self.image_output_types)
+            self.set_fstypes(fstypes)
+        return fstypes
 
     def get_image_deploy_dir(self):
         return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index ab2f0d8..1e6c78b 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -30,11 +30,15 @@ class HobPrefs(gtk.Dialog):
         if model:
             model.clear()
 
-    def output_type_changed_cb(self, combo, handler):
-        ot = combo.get_active_text()
-        if ot != self.curr_output_type:
-            self.curr_output_type = ot
-            handler.set_image_output_type(ot)
+    def output_type_toggled_cb(self, check, handler):
+        ot = check.get_label()
+        enabled = check.get_active()
+        if enabled:
+            self.selected_image_types = handler.add_image_output_type(ot)
+        else:
+            self.selected_image_types = handler.remove_image_output_type(ot)
+
+        self.configurator.setLocalConfVar('IMAGE_FSTYPES', "%s" % self.selected_image_types)
 
     def sdk_machine_combo_changed_cb(self, combo, handler):
         sdk_mach = combo.get_active_text()
@@ -144,7 +148,7 @@ class HobPrefs(gtk.Dialog):
             glib.idle_add(self.handler.reload_data)
 
     def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
-                 cpu_cnt, pmake, bbthread, image_types):
+                 cpu_cnt, pmake, bbthread, selected_image_types, all_image_types):
         """
         """
         gtk.Dialog.__init__(self, "Preferences", None,
@@ -162,7 +166,6 @@ class HobPrefs(gtk.Dialog):
         self.curr_sdk_mach = curr_sdk_mach
         self.curr_distro = curr_distro
         self.curr_package_format = pclass
-        self.curr_output_type = None
         self.cpu_cnt = cpu_cnt
         self.pmake = pmake
         self.bbthread = bbthread
@@ -170,6 +173,7 @@ class HobPrefs(gtk.Dialog):
         self.distro_handler_id = None
         self.sdk_machine_handler_id = None
         self.package_handler_id = None
+        self.selected_image_types = selected_image_types.split(" ")
 
         left = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
         right = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
@@ -214,19 +218,25 @@ class HobPrefs(gtk.Dialog):
  of the root filesystem and also dictates the package manager used in your image""")
         self.package_combo.show()
         hbox.pack_start(self.package_combo, expand=False, fill=False, padding=6)
-        # Image output type selector
-        label = gtk.Label("Image output type:")
-        label.show()
-        hbox.pack_start(label, expand=False, fill=False, padding=6)
-        output_combo = gtk.combo_box_new_text()
-        if image_types:
-            for it in image_types.split(" "):
-                output_combo.append_text(it)
-            output_combo.connect("changed", self.output_type_changed_cb, handler)
-        else:
-            output_combo.set_sensitive(False)
-        output_combo.show()
-        hbox.pack_start(output_combo)
+        if all_image_types:
+            # Image output type selector
+            label = gtk.Label("Image output types:")
+            label.show()
+            hbox.pack_start(label, expand=False, fill=False, padding=6)
+            chk_cnt = 3
+            for it in all_image_types.split(" "):
+                chk_cnt = chk_cnt + 1
+                if chk_cnt % 6 == 0:
+                    hbox = gtk.HBox(False, 12)
+                    hbox.show()
+                    pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+                chk = gtk.CheckButton(it)
+                if it in self.selected_image_types:
+                    chk.set_active(True)
+                chk.set_tooltip_text("Build an %s image" % it)
+                chk.connect("toggled", self.output_type_toggled_cb, handler)
+                chk.show()
+                hbox.pack_start(chk, expand=False, fill=False, padding=3)
         # BitBake
         label = gtk.Label()
         label.set_markup("<b>BitBake</b>")
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 8e3e7bc..09a63c6 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -900,7 +900,8 @@ def main (server, eventHandler):
         # up to and including the space
         pmake = int(pmake.lstrip("-j "))
 
-    image_types = server.runCommand(["getVariable", "IMAGE_TYPES"])
+    selected_image_types = server.runCommand(["getVariable", "IMAGE_FSTYPES"])
+    all_image_types = server.runCommand(["getVariable", "IMAGE_TYPES"])
 
     pclasses = server.runCommand(["getVariable", "PACKAGE_CLASSES"]).split(" ")
     # NOTE: we're only supporting one value for PACKAGE_CLASSES being set
@@ -909,7 +910,7 @@ def main (server, eventHandler):
     pkg, sep, pclass = pclasses[0].rpartition("_")
 
     prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
-                     pmake, bbthread, image_types)
+                     pmake, bbthread, selected_image_types, all_image_types)
     layers = LayerEditor(configurator, None)
     window = MainWindow(taskmodel, handler, configurator, prefs, layers, mach)
     prefs.set_parent_window(window)
-- 
1.7.6



