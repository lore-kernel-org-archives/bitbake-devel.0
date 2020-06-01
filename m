Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.46956.1591043301627264336
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=etLwZ1aV;
 spf=pass (domain: gmail.com, ip: 209.85.166.170, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f170.google.com with SMTP id j3so10657982ilk.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UDWEXOA1I1+sR/BptbSRyff2petEhCRmdwg7h7B/uCs=;
        b=etLwZ1aVf5MmQIjdvkDuTBe+pYrFhIKhH3UOKu+OiCaF+w6q/UTW1FBsZEKRGpkYL2
         eZcs0w4Oroc//Xk2NWeH0fD0hxZ0VeNi3/X8SCgIkarKYkseMfAvhghoKK5YGoELaD78
         EQ2sf8+KR25SFcolAJ3QhOBJW0iVhqrCUKf+qxaTIKk4aPKh2bJd9HDUvSTwuNnAchf1
         n+K4bQCSLzHYGMje6OlCk7shpV8LfC4aa6fuzc7Bv1RzhN5UsYsthtAJnGwqM4Vkt17m
         HN80i22HoGMlDw28TB1JA9HgFJN5MHCRe6IyvQpk6j/C9uZcwDXXZA6s7HFPzPlZVTYW
         U/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UDWEXOA1I1+sR/BptbSRyff2petEhCRmdwg7h7B/uCs=;
        b=YzqbOjYwlpFsf9Vm3eSJywDbXJZYMbbQkzavodfXuHwrfWWXbrTtMRPS7vqBpslLvD
         VP004UW6J3I7QxmJmHGmF9KVLmX+0C429XpK4IS4cvUS/1oFWuxc5wLdQUzfqOCZCsEx
         YlzfzGDBi8+JxKyX8UOKg9PzDYOBWLPPDUmz97PVSg607Jsi4Aq8EMRUZ/D/3in6JdA7
         2DbX/EHhNWsB2OQgK3eUwpVr7/m1gk3AjbUVkH6/7+Ncyt0ANad+mqSnGkm2IADCcCX9
         b1iRlPYGKIcM4yuXDcnvGT/FOS+/TPsZqbzR6ewwNKIKmmHNQ2eQpmpEzxVtHv9kcQID
         Cn7g==
X-Gm-Message-State: AOAM530wbGEFrIuBSm9sCeoC7HceWS/gFevPnb+b+A1Adlc/y8d+ubbm
	rg42Ys8DhXhQUNY1tArNcU8g/xh58bc=
X-Google-Smtp-Source: ABdhPJwp7Ni3t0SEZhRqQYXXDmAPQOhRVj58n7fXAzWp/UUA81AAjWUCQfSFLjcYqHL8+9iq+N5eBg==
X-Received: by 2002:a05:6e02:144:: with SMTP id j4mr22280628ilr.214.1591043300467;
        Mon, 01 Jun 2020 13:28:20 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:19 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 5/8] bitbake: cache: Improve logging
Date: Mon,  1 Jun 2020 15:28:04 -0500
Message-Id: <20200601202807.26357-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

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
2.17.1

