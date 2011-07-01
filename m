Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtT-0007rE-CS
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:08:02 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321729"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:56 -0700
Message-Id: <613e3b4213fa2117604fdfc719a9b36aaedeae0d.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
X-Mailman-Approved-At: Sat, 02 Jul 2011 01:11:43 +0200
Subject: [PATCH 10/10] hob: re-designed interaction and implementation
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
X-List-Received-Date: Fri, 01 Jul 2011 06:08:02 -0000

Highlights include:

* Atempted GNOME HIG compliance
* Simplified UI and interaction model
* Sorting and type to find in tree views
* Preferences dialog to modify local settings
* Dialog to add and remove layers
* Search in packages list
* Save/Load image recipes

The build model has been changed, hob will attempt to build all dependent
packages of an image and then use the buildFile server method to build the
created image.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/configurator.py    |  278 +++++++++++
 lib/bb/ui/crumbs/hig.py             |   61 +++
 lib/bb/ui/crumbs/hobeventhandler.py |  218 +++++++--
 lib/bb/ui/crumbs/hobprefs.py        |  293 +++++++++++
 lib/bb/ui/crumbs/layereditor.py     |  136 +++++
 lib/bb/ui/crumbs/runningbuild.py    |   12 +-
 lib/bb/ui/crumbs/tasklistmodel.py   |  306 +++++++++---
 lib/bb/ui/hob.py                    |  924 +++++++++++++++++++++++-----------
 8 files changed, 1807 insertions(+), 421 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/configurator.py
 create mode 100644 lib/bb/ui/crumbs/hig.py
 create mode 100644 lib/bb/ui/crumbs/hobprefs.py
 create mode 100644 lib/bb/ui/crumbs/layereditor.py

diff --git a/lib/bb/ui/crumbs/configurator.py b/lib/bb/ui/crumbs/configurator.py
new file mode 100644
index 0000000..b694143
--- /dev/null
+++ b/lib/bb/ui/crumbs/configurator.py
@@ -0,0 +1,278 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Joshua Lock <josh@linux.intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gobject
+import copy
+import re, os
+from bb import data
+
+class Configurator(gobject.GObject):
+
+    """
+    A GObject to handle writing modified configuration values back
+    to conf files.
+    """
+    __gsignals__ = {
+        "layers-loaded"  : (gobject.SIGNAL_RUN_LAST,
+                           gobject.TYPE_NONE,
+                           ()),
+        "layers-changed" : (gobject.SIGNAL_RUN_LAST,
+                            gobject.TYPE_NONE,
+                            ())
+    }
+
+    def __init__(self):
+        gobject.GObject.__init__(self)
+        self.local = None
+        self.bblayers = None
+        self.enabled_layers = {}
+        self.loaded_layers = {}
+        self.config = {}
+        self.orig_config = {}
+
+    # NOTE: cribbed from the cooker...
+    def _parse(self, f, data, include=False):
+        try:
+            return bb.parse.handle(f, data, include)
+        except (IOError, bb.parse.ParseError) as exc:
+            parselog.critical("Unable to parse %s: %s" % (f, exc))
+            sys.exit(1)
+
+    def _loadLocalConf(self, path):
+        def getString(var):
+            return bb.data.getVar(var, data, True) or ""
+
+        self.local = path
+
+        if self.orig_config:
+            del self.orig_config
+            self.orig_config = {}
+
+        data = bb.data.init()
+        data = self._parse(self.local, data)
+
+        # We only need to care about certain variables
+        mach = getString('MACHINE')
+        if mach and mach != self.config.get('MACHINE', ''):
+            self.config['MACHINE'] = mach
+        sdkmach = getString('SDKMACHINE')
+        if sdkmach and sdkmach != self.config.get('SDKMACHINE', ''):
+            self.config['SDKMACHINE'] = sdkmach
+        distro = getString('DISTRO')
+        if distro and distro != self.config.get('DISTRO', ''):
+            self.config['DISTRO'] = distro
+        bbnum = getString('BB_NUMBER_THREADS')
+        if bbnum and bbnum != self.config.get('BB_NUMBER_THREADS', ''):
+            self.config['BB_NUMBER_THREADS'] = bbnum
+        pmake = getString('PARALLEL_MAKE')
+        if pmake and pmake != self.config.get('PARALLEL_MAKE', ''):
+            self.config['PARALLEL_MAKE'] = pmake
+        incompat = getString('INCOMPATIBLE_LICENSE')
+        if incompat and incompat != self.config.get('INCOMPATIBLE_LICENSE', ''):
+            self.config['INCOMPATIBLE_LICENSE'] = incompat
+        pclass = getString('PACKAGE_CLASSES')
+        if pclass and pclass != self.config.get('PACKAGE_CLASSES', ''):
+            self.config['PACKAGE_CLASSES'] = pclass
+
+        self.orig_config = copy.deepcopy(self.config)
+
+    def setLocalConfVar(self, var, val):
+        if var in self.config:
+            self.config[var] = val
+
+    def _loadLayerConf(self, path):
+        self.bblayers = path
+        self.enabled_layers = {}
+        self.loaded_layers = {}
+        data = bb.data.init()
+        data = self._parse(self.bblayers, data)
+        layers = (bb.data.getVar('BBLAYERS', data, True) or "").split()
+        for layer in layers:
+            # TODO: we may be better off calling the layer by its
+            # BBFILE_COLLECTIONS value?
+            name = self._getLayerName(layer)
+            self.loaded_layers[name] = layer
+
+        self.enabled_layers = copy.deepcopy(self.loaded_layers)
+        self.emit("layers-loaded")
+
+    def _addConfigFile(self, path):
+        pref, sep, filename = path.rpartition("/")
+        if filename == "local.conf" or filename == "hob.local.conf":
+            self._loadLocalConf(path)
+        elif filename == "bblayers.conf":
+            self._loadLayerConf(path)
+
+    def _splitLayer(self, path):
+        # we only care about the path up to /conf/layer.conf
+        layerpath, conf, end = path.rpartition("/conf/")
+        return layerpath
+
+    def _getLayerName(self, path):
+        # Should this be the collection name?
+        layerpath, sep, name = path.rpartition("/")
+        return name
+
+    def disableLayer(self, layer):
+        if layer in self.enabled_layers:
+            del self.enabled_layers[layer]
+
+    def addLayerConf(self, confpath):
+        layerpath = self._splitLayer(confpath)
+        name = self._getLayerName(layerpath)
+        if name not in self.enabled_layers:
+            self.addLayer(name, layerpath)
+        return name, layerpath
+
+    def addLayer(self, name, path):
+        self.enabled_layers[name] = path
+
+    def _isLayerConfDirty(self):
+        # if a different number of layers enabled to what was
+        # loaded, definitely different
+        if len(self.enabled_layers) != len(self.loaded_layers):
+            return True
+
+        for layer in self.loaded_layers:
+            # if layer loaded but no longer present, definitely dirty
+            if layer not in self.enabled_layers:
+                return True
+
+        for layer in self.enabled_layers:
+            # if this layer wasn't present at load, definitely dirty
+            if layer not in self.loaded_layers:
+                return True
+            # if this layers path has changed, definitely dirty
+            if self.enabled_layers[layer] != self.loaded_layers[layer]:
+                return True
+
+        return False
+
+    def _constructLayerEntry(self):
+        """
+        Returns a string representing the new layer selection
+        """
+        layers = self.enabled_layers.copy()
+        # Construct BBLAYERS entry
+        layer_entry = "BBLAYERS = \" \\\n"
+        if 'meta' in layers:
+            layer_entry = layer_entry + "  %s \\\n" % layers['meta']
+            del layers['meta']
+        for layer in layers:
+            layer_entry = layer_entry + "  %s \\\n" % layers[layer]
+        layer_entry = layer_entry + "  \""
+
+        return "".join(layer_entry)
+
+    def writeLocalConf(self):
+        # Dictionary containing only new or modified variables
+        changed_values = {}
+        for var in self.config:
+            val = self.config[var]
+            if self.orig_config.get(var, None) != val:
+                changed_values[var] = val
+
+        if not len(changed_values):
+            return
+
+        # Create a backup of the local.conf
+        bkup = "%s~" % self.local
+        os.rename(self.local, bkup)
+
+        # read the original conf into a list
+        with open(bkup, 'r') as config:
+            config_lines = config.readlines()
+
+        new_config_lines = ["\n"]
+        for var in changed_values:
+            # Convenience function for re.subn(). If the pattern matches
+            # return a string which contains an assignment using the same
+            # assignment operator as the old assignment.
+            def replace_val(matchobj):
+                var = matchobj.group(1) # config variable
+                op = matchobj.group(2) # assignment operator
+                val = changed_values[var] # new config value
+                return "%s %s \"%s\"" % (var, op, val)
+
+            pattern = '^\s*(%s)\s*([+=?.]+)(.*)' % re.escape(var)
+            p = re.compile(pattern)
+            cnt = 0
+            replaced = False
+
+            # Iterate over the local.conf lines and if they are a match
+            # for the pattern comment out the line and append a new line
+            # with the new VAR op "value" entry
+            for line in config_lines:
+                new_line, replacements = p.subn(replace_val, line)
+                if replacements:
+                    config_lines[cnt] = "#%s" % line
+                    new_config_lines.append(new_line)
+                    replaced = True
+                cnt = cnt + 1
+
+            if not replaced:
+                new_config_lines.append("%s = \"%s\"" % (var, changed_values[var]))
+
+        # Add the modified variables
+        config_lines.extend(new_config_lines)
+
+        # Write the updated lines list object to the local.conf
+        with open(self.local, "w") as n:
+            n.write("".join(config_lines))
+
+        del self.orig_config
+        self.orig_config = copy.deepcopy(self.config)
+
+    def writeLayerConf(self):
+        # If we've not added/removed new layers don't write
+        if not self._isLayerConfDirty():
+            return
+
+        # This pattern should find the existing BBLAYERS
+        pattern = 'BBLAYERS\s=\s\".*\"'
+
+        # Backup the users bblayers.conf
+        bkup = "%s~" % self.bblayers
+        os.rename(self.bblayers, bkup)
+
+        replacement = self._constructLayerEntry()
+
+        with open(bkup, "r") as f:
+            contents = f.read()
+            p = re.compile(pattern, re.DOTALL)
+            new = p.sub(replacement, contents)
+
+        with open(self.bblayers, "w") as n:
+            n.write(new)
+
+        # At some stage we should remove the backup we've created
+        # though we should probably verify it first
+        #os.remove(bkup)
+
+        # set loaded_layers for dirtiness tracking
+        self.loaded_layers = copy.deepcopy(self.enabled_layers)
+
+        self.emit("layers-changed")
+
+    def configFound(self, handler, path):
+        self._addConfigFile(path)
+
+    def loadConfig(self, path):
+        self._addConfigFile(path)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
new file mode 100644
index 0000000..b3b3c7a
--- /dev/null
+++ b/lib/bb/ui/crumbs/hig.py
@@ -0,0 +1,61 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Joshua Lock <josh@linux.intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gobject
+import gtk
+"""
+The following are convenience classes for implementing GNOME HIG compliant
+BitBake GUI's
+In summary: spacing = 12px, border-width = 6px
+"""
+
+class CrumbsDialog(gtk.Dialog):
+    """
+    A GNOME HIG compliant dialog widget.
+    Add buttons with gtk.Dialog.add_button or gtk.Dialog.add_buttons
+    """
+    def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO):
+        gtk.Dialog.__init__(self, "", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
+        
+        #self.set_property("has-separator", False) # note: deprecated in 2.22
+
+        self.set_border_width(6)
+        self.vbox.set_property("spacing", 12)
+        self.action_area.set_property("spacing", 12)
+        self.action_area.set_property("border-width", 6)
+
+        first_row = gtk.HBox(spacing=12)
+        first_row.set_property("border-width", 6)
+        first_row.show()
+        self.vbox.add(first_row)
+
+        self.icon = gtk.Image()
+        self.icon.set_from_stock(icon, gtk.ICON_SIZE_DIALOG)
+        self.icon.set_property("yalign", 0.00)
+        self.icon.show()
+        first_row.add(self.icon)
+
+        self.label = gtk.Label()
+        self.label.set_use_markup(True)
+        self.label.set_line_wrap(True)
+        self.label.set_markup(label)
+        self.label.set_property("yalign", 0.00)
+        self.label.show()
+        first_row.add(self.label)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index c474491..fa79e0c 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -19,7 +19,6 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import gobject
-from bb.ui.crumbs.progress import ProgressBar
 
 progress_total = 0
 
@@ -29,46 +28,78 @@ class HobHandler(gobject.GObject):
     This object does BitBake event handling for the hob gui.
     """
     __gsignals__ = {
-         "machines-updated" : (gobject.SIGNAL_RUN_LAST,
-	                       gobject.TYPE_NONE,
-			       (gobject.TYPE_PYOBJECT,)),
-	 "distros-updated" : (gobject.SIGNAL_RUN_LAST,
-	 		      gobject.TYPE_NONE,
-			      (gobject.TYPE_PYOBJECT,)),
-         "generating-data" : (gobject.SIGNAL_RUN_LAST,
-                              gobject.TYPE_NONE,
-                              ()),
-         "data-generated" : (gobject.SIGNAL_RUN_LAST,
-                             gobject.TYPE_NONE,
-                             ())
+         "machines-updated"    : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_PYOBJECT,)),
+         "sdk-machines-updated": (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_PYOBJECT,)),
+         "distros-updated"     : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_PYOBJECT,)),
+         "package-formats-found" : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_PYOBJECT,)),
+         "config-found"        : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_STRING,)),
+         "generating-data"     : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  ()),
+         "data-generated"      : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  ()),
+         "error"               : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_STRING,)),
+         "build-complete"      : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  ()),
+         "reload-triggered"    : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
+                                  (gobject.TYPE_STRING,
+                                   gobject.TYPE_STRING)),
     }
 
     def __init__(self, taskmodel, server):
         gobject.GObject.__init__(self)
+        self.current_command = None
+        self.building = None
+        self.gplv3_excluded = False
+        self.build_toolchain = False
+        self.build_toolchain_headers = False
+        self.generating = False
+        self.build_queue = []
 
         self.model = taskmodel
         self.server = server
-        self.current_command = None
-        self.building = False
 
         self.command_map = {
-            "findConfigFilesDistro" : ("findConfigFiles", "MACHINE", "findConfigFilesMachine"),
-            "findConfigFilesMachine" : ("generateTargetsTree", "classes/image.bbclass", None),
-            "generateTargetsTree"  : (None, None, None),
+            "findConfigFilePathLocal" : ("findConfigFilePath", ["hob.local.conf"], "findConfigFilePathHobLocal"),
+            "findConfigFilePathHobLocal" : ("findConfigFilePath", ["bblayers.conf"], "findConfigFilePathLayers"),
+            "findConfigFilePathLayers" : ("findConfigFiles", ["DISTRO"], "findConfigFilesDistro"),
+            "findConfigFilesDistro" : ("findConfigFiles", ["MACHINE"], "findConfigFilesMachine"),
+            "findConfigFilesMachine" : ("findConfigFiles", ["MACHINE-SDK"], "findConfigFilesSdkMachine"),
+            "findConfigFilesSdkMachine" : ("findFilesMatchingInDir", ["rootfs_", "classes"], "findFilesMatchingPackage"),
+            "findFilesMatchingPackage" : ("generateTargetsTree", ["classes/image.bbclass"], None),
+            "generateTargetsTree"  : (None, [], None),
             }
 
     def run_next_command(self):
         # FIXME: this is ugly and I *will* replace it
         if self.current_command:
+            if not self.generating:
+                self.emit("generating-data")
+                self.generating = True
             next_cmd = self.command_map[self.current_command]
             command = next_cmd[0]
             argument = next_cmd[1]
             self.current_command = next_cmd[2]
-            if command == "generateTargetsTree":
-                self.emit("generating-data")
-            self.server.runCommand([command, argument])
+            args = [command]
+            args.extend(argument)
+            self.server.runCommand(args)
 
-    def handle_event(self, event, running_build, pbar=None):
+    def handle_event(self, event, running_build, pbar):
         if not event:
 	    return
 
@@ -77,9 +108,9 @@ class HobHandler(gobject.GObject):
             running_build.handle_event(event)
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.emit("data-generated")
+            self.generating = False
             if event._model:
                 self.model.populate(event._model)
-                
         elif isinstance(event, bb.event.ConfigFilesFound):
             var = event._variable
 	    if var == "distro":
@@ -90,28 +121,44 @@ class HobHandler(gobject.GObject):
 	        machines = event._values
 		machines.sort()
 		self.emit("machines-updated", machines)
-
+            elif var == "machine-sdk":
+                sdk_machines = event._values
+                sdk_machines.sort()
+                self.emit("sdk-machines-updated", sdk_machines)
+        elif isinstance(event, bb.event.ConfigFilePathFound):
+            path = event._path
+            self.emit("config-found", path)
+        elif isinstance(event, bb.event.FilesMatchingFound):
+            # FIXME: hard coding, should at least be a variable shared between
+            # here and the caller
+            if event._pattern == "rootfs_":
+                formats = []
+                for match in event._matches:
+                    classname, sep, cls = match.rpartition(".")
+                    fs, sep, format = classname.rpartition("_")
+                    formats.append(format)
+                formats.sort()
+                self.emit("package-formats-found", formats)
         elif isinstance(event, bb.command.CommandCompleted):
             self.run_next_command()
-        elif isinstance(event, bb.event.CacheLoadStarted) and pbar:
-            pbar.set_title("Loading cache")
+        elif isinstance(event, bb.command.CommandFailed):
+            self.emit("error", event.error)
+        elif isinstance(event, bb.event.CacheLoadStarted):
             bb.ui.crumbs.hobeventhandler.progress_total = event.total
-            pbar.update(0, bb.ui.crumbs.hobeventhandler.progress_total)
-        elif isinstance(event, bb.event.CacheLoadProgress) and pbar:
-            pbar.update(event.current, bb.ui.crumbs.hobeventhandler.progress_total)
-        elif isinstance(event, bb.event.CacheLoadCompleted) and pbar:
-            pbar.update(bb.ui.crumbs.hobeventhandler.progress_total, bb.ui.crumbs.hobeventhandler.progress_total)
-        elif isinstance(event, bb.event.ParseStarted) and pbar:
+            pbar.set_text("Loading cache: %s/%s" % (0, bb.ui.crumbs.hobeventhandler.progress_total))
+        elif isinstance(event, bb.event.CacheLoadProgress):
+            pbar.set_text("Loading cache: %s/%s" % (event.current, bb.ui.crumbs.hobeventhandler.progress_total))
+        elif isinstance(event, bb.event.CacheLoadCompleted):
+            pbar.set_text("Loading cache: %s/%s" % (bb.ui.crumbs.hobeventhandler.progress_total, bb.ui.crumbs.hobeventhandler.progress_total))
+        elif isinstance(event, bb.event.ParseStarted):
             if event.total == 0:
                 return
-            pbar.set_title("Processing recipes")
             bb.ui.crumbs.hobeventhandler.progress_total = event.total
-            pbar.update(0, bb.ui.crumbs.hobeventhandler.progress_total)
-        elif isinstance(event, bb.event.ParseProgress) and pbar:
-            pbar.update(event.current, bb.ui.crumbs.hobeventhandler.progress_total)
-        elif isinstance(event, bb.event.ParseCompleted) and pbar:
-            pbar.hide()
-            
+            pbar.set_text("Processing recipes: %s/%s" % (0, bb.ui.crumbs.hobeventhandler.progress_total))
+        elif isinstance(event, bb.event.ParseProgress):
+            pbar.set_text("Processing recipes: %s/%s" % (event.current, bb.ui.crumbs.hobeventhandler.progress_total))
+        elif isinstance(event, bb.event.ParseCompleted):
+            pbar.set_fraction(1.0)
         return
 
     def event_handle_idle_func (self, eventHandler, running_build, pbar):
@@ -124,16 +171,95 @@ class HobHandler(gobject.GObject):
 
     def set_machine(self, machine):
         self.server.runCommand(["setVariable", "MACHINE", machine])
-        self.current_command = "findConfigFilesMachine"
-        self.run_next_command()
+
+    def set_sdk_machine(self, sdk_machine):
+        self.server.runCommand(["setVariable", "SDKMACHINE", sdk_machine])
 
     def set_distro(self, distro):
         self.server.runCommand(["setVariable", "DISTRO", distro])
 
-    def run_build(self, targets):
-        self.building = True
+    def set_package_format(self, format):
+        self.server.runCommand(["setVariable", "PACKAGE_CLASSES", "package_%s" % format])
+
+    def reload_data(self, config=None):
+        img = self.model.selected_image
+        selected_packages, _ = self.model.get_selected_packages()
+        self.emit("reload-triggered", img, " ".join(selected_packages))
+        self.server.runCommand(["reparseFiles"])
+        self.current_command = "findConfigFilePathLayers"
+        self.run_next_command()
+
+    def set_bbthreads(self, threads):
+        self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", threads])
+
+    def set_pmake(self, threads):
+        pmake = "-j %s" % threads
+        self.server.runCommand(["setVariable", "BB_NUMBER_THREADS", pmake])
+
+    def run_build(self, tgts):
+        self.building = "image"
+        targets = []
+        targets.append(tgts)
+        if self.build_toolchain and self.build_toolchain_headers:
+            targets = ["meta-toolchain-sdk"] + targets
+        elif self.build_toolchain:
+            targets = ["meta-toolchain"] + targets
         self.server.runCommand(["buildTargets", targets, "build"])
 
-    def cancel_build(self):
-        # Note: this may not be the right way to stop an in-progress build
-        self.server.runCommand(["stateStop"])
+    def build_packages(self, pkgs):
+        self.building = "packages"
+        if 'meta-toolchain' in self.build_queue:
+            self.build_queue.remove('meta-toolchain')
+            pkgs.extend('meta-toolchain')
+        self.server.runCommand(["buildTargets", pkgs, "build"])
+
+    def build_file(self, image):
+        self.building = "image"
+        self.server.runCommand(["buildFile", image, "build"])
+
+    def cancel_build(self, force=False):
+        if force:
+            # Force the cooker to stop as quickly as possible
+            self.server.runCommand(["stateStop"])
+        else:
+            # Wait for tasks to complete before shutting down, this helps
+            # leave the workdir in a usable state
+            self.server.runCommand(["stateShutdown"])
+
+    def toggle_gplv3(self, excluded):
+        if self.gplv3_excluded != excluded:
+            self.gplv3_excluded = excluded
+            if excluded:
+                self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", "GPLv3"])
+            else:
+                self.server.runCommand(["setVariable", "INCOMPATIBLE_LICENSE", ""])
+
+    def toggle_toolchain(self, enabled):
+        if self.build_toolchain != enabled:
+            self.build_toolchain = enabled
+
+    def toggle_toolchain_headers(self, enabled):
+        if self.build_toolchain_headers != enabled:
+            self.build_toolchain_headers = enabled
+
+    def queue_image_recipe_path(self, path):
+        self.build_queue.append(path)
+
+    def build_complete_cb(self, running_build):
+        if len(self.build_queue) > 0:
+            next = self.build_queue.pop(0)
+            if next.endswith('.bb'):
+                self.build_file(next)
+                self.building = 'image'
+                self.build_file(next)
+            else:
+                self.build_packages(next.split(" "))
+        else:
+            self.building = None
+            self.emit("build-complete")
+
+    def set_image_output_type(self, output_type):
+        self.server.runCommand(["setVariable", "IMAGE_FSTYPES", output_type])
+
+    def get_image_deploy_dir(self):
+        return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
new file mode 100644
index 0000000..f186410
--- /dev/null
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -0,0 +1,293 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Joshua Lock <josh@linux.intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gtk
+from bb.ui.crumbs.configurator import Configurator
+
+class HobPrefs(gtk.Dialog):
+    """
+    """
+    def empty_combo_text(self, combo_text):
+        model = combo_text.get_model()
+        if model:
+            model.clear()
+
+    def output_type_changed_cb(self, combo, handler):
+        ot = combo.get_active_text()
+        if ot != self.curr_output_type:
+            self.curr_output_type = ot
+            handler.set_image_output_type(ot)
+
+    def sdk_machine_combo_changed_cb(self, combo, handler):
+        sdk_mach = combo.get_active_text()
+	if sdk_mach != self.curr_sdk_mach:
+            self.curr_sdk_mach = sdk_mach
+            self.configurator.setLocalConfVar('SDKMACHINE', sdk_mach)
+            handler.set_sdk_machine(sdk_mach)
+
+    def update_sdk_machines(self, handler, sdk_machines):
+        active = 0
+        # disconnect the signal handler before updating the combo model
+        if self.sdk_machine_handler_id:
+            self.sdk_machine_combo.disconnect(self.sdk_machine_handler_id)
+            self.sdk_machine_handler_id = None
+
+        self.empty_combo_text(self.sdk_machine_combo)
+        for sdk_machine in sdk_machines:
+            self.sdk_machine_combo.append_text(sdk_machine)
+            if sdk_machine == self.curr_sdk_mach:
+                self.sdk_machine_combo.set_active(active)
+            active = active + 1
+
+        self.sdk_machine_handler_id = self.sdk_machine_combo.connect("changed", self.sdk_machine_combo_changed_cb, handler)
+
+    def distro_combo_changed_cb(self, combo, handler):
+        distro = combo.get_active_text()
+	if distro != self.curr_distro:
+            self.curr_distro = distro
+            self.configurator.setLocalConfVar('DISTRO', distro)
+            handler.set_distro(distro)
+            self.reload_required = True
+
+    def update_distros(self, handler, distros):
+        active = 0
+        # disconnect the signal handler before updating combo model
+        if self.distro_handler_id:
+            self.distro_combo.disconnect(self.distro_handler_id)
+            self.distro_handler_id = None
+
+        self.empty_combo_text(self.distro_combo)
+	for distro in distros:
+	    self.distro_combo.append_text(distro)
+	    if distro == self.curr_distro:
+                self.distro_combo.set_active(active)
+	    active = active + 1
+
+	self.distro_handler_id = self.distro_combo.connect("changed", self.distro_combo_changed_cb, handler)
+
+    def package_format_combo_changed_cb(self, combo, handler):
+        package_format = combo.get_active_text()
+        if package_format != self.curr_package_format:
+            self.curr_package_format = package_format
+            self.configurator.setLocalConfVar('PACKAGE_CLASSES', 'package_%s' % package_format)
+            handler.set_package_format(package_format)
+
+    def update_package_formats(self, handler, formats):
+        active = 0
+        # disconnect the signal handler before updating the model
+        if self.package_handler_id:
+            self.package_combo.disconnect(self.package_handler_id)
+            self.package_handler_id = None
+
+        self.empty_combo_text(self.package_combo)
+        for format in formats:
+            self.package_combo.append_text(format)
+            if format == self.curr_package_format:
+                self.package_combo.set_active(active)
+            active = active + 1
+
+        self.package_handler_id = self.package_combo.connect("changed", self.package_format_combo_changed_cb, handler)
+    
+    def include_gplv3_cb(self, toggle):
+        excluded = toggle.get_active()
+        self.handler.toggle_gplv3(excluded)
+        if excluded:
+            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', 'GPLv3')
+        else:
+            self.configurator.setLocalConfVar('INCOMPATIBLE_LICENSE', '')
+        self.reload_required = True
+
+    def change_bb_threads_cb(self, spinner):
+        val = spinner.get_value_as_int()
+        self.handler.set_bbthreads(val)
+        self.configurator.setLocalConfVar('BB_NUMBER_THREADS', val)
+
+    def change_make_threads_cb(self, spinner):
+        val = spinner.get_value_as_int()
+        self.handler.set_pmake(val)
+        self.configurator.setLocalConfVar('PARALLEL_MAKE', "-j %s" % val)
+
+    def toggle_toolchain_cb(self, check):
+        enabled = check.get_active()
+        self.handler.toggle_toolchain(enabled)
+
+    def toggle_headers_cb(self, check):
+        enabled = check.get_active()
+        self.handler.toggle_toolchain_headers(enabled)
+
+    def set_parent_window(self, parent):
+        self.set_transient_for(parent)
+
+    def write_changes(self):
+        self.configurator.writeLocalConf()
+
+    def prefs_response_cb(self, dialog, response):
+        if self.reload_required:
+            glib.idle_add(self.handler.reload_data)
+
+    def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
+                 cpu_cnt, pmake, bbthread, image_types):
+        """
+        """
+        gtk.Dialog.__init__(self, "Preferences", None,
+                            gtk.DIALOG_DESTROY_WITH_PARENT,
+                            (gtk.STOCK_CLOSE, gtk.RESPONSE_OK))
+
+        self.set_border_width(6)
+        self.vbox.set_property("spacing", 12)
+        self.action_area.set_property("spacing", 12)
+        self.action_area.set_property("border-width", 6)
+
+        self.handler = handler
+        self.configurator = configurator
+
+        self.curr_sdk_mach = curr_sdk_mach
+        self.curr_distro = curr_distro
+        self.curr_package_format = pclass
+        self.curr_output_type = None
+        self.cpu_cnt = cpu_cnt
+        self.pmake = pmake
+        self.bbthread = bbthread
+        self.reload_required = False
+        self.distro_handler_id = None
+        self.sdk_machine_handler_id = None
+        self.package_handler_id = None
+
+        left = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
+        right = gtk.SizeGroup(gtk.SIZE_GROUP_HORIZONTAL)
+
+        label = gtk.Label()
+        label.set_markup("<b>Policy</b>")
+        label.show()
+        frame = gtk.Frame()
+        frame.set_label_widget(label)
+        frame.set_shadow_type(gtk.SHADOW_NONE)
+        frame.show()
+        self.vbox.pack_start(frame)
+        pbox = gtk.VBox(False, 12)
+        pbox.show()
+        frame.add(pbox)
+        hbox = gtk.HBox(False, 12)
+        hbox.show()
+        pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+        # Distro selector
+        label = gtk.Label("Distribution:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        self.distro_combo = gtk.combo_box_new_text()
+        self.distro_combo.set_tooltip_text("Select the Yocto distribution you would like to use")
+        self.distro_combo.show()
+        hbox.pack_start(self.distro_combo, expand=False, fill=False, padding=6)
+        # Exclude GPLv3
+        check = gtk.CheckButton("Exclude GPLv3 packages")
+        check.set_tooltip_text("Check this box to prevent GPLv3 packages from being included in your image")
+        check.show()
+        check.connect("toggled", self.include_gplv3_cb)
+        hbox.pack_start(check, expand=False, fill=False, padding=6)
+        hbox = gtk.HBox(False, 12)
+        hbox.show()
+        pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+        # Package format selector
+        label = gtk.Label("Package format:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        self.package_combo = gtk.combo_box_new_text()
+        self.package_combo.set_tooltip_text("Select the package format you would like to use in your image")
+        self.package_combo.show()
+        hbox.pack_start(self.package_combo, expand=False, fill=False, padding=6)
+        # Image output type selector
+        label = gtk.Label("Image output type:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        output_combo = gtk.combo_box_new_text()
+        if image_types:
+            for it in image_types.split(" "):
+                output_combo.append_text(it)
+            output_combo.connect("changed", self.output_type_changed_cb, handler)
+        else:
+            output_combo.set_sensitive(False)
+        output_combo.show()
+        hbox.pack_start(output_combo)
+        # BitBake
+        label = gtk.Label()
+        label.set_markup("<b>BitBake</b>")
+        label.show()
+        frame = gtk.Frame()
+        frame.set_label_widget(label)
+        frame.set_shadow_type(gtk.SHADOW_NONE)
+        frame.show()
+        self.vbox.pack_start(frame)
+        pbox = gtk.VBox(False, 12)
+        pbox.show()
+        frame.add(pbox)
+        hbox = gtk.HBox(False, 12)
+        hbox.show()
+        pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+        label = gtk.Label("BitBake threads:")
+        label.show()
+        spin_max = 9 #self.cpu_cnt * 3
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        bbadj = gtk.Adjustment(value=self.bbthread, lower=1, upper=spin_max, step_incr=1)
+        bbspinner = gtk.SpinButton(adjustment=bbadj, climb_rate=1, digits=0)
+        bbspinner.show()
+        bbspinner.connect("value-changed", self.change_bb_threads_cb)
+        hbox.pack_start(bbspinner, expand=False, fill=False, padding=6)
+        label = gtk.Label("Make threads:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        madj = gtk.Adjustment(value=self.pmake, lower=1, upper=spin_max, step_incr=1)
+        makespinner = gtk.SpinButton(adjustment=madj, climb_rate=1, digits=0)
+        makespinner.connect("value-changed", self.change_make_threads_cb)
+        makespinner.show()
+        hbox.pack_start(makespinner, expand=False, fill=False, padding=6)
+        # Toolchain
+        label = gtk.Label()
+        label.set_markup("<b>External Toolchain</b>")
+        label.show()
+        frame = gtk.Frame()
+        frame.set_label_widget(label)
+        frame.set_shadow_type(gtk.SHADOW_NONE)
+        frame.show()
+        self.vbox.pack_start(frame)
+        pbox = gtk.VBox(False, 12)
+        pbox.show()
+        frame.add(pbox)
+        hbox = gtk.HBox(False, 12)
+        hbox.show()
+        pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+        toolcheck = gtk.CheckButton("Build external development toolchain with image")
+        toolcheck.show()
+        toolcheck.connect("toggled", self.toggle_toolchain_cb)
+        hbox.pack_start(toolcheck, expand=False, fill=False, padding=6)
+        hbox = gtk.HBox(False, 12)
+        hbox.show()
+        pbox.pack_start(hbox, expand=False, fill=False, padding=6)
+        label = gtk.Label("Toolchain host:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        self.sdk_machine_combo = gtk.combo_box_new_text()
+        self.sdk_machine_combo.set_tooltip_text("Select the host architecture of the external machine")
+        self.sdk_machine_combo.show()
+        hbox.pack_start(self.sdk_machine_combo, expand=False, fill=False, padding=6)
+        headerscheck = gtk.CheckButton("Include development headers with toolchain")
+        headerscheck.show()
+        headerscheck.connect("toggled", self.toggle_headers_cb)
+        hbox.pack_start(headerscheck, expand=False, fill=False, padding=6)
+        self.connect("response", self.prefs_response_cb)
diff --git a/lib/bb/ui/crumbs/layereditor.py b/lib/bb/ui/crumbs/layereditor.py
new file mode 100644
index 0000000..76a2eb5
--- /dev/null
+++ b/lib/bb/ui/crumbs/layereditor.py
@@ -0,0 +1,136 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011        Intel Corporation
+#
+# Authored by Joshua Lock <josh@linux.intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gobject
+import gtk
+from bb.ui.crumbs.configurator import Configurator
+
+class LayerEditor(gtk.Dialog):
+    """
+    Gtk+ Widget for enabling and disabling layers.
+    Layers are added through using an open dialog to find the layer.conf
+    Disabled layers are deleted from conf/bblayers.conf
+    """
+    def __init__(self, configurator, parent=None):
+        gtk.Dialog.__init__(self, "Layers", None,
+                            gtk.DIALOG_DESTROY_WITH_PARENT,
+                            (gtk.STOCK_CLOSE, gtk.RESPONSE_OK))
+
+        # We want to show a little more of the treeview in the default,
+        # emptier, case
+        self.set_size_request(-1, 300)
+        self.set_border_width(6)
+        self.vbox.set_property("spacing", 0)
+        self.action_area.set_property("border-width", 6)
+
+        self.configurator = configurator
+        self.newly_added = {}
+
+        # Label to inform users that meta is enabled but that you can't
+        # disable it as it'd be a *bad* idea
+        msg = "As the core of the build system the <i>meta</i> layer must always be included and therefore can't be viewed or edited here."
+        lbl = gtk.Label()
+        lbl.show()
+        lbl.set_use_markup(True)
+        lbl.set_markup(msg)
+        lbl.set_line_wrap(True)
+        lbl.set_justify(gtk.JUSTIFY_FILL)
+        self.vbox.pack_start(lbl, expand=False, fill=False, padding=6)
+
+        # Create a treeview in which to list layers
+        # ListStore of Name, Path, Enabled
+        self.layer_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
+        self.tv = gtk.TreeView(self.layer_store)
+        self.tv.set_headers_visible(True)
+
+        col0 = gtk.TreeViewColumn('Name')
+        self.tv.append_column(col0)
+        col1 = gtk.TreeViewColumn('Path')
+        self.tv.append_column(col1)
+        col2 = gtk.TreeViewColumn('Enabled')
+        self.tv.append_column(col2)
+
+        cell0 = gtk.CellRendererText()
+        col0.pack_start(cell0, True)
+        col0.set_attributes(cell0, text=0)
+        cell1 = gtk.CellRendererText()
+        col1.pack_start(cell1, True)
+        col1.set_attributes(cell1, text=1)
+        cell2 = gtk.CellRendererToggle()
+        cell2.connect("toggled", self._toggle_layer_cb)
+        col2.pack_start(cell2, True)
+        col2.set_attributes(cell2, active=2)
+
+        self.tv.show()
+        self.vbox.pack_start(self.tv, expand=True, fill=True, padding=0)
+
+        tb = gtk.Toolbar()
+        tb.set_icon_size(gtk.ICON_SIZE_SMALL_TOOLBAR)
+        tb.set_style(gtk.TOOLBAR_BOTH)
+        tb.set_tooltips(True)
+        tb.show()
+        icon = gtk.Image()
+        icon.set_from_stock(gtk.STOCK_ADD, gtk.ICON_SIZE_SMALL_TOOLBAR)
+        icon.show()
+        tb.insert_item("Add Layer", "Add new layer", None, icon,
+                       self._find_layer_cb, None, -1)
+        self.vbox.pack_start(tb, expand=False, fill=False, padding=0)
+
+    def set_parent_window(self, parent):
+        self.set_transient_for(parent)
+
+    def load_current_layers(self, data):
+        for layer, path in self.configurator.enabled_layers.items():
+            if layer != 'meta':
+                self.layer_store.append([layer, path, True])
+
+    def save_current_layers(self):
+        self.configurator.writeLayerConf()
+
+    def _toggle_layer_cb(self, cell, path):
+        name = self.layer_store[path][0]
+        toggle = not self.layer_store[path][2]
+        if toggle:
+            self.configurator.addLayer(name, path)
+        else:
+            self.configurator.disableLayer(name)
+        self.layer_store[path][2] = toggle
+
+    def _find_layer_cb(self, button):
+        self.find_layer(self)
+
+    def find_layer(self, parent):
+        dialog = gtk.FileChooserDialog("Add new layer", parent,
+                                       gtk.FILE_CHOOSER_ACTION_OPEN,
+                                       (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
+                                        gtk.STOCK_OPEN, gtk.RESPONSE_YES))
+        label = gtk.Label("Select the layer.conf of the layer you wish to add")
+        label.show()
+        dialog.set_extra_widget(label)
+        response = dialog.run()
+        path = dialog.get_filename()
+        dialog.destroy()
+
+        if response == gtk.RESPONSE_YES:
+            # FIXME: verify we've actually got a layer conf?
+            if path.endswith(".conf"):
+                name, layerpath = self.configurator.addLayerConf(path)
+                self.newly_added[name] = layerpath
+                self.layer_store.append([name, layerpath, True])
diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 70fd57e..bdab340 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -47,12 +47,18 @@ class RunningBuildModel (gtk.TreeStore):
 
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
+          'build-started' : (gobject.SIGNAL_RUN_LAST,
+                               gobject.TYPE_NONE,
+                               ()),
           'build-succeeded' : (gobject.SIGNAL_RUN_LAST,
                                gobject.TYPE_NONE,
                                ()),
           'build-failed' : (gobject.SIGNAL_RUN_LAST,
                             gobject.TYPE_NONE,
-                            ())
+                            ()),
+          'build-complete' : (gobject.SIGNAL_RUN_LAST,
+                              gobject.TYPE_NONE,
+                              ())
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -201,6 +207,7 @@ class RunningBuild (gobject.GObject):
 
         elif isinstance(event, bb.event.BuildStarted):
 
+            self.emit("build-started")
             self.model.prepend(None, (None,
                                       None,
                                       None,
@@ -218,6 +225,9 @@ class RunningBuild (gobject.GObject):
                                       Colors.OK,
                                       0))
 
+            # Emit a generic "build-complete" signal for things wishing to
+            # handle when the build is finished
+            self.emit("build-complete")
             # Emit the appropriate signal depending on the number of failures
             if (failures >= 1):
                 self.emit ("build-failed")
diff --git a/lib/bb/ui/crumbs/tasklistmodel.py b/lib/bb/ui/crumbs/tasklistmodel.py
index a83a176..cabd70c 100644
--- a/lib/bb/ui/crumbs/tasklistmodel.py
+++ b/lib/bb/ui/crumbs/tasklistmodel.py
@@ -21,6 +21,62 @@
 import gtk
 import gobject
 
+class BuildRep(gobject.GObject):
+
+    def __init__(self, userpkgs, allpkgs, base_image=None):
+        gobject.GObject.__init__(self)
+        self.base_image = base_image
+        self.allpkgs = allpkgs
+        self.userpkgs = userpkgs
+
+    def loadRecipe(self, pathname):
+        import re
+
+        contents = []
+        packages = ""
+        base_image = ""
+
+        with open(pathname, 'r') as f:
+            contents = f.readlines()
+
+        pkg_pattern = "^\s*(IMAGE_INSTALL)\s*([+=.?]+)\s*(\"\S*\")"
+        img_pattern = "^\s*(require)\s+(\S+.bb)"
+
+        for line in contents:
+            matchpkg = re.search(pkg_pattern, line)
+            matchimg = re.search(img_pattern, line)
+            if matchpkg:
+                packages = packages + matchpkg.group(3).strip('"')
+            if matchimg:
+                base_image = os.path.basename(matchimg.group(2)).split(".")[0]
+
+        self.base_image = base_image
+        self.userpkgs = packages
+
+    def writeRecipe(self, writepath):
+        # FIXME: Need a better way to determine meta_path...
+        template = """
+# Recipe generated by the HOB
+
+require %s.bb
+
+IMAGE_INSTALL += "%s"
+"""
+        if self.base_image.count('sato'):
+            meta_path = "recipes-sato/images/%s" % self.base_image
+        else:
+            meta_path = "recipes-core/images/%s" % self.base_image
+
+        recipe = template % (meta_path, self.userpkgs)
+
+        if os.path.exists(writepath):
+            os.rename(writepath, "%s~" % writepath)
+
+        with open(writepath, 'w') as r:
+            r.write(recipe)
+
+        return writepath
+
 class TaskListModel(gtk.ListStore):
     """
     This class defines an gtk.ListStore subclass which will convert the output
@@ -28,12 +84,18 @@ class TaskListModel(gtk.ListStore):
     providing convenience functions to access gtk.TreeModel subclasses which
     provide filtered views of the data.
     """
-    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC) = range(8)
+    (COL_NAME, COL_DESC, COL_LIC, COL_GROUP, COL_DEPS, COL_BINB, COL_TYPE, COL_INC, COL_IMG) = range(9)
 
     __gsignals__ = {
         "tasklist-populated" : (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
-                                ())
+                                ()),
+        "contents-changed"   : (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                                (gobject.TYPE_INT,)),
+        "image-changed"      : (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                                (gobject.TYPE_STRING,)),
         }
 
     """
@@ -43,6 +105,7 @@ class TaskListModel(gtk.ListStore):
         self.tasks = None
         self.packages = None
         self.images = None
+        self.selected_image = None
         
         gtk.ListStore.__init__ (self,
                                 gobject.TYPE_STRING,
@@ -52,8 +115,22 @@ class TaskListModel(gtk.ListStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_STRING,
+                                gobject.TYPE_BOOLEAN,
                                 gobject.TYPE_BOOLEAN)
 
+    def contents_changed_cb(self, tree_model, path, it=None):
+        pkg_cnt = self.contents.iter_n_children(None)
+        self.emit("contents-changed", pkg_cnt)
+
+    def contents_model_filter(self, model, it):
+        if not model.get_value(it, self.COL_INC) or model.get_value(it, self.COL_TYPE) == 'image':
+            return False
+        name = model.get_value(it, self.COL_NAME)
+        if name.endswith('-native') or name.endswith('-cross'):
+            return False
+        else:
+            return True
+
     """
     Create, if required, and return a filtered gtk.TreeModel
     containing only the items which are to be included in the
@@ -62,7 +139,9 @@ class TaskListModel(gtk.ListStore):
     def contents_model(self):
         if not self.contents:
             self.contents = self.filter_new()
-            self.contents.set_visible_column(self.COL_INC)
+            self.contents.set_visible_func(self.contents_model_filter)
+            self.contents.connect("row-inserted", self.contents_changed_cb)
+            self.contents.connect("row-deleted", self.contents_changed_cb)
         return self.contents
     
     """
@@ -107,10 +186,10 @@ class TaskListModel(gtk.ListStore):
     Helper function to determine whether an item is a package
     """
     def package_model_filter(self, model, it):
-        if model.get_value(it, self.COL_TYPE) == 'package':
-            return True
-        else:
+        if model.get_value(it, self.COL_TYPE) != 'package':
             return False
+        else:
+            return True
 
     """
     Create, if required, and return a filtered gtk.TreeModel
@@ -129,33 +208,78 @@ class TaskListModel(gtk.ListStore):
     to notify any listeners that the model is ready
     """
     def populate(self, event_model):
+        # First clear the model, in case repopulating
+        self.clear()
         for item in event_model["pn"]:
             atype = 'package'
             name = item
             summary = event_model["pn"][item]["summary"]
-            license = event_model["pn"][item]["license"]
+            lic = event_model["pn"][item]["license"]
             group = event_model["pn"][item]["section"]
             
 	    depends = event_model["depends"].get(item, "")
             rdepends = event_model["rdepends-pn"].get(item, "")
-            depends = depends + rdepends
+            if rdepends:
+                for rdep in rdepends:
+                    if event_model["packages"].get(rdep, ""):
+                        pn = event_model["packages"][rdep].get("pn", "")
+                        if pn:
+                            depends.append(pn)
+
             self.squish(depends)
             deps = " ".join(depends)
-            
+
             if name.count('task-') > 0:
                 atype = 'task'
             elif name.count('-image-') > 0:
                 atype = 'image'
 
             self.set(self.append(), self.COL_NAME, name, self.COL_DESC, summary,
-	             self.COL_LIC, license, self.COL_GROUP, group,
-		     self.COL_DEPS, deps, self.COL_BINB, "",
-		     self.COL_TYPE, atype, self.COL_INC, False)
-	
+                     self.COL_LIC, lic, self.COL_GROUP, group,
+                     self.COL_DEPS, deps, self.COL_BINB, "",
+                     self.COL_TYPE, atype, self.COL_INC, False,
+                     self.COL_IMG, False)
+
 	self.emit("tasklist-populated")
 
     """
-    squish lst so that it doesn't contain any duplicates
+    Load a BuildRep into the model
+    """
+    def load_image_rep(self, rep):
+        # Unset everything
+        it = self.get_iter_first()
+        while it:
+            path = self.get_path(it)
+            self[path][self.COL_INC] = False
+            self[path][self.COL_IMG] = False
+            it = self.iter_next(it)
+
+        # Iterate the images and disable them all
+        it = self.images.get_iter_first()
+        while it:
+            path = self.images.convert_path_to_child_path(self.images.get_path(it))
+            name = self[path][self.COL_NAME]
+            if name == rep.base_image:
+                self.include_item(path, image_contents=True)
+            else:
+                self[path][self.COL_INC] = False
+            it = self.images.iter_next(it)
+
+        # Mark all of the additional packages for inclusion
+        packages = rep.packages.split(" ")
+        it = self.get_iter_first()
+        while it:
+            path = self.get_path(it)
+            name = self[path][self.COL_NAME]
+            if name in packages:
+                self.include_item(path)
+                packages.remove(name)
+            it = self.iter_next(it)
+
+        self.emit("image-changed", rep.base_image)
+
+    """
+    squish lst so that it doesn't contain any duplicate entries
     """
     def squish(self, lst):
         seen = {}
@@ -173,56 +297,59 @@ class TaskListModel(gtk.ListStore):
         self[path][self.COL_INC] = False
 
     """
+    recursively called to mark the item at opath and any package which
+    depends on it for removal
     """
-    def mark(self, path):
-        name = self[path][self.COL_NAME]
-        it = self.get_iter_first()
+    def mark(self, opath):
         removals = []
-        #print("Removing %s" % name)
+        it = self.get_iter_first()
+        name = self[opath][self.COL_NAME]
 
-        self.remove_item_path(path)
+        self.remove_item_path(opath)
 
         # Remove all dependent packages, update binb
         while it:
             path = self.get_path(it)
-            # FIXME: need to ensure partial name matching doesn't happen, regexp?
-            if self[path][self.COL_INC] and self[path][self.COL_DEPS].count(name):
-                #print("%s depended on %s, marking for removal" % (self[path][self.COL_NAME], name))
+            inc = self[path][self.COL_INC]
+            deps = self[path][self.COL_DEPS]
+            binb = self[path][self.COL_BINB]
+
+            # FIXME: need to ensure partial name matching doesn't happen
+            if inc and deps.count(name):
                 # found a dependency, remove it
                 self.mark(path)
-            if self[path][self.COL_INC] and self[path][self.COL_BINB].count(name):
-                binb = self.find_alt_dependency(self[path][self.COL_NAME])
-                #print("%s was brought in by %s, binb set to %s" % (self[path][self.COL_NAME], name, binb))
-                self[path][self.COL_BINB] = binb
+            if inc and binb.count(name):
+                bib = self.find_alt_dependency(name)
+                self[path][self.COL_BINB] = bib
+
             it = self.iter_next(it)
 
     """
+    Remove items from contents if the have an empty COL_BINB (brought in by)
+    caused by all packages they are a dependency of being removed.
+    If the item isn't a package we leave it included.
     """
     def sweep_up(self):
+        model = self.contents
         removals = []
-        it = self.get_iter_first()
+        it = self.contents.get_iter_first()
 
 	while it:
-	    path = self.get_path(it)
-	    binb = self[path][self.COL_BINB]
-	    if binb == "" or binb is None:
-                #print("Sweeping up %s" % self[path][self.COL_NAME])
-                if not path in removals:
-                    removals.extend(path)
-            it = self.iter_next(it)
+            binb = model.get_value(it, self.COL_BINB)
+            itype = model.get_value(it, self.COL_TYPE)
+
+            if itype == 'package' and not binb:
+                opath = model.convert_path_to_child_path(model.get_path(it))
+                if not opath in removals:
+                    removals.extend(opath)
+
+            it = model.iter_next(it)
 
 	while removals:
 	    path = removals.pop()
 	    self.mark(path)
 
     """
-    Remove an item from the contents
-    """
-    def remove_item(self, path):
-        self.mark(path)
-        self.sweep_up()
-
-    """
     Find the name of an item in the image contents which depends on the item
     at contents_path returns either an item name (str) or None
     NOTE:
@@ -238,18 +365,11 @@ class TaskListModel(gtk.ListStore):
             inc = self[path][self.COL_INC]
             if itname != name and inc and deps.count(name) > 0:
 		# if this item depends on the item, return this items name
-		#print("%s depends on %s" % (itname, name))
 	        return itname
 	    it = self.iter_next(it)
 	return ""
 
     """
-    Convert a path in self to a path in the filtered contents model
-    """
-    def contents_path_for_path(self, path):
-        return self.contents.convert_child_path_to_path(path)
-
-    """
     Check the self.contents gtk.TreeModel for an item
     where COL_NAME matches item_name
     Returns True if a match is found, False otherwise
@@ -266,25 +386,30 @@ class TaskListModel(gtk.ListStore):
     """
     Add this item, and any of its dependencies, to the image contents
     """
-    def include_item(self, item_path, binb=""):
+    def include_item(self, item_path, binb="", image_contents=False):
         name = self[item_path][self.COL_NAME]
         deps = self[item_path][self.COL_DEPS]
         cur_inc = self[item_path][self.COL_INC]
-        #print("Adding %s for %s dependency" % (name, binb))
         if not cur_inc:
             self[item_path][self.COL_INC] = True
             self[item_path][self.COL_BINB] = binb
+        # We want to do some magic with things which are brought in by the base
+        # image so tag them as so
+        if image_contents:
+            self[item_path][self.COL_IMG] = True
+            if self[item_path][self.COL_TYPE] == 'image':
+                self.selected_image = name
+
         if deps:
-            #print("Dependencies of %s are %s" % (name, deps))
             # add all of the deps and set their binb to this item
             for dep in deps.split(" "):
-                # FIXME: this skipping virtuals can't be right? Unless we choose only to show target
-                # packages? In which case we should handle this server side...
                 # If the contents model doesn't already contain dep, add it
-                if not dep.startswith("virtual") and not self.contents_includes_name(dep):
+                # We only care to show things which will end up in the
+                # resultant image, so filter cross and native recipes
+                if not self.contents_includes_name(dep) and not dep.endswith("-native") and not dep.endswith("-cross"):
                     path = self.find_path_for_item(dep)
                     if path:
-                        self.include_item(path, name)
+                        self.include_item(path, name, image_contents)
                     else:
                         pass
 
@@ -317,30 +442,61 @@ class TaskListModel(gtk.ListStore):
             it = self.contents.get_iter_first()
 
     """
-    Returns True if one of the selected tasks is an image, False otherwise
+    Returns two lists. One of user selected packages and the other containing
+    all selected packages
     """
-    def targets_contains_image(self):
-        it = self.images.get_iter_first()
+    def get_selected_packages(self):
+        allpkgs = []
+        userpkgs = []
+
+        it = self.contents.get_iter_first()
         while it:
-            path = self.images.get_path(it)
-            inc = self.images[path][self.COL_INC]
-            if inc:
-                return True
-            it = self.images.iter_next(it)
-        return False
+            sel = self.contents.get_value(it, self.COL_BINB) == "User Selected"
+            name = self.contents.get_value(it, self.COL_NAME)
+            allpkgs.append(name)
+            if sel:
+                userpkgs.append(name)
+            it = self.contents.iter_next(it)
+        return userpkgs, allpkgs
 
-    """
-    Return a list of all selected items which are not -native or -cross
-    """
-    def get_targets(self):
-        tasks = []
+    def get_build_rep(self):
+        userpkgs, allpkgs = self.get_selected_packages()
+        image = self.selected_image
 
+        return BuildRep(" ".join(userpkgs), " ".join(allpkgs), image)
+
+    def find_reverse_depends(self, pn):
+        revdeps = []
         it = self.contents.get_iter_first()
+
         while it:
-            path = self.contents.get_path(it)
-            name = self.contents[path][self.COL_NAME]
-            stype = self.contents[path][self.COL_TYPE]
-            if not name.count('-native') and not name.count('-cross'):
-                tasks.append(name)
+            if self.contents.get_value(it, self.COL_DEPS).count(pn) != 0:
+                revdeps.append(self.contents.get_value(it, self.COL_NAME))
             it = self.contents.iter_next(it)
-        return tasks
+
+        revdeps.remove(pn)
+        return revdeps
+
+    def set_selected_image(self, img):
+        self.selected_image = img
+        path = self.find_path_for_item(img)
+        self.include_item(item_path=path,
+                          binb="User Selected",
+                          image_contents=True)
+
+        self.emit("image-changed", self.selected_image)
+
+    def set_selected_packages(self, pkglist):
+        selected = pkglist
+        it = self.get_iter_first()
+
+        while it:
+            name = self.get_value(it, self.COL_NAME)
+            if name in pkglist:
+                pkglist.remove(name)
+                path = self.get_path(it)
+                self.include_item(item_path=path,
+                                  binb="User Selected")
+                if len(pkglist) == 0:
+                    return
+            it = self.iter_next(it)
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 175e5bd..ca38c3b 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -18,12 +18,16 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import glib
 import gobject
 import gtk
-from bb.ui.crumbs.progress import ProgressBar
-from bb.ui.crumbs.tasklistmodel import TaskListModel
+from bb.ui.crumbs.tasklistmodel import TaskListModel, BuildRep
 from bb.ui.crumbs.hobeventhandler import HobHandler
+from bb.ui.crumbs.configurator import Configurator
+from bb.ui.crumbs.hobprefs import HobPrefs
+from bb.ui.crumbs.layereditor import LayerEditor
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView, RunningBuild
+from bb.ui.crumbs.hig import CrumbsDialog
 import xmlrpclib
 import logging
 import Queue
@@ -32,226 +36,459 @@ extraCaches = ['bb.cache_extra:HobRecipeInfo']
 
 class MainWindow (gtk.Window):
             
-    def __init__(self, taskmodel, handler, curr_mach=None, curr_distro=None):
-        gtk.Window.__init__(self, gtk.WINDOW_TOPLEVEL)
+    def __init__(self, taskmodel, handler, configurator, prefs, layers, mach):
+        gtk.Window.__init__(self)
+        # global state
+        self.curr_mach = mach
+        self.machine_handler_id = None
+        self.image_combo_id = None
+        self.generating = False
+        self.files_to_clean = []
+        self.selected_image = None
+        self.selected_packages = None
+
         self.model = taskmodel
-	self.model.connect("tasklist-populated", self.update_model)
-	self.curr_mach = curr_mach
-	self.curr_distro = curr_distro
+        self.model.connect("tasklist-populated", self.update_model)
+        self.model.connect("image-changed", self.image_changed_string_cb)
+        self.curr_image_path = None
         self.handler = handler
-        self.set_border_width(10)
-        self.connect("delete-event", gtk.main_quit)
-        self.set_title("BitBake Image Creator")
-        self.set_default_size(700, 600)
+        self.configurator = configurator
+        self.prefs = prefs
+        self.layers = layers
+        self.save_path = None
+        self.dirty = False
+
+        self.connect("delete-event", self.destroy_window)
+        self.set_title("Image Creator")
+        self.set_icon_name("applications-development")
+        self.set_default_size(1000, 650)
 
         self.build = RunningBuild()
-        self.build.connect("build-succeeded", self.running_build_succeeded_cb)
         self.build.connect("build-failed", self.running_build_failed_cb)
+        self.build.connect("build-complete", self.handler.build_complete_cb)
+        self.build.connect("build-started", self.build_started_cb)
 
-	createview = self.create_build_gui()
+        self.handler.connect("build-complete", self.build_complete_cb)
+
+        vbox = gtk.VBox(False, 0)
+        vbox.set_border_width(0)
+        vbox.show()
+        self.add(vbox)
+        self.menu = self.create_menu()
+        vbox.pack_start(self.menu, False)
+        createview = self.create_build_gui()
+        self.back = None
+        self.cancel = None
         buildview = self.view_build_gui()
-	self.nb = gtk.Notebook()
-	self.nb.append_page(createview)
-	self.nb.append_page(buildview)
-	self.nb.set_current_page(0)
-	self.nb.set_show_tabs(False)
-        self.add(self.nb)
-        self.generating = False
+        self.nb = gtk.Notebook()
+        self.nb.append_page(createview)
+        self.nb.append_page(buildview)
+        self.nb.set_current_page(0)
+        self.nb.set_show_tabs(False)
+        vbox.pack_start(self.nb, expand=True, fill=True)
+
+    def destroy_window(self, widget, event):
+        self.quit()
+
+    def menu_quit(self, action):
+        self.quit()
+
+    def quit(self):
+        if self.dirty and len(self.model.contents):
+            question = "Would you like to save your customisations?"
+            dialog = CrumbsDialog(self, question, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_buttons(gtk.STOCK_NO, gtk.RESPONSE_NO,
+                               gtk.STOCK_YES, gtk.RESPONSE_YES)
+            resp = dialog.run()
+            if resp == gtk.RESPONSE_YES:
+                if not self.save_path:
+                    self.get_save_path()
+                self.save_recipe_file()
+                rep = self.model.get_build_rep()
+                rep.writeRecipe(self.save_path)
+
+        gtk.main_quit()
 
     def scroll_tv_cb(self, model, path, it, view):
         view.scroll_to_cell(path)
 
     def running_build_failed_cb(self, running_build):
         # FIXME: handle this
-        return
+        print("Build failed")
+
+    def image_changed_string_cb(self, model, new_image):
+        cnt = 0
+        it = self.model.images.get_iter_first()
+        while it:
+            path = self.model.images.get_path(it)
+            if self.model.images[path][self.model.COL_NAME] == new_image:
+                self.image_combo.set_active(cnt)
+                break
+            it = self.model.images.iter_next(it)
+            cnt = cnt + 1
+
+    def image_changed_cb(self, combo):
+        model = self.image_combo.get_model()
+        it = self.image_combo.get_active_iter()
+        if it:
+            path = model.get_path(it)
+            # Firstly, deselect the previous image
+            if self.curr_image_path:
+                self.toggle_package(self.curr_image_path, model)
+            # Now select the new image and save its path in case we
+            # change the image later
+            self.curr_image_path = path
+            self.toggle_package(path, model, image=True)
+
+    def reload_triggered_cb(self, handler, image, packages):
+        if image:
+            self.selected_image = image
+        if len(packages):
+            self.selected_packages = packages.split()
 
-    def running_build_succeeded_cb(self, running_build):
-        label = gtk.Label("Build completed, start another build?")
-        dialog = gtk.Dialog("Build complete",
-                            self,
-                            gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
-                            (gtk.STOCK_NO, gtk.RESPONSE_NO,
-                             gtk.STOCK_YES, gtk.RESPONSE_YES))
-        dialog.vbox.pack_start(label)
-        label.show()
-        response = dialog.run()
-        dialog.destroy()
-        if response == gtk.RESPONSE_YES:
-            self.model.reset() # NOTE: really?
-            self.nb.set_current_page(0)
-        return
+    def data_generated(self, handler):
+        self.generating = False
+        self.image_combo.set_model(self.model.images_model())
+        if not self.image_combo_id:
+            self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+        self.enable_widgets()
 
     def machine_combo_changed_cb(self, combo, handler):
         mach = combo.get_active_text()
-	if mach != self.curr_mach:
-	    self.curr_mach = mach
+        if mach != self.curr_mach:
+            self.curr_mach = mach
+            # Flush this straight to the file as MACHINE is changed
+            # independently of other 'Preferences'
+            self.configurator.setLocalConfVar('MACHINE', mach)
+            self.configurator.writeLocalConf()
             handler.set_machine(mach)
+            handler.reload_data()
 
     def update_machines(self, handler, machines):
-	active = 0
-	for machine in machines:
-	    self.machine_combo.append_text(machine)
-	    if machine == self.curr_mach:
+        active = 0
+        # disconnect the signal handler before updating the combo model
+        if self.machine_handler_id:
+            self.machine_combo.disconnect(self.machine_handler_id)
+            self.machine_handler_id = None
+
+        model = self.machine_combo.get_model()
+        if model:
+            model.clear()
+
+        for machine in machines:
+            self.machine_combo.append_text(machine)
+            if machine == self.curr_mach:
                 self.machine_combo.set_active(active)
-	    active = active + 1
-	self.machine_combo.connect("changed", self.machine_combo_changed_cb, handler)
-
-    def update_distros(self, handler, distros):
-        # FIXME: when we add UI for changing distro this will be used
-        return
-
-    def data_generated(self, handler):
-        self.generating = False
-
-    def spin_idle_func(self, pbar):
+            active = active + 1
+
+        self.machine_handler_id = self.machine_combo.connect("changed", self.machine_combo_changed_cb, handler)
+
+    def set_busy_cursor(self, busy=True):
+        """
+        Convenience method to set the cursor to a spinner when executing
+        a potentially lengthy process.
+        A busy value of False will set the cursor back to the default
+        left pointer.
+        """
+        if busy:
+            cursor = gtk.gdk.Cursor(gtk.gdk.WATCH)
+        else:
+            # TODO: presumably the default cursor is different on RTL
+            # systems. Can we determine the default cursor? Or at least
+            # the cursor which is set before we change it?
+            cursor = gtk.gdk.Cursor(gtk.gdk.LEFT_PTR)
+        window = self.get_root_window()
+        window.set_cursor(cursor)
+
+    def busy_idle_func(self):
         if self.generating:
-            pbar.pulse()
+            self.progress.set_text("Loading...")
+            self.progress.pulse()
             return True
         else:
-            pbar.hide()
+            if not self.image_combo_id:
+                self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+            self.progress.set_text("Loaded")
+            self.progress.set_fraction(0.0)
+            self.set_busy_cursor(False)
             return False
 
     def busy(self, handler):
         self.generating = True
-        pbar = ProgressBar(self)
-        pbar.connect("delete-event", gtk.main_quit) # NOTE: questionable...
-        pbar.pulse()
-        gobject.timeout_add (200,
-                             self.spin_idle_func,
-                             pbar)
+        self.set_busy_cursor()
+        if self.image_combo_id:
+            self.image_combo.disconnect(self.image_combo_id)
+            self.image_combo_id = None
+        self.progress.pulse()
+        gobject.timeout_add (200, self.busy_idle_func)
+        self.disable_widgets()
+
+    def enable_widgets(self):
+        self.menu.set_sensitive(True)
+        self.machine_combo.set_sensitive(True)
+        self.image_combo.set_sensitive(True)
+        self.nb.set_sensitive(True)
+        self.contents_tree.set_sensitive(True)
+
+    def disable_widgets(self):
+        self.menu.set_sensitive(False)
+        self.machine_combo.set_sensitive(False)
+        self.image_combo.set_sensitive(False)
+        self.nb.set_sensitive(False)
+        self.contents_tree.set_sensitive(False)
 
     def update_model(self, model):
-	pkgsaz_model = gtk.TreeModelSort(self.model.packages_model())
+        # We want the packages model to be alphabetised and sortable so create
+        # a TreeModelSort to use in the view
+        pkgsaz_model = gtk.TreeModelSort(self.model.packages_model())
         pkgsaz_model.set_sort_column_id(self.model.COL_NAME, gtk.SORT_ASCENDING)
+        # Unset default sort func so that we only toggle between A-Z and
+        # Z-A sorting
+        pkgsaz_model.set_default_sort_func(None)
         self.pkgsaz_tree.set_model(pkgsaz_model)
 
-        # FIXME: need to implement a custom sort function, as otherwise the column
-        # is re-ordered when toggling the inclusion state (COL_INC)
-	pkgsgrp_model = gtk.TreeModelSort(self.model.packages_model())
-	pkgsgrp_model.set_sort_column_id(self.model.COL_GROUP, gtk.SORT_ASCENDING)
-	self.pkgsgrp_tree.set_model(pkgsgrp_model)
-
-        self.contents_tree.set_model(self.model.contents_model())
-	self.images_tree.set_model(self.model.images_model())
-	self.tasks_tree.set_model(self.model.tasks_model())
+        # We want the contents to be alphabetised so create a TreeModelSort to
+        # use in the view
+        contents_model = gtk.TreeModelSort(self.model.contents_model())
+        contents_model.set_sort_column_id(self.model.COL_NAME, gtk.SORT_ASCENDING)
+        # Unset default sort func so that we only toggle between A-Z and
+        # Z-A sorting
+        contents_model.set_default_sort_func(None)
+        self.contents_tree.set_model(contents_model)
+        self.tasks_tree.set_model(self.model.tasks_model())
+
+        if self.selected_image:
+            if self.image_combo_id:
+                self.image_combo.disconnect(self.image_combo_id)
+                self.image_combo_id = None
+            self.model.set_selected_image(self.selected_image)
+            self.selected_image = None
+            if not self.image_combo_id:
+                self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+
+        if self.selected_packages:
+            self.model.set_selected_packages(self.selected_packages)
+            self.selected_packages = None
 
     def reset_clicked_cb(self, button):
-        label = gtk.Label("Are you sure you want to reset the image contents?")
-        dialog = gtk.Dialog("Confirm reset", self,
-                            gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
-                            (gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT,
-                             gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
-        dialog.vbox.pack_start(label)
-        label.show()
+        lbl = "<b>Reset your selections?</b>\n\nAny new changes you have made will be lost"
+        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+        dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+        dialog.add_button("Reset", gtk.RESPONSE_OK)
         response = dialog.run()
         dialog.destroy()
-        if (response == gtk.RESPONSE_ACCEPT):
-            self.model.reset()
+        if response == gtk.RESPONSE_OK:
+            self.reset_build()
         return
 
+    def reset_build(self):
+        self.image_combo.disconnect(self.image_combo_id)
+        self.image_combo_id = None
+        self.image_combo.set_active(-1)
+        self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
+        self.model.reset()
+
+    def layers_cb(self, action):
+        resp = self.layers.run()
+        self.layers.save_current_layers()
+        self.layers.hide()
+
+    def add_layer_cb(self, action):
+        self.layers.find_layer(self)
+
+    def preferences_cb(self, action):
+        resp = self.prefs.run()
+        self.prefs.write_changes()
+        self.prefs.hide()
+
+    def about_cb(self, action):
+        about = gtk.AboutDialog()
+        about.set_name("Image Creator")
+        about.set_copyright("Copyright (C) 2011 Intel Corporation")
+        about.set_authors(["Joshua Lock <josh@linux.intel.com>"])
+        about.set_logo_icon_name("applications-development")
+        about.run()
+        about.destroy()
+
+    def save_recipe_file(self):
+        rep = self.model.get_build_rep()
+        rep.writeRecipe(self.save_path)
+        self.dirty = False
+
+    def get_save_path(self):
+        chooser = gtk.FileChooserDialog(title=None, parent=self,
+                                        action=gtk.FILE_CHOOSER_ACTION_SAVE,
+                                        buttons=(gtk.STOCK_CANCEL,
+                                                 gtk.RESPONSE_CANCEL,
+                                                 gtk.STOCK_SAVE,
+                                                 gtk.RESPONSE_OK,))
+        chooser.set_current_name("myimage.bb")
+        response = chooser.run()
+        if response == gtk.RESPONSE_OK:
+            self.save_path = chooser.get_filename()
+        chooser.destroy()
+
+    def save_cb(self, action):
+        if not self.save_path:
+            self.get_save_path()
+        self.save_recipe_file()
+
+    def save_as_cb(self, action):
+        self.get_save_path()
+        self.save_recipe_file()
+
+    def open_cb(self, action):
+        chooser = gtk.FileChooserDialog(title=None, parent=self,
+                                        action=gtk.FILE_CHOOSER_ACTION_OPEN,
+                                        buttons=(gtk.STOCK_CANCEL,
+                                                 gtk.RESPONSE_CANCEL,
+                                                 gtk.STOCK_OPEN,
+                                                 gtk.RESPONSE_OK))
+        response  = chooser.run()
+        rep = BuildRep(None, None, None)
+        if response == gtk.RESPONSE_OK:
+            rep.loadRecipe(chooser.get_filename())
+        chooser.destroy()
+        self.model.load_image_rep(rep)
+        self.dirty = False
+
     def bake_clicked_cb(self, button):
-        if not self.model.targets_contains_image():
-            label = gtk.Label("No image was selected. Just build the selected packages?")
-            dialog = gtk.Dialog("Warning, no image selected",
-                                self,
-                                gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
-                                (gtk.STOCK_NO, gtk.RESPONSE_NO,
-                                 gtk.STOCK_YES, gtk.RESPONSE_YES))
-            dialog.vbox.pack_start(label)
-            label.show()
+        rep = self.model.get_build_rep()
+        if not rep.base_image:
+            lbl = "<b>Build only packages?</b>\n\nAn image has not been selected, so only the selected packages will be built."
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+            dialog.add_button("Build", gtk.RESPONSE_YES)
             response = dialog.run()
             dialog.destroy()
-            if not response == gtk.RESPONSE_YES:
+            if response == gtk.RESPONSE_CANCEL:
                 return
-
-        # Note: We could "squash" the targets list to only include things not brought in by an image
-	task_list = self.model.get_targets()
-	if len(task_list):
-	    tasks = " ".join(task_list)
-            # TODO: show a confirmation dialog
-            print("Including these extra tasks in IMAGE_INSTALL: %s" % tasks)
         else:
-            return
-
+            # TODO: show a confirmation dialog ?
+            if not self.save_path:
+                import tempfile, datetime
+                image_name = "hob-%s-variant-%s.bb" % (rep.base_image, datetime.date.today().isoformat())
+                image_dir = os.path.join(tempfile.gettempdir(), 'hob-images')
+                bb.utils.mkdirhier(image_dir)
+                recipepath =  os.path.join(image_dir, image_name)
+            else:
+                recipepath = self.save_path
+
+            rep.writeRecipe(recipepath)
+            # In the case where we saved the file for the purpose of building
+            # it we should then delete it so that the users workspace doesn't
+            # contain files they haven't explicitly saved there.
+            if not self.save_path:
+                self.files_to_clean.append(recipepath)
+
+            self.handler.queue_image_recipe_path(recipepath)
+
+        self.handler.build_packages(rep.allpkgs.split(" "))
         self.nb.set_current_page(1)
-        self.handler.run_build(task_list)
 
-        return
+    def back_button_clicked_cb(self, button):
+        self.toggle_createview()
 
-    def advanced_expander_cb(self, expander, param):
-        return
-
-    def images(self):
-        self.images_tree = gtk.TreeView()
-	self.images_tree.set_headers_visible(True)
-        self.images_tree.set_headers_clickable(False)
-        self.images_tree.set_enable_search(True)
-        self.images_tree.set_search_column(0)
-        self.images_tree.get_selection().set_mode(gtk.SELECTION_NONE)
+    def toggle_createview(self):
+        self.build.model.clear()
+        self.nb.set_current_page(0)
 
-        col = gtk.TreeViewColumn('Package')
-        col1 = gtk.TreeViewColumn('Description')
-        col2 = gtk.TreeViewColumn('License')
-        col3 = gtk.TreeViewColumn('Include')
-	col3.set_resizable(False)
+    def build_complete_cb(self, running_build):
+        self.back.connect("clicked", self.back_button_clicked_cb)
+        self.back.set_sensitive(True)
+        self.cancel.set_sensitive(False)
+        for f in self.files_to_clean:
+            os.remove(f)
 
-        self.images_tree.append_column(col)
-        self.images_tree.append_column(col1)
-        self.images_tree.append_column(col2)
-        self.images_tree.append_column(col3)
+        lbl = "<b>Build completed</b>\n\nClick OK to start another build or Cancel to view the build log."
+        if self.handler.building == "image":
+            deploy = self.handler.get_image_deploy_dir()
+            lbl = lbl + "\n<a href=\"file://%s\" title=\"%s\">Browse folder of built images</a>." % (deploy, deploy)
 
-        cell = gtk.CellRendererText()
-        cell1 = gtk.CellRendererText()
-        cell2 = gtk.CellRendererText()
-        cell3 = gtk.CellRendererToggle()
-        cell3.set_property('activatable', True)
-        cell3.connect("toggled", self.toggle_include_cb, self.images_tree)
-
-        col.pack_start(cell, True)
-        col1.pack_start(cell1, True)
-        col2.pack_start(cell2, True)
-        col3.pack_start(cell3, True)
-
-        col.set_attributes(cell, text=self.model.COL_NAME)
-        col1.set_attributes(cell1, text=self.model.COL_DESC)
-        col2.set_attributes(cell2, text=self.model.COL_LIC)
-        col3.set_attributes(cell3, active=self.model.COL_INC)
-
-        self.images_tree.show()
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(self.images_tree)
-
-        return scroll
+        dialog = CrumbsDialog(self, lbl)
+        dialog.add_button("View Log", gtk.RESPONSE_CANCEL)
+        dialog.add_button("Edit Image", gtk.RESPONSE_OK)
+        response = dialog.run()
+        dialog.destroy()
+        if response == gtk.RESPONSE_OK:
+            self.toggle_createview()
+
+    def build_started_cb(self, running_build):
+        self.back.set_sensitive(False)
+        self.cancel.set_sensitive(True)
+
+    def include_gplv3_cb(self, toggle):
+        excluded = toggle.get_active()
+        self.handler.toggle_gplv3(excluded)
+
+    def change_bb_threads(self, spinner):
+        val = spinner.get_value_as_int()
+        self.handler.set_bbthreads(val)
+
+    def change_make_threads(self, spinner):
+        val = spinner.get_value_as_int()
+        self.handler.set_pmake(val)
+
+    def toggle_toolchain(self, check):
+        enabled = check.get_active()
+        self.handler.toggle_toolchain(enabled)
+
+    def toggle_headers(self, check):
+        enabled = check.get_active()
+        self.handler.toggle_toolchain_headers(enabled)
+
+    def toggle_package_idle_cb(self, opath, image):
+        """
+        As the operations which we're calling on the model can take
+        a significant amount of time (in the order of seconds) during which
+        the GUI is unresponsive as the main loop is blocked perform them in
+        an idle function which at least enables us to set the busy cursor
+        before the UI is blocked giving the appearance of being responsive.
+        """
+        # Whether the item is currently included
+        inc = self.model[opath][self.model.COL_INC]
+        # If the item is already included, mark it for removal then
+        # the sweep_up() method finds affected items and marks them
+        # appropriately
+        if inc:
+            self.model.mark(opath)
+            self.model.sweep_up()
+        # If the item isn't included, mark it for inclusion
+        else:
+            self.model.include_item(item_path=opath,
+                                    binb="User Selected",
+                                    image_contents=image)
+
+        self.set_busy_cursor(False)
+        return False
+
+    def toggle_package(self, path, model, image=False):
+        # Warn user before removing packages
+        inc = model[path][self.model.COL_INC]
+        if inc:
+            pn = model[path][self.model.COL_NAME]
+            revdeps = self.model.find_reverse_depends(pn)
+            if len(revdeps):
+                lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone and all packages which depend on this will be removed\nPackages which depend on %s include %s." % (pn, pn, ", ".join(revdeps).rstrip(","))
+            else:
+                lbl = "<b>Remove %s?</b>\n\nThis action cannot be undone." % pn
+            dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+            dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+            dialog.add_button("Remove", gtk.RESPONSE_OK)
+            response = dialog.run()
+            dialog.destroy()
+            if response == gtk.RESPONSE_CANCEL:
+                return
 
-    def toggle_package(self, path, model):
+        self.set_busy_cursor()
         # Convert path to path in original model
         opath = model.convert_path_to_child_path(path)
-        # current include status
-	inc = self.model[opath][self.model.COL_INC]
-	if inc:
-	    self.model.mark(opath)
-            self.model.sweep_up()
-	    #self.model.remove_package_full(cpath)
-	else:
-	    self.model.include_item(opath)
-        return
+        # This is a potentially length call which can block the
+        # main loop, therefore do the work in an idle func to keep
+        # the UI responsive
+        glib.idle_add(self.toggle_package_idle_cb, opath, image)
 
-    def remove_package_cb(self, cell, path):
-        model = self.model.contents_model()
-        label = gtk.Label("Are you sure you want to remove this item?")
-        dialog = gtk.Dialog("Confirm removal", self,
-                            gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
-                            (gtk.STOCK_CANCEL, gtk.RESPONSE_REJECT,
-                             gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
-        dialog.vbox.pack_start(label)
-        label.show()
-        response = dialog.run()
-        dialog.destroy()
-        if (response == gtk.RESPONSE_ACCEPT):
-            self.toggle_package(path, model)
+        self.dirty = True
 
     def toggle_include_cb(self, cell, path, tv):
         model = tv.get_model()
@@ -262,23 +499,36 @@ class MainWindow (gtk.Window):
         sort_model = tv.get_model()
         cpath = sort_model.convert_path_to_child_path(path)
         self.toggle_package(cpath, sort_model.get_model())
-	
+
     def pkgsaz(self):
+        vbox = gtk.VBox(False, 6)
+        vbox.show()
         self.pkgsaz_tree = gtk.TreeView()
         self.pkgsaz_tree.set_headers_visible(True)
         self.pkgsaz_tree.set_headers_clickable(True)
         self.pkgsaz_tree.set_enable_search(True)
         self.pkgsaz_tree.set_search_column(0)
-        self.pkgsaz_tree.get_selection().set_mode(gtk.SELECTION_NONE)
+        self.pkgsaz_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
 
         col = gtk.TreeViewColumn('Package')
+        col.set_clickable(True)
+        col.set_sort_column_id(self.model.COL_NAME)
+        col.set_min_width(220)
         col1 = gtk.TreeViewColumn('Description')
-	col1.set_resizable(True)
+        col1.set_resizable(True)
+        col1.set_min_width(360)
         col2 = gtk.TreeViewColumn('License')
-	col2.set_resizable(True)
+        col2.set_resizable(True)
+        col2.set_clickable(True)
+        col2.set_sort_column_id(self.model.COL_LIC)
+        col2.set_min_width(170)
         col3 = gtk.TreeViewColumn('Group')
-        col4 = gtk.TreeViewColumn('Include')
-	col4.set_resizable(False)
+        col3.set_clickable(True)
+        col3.set_sort_column_id(self.model.COL_GROUP)
+        col4 = gtk.TreeViewColumn('Included')
+        col4.set_min_width(80)
+        col4.set_max_width(90)
+        col4.set_sort_column_id(self.model.COL_INC)
 
         self.pkgsaz_tree.append_column(col)
         self.pkgsaz_tree.append_column(col1)
@@ -288,9 +538,9 @@ class MainWindow (gtk.Window):
 
         cell = gtk.CellRendererText()
         cell1 = gtk.CellRendererText()
-	cell1.set_property('width-chars', 20)
+        cell1.set_property('width-chars', 20)
         cell2 = gtk.CellRendererText()
-	cell2.set_property('width-chars', 20)
+        cell2.set_property('width-chars', 20)
         cell3 = gtk.CellRendererText()
         cell4 = gtk.CellRendererToggle()
         cell4.set_property('activatable', True)
@@ -300,7 +550,7 @@ class MainWindow (gtk.Window):
         col1.pack_start(cell1, True)
         col2.pack_start(cell2, True)
         col3.pack_start(cell3, True)
-        col4.pack_start(cell4, True)
+        col4.pack_end(cell4, True)
 
         col.set_attributes(cell, text=self.model.COL_NAME)
         col1.set_attributes(cell1, text=self.model.COL_DESC)
@@ -314,75 +564,43 @@ class MainWindow (gtk.Window):
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         scroll.set_shadow_type(gtk.SHADOW_IN)
         scroll.add(self.pkgsaz_tree)
+        vbox.pack_start(scroll, True, True, 0)
+
+        hb = gtk.HBox(False, 0)
+        hb.show()
+        search = gtk.Entry()
+        search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, "gtk-clear")
+        search.connect("icon-release", self.search_entry_clear_cb)
+        search.show()
+        self.pkgsaz_tree.set_search_entry(search)
+        hb.pack_end(search, False, False, 0)
+        label = gtk.Label("Search packages:")
+        label.show()
+        hb.pack_end(label, False, False, 6)
+        vbox.pack_start(hb, False, False, 0)
 
-        return scroll
-
-    def pkgsgrp(self):
-        self.pkgsgrp_tree = gtk.TreeView()
-        self.pkgsgrp_tree.set_headers_visible(True)
-        self.pkgsgrp_tree.set_headers_clickable(False)
-        self.pkgsgrp_tree.set_enable_search(True)
-        self.pkgsgrp_tree.set_search_column(0)
-        self.pkgsgrp_tree.get_selection().set_mode(gtk.SELECTION_NONE)
-
-        col = gtk.TreeViewColumn('Package')
-        col1 = gtk.TreeViewColumn('Description')
-	col1.set_resizable(True)
-        col2 = gtk.TreeViewColumn('License')
-	col2.set_resizable(True)
-        col3 = gtk.TreeViewColumn('Group')
-        col4 = gtk.TreeViewColumn('Include')
-	col4.set_resizable(False)
-
-        self.pkgsgrp_tree.append_column(col)
-        self.pkgsgrp_tree.append_column(col1)
-        self.pkgsgrp_tree.append_column(col2)
-        self.pkgsgrp_tree.append_column(col3)
-        self.pkgsgrp_tree.append_column(col4)
-
-        cell = gtk.CellRendererText()
-        cell1 = gtk.CellRendererText()
-	cell1.set_property('width-chars', 20)
-        cell2 = gtk.CellRendererText()
-	cell2.set_property('width-chars', 20)
-        cell3 = gtk.CellRendererText()
-        cell4 = gtk.CellRendererToggle()
-        cell4.set_property("activatable", True)
-        cell4.connect("toggled", self.toggle_pkg_include_cb, self.pkgsgrp_tree)
-
-        col.pack_start(cell, True)
-        col1.pack_start(cell1, True)
-        col2.pack_start(cell2, True)
-        col3.pack_start(cell3, True)
-        col4.pack_start(cell4, True)
-
-        col.set_attributes(cell, text=self.model.COL_NAME)
-        col1.set_attributes(cell1, text=self.model.COL_DESC)
-        col2.set_attributes(cell2, text=self.model.COL_LIC)
-        col3.set_attributes(cell3, text=self.model.COL_GROUP)
-        col4.set_attributes(cell4, active=self.model.COL_INC)
-
-        self.pkgsgrp_tree.show()
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(self.pkgsgrp_tree)
+        return vbox
 
-        return scroll
+    def search_entry_clear_cb(self, entry, icon_pos, event):
+        entry.set_text("")
 
     def tasks(self):
+        vbox = gtk.VBox(False, 6)
+        vbox.show()
         self.tasks_tree = gtk.TreeView()
         self.tasks_tree.set_headers_visible(True)
         self.tasks_tree.set_headers_clickable(False)
         self.tasks_tree.set_enable_search(True)
         self.tasks_tree.set_search_column(0)
-        self.tasks_tree.get_selection().set_mode(gtk.SELECTION_NONE)
+        self.tasks_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
 
         col = gtk.TreeViewColumn('Package')
+        col.set_min_width(430)
         col1 = gtk.TreeViewColumn('Description')
+        col1.set_min_width(430)
         col2 = gtk.TreeViewColumn('Include')
-	col2.set_resizable(False)
+        col2.set_min_width(70)
+        col2.set_max_width(80)
 
         self.tasks_tree.append_column(col)
         self.tasks_tree.append_column(col1)
@@ -396,7 +614,7 @@ class MainWindow (gtk.Window):
 
         col.pack_start(cell, True)
         col1.pack_start(cell1, True)
-        col2.pack_start(cell2, True)
+        col2.pack_end(cell2, True)
 
         col.set_attributes(cell, text=self.model.COL_NAME)
         col1.set_attributes(cell1, text=self.model.COL_DESC)
@@ -408,26 +626,37 @@ class MainWindow (gtk.Window):
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         scroll.set_shadow_type(gtk.SHADOW_IN)
         scroll.add(self.tasks_tree)
+        vbox.pack_start(scroll, True, True, 0)
+
+        hb = gtk.HBox(False, 0)
+        hb.show()
+        search = gtk.Entry()
+        search.show()
+        self.tasks_tree.set_search_entry(search)
+        hb.pack_end(search, False, False, 0)
+        label = gtk.Label("Search collections:")
+        label.show()
+        hb.pack_end(label, False, False, 6)
+        vbox.pack_start(hb, False, False, 0)
 
-        return scroll
+        return vbox
 
     def cancel_build(self, button):
-        label = gtk.Label("Do you really want to stop this build?")
-        dialog = gtk.Dialog("Cancel build",
-                            self,
-                            gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
-                            (gtk.STOCK_NO, gtk.RESPONSE_NO,
-                             gtk.STOCK_YES, gtk.RESPONSE_YES))
-        dialog.vbox.pack_start(label)
-        label.show()
+        lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this build?"
+        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
+        dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
+        dialog.add_button("Stop", gtk.RESPONSE_OK)
+        dialog.add_button("Force Stop", gtk.RESPONSE_YES)
         response = dialog.run()
         dialog.destroy()
-        if response == gtk.RESPONSE_YES:
+        if response == gtk.RESPONSE_OK:
             self.handler.cancel_build()
-        return
+        elif response == gtk.RESPONSE_YES:
+            self.handler.cancel_build(True)
 
     def view_build_gui(self):
-        vbox = gtk.VBox(False, 6)
+        vbox = gtk.VBox(False, 12)
+        vbox.set_border_width(6)
         vbox.show()
         build_tv = RunningBuildTreeView()
         build_tv.show()
@@ -438,20 +667,74 @@ class MainWindow (gtk.Window):
         scrolled_view.add(build_tv)
         scrolled_view.show()
         vbox.pack_start(scrolled_view, expand=True, fill=True)
-        hbox = gtk.HBox(False, 6)
+        hbox = gtk.HBox(False, 12)
         hbox.show()
         vbox.pack_start(hbox, expand=False, fill=False)
-        cancel = gtk.Button(stock=gtk.STOCK_CANCEL)
-        cancel.connect("clicked", self.cancel_build)
-        cancel.show()
-        hbox.pack_end(cancel, expand=False, fill=False)
+        self.back = gtk.Button("Back")
+        self.back.show()
+        self.back.set_sensitive(False)
+        hbox.pack_start(self.back, expand=False, fill=False)
+        self.cancel = gtk.Button("Stop Build")
+        self.cancel.connect("clicked", self.cancel_build)
+        self.cancel.show()
+        hbox.pack_end(self.cancel, expand=False, fill=False)
 
         return vbox
+
+    def create_menu(self):
+        menu_items = '''<ui>
+        <menubar name="MenuBar">
+          <menu action="File">
+            <menuitem action="Save"/>
+            <menuitem action="Save As"/>
+            <menuitem action="Open"/>
+            <separator/>
+            <menuitem action="AddLayer" label="Add Layer"/>
+            <separator/>
+            <menuitem action="Quit"/>
+          </menu>
+          <menu action="Edit">
+            <menuitem action="Layers" label="Layers"/>
+            <menuitem action="Preferences"/>
+          </menu>
+          <menu action="Help">
+            <menuitem action="About"/>
+          </menu>
+        </menubar>
+        </ui>'''
+
+        uimanager = gtk.UIManager()
+        accel = uimanager.get_accel_group()
+        self.add_accel_group(accel)
+
+        actions = gtk.ActionGroup('ImageCreator')
+        self.actions = actions
+        actions.add_actions([('Quit', gtk.STOCK_QUIT, None, None,
+                              None, self.menu_quit,),
+                             ('File', None, '_File'),
+                             ('Save', gtk.STOCK_SAVE, None, None, None, self.save_cb),
+                             ('Save As', gtk.STOCK_SAVE_AS, None, None, None, self.save_as_cb),
+                             ('Open', gtk.STOCK_OPEN, None, None, None, self.open_cb),
+                             ('AddLayer', None, 'Add Layer', None, None, self.add_layer_cb),
+                             ('Edit', None, '_Edit'),
+                             ('Help', None, '_Help'),
+                             ('Layers', None, 'Layers', None, None, self.layers_cb),
+                             ('Preferences', gtk.STOCK_PREFERENCES, None, None, None, self.preferences_cb),
+                             ('About', gtk.STOCK_ABOUT, None, None, None, self.about_cb)])
+        uimanager.insert_action_group(actions, 0)
+        uimanager.add_ui_from_string(menu_items)
+
+        menubar = uimanager.get_widget('/MenuBar')
+        menubar.show_all()
+
+        return menubar
     
     def create_build_gui(self):
-        vbox = gtk.VBox(False, 6)
+        vbox = gtk.VBox(False, 12)
+        vbox.set_border_width(6)
         vbox.show()
-        hbox = gtk.HBox(False, 6)
+        
+        hbox = gtk.HBox(False, 12)
         hbox.show()
         vbox.pack_start(hbox, expand=False, fill=False)
 
@@ -459,90 +742,92 @@ class MainWindow (gtk.Window):
         label.show()
         hbox.pack_start(label, expand=False, fill=False, padding=6)
         self.machine_combo = gtk.combo_box_new_text()
-	self.machine_combo.set_active(0)
         self.machine_combo.show()
         self.machine_combo.set_tooltip_text("Selects the architecture of the target board for which you would like to build an image.")
         hbox.pack_start(self.machine_combo, expand=False, fill=False, padding=6)
+        label = gtk.Label("Base image:")
+        label.show()
+        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        self.image_combo = gtk.ComboBox()
+        self.image_combo.show()
+        self.image_combo.set_tooltip_text("Selects the image on which to base the created image")
+        image_combo_cell = gtk.CellRendererText()
+        self.image_combo.pack_start(image_combo_cell, True)
+        self.image_combo.add_attribute(image_combo_cell, 'text', self.model.COL_NAME)
+        hbox.pack_start(self.image_combo, expand=False, fill=False, padding=6)
+        self.progress = gtk.ProgressBar()
+        self.progress.set_size_request(250, -1)
+        hbox.pack_end(self.progress, expand=False, fill=False, padding=6)
 
         ins = gtk.Notebook()
         vbox.pack_start(ins, expand=True, fill=True)
         ins.set_show_tabs(True)
-        label = gtk.Label("Images")
+        label = gtk.Label("Packages")
         label.show()
-        ins.append_page(self.images(), tab_label=label)
-        label = gtk.Label("Tasks")
+        ins.append_page(self.pkgsaz(), tab_label=label)
+        label = gtk.Label("Package Collections")
         label.show()
         ins.append_page(self.tasks(), tab_label=label)
-        label = gtk.Label("Packages (by Group)")
-        label.show()
-        ins.append_page(self.pkgsgrp(), tab_label=label)
-        label = gtk.Label("Packages (by Name)")
-        label.show()
-        ins.append_page(self.pkgsaz(), tab_label=label)
         ins.set_current_page(0)
         ins.show_all()
 
-        hbox = gtk.HBox()
-        hbox.show()
-        vbox.pack_start(hbox, expand=False, fill=False)
         label = gtk.Label("Image contents:")
+        self.model.connect("contents-changed", self.update_package_count_cb, label)
+        label.set_property("xalign", 0.00)
         label.show()
-        hbox.pack_start(label, expand=False, fill=False, padding=6)
+        vbox.pack_start(label, expand=False, fill=False, padding=6)
         con = self.contents()
         con.show()
         vbox.pack_start(con, expand=True, fill=True)
 
-        #advanced = gtk.Expander(label="Advanced")
-        #advanced.connect("notify::expanded", self.advanced_expander_cb)
-        #advanced.show()
-        #vbox.pack_start(advanced, expand=False, fill=False)
-
-        hbox = gtk.HBox()
-        hbox.show()
-        vbox.pack_start(hbox, expand=False, fill=False)
-        bake = gtk.Button("Bake")
-        bake.connect("clicked", self.bake_clicked_cb)
-        bake.show()
-        hbox.pack_end(bake, expand=False, fill=False, padding=6)
+        bbox = gtk.HButtonBox()
+        bbox.set_spacing(12)
+        bbox.set_layout(gtk.BUTTONBOX_END)
+        bbox.show()
+        vbox.pack_start(bbox, expand=False, fill=False)
         reset = gtk.Button("Reset")
         reset.connect("clicked", self.reset_clicked_cb)
         reset.show()
-        hbox.pack_end(reset, expand=False, fill=False, padding=6)
+        bbox.add(reset)
+        bake = gtk.Button("Bake")
+        bake.connect("clicked", self.bake_clicked_cb)
+        bake.show()
+        bbox.add(bake)
 
         return vbox
 
+    def update_package_count_cb(self, model, count, label):
+        lbl = "Image contents (%s packages):" % count
+        label.set_text(lbl)
+
     def contents(self):
         self.contents_tree = gtk.TreeView()
         self.contents_tree.set_headers_visible(True)
-        self.contents_tree.get_selection().set_mode(gtk.SELECTION_NONE)
+        self.contents_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
 
         # allow searching in the package column
         self.contents_tree.set_search_column(0)
+        self.contents_tree.set_enable_search(True)
 
         col = gtk.TreeViewColumn('Package')
-	col.set_sort_column_id(0)
+        col.set_sort_column_id(0)
+        col.set_min_width(430)
         col1 = gtk.TreeViewColumn('Brought in by')
-	col1.set_resizable(True)
-        col2 = gtk.TreeViewColumn('Remove')
-	col2.set_expand(False)
+        col1.set_resizable(True)
+        col1.set_min_width(430)
 
         self.contents_tree.append_column(col)
         self.contents_tree.append_column(col1)
-        self.contents_tree.append_column(col2)
 
         cell = gtk.CellRendererText()
         cell1 = gtk.CellRendererText()
-	cell1.set_property('width-chars', 20)
-        cell2 = gtk.CellRendererToggle()
-        cell2.connect("toggled", self.remove_package_cb)
+        cell1.set_property('width-chars', 20)
 
         col.pack_start(cell, True)
         col1.pack_start(cell1, True)
-        col2.pack_start(cell2, True)
 
         col.set_attributes(cell, text=self.model.COL_NAME)
         col1.set_attributes(cell1, text=self.model.COL_BINB)
-        col2.set_attributes(cell2, active=self.model.COL_INC)
 
         self.contents_tree.show()
 
@@ -554,26 +839,67 @@ class MainWindow (gtk.Window):
         return scroll
 
 def main (server, eventHandler):
+    import multiprocessing
+    cpu_cnt = multiprocessing.cpu_count()
+
     gobject.threads_init()
 
     taskmodel = TaskListModel()
+    configurator = Configurator()
     handler = HobHandler(taskmodel, server)
     mach = server.runCommand(["getVariable", "MACHINE"])
+    sdk_mach = server.runCommand(["getVariable", "SDKMACHINE"])
+    # If SDKMACHINE not set the default SDK_ARCH is used so we
+    # should represent that in the GUI
+    if not sdk_mach:
+        sdk_mach = server.runCommand(["getVariable", "SDK_ARCH"])
     distro = server.runCommand(["getVariable", "DISTRO"])
-
-    window = MainWindow(taskmodel, handler, mach, distro)
+    bbthread = server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
+    if not bbthread:
+        bbthread = cpu_cnt
+        handler.set_bbthreads(cpu_cnt)
+    else:
+        bbthread = int(bbthread)
+    pmake = server.runCommand(["getVariable", "PARALLEL_MAKE"])
+    if not pmake:
+        pmake = cpu_cnt
+        handler.set_pmake(cpu_cnt)
+    else:
+        # The PARALLEL_MAKE variable will be of the format: "-j 3" and we only
+        # want a number for the spinner, so strip everything from the variable
+        # up to and including the space
+        pmake = int(pmake[pmake.find(" ")+1:])
+
+    image_types = server.runCommand(["getVariable", "IMAGE_TYPES"])
+
+    pclasses = server.runCommand(["getVariable", "PACKAGE_CLASSES"]).split(" ")
+    # NOTE: we're only supporting one value for PACKAGE_CLASSES being set
+    # this seems OK because we're using the first package format set in
+    # PACKAGE_CLASSES and that's the package manager used for the rootfs
+    pkg, sep, pclass = pclasses[0].rpartition("_")
+
+    prefs = HobPrefs(configurator, handler, sdk_mach, distro, pclass, cpu_cnt,
+                     pmake, bbthread, image_types)
+    layers = LayerEditor(configurator, None)
+    window = MainWindow(taskmodel, handler, configurator, prefs, layers, mach)
+    prefs.set_parent_window(window)
+    layers.set_parent_window(window)
     window.show_all ()
     handler.connect("machines-updated", window.update_machines)
-    handler.connect("distros-updated", window.update_distros)
+    handler.connect("sdk-machines-updated", prefs.update_sdk_machines)
+    handler.connect("distros-updated", prefs.update_distros)
+    handler.connect("package-formats-found", prefs.update_package_formats)
     handler.connect("generating-data", window.busy)
     handler.connect("data-generated", window.data_generated)
-    pbar = ProgressBar(window)
-    pbar.connect("delete-event", gtk.main_quit)
+    handler.connect("reload-triggered", window.reload_triggered_cb)
+    configurator.connect("layers-loaded", layers.load_current_layers)
+    configurator.connect("layers-changed", handler.reload_data)
+    handler.connect("config-found", configurator.configFound)
 
     try:
         # kick the while thing off
-        handler.current_command = "findConfigFilesDistro"
-        server.runCommand(["findConfigFiles", "DISTRO"])
+        handler.current_command = "findConfigFilePathLocal"
+        server.runCommand(["findConfigFilePath", "local.conf"])
     except xmlrpclib.Fault:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return 1
@@ -584,7 +910,7 @@ def main (server, eventHandler):
                          handler.event_handle_idle_func,
                          eventHandler,
                          window.build,
-                         pbar)
+                         window.progress)
 
     try:
         gtk.main()
-- 
1.7.5.4



