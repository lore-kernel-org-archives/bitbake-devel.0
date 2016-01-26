Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2159376E2E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:38 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616607"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:38 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:31 +0200
Message-Id: <1453815272-8303-6-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 5/6] MultiProcessCache: make cache filename configurable
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:38 -0000

If no cache file name is given a default from class variable is used,
like before.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cache.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 55283b0..063ab15 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -755,13 +755,14 @@ class MultiProcessCache(object):
         self.cachedata = self.create_cachedata()
         self.cachedata_extras = self.create_cachedata()
 
-    def init_cache(self, d):
+    def init_cache(self, d, cache_file_name=None):
         cachedir = (d.getVar("PERSISTENT_DIR", True) or
                     d.getVar("CACHE", True))
         if cachedir in [None, '']:
             return
         bb.utils.mkdirhier(cachedir)
-        self.cachefile = os.path.join(cachedir, self.__class__.cache_file_name)
+        self.cachefile = os.path.join(cachedir,
+                                      cache_file_name or self.__class__.cache_file_name)
         logger.debug(1, "Using cache in '%s'", self.cachefile)
 
         glf = bb.utils.lockfile(self.cachefile + ".lock")
-- 
2.1.4


