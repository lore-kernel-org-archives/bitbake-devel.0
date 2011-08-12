Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QruRi-0007qD-Nz
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 18:18:54 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Aug 2011 09:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,363,1309762800"; d="scan'208";a="38827064"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.18.64])
	by fmsmga002.fm.intel.com with ESMTP; 12 Aug 2011 09:14:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 17:13:58 +0100
Message-Id: <e59f678e8c65fb21e4b54eb72b0327f448cd789d.1313165343.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1313165343.git.paul.eggleton@linux.intel.com>
References: <cover.1313165343.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-layers: use logger.plain instead of info
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
X-List-Received-Date: Fri, 12 Aug 2011 16:18:55 -0000

The INFO: prefix makes sense in bitbake itself but in bitbake-layers is
just noise. Changing this exposed the fact that the logger was not being
set up correctly (which should be done anyway to correctly support
logging from BitBake), so this has also been fixed.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   33 +++++++++++++++++++--------------
 1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 2845ae5..aea8f93 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -24,7 +24,12 @@ logger = logging.getLogger('BitBake')
 
 
 def main(args):
-    logging.basicConfig(format='%(levelname)s: %(message)s')
+    # Set up logging
+    console = logging.StreamHandler(sys.stdout)
+    format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    console.setFormatter(format)
+    logger.addHandler(console)
+
     bb.utils.clean_environment()
 
     cmds = Commands()
@@ -97,7 +102,7 @@ class Commands(cmd.Cmd):
     def do_show_layers(self, args):
         """show current configured layers"""
         self.check_prepare_cooker()
-        logger.info(str(self.config_data.getVar('BBLAYERS', True)))
+        logger.plain(str(self.config_data.getVar('BBLAYERS', True)))
 
     def do_show_overlayed(self, args):
         """list overlayed recipes (where there is a recipe in another layer that has a higher layer priority)
@@ -108,13 +113,13 @@ Highest priority recipes are listed with the recipes they overlay as subitems.
 """
         self.check_prepare_cooker()
         if self.cooker.overlayed:
-            logger.info('Overlayed recipes:')
+            logger.plain('Overlayed recipes:')
             for f in self.cooker.overlayed.iterkeys():
-                logger.info('%s' % f)
+                logger.plain('%s' % f)
                 for of in self.cooker.overlayed[f]:
-                    logger.info('  %s' % of)
+                    logger.plain('  %s' % of)
         else:
-            logger.info('No overlayed recipes found')
+            logger.plain('No overlayed recipes found')
 
     def do_flatten(self, args):
         """flattens layer configuration into a separate output directory.
@@ -151,12 +156,12 @@ cleanup may still be necessary afterwards, in particular:
                     if of.startswith(layer):
                         overlayed.append(of)
 
-            logger.info('Copying files from %s...' % layer )
+            logger.plain('Copying files from %s...' % layer )
             for root, dirs, files in os.walk(layer):
                 for f1 in files:
                     f1full = os.sep.join([root, f1])
                     if f1full in overlayed:
-                        logger.info('  Skipping overlayed file %s' % f1full )
+                        logger.plain('  Skipping overlayed file %s' % f1full )
                     else:
                         ext = os.path.splitext(f1)[1]
                         if ext != '.bbappend':
@@ -165,7 +170,7 @@ cleanup may still be necessary afterwards, in particular:
                             bb.utils.mkdirhier(os.path.dirname(fdest))
                             if os.path.exists(fdest):
                                 if f1 == 'layer.conf' and root.endswith('/conf'):
-                                    logger.info('  Skipping layer config file %s' % f1full )
+                                    logger.plain('  Skipping layer config file %s' % f1full )
                                     continue
                                 else:
                                     logger.warn('Overwriting file %s', fdest)
@@ -174,7 +179,7 @@ cleanup may still be necessary afterwards, in particular:
                                 if f1 in self.cooker_data.appends:
                                     appends = self.cooker_data.appends[f1]
                                     if appends:
-                                        logger.info('  Applying appends to %s' % fdest )
+                                        logger.plain('  Applying appends to %s' % fdest )
                                         for appendname in appends:
                                             self.apply_append(appendname, fdest)
 
@@ -200,10 +205,10 @@ Recipes are listed with the bbappends that apply to them as subitems.
 """
         self.check_prepare_cooker()
         if not self.cooker_data.appends:
-            logger.info('No append files found')
+            logger.plain('No append files found')
             return
 
-        logger.info('State of append files:')
+        logger.plain('State of append files:')
 
         pnlist = list(self.cooker_data.pkg_pn.keys())
         pnlist.sort()
@@ -232,9 +237,9 @@ Recipes are listed with the bbappends that apply to them as subitems.
         appended, missing = self.get_appends_for_files(filenames)
         if appended:
             for basename, appends in appended:
-                logger.info('%s%s:', basename, name_suffix)
+                logger.plain('%s%s:', basename, name_suffix)
                 for append in appends:
-                    logger.info('  %s', append)
+                    logger.plain('  %s', append)
 
             if best_filename:
                 if best_filename in missing:
-- 
1.7.4.1



