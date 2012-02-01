Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqD-00075X-FA
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:22 +0100
Received: by opal (Postfix, from userid 111)
	id 6B64C1033A; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.6B64C1033A@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: add show-recipes subcommand
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:22 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 05e86ba966f5a26721891c82b21afa48768a67cc
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=05e86ba966f5a26721891c82b21afa48768a67cc

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:53 2012 +0000

bitbake-layers: add show-recipes subcommand

Add a show-recipes subcommand which lists all available recipes, with
the layer they are provided by. You can optionally filter the output by
recipe name (PN).

(This is a generalised version of the show-overlayed subcommand.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |   57 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index abcfb99..95150de 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -163,6 +163,50 @@ Options:
                 self.do_help('')
                 return
 
+        items_listed = self.list_recipes('Overlayed recipes', None, True, show_same_ver_only, show_filenames, True)
+
+        if not items_listed:
+            logger.note('No overlayed files found')
+
+
+    def do_show_recipes(self, args):
+        """list available recipes, showing the layer they are provided by
+
+usage: show-recipes [-f] [-m] [pnspec]
+
+Lists the names of overlayed recipes and the available versions in each
+layer, with the preferred version first. Optionally you may specify
+pnspec to match a specified recipe name (supports wildcards). Note that
+skipped recipes will also be listed, with a " (skipped)" suffix.
+
+Options:
+  -f   instead of the default formatting, list filenames of higher priority
+       recipes with other available recipes indented underneath
+  -m   only list where multiple recipes (in the same layer or different
+       layers) exist for the same recipe name
+"""
+        self.check_prepare_cooker()
+
+        show_filenames = False
+        show_multi_provider_only = False
+        pnspec = None
+        title = 'Available recipes:'
+        for arg in args.split():
+            if arg == '-f':
+                show_filenames = True
+            elif arg == '-m':
+                show_multi_provider_only = True
+            elif not arg.startswith('-'):
+                pnspec = arg
+                title = 'Available recipes matching %s:' % pnspec
+            else:
+                sys.stderr.write("show-recipes: invalid option %s\n" % arg)
+                self.do_help('')
+                return
+        self.list_recipes(title, pnspec, False, False, show_filenames, show_multi_provider_only)
+
+
+    def list_recipes(self, title, pnspec, show_overlayed_only, show_same_ver_only, show_filenames, show_multi_provider_only):
         pkg_pn = self.cooker.status.pkg_pn
         (latest_versions, preferred_versions) = bb.providers.findProviders(self.cooker.configuration.data, self.cooker.status, pkg_pn)
         allproviders = bb.providers.allProviders(self.cooker.status)
@@ -203,7 +247,11 @@ Options:
         preffiles = []
         items_listed = False
         for p in sorted(pkg_pn):
-            if len(allproviders[p]) > 1:
+            if pnspec:
+                if not fnmatch.fnmatch(p, pnspec):
+                    continue
+
+            if len(allproviders[p]) > 1 or not show_multi_provider_only:
                 pref = preferred_versions[p]
                 preffile = bb.cache.Cache.virtualfn2realfn(pref[1])[0]
                 if preffile not in preffiles:
@@ -220,9 +268,9 @@ Options:
                         if prov[0] != pref[0]:
                             same_ver = False
 
-                    if multilayer and (same_ver or not show_same_ver_only):
+                    if (multilayer or not show_overlayed_only) and (same_ver or not show_same_ver_only):
                         if not items_listed:
-                            logger.plain('=== Overlayed recipes ===')
+                            logger.plain('=== %s ===' % title)
                             items_listed = True
                         print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
                         for (provfile, provlayer, provver) in provs:
@@ -231,8 +279,7 @@ Options:
                         # Ensure we don't show two entries for BBCLASSEXTENDed recipes
                         preffiles.append(preffile)
 
-        if not items_listed:
-            logger.note('No overlayed files found')
+        return items_listed
 
 
     def do_flatten(self, args):



