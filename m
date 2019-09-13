Return-Path: <ee.peng.yeoh@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D3B397E584
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 03:58:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Sep 2019 20:58:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="197430584"
Received: from andromeda02.png.intel.com ([10.221.183.11])
	by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 20:58:46 -0700
From: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Sep 2019 11:58:39 +0800
Message-Id: <1568347121-43357-2-git-send-email-ee.peng.yeoh@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
References: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
X-Mailman-Approved-At: Sat, 14 Sep 2019 11:25:37 +0000
Subject: [PATCH 1/3] bitbake: bitbake-layers: show-recipes: Show unique packagenames
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
X-List-Received-Date: Fri, 13 Sep 2019 03:58:46 -0000

Currently, show-recipes will show all recipes available (both
recipes with different version and recipes provided by more
than one layer).

Example of default $ bitbake-layers show-recipes:
core-image-rt:
  meta-intel           unknown (skipped)
  meta                 unknown (skipped)

yajl:
  meta-oe              2.1.0
  meta-oe              1.0.12

Add -p argument to enable showing unique packagenames. This
provide a focus view on unique recipes available.

Example of $ bitbake-layers show-recipes -p:
core-image-rt (skipped)
yajl

Signed-off-by: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
---
 lib/bblayers/query.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 993589d..e13c00e 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -46,7 +46,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True, None)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -112,9 +112,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple, inheritlist)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.packagenames, args.multiple, inheritlist)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only, inherits):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_packagenames, show_multi_provider_only, inherits):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -153,6 +153,10 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     logger.plain("%s%s", f, skipped)
                 else:
                     logger.plain("  %s%s", f, skipped)
+            elif show_packagenames:
+                if pn not in show_unique_pn:
+                    show_unique_pn.append(pn)
+                    logger.plain("%s%s", pn, skipped)
             else:
                 if ispref:
                     logger.plain("%s:", pn)
@@ -162,6 +166,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
         cls_re = re.compile('classes/')
 
         preffiles = []
+        show_unique_pn = []
         items_listed = False
         for p in sorted(pkg_pn):
             if pnspec:
@@ -493,6 +498,7 @@ NOTE: .bbappend files can impact the dependencies.
 
         parser_show_recipes = self.add_command(sp, 'show-recipes', self.do_show_recipes)
         parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
+        parser_show_recipes.add_argument('-p', '--packagenames', help='instead of the default formatting, list packagenames of higher priority recipes only', action='store_true')
         parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
-- 
2.7.4


