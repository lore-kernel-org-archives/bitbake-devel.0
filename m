Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T66Mn-0000sM-8g
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 22:57:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 Aug 2012 13:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,322,1344236400"; d="scan'208";a="191985299"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.136])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2012 13:44:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2012 21:44:31 +0100
Message-Id: <926dc523d54066e822b0909df2a0d694e038660d.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/5] tinfoil: create simple interface for bitbake-based utilities
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
X-List-Received-Date: Mon, 27 Aug 2012 20:57:01 -0000

The code to initialise BitBake within bitbake-layers should be useful
for other utilities that need to query configuration or recipe
information, so refactor it out into its own class, "Tinfoil" (to
continue with our cooking metaphor).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |  146 ++++++++++++++------------------------------
 bitbake/lib/bb/tinfoil.py  |   98 +++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 99 deletions(-)
 create mode 100644 bitbake/lib/bb/tinfoil.py

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index f473711..fa4e767 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -6,10 +6,22 @@
 
 # Copyright (C) 2011 Mentor Graphics Corporation
 # Copyright (C) 2012 Intel Corporation
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
 
 import cmd
 import logging
-import warnings
 import os
 import sys
 import fnmatch
@@ -23,26 +35,14 @@ import bb.cache
 import bb.cooker
 import bb.providers
 import bb.utils
-from bb.cooker import state
-import bb.fetch2
+import bb.tinfoil
 
 
 logger = logging.getLogger('BitBake')
 
-warnings.filterwarnings("ignore", category=DeprecationWarning)
 
 def main(args):
-    # Set up logging
-    console = logging.StreamHandler(sys.stdout)
-    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
-    bb.msg.addDefaultlogFilter(console)
-    console.setFormatter(format)
-    logger.addHandler(console)
-
-    initialenv = os.environ.copy()
-    bb.utils.clean_environment()
-
-    cmds = Commands(initialenv)
+    cmds = Commands()
     if args:
         # Allow user to specify e.g. show-layers instead of show_layers
         args = [args[0].replace('-', '_')] + args[1:]
@@ -53,46 +53,11 @@ def main(args):
 
 
 class Commands(cmd.Cmd):
-    def __init__(self, initialenv):
+    def __init__(self):
         cmd.Cmd.__init__(self)
+        self.bbhandler = bb.tinfoil.Tinfoil()
         self.returncode = 0
-        self.config = Config(parse_only=True)
-        self.cooker = bb.cooker.BBCooker(self.config,
-                                         self.register_idle_function,
-                                         initialenv)
-        self.config_data = self.cooker.configuration.data
-        bb.providers.logger.setLevel(logging.ERROR)
-        self.cooker_data = None
-        self.bblayers = (self.config_data.getVar('BBLAYERS', True) or "").split()
-
-    def register_idle_function(self, function, data):
-        pass
-
-    def prepare_cooker(self):
-        sys.stderr.write("Parsing recipes..")
-        logger.setLevel(logging.WARNING)
-
-        try:
-            while self.cooker.state in (state.initial, state.parsing):
-                self.cooker.updateCache()
-        except KeyboardInterrupt:
-            self.cooker.shutdown()
-            self.cooker.updateCache()
-            sys.exit(2)
-
-        logger.setLevel(logging.INFO)
-        sys.stderr.write("done.\n")
-
-        self.cooker_data = self.cooker.status
-        self.cooker_data.appends = self.cooker.appendlist
-
-    def check_prepare_cooker(self, config_only = False):
-        if not self.cooker_data:
-            if config_only:
-                self.cooker.parseConfiguration()
-                self.cooker_data = self.cooker.status
-            else:
-                self.prepare_cooker()
+        self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
 
     def default(self, line):
         """Handle unrecognised commands"""
@@ -117,13 +82,13 @@ class Commands(cmd.Cmd):
 
     def do_show_layers(self, args):
         """show current configured layers"""
-        self.check_prepare_cooker(config_only = True)
+        self.bbhandler.prepare(config_only = True)
         logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
         logger.plain('=' * 74)
         for layerdir in self.bblayers:
             layername = self.get_layer_name(layerdir)
             layerpri = 0
-            for layer, _, regex, pri in self.cooker.status.bbfile_config_priorities:
+            for layer, _, regex, pri in self.bbhandler.cooker.status.bbfile_config_priorities:
                 if regex.match(os.path.join(layerdir, 'test')):
                     layerpri = pri
                     break
@@ -154,7 +119,7 @@ Options:
        recipes with the ones they overlay indented underneath
   -s   only list overlayed recipes where the version is the same
 """
-        self.check_prepare_cooker()
+        self.bbhandler.prepare()
 
         show_filenames = False
         show_same_ver_only = False
@@ -186,7 +151,7 @@ Options:
         # factor - however, each layer.conf is free to either prepend or append to
         # BBPATH (or indeed do crazy stuff with it). Thus the order in BBPATH might
         # not be exactly the order present in bblayers.conf either.
-        bbpath = str(self.config_data.getVar('BBPATH', True))
+        bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
         overlayed_class_found = False
         for (classfile, classdirs) in classes.items():
             if len(classdirs) > 1:
@@ -237,7 +202,7 @@ Options:
   -m   only list where multiple recipes (in the same layer or different
        layers) exist for the same recipe name
 """
-        self.check_prepare_cooker()
+        self.bbhandler.prepare()
 
         show_filenames = False
         show_multi_provider_only = False
@@ -259,15 +224,15 @@ Options:
 
 
     def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only):
-        pkg_pn = self.cooker.status.pkg_pn
-        (latest_versions, preferred_versions) = bb.providers.findProviders(self.cooker.configuration.data, self.cooker.status, pkg_pn)
-        allproviders = bb.providers.allProviders(self.cooker.status)
+        pkg_pn = self.bbhandler.cooker.status.pkg_pn
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.bbhandler.cooker.configuration.data, self.bbhandler.cooker.status, pkg_pn)
+        allproviders = bb.providers.allProviders(self.bbhandler.cooker.status)
 
         # Ensure we list skipped recipes
         # We are largely guessing about PN, PV and the preferred version here,
         # but we have no choice since skipped recipes are not fully parsed
-        skiplist = self.cooker.skiplist.keys()
-        skiplist.sort( key=lambda fileitem: self.cooker.calc_bbfile_priority(fileitem) )
+        skiplist = self.bbhandler.cooker.skiplist.keys()
+        skiplist.sort( key=lambda fileitem: self.bbhandler.cooker.calc_bbfile_priority(fileitem) )
         skiplist.reverse()
         for fn in skiplist:
             recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
@@ -375,7 +340,7 @@ build results (as the layer priority order has effectively changed).
             logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
             return
 
-        self.check_prepare_cooker()
+        self.bbhandler.prepare()
         layers = self.bblayers
         if len(arglist) > 2:
             layernames = arglist[:-1]
@@ -405,8 +370,8 @@ build results (as the layer priority order has effectively changed).
         appended_recipes = []
         for layer in layers:
             overlayed = []
-            for f in self.cooker.overlayed.iterkeys():
-                for of in self.cooker.overlayed[f]:
+            for f in self.bbhandler.cooker.overlayed.iterkeys():
+                for of in self.bbhandler.cooker.overlayed[f]:
                     if of.startswith(layer):
                         overlayed.append(of)
 
@@ -430,8 +395,8 @@ build results (as the layer priority order has effectively changed).
                                     logger.warn('Overwriting file %s', fdest)
                             bb.utils.copyfile(f1full, fdest)
                             if ext == '.bb':
-                                if f1 in self.cooker_data.appends:
-                                    appends = self.cooker_data.appends[f1]
+                                if f1 in self.bbhandler.cooker.appendlist:
+                                    appends = self.bbhandler.cooker.appendlist[f1]
                                     if appends:
                                         logger.plain('  Applying appends to %s' % fdest )
                                         for appendname in appends:
@@ -440,9 +405,9 @@ build results (as the layer priority order has effectively changed).
                                     appended_recipes.append(f1)
 
         # Take care of when some layers are excluded and yet we have included bbappends for those recipes
-        for recipename in self.cooker_data.appends.iterkeys():
+        for recipename in self.bbhandler.cooker.appendlist.iterkeys():
             if recipename not in appended_recipes:
-                appends = self.cooker_data.appends[recipename]
+                appends = self.bbhandler.cooker.appendlist[recipename]
                 first_append = None
                 for appendname in appends:
                     layer = layer_path_match(appendname)
@@ -460,14 +425,14 @@ build results (as the layer priority order has effectively changed).
         # have come from)
         first_regex = None
         layerdir = layers[0]
-        for layername, pattern, regex, _ in self.cooker.status.bbfile_config_priorities:
+        for layername, pattern, regex, _ in self.bbhandler.cooker.status.bbfile_config_priorities:
             if regex.match(os.path.join(layerdir, 'test')):
                 first_regex = regex
                 break
 
         if first_regex:
             # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
-            bbfiles = str(self.config_data.getVar('BBFILES', True)).split()
+            bbfiles = str(self.bbhandler.config_data.getVar('BBFILES', True)).split()
             bbfiles_layer = []
             for item in bbfiles:
                 if first_regex.match(item):
@@ -490,7 +455,7 @@ build results (as the layer priority order has effectively changed).
                                 logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
     def get_file_layer(self, filename):
-        for layer, _, regex, _ in self.cooker.status.bbfile_config_priorities:
+        for layer, _, regex, _ in self.bbhandler.cooker.status.bbfile_config_priorities:
             if regex.match(filename):
                 for layerdir in self.bblayers:
                     if regex.match(os.path.join(layerdir, 'test')):
@@ -516,14 +481,14 @@ usage: show-appends
 
 Recipes are listed with the bbappends that apply to them as subitems.
 """
-        self.check_prepare_cooker()
-        if not self.cooker_data.appends:
+        self.bbhandler.prepare()
+        if not self.bbhandler.cooker.appendlist:
             logger.plain('No append files found')
             return
 
         logger.plain('=== Appended recipes ===')
 
-        pnlist = list(self.cooker_data.pkg_pn.keys())
+        pnlist = list(self.bbhandler.cooker_data.pkg_pn.keys())
         pnlist.sort()
         for pn in pnlist:
             self.show_appends_for_pn(pn)
@@ -531,19 +496,19 @@ Recipes are listed with the bbappends that apply to them as subitems.
         self.show_appends_for_skipped()
 
     def show_appends_for_pn(self, pn):
-        filenames = self.cooker_data.pkg_pn[pn]
+        filenames = self.bbhandler.cooker_data.pkg_pn[pn]
 
         best = bb.providers.findBestProvider(pn,
-                                             self.cooker.configuration.data,
-                                             self.cooker_data,
-                                             self.cooker_data.pkg_pn)
+                                             self.bbhandler.cooker.configuration.data,
+                                             self.bbhandler.cooker_data,
+                                             self.bbhandler.cooker_data.pkg_pn)
         best_filename = os.path.basename(best[3])
 
         self.show_appends_output(filenames, best_filename)
 
     def show_appends_for_skipped(self):
         filenames = [os.path.basename(f)
-                    for f in self.cooker.skiplist.iterkeys()]
+                    for f in self.bbhandler.cooker.skiplist.iterkeys()]
         self.show_appends_output(filenames, None, " (skipped)")
 
     def show_appends_output(self, filenames, best_filename, name_suffix = ''):
@@ -569,7 +534,7 @@ Recipes are listed with the bbappends that apply to them as subitems.
                 continue
 
             basename = os.path.basename(filename)
-            appends = self.cooker_data.appends.get(basename)
+            appends = self.bbhandler.cooker.appendlist.get(basename)
             if appends:
                 appended.append((basename, list(appends)))
             else:
@@ -577,22 +542,5 @@ Recipes are listed with the bbappends that apply to them as subitems.
         return appended, notappended
 
 
-class Config(object):
-    def __init__(self, **options):
-        self.pkgs_to_build = []
-        self.debug_domains = []
-        self.extra_assume_provided = []
-        self.prefile = []
-        self.postfile = []
-        self.debug = 0
-        self.__dict__.update(options)
-
-    def __getattr__(self, attribute):
-        try:
-            return super(Config, self).__getattribute__(attribute)
-        except AttributeError:
-            return None
-
-
 if __name__ == '__main__':
     sys.exit(main(sys.argv[1:]) or 0)
diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
new file mode 100644
index 0000000..73d8fe9
--- /dev/null
+++ b/bitbake/lib/bb/tinfoil.py
@@ -0,0 +1,98 @@
+# tinfoil: a simple wrapper around cooker for bitbake-based command-line utilities
+#
+# Copyright (C) 2012 Intel Corporation
+# Copyright (C) 2011 Mentor Graphics Corporation
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
+import logging
+import warnings
+import os
+import sys
+
+import bb.cache
+import bb.cooker
+import bb.providers
+import bb.utils
+from bb.cooker import state
+import bb.fetch2
+
+class Tinfoil:
+    def __init__(self):
+        # Needed to avoid deprecation warnings with python 2.6
+        warnings.filterwarnings("ignore", category=DeprecationWarning)
+
+        # Set up logging
+        self.logger = logging.getLogger('BitBake')
+        console = logging.StreamHandler(sys.stdout)
+        format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+        bb.msg.addDefaultlogFilter(console)
+        console.setFormatter(format)
+        self.logger.addHandler(console)
+
+        initialenv = os.environ.copy()
+        bb.utils.clean_environment()
+        self.config = TinfoilConfig(parse_only=True)
+        self.cooker = bb.cooker.BBCooker(self.config,
+                                            self.register_idle_function,
+                                            initialenv)
+        self.config_data = self.cooker.configuration.data
+        bb.providers.logger.setLevel(logging.ERROR)
+        self.cooker_data = None
+
+    def register_idle_function(self, function, data):
+        pass
+
+    def parseRecipes(self):
+        sys.stderr.write("Parsing recipes..")
+        self.logger.setLevel(logging.WARNING)
+
+        try:
+            while self.cooker.state in (state.initial, state.parsing):
+                self.cooker.updateCache()
+        except KeyboardInterrupt:
+            self.cooker.shutdown()
+            self.cooker.updateCache()
+            sys.exit(2)
+
+        self.logger.setLevel(logging.INFO)
+        sys.stderr.write("done.\n")
+
+        self.cooker_data = self.cooker.status
+
+    def prepare(self, config_only = False):
+        if not self.cooker_data:
+            if config_only:
+                self.cooker.parseConfiguration()
+                self.cooker_data = self.cooker.status
+            else:
+                self.parseRecipes()
+
+
+class TinfoilConfig(object):
+    def __init__(self, **options):
+        self.pkgs_to_build = []
+        self.debug_domains = []
+        self.extra_assume_provided = []
+        self.prefile = []
+        self.postfile = []
+        self.debug = 0
+        self.__dict__.update(options)
+
+    def __getattr__(self, attribute):
+        try:
+            return super(TinfoilConfig, self).__getattribute__(attribute)
+        except AttributeError:
+            return None
+
-- 
1.7.9.5



