Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4037D73E11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:20:30 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 19 Aug 2015 06:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,709,1432623600"; d="scan'208";a="751523685"
Received: from mclawlor-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.12.193])
	by orsmga001.jf.intel.com with ESMTP; 19 Aug 2015 06:20:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:20:11 +0100
Message-Id: <76441671d5ee0638e0fcf6fc945cab604dff2e28.1439990327.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439990327.git.paul.eggleton@linux.intel.com>
References: <cover.1439990327.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] bitbake-layers: show-recipes: allow filtering by class inheritance
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
X-List-Received-Date: Wed, 19 Aug 2015 13:20:31 -0000

Add a -i/--inherits option to filter the output to include only recipes
inheriting the specified class(es).

Implements [YOCTO #7475].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index df22781..72db232 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -54,6 +54,8 @@ def logger_create(name, output=sys.stderr):
 
 logger = logger_create('bitbake-layers', sys.stdout)
 
+class UserError(Exception):
+    pass
 
 class Commands():
     def __init__(self):
@@ -388,7 +390,7 @@ are overlayed will also be listed, with a " (skipped)" suffix.
 """
         self.init_bbhandler()
 
-        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True)
+        items_listed = self.list_recipes('Overlayed recipes', None, True, args.same_version, args.filenames, True, None)
 
         # Check for overlayed .bbclass files
         classes = defaultdict(list)
@@ -451,11 +453,22 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 """
         self.init_bbhandler()
 
-        title = 'Available recipes:'
-        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple)
+        inheritlist = args.inherits.split(',') if args.inherits else []
+        if inheritlist or args.pnspec or args.multiple:
+            title = 'Matching recipes:'
+        else:
+            title = 'Available recipes:'
+        self.list_recipes(title, args.pnspec, False, False, args.filenames, args.multiple, inheritlist)
+
 
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only, inherits):
+        if inherits:
+            bbpath = str(self.bbhandler.config_data.getVar('BBPATH', True))
+            for classname in inherits:
+                classfile = 'classes/%s.bbclass' % classname
+                if not bb.utils.which(bbpath, classfile, history=False):
+                    raise UserError('No class named %s found in BBPATH' % classfile)
 
-    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only):
         pkg_pn = self.bbhandler.cooker.recipecache.pkg_pn
         (latest_versions, preferred_versions) = bb.providers.findProviders(self.bbhandler.config_data, self.bbhandler.cooker.recipecache, pkg_pn)
         allproviders = bb.providers.allProviders(self.bbhandler.cooker.recipecache)
@@ -493,6 +506,9 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     logger.plain("%s:", pn)
                 logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
 
+        global_inherit = (self.bbhandler.config_data.getVar('INHERIT', True) or "").split()
+        cls_re = re.compile('classes/')
+
         preffiles = []
         items_listed = False
         for p in sorted(pkg_pn):
@@ -504,11 +520,28 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                 pref = preferred_versions[p]
                 realfn = bb.cache.Cache.virtualfn2realfn(pref[1])
                 preffile = realfn[0]
+
                 # We only display once per recipe, we should prefer non extended versions of the
                 # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
                 # which would otherwise sort first).
                 if realfn[1] and realfn[0] in self.bbhandler.cooker.recipecache.pkg_fn:
                     continue
+
+                if inherits:
+                    matchcount = 0
+                    recipe_inherits = self.bbhandler.cooker_data.inherits.get(preffile, [])
+                    for cls in recipe_inherits:
+                        if cls_re.match(cls):
+                            continue
+                        classname = os.path.splitext(os.path.basename(cls))[0]
+                        if classname in global_inherit:
+                            continue
+                        elif classname in inherits:
+                            matchcount += 1
+                    if matchcount != len(inherits):
+                        # No match - skip this recipe
+                        continue
+
                 if preffile not in preffiles:
                     preflayer = self.get_file_layer(preffile)
                     multilayer = False
@@ -993,6 +1026,7 @@ def main():
     parser_show_recipes = add_command('show-recipes', cmds.do_show_recipes)
     parser_show_recipes.add_argument('-f', '--filenames', help='instead of the default formatting, list filenames of higher priority recipes with the ones they overlay indented underneath', action='store_true')
     parser_show_recipes.add_argument('-m', '--multiple', help='only list where multiple recipes (in the same layer or different layers) exist for the same recipe name', action='store_true')
+    parser_show_recipes.add_argument('-i', '--inherits', help='only list recipes that inherit the named class', metavar='CLASS', default='')
     parser_show_recipes.add_argument('pnspec', nargs='?', help='optional recipe name specification (wildcards allowed, enclose in quotes to avoid shell expansion)')
 
     parser_show_appends = add_command('show-appends', cmds.do_show_appends)
@@ -1022,7 +1056,11 @@ def main():
     elif args.quiet:
         logger.setLevel(logging.ERROR)
 
-    ret = args.func(args)
+    try:
+        ret = args.func(args)
+    except UserError as err:
+        logger.error(str(err))
+        ret = 1
 
     return ret
 
-- 
2.1.0


