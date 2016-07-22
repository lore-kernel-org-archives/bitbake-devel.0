Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EB25F606BF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 10:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MAT09L031639 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:29:00 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JsDCIUn1pmcu for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:29:00 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6MASv8i031636
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jul 2016 11:28:58 +0100
Message-ID: <1469183337.23580.50.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jul 2016 11:28:57 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Don't interleave pickle cache file writing
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
X-List-Received-Date: Fri, 22 Jul 2016 10:29:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

For some reason the data written in this way is coming back out the
files out of order. I've not been able to simplify the test case to a
point where this was standalone reproducible. Simplify the code and
write out the cache files sequentially since this seems to avoid the
errors and makes the code more readable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 439565f..c09f929 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -601,26 +601,19 @@ class Cache(object):
             logger.debug(2, "Cache is clean, not saving.")
             return
 
-        file_dict = {}
-        pickler_dict = {}
         for cache_class in self.caches_array:
             cache_class_name = cache_class.__name__
             cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
-            file_dict[cache_class_name] = open(cachefile, "wb")
-            pickler_dict[cache_class_name] =  pickle.Pickler(file_dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
-            pickler_dict[cache_class_name].dump(__cache_version__)
-            pickler_dict[cache_class_name].dump(bb.__version__)
-
-        try:
-            for key, info_array in self.depends_cache.items():
-                for info in info_array:
-                    cache_class_name = info.__class__.__name__
-                    pickler_dict[cache_class_name].dump(key)
-                    pickler_dict[cache_class_name].dump(info)
-        finally:
-            for cache_class in self.caches_array:
-                cache_class_name = cache_class.__name__
-                file_dict[cache_class_name].close()
+            with open(cachefile, "wb") as f:
+                p = pickle.Pickler(f, pickle.HIGHEST_PROTOCOL)
+                p.dump(__cache_version__)
+                p.dump(bb.__version__)
+
+                for key, info_array in self.depends_cache.items():
+                    for info in info_array:
+                        if isinstance(info, RecipeInfoCommon) and info.__class__.__name__ == cache_class_name:
+                            p.dump(key)
+                            p.dump(info)
 
         del self.depends_cache
 



