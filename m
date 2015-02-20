Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 6AF0871F1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Feb 2015 17:52:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 20 Feb 2015 09:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,616,1418112000"; d="scan'208";a="680980804"
Received: from marazel-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.180])
	by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2015 09:52:53 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Feb 2015 17:52:41 +0000
Message-Id: <f66dbe2c337b72ecc2b8feb3bf5d36810c6dac18.1424454574.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1424454574.git.paul.eggleton@linux.intel.com>
References: <cover.1424454574.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake-layers: refactor to use argparse instead of cmd
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
X-List-Received-Date: Fri, 20 Feb 2015 17:52:58 -0000

This makes help formatting and option handling a lot more standardised
and allows us to drop a bunch of code. We also gain slightly more
straightforward error handling.

One side-effect however is that the old subcommand syntax using
underscores is no longer supported. The dashed form has been supported
(and displayed in the help text) for quite a while now so I wouldn't
imagine that will be much of an issue.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 261 ++++++++++++++++++++++-------------------------------
 1 file changed, 110 insertions(+), 151 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 9879498..2622bc0 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -5,7 +5,7 @@
 # See the help output for details on available commands.
 
 # Copyright (C) 2011 Mentor Graphics Corporation
-# Copyright (C) 2012 Intel Corporation
+# Copyright (C) 2011-2015 Intel Corporation
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License version 2 as
@@ -20,12 +20,12 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-import cmd
 import logging
 import os
 import sys
 import fnmatch
 from collections import defaultdict
+import argparse
 import re
 
 bindir = os.path.dirname(__file__)
@@ -42,23 +42,11 @@ import bb.tinfoil
 logger = logging.getLogger('BitBake')
 
 
-def main(args):
-    cmds = Commands()
-    if args:
-        # Allow user to specify e.g. show-layers instead of show_layers
-        args = [args[0].replace('-', '_')] + args[1:]
-        cmds.onecmd(' '.join(args))
-    else:
-        cmds.do_help('')
-    return cmds.returncode
-
 
-class Commands(cmd.Cmd):
+class Commands():
     def __init__(self):
         self.bbhandler = None
-        self.returncode = 0
         self.bblayers = []
-        cmd.Cmd.__init__(self)
 
     def init_bbhandler(self, config_only = False):
         if not self.bbhandler:
@@ -66,27 +54,6 @@ class Commands(cmd.Cmd):
             self.bblayers = (self.bbhandler.config_data.getVar('BBLAYERS', True) or "").split()
             self.bbhandler.prepare(config_only)
 
-    def default(self, line):
-        """Handle unrecognised commands"""
-        sys.stderr.write("Unrecognised command or option\n")
-        self.do_help('')
-
-    def do_help(self, topic):
-        """display general help or help on a specified command"""
-        if topic:
-            sys.stdout.write('%s: ' % topic)
-            cmd.Cmd.do_help(self, topic.replace('-', '_'))
-        else:
-            sys.stdout.write("usage: bitbake-layers <command> [arguments]\n\n")
-            sys.stdout.write("Available commands:\n")
-            procnames = list(set(self.get_names()))
-            for procname in procnames:
-                if procname[:3] == 'do_':
-                    sys.stdout.write("  %s\n" % procname[3:].replace('_', '-'))
-                    doc = getattr(self, procname).__doc__
-                    if doc:
-                        sys.stdout.write("    %s\n" % doc.splitlines()[0])
-
     def do_show_layers(self, args):
         """show current configured layers"""
         self.init_bbhandler(config_only = True)
@@ -103,29 +70,25 @@ class Commands(cmd.Cmd):
             logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), layerpri))
 
 
-    def do_add_layer(self, dirname):
+    def do_add_layer(self, args):
         """Add a layer to bblayers.conf
 
-usage: add-layer <layerdir>
+Adds the specified layer to bblayers.conf
 """
-        if not dirname:
-            sys.stderr.write("Please specify the layer directory to add\n")
-            return
-
-        layerdir = os.path.abspath(dirname)
+        layerdir = os.path.abspath(args.layerdir)
         if not os.path.exists(layerdir):
             sys.stderr.write("Specified layer directory doesn't exist\n")
-            return
+            return 1
 
         layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
         if not os.path.exists(layer_conf):
             sys.stderr.write("Specified layer directory doesn't contain a conf/layer.conf file\n")
-            return
+            return 1
 
         bblayers_conf = os.path.join('conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
-            return
+            return 1
 
         (notadded, _) = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
         if notadded:
@@ -133,28 +96,25 @@ usage: add-layer <layerdir>
                 sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
 
 
-    def do_remove_layer(self, dirname):
+    def do_remove_layer(self, args):
         """Remove a layer from bblayers.conf
 
-usage: remove-layer <layerdir>
+Removes the specified layer from bblayers.conf
 """
-        if not dirname:
-            sys.stderr.write("Please specify the layer directory to remove\n")
-            return
-
         bblayers_conf = os.path.join('conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
-            return
+            return 1
 
-        if dirname.startswith('*'):
+        if args.layerdir.startswith('*'):
             layerdir = dirname
         else:
-            layerdir = os.path.abspath(dirname)
+            layerdir = os.path.abspath(args.layerdir)
         (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
         if notremoved:
             for item in notremoved:
                 sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
+            return 1
 
 
     def version_str(self, pe, pv, pr = None):
@@ -169,32 +129,13 @@ usage: remove-layer <layerdir>
     def do_show_overlayed(self, args):
         """list overlayed recipes (where the same recipe exists in another layer)
 
-usage: show-overlayed [-f] [-s]
-
 Lists the names of overlayed recipes and the available versions in each
 layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
-
-Options:
-  -f   instead of the default formatting, list filenames of higher priority
-       recipes with the ones they overlay indented underneath
-  -s   only list overlayed recipes where the version is the same
 """
         self.init_bbhandler()
 
-        show_filenames = False
-        show_same_ver_only = False
-        for arg in args.split():
-            if arg == '-f':
-                show_filenames = True
-            elif arg == '-s':
-                show_same_ver_only = True
-            else:
-                sys.stderr.write("show-overlayed: invalid option %s\n" % arg)
-                self.do_help('')
-                return
-
-        items_listed = self.list_recipes('Overlayed recipes', None, True, show_same_ver_only, show_filenames, True)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True)
 
         # Check for overlayed .bbclass files
         classes = defaultdict(list)
@@ -221,7 +162,7 @@ Options:
                     overlayed_class_found = True
 
                 mainfile = bb.utils.which(bbpath, os.path.join('classes', classfile))
-                if show_filenames:
+                if args.filenames:
                     logger.plain('%s' % mainfile)
                 else:
                     # We effectively have to guess the layer here
@@ -235,7 +176,7 @@ Options:
                 for classdir in classdirs:
                     fullpath = os.path.join(classdir, classfile)
                     if fullpath != mainfile:
-                        if show_filenames:
+                        if args.filenames:
                             print('  %s' % fullpath)
                         else:
                             print('  %s' % self.get_layer_name(os.path.dirname(classdir)))
@@ -250,38 +191,15 @@ Options:
     def do_show_recipes(self, args):
         """list available recipes, showing the layer they are provided by
 
-usage: show-recipes [-f] [-m] [pnspec]
-
-Lists the names of overlayed recipes and the available versions in each
+Lists the names of recipes and the available versions in each
 layer, with the preferred version first. Optionally you may specify
 pnspec to match a specified recipe name (supports wildcards). Note that
 skipped recipes will also be listed, with a " (skipped)" suffix.
-
-Options:
-  -f   instead of the default formatting, list filenames of higher priority
-       recipes with other available recipes indented underneath
-  -m   only list where multiple recipes (in the same layer or different
-       layers) exist for the same recipe name
 """
         self.init_bbhandler()
 
-        show_filenames = False
-        show_multi_provider_only = False
-        pnspec = None
         title = 'Available recipes:'
-        for arg in args.split():
-            if arg == '-f':
-                show_filenames = True
-            elif arg == '-m':
-                show_multi_provider_only = True
-            elif not arg.startswith('-'):
-                pnspec = arg
-                title = 'Available recipes matching %s:' % pnspec
-            else:
-                sys.stderr.write("show-recipes: invalid option %s\n" % arg)
-                self.do_help('')
-                return
-        self.list_recipes(title, pnspec, False, False, show_filenames, show_multi_provider_only)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple)
 
 
     def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only):
@@ -361,9 +279,7 @@ Options:
 
 
     def do_flatten(self, args):
-        """flattens layer configuration into a separate output directory.
-
-usage: flatten [layer1 layer2 [layer3]...] <outputdir>
+        """flatten layer configuration into a separate output directory.
 
 Takes the specified layers (or all layers in the current layer
 configuration if none are specified) and builds a "flattened" directory
@@ -385,26 +301,19 @@ bbappends in the layers interact, and then attempt to use the new output
 layer together with that other layer, you may no longer get the same
 build results (as the layer priority order has effectively changed).
 """
-        arglist = args.split()
-        if len(arglist) < 1:
-            logger.error('Please specify an output directory')
-            self.do_help('flatten')
-            return
-
-        if len(arglist) == 2:
+        if len(args.layer) == 1:
             logger.error('If you specify layers to flatten you must specify at least two')
-            self.do_help('flatten')
-            return
+            return 1
 
-        outputdir = arglist[-1]
+        outputdir = args.outputdir
         if os.path.exists(outputdir) and os.listdir(outputdir):
             logger.error('Directory %s exists and is non-empty, please clear it out first' % outputdir)
-            return
+            return 1
 
         self.init_bbhandler()
         layers = self.bblayers
-        if len(arglist) > 2:
-            layernames = arglist[:-1]
+        if len(args.layer) > 2:
+            layernames = args.layer
             found_layernames = []
             found_layerdirs = []
             for layerdir in layers:
@@ -553,14 +462,12 @@ build results (as the layer priority order has effectively changed).
     def do_show_appends(self, args):
         """list bbappend files and recipe files they apply to
 
-usage: show-appends
-
-Recipes are listed with the bbappends that apply to them as subitems.
+Lists recipes with the bbappends that apply to them as subitems.
 """
         self.init_bbhandler()
         if not self.bbhandler.cooker.collection.appendlist:
             logger.plain('No append files found')
-            return
+            return 0
 
         logger.plain('=== Appended recipes ===')
 
@@ -599,7 +506,6 @@ Recipes are listed with the bbappends that apply to them as subitems.
                 if best_filename in missing:
                     logger.warn('%s: missing append for preferred version',
                                 best_filename)
-                    self.returncode |= 1
 
 
     def get_appends_for_files(self, filenames):
@@ -618,29 +524,13 @@ Recipes are listed with the bbappends that apply to them as subitems.
         return appended, notappended
 
     def do_show_cross_depends(self, args):
-        """figure out the dependency between recipes that crosses a layer boundary.
-
-usage: show-cross-depends [-f] [-i layer1[,layer2[,layer3...]]]
+        """Show dependencies between recipes that cross layer boundaries.
 
-Figure out the dependency between recipes that crosses a layer boundary.
+Figure out the dependencies between recipes that cross layer boundaries.
 
-Options:
-  -f   show full file path
-  -i   ignore dependencies on items in the specified layer(s)
-
-NOTE:
-The .bbappend file can impact the dependency.
+NOTE: .bbappend files can impact the dependencies.
 """
-        import optparse
-
-        parser = optparse.OptionParser(usage="show-cross-depends [-f] [-i layer1[,layer2[,layer3...]]]")
-        parser.add_option("-f", "",
-                action="store_true", dest="show_filenames")
-        parser.add_option("-i", "",
-                action="store", dest="ignore_layers", default="")
-
-        options, args = parser.parse_args(sys.argv)
-        ignore_layers = options.ignore_layers.split(',')
+        ignore_layers = (args.ignore or '').split(',')
 
         self.init_bbhandler()
 
@@ -666,7 +556,7 @@ The .bbappend file can impact the dependency.
                             self.bbhandler.config_data,
                             self.bbhandler.cooker_data,
                             self.bbhandler.cooker_data.pkg_pn)
-                    self.check_cross_depends("DEPENDS", layername, f, best[3], options.show_filenames, ignore_layers)
+                    self.check_cross_depends("DEPENDS", layername, f, best[3], args.filenames, ignore_layers)
 
             # The RDPENDS
             all_rdeps = self.bbhandler.cooker_data.rundeps[f].values()
@@ -686,7 +576,7 @@ The .bbappend file can impact the dependency.
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RDEPENDS", layername, f, best, options.show_filenames, ignore_layers)
+                    self.check_cross_depends("RDEPENDS", layername, f, best, args.filenames, ignore_layers)
 
             # The RRECOMMENDS
             all_rrecs = self.bbhandler.cooker_data.runrecs[f].values()
@@ -706,7 +596,7 @@ The .bbappend file can impact the dependency.
                     best = bb.providers.filterProvidersRunTime(all_p, rrec,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-                    self.check_cross_depends("RRECOMMENDS", layername, f, best, options.show_filenames, ignore_layers)
+                    self.check_cross_depends("RRECOMMENDS", layername, f, best, args.filenames, ignore_layers)
 
             # The inherit class
             cls_re = re.compile('classes/')
@@ -721,7 +611,7 @@ The .bbappend file can impact the dependency.
                             continue
                         inherit_layername = self.get_file_layer(cls)
                         if inherit_layername != layername and not inherit_layername in ignore_layers:
-                            if not options.show_filenames:
+                            if not args.filenames:
                                 f_short = self.remove_layer_prefix(f)
                                 cls = self.remove_layer_prefix(cls)
                             else:
@@ -741,7 +631,7 @@ The .bbappend file can impact the dependency.
                     if pv_re.search(needed_file) and f in self.bbhandler.cooker_data.pkg_pepvpr:
                         pv = self.bbhandler.cooker_data.pkg_pepvpr[f][1]
                         needed_file = re.sub(r"\${PV}", pv, needed_file)
-                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, options.show_filenames, ignore_layers)
+                    self.print_cross_files(bbpath, keyword, layername, f, needed_file, args.filenames, ignore_layers)
                 line = fnfile.readline()
             fnfile.close()
 
@@ -768,7 +658,7 @@ The .bbappend file can impact the dependency.
                                 bbclass=".bbclass"
                             # Find a 'require/include xxxx'
                             if m:
-                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, options.show_filenames, ignore_layers)
+                                self.print_cross_files(bbpath, keyword, layername, f, m.group(1) + bbclass, args.filenames, ignore_layers)
                             line = ffile.readline()
                         ffile.close()
 
@@ -808,5 +698,74 @@ The .bbappend file can impact the dependency.
 
             logger.plain("%s %s %s" % (f, keyword, best_realfn))
 
-if __name__ == '__main__':
-    sys.exit(main(sys.argv[1:]) or 0)
+
+def main():
+
+    cmds = Commands()
+
+    def add_command(cmdname, function, *args, **kwargs):
+        # Convert docstring for function to help (one-liner shown in main --help) and description (shown in subcommand --help)
+        docsplit = function.__doc__.splitlines()
+        help = docsplit[0]
+        if len(docsplit) > 1:
+            desc = '\n'.join(docsplit[1:])
+        else:
+            desc = help
+        subparser = subparsers.add_parser(cmdname, *args, help=help, description=desc, formatter_class=argparse.RawTextHelpFormatter, **kwargs)
+        subparser.set_defaults(func=function)
+        return subparser
+
+    parser = argparse.ArgumentParser(description="BitBake layers utility",
+                                     epilog="Use %(prog)s <subcommand> --help to get help on a specific command")
+    parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
+    parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    subparsers = parser.add_subparsers(title='subcommands', metavar='<subcommand>')
+
+    parser_show_layers = add_command('show-layers', cmds.do_show_layers)
+
+    parser_add_layer = add_command('add-layer', cmds.do_add_layer)
+    parser_add_layer.add_argument('layerdir', help='Layer directory to add')
+
+    parser_remove_layer = add_command('remove-layer', cmds.do_remove_layer)
+    parser_remove_layer.add_argument('layerdir', help='Layer directory to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
+    parser_remove_layer.set_defaults(func=cmds.do_remove_layer)
+
+    parser_show_overlayed = add_command('show-overlayed', cmds.do_show_overlayed)
+    parser_show_overlayed.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
+    parser_show_overlayed.add_argument('-s', '--same-version', help='only list overlayed recipes where the version is the same', action='store_true')
+
+    parser_show_recipes = add_command('show-recipes', cmds.do_show_recipes)
+    parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
+    parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
+    parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
+
+    parser_show_appends = add_command('show-appends', cmds.do_show_appends)
+
+    parser_flatten = add_command('flatten', cmds.do_flatten)
+    parser_flatten.add_argument('layer', nargs='*', help='Optional layer(s) to flatten (otherwise all are flattened)')
+    parser_flatten.add_argument('outputdir', help='Output directory')
+
+    parser_show_cross_depends = add_command('show-cross-depends', cmds.do_show_cross_depends)
+    parser_show_cross_depends.add_argument('-f', '--filenames', help='show full file path', action='store_true')
+    parser_show_cross_depends.add_argument('-i', '--ignore', help='ignore dependencies on items in the specified layer(s) (split multiple layer names with commas, no spaces)', metavar='LAYERNAME')
+
+    args = parser.parse_args()
+
+    if args.debug:
+        logger.setLevel(logging.DEBUG)
+    elif args.quiet:
+        logger.setLevel(logging.ERROR)
+
+    ret = args.func(args)
+
+    return ret
+
+
+if __name__ == "__main__":
+    try:
+        ret = main()
+    except Exception:
+        ret = 1
+        import traceback
+        traceback.print_exc(5)
+    sys.exit(ret)
-- 
1.9.3


