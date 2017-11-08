Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 70C877848A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:17:54 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 07 Nov 2017 18:17:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; 
   d="scan'208";a="4848712"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by orsmga002.jf.intel.com with ESMTP; 07 Nov 2017 18:17:53 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:17:06 +1300
Message-Id: <0a803a4de42299a0ff1008632d133274e3619602.1510107342.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1510107342.git.paul.eggleton@linux.intel.com>
References: <cover.1510107342.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake-layers: add-layer: enable adding multiple layers at once
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
X-List-Received-Date: Wed, 08 Nov 2017 02:17:54 -0000

Allow specifying multiple layers with bitbake-layers add-layer so that
you can add more than one in a single command. This is not just useful,
it's actually pretty important if you need to add a layer and its
dependencies at the same time - since we now go through a parse process
when the layer is added, without this you have to add them all in just
the right order and wait for the parse each time which is somewhat
painful.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bblayers/action.py | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index b1326e5..a421380 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -18,16 +18,18 @@ def plugin_init(plugins):
 
 class ActionPlugin(LayerPlugin):
     def do_add_layer(self, args):
-        """Add a layer to bblayers.conf."""
-        layerdir = os.path.abspath(args.layerdir)
-        if not os.path.exists(layerdir):
-            sys.stderr.write("Specified layer directory doesn't exist\n")
-            return 1
+        """Add one or more layers to bblayers.conf."""
+        layerdirs = [os.path.abspath(ldir) for ldir in args.layerdir]
 
-        layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
-        if not os.path.exists(layer_conf):
-            sys.stderr.write("Specified layer directory doesn't contain a conf/layer.conf file\n")
-            return 1
+        for layerdir in layerdirs:
+            if not os.path.exists(layerdir):
+                sys.stderr.write("Specified layer directory %s doesn't exist\n" % layerdir)
+                return 1
+
+            layer_conf = os.path.join(layerdir, 'conf', 'layer.conf')
+            if not os.path.exists(layer_conf):
+                sys.stderr.write("Specified layer directory %s doesn't contain a conf/layer.conf file\n" % layerdir)
+                return 1
 
         bblayers_conf = os.path.join('conf', 'bblayers.conf')
         if not os.path.exists(bblayers_conf):
@@ -40,7 +42,7 @@ class ActionPlugin(LayerPlugin):
         shutil.copy2(bblayers_conf, backup)
 
         try:
-            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
+            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
             if not (args.force or notadded):
                 try:
                     self.tinfoil.parseRecipes()
@@ -240,7 +242,7 @@ build results (as the layer priority order has effectively changed).
 
     def register_commands(self, sp):
         parser_add_layer = self.add_command(sp, 'add-layer', self.do_add_layer, parserecipes=False)
-        parser_add_layer.add_argument('layerdir', help='Layer directory to add')
+        parser_add_layer.add_argument('layerdir', nargs='+', help='Layer directory/directories to add')
 
         parser_remove_layer = self.add_command(sp, 'remove-layer', self.do_remove_layer, parserecipes=False)
         parser_remove_layer.add_argument('layerdir', help='Layer directory to remove (wildcards allowed, enclose in quotes to avoid shell expansion)')
-- 
2.9.5


