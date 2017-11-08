Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 6B1497849C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:17:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 07 Nov 2017 18:18:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; 
   d="scan'208";a="4848734"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by orsmga002.jf.intel.com with ESMTP; 07 Nov 2017 18:17:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:17:07 +1300
Message-Id: <622ac7b14aa743912bda5f6ab1f30aa904ef51d0.1510107342.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1510107342.git.paul.eggleton@linux.intel.com>
References: <cover.1510107342.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake-layers: remove-layer: support removing multiple layers at a time
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
X-List-Received-Date: Wed, 08 Nov 2017 02:17:58 -0000

If you can add multiple layers at once, it stands to reason that you
should also be able to remove more than one at a time.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bblayers/action.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index a421380..aa575d1 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -58,19 +58,22 @@ class ActionPlugin(LayerPlugin):
             shutil.rmtree(tempdir)
 
     def do_remove_layer(self, args):
-        """Remove a layer from bblayers.conf."""
+        """Remove one or more layers from bblayers.conf."""
         bblayers_conf = os.path.join('conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
 
-        if args.layerdir.startswith('*'):
-            layerdir = args.layerdir
-        elif not '/' in args.layerdir:
-            layerdir = '*/%s' % args.layerdir
-        else:
-            layerdir = os.path.abspath(args.layerdir)
-        (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
+        layerdirs = []
+        for item in args.layerdir:
+            if item.startswith('*'):
+                layerdir = item
+            elif not '/' in item:
+                layerdir = '*/%s' % item
+            else:
+                layerdir = os.path.abspath(item)
+            layerdirs.append(layerdir)
+        (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdirs)
         if notremoved:
             for item in notremoved:
                 sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
@@ -245,7 +248,7 @@ build results (as the layer priority order has effectively changed).
         parser_add_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to add')
 
         parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
-        parser_remove_layer.add_argument('layerdir', help='Layer directory to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
+        parser_remove_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
         parser_remove_layer.set_defaults(func=self.do_remove_layer)
 
         parser_flatten = self.add_command(sp, 'flatten', self.do_flatten)
-- 
2.9.5


