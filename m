Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5cz-0001FS-9X
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:17 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Dec 2011 23:14:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="87545436"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 14 Dec 2011 23:14:19 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:53 +0800
Message-Id: <1ef50ac57fc6ab1bf0f49c4c1ef476786a963577.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
Subject: [PATCH 02/10] cache: Use configuration's hash value to validate cache
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:17 -0000

Previously we use the file time stamp to judge if a cache is valid.
Here this commit introduce a new method, which calculates the total
hash value for a certain configuration's key/value paris, and tag
it into cache filename, for example, bb_cache.dat.xxxyyyzzz.

This mechanism also ensures the cache's correctness if user
dynamically setting variables from some frontend GUI, like HOB.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/cache.py      |   32 ++++++++++++--------------------
 lib/bb/cooker.py     |    4 +++-
 lib/bb/data_smart.py |   17 +++++++++++++++++
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 6b7fa6f..955b6df 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -42,10 +42,10 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "142"
+__cache_version__ = "143"
 
-def getCacheFile(path, filename):
-    return os.path.join(path, filename)
+def getCacheFile(path, filename, data_hash):
+    return os.path.join(path, filename + "." + data_hash)
 
 # RecipeInfoCommon defines common data retrieving methods
 # from meta data for caches. CoreRecipeInfo as well as other
@@ -254,7 +254,7 @@ class Cache(object):
     BitBake Cache implementation
     """
 
-    def __init__(self, data, caches_array):
+    def __init__(self, data, data_hash, caches_array):
         # Pass caches_array information into Cache Constructor
         # It will be used in later for deciding whether we 
         # need extra cache file dump/load support 
@@ -266,6 +266,7 @@ class Cache(object):
         self.data = None
         self.data_fn = None
         self.cacheclean = True
+        self.data_hash = data_hash
 
         if self.cachedir in [None, '']:
             self.has_cache = False
@@ -274,26 +275,17 @@ class Cache(object):
             return
 
         self.has_cache = True
-        self.cachefile = getCacheFile(self.cachedir, "bb_cache.dat")
+        self.cachefile = getCacheFile(self.cachedir, "bb_cache.dat", self.data_hash)
 
         logger.debug(1, "Using cache in '%s'", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
 
-        # If any of configuration.data's dependencies are newer than the
-        # cache there isn't even any point in loading it...
-        newest_mtime = 0
-        deps = data.getVar("__base_depends")
-
-        old_mtimes = [old_mtime for _, old_mtime in deps]
-        old_mtimes.append(newest_mtime)
-        newest_mtime = max(old_mtimes)
-
         cache_ok = True
         if self.caches_array:
             for cache_class in self.caches_array:
                 if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                    cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
-                    cache_ok = cache_ok and (bb.parse.cached_mtime_noerror(cachefile) >= newest_mtime)
+                    cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+                    cache_ok = cache_ok and os.path.exists(cachefile)
                     cache_class.init_cacheData(self)
         if cache_ok:
             self.load_cachefile()
@@ -327,7 +319,7 @@ class Cache(object):
         # Calculate the correct cachesize of all those cache files
         for cache_class in self.caches_array:
             if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
                 with open(cachefile, "rb") as cachefile:
                     cachesize += os.fstat(cachefile.fileno()).st_size
 
@@ -335,7 +327,7 @@ class Cache(object):
         
         for cache_class in self.caches_array:
             if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
                 with open(cachefile, "rb") as cachefile:
                     pickled = pickle.Unpickler(cachefile)                    
                     while cachefile:
@@ -588,7 +580,7 @@ class Cache(object):
         for cache_class in self.caches_array:
             if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
                 cache_class_name = cache_class.__name__
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
                 file_dict[cache_class_name] = open(cachefile, "wb")
                 pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
                    
@@ -693,7 +685,7 @@ def init(cooker):
     Files causing parsing errors are evicted from the cache.
 
     """
-    return Cache(cooker.configuration.data)
+    return Cache(cooker.configuration.data, cooker.configuration.data_hash)
 
 
 class CacheData(object):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index cbe0d71..2c02e28 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -832,6 +832,7 @@ class BBCooker:
         bb.parse.init_parser(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
         self.configuration.data = data
+        self.configuration.data_hash = data.get_hash()
 
     def handleCollections( self, collections ):
         """Handle collections"""
@@ -1399,6 +1400,7 @@ class CookerParser(object):
         self.filelist = filelist
         self.cooker = cooker
         self.cfgdata = cooker.configuration.data
+        self.cfghash = cooker.configuration.data_hash
 
         # Accounting statistics
         self.parsed = 0
@@ -1414,7 +1416,7 @@ class CookerParser(object):
         self.num_processes = int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
                                  multiprocessing.cpu_count())
 
-        self.bb_cache = bb.cache.Cache(self.cfgdata, cooker.caches_array)
+        self.bb_cache = bb.cache.Cache(self.cfgdata, self.cfghash, cooker.caches_array)
         self.fromcache = []
         self.willparse = []
         for filename in self.filelist:
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index ea13478..06d8d0b 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -31,6 +31,7 @@ BitBake build tools.
 import copy, re
 from collections import MutableMapping
 import logging
+import hashlib
 import bb, bb.codeparser
 from bb   import utils
 from bb.COW  import COWDictBase
@@ -459,3 +460,19 @@ class DataSmart(MutableMapping):
 
     def __delitem__(self, var):
         self.delVar(var)
+
+    def get_hash(self):
+        data = ""
+        keys = iter(self)
+        for key in keys:
+            if key == "TIME":
+                continue
+            if key == "__depends":
+                deps = list(self.getVar(key, False))
+                deps.sort()
+                value = [deps[i][0] for i in range(len(deps))]
+            else:
+                value = self.getVar(key, False) or ""
+            data = data + key + str(value)
+
+        return hashlib.md5(data).hexdigest()
-- 
1.7.0.4



