Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QeWZU-0008Sh-5W for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jul 2011 20:11:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66I7jUL017876
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 19:07:45 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17374-08 for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jul 2011 19:07:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p66I7cci017870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jul 2011 19:07:39 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 06 Jul 2011 19:07:04 +0100
Message-ID: <1309975625.20015.796.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] cache.py: Ensure additional .bbappend files are accounted for
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
X-List-Received-Date: Wed, 06 Jul 2011 18:11:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently if a user adds a new .bbappend file to the system, the cache still
thinks the cached data is valid. This code fixes that to ensure additions and
changed in append application order are accounted for.

[YOCTO #1091]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 99d7395..6e152fa 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "140"
+__cache_version__ = "141"
 
 def getCacheFile(path, filename):
     return os.path.join(path, filename)
@@ -94,6 +94,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.file_depends = metadata.getVar('__depends', False)
         self.timestamp = bb.parse.cached_mtime(filename)
         self.variants = self.listvar('__VARIANTS', metadata) + ['']
+        self.appends = self.listvar('__BBAPPEND', metadata)
         self.nocache = self.getvar('__BB_DONT_CACHE', metadata)
 
         self.skipreason = self.getvar('__SKIPPED', metadata)
@@ -429,7 +430,7 @@ class Cache(object):
         automatically add the information to the cache or to your
         CacheData.  Use the add or add_info method to do so after
         running this, or use loadData instead."""
-        cached = self.cacheValid(filename)
+        cached = self.cacheValid(filename, appends)
         if cached:
             infos = []
             # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
@@ -460,13 +461,13 @@ class Cache(object):
 
         return cached, skipped, virtuals
 
-    def cacheValid(self, fn):
+    def cacheValid(self, fn, appends):
         """
         Is the cache valid for fn?
         Fast version, no timestamps checked.
         """
         if fn not in self.checked:
-            self.cacheValidUpdate(fn)
+            self.cacheValidUpdate(fn, appends)
 
         # Is cache enabled?
         if not self.has_cache:
@@ -475,7 +476,7 @@ class Cache(object):
             return True
         return False
 
-    def cacheValidUpdate(self, fn):
+    def cacheValidUpdate(self, fn, appends):
         """
         Is the cache valid for fn?
         Make thorough (slower) checks including timestamps.
@@ -524,6 +525,12 @@ class Cache(object):
                     self.remove(fn)
                     return False
 
+        if appends != info_array[0].appends:
+            logger.debug(2, "Cache: appends for %s changed", fn)
+            bb.note("%s to %s" % (str(appends), str(info_array[0].appends)))
+            self.remove(fn)
+            return False
+
         invalid = False
         for cls in info_array[0].variants:
             virtualfn = self.realfn2virtual(fn, cls)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7976d29..ecf20dc 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1298,7 +1298,7 @@ class CookerParser(object):
         self.willparse = []
         for filename in self.filelist:
             appends = self.cooker.get_file_appends(filename)
-            if not self.bb_cache.cacheValid(filename):
+            if not self.bb_cache.cacheValid(filename, appends):
                 self.willparse.append((filename, appends, cooker.caches_array))
             else:
                 self.fromcache.append((filename, appends))



