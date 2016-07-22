Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2C4E7606BF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 10:27:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MARQlG031525 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:26 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Dw6gjn5XEadA for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:26 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MARLQU031522
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:27:22 +0100
Message-ID: <1469183241.23580.47.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jul 2016 11:27:21 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Improve versions fields handling
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
X-List-Received-Date: Fri, 22 Jul 2016 10:27:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Firstly, don't store the versions fields in memory in the cache objects
data store. This just complicates the code for no good reason.

Secondly, write the version fields to all cache files, not just the
core one. This makes everything consistent and easier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index b90d488..d0fb234 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -290,25 +290,6 @@ class Cache(object):
             logger.info("Out of date cache found, rebuilding...")
 
     def load_cachefile(self):
-        # Firstly, using core cache file information for
-        # valid checking
-        with open(self.cachefile, "rb") as cachefile:
-            pickled = pickle.Unpickler(cachefile)
-            try:
-                cache_ver = pickled.load()
-                bitbake_ver = pickled.load()
-            except Exception:
-                logger.info('Invalid cache, rebuilding...')
-                return
-
-            if cache_ver != __cache_version__:
-                logger.info('Cache version mismatch, rebuilding...')
-                return
-            elif bitbake_ver != bb.__version__:
-                logger.info('Bitbake version mismatch, rebuilding...')
-                return
-
-
         cachesize = 0
         previous_progress = 0
         previous_percent = 0
@@ -326,7 +307,24 @@ class Cache(object):
             if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
                 cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
                 with open(cachefile, "rb") as cachefile:
-                    pickled = pickle.Unpickler(cachefile)                    
+                    pickled = pickle.Unpickler(cachefile)
+                    # Check cache version information
+                    try:
+                        cache_ver = pickled.load()
+                        bitbake_ver = pickled.load()
+                    except Exception:
+                        logger.info('Invalid cache, rebuilding...')
+                        return
+
+                    if cache_ver != __cache_version__:
+                        logger.info('Cache version mismatch, rebuilding...')
+                        return
+                    elif bitbake_ver != bb.__version__:
+                         logger.info('Bitbake version mismatch, rebuilding...')
+                         return
+
+                    # Load the rest of the cache file
+                    current_progress = 0
                     while cachefile:
                         try:
                             key = pickled.load()
@@ -608,9 +606,8 @@ class Cache(object):
                 cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
                 file_dict[cache_class_name] = open(cachefile, "wb")
                 pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
-                   
-        pickler_dict['CoreRecipeInfo'].dump(__cache_version__)
-        pickler_dict['CoreRecipeInfo'].dump(bb.__version__)
+                pickler_dict[cache_class_name].dump(__cache_version__)
+                pickler_dict[cache_class_name].dump(bb.__version__)
 
         try:
             for key, info_array in self.depends_cache.items():



