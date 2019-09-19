Return-Path: <ee.peng.yeoh@intel.com>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by mail.openembedded.org (Postfix) with ESMTP id 85B247FFD6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Sep 2019 10:18:24 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Sep 2019 03:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,523,1559545200"; d="scan'208";a="194337437"
Received: from andromeda02.png.intel.com ([10.221.183.11])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Sep 2019 03:11:19 -0700
From: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Sep 2019 18:11:09 +0800
Message-Id: <1568887870-22217-3-git-send-email-ee.peng.yeoh@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568887870-22217-1-git-send-email-ee.peng.yeoh@intel.com>
References: <1568887870-22217-1-git-send-email-ee.peng.yeoh@intel.com>
Subject: [PATCH 2/3 v01] bitbake: bitbake-layers: show-recipes: Select recipes from selected layer
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
X-List-Received-Date: Thu, 19 Sep 2019 10:18:24 -0000

Currently, show-recipes will show recipes from all configured layers.
Assume, meta-intel layer was added to conf/bblayers.conf.

Example of default $ bitbake-layers show-recipes:
core-image-rt:
  meta-intel           unknown (skipped)
  meta                 unknown (skipped)

Add -l/--layer to enable showing recipes from user selected layer.

Example: $ bitbake-layers show-recipes -l meta-intel
core-image-rt:
  meta-intel           unknown (skipped)

Signed-off-by: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
---
 lib/bblayers/query.py | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 84168a1..a100f66 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -46,7 +46,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, None)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -112,9 +112,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, inheritlist)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.recipes_only, args.multiple, args.layer, inheritlist)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, inherits):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_recipes_only, show_multi_provider_only, selected_layer, inherits):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -144,23 +144,24 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                 preferred_versions[p] = (ver, fn)
 
         def print_item(f, pn, ver, layer, ispref):
-            if f in skiplist:
-                skipped = ' (skipped)'
-            else:
-                skipped = ''
-            if show_filenames:
-                if ispref:
-                    logger.plain("%s%s", f, skipped)
+            if not selected_layer or layer == selected_layer:
+                if f in skiplist:
+                    skipped = ' (skipped)'
                 else:
-                    logger.plain("  %s%s", f, skipped)
-            elif show_recipes_only:
-                if pn not in show_unique_pn:
-                    show_unique_pn.append(pn)
-                    logger.plain("%s%s", pn, skipped)
-            else:
-                if ispref:
-                    logger.plain("%s:", pn)
-                logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
+                    skipped = ''
+                if show_filenames:
+                    if ispref:
+                        logger.plain("%s%s", f, skipped)
+                    else:
+                        logger.plain("  %s%s", f, skipped)
+                elif show_recipes_only:
+                    if pn not in show_unique_pn:
+                        show_unique_pn.append(pn)
+                        logger.plain("%s%s", pn, skipped)
+                else:
+                    if ispref:
+                        logger.plain("%s:", pn)
+                    logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
 
         global_inherit = (self.tinfoil.config_data.getVar('INHERIT') or "").split()
         cls_re = re.compile('classes/')
@@ -501,6 +502,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-r', '--recipes-only', help='instead of the default formatting, list recipes only', action='store_true')
         parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
+        parser_show_recipes.add_argument('-l', '--layer', help='only list recipes from the selected layer', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
-- 
2.7.4


