Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web10.48879.1591048192386352241
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=A7WTAv3g;
 spf=pass (domain: gmail.com, ip: 209.85.216.65, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f65.google.com with SMTP id fs4so388400pjb.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwCWVLT0oyWHKwgL4bh1eHTkUljpexOUwLwkpQRWdrs=;
        b=A7WTAv3gpv3PrdHfWrSiLABrmVnfb3EvtQvztoVvnEmjO9xMKworYhPqdfGR4cu+Q6
         oEwupUg62Iu8PtyFmGVbD11wvOL6/o0ZrCPPzfBXHFnyCUCfuDw6fOqIGI4rrdsfoVsF
         X6IpxzlsMUV75vJ8WliSWY5EfKs4MxFmJRGfaw+r6EK2dNfDb3ZUzmqpXRxuU5gQp00H
         jJcEVgspemtRppda0WyjPobZLjTBS054v3GR4mOS3klj0Cs2MYZsI4Pa+5giutzBwD8i
         2Js/vKoNWx43RMtRG2y0dd+KZo9L6Wg/quPHt4g2J5OKOimbKJ9h+9wcVcEf71wC6Jlh
         o58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwCWVLT0oyWHKwgL4bh1eHTkUljpexOUwLwkpQRWdrs=;
        b=XdlorDbDhuySExsRM+LoFGAlmodnKnn8zM/fAXe1jNw+Odr5Fa2OmXi3DoE+HfDV2M
         A3xW3U5Yh28XeW9JIAdmjEXqjz+yQWZIzA8ewOpJZCZRZDVbujIt59uCyU2bUBIjduhD
         w4MN2DcHxqXQ6Kh6ajQPytuvq5MGDIasqnjrEBPJzupq+0D/L0UGWxBQb5CW87/aEa35
         nGhklnrnDYeam/aYpMRrj2Z1lQ5sKO1wzsegDLH17c2IYKIkhkVpZE+QnZG6zpt0MAkO
         vvEAroEOoh5XFW/cOO9nrBvR0n0M24kr+cY0DwG8hDiGxA8raoBwupIYku7VDlluK651
         uCcw==
X-Gm-Message-State: AOAM533LUUpX4s6qDv+ZxKtrEjIT/0UhI+KuwPIv6cBdUu2hFpi3Eb3m
	ww+D9yQ6l2XzKpJ94F6a0cwZ3PFtf4A=
X-Google-Smtp-Source: ABdhPJyWuxfOhLB0uNQIHvQC0N/xV2UhnN63K1sF8FVXCpidIZ/NGuL5tcLTX0O6tKhZVpaW69ZgnA==
X-Received: by 2002:a17:90a:a08d:: with SMTP id r13mr1534571pjp.96.1591048191358;
        Mon, 01 Jun 2020 14:49:51 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:50 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 2/8] bitbake: cache: Use multiconfig aware caches
Date: Mon,  1 Jun 2020 16:49:39 -0500
Message-Id: <20200601214945.32481-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splits the parsing cache to maintain one cache per multiconfig instead
of one global cache. This is necessary now that the files and appends
can vary for each multiconfig. A bb.cache.MulticonfigCache
dictionary-like proxy object is created instead of a single
bb.cache.Cache object. This object will create and properly initialize
bb.cache.Cache object for each multiconfig, and each of these caches has
a dedicated cache file with a name based on the multiconfig.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py  | 143 +++++++++++++++++++++++++++++----------
 bitbake/lib/bb/cooker.py |  42 +++++++-----
 2 files changed, 133 insertions(+), 52 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index aa5ec5b591..954418384b 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -19,7 +19,7 @@
 import os
 import logging
 import pickle
-from collections import defaultdict
+from collections import defaultdict, Mapping
 import bb.utils
 import re
 
@@ -27,8 +27,11 @@ logger = logging.getLogger("BitBake.Cache")
 
 __cache_version__ = "152"
 
-def getCacheFile(path, filename, data_hash):
-    return os.path.join(path, filename + "." + data_hash)
+def getCacheFile(path, filename, mc, data_hash):
+    mcspec = ''
+    if mc:
+        mcspec = ".%s" % mc
+    return os.path.join(path, filename + mcspec + "." + data_hash)
 
 # RecipeInfoCommon defines common data retrieving methods
 # from meta data for caches. CoreRecipeInfo as well as other
@@ -354,14 +357,14 @@ class Cache(NoCache):
     """
     BitBake Cache implementation
     """
-
-    def __init__(self, databuilder, data_hash, caches_array):
+    def __init__(self, databuilder, mc, data_hash, caches_array):
         super().__init__(databuilder)
         data = databuilder.data
 
         # Pass caches_array information into Cache Constructor
         # It will be used later for deciding whether we
         # need extra cache file dump/load support
+        self.mc = mc
         self.caches_array = caches_array
         self.cachedir = data.getVar("CACHE")
         self.clean = set()
@@ -379,7 +382,17 @@ class Cache(NoCache):
             return
 
         self.has_cache = True
-        self.cachefile = getCacheFile(self.cachedir, "bb_cache.dat", self.data_hash)
+
+    def getCacheFile(self, cachefile):
+        return getCacheFile(self.cachedir, cachefile, self.mc, self.data_hash)
+
+    def prepare_cache(self, progress):
+        if not self.has_cache:
+            return 0
+
+        loaded = 0
+
+        self.cachefile = self.getCacheFile("bb_cache.dat")
 
         logger.debug(1, "Cache dir: %s", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
@@ -387,18 +400,22 @@ class Cache(NoCache):
         cache_ok = True
         if self.caches_array:
             for cache_class in self.caches_array:
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+                cachefile = self.getCacheFile(cache_class.cachefile)
                 cache_ok = cache_ok and os.path.exists(cachefile)
                 cache_class.init_cacheData(self)
         if cache_ok:
-            self.load_cachefile()
+            loaded = self.load_cachefile(progress)
         elif os.path.isfile(self.cachefile):
             logger.info("Out of date cache found, rebuilding...")
         else:
             logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
 
         # We don't use the symlink, its just for debugging convinience
-        symlink = os.path.join(self.cachedir, "bb_cache.dat")
+        if self.mc:
+            symlink = os.path.join(self.cachedir, "bb_cache.dat.%s" % self.mc)
+        else:
+            symlink = os.path.join(self.cachedir, "bb_cache.dat")
+
         if os.path.exists(symlink):
             bb.utils.remove(symlink)
         try:
@@ -406,21 +423,30 @@ class Cache(NoCache):
         except OSError:
             pass
 
-    def load_cachefile(self):
-        cachesize = 0
-        previous_progress = 0
-        previous_percent = 0
+        return loaded
+
+    def cachesize(self):
+        if not self.has_cache:
+            return 0
 
-        # Calculate the correct cachesize of all those cache files
+        cachesize = 0
         for cache_class in self.caches_array:
-            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-            with open(cachefile, "rb") as cachefile:
-                cachesize += os.fstat(cachefile.fileno()).st_size
+            cachefile = self.getCacheFile(cache_class.cachefile)
+            try:
+                with open(cachefile, "rb") as cachefile:
+                    cachesize += os.fstat(cachefile.fileno()).st_size
+            except FileNotFoundError:
+                pass
 
-        bb.event.fire(bb.event.CacheLoadStarted(cachesize), self.data)
+        return cachesize
+
+    def load_cachefile(self, progress):
+        cachesize = self.cachesize()
+        previous_progress = 0
+        previous_percent = 0
 
         for cache_class in self.caches_array:
-            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            cachefile = self.getCacheFile(cache_class.cachefile)
             logger.debug(1, 'Loading cache file: %s' % cachefile)
             with open(cachefile, "rb") as cachefile:
                 pickled = pickle.Unpickler(cachefile)
@@ -460,23 +486,11 @@ class Cache(NoCache):
                         self.depends_cache[key] = [value]
                     # only fire events on even percentage boundaries
                     current_progress = cachefile.tell() + previous_progress
-                    if current_progress > cachesize:
-                        # we might have calculated incorrect total size because a file
-                        # might've been written out just after we checked its size
-                        cachesize = current_progress
-                    current_percent = 100 * current_progress / cachesize
-                    if current_percent > previous_percent:
-                        previous_percent = current_percent
-                        bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
-                                      self.data)
+                    progress(cachefile.tell() + previous_progress)
 
                 previous_progress += current_progress
 
-        # Note: depends cache number is corresponding to the parsing file numbers.
-        # The same file has several caches, still regarded as one item in the cache
-        bb.event.fire(bb.event.CacheLoadCompleted(cachesize,
-                                                  len(self.depends_cache)),
-                      self.data)
+        return len(self.depends_cache)
 
     def parse(self, filename, appends):
         """Parse the specified filename, returning the recipe information"""
@@ -682,7 +696,7 @@ class Cache(NoCache):
 
         for cache_class in self.caches_array:
             cache_class_name = cache_class.__name__
-            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            cachefile = self.getCacheFile(cache_class.cachefile)
             with open(cachefile, "wb") as f:
                 p = pickle.Pickler(f, pickle.HIGHEST_PROTOCOL)
                 p.dump(__cache_version__)
@@ -701,7 +715,7 @@ class Cache(NoCache):
         return bb.parse.cached_mtime_noerror(cachefile)
 
     def add_info(self, filename, info_array, cacheData, parsed=None, watcher=None):
-        if isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
+        if cacheData is not None and isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
             cacheData.add_from_recipeinfo(filename, info_array)
 
             if watcher:
@@ -727,6 +741,65 @@ class Cache(NoCache):
             info_array.append(cache_class(realfn, data))
         self.add_info(file_name, info_array, cacheData, parsed)
 
+class MulticonfigCache(Mapping):
+    def __init__(self, databuilder, data_hash, caches_array):
+        def progress(p):
+            nonlocal current_progress
+            nonlocal previous_progress
+            nonlocal previous_percent
+            nonlocal cachesize
+
+            current_progress = previous_progress + p
+
+            if current_progress > cachesize:
+                # we might have calculated incorrect total size because a file
+                # might've been written out just after we checked its size
+                cachesize = current_progress
+            current_percent = 100 * current_progress / cachesize
+            if current_percent > previous_percent:
+                previous_percent = current_percent
+                bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
+                                databuilder.data)
+
+
+        cachesize = 0
+        current_progress = 0
+        previous_progress = 0
+        previous_percent = 0
+        self.__caches = {}
+
+        for mc, mcdata in databuilder.mcdata.items():
+            self.__caches[mc] = Cache(databuilder, mc, data_hash, caches_array)
+
+            cachesize += self.__caches[mc].cachesize()
+
+        bb.event.fire(bb.event.CacheLoadStarted(cachesize), databuilder.data)
+        loaded = 0
+
+        for c in self.__caches.values():
+            loaded += c.prepare_cache(progress)
+            previous_progress = current_progress
+
+        # Note: depends cache number is corresponding to the parsing file numbers.
+        # The same file has several caches, still regarded as one item in the cache
+        bb.event.fire(bb.event.CacheLoadCompleted(cachesize, loaded), databuilder.data)
+
+    def __len__(self):
+        return len(self.__caches)
+
+    def __getitem__(self, key):
+        return self.__caches[key]
+
+    def __contains__(self, key):
+        return key in self.__caches
+
+    def __iter__(self):
+        for k in self.__caches:
+            yield k
+
+    def keys(self):
+        return self.__caches[key]
+
 
 def init(cooker):
     """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8f45233c8d..50526d52b2 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -541,8 +541,8 @@ class BBCooker:
 
         if fn:
             try:
-                bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
-                envdata = bb_cache.loadDataFull(fn, self.collections[mc].get_file_appends(fn))
+                bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.data_hash, self.caches_array)
+                envdata = bb_caches[mc].loadDataFull(fn, self.collections[mc].get_file_appends(fn))
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
@@ -1328,9 +1328,9 @@ class BBCooker:
         self.buildSetVars()
         self.reset_mtime_caches()
 
-        bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
+        bb_caches = bb.cache.MulticonfigCache(self.databuilder, self.data_hash, self.caches_array)
 
-        infos = bb_cache.parse(fn, self.collections[mc].get_file_appends(fn))
+        infos = bb_caches[mc].parse(fn, self.collections[mc].get_file_appends(fn))
         infos = dict(infos)
 
         fn = bb.cache.realfn2virtual(fn, cls, mc)
@@ -1968,7 +1968,7 @@ class Parser(multiprocessing.Process):
             except queue.Full:
                 pending.append(result)
 
-    def parse(self, filename, appends):
+    def parse(self, mc, cache, filename, appends):
         try:
             origfilter = bb.event.LogHandler.filter
             # Record the filename we're parsing into any events generated
@@ -1982,7 +1982,7 @@ class Parser(multiprocessing.Process):
             bb.event.set_class_handlers(self.handlers.copy())
             bb.event.LogHandler.filter = parse_filter
 
-            return True, self.bb_cache.parse(filename, appends)
+            return True, mc, cache.parse(filename, appends)
         except Exception as exc:
             tb = sys.exc_info()[2]
             exc.recipe = filename
@@ -2016,16 +2016,16 @@ class CookerParser(object):
         self.current = 0
         self.process_names = []
 
-        self.bb_cache = bb.cache.Cache(self.cfgbuilder, self.cfghash, cooker.caches_array)
+        self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder, self.cfghash, cooker.caches_array)
         self.fromcache = set()
         self.willparse = set()
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends = self.cooker.collections[mc].get_file_appends(filename)
-                if not self.bb_cache.cacheValid(filename, appends):
-                    self.willparse.add((filename, appends))
+                if not self.bb_caches[mc].cacheValid(filename, appends):
+                    self.willparse.add((mc, self.bb_caches[mc], filename, appends))
                 else:
-                    self.fromcache.add((filename, appends))
+                    self.fromcache.add((mc, self.bb_caches[mc], filename, appends))
 
         self.total = len(self.fromcache) + len(self.willparse)
         self.toparse = len(self.willparse)
@@ -2043,7 +2043,6 @@ class CookerParser(object):
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
             def init():
-                Parser.bb_cache = self.bb_cache
                 bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
@@ -2099,7 +2098,11 @@ class CookerParser(object):
             else:
                 process.join()
 
-        sync = threading.Thread(target=self.bb_cache.sync)
+        def sync_caches():
+            for c in self.bb_caches.values():
+                c.sync()
+
+        sync = threading.Thread(target=sync_caches)
         sync.start()
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
         bb.codeparser.parser_cache_savemerge()
@@ -2116,8 +2119,8 @@ class CookerParser(object):
             print("Processed parsing statistics saved to %s" % (pout))
 
     def load_cached(self):
-        for mc, filename, appends in self.fromcache:
-            cached, infos = self.bb_cache.load(mc, filename, appends)
+        for mc, cache, filename, appends in self.fromcache:
+            cached, infos = cache.load(filename, appends)
             yield not cached, mc, infos
 
     def parse_generator(self):
@@ -2196,8 +2199,13 @@ class CookerParser(object):
             if info_array[0].skipped:
                 self.skipped += 1
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
-            (fn, cls, mc) = bb.cache.virtualfn2realfn(virtualfn)
-            self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecaches[mc],
+            (fn, cls, fnmc) = bb.cache.virtualfn2realfn(virtualfn)
+
+            if fnmc == mc:
+                cache = self.cooker.recipecaches[mc]
+            else:
+                cache = None
+            self.bb_caches[mc].add_info(virtualfn, info_array, cache,
                                         parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
 
@@ -2207,6 +2215,6 @@ class CookerParser(object):
             to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename)))
 
         for mc, filename, appends in to_reparse:
-            infos = self.bb_cache.parse(filename, appends)
+            infos = self.bb_caches[mc].parse(filename, appends)
             for vfn, info_array in infos:
                 self.cooker.recipecaches[mc].add_from_recipeinfo(vfn, info_array)
-- 
2.26.2

