Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QrK0a-0004cT-Mq
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Aug 2011 03:24:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Aug 2011 18:19:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="37334320"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.222])
	by orsmga001.jf.intel.com with ESMTP; 10 Aug 2011 18:19:56 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2011 18:19:48 -0700
Message-Id: <cc4158db215493ac270e27f92d977bcbe337f3db.1313025215.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
In-Reply-To: <cover.1313025215.git.josh@linux.intel.com>
References: <cover.1313025215.git.josh@linux.intel.com>
Subject: [PATCH 4/4] bb/cache: rename confusing variable
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
X-List-Received-Date: Thu, 11 Aug 2011 01:24:28 -0000

The bNeedUpdate variable doesn't reflect its purpose, and doesn't match
coding style (type encoded in variable name, camel case) - rename to
cache_ok.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cache.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index d805d46..d495f9e 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -286,14 +286,14 @@ class Cache(object):
         old_mtimes.append(newest_mtime)
         newest_mtime = max(old_mtimes)
 
-        bNeedUpdate = True
+        cache_ok = True
         if self.caches_array:
             for cache_class in self.caches_array:
                 if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
                     cachefile = getCacheFile(self.cachedir, cache_class.cachefile)
-                    bNeedUpdate = bNeedUpdate and (bb.parse.cached_mtime_noerror(cachefile) >= newest_mtime)
+                    cache_ok = cache_ok and (bb.parse.cached_mtime_noerror(cachefile) >= newest_mtime)
                     cache_class.init_cacheData(self)
-        if bNeedUpdate:
+        if cache_ok:
             self.load_cachefile()
         elif os.path.isfile(self.cachefile):
             logger.info("Out of date cache found, rebuilding...")
-- 
1.7.6



