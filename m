Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AD44F787D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FFBpj024913
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:11 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:10 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:26 +0800
Message-ID: <91d3cf4ba78d12e6cbb6695c3fd5e11ec125f990.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/8] bitbake: cache: improve debug message
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:09 -0000
Content-Type: text/plain

* Print message when cachefile is found/not can help debug.
* Update "Using cache in" to "Cache dir:" since it was the same as the debug
  message of "codeparser & file checksum caches", which caused confusion. And
  whether the cache file will be used or not is still unknown at that time, so
  just print the cache dir.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 86ce0e7..168a77a 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -395,7 +395,7 @@ class Cache(NoCache):
         self.has_cache = True
         self.cachefile = getCacheFile(self.cachedir, "bb_cache.dat", self.data_hash)
 
-        logger.debug(1, "Using cache in '%s'", self.cachedir)
+        logger.debug(1, "Cache dir: %s", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
 
         cache_ok = True
@@ -408,6 +408,8 @@ class Cache(NoCache):
             self.load_cachefile()
         elif os.path.isfile(self.cachefile):
             logger.info("Out of date cache found, rebuilding...")
+        else:
+            logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
 
     def load_cachefile(self):
         cachesize = 0
@@ -424,6 +426,7 @@ class Cache(NoCache):
 
         for cache_class in self.caches_array:
             cachefile = getCacheFile(self.cachedir, cache_class.cachefile, self.data_hash)
+            logger.debug(1, 'Loading cache file: %s' % cachefile)
             with open(cachefile, "rb") as cachefile:
                 pickled = pickle.Unpickler(cachefile)
                 # Check cache version information
-- 
2.7.4


