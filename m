Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E1D9776643
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:38 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616615"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:39 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:32 +0200
Message-Id: <1453815272-8303-7-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 6/6] SignatureGeneratorBasic: make checksum cache file configurable
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:39 -0000

Define a new bitbake configuration variable BB_HASH_CHECKSUM_CACHE_FILE
that can be used to define the cache file to use for file checksum
cache.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/siggen.py | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index a7916b2..43cf7b6 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -4,6 +4,7 @@ import os
 import re
 import tempfile
 import bb.data
+from bb.checksum import FileChecksumCache
 
 logger = logging.getLogger('BitBake.SigGen')
 
@@ -91,6 +92,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST", True) or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
+        checksum_cache_file = data.getVar("BB_HASH_CHECKSUM_CACHE_FILE", True)
+        if checksum_cache_file:
+            self.checksum_cache = FileChecksumCache()
+            self.checksum_cache.init_cache(data, checksum_cache_file)
+        else:
+            self.checksum_cache = None
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST", True) or None
@@ -194,7 +201,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.runtaskdeps[k].append(dep)
 
         if task in dataCache.file_checksums[fn]:
-            checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
+            if self.checksum_cache:
+                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename)
+            else:
+                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
                 self.file_checksum_values[k][f] = cs
                 if cs:
@@ -221,8 +231,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def writeout_file_checksum_cache(self):
         """Write/update the file checksum cache onto disk"""
-        bb.fetch2.fetcher_parse_save()
-        bb.fetch2.fetcher_parse_done()
+        if self.checksum_cache:
+            self.checksum_cache.save_extras()
+            self.checksum_cache.save_merge()
+        else:
+            bb.fetch2.fetcher_parse_save()
+            bb.fetch2.fetcher_parse_done()
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
         k = fn + "." + task
-- 
2.1.4


