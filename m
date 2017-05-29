Return-Path: <rebecca.swee.fun.chang@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 6C86677FC9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 May 2017 00:43:45 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2017 17:43:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,412,1491289200"; d="scan'208";a="108120566"
Received: from rebeccas.png.intel.com ([172.30.199.118])
	by fmsmga006.fm.intel.com with ESMTP; 28 May 2017 17:43:45 -0700
From: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
To: Bitbake dev Mailing List <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 May 2017 08:44:06 +0800
Message-Id: <1496018646-92426-2-git-send-email-rebecca.swee.fun.chang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1496018646-92426-1-git-send-email-rebecca.swee.fun.chang@intel.com>
References: <1496018646-92426-1-git-send-email-rebecca.swee.fun.chang@intel.com>
Cc: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong@intel.com>
Subject: [PATCHv2] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Mon, 29 May 2017 00:43:46 -0000

In the original implementation, "bitbake-layers add-layers <layer>"
succeeded without error checking. This will further introduce
failures in recipe parsing only when "bitbake" command is executed.
Adding a meta layer without its dependency layer(s) should failed
and exit the process gracefully.

Added extra argument "-f" to force add a layer without checking
layer dependency.

[YOCTO #10913]

Signed-off-by: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong@intel.com>
Signed-off-by: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
---
 bin/bitbake-layers     |  1 +
 lib/bblayers/action.py | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 2b05d28..ced38a6 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -43,6 +43,7 @@ def main():
         add_help=False)
     parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('-f', '--force', help='Force add without recipe parse verification', action='store_true')
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
 
     global_args, unparsed_args = parser.parse_known_args()
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index cf94704..cc61555 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -1,7 +1,9 @@
 import fnmatch
 import logging
 import os
+import shutil
 import sys
+import tempfile
 
 import bb.utils
 
@@ -32,10 +34,26 @@ class ActionPlugin(LayerPlugin):
             sys.stderr.write("Unable to find bblayers.conf\n")
             return 1
 
-        notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
-        if notadded:
-            for item in notadded:
-                sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
+        # Back up bblayers.conf to tempdir before we add layers
+        tempdir = tempfile.mkdtemp()
+        backup = tempdir + "/bblayers.conf.bak"
+        shutil.copy2(bblayers_conf, backup)
+
+        try:
+            notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdir, None)
+            if not (args.force or notadded):
+                try:
+                    self.tinfoil.parseRecipes()
+                except bb.tinfoil.TinfoilUIException:
+                    # Restore the back up copy of bblayers.conf
+                    shutil.copy2(backup, bblayers_conf)
+                    bb.fatal("Parse failure with the specified layer added")
+            else:
+                for item in notadded:
+                    sys.stderr.write("Specified layer %s is already in BBLAYERS\n" % item)
+        finally:
+            # Remove the back up copy of bblayers.conf
+            shutil.rmtree(tempdir)
 
     def do_remove_layer(self, args):
         """Remove a layer from bblayers.conf."""
-- 
2.7.4


