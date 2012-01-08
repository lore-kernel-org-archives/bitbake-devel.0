Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rjrdo-0005Vf-Tj
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Jan 2012 13:14:25 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Jan 2012 04:06:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="95755845"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.80])
	by orsmga002.jf.intel.com with ESMTP; 08 Jan 2012 04:06:57 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Jan 2012 12:06:50 +0000
Message-Id: <c3bae954b1363adee5bd80b623cc1fe71b7626a9.1326023910.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326023910.git.paul.eggleton@linux.intel.com>
References: <cover.1326023910.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326023910.git.paul.eggleton@linux.intel.com>
References: <cover.1326023910.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake-layers: flatten: warn the user if output structure is incorrect
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
X-List-Received-Date: Sun, 08 Jan 2012 12:14:25 -0000

If you flatten layers that have different directory structures you may
not end up with a usable layer in the output directory - some files
won't be picked up by BitBake.

To try to avoid this problem, once flattening has completed, get the
BBFILES entries that correspond to the layer from which the output
layer's conf/layer.conf came from, and check through all of the
.bb/.bbappend files in the output directory to see if any will not be
referred to by BBFILES in the output layer. If any are found, show a
warning to the user.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 572487d..b4c4127 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -8,6 +8,7 @@ import cmd
 import logging
 import os
 import sys
+import fnmatch
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -152,6 +153,8 @@ cleanup may still be necessary afterwards, in particular:
 * where anything beyond the normal layer setup has been added to
   layer.conf (only the lowest priority number layer's layer.conf is used)
 * overridden/appended items from bbappends will need to be tidied up
+* when the flattened layers do not have the same directory structure (the
+  flatten command should show a warning when this will cause a problem)
 
 Warning: if you flatten several layers where another layer is intended to
 be used "inbetween" them (in layer priority order) such that recipes /
@@ -194,6 +197,8 @@ build results (as the layer priority order has effectively changed).
                     logger.error('Unable to find layer %s in current configuration, please run "%s show_layers" to list configured layers' % (layername, os.path.basename(sys.argv[0])))
                     return
             layers = found_layerdirs
+        else:
+            layernames = []
 
         # Ensure a specified path matches our list of layers
         def layer_path_match(path):
@@ -256,6 +261,39 @@ build results (as the layer priority order has effectively changed).
                             bb.utils.copyfile(appendname, fdest)
                             first_append = fdest
 
+        # Get the regex for the first layer in our list (which is where the conf/layer.conf file will
+        # have come from)
+        first_regex = None
+        layerdir = layers[0]
+        for layername, pattern, regex, _ in self.cooker.status.bbfile_config_priorities:
+            if (not layernames) or layername in layernames:
+                if regex.match(os.path.join(layerdir, 'test')):
+                    first_regex = regex
+                    break
+
+        if first_regex:
+            # Find the BBFILES entries that match (which will have come from this conf/layer.conf file)
+            bbfiles = str(self.config_data.getVar('BBFILES', True)).split()
+            bbfiles_layer = []
+            for item in bbfiles:
+                if first_regex.match(item):
+                    newpath = os.path.join(outputdir, item[len(layerdir)+1:])
+                    bbfiles_layer.append(newpath)
+
+            if bbfiles_layer:
+                # Check that all important layer files match BBFILES
+                for root, dirs, files in os.walk(outputdir):
+                    for f1 in files:
+                        ext = os.path.splitext(f1)[1]
+                        if ext in ['.bb', '.bbappend']:
+                            f1full = os.sep.join([root, f1])
+                            entry_found = False
+                            for item in bbfiles_layer:
+                                if fnmatch.fnmatch(f1full, item):
+                                    entry_found = True
+                                    break
+                            if not entry_found:
+                                logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
     def get_append_layer(self, appendname):
         for layer, _, regex, _ in self.cooker.status.bbfile_config_priorities:
-- 
1.7.5.4



