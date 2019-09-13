Return-Path: <ee.peng.yeoh@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 63AF17D391
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2019 03:58:50 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Sep 2019 20:58:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="197430603"
Received: from andromeda02.png.intel.com ([10.221.183.11])
	by orsmga002.jf.intel.com with ESMTP; 12 Sep 2019 20:58:50 -0700
From: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Sep 2019 11:58:41 +0800
Message-Id: <1568347121-43357-4-git-send-email-ee.peng.yeoh@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
References: <1568347121-43357-1-git-send-email-ee.peng.yeoh@intel.com>
X-Mailman-Approved-At: Sat, 14 Sep 2019 11:25:37 +0000
Subject: [PATCH 3/3] bitbake: bitbake-layers: show-recipes: Enable remove the (skipped) tag
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
X-List-Received-Date: Fri, 13 Sep 2019 03:58:50 -0000

Currently, show-recipes will append "(skipped)" to recipes which
were skipped due these recipes does not satisfied the configurations.

Example: $ bitbake-layers show-recipes -p
ace
backport-iwlwifi
core-image-rt (skipped)
core-image-rt-sdk (skipped)
core-image-tiny

Enable removal of the "(skipped)" tag appended to recipe using -r.

Example: $ bitbake-layers show-recipes -p -r
ace
backport-iwlwifi
core-image-rt
core-image-rt-sdk
core-image-tiny

Signed-off-by: Yeoh Ee Peng <ee.peng.yeoh@intel.com>
---
 lib/bblayers/query.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bblayers/query.py b/lib/bblayers/query.py
index 8ba94ac..44ab907 100644
--- a/lib/bblayers/query.py
+++ b/lib/bblayers/query.py
@@ -46,7 +46,7 @@ layer, with the preferred version first. Note that skipped recipes that
 are overlayed will also be listed, with a " (skipped)" suffix.
 """
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, None)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, False, True, None, False, None)
 
         # Check for overlayed .bbclass files
         classes = collections.defaultdict(list)
@@ -112,9 +112,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
             title = 'Matching recipes:'
         else:
             title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.packagenames, args.multiple, args.layer, inheritlist)
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.packagenames, args.multiple, args.layer, args.remove_skip_tag, inheritlist)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_packagenames, show_multi_provider_only, show_provided_layer_only, inherits):
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_packagenames, show_multi_provider_only, show_provided_layer_only, remove_skip_tag, inherits):
         if inherits:
             bbpath = str(self.tinfoil.config_data.getVar('BBPATH'))
             for classname in inherits:
@@ -145,7 +145,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 
         def print_item(f, pn, ver, layer, ispref):
             if not show_provided_layer_only or layer == show_provided_layer_only:
-                if f in skiplist:
+                if not remove_skip_tag and f in skiplist:
                     skipped = ' (skipped)'
                 else:
                     skipped = ''
@@ -503,6 +503,7 @@ NOTE: .bbappend files can impact the dependencies.
         parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
         parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class(es) - separate multiple classes using , (without spaces)', metavar='CLASS', default='')
         parser_show_recipes.add_argument('-l', '--layer', help='only list recipes from the provided layer', default='')
+        parser_show_recipes.add_argument('-r', '--remove-skip-tag', help='remove the "(skipped)" tag from recipes', action='store_true')
         parser_show_recipes.add_argument('pnspec', nargs='*', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
         parser_show_appends = self.add_command(sp, 'show-appends', self.do_show_appends)
-- 
2.7.4


