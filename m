Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B9E9476803
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:35 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616587"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:34 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:27 +0200
Message-Id: <1453815272-8303-2-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 1/6] bb/cache: drop some unused arguments
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:37 -0000

Drop unused 'd' argument from the cache save methods, simplifying the
API.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cache.py           |  4 ++--
 lib/bb/codeparser.py      |  8 ++++----
 lib/bb/cooker.py          |  8 ++++----
 lib/bb/fetch2/__init__.py | 10 +++++-----
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 8485eb4..55283b0 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -785,7 +785,7 @@ class MultiProcessCache(object):
         data = [{}]
         return data
 
-    def save_extras(self, d):
+    def save_extras(self):
         if not self.cachefile:
             return
 
@@ -815,7 +815,7 @@ class MultiProcessCache(object):
                 if h not in dest[j]:
                     dest[j][h] = source[j][h]
 
-    def save_merge(self, d):
+    def save_merge(self):
         if not self.cachefile:
             return
 
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 577b427..bdfa2ca 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -167,11 +167,11 @@ codeparsercache = CodeParserCache()
 def parser_cache_init(d):
     codeparsercache.init_cache(d)
 
-def parser_cache_save(d):
-    codeparsercache.save_extras(d)
+def parser_cache_save():
+    codeparsercache.save_extras()
 
-def parser_cache_savemerge(d):
-    codeparsercache.save_merge(d)
+def parser_cache_savemerge():
+    codeparsercache.save_merge()
 
 Logger = logging.getLoggerClass()
 class BufferedLogger(Logger):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9c58d95..d48724a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1999,8 +1999,8 @@ class CookerParser(object):
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
             def init():
                 Parser.cfg = self.cfgdata
-                multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, args=(self.cfgdata,), exitpriority=1)
-                multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, args=(self.cfgdata,), exitpriority=1)
+                multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
+                multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
 
             self.feeder_quit = multiprocessing.Queue(maxsize=1)
             self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
@@ -2053,8 +2053,8 @@ class CookerParser(object):
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
         multiprocessing.util.Finalize(None, sync.join, exitpriority=-100)
-        bb.codeparser.parser_cache_savemerge(self.cooker.data)
-        bb.fetch.fetcher_parse_done(self.cooker.data)
+        bb.codeparser.parser_cache_savemerge()
+        bb.fetch.fetcher_parse_done()
         if self.cooker.configuration.profile:
             profiles = []
             for i in self.process_names:
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5b416ab..7d7bd58 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -515,13 +515,13 @@ def fetcher_init(d):
         if hasattr(m, "init"):
             m.init(d)
 
-def fetcher_parse_save(d):
-    _checksum_cache.save_extras(d)
+def fetcher_parse_save():
+    _checksum_cache.save_extras()
 
-def fetcher_parse_done(d):
-    _checksum_cache.save_merge(d)
+def fetcher_parse_done():
+    _checksum_cache.save_merge()
 
-def fetcher_compare_revisions(d):
+def fetcher_compare_revisions():
     """
     Compare the revisions in the persistant cache with current values and
     return true/false on whether they've changed.
-- 
2.1.4


