Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BBF3260DFA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 08:05:26 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Mar 2014 01:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,734,1389772800"; d="scan'208";a="480229585"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.62])
	by orsmga001.jf.intel.com with ESMTP; 26 Mar 2014 01:05:08 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Mar 2014 10:05:45 +0200
Message-Id: <1395821145-2242-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] cooker: bitbake memres server should not always reload the cache
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
X-List-Received-Date: Wed, 26 Mar 2014 08:05:30 -0000

Due to commit dd15648fc2654b8d7c3e00ea7ab3dbf04f24f24b, after an async
command is executed, the state of the server is set back to state.initial,
so the cache is always reloaded.
This patch adds a sanity check on the validity of the cache and then only
reload if something has changed.
depends_cache variable is needed in this case, so the del statement needs
to be removed.

[YOCTO #5603]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cache.py  |    2 --
 bitbake/lib/bb/cooker.py |   32 ++++++++++++++++++++++----------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 318781b..da9ad5d 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -612,8 +612,6 @@ class Cache(object):
                     cache_class_name = cache_class.__name__
                     file_dict[cache_class_name].close()
 
-        del self.depends_cache
-
     @staticmethod
     def mtime(cachefile):
         return bb.parse.cached_mtime_noerror(cachefile)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 07202e3..c90bb44 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1265,21 +1265,33 @@ class BBCooker:
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-            self.parseConfiguration ()
+            check_cache = False
+            if self.parser:
+                self.parser.bb_cache.checked = set()
+                for filename in self.parser.filelist:
+                    appends = self.collection.get_file_appends(filename)
+                    if not self.parser.bb_cache.cacheValid(filename, appends):
+                        check_cache = True
+                        break
+            else:
+                check_cache = True
 
-            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
-            self.recipecache.ignored_dependencies = set(ignore.split())
+            if check_cache:
+                self.parseConfiguration ()
+
+                ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
+                self.recipecache.ignored_dependencies = set(ignore.split())
 
-            for dep in self.configuration.extra_assume_provided:
-                self.recipecache.ignored_dependencies.add(dep)
+                for dep in self.configuration.extra_assume_provided:
+                    self.recipecache.ignored_dependencies.add(dep)
 
-            self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
-            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
+                self.collection = CookerCollectFiles(self.recipecache.bbfile_config_priorities)
+                (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
 
-            self.data.renameVar("__depends", "__base_depends")
+                self.data.renameVar("__depends", "__base_depends")
 
-            self.parser = CookerParser(self, filelist, masked)
-            self.state = state.parsing
+                self.parser = CookerParser(self, filelist, masked)
+                self.state = state.parsing
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
-- 
1.7.9.5


