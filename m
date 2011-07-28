Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QmV6P-0001Ja-D5
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Jul 2011 20:14:33 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,283,1309762800"; d="scan'208";a="33431822"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.108])
	by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Jul 2011 11:10:02 -0700
Message-Id: <68b992922bc7148d657a1c706c6acc67812a87c0.1311876523.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311876523.git.josh@linux.intel.com>
References: <cover.1311876523.git.josh@linux.intel.com>
In-Reply-To: <cover.1311876523.git.josh@linux.intel.com>
References: <cover.1311876523.git.josh@linux.intel.com>
Subject: [PATCH 1/2] hob: more reliable disabling of GPLv3 packages
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
X-List-Received-Date: Thu, 28 Jul 2011 18:14:33 -0000

1. reflect GPLv3's presence in INCOMPATIBLE_LICENSE value in the UI

The hob UI currently only supports GPLv3 as a value for
INCOMPATIBLE_LICENSE but doesn't properly reflect whether the value is
already set. This patch rectifies this.

2. don't stomp over other INCOMPATIBLE_LICENSE values when disabling GPLv3

In case the user has other values set for INCOMPATIBLE_LICENSE we don't
want to overwrite the value, we want to modify it.

Fixes [#1286]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |   17 ++++++++++++++---
 lib/bb/ui/crumbs/hobeventhandler.py |   10 ++--------
 lib/bb/ui/crumbs/hobprefs.py        |   24 ++++++++++++++++++------
 lib/bb/ui/hob.py                    |    8 +++++++-
 4 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index ec48a4f..587a6ff 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -84,9 +84,6 @@ class Configurator(gobject.GObject):
         pmake = getString('PARALLEL_MAKE')
         if pmake and pmake != self.config.get('PARALLEL_MAKE', ''):
             self.config['PARALLEL_MAKE'] = pmake
-        incompat = getString('INCOMPATIBLE_LICENSE')
-        if incompat and incompat != self.config.get('INCOMPATIBLE_LICENSE', ''):
-            self.config['INCOMPATIBLE_LICENSE'] = incompat
         pclass = getString('PACKAGE_CLASSES')
         if pclass and pclass != self.config.get('PACKAGE_CLASSES', ''):
             self.config['PACKAGE_CLASSES'] = pclass
@@ -94,11 +91,25 @@ class Configurator(gobject.GObject):
         if fstypes and fstypes != self.config.get('IMAGE_FSTYPES', ''):
             self.config['IMAGE_FSTYPES'] = fstypes
 
+        # Values which aren't always set in the conf must be explicitly
+        # loaded as empty values for save to work
+        incompat = getString('INCOMPATIBLE_LICENSE')
+        if incompat and incompat != self.config.get('INCOMPATIBLE_LICENSE', ''):
+            self.config['INCOMPATIBLE_LICENSE'] = incompat
+        else:
+            self.config['INCOMPATIBLE_LICENSE'] = ""
+
         self.orig_config = copy.deepcopy(self.config)
 
     def setLocalConfVar(self, var, val):
         self.config[var] = val
 
+    def getLocalConfVar(self, var):
+        if var in self.config:
+            return self.config[var]
+        else:
+            return ""
+
     def _loadLayerConf(self, path):
         self.bblayers = path
         self.enabled_layers = {}
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 4897bcc..c6ac7d5 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -65,7 +65,6 @@ class HobHandler(gobject.GObject):
 
         self.current_command = None
         self.building = None
-        self.gplv3_excluded = False
         self.build_toolchain = False
         self.build_toolchain_headers = False
         self.generating = False
@@ -269,13 +268,8 @@ class HobHandler(gobject.GObject):
             # leave the workdir in a usable state
             self.server.runCommand(["stateShutdown"])
 
-    def toggle_gplv3(self, excluded):
-        if self.gplv3_excluded != excluded:
-            self.gplv3_excluded = excluded
-            if excluded:
-                self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", "GPLv3"])
-            else:
-                self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", ""])
+    def set_incompatible_license(self, incompatible):
+        self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", incompatible])
 
     def toggle_toolchain(self, enabled):
         if self.build_toolchain != enabled:
diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 0f9bda2..be094e7 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -113,12 +113,20 @@ class HobPrefs(gtk.Dialog):
     
     def include_gplv3_cb(self, toggle):
         excluded = toggle.get_active()
-        self.handler.toggle_gplv3(excluded)
+        orig_incompatible = self.configurator.getLocalConfVar('INCOMPATIBLE_LICENSE')
+        new_incompatible = ""
         if excluded:
-            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', 'GPLv3')
+            if not orig_incompatible:
+                new_incompatible = "GPLv3"
+            elif not orig_incompatible.find('GPLv3'):
+                new_incompatible = "%s GPLv3" % orig_incompatible
         else:
-            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', '')
-        self.reload_required = True
+            new_incompatible = orig_incompatible.replace('GPLv3', '')
+
+        if new_incompatible != orig_incompatible:
+            self.handler.set_incompatible_license(new_incompatible)
+            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', new_incompatible)
+            self.reload_required = True
 
     def change_bb_threads_cb(self, spinner):
         val = spinner.get_value_as_int()
@@ -149,7 +157,8 @@ class HobPrefs(gtk.Dialog):
             glib.idle_add(self.handler.reload_data)
 
     def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
-                 cpu_cnt, pmake, bbthread, selected_image_types, all_image_types):
+                 cpu_cnt, pmake, bbthread, selected_image_types, all_image_types,
+                 gplv3disabled):
         """
         """
         gtk.Dialog.__init__(self, "Preferences", None,
@@ -170,11 +179,13 @@ class HobPrefs(gtk.Dialog):
         self.cpu_cnt = cpu_cnt
         self.pmake = pmake
         self.bbthread = bbthread
+        self.selected_image_types = selected_image_types.split(" ")
+        self.gplv3disabled = gplv3disabled
+
         self.reload_required = False
         self.distro_handler_id = None
         self.sdk_machine_handler_id = None
         self.package_handler_id = None
-        self.selected_image_types = selected_image_types.split(" ")
 
         left = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
         right = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
@@ -205,6 +216,7 @@ class HobPrefs(gtk.Dialog):
         check = gtk.CheckButton("Exclude GPLv3 packages")
         check.set_tooltip_text("Check this box to prevent GPLv3 packages from being included in your image")
         check.show()
+        check.set_active(self.gplv3disabled)
         check.connect("toggled", self.include_gplv3_cb)
         hbox.pack_start(check, expand=False, fill=False, padding=6)
         hbox = gtk.HBox(False, 12)
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 90d5c5a..a5a2960 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -932,8 +932,14 @@ def main (server, eventHandler):
     # PACKAGE_CLASSES and that's the package manager used for the rootfs
     pkg, sep, pclass = pclasses[0].rpartition("_")
 
+    incompatible = server.runCommand(["getVariable", "INCOMPATIBLE_LICENSE"])
+    gplv3disabled = False
+    if incompatible and incompatible.lower().find("gplv3"):
+        gplv3disabled = True
+
     prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
-                     pmake, bbthread, selected_image_types, all_image_types)
+                     pmake, bbthread, selected_image_types, all_image_types,
+                     gplv3disabled)
     layers = LayerEditor(configurator, None)
     window = MainWindow(taskmodel, handler, configurator, prefs, layers, mach)
     prefs.set_parent_window(window)
-- 
1.7.6



