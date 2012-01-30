Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RruB6-0000QG-3D
	for bitbake-devel@lists.openembedded.org;
	Mon, 30 Jan 2012 17:34:00 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Jan 2012 08:26:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="104198236"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.192])
	by orsmga002.jf.intel.com with ESMTP; 30 Jan 2012 08:26:01 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 30 Jan 2012 16:25:53 +0000
Message-Id: <afa9dfc091a92fb387561018b1a7d33712c4efdb.1327940413.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1327940413.git.paul.eggleton@linux.intel.com>
References: <cover.1327940413.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/6] bitbake-layers: add show-recipes subcommand
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
X-List-Received-Date: Mon, 30 Jan 2012 16:34:00 -0000

Add a show-recipes subcommand which lists all available recipes, with
the layer they are provided by. You can optionally filter the output by
recipe name (PN).

(This is a generalised version of the show-overlayed subcommand.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   57 ++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index abcfb99..95150de 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
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
-- 
1.7.5.4



