Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 26CDB76A5F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:20:29 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2015 06:20:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,709,1432623600"; d="scan'208";a="751523666"
Received: from mclawlor-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.12.193])
	by orsmga001.jf.intel.com with ESMTP; 19 Aug 2015 06:20:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:20:10 +0100
Message-Id: <f16c02c81fe76b172405e3a6c67e18e735bf4b84.1439990327.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-layers: fix mapping files to layers
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Aug 2015 13:20:29 -0000

bitbake-layers needs to map recipe and class files to the layer they
came from within the show-recipes and show-overlayed commands. However,
it turns out that mapping a file to the layer it came from is not as
trivial as it might seem. To do it properly we need to match the path to
an entry in BBFILES then map that to the collection name using
BBFILE_PATTERN, then map that to the actual layer using variable
history. If it doesn't match any entry in BBFILES, then we can fall back
to BBFILE_PATTERN (to handle classes and conf files).

This fixes the layer name not showing up properly in the output of the
show-recipes and show-overlayed commands for recipes in layers such as
meta-intel that have subdirectories in BBFILE_PATTERN. It also fixes the
priority not showing up in show-layers for such layers.

As part of this I've added a function to VariableHistory which for a
space-separated list variable gives you a dict mapping the items added
to the files in which they were added. I've also fixed
bb.utils.get_file_layer() and reduced some of the duplication by using
this function in bitbake-layers. Also fixes the priority not showing up
for layers such as meta-intel

Fixes [YOCTO #8160].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers   | 37 ++++++++++++++++---------------------
 lib/bb/data_smart.py | 25 +++++++++++++++++++++++++
 lib/bb/utils.py      | 32 ++++++++++++++++++++++++--------
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 1b4694b..df22781 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -62,24 +62,22 @@ class Commands():
 
     def init_bbhandler(self, config_only = False):
         if not self.bbhandler:
-            self.bbhandler = bb.tinfoil.Tinfoil()
+            self.bbhandler = bb.tinfoil.Tinfoil(tracking=True)
             self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
             self.bbhandler.prepare(config_only)
+            layerconfs = self.bbhandler.config_data.varhistory.get_variable_items_files('BBFILE_COLLECTIONS', self.bbhandler.config_data)
+            self.bbfile_collections = {layer: os.path.dirname(os.path.dirname(path)) for layer, path in layerconfs.iteritems()}
+
 
     def do_show_layers(self, args):
         """show current configured layers"""
         self.init_bbhandler(config_only = True)
         logger.plain("%s  %s  %s" % ("layer".ljust(20), "path".ljust(40), "priority"))
         logger.plain('=' * 74)
-        for layerdir in self.bblayers:
+        for layer, _, regex, pri in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
+            layerdir = self.bbfile_collections.get(layer, None)
             layername = self.get_layer_name(layerdir)
-            layerpri = 0
-            for layer, _, regex, pri in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
-                if regex.match(os.path.join(layerdir, 'test')):
-                    layerpri = pri
-                    break
-
-            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), layerpri))
+            logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), pri))
 
 
     def do_add_layer(self, args):
@@ -686,25 +684,22 @@ build results (as the layer priority order has effectively changed).
                                 logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
     def get_file_layer(self, filename):
-        for layer, _, regex, _ in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
-            if regex.match(filename):
-                for layerdir in self.bblayers:
-                    if regex.match(os.path.join(layerdir, 'test')) and re.match(layerdir, filename):
-                        return self.get_layer_name(layerdir)
-        return "?"
+        layerdir = self.get_file_layerdir(filename)
+        if layerdir:
+            return self.get_layer_name(layerdir)
+        else:
+            return '?'
 
     def get_file_layerdir(self, filename):
-        for layer, _, regex, _ in self.bbhandler.cooker.recipecache.bbfile_config_priorities:
-            if regex.match(filename):
-                for layerdir in self.bblayers:
-                    if regex.match(os.path.join(layerdir, 'test')) and re.match(layerdir, filename):
-                        return layerdir
-        return "?"
+        layer = bb.utils.get_file_layer(filename, self.bbhandler.config_data)
+        return self.bbfile_collections.get(layer, None)
 
     def remove_layer_prefix(self, f):
         """Remove the layer_dir prefix, e.g., f = /path/to/layer_dir/foo/blah, the
            return value will be: layer_dir/foo/blah"""
         f_layerdir = self.get_file_layerdir(f)
+        if not f_layerdir:
+            return f
         prefix = os.path.join(os.path.dirname(f_layerdir), '')
         return f[len(prefix):] if f.startswith(prefix) else f
 
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 26f69d1..75e22f9 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -312,6 +312,31 @@ class VariableHistory(object):
                 lines.append(line)
         return lines
 
+    def get_variable_items_files(self, var, d):
+        """
+        Use variable history to map items added to a list variable and
+        the files in which they were added.
+        """
+        history = self.variable(var)
+        finalitems = (d.getVar(var, True) or '').split()
+        filemap = {}
+        isset = False
+        for event in history:
+            if 'flag' in event:
+                continue
+            if event['op'] == '_remove':
+                continue
+            if isset and event['op'] == 'set?':
+                continue
+            isset = True
+            items = d.expand(event['detail']).split()
+            for item in items:
+                # This is a little crude but is belt-and-braces to avoid us
+                # having to handle every possible operation type specifically
+                if item in finalitems and not item in filemap:
+                    filemap[item] = event['file']
+        return filemap
+
     def del_var_history(self, var, f=None, line=None):
         """If file f and line are not given, the entire history of var is deleted"""
         if var in self.variables:
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 607ffc5..5b94432 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -29,6 +29,7 @@ import multiprocessing
 import fcntl
 import subprocess
 import glob
+import fnmatch
 import traceback
 import errno
 import signal
@@ -1262,11 +1263,26 @@ def get_file_layer(filename, d):
     for collection in collections:
         collection_res[collection] = d.getVar('BBFILE_PATTERN_%s' % collection, True) or ''
 
-    # Use longest path so we handle nested layers
-    matchlen = 0
-    match = None
-    for collection, regex in collection_res.iteritems():
-        if len(regex) > matchlen and re.match(regex, filename):
-            matchlen = len(regex)
-            match = collection
-    return match
+    def path_to_layer(path):
+        # Use longest path so we handle nested layers
+        matchlen = 0
+        match = None
+        for collection, regex in collection_res.iteritems():
+            if len(regex) > matchlen and re.match(regex, path):
+                matchlen = len(regex)
+                match = collection
+        return match
+
+    result = None
+    bbfiles = (d.getVar('BBFILES', True) or '').split()
+    bbfilesmatch = False
+    for bbfilesentry in bbfiles:
+        if fnmatch.fnmatch(filename, bbfilesentry):
+            bbfilesmatch = True
+            result = path_to_layer(bbfilesentry)
+
+    if not bbfilesmatch:
+        # Probably a bbclass
+        result = path_to_layer(filename)
+
+    return result
-- 
2.1.0


