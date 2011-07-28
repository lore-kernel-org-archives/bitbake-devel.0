Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QmV6R-0001Ja-Ho
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Jul 2011 20:14:36 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,283,1309762800"; d="scan'208";a="33431823"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.108])
	by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2011 11:10:15 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Jul 2011 11:10:03 -0700
Message-Id: <c9dd2592434338bdddb3cc6f42e760c86fa9e6bb.1311876523.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311876523.git.josh@linux.intel.com>
References: <cover.1311876523.git.josh@linux.intel.com>
In-Reply-To: <cover.1311876523.git.josh@linux.intel.com>
References: <cover.1311876523.git.josh@linux.intel.com>
Subject: [PATCH 2/2] hob: fix save/restore of toolchain preferences
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
X-List-Received-Date: Thu, 28 Jul 2011 18:14:36 -0000

Add some (namespaced) custom variables to the configuration file for sake
of this UI.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py |    8 ++++++++
 lib/bb/ui/crumbs/hobprefs.py     |   14 +++++++++++++-
 lib/bb/ui/hob.py                 |    5 ++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index 587a6ff..e558c95 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -99,6 +99,14 @@ class Configurator(gobject.GObject):
         else:
             self.config['INCOMPATIBLE_LICENSE'] = ""
 
+        # Non-standard, namespaces, variables for GUI preferences
+        toolchain = getString('HOB_BUILD_TOOLCHAIN')
+        if toolchain and toolchain != self.config.get('HOB_BUILD_TOOLCHAIN', ''):
+            self.config['HOB_BUILD_TOOLCHAIN'] = toolchain
+        header = getString('HOB_BUILD_TOOLCHAIN_HEADERS')
+        if header and header != self.config.get('HOB_BUILD_TOOLCHAIN_HEADERS', ''):
+            self.config['HOB_BUILD_TOOLCHAIN_HEADERS'] = header
+
         self.orig_config = copy.deepcopy(self.config)
 
     def setLocalConfVar(self, var, val):
diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index be094e7..8ebfba2 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -140,11 +140,19 @@ class HobPrefs(gtk.Dialog):
 
     def toggle_toolchain_cb(self, check):
         enabled = check.get_active()
+        toolchain = '0'
+        if enabled:
+            toolchain = '1'
         self.handler.toggle_toolchain(enabled)
+        self.configurator.setLocalConfVar('HOB_BUILD_TOOLCHAIN', toolchain)
 
     def toggle_headers_cb(self, check):
         enabled = check.get_active()
+        headers = '0'
+        if enabled:
+            headers = '1'
         self.handler.toggle_toolchain_headers(enabled)
+        self.configurator.setLocalConfVar('HOB_BUILD_TOOLCHAIN_HEADERS', headers)
 
     def set_parent_window(self, parent):
         self.set_transient_for(parent)
@@ -158,7 +166,7 @@ class HobPrefs(gtk.Dialog):
 
     def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
                  cpu_cnt, pmake, bbthread, selected_image_types, all_image_types,
-                 gplv3disabled):
+                 gplv3disabled, build_toolchain, build_toolchain_headers):
         """
         """
         gtk.Dialog.__init__(self, "Preferences", None,
@@ -181,6 +189,8 @@ class HobPrefs(gtk.Dialog):
         self.bbthread = bbthread
         self.selected_image_types = selected_image_types.split(" ")
         self.gplv3disabled = gplv3disabled
+        self.build_toolchain = build_toolchain
+        self.build_toolchain_headers = build_toolchain_headers
 
         self.reload_required = False
         self.distro_handler_id = None
@@ -304,6 +314,7 @@ class HobPrefs(gtk.Dialog):
         pbox.pack_start(hbox, expand=False, fill=False, padding=6)
         toolcheck = gtk.CheckButton("Build external development toolchain with image")
         toolcheck.show()
+        toolcheck.set_active(self.build_toolchain)
         toolcheck.connect("toggled", self.toggle_toolchain_cb)
         hbox.pack_start(toolcheck, expand=False, fill=False, padding=6)
         hbox = gtk.HBox(False, 12)
@@ -318,6 +329,7 @@ class HobPrefs(gtk.Dialog):
         hbox.pack_start(self.sdk_machine_combo, expand=False, fill=False, padding=6)
         headerscheck = gtk.CheckButton("Include development headers with toolchain")
         headerscheck.show()
+        headerscheck.set_active(self.build_toolchain_headers)
         headerscheck.connect("toggled", self.toggle_headers_cb)
         hbox.pack_start(headerscheck, expand=False, fill=False, padding=6)
         self.connect("response", self.prefs_response_cb)
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index a5a2960..305559f 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -937,9 +937,12 @@ def main (server, eventHandler):
     if incompatible and incompatible.lower().find("gplv3"):
         gplv3disabled = True
 
+    build_toolchain = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN"]))
+    build_headers = bool(server.runCommand(["getVariable", "HOB_BUILD_TOOLCHAIN_HEADERS"]))
+
     prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
                      pmake, bbthread, selected_image_types, all_image_types,
-                     gplv3disabled)
+                     gplv3disabled, build_toolchain, build_headers)
     layers = LayerEditor(configurator, None)
     window = MainWindow(taskmodel, handler, configurator, prefs, layers, mach)
     prefs.set_parent_window(window)
-- 
1.7.6



