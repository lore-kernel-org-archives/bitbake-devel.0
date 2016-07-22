Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C4DC46FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 10:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MARvwf031565 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:57 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uvraB36yqQLh for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:56 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MARpJ8031559
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:53 +0100
Message-ID: <1469183271.23580.48.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jul 2016 11:27:51 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Drop/simplify pointless type checking
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
X-List-Received-Date: Fri, 22 Jul 2016 10:27:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Since we no longer have random data like version fields in these structures
and we can assume any extra cache data subclasses our class, simplify the
code.

This is mostly reindenting after removal of the pointless type checks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index d0fb234..cce12d1 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -280,10 +280,9 @@ class Cache(object):
         cache_ok = True
         if self.caches_array:
             for cache_class in self.caches_array:
-                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                    cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-                    cache_ok = cache_ok and os.path.exists(cachefile)
-                    cache_class.init_cacheData(self)
+                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+                cache_ok = cache_ok and os.path.exists(cachefile)
+                cache_class.init_cacheData(self)
         if cache_ok:
             self.load_cachefile()
         elif os.path.isfile(self.cachefile):
@@ -296,54 +295,52 @@ class Cache(object):
 
         # Calculate the correct cachesize of all those cache files
         for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-                with open(cachefile, "rb") as cachefile:
-                    cachesize += os.fstat(cachefile.fileno()).st_size
+            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            with open(cachefile, "rb") as cachefile:
+                cachesize += os.fstat(cachefile.fileno()).st_size
 
         bb.event.fire(bb.event.CacheLoadStarted(cachesize), self.data)
         
         for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-                with open(cachefile, "rb") as cachefile:
-                    pickled = pickle.Unpickler(cachefile)
-                    # Check cache version information
+            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            with open(cachefile, "rb") as cachefile:
+                pickled = pickle.Unpickler(cachefile)
+                # Check cache version information
+                try:
+                    cache_ver = pickled.load()
+                    bitbake_ver = pickled.load()
+                except Exception:
+                    logger.info('Invalid cache, rebuilding...')
+                    return
+
+                if cache_ver != __cache_version__:
+                    logger.info('Cache version mismatch, rebuilding...')
+                    return
+                elif bitbake_ver != bb.__version__:
+                     logger.info('Bitbake version mismatch, rebuilding...')
+                     return
+
+                # Load the rest of the cache file
+                current_progress = 0
+                while cachefile:
                     try:
-                        cache_ver = pickled.load()
-                        bitbake_ver = pickled.load()
+                        key = pickled.load()
+                        value = pickled.load()
                     except Exception:
-                        logger.info('Invalid cache, rebuilding...')
-                        return
-
-                    if cache_ver != __cache_version__:
-                        logger.info('Cache version mismatch, rebuilding...')
-                        return
-                    elif bitbake_ver != bb.__version__:
-                         logger.info('Bitbake version mismatch, rebuilding...')
-                         return
-
-                    # Load the rest of the cache file
-                    current_progress = 0
-                    while cachefile:
-                        try:
-                            key = pickled.load()
-                            value = pickled.load()
-                        except Exception:
-                            break
-                        if key in self.depends_cache:
-                            self.depends_cache[key].append(value)
-                        else:
-                            self.depends_cache[key] = [value]
-                        # only fire events on even percentage boundaries
-                        current_progress = cachefile.tell() + previous_progress
-                        current_percent = 100 * current_progress / cachesize
-                        if current_percent > previous_percent:
-                            previous_percent = current_percent
-                            bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
-                                          self.data)
-
-                    previous_progress += current_progress
+                        break
+                    if key in self.depends_cache:
+                        self.depends_cache[key].append(value)
+                    else:
+                        self.depends_cache[key] = [value]
+                    # only fire events on even percentage boundaries
+                    current_progress = cachefile.tell() + previous_progress
+                    current_percent = 100 * current_progress / cachesize
+                    if current_percent > previous_percent:
+                        previous_percent = current_percent
+                        bb.event.fire(bb.event.CacheLoadProgress(current_progress, cachesize),
+                                      self.data)
+
+                previous_progress += current_progress
 
         # Note: depends cache number is corresponding to the parsing file numbers.
         # The same file has several caches, still regarded as one item in the cache
@@ -407,9 +404,8 @@ class Cache(object):
 
             info_array = []
             for cache_class in caches_array:
-                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                    info = cache_class(filename, data)
-                    info_array.append(info)
+                info = cache_class(filename, data)
+                info_array.append(info)
             infos.append((virtualfn, info_array))
 
         return infos
@@ -601,26 +597,23 @@ class Cache(object):
         file_dict = {}
         pickler_dict = {}
         for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cache_class_name = cache_class.__name__
-                cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-                file_dict[cache_class_name] = open(cachefile, "wb")
-                pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
-                pickler_dict[cache_class_name].dump(__cache_version__)
-                pickler_dict[cache_class_name].dump(bb.__version__)
+            cache_class_name = cache_class.__name__
+            cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            file_dict[cache_class_name] = open(cachefile, "wb")
+            pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
+            pickler_dict[cache_class_name].dump(__cache_version__)
+            pickler_dict[cache_class_name].dump(bb.__version__)
 
         try:
             for key, info_array in self.depends_cache.items():
                 for info in info_array:
-                    if isinstance(info, RecipeInfoCommon):
-                        cache_class_name = info.__class__.__name__
-                        pickler_dict[cache_class_name].dump(key)
-                        pickler_dict[cache_class_name].dump(info)
+                    cache_class_name = info.__class__.__name__
+                    pickler_dict[cache_class_name].dump(key)
+                    pickler_dict[cache_class_name].dump(info)
         finally:
             for cache_class in self.caches_array:
-                if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                    cache_class_name = cache_class.__name__
-                    file_dict[cache_class_name].close()
+                cache_class_name = cache_class.__name__
+                file_dict[cache_class_name].close()
 
         del self.depends_cache
 
@@ -652,8 +645,7 @@ class Cache(object):
 
         info_array = []
         for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                info_array.append(cache_class(realfn, data))
+            info_array.append(cache_class(realfn, data))
         self.add_info(file_name, info_array, cacheData, parsed)
 
     @staticmethod
@@ -721,8 +713,9 @@ class CacheData(object):
     def __init__(self, caches_array):
         self.caches_array = caches_array
         for cache_class in self.caches_array:
-            if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
-                cache_class.init_cacheData(self)        
+            if not issubclass(cache_class, RecipeInfoCommon):
+                bb.error("Extra cache data class %s should subclass RecipeInfoCommon class" % cache_class)
+            cache_class.init_cacheData(self)
 
         # Direct cache variables
         self.task_queues = {}



