Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qze0W-0008Rq-5C
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Sep 2011 02:22:48 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,321,1312182000"; d="scan'208";a="47755003"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.9])
	by fmsmga001.fm.intel.com with ESMTP; 02 Sep 2011 17:17:49 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Sep 2011 17:17:36 -0700
Message-Id: <ee186fa834bda64705021c94638ecea73517ede0.1315008498.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
In-Reply-To: <cover.1315008498.git.josh@linux.intel.com>
References: <cover.1315008498.git.josh@linux.intel.com>
Subject: [PATCH 1/6] hob: use both pre and post files for hob configuration
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
X-List-Received-Date: Sat, 03 Sep 2011 00:22:49 -0000

We need to set various variables *before* parse begins, the simplest way
to ensure this is to use a pre configuration file for the relevant
configuration entries.

This series adapts hob to use both pre and post files to store its
configuration. Any variables which affect initial parse are set in the pre
file and all others in the post file.

Unfortunately this requires hob related code to have even more hard-coded
data as to what is relevant but this is the simplest way to solve issues
with variables and parse order at this time.

Addresses [YOCTO #1281]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |   94 +++++++++++++++++++++++-----------
 lib/bb/ui/crumbs/hobeventhandler.py |   11 +++--
 lib/bb/ui/crumbs/hobprefs.py        |   22 ++++----
 lib/bb/ui/hob.py                    |    4 +-
 4 files changed, 83 insertions(+), 48 deletions(-)

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
index c37e917..458e056 100644
--- a/lib/bb/ui/crumbs/configurator.py
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -40,12 +40,13 @@ class Configurator(gobject.GObject):
 
     def __init__(self):
         gobject.GObject.__init__(self)
-        self.local = None
         self.bblayers = None
         self.enabled_layers = {}
         self.loaded_layers = {}
         self.config = {}
         self.orig_config = {}
+        self.preconf = None
+        self.postconf = None
 
     # NOTE: cribbed from the cooker...
     def _parse(self, f, data, include=False):
@@ -55,18 +56,16 @@ class Configurator(gobject.GObject):
             parselog.critical("Unable to parse %s: %s" % (f, exc))
             sys.exit(1)
 
-    def _loadLocalConf(self, path):
+    def _loadConf(self, path):
         def getString(var):
             return bb.data.getVar(var, data, True) or ""
 
-        self.local = path
-
         if self.orig_config:
             del self.orig_config
             self.orig_config = {}
 
         data = bb.data.init()
-        data = self._parse(self.local, data)
+        data = self._parse(path, data)
 
         # We only need to care about certain variables
         mach = getString('MACHINE')
@@ -76,6 +75,8 @@ class Configurator(gobject.GObject):
         if sdkmach and sdkmach != self.config.get('SDKMACHINE', ''):
             self.config['SDKMACHINE'] = sdkmach
         distro = getString('DISTRO')
+        if not distro:
+            distro = "defaultsetup"
         if distro and distro != self.config.get('DISTRO', ''):
             self.config['DISTRO'] = distro
         bbnum = getString('BB_NUMBER_THREADS')
@@ -109,10 +110,10 @@ class Configurator(gobject.GObject):
 
         self.orig_config = copy.deepcopy(self.config)
 
-    def setLocalConfVar(self, var, val):
+    def setConfVar(self, var, val):
         self.config[var] = val
 
-    def getLocalConfVar(self, var):
+    def getConfVar(self, var):
         if var in self.config:
             return self.config[var]
         else:
@@ -135,9 +136,17 @@ class Configurator(gobject.GObject):
         self.emit("layers-loaded")
 
     def _addConfigFile(self, path):
+        conffiles = ["local.conf", "hob-pre.conf", "hob-post.conf"]
         pref, sep, filename = path.rpartition("/")
-        if filename == "local.conf" or filename == "hob.local.conf":
-            self._loadLocalConf(path)
+
+        if filename == "hob-pre.conf":
+            self.preconf = path
+
+        if filename == "hob-post.conf":
+            self.postconf = path
+
+        if filename in conffiles:
+            self._loadConf(path)
         elif filename == "bblayers.conf":
             self._loadLayerConf(path)
 
@@ -220,22 +229,8 @@ class Configurator(gobject.GObject):
         with open(conffile, "w") as new:
             new.write("".join(contents))
 
-    def writeLocalConf(self):
-        # Dictionary containing only new or modified variables
-        changed_values = {}
-        for var in self.config:
-            val = self.config[var]
-            if self.orig_config.get(var, None) != val:
-                changed_values[var] = val
-
-        if not len(changed_values):
-            return
-
-        # read the original conf into a list
-        with open(self.local, 'r') as config:
-            config_lines = config.readlines()
-
-        new_config_lines = ["\n"]
+    def updateConf(self, orig_lines, changed_values):
+        new_config_lines = []
         for var in changed_values:
             # Convenience function for re.subn(). If the pattern matches
             # return a string which contains an assignment using the same
@@ -254,10 +249,10 @@ class Configurator(gobject.GObject):
             # Iterate over the local.conf lines and if they are a match
             # for the pattern comment out the line and append a new line
             # with the new VAR op "value" entry
-            for line in config_lines:
+            for line in orig_lines:
                 new_line, replacements = p.subn(replace_val, line)
                 if replacements:
-                    config_lines[cnt] = "#%s" % line
+                    orig_lines[cnt] = "#%s" % line
                     new_config_lines.append(new_line)
                     replaced = True
                 cnt = cnt + 1
@@ -266,16 +261,53 @@ class Configurator(gobject.GObject):
                 new_config_lines.append("%s = \"%s\"\n" % (var, changed_values[var]))
 
         # Add the modified variables
-        config_lines.extend(new_config_lines)
+        orig_lines.extend(new_config_lines)
+        return orig_lines
+
+    def writeConf(self):
+        pre_vars = ["MACHINE", "SDKMACHINE", "DISTRO",
+                    "INCOMPATIBLE_LICENSE"]
+        post_vars = ["BB_NUMBER_THREADS", "PARALLEL_MAKE", "PACKAGE_CLASSES",
+                     "IMAGE_FSTYPES", "HOB_BUILD_TOOLCHAIN",
+                     "HOB_BUILD_TOOLCHAIN_HEADERS"]
+        pre_values = {}
+        post_values = {}
+        changed_values = {}
+        pre_lines = None
+        post_lines = None
 
-        self.writeConfFile(self.local, config_lines)
+        for var in self.config:
+            val = self.config[var]
+            if self.orig_config.get(var, None) != val:
+                changed_values[var] = val
+
+        if not len(changed_values):
+            return
+
+        for var in changed_values:
+            if var in pre_vars:
+                pre_values[var] = changed_values[var]
+            elif var in post_vars:
+                post_values[var] = changed_values[var]
+
+        with open(self.preconf, 'r') as pre:
+            pre_lines = pre.readlines()
+        pre_lines = self.updateConf(pre_lines, pre_values)
+        if len(pre_lines):
+            self.writeConfFile(self.preconf, pre_lines)
+
+        with open(self.postconf, 'r') as post:
+            post_lines = post.readlines()
+        post_lines = self.updateConf(post_lines, post_values)
+        if len(post_lines):
+            self.writeConfFile(self.postconf, post_lines)
 
         del self.orig_config
         self.orig_config = copy.deepcopy(self.config)
 
     def insertTempBBPath(self, bbpath, bbfiles):
         # read the original conf into a list
-        with open(self.local, 'r') as config:
+        with open(self.postconf, 'r') as config:
             config_lines = config.readlines()
 
         if bbpath:
@@ -283,7 +315,7 @@ class Configurator(gobject.GObject):
         if bbfiles:
             config_lines.append("BBFILES := \"${BBFILES} %s\"\n" % bbfiles)
 
-        self.writeConfFile(self.local, config_lines)
+        self.writeConfFile(self.postconf, config_lines)
 
     def writeLayerConf(self):
         # If we've not added/removed new layers don't write
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index fca4401..66dffac 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -65,7 +65,7 @@ class HobHandler(gobject.GObject):
                                    gobject.TYPE_STRING,)),
     }
 
-    (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES, BUILD_IMAGE) = range(10)
+    (CFG_PATH_LOCAL, CFG_PATH_PRE, CFG_PATH_POST, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES, BUILD_IMAGE) = range(11)
 
     def __init__(self, taskmodel, server):
         gobject.GObject.__init__(self)
@@ -90,9 +90,12 @@ class HobHandler(gobject.GObject):
             self.generating = True
 
         if self.current_command == self.CFG_PATH_LOCAL:
-            self.current_command = self.CFG_PATH_HOB
-            self.server.runCommand(["findConfigFilePath", "hob.local.conf"])
-        elif self.current_command == self.CFG_PATH_HOB:
+            self.current_command = self.CFG_PATH_PRE
+            self.server.runCommand(["findConfigFilePath", "hob-pre.conf"])
+        elif self.current_command == self.CFG_PATH_PRE:
+            self.current_command = self.CFG_PATH_POST
+            self.server.runCommand(["findConfigFilePath", "hob-post.conf"])
+        elif self.current_command == self.CFG_PATH_POST:
             self.current_command = self.CFG_PATH_LAYERS
             self.server.runCommand(["findConfigFilePath", "bblayers.conf"])
         elif self.current_command == self.CFG_PATH_LAYERS:
diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 3859b29..14d6bc7 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -38,13 +38,13 @@ class HobPrefs(gtk.Dialog):
         else:
             self.selected_image_types = handler.remove_image_output_type(ot)
 
-        self.configurator.setLocalConfVar('IMAGE_FSTYPES', "%s" % " ".join(self.selected_image_types).lstrip(" "))
+        self.configurator.setConfVar('IMAGE_FSTYPES', "%s" % " ".join(self.selected_image_types).lstrip(" "))
 
     def sdk_machine_combo_changed_cb(self, combo, handler):
         sdk_mach = combo.get_active_text()
 	if sdk_mach != self.curr_sdk_mach:
             self.curr_sdk_mach = sdk_mach
-            self.configurator.setLocalConfVar('SDKMACHINE', sdk_mach)
+            self.configurator.setConfVar('SDKMACHINE', sdk_mach)
             handler.set_sdk_machine(sdk_mach)
 
     def update_sdk_machines(self, handler, sdk_machines):
@@ -67,7 +67,7 @@ class HobPrefs(gtk.Dialog):
         distro = combo.get_active_text()
 	if distro != self.curr_distro:
             self.curr_distro = distro
-            self.configurator.setLocalConfVar('DISTRO', distro)
+            self.configurator.setConfVar('DISTRO', distro)
             handler.set_distro(distro)
             self.reload_required = True
 
@@ -91,7 +91,7 @@ class HobPrefs(gtk.Dialog):
         package_format = combo.get_active_text()
         if package_format != self.curr_package_format:
             self.curr_package_format = package_format
-            self.configurator.setLocalConfVar('PACKAGE_CLASSES', 'package_%s' % package_format)
+            self.configurator.setConfVar('PACKAGE_CLASSES', 'package_%s' % package_format)
             handler.set_package_format(package_format)
             self.reload_required = True
 
@@ -113,7 +113,7 @@ class HobPrefs(gtk.Dialog):
     
     def include_gplv3_cb(self, toggle):
         excluded = toggle.get_active()
-        orig_incompatible = self.configurator.getLocalConfVar('INCOMPATIBLE_LICENSE')
+        orig_incompatible = self.configurator.getConfVar('INCOMPATIBLE_LICENSE')
         new_incompatible = ""
         if excluded:
             if not orig_incompatible:
@@ -125,18 +125,18 @@ class HobPrefs(gtk.Dialog):
 
         if new_incompatible != orig_incompatible:
             self.handler.set_incompatible_license(new_incompatible)
-            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', new_incompatible)
+            self.configurator.setConfVar('INCOMPATIBLE_LICENSE', new_incompatible)
             self.reload_required = True
 
     def change_bb_threads_cb(self, spinner):
         val = spinner.get_value_as_int()
         self.handler.set_bbthreads(val)
-        self.configurator.setLocalConfVar('BB_NUMBER_THREADS', val)
+        self.configurator.setConfVar('BB_NUMBER_THREADS', val)
 
     def change_make_threads_cb(self, spinner):
         val = spinner.get_value_as_int()
         self.handler.set_pmake(val)
-        self.configurator.setLocalConfVar('PARALLEL_MAKE', "-j %s" % val)
+        self.configurator.setConfVar('PARALLEL_MAKE', "-j %s" % val)
 
     def toggle_toolchain_cb(self, check):
         enabled = check.get_active()
@@ -144,7 +144,7 @@ class HobPrefs(gtk.Dialog):
         if enabled:
             toolchain = '1'
         self.handler.toggle_toolchain(enabled)
-        self.configurator.setLocalConfVar('HOB_BUILD_TOOLCHAIN', toolchain)
+        self.configurator.setConfVar('HOB_BUILD_TOOLCHAIN', toolchain)
 
     def toggle_headers_cb(self, check):
         enabled = check.get_active()
@@ -152,13 +152,13 @@ class HobPrefs(gtk.Dialog):
         if enabled:
             headers = '1'
         self.handler.toggle_toolchain_headers(enabled)
-        self.configurator.setLocalConfVar('HOB_BUILD_TOOLCHAIN_HEADERS', headers)
+        self.configurator.setConfVar('HOB_BUILD_TOOLCHAIN_HEADERS', headers)
 
     def set_parent_window(self, parent):
         self.set_transient_for(parent)
 
     def write_changes(self):
-        self.configurator.writeLocalConf()
+        self.configurator.writeConf()
 
     def prefs_response_cb(self, dialog, response):
         if self.reload_required:
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index c2acada..c1302e5 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -192,8 +192,8 @@ class MainWindow (gtk.Window):
             self.curr_mach = mach
             # Flush this straight to the file as MACHINE is changed
             # independently of other 'Preferences'
-            self.configurator.setLocalConfVar('MACHINE', mach)
-            self.configurator.writeLocalConf()
+            self.configurator.setConfVar('MACHINE', mach)
+            self.configurator.writeConf()
             handler.set_machine(mach)
             handler.reload_data()
 
-- 
1.7.6



