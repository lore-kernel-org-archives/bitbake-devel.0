Return-Path: <Qi.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2FBC873D1F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 08:45:59 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3F8k0Bi026468
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 01:46:01 -0700 (PDT)
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.236) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.224.2; Wed, 15 Apr 2015 01:46:00 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Apr 2015 16:46:05 +0800
Message-ID: <6eae7f31a174bec1873983704d09ebae6614eca6.1429087384.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1429087384.git.Qi.Chen@windriver.com>
References: <cover.1429087384.git.Qi.Chen@windriver.com>
MIME-Version: 1.0
Subject: [PATCH V2 1/1] bitbake-layers: change the behaviour of show-cross-depends
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
X-List-Received-Date: Wed, 15 Apr 2015 08:46:04 -0000
Content-Type: text/plain

Make `bitbake-layers show-cross-depends' only output dependencies that
may potentially cause problems. In other words, if a dependency is in
a required layer of the layer where the target recipe resides, the
dependency is not printed.

Add a new option '-a' (or '--alldeps') to 'show-cross-depends' to maintain
the previous behaviour. In other words, `bitbake-layers show-cross-depends -a'
behaves the same way as the previous `bitbake-layers show-cross-depends'.

The purpose is to make `bitbake-layers show-cross-depends' more useful.
Before this change, with several meta-xxx layers added to bblayer.conf,
this command would output more then 10000 lines of dependencies. Even with
'meta' layer ignored, the output is still about 100 lines.
After this change, this command only shows less than 20 lines of dependencies,
all of which indicate potential errors.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/bin/bitbake-layers | 68 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index c1c65aa..1107e10 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -59,6 +59,8 @@ class Commands():
     def __init__(self):
         self.bbhandler = None
         self.bblayers = []
+        self.dict_layername_collection = {}
+        self.dict_collection_layername = {}
 
     def init_bbhandler(self, config_only = False):
         if not self.bbhandler:
@@ -233,6 +235,33 @@ Removes the specified layer from bblayers.conf
             ldict[lname] = lurl, lsubdir
         return None, ldict
 
+    def get_required_layers(self, layername):
+        import re
+
+        self.init_bbhandler(config_only=True)
+        required_layers = []
+        bblayers = self.bbhandler.config_data.getVar('BBLAYERS', True).split()
+
+        if not self.dict_layername_collection and not self.dict_collection_layername:
+            bbcollections = self.bbhandler.config_data.getVar('BBFILE_COLLECTIONS', True).split()
+            for collection in bbcollections:
+                bbfile_pattern = self.bbhandler.config_data.getVar('BBFILE_PATTERN_%s' % collection, True)
+                bbfile_regex = re.compile(bbfile_pattern)
+                layerdir = None
+                for bblayer in bblayers:
+                    if bbfile_regex.match(os.path.join(bblayer, 'test')):
+                        layerdir = bblayer
+                        break
+                layer_basename = self.get_layer_name(layerdir)
+                self.dict_collection_layername[collection] = layer_basename
+                self.dict_layername_collection[layer_basename] = collection
+
+        required_collection_names = self.bbhandler.config_data.getVar('LAYERDEPENDS_%s' % self.dict_layername_collection[layername], True)
+        if required_collection_names:
+            for collection in required_collection_names.split():
+                required_layers.append(self.dict_collection_layername[collection])
+
+        return required_layers
 
     def get_fetch_layer(self, fetchdir, url, subdir, fetch_layer):
         layername = self.get_layer_name(url)
@@ -794,12 +823,22 @@ NOTE: .bbappend files can impact the dependencies.
 
         global_inherit = (self.bbhandler.config_data.getVar('INHERIT', True) or "").split()
 
+        dict_layer_required = {}
+
         # The bb's DEPENDS and RDEPENDS
         for f in pkg_fn:
             f = bb.cache.Cache.virtualfn2realfn(f)[0]
             # Get the layername that the file is in
             layername = self.get_file_layer(f)
 
+            required_layers = []
+            if not args.alldeps:
+                if layername in dict_layer_required:
+                    required_layers = dict_layer_required[layername]
+                else:
+                    required_layers = self.get_required_layers(layername)
+                    dict_layer_required[layername] = required_layers
+
             # The DEPENDS
             deps = self.bbhandler.cooker_data.deps[f]
             for pn in deps:
@@ -808,7 +847,7 @@ NOTE: .bbappend files can impact the dependencies.
                             self.bbhandler.config_data,
                             self.bbhandler.cooker_data,
                             self.bbhandler.cooker_data.pkg_pn)
-                    self.check_cross_depends("DEPENDS", layername, f, best[3], args.filenames, ignore_layers)
+                    self.check_cross_depends("DEPENDS", layername, f, best[3], args.filenames, ignore_layers, required_layers)
 
             # The RDPENDS
             all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
@@ -828,7 +867,7 @@ NOTE: .bbappend files can impact the dependencies.
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RDEPENDS", layername, f, best, args.filenames, ignore_layers)
+                    self.check_cross_depends("RDEPENDS", layername, f, best, args.filenames, ignore_layers, required_layers)
 
             # The RRECOMMENDS
             all_rrecs = self.bbhandler.cooker_data.runrecs[f].values()
@@ -848,7 +887,7 @@ NOTE: .bbappend files can impact the dependencies.
                     best = bb.providers.filterProvidersRunTime(all_p, rrec,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers)
+                    self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers, required_layers)
 
             # The inherit class
             cls_re = re.compile('classes/')
@@ -862,7 +901,7 @@ NOTE: .bbappend files can impact the dependencies.
                         if classname in global_inherit:
                             continue
                         inherit_layername = self.get_file_layer(cls)
-                        if inherit_layername != layername and not inherit_layername in ignore_layers:
+                        if inherit_layername != layername and not inherit_layername in ignore_layers and not inherit_layername in required_layers:
                             if not args.filenames:
                                 f_short = self.remove_layer_prefix(f)
                                 cls = self.remove_layer_prefix(cls)
@@ -883,7 +922,7 @@ NOTE: .bbappend files can impact the dependencies.
                     if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
                         pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
                         needed_file = re.sub(r"\${PV}", pv, needed_file)
-                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
+                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers, required_layers)
                 line = fnfile.readline()
             fnfile.close()
 
@@ -894,6 +933,14 @@ NOTE: .bbappend files can impact the dependencies.
         bbclass_re = re.compile(".*\.bbclass$")
         for layerdir in self.bblayers:
             layername = self.get_layer_name(layerdir)
+            required_layers = []
+            if not args.alldeps:
+                if layername in dict_layer_required:
+                    required_layers = dict_layer_required[layername]
+                else:
+                    required_layers = self.get_required_layers(layername)
+                    dict_layer_required[layername] = required_layers
+
             for dirpath, dirnames, filenames in os.walk(layerdir):
                 for name in filenames:
                     f = os.path.join(dirpath, name)
@@ -910,17 +957,17 @@ NOTE: .bbappend files can impact the dependencies.
                                 bbclass=".bbclass"
                             # Find a 'require/include xxxx'
                             if m:
-                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers)
+                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers, required_layers)
                             line = ffile.readline()
                         ffile.close()
 
-    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers):
+    def print_cross_files(self, bbpath, keyword, layername, f, needed_filename, show_filenames, ignore_layers, required_layers):
         """Print the depends that crosses a layer boundary"""
         needed_file = bb.utils.which(bbpath, needed_filename)
         if needed_file:
             # Which layer is this file from
             needed_layername = self.get_file_layer(needed_file)
-            if needed_layername != layername and not needed_layername in ignore_layers:
+            if needed_layername != layername and not needed_layername in ignore_layers and not needed_layername in required_layers:
                 if not show_filenames:
                     f = self.remove_layer_prefix(f)
                     needed_file = self.remove_layer_prefix(needed_file)
@@ -939,11 +986,11 @@ NOTE: .bbappend files can impact the dependencies.
             keyword = "includes"
         return (m, keyword)
 
-    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers):
+    def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers, required_layers):
         """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
         best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
         needed_layername = self.get_file_layer(best_realfn)
-        if needed_layername != layername and not needed_layername in ignore_layers:
+        if needed_layername != layername and not needed_layername in ignore_layers and not needed_layername in required_layers:
             if not show_filenames:
                 f = self.remove_layer_prefix(f)
                 best_realfn = self.remove_layer_prefix(best_realfn)
@@ -1000,6 +1047,7 @@ def main():
     parser_show_cross_depends = add_command('show-cross-depends', cmds.do_show_cross_depends)
     parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
     parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
+    parser_show_cross_depends.add_argument('-a', '--alldeps', help='show all cross dependencies including those in required layers', action='store_true')
 
     parser_layerindex_fetch = add_command('layerindex-fetch', cmds.do_layerindex_fetch)
     parser_layerindex_fetch.add_argument('-n', '--show-only', help='show dependencies and do nothing else', action='store_true')
-- 
1.9.1


