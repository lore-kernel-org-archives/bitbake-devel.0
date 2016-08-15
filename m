Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 39528758DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH0oqZ010836 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:00:50 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id i3YIBoGIHEDQ for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:00:50 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH0jH6010833
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:00:46 +0100
Message-ID: <1471280445.20391.96.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 18:00:45 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Make virtualfn2realfn/realfn2virtual standalone functions
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
X-List-Received-Date: Mon, 15 Aug 2016 17:00:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Needing to build an object to access these static methods doesn't
make sense. Move these to become module level standalone functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 658f30f..c915bb9 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -244,7 +244,26 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootdirs[fn] = self.fakerootdirs
         cachedata.extradepsfunc[fn] = self.extradepsfunc
 
+def virtualfn2realfn(virtualfn):
+    """
+    Convert a virtual file name to a real one + the associated subclass keyword
+    """
 
+    fn = virtualfn
+    cls = ""
+    if virtualfn.startswith('virtual:'):
+        elems = virtualfn.split(':')
+        cls = ":".join(elems[1:-1])
+        fn = elems[-1]
+    return (fn, cls)
+
+def realfn2virtual(realfn, cls):
+    """
+    Convert a real filename + the associated subclass keyword to a virtual filename
+    """
+    if cls == "":
+        return realfn
+    return "virtual:" + cls + ":" + realfn
 
 class Cache(object):
     """
@@ -355,30 +374,6 @@ class Cache(object):
                                                   len(self.depends_cache)),
                       self.data)
 
-    
-    @staticmethod
-    def virtualfn2realfn(virtualfn):
-        """
-        Convert a virtual file name to a real one + the associated subclass keyword
-        """
-
-        fn = virtualfn
-        cls = ""
-        if virtualfn.startswith('virtual:'):
-            elems = virtualfn.split(':')
-            cls = ":".join(elems[1:-1])
-            fn = elems[-1]
-        return (fn, cls)
-
-    @staticmethod
-    def realfn2virtual(realfn, cls):
-        """
-        Convert a real filename + the associated subclass keyword to a virtual filename
-        """
-        if cls == "":
-            return realfn
-        return "virtual:" + cls + ":" + realfn
-
     @classmethod
     def loadDataFull(cls, virtualfn, appends, cfgData):
         """
@@ -386,7 +381,7 @@ class Cache(object):
         To do this, we need to parse the file.
         """
 
-        (fn, virtual) = cls.virtualfn2realfn(virtualfn)
+        (fn, virtual) = virtualfn2realfn(virtualfn)
 
         logger.debug(1, "Parsing %s (full)", fn)
 
@@ -406,7 +401,7 @@ class Cache(object):
         for variant, data in sorted(datastores.items(),
                                     key=lambda i: i[0],
                                     reverse=True):
-            virtualfn = cls.realfn2virtual(filename, variant)
+            virtualfn = realfn2virtual(filename, variant)
             variants.append(variant)
             depends = depends + (data.getVar("__depends", False) or [])
             if depends and not variant:
@@ -435,7 +430,7 @@ class Cache(object):
             # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
             info_array = self.depends_cache[filename]
             for variant in info_array[0].variants:
-                virtualfn = self.realfn2virtual(filename, variant)
+                virtualfn = realfn2virtual(filename, variant)
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
         else:
             return self.parse(filename, appends, configdata, self.caches_array)
@@ -556,7 +551,7 @@ class Cache(object):
 
         invalid = False
         for cls in info_array[0].variants:
-            virtualfn = self.realfn2virtual(fn, cls)
+            virtualfn = realfn2virtual(fn, cls)
             self.clean.add(virtualfn)
             if virtualfn not in self.depends_cache:
                 logger.debug(2, "Cache: %s is not cached", virtualfn)
@@ -568,7 +563,7 @@ class Cache(object):
         # If any one of the variants is not present, mark as invalid for all
         if invalid:
             for cls in info_array[0].variants:
-                virtualfn = self.realfn2virtual(fn, cls)
+                virtualfn = realfn2virtual(fn, cls)
                 if virtualfn in self.clean:
                     logger.debug(2, "Cache: Removing %s from cache", virtualfn)
                     self.clean.remove(virtualfn)
@@ -645,7 +640,7 @@ class Cache(object):
         Save data we need into the cache
         """
 
-        realfn = self.virtualfn2realfn(file_name)[0]
+        realfn = virtualfn2realfn(file_name)[0]
 
         info_array = []
         for cache_class in self.caches_array:
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d4dd23f..11c611d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -601,9 +601,9 @@ class BBCooker:
             # this showEnvironment() code path doesn't use the cache
             self.parseConfiguration()
 
-            fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
+            fn, cls = bb.cache.virtualfn2realfn(buildfile)
             fn = self.matchFile(fn)
-            fn = bb.cache.Cache.realfn2virtual(fn, cls)
+            fn = bb.cache.realfn2virtual(fn, cls)
         elif len(pkgs_to_build) == 1:
             ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
             if pkgs_to_build[0] in set(ignore.split()):
@@ -1249,7 +1249,7 @@ class BBCooker:
         if (task == None):
             task = self.configuration.cmd
 
-        fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
+        fn, cls = bb.cache.virtualfn2realfn(buildfile)
         fn = self.matchFile(fn)
 
         self.buildSetVars()
@@ -1259,7 +1259,7 @@ class BBCooker:
                                      self.caches_array)
         infos = dict(infos)
 
-        fn = bb.cache.Cache.realfn2virtual(fn, cls)
+        fn = bb.cache.realfn2virtual(fn, cls)
         try:
             info_array = infos[fn]
         except KeyError:
@@ -1822,7 +1822,7 @@ class CookerCollectFiles(object):
         # Calculate priorities for each file
         matched = set()
         for p in pkgfns:
-            realfn, cls = bb.cache.Cache.virtualfn2realfn(p)
+            realfn, cls = bb.cache.virtualfn2realfn(p)
             priorities[p] = self.calc_bbfile_priority(realfn, matched)
 
         # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index 0a49681..6e62082 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -170,7 +170,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 
             if len(allproviders[p]) > 1 or not show_multi_provider_only:
                 pref = preferred_versions[p]
-                realfn = bb.cache.Cache.virtualfn2realfn(pref[1])
+                realfn = bb.cache.virtualfn2realfn(pref[1])
                 preffile = realfn[0]
 
                 # We only display once per recipe, we should prefer non extended versions of the
@@ -200,7 +200,7 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
                     same_ver = True
                     provs = []
                     for prov in allproviders[p]:
-                        provfile = bb.cache.Cache.virtualfn2realfn(prov[1])[0]
+                        provfile = bb.cache.virtualfn2realfn(prov[1])[0]
                         provlayer = self.get_file_layer(provfile)
                         provs.append((provfile, provlayer, prov[0]))
                         if provlayer != preflayer:
@@ -297,7 +297,7 @@ Lists recipes with the bbappends that apply to them as subitems.
     def get_appends_for_files(self, filenames):
         appended, notappended = [], []
         for filename in filenames:
-            _, cls = bb.cache.Cache.virtualfn2realfn(filename)
+            _, cls = bb.cache.virtualfn2realfn(filename)
             if cls:
                 continue
 
@@ -328,7 +328,7 @@ NOTE: .bbappend files can impact the dependencies.
 
         # The bb's DEPENDS and RDEPENDS
         for f in pkg_fn:
-            f = bb.cache.Cache.virtualfn2realfn(f)[0]
+            f = bb.cache.virtualfn2realfn(f)[0]
             # Get the layername that the file is in
             layername = self.get_file_layer(f)
 
@@ -471,7 +471,7 @@ NOTE: .bbappend files can impact the dependencies.
 
     def check_cross_depends(self, keyword, layername, f, needed_file, show_filenames, ignore_layers):
         """Print the DEPENDS/RDEPENDS file that crosses a layer boundary"""
-        best_realfn = bb.cache.Cache.virtualfn2realfn(needed_file)[0]
+        best_realfn = bb.cache.virtualfn2realfn(needed_file)[0]
         needed_layername = self.get_file_layer(best_realfn)
         if needed_layername != layername and not needed_layername in ignore_layers:
             if not show_filenames:



