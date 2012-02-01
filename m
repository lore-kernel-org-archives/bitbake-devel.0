Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RsbqC-000759-GL
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Feb 2012 16:11:20 +0100
Received: by opal (Postfix, from userid 111)
	id 4E7F010338; Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120201150346.4E7F010338@opal>
Date: Wed,  1 Feb 2012 15:03:46 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: improve show-overlayed output
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
X-List-Received-Date: Wed, 01 Feb 2012 15:11:20 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 43b473275d3cb2e60a14e4a52cdc4654b3f4e5e7
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=43b473275d3cb2e60a14e4a52cdc4654b3f4e5e7

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Mon Jan 30 16:25:52 2012 +0000

bitbake-layers: improve show-overlayed output

Make the following improvements to the show-overlayed subcommand:

* Show recipes that are overlayed when the version is higher or lower,
  not just when it is the same. This gives a much better picture of the
  influence each layer is having over the metadata used for building.
  This can be disabled with the -s option if you just want to see
  recipes with the same version as before.
* Default to showing name (PN), layer and version rather than the full
  path and filename. The old style formatting can be used by specifying
  the -f option.
* Mark skipped recipes as such in the output, and print them in the
  correct sorted place in the list rather than at the end
* Prefix/suffix title line with === so it can be filtered out easily in
  shell scripts if desired

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers  |  116 ++++++++++++++++++++++++++++++++++++++++++++++-----
 lib/bb/cooker.py    |   14 +------
 lib/bb/providers.py |   36 ++++++++++++++++
 3 files changed, 142 insertions(+), 24 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 9d453ca..abcfb99 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -12,6 +12,7 @@ import logging
 import os
 import sys
 import fnmatch
+from collections import defaultdict
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
@@ -124,22 +125,115 @@ class Commands(cmd.Cmd):
 
             logger.plain("%s  %s  %d" % (layername.ljust(20), layerdir.ljust(40), layerpri))
 
+
+    def version_str(self, pe, pv, pr = None):
+        verstr = "%s" % pv
+        if pr:
+            verstr = "%s-%s" % (verstr, pr)
+        if pe:
+            verstr = "%s:%s" % (pe, verstr)
+        return verstr
+
+
     def do_show_overlayed(self, args):
-        """list overlayed recipes (where there is a recipe in another layer that has a higher layer priority)
+        """list overlayed recipes (where the same recipe exists in another layer that has a higher layer priority)
+
+usage: show-overlayed [-f] [-s]
 
-usage: show-overlayed
+Lists the names of overlayed recipes and the available versions in each
+layer, with the preferred version first. Note that skipped recipes that
+are overlayed will also be listed, with a " (skipped)" suffix.
 
-Highest priority recipes are listed with the recipes they overlay as subitems.
+Options:
+  -f   instead of the default formatting, list filenames of higher priority
+       recipes with the ones they overlay indented underneath
+  -s   only list overlayed recipes where the version is the same
 """
         self.check_prepare_cooker()
-        if self.cooker.overlayed:
-            logger.plain('Overlayed recipes:')
-            for f in self.cooker.overlayed.iterkeys():
-                logger.plain('%s' % f)
-                for of in self.cooker.overlayed[f]:
-                    logger.plain('  %s' % of)
-        else:
-            logger.plain('No overlayed recipes found')
+
+        show_filenames = False
+        show_same_ver_only = False
+        for arg in args.split():
+            if arg == '-f':
+                show_filenames = True
+            elif arg == '-s':
+                show_same_ver_only = True
+            else:
+                sys.stderr.write("show-overlayed: invalid option %s\n" % arg)
+                self.do_help('')
+                return
+
+        pkg_pn = self.cooker.status.pkg_pn
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.cooker.configuration.data, self.cooker.status, pkg_pn)
+        allproviders = bb.providers.allProviders(self.cooker.status)
+
+        # Ensure we list skipped recipes
+        # We are largely guessing about PN, PV and the preferred version here,
+        # but we have no choice since skipped recipes are not fully parsed
+        skiplist = self.cooker.skiplist.keys()
+        skiplist.sort( key=lambda fileitem: self.cooker.calc_bbfile_priority(fileitem) )
+        skiplist.reverse()
+        for fn in skiplist:
+            recipe_parts = os.path.splitext(os.path.basename(fn))[0].split('_')
+            p = recipe_parts[0]
+            if len(recipe_parts) > 1:
+                ver = (None, recipe_parts[1], None)
+            else:
+                ver = (None, 'unknown', None)
+            allproviders[p].append((ver, fn))
+            if not p in pkg_pn:
+                pkg_pn[p] = 'dummy'
+                preferred_versions[p] = (ver, fn)
+
+        def print_item(f, pn, ver, layer, ispref):
+            if f in skiplist:
+                skipped = ' (skipped)'
+            else:
+                skipped = ''
+            if show_filenames:
+                if ispref:
+                    logger.plain("%s%s", f, skipped)
+                else:
+                    logger.plain("  %s%s", f, skipped)
+            else:
+                if ispref:
+                    logger.plain("%s:", pn)
+                logger.plain("  %s %s%s", layer.ljust(20), ver, skipped)
+
+        preffiles = []
+        items_listed = False
+        for p in sorted(pkg_pn):
+            if len(allproviders[p]) > 1:
+                pref = preferred_versions[p]
+                preffile = bb.cache.Cache.virtualfn2realfn(pref[1])[0]
+                if preffile not in preffiles:
+                    preflayer = self.get_file_layer(preffile)
+                    multilayer = False
+                    same_ver = True
+                    provs = []
+                    for prov in allproviders[p]:
+                        provfile = bb.cache.Cache.virtualfn2realfn(prov[1])[0]
+                        provlayer = self.get_file_layer(provfile)
+                        provs.append((provfile, provlayer, prov[0]))
+                        if provlayer != preflayer:
+                            multilayer = True
+                        if prov[0] != pref[0]:
+                            same_ver = False
+
+                    if multilayer and (same_ver or not show_same_ver_only):
+                        if not items_listed:
+                            logger.plain('=== Overlayed recipes ===')
+                            items_listed = True
+                        print_item(preffile, p, self.version_str(pref[0][0], pref[0][1]), preflayer, True)
+                        for (provfile, provlayer, provver) in provs:
+                            if provfile != preffile:
+                                print_item(provfile, p, self.version_str(provver[0], provver[1]), provlayer, False)
+                        # Ensure we don't show two entries for BBCLASSEXTENDed recipes
+                        preffiles.append(preffile)
+
+        if not items_listed:
+            logger.note('No overlayed files found')
+
 
     def do_flatten(self, args):
         """flattens layer configuration into a separate output directory.
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ac99e91..7dab38e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -259,20 +259,8 @@ class BBCooker:
         # Need files parsed
         self.updateCache()
 
-        # Need to ensure data store is expanded
-        localdata = data.createCopy(self.configuration.data)
-        bb.data.update_data(localdata)
-        bb.data.expandKeys(localdata)
-
         pkg_pn = self.status.pkg_pn
-        preferred_versions = {}
-        latest_versions = {}
-
-        # Sort by priority
-        for pn in pkg_pn:
-            (last_ver, last_file, pref_ver, pref_file) = bb.providers.findBestProvider(pn, localdata, self.status)
-            preferred_versions[pn] = (pref_ver, pref_file)
-            latest_versions[pn] = (last_ver, last_file)
+        (latest_versions, preferred_versions) = bb.providers.findProviders(self.configuration.data, self.status, pkg_pn)
 
         logger.plain("%-35s %25s %25s", "Package Name", "Latest Version", "Preferred Version")
         logger.plain("%-35s %25s %25s\n", "============", "==============", "=================")
diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 398c8ea..1dc6a8e 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -24,6 +24,7 @@
 import re
 import logging
 from bb import data, utils
+from collections import defaultdict
 import bb
 
 logger = logging.getLogger("BitBake.Provider")
@@ -35,6 +36,41 @@ class NoRProvider(bb.BBHandledException):
     """Exception raised when no provider of a runtime dependency can be found"""
 
 
+def findProviders(cfgData, dataCache, pkg_pn = None):
+    """
+    Convenience function to get latest and preferred providers in pkg_pn
+    """
+
+    if not pkg_pn:
+        pkg_pn = dataCache.pkg_pn
+
+    # Need to ensure data store is expanded
+    localdata = data.createCopy(cfgData)
+    bb.data.update_data(localdata)
+    bb.data.expandKeys(localdata)
+
+    preferred_versions = {}
+    latest_versions = {}
+
+    for pn in pkg_pn:
+        (last_ver, last_file, pref_ver, pref_file) = findBestProvider(pn, localdata, dataCache, pkg_pn)
+        preferred_versions[pn] = (pref_ver, pref_file)
+        latest_versions[pn] = (last_ver, last_file)
+
+    return (latest_versions, preferred_versions)
+
+
+def allProviders(dataCache):
+    """
+    Find all providers for each pn
+    """
+    all_providers = defaultdict(list)
+    for (fn, pn) in dataCache.pkg_fn.items():
+        ver = dataCache.pkg_pepvpr[fn]
+        all_providers[pn].append((ver, fn))
+    return all_providers
+
+
 def sortPriorities(pn, dataCache, pkg_pn = None):
     """
     Reorder pkg_pn by file priority and default preference



