Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QSJ6p-0000sV-Gl
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 03:23:32 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 02 Jun 2011 18:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,312,1304319600"; d="scan'208";a="11177247"
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.48])
	by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2011 18:19:13 -0700
From: Ke Liping <liping.ke@intel.com>
To: poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jun 2011 09:06:04 +0800
Message-Id: <98c7028eaf685418080016b7f37b817e5f7561ce.1307062861.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
Subject: [PATCH 4/4][Image Creator]Implement multiple extra cache fields request support
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
X-List-Received-Date: Fri, 03 Jun 2011 01:23:32 -0000

From: Liping Ke <liping.ke@intel.com>

This patch is to support extra cache. If user needs to request
extra cache fields besides CoreRecipeInfo fields, just add a new
XXXRecipeInfo class definition as Hob Does.
Currently supported Extra RecipeInfo name is an array. We can
support multiple extra cache fields at the same time besides
CoreRecipeInfo which is needed by all clients.

Signed-off-by: Liping Ke <liping.ke@intel.com>
---
 bitbake/lib/bb/cache.py  |  177 +++++++++++++++++++++++++++++++---------------
 bitbake/lib/bb/cooker.py |   16 ++--
 2 files changed, 127 insertions(+), 66 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 0620621..5b8e3ee 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,8 +43,10 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "138"
+__cache_version__ = "139"
 
+def getCacheFile(path, filename):
+    return os.path.join(path, filename)
 
 # RecipeInfoCommon defines common data retrieving methods
 # from meta data for caches. CoreRecipeInfo as well as other
@@ -86,12 +88,9 @@ class RecipeInfoCommon(object):
 class CoreRecipeInfo(RecipeInfoCommon):
     __slots__ = ()
 
-    def __init__(self, filename, metadata):
-        self.name = "base"
-        # please override this member with the correct data cache file
-        # such as (bb_cache.dat, bb_extracache_hob.dat) 
-        self.cachefile = "bb_cache.dat"        
+    cachefile = "bb_cache.dat"   
 
+    def __init__(self, filename, metadata):      
         self.file_depends = metadata.getVar('__depends', False)
         self.timestamp = bb.parse.cached_mtime(filename)
         self.variants = self.listvar('__VARIANTS', metadata) + ['']
@@ -265,7 +264,7 @@ class Cache(object):
             return
 
         self.has_cache = True
-        self.cachefile = os.path.join(self.cachedir, "bb_cache.dat")
+        self.cachefile = getCacheFile(self.cachedir, "bb_cache.dat")
 
         logger.debug(1, "Using cache in '%s'", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
@@ -279,12 +278,21 @@ class Cache(object):
         old_mtimes.append(newest_mtime)
         newest_mtime = max(old_mtimes)
 
-        if bb.parse.cached_mtime_noerror(self.cachefile) >= newest_mtime:
+        bNeedUpdate = True
+        if self.caches_array:
+            for cache_class in self.caches_array:
+                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                    cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                    bNeedUpdate = bNeedUpdate and (bb.parse.cached_mtime_noerror(cachefile) >= newest_mtime)
+                    cache_class.init_cacheData(self)
+        if bNeedUpdate:
             self.load_cachefile()
         elif os.path.isfile(self.cachefile):
             logger.info("Out of date cache found, rebuilding...")
 
     def load_cachefile(self):
+        # Firstly, using core cache file information for
+        # valid checking
         with open(self.cachefile, "rb") as cachefile:
             pickled = pickle.Unpickler(cachefile)
             try:
@@ -301,31 +309,52 @@ class Cache(object):
                 logger.info('Bitbake version mismatch, rebuilding...')
                 return
 
-            cachesize = os.fstat(cachefile.fileno()).st_size
-            bb.event.fire(bb.event.CacheLoadStarted(cachesize), self.data)
 
-            previous_percent = 0
-            while cachefile:
-                try:
-                    key = pickled.load()
-                    value = pickled.load()
-                except Exception:
-                    break
+        cachesize = 0
+        previous_progress = 0
+        previous_percent = 0
 
-                self.depends_cache[key] = value
-
-                # only fire events on even percentage boundaries
-                current_progress = cachefile.tell()
-                current_percent = 100 * current_progress / cachesize
-                if current_percent > previous_percent:
-                    previous_percent = current_percent
-                    bb.event.fire(bb.event.CacheLoadProgress(current_progress),
-                                  self.data)
-
-            bb.event.fire(bb.event.CacheLoadCompleted(cachesize,
-                                                      len(self.depends_cache)),
-                          self.data)
+        # Calculate the correct cachesize of all those cache files
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                with open(cachefile, "rb") as cachefile:
+                    cachesize += os.fstat(cachefile.fileno()).st_size
 
+        bb.event.fire(bb.event.CacheLoadStarted(cachesize), self.data)
+        
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                with open(cachefile, "rb") as cachefile:
+                    pickled = pickle.Unpickler(cachefile)                    
+                    while cachefile:
+                        try:
+                            key = pickled.load()
+                            value = pickled.load()
+                        except Exception:
+                            break
+                        if self.depends_cache.has_key(key):
+                            self.depends_cache[key].append(value)
+                        else:
+                            self.depends_cache[key] = [value]
+                        # only fire events on even percentage boundaries
+                        current_progress = cachefile.tell() + previous_progress
+                        current_percent = 100 * current_progress / cachesize
+                        if current_percent > previous_percent:
+                            previous_percent = current_percent
+                            bb.event.fire(bb.event.CacheLoadProgress(current_progress),
+                                          self.data)
+
+                    previous_progress += current_progress
+
+        # Note: depends cache number is corresponding to the parsing file numbers.
+        # The same file has several caches, still regarded as one item in the cache
+        bb.event.fire(bb.event.CacheLoadCompleted(cachesize,
+                                                  len(self.depends_cache)),
+                      self.data)
+
+    
     @staticmethod
     def virtualfn2realfn(virtualfn):
         """
@@ -376,8 +405,14 @@ class Cache(object):
             depends |= (data.getVar("__depends", False) or set())
             if depends and not variant:
                 data.setVar("__depends", depends)
-            info = CoreRecipeInfo(filename, data)
-            infos.append((virtualfn, info))
+
+            info_array = []
+            for cache_class in caches_array:
+                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                    info = cache_class(filename, data)
+                    info_array.append(info)
+            infos.append((virtualfn, info_array))
+
         return infos
 
     def load(self, filename, appends, configdata):
@@ -391,8 +426,9 @@ class Cache(object):
         cached = self.cacheValid(filename)
         if cached:
             infos = []
-            info = self.depends_cache[filename]
-            for variant in info.variants:
+            # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
+            info_array = self.depends_cache[filename]
+            for variant in info_array[0].variants:
                 virtualfn = self.realfn2virtual(filename, variant)
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
         else:
@@ -408,12 +444,12 @@ class Cache(object):
         skipped, virtuals = 0, 0
 
         cached, infos = self.load(fn, appends, cfgData)
-        for virtualfn, info in infos:
-            if info.skipped:
+        for virtualfn, info_array in infos:
+            if info_array[0].skipped:
                 logger.debug(1, "Skipping %s", virtualfn)
                 skipped += 1
             else:
-                self.add_info(virtualfn, info, cacheData, not cached)
+                self.add_info(virtualfn, info_array, cacheData, not cached)
                 virtuals += 1
 
         return cached, skipped, virtuals
@@ -457,15 +493,15 @@ class Cache(object):
             self.remove(fn)
             return False
 
-        info = self.depends_cache[fn]
+        info_array = self.depends_cache[fn]
         # Check the file's timestamp
-        if mtime != info.timestamp:
+        if mtime != info_array[0].timestamp:
             logger.debug(2, "Cache: %s changed", fn)
             self.remove(fn)
             return False
 
         # Check dependencies are still valid
-        depends = info.file_depends
+        depends = info_array[0].file_depends
         if depends:
             for f, old_mtime in depends:
                 fmtime = bb.parse.cached_mtime_noerror(f)
@@ -483,7 +519,7 @@ class Cache(object):
                     return False
 
         invalid = False
-        for cls in info.variants:
+        for cls in info_array[0].variants:
             virtualfn = self.realfn2virtual(fn, cls)
             self.clean.add(virtualfn)
             if virtualfn not in self.depends_cache:
@@ -530,13 +566,30 @@ class Cache(object):
             logger.debug(2, "Cache is clean, not saving.")
             return
 
-        with open(self.cachefile, "wb") as cachefile:
-            pickler = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
-            pickler.dump(__cache_version__)
-            pickler.dump(bb.__version__)
-            for key, value in self.depends_cache.iteritems():
-                pickler.dump(key)
-                pickler.dump(value)
+        file_dict = {}
+        pickler_dict = {}
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                cache_class_name = cache_class.__name__
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                file_dict[cache_class_name] = open(cachefile, "wb")
+                pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
+                   
+        pickler_dict['CoreRecipeInfo'].dump(__cache_version__)
+        pickler_dict['CoreRecipeInfo'].dump(bb.__version__)
+
+        try:
+            for key, info_array in self.depends_cache.iteritems():
+                for info in info_array:
+                    if isinstance(info, RecipeInfoCommon):
+                        cache_class_name = info.__class__.__name__
+                        pickler_dict[cache_class_name].dump(key)
+                        pickler_dict[cache_class_name].dump(info)
+        finally:
+            for cache_class in self.caches_array:
+                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                    cache_class_name = cache_class.__name__
+                    file_dict[cache_class_name].close()
 
         del self.depends_cache
 
@@ -544,17 +597,17 @@ class Cache(object):
     def mtime(cachefile):
         return bb.parse.cached_mtime_noerror(cachefile)
 
-    def add_info(self, filename, info, cacheData, parsed=None):
-        if not info.skipped:
-            cacheData.add_from_recipeinfo(filename, info)
+    def add_info(self, filename, info_array, cacheData, parsed=None):
+        if isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
+            cacheData.add_from_recipeinfo(filename, info_array)
 
         if not self.has_cache:
             return
 
-        if (info.skipped or 'SRCREVINACTION' not in info.pv) and not info.nocache:
+        if (info_array[0].skipped or 'SRCREVINACTION' not in info_array[0].pv) and not info_array[0].nocache:
             if parsed:
                 self.cacheclean = False
-            self.depends_cache[filename] = info
+            self.depends_cache[filename] = info_array
 
     def add(self, file_name, data, cacheData, parsed=None):
         """
@@ -562,8 +615,12 @@ class Cache(object):
         """
 
         realfn = self.virtualfn2realfn(file_name)[0]
-        info = CoreRecipeInfo(realfn, data)
-        self.add_info(file_name, info, cacheData, parsed)
+
+        info_array = []
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                info_array.append(cache_class(realfn, data))
+        self.add_info(file_name, info_array, cacheData, parsed)
 
     @staticmethod
     def load_bbfile(bbfile, appends, config):
@@ -629,7 +686,10 @@ class CacheData(object):
 
     def __init__(self, caches_array):
         self.caches_array = caches_array
-        CoreRecipeInfo.init_cacheData(self)
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                cache_class.init_cacheData(self)        
+
         # Direct cache variables
         self.task_queues = {}
         self.preferred = {}
@@ -640,7 +700,8 @@ class CacheData(object):
         self.bbfile_priority = {}
         self.bbfile_config_priorities = []
 
-    def add_from_recipeinfo(self, fn, info):
-        info.add_cacheData(self, fn)
+    def add_from_recipeinfo(self, fn, info_array):
+        for info in info_array:
+            info.add_cacheData(self, fn)
 
         
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 89da7e9..8379d0c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -773,13 +773,13 @@ class BBCooker:
 
         fn = bb.cache.Cache.realfn2virtual(fn, cls)
         try:
-            maininfo = infos[fn]
+            info_array = infos[fn]
         except KeyError:
             bb.fatal("%s does not exist" % fn)
-        self.status.add_from_recipeinfo(fn, maininfo)
+        self.status.add_from_recipeinfo(fn, info_array)
 
         # Tweak some variables
-        item = maininfo.pn
+        item = info_array[0].pn
         self.status.ignored_dependencies = set()
         self.status.bbfile_priority[fn] = 1
 
@@ -1231,10 +1231,10 @@ class CookerParser(object):
         else:
             self.cached += 1
 
-        for virtualfn, info in result:
-            if info.skipped:
+        for virtualfn, info_array in result:
+            if info_array[0].skipped:
                 self.skipped += 1
-            self.bb_cache.add_info(virtualfn, info, self.cooker.status,
+            self.bb_cache.add_info(virtualfn, info_array, self.cooker.status,
                                         parsed=parsed)
         return True
 
@@ -1242,5 +1242,5 @@ class CookerParser(object):
         infos = self.bb_cache.parse(filename,
                                     self.cooker.get_file_appends(filename),
                                     self.cfgdata, self.cooker.caches_array)
-        for vfn, info in infos:
-            self.cooker.status.add_from_recipeinfo(vfn, info)
+        for vfn, info_array in infos:
+            self.cooker.status.add_from_recipeinfo(vfn, info_array)
-- 
1.7.0.4



