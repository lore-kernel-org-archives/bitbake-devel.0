Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 16C21780B8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Jun 2017 15:00:18 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP; 19 Jun 2017 08:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,361,1493708400"; d="scan'208";a="101162179"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by orsmga002.jf.intel.com with ESMTP; 19 Jun 2017 08:00:20 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Jun 2017 08:00:18 -0700
Message-Id: <20170619150018.22287-1-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.12.0
Subject: [PATCH] action: bitbake-layers new plugin to create a layer
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
X-List-Received-Date: Mon, 19 Jun 2017 15:00:19 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

Creates a simple layer with a example recipe, where the latter
has just a single task (do_build). Layer's license is MIT and
layer's priority defaults to 6. Recipe name and layer's priority
can changed specified through the command line.

[YOCTO #11567]

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 bitbake/lib/bblayers/action.py | 121 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index b1326e5f53..2384ef6dc1 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -220,6 +220,122 @@ build results (as the layer priority order has effectively changed).
                             if not entry_found:
                                 logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
+    def do_create_layer(self, args):
+        """Create a basic layer"""
+        layerdir = os.path.abspath(args.layerdir)
+        if os.path.exists(layerdir):
+            sys.stderr.write("Specified layer directory exists\n")
+            return 1
+
+        # create dirs
+        conf = os.path.join(layerdir, 'conf')
+        bb.utils.mkdirhier(conf)
+
+        # readme
+        readme = os.path.join(layerdir, 'README')
+        with open(readme, 'w') as fd:
+            fd.write("""\
+This README file contains information on the contents of the %s layer.
+
+Please see the corresponding sections below for details.
+
+Dependencies
+============
+
+  URI: <first dependency>
+  branch: <branch name>
+
+  URI: <second dependency>
+  branch: <branch name>
+
+  .
+  .
+  .
+
+Patches
+=======
+
+Please submit any patches against the %s layer to the xxxx mailing list (xxxx@zzzz.org)
+and cc: the maintainer:
+
+Maintainer: XXX YYYYYY <xxx.yyyyyy@zzzzz.com>
+
+Table of Contents
+=================
+
+  I. Adding the %s layer to your build
+ II. Misc
+
+
+I. Adding the %s layer to your build
+=================================================
+
+Run 'bitbake-layers add-layer %s'
+
+II. Misc
+========
+
+--- replace with specific information about the %s layer ---
+""" % (args.layerdir, args.layerdir, args.layerdir, args.layerdir, args.layerdir, args.layerdir))
+
+        # license
+        copying = os.path.join(layerdir, 'COPYING.MIT')
+        with open(copying, 'w') as fd:
+            fd.write("""\
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+THE SOFTWARE.""")
+
+        # layer.conf
+        layer_conf = os.path.join(conf, 'layer.conf')
+        with open(layer_conf, 'w') as fd:
+            fd.write("""\
+# We have a conf and classes directory, add to BBPATH
+BBPATH .= \":${LAYERDIR}\"
+
+# We have recipes-* directories, add to BBFILES
+BBFILES += \"${LAYERDIR}/recipes-*/*/*.bb \\
+            ${LAYERDIR}/recipes-*/*/*.bbappend\"
+
+BBFILE_COLLECTIONS += \"%s\"
+BBFILE_PATTERN_%s = \"^${LAYERDIR}/\"
+BBFILE_PRIORITY_%s = \"%s\"
+""" % (args.layerdir, args.layerdir, args.layerdir, args.priority))
+
+        # example
+        example = os.path.join(layerdir, 'recipes-' + args.examplerecipe, args.examplerecipe)
+        bb.utils.mkdirhier(example)
+        with open(os.path.join(example, args.examplerecipe + '.bb'), 'w') as fd:
+            fd.write("""\
+SUMMARY = \"bitbake-layers recipe\"
+DESCRIPTION = \"Recipe created by bitbake-layers\"
+LICENSE = \"MIT\"
+
+python do_build() {
+    bb.plain(\"***********************************************\");
+    bb.plain(\"*                                             *\");
+    bb.plain(\"*  Example recipe created by bitbake-layers   *\");
+    bb.plain(\"*                                             *\");
+    bb.plain(\"***********************************************\");
+}
+""")
+
+        logger.plain('Add your new layer with \'bitbake-layers add-layer %s\'' % args.layerdir)
+
     def get_file_layer(self, filename):
         layerdir = self.get_file_layerdir(filename)
         if layerdir:
@@ -249,3 +365,8 @@ build results (as the layer priority order has effectively changed).
         parser_flatten = self.add_command(sp, 'flatten', self.do_flatten)
         parser_flatten.add_argument('layer', nargs='*', help='Optional layer(s) to flatten (otherwise all are flattened)')
         parser_flatten.add_argument('outputdir', help='Output directory')
+
+        parser_create_layer = self.add_command(sp, 'create-layer', self.do_create_layer, parserecipes=False)
+        parser_create_layer.add_argument('layerdir', help='Layer directory to create')
+        parser_create_layer.add_argument('--priority', '-p', default=6, help='Layer directory to create')
+        parser_create_layer.add_argument('--example-recipe-name', '-e', dest='examplerecipe', default='example', help='Filename of the example recipe')
-- 
2.12.0


