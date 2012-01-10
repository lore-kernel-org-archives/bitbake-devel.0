Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rkfny-0005Ts-Jm
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:48:14 +0100
Received: by opal (Postfix, from userid 111)
	id 92C9D10331; Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120110174903.92C9D10331@opal>
Date: Tue, 10 Jan 2012 17:49:03 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: flatten: warn the user if output structure is incorrect
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
X-List-Received-Date: Tue, 10 Jan 2012 17:48:15 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 8e4dc97614f2022855143b49d18795ca0352b237
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=8e4dc97614f2022855143b49d18795ca0352b237

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Sun Jan  8 12:06:50 2012 +0000

bitbake-layers: flatten: warn the user if output structure is incorrect

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 572487d..b4c4127 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
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



