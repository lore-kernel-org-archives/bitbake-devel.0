Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qbzhk-0000hX-4A
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 20:41:40 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jun 2011 11:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="24396445"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.126])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2011 11:37:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jun 2011 19:37:40 +0100
Message-Id: <8ed35a3b5ced76ef30eb6f9a98561ec445dda02c.1309372176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 4/5] bitbake-layers: add command to flatten layers into one
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
X-List-Received-Date: Wed, 29 Jun 2011 18:41:40 -0000

Takes the current layer configuration and builds a "flattened" directory
containing the contents of all layers, with any overlayed recipes removed
and bbappends appended to the corresponding recipes. Note that some manual
cleanup may still be necessary afterwards, in particular:

 * where non-recipe files (such as patches) are overwritten (the flatten
   command will show a warning for these)
 * where anything beyond the normal layer setup has been added to
   layer.conf (only the lowest priority layer's layer.conf is used)
 * Overridden/appended items from bbappends will need to be tidied up

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   59 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index fced88e..110e3c8 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -18,6 +18,7 @@ sys.path[0:0] = [os.path.join(topdir, 'lib')]
 import bb.cache
 import bb.cooker
 import bb.providers
+import bb.utils
 from bb.cooker import state
 
 
@@ -83,6 +84,64 @@ class Commands(cmd.Cmd):
         else:
             logger.info('No overlayed recipes found')
 
+    def do_flatten(self, args):
+        arglist = args.split()
+        if len(arglist) != 1:
+            logger.error('syntax: flatten <outputdir>')
+            return
+
+        if os.path.exists(arglist[0]) and os.listdir(arglist[0]):
+            logger.error('Directory %s exists and is non-empty, please clear it out first' % arglist[0])
+            return
+
+        layers = (self.config_data.getVar('BBLAYERS', True) or "").split()
+        for layer in layers:
+            overlayed = []
+            for f in self.cooker.overlayed.iterkeys():
+                for of in self.cooker.overlayed[f]:
+                    if of.startswith(layer):
+                        overlayed.append(of)
+
+            logger.info('Copying files from %s...' % layer )
+            for root, dirs, files in os.walk(layer):
+                for f1 in files:
+                    f1full = os.sep.join([root, f1])
+                    if f1full in overlayed:
+                        logger.info('  Skipping overlayed file %s' % f1full )
+                    else:
+                        ext = os.path.splitext(f1)[1]
+                        if ext != '.bbappend':
+                            fdest = f1full[len(layer):]
+                            fdest = os.path.normpath(os.sep.join([arglist[0],fdest]))
+                            bb.utils.mkdirhier(os.path.dirname(fdest))
+                            if os.path.exists(fdest):
+                                if f1 == 'layer.conf' and root.endswith('/conf'):
+                                    logger.info('  Skipping layer config file %s' % f1full )
+                                    continue
+                                else:
+                                    logger.warn('Overwriting file %s', fdest)
+                            bb.utils.copyfile(f1full, fdest)
+                            if ext == '.bb':
+                                if f1 in self.cooker_data.appends:
+                                    appends = self.cooker_data.appends[f1]
+                                    if appends:
+                                        logger.info('  Applying appends to %s' % fdest )
+                                        for appendname in appends:
+                                            self.apply_append(appendname, fdest)
+
+    def get_append_layer(self, appendname):
+        for layer, _, regex, _ in self.cooker.status.bbfile_config_priorities:
+            if regex.match(appendname):
+                return layer
+        return "?"
+
+    def apply_append(self, appendname, recipename):
+        appendfile = open(appendname, 'r')
+        recipefile = open(recipename, 'a')
+        recipefile.write('\n')
+        recipefile.write('##### bbappended from %s #####\n' % self.get_append_layer(appendname))
+        recipefile.writelines(appendfile.readlines())
+
     def do_show_appends(self, args):
         if not self.cooker_data.appends:
             logger.info('No append files found')
-- 
1.7.4.1



