Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web10.3739.1591413354233803184
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=qSqGMQW2;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id y18so12613676iow.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ziSFLxhm6NthmsXQHeuSFiZkAZiurqTzfBa3l7e1kvc=;
        b=qSqGMQW2nECsrsSApAszDwPlOQLCC4bArFnYTuYz7UZHp0fvVtWnILM6oOq80LWWIW
         9+051zpxjf8/jnbpqCxDrFO4kRbxNhCMtYHdKRxktbKs78LiqOCjuLABF96Ex9pja/SH
         VrWzl6VWMFXGjyFUv0kD/GcpP+C3KCOzVchMZMMqoWlSlW9q6eV0y1Va/YPV2R6MJ5Q5
         7emZrvNzqccKHYr2RMd+7pwAwI/k/BC8Cbn+qdyi7mZM1a/pHsiQBz4w+5PKpbEaeMkd
         3YaPc6taY3WPDXRsJz/7FS69BORCdG1drANaT6f7Lgc/21bYnkmLi786jxhBvHN/iOGD
         vV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ziSFLxhm6NthmsXQHeuSFiZkAZiurqTzfBa3l7e1kvc=;
        b=CqRE9X1wUC5XPN3BLOQfzhn1bu08FV9ZXcyLRFSv9cpS0Fj0ZSKImZXLjvzJNDVlqc
         mzX4sz5YyolzuwNzetpdb1F2obJpXtE3R8/CYEzeG0yQDDhXjcoi3dMGwtXHYaSEeMUT
         qo9crml+y+bVJAq+ba4KJkC8vZRvD7uWuvVfmZFCkCNkPsLStgxUtA9I12gP9mvOY3K6
         509/mlU9Sv7K+Z7VvQ1A4G4C064Bj4qGEf8jNJwK8lgV8CmCPfqz/ZqbzeJWt53+eXFV
         7GkkwazzS1KZ0gtXu4q5dF14nxdvp+0kydoQPrJp0/sMbEz0yozrc564ENZ9LHT29eDn
         ENJQ==
X-Gm-Message-State: AOAM533W49Ktgj06tWgG1qHbPszVlbMi6wtgorP9Makss0hVhdkt+O0x
	PqsLO2anXbuZYDkW//GoCLG3pzvnxUs=
X-Google-Smtp-Source: ABdhPJya23OgtQyltE+OWBAQHFvPsqW7Ub3LfNIbx0SPkYyUfyx6gGvkfkbe3yl8setAEW/PWu2cJw==
X-Received: by 2002:a05:6602:2437:: with SMTP id g23mr11320190iob.5.1591413353292;
        Fri, 05 Jun 2020 20:15:53 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:52 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 5/8] bitbake: cache: Improve logging
Date: Fri,  5 Jun 2020 22:15:33 -0500
Message-Id: <20200606031536.15956-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves the logging of Cache objects by prefixing the log messages with
the multiconfig name of the cache, so as to distinguish between multiple
instances of the class. Also adds a more log messages.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 65 ++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 954418384b..b34bfa9b5a 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -21,6 +21,7 @@ import logging
 import pickle
 from collections import defaultdict, Mapping
 import bb.utils
+from bb import PrefixLoggerAdapter
 import re
 
 logger = logging.getLogger("BitBake.Cache")
@@ -365,6 +366,7 @@ class Cache(NoCache):
         # It will be used later for deciding whether we
         # need extra cache file dump/load support
         self.mc = mc
+        self.logger = PrefixLoggerAdapter("Cache: %s: " % (mc if mc else "default"), logger)
         self.caches_array = caches_array
         self.cachedir = data.getVar("CACHE")
         self.clean = set()
@@ -377,8 +379,8 @@ class Cache(NoCache):
 
         if self.cachedir in [None, '']:
             self.has_cache = False
-            logger.info("Not using a cache. "
-                        "Set CACHE = <directory> to enable.")
+            self.logger.info("Not using a cache. "
+                             "Set CACHE = <directory> to enable.")
             return
 
         self.has_cache = True
@@ -394,21 +396,23 @@ class Cache(NoCache):
 
         self.cachefile = self.getCacheFile("bb_cache.dat")
 
-        logger.debug(1, "Cache dir: %s", self.cachedir)
+        self.logger.debug(1, "Cache dir: %s", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
 
         cache_ok = True
         if self.caches_array:
             for cache_class in self.caches_array:
                 cachefile = self.getCacheFile(cache_class.cachefile)
-                cache_ok = cache_ok and os.path.exists(cachefile)
+                cache_exists = os.path.exists(cachefile)
+                self.logger.debug(2, "Checking if %s exists: %r", cachefile, cache_exists)
+                cache_ok = cache_ok and cache_exists
                 cache_class.init_cacheData(self)
         if cache_ok:
             loaded = self.load_cachefile(progress)
         elif os.path.isfile(self.cachefile):
-            logger.info("Out of date cache found, rebuilding...")
+            self.logger.info("Out of date cache found, rebuilding...")
         else:
-            logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
+            self.logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
 
         # We don't use the symlink, its just for debugging convinience
         if self.mc:
@@ -447,7 +451,7 @@ class Cache(NoCache):
 
         for cache_class in self.caches_array:
             cachefile = self.getCacheFile(cache_class.cachefile)
-            logger.debug(1, 'Loading cache file: %s' % cachefile)
+            self.logger.debug(1, 'Loading cache file: %s' % cachefile)
             with open(cachefile, "rb") as cachefile:
                 pickled = pickle.Unpickler(cachefile)
                 # Check cache version information
@@ -455,14 +459,14 @@ class Cache(NoCache):
                     cache_ver = pickled.load()
                     bitbake_ver = pickled.load()
                 except Exception:
-                    logger.info('Invalid cache, rebuilding...')
+                    self.logger.info('Invalid cache, rebuilding...')
                     return
 
                 if cache_ver != __cache_version__:
-                    logger.info('Cache version mismatch, rebuilding...')
+                    self.logger.info('Cache version mismatch, rebuilding...')
                     return
                 elif bitbake_ver != bb.__version__:
-                    logger.info('Bitbake version mismatch, rebuilding...')
+                    self.logger.info('Bitbake version mismatch, rebuilding...')
                     return
 
                 # Load the rest of the cache file
@@ -494,7 +498,7 @@ class Cache(NoCache):
 
     def parse(self, filename, appends):
         """Parse the specified filename, returning the recipe information"""
-        logger.debug(1, "Parsing %s", filename)
+        self.logger.debug(1, "Parsing %s", filename)
         infos = []
         datastores = self.load_bbfile(filename, appends)
         depends = []
@@ -548,7 +552,7 @@ class Cache(NoCache):
         cached, infos = self.load(fn, appends)
         for virtualfn, info_array in infos:
             if info_array[0].skipped:
-                logger.debug(1, "Skipping %s: %s", virtualfn, info_array[0].skipreason)
+                self.logger.debug(1, "Skipping %s: %s", virtualfn, info_array[0].skipreason)
                 skipped += 1
             else:
                 self.add_info(virtualfn, info_array, cacheData, not cached)
@@ -584,21 +588,21 @@ class Cache(NoCache):
 
         # File isn't in depends_cache
         if not fn in self.depends_cache:
-            logger.debug(2, "Cache: %s is not cached", fn)
+            self.logger.debug(2, "%s is not cached", fn)
             return False
 
         mtime = bb.parse.cached_mtime_noerror(fn)
 
         # Check file still exists
         if mtime == 0:
-            logger.debug(2, "Cache: %s no longer exists", fn)
+            self.logger.debug(2, "%s no longer exists", fn)
             self.remove(fn)
             return False
 
         info_array = self.depends_cache[fn]
         # Check the file's timestamp
         if mtime != info_array[0].timestamp:
-            logger.debug(2, "Cache: %s changed", fn)
+            self.logger.debug(2, "%s changed", fn)
             self.remove(fn)
             return False
 
@@ -609,14 +613,14 @@ class Cache(NoCache):
                 fmtime = bb.parse.cached_mtime_noerror(f)
                 # Check if file still exists
                 if old_mtime != 0 and fmtime == 0:
-                    logger.debug(2, "Cache: %s's dependency %s was removed",
-                                    fn, f)
+                    self.logger.debug(2, "%s's dependency %s was removed",
+                                         fn, f)
                     self.remove(fn)
                     return False
 
                 if (fmtime != old_mtime):
-                    logger.debug(2, "Cache: %s's dependency %s changed",
-                                    fn, f)
+                    self.logger.debug(2, "%s's dependency %s changed",
+                                         fn, f)
                     self.remove(fn)
                     return False
 
@@ -632,14 +636,14 @@ class Cache(NoCache):
                         continue
                     f, exist = f.split(":")
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
-                        logger.debug(2, "Cache: %s's file checksum list file %s changed",
-                                        fn, f)
+                        self.logger.debug(2, "%s's file checksum list file %s changed",
+                                             fn, f)
                         self.remove(fn)
                         return False
 
         if tuple(appends) != tuple(info_array[0].appends):
-            logger.debug(2, "Cache: appends for %s changed", fn)
-            logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
+            self.logger.debug(2, "appends for %s changed", fn)
+            self.logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
             self.remove(fn)
             return False
 
@@ -648,10 +652,10 @@ class Cache(NoCache):
             virtualfn = variant2virtual(fn, cls)
             self.clean.add(virtualfn)
             if virtualfn not in self.depends_cache:
-                logger.debug(2, "Cache: %s is not cached", virtualfn)
+                self.logger.debug(2, "%s is not cached", virtualfn)
                 invalid = True
             elif len(self.depends_cache[virtualfn]) != len(self.caches_array):
-                logger.debug(2, "Cache: Extra caches missing for %s?" % virtualfn)
+                self.logger.debug(2, "Extra caches missing for %s?" % virtualfn)
                 invalid = True
 
         # If any one of the variants is not present, mark as invalid for all
@@ -659,10 +663,10 @@ class Cache(NoCache):
             for cls in info_array[0].variants:
                 virtualfn = variant2virtual(fn, cls)
                 if virtualfn in self.clean:
-                    logger.debug(2, "Cache: Removing %s from cache", virtualfn)
+                    self.logger.debug(2, "Removing %s from cache", virtualfn)
                     self.clean.remove(virtualfn)
             if fn in self.clean:
-                logger.debug(2, "Cache: Marking %s as not clean", fn)
+                self.logger.debug(2, "Marking %s as not clean", fn)
                 self.clean.remove(fn)
             return False
 
@@ -675,10 +679,10 @@ class Cache(NoCache):
         Called from the parser in error cases
         """
         if fn in self.depends_cache:
-            logger.debug(1, "Removing %s from cache", fn)
+            self.logger.debug(1, "Removing %s from cache", fn)
             del self.depends_cache[fn]
         if fn in self.clean:
-            logger.debug(1, "Marking %s as unclean", fn)
+            self.logger.debug(1, "Marking %s as unclean", fn)
             self.clean.remove(fn)
 
     def sync(self):
@@ -691,12 +695,13 @@ class Cache(NoCache):
             return
 
         if self.cacheclean:
-            logger.debug(2, "Cache is clean, not saving.")
+            self.logger.debug(2, "Cache is clean, not saving.")
             return
 
         for cache_class in self.caches_array:
             cache_class_name = cache_class.__name__
             cachefile = self.getCacheFile(cache_class.cachefile)
+            self.logger.debug(2, "Writing %s", cachefile)
             with open(cachefile, "wb") as f:
                 p = pickle.Pickler(f, pickle.HIGHEST_PROTOCOL)
                 p.dump(__cache_version__)
-- 
2.26.2

