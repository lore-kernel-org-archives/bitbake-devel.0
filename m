Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7875678816
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:19 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w11FFLBv024948
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:21 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:19 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:29 +0800
Message-ID: <4bf31a7aa9885c2a8f7a583a582ceb50b3898666.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 8/8] bitbake: cooker: improve inotify handling
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:19 -0000
Content-Type: text/plain

Each recipe calls bb_cache.add_info() and it calls add_filewatch() for every
depend file (not only existed files, but also non-exsited/attempted ones),
which caused the parsing and loading very slow. The watchers are global, so we
can only pass new depend files to add_filewatch() to improve the performance.

Here is the testing of 54 layers before and after the patch.

              Parsing       Loading
Before        35s           33s
Now           11s           9s

24 seconds are saved for parsing, and 24s are saved for loading.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py  |  9 ++++++---
 bitbake/lib/bb/cooker.py | 24 +++++++++++++++---------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 168a77a..7d65939 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -713,12 +713,15 @@ class Cache(NoCache):
     def mtime(cachefile):
         return bb.parse.cached_mtime_noerror(cachefile)
 
-    def add_info(self, filename, info_array, cacheData, parsed=None, watcher=None):
+    def add_info(self, filename, info_array, cacheData, parsed=None, watcher=None, watch_manager=None):
         if isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
             cacheData.add_from_recipeinfo(filename, info_array)
 
-            if watcher:
-                watcher(info_array[0].file_depends)
+            if watcher and watch_manager:
+                deps_set = set()
+                for deps in info_array[0].file_depends:
+                    deps_set.add(deps[0])
+                watcher(deps_set - watch_manager.bbseen)
 
         if not self.has_cache:
             return
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ffda225..cd98ba0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -176,13 +176,13 @@ class BBCooker:
         self.configuration = configuration
 
         self.configwatcher = pyinotify.WatchManager()
-        self.configwatcher.bbseen = []
+        self.configwatcher.bbseen = set()
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
         self.watcher = pyinotify.WatchManager()
-        self.watcher.bbseen = []
+        self.watcher.bbseen = set()
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
         # If being called by something like tinfoil, we need to clean cached data
@@ -278,12 +278,14 @@ class BBCooker:
             watcher = self.watcher
         for i in deps:
             if dirs:
-                f = i[0]
+                f = i
             else:
-                f = os.path.dirname(i[0])
+                f = os.path.dirname(i)
             if f in watcher.bbseen:
                 continue
-            watcher.bbseen.append(f)
+            # Add both files and directories to to bbseen
+            watcher.bbseen.add(f)
+            watcher.bbseen.add(i)
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
                 # the parser. The parent directory of these files may not exist, in which case we need
@@ -296,7 +298,7 @@ class BBCooker:
                         f = os.path.dirname(f)
                         if f in watcher.bbseen:
                             break
-                        watcher.bbseen.append(f)
+                        watcher.bbseen.add(f)
                         continue
                     if 'ENOSPC' in str(e):
                         providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
@@ -367,7 +369,10 @@ class BBCooker:
             self.disableDataTracking()
 
         self.data.renameVar("__depends", "__base_depends")
-        self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
+        deps_set = set()
+        for deps in self.data.getVar("__base_depends", False):
+            deps_set.add(deps[0])
+        self.add_filewatch(deps_set, self.configwatcher)
 
         self.baseconfig_valid = True
         self.parsecache_valid = False
@@ -1510,7 +1515,7 @@ class BBCooker:
 
             # Add inotify watches for directories searched for bb/bbappend files
             for dirent in searchdirs:
-                self.add_filewatch([[dirent]], dirs=True)
+                self.add_filewatch([dirent], dirs=True)
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
@@ -2144,7 +2149,8 @@ class CookerParser(object):
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
             (fn, cls, mc) = bb.cache.virtualfn2realfn(virtualfn)
             self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecaches[mc],
-                                        parsed=parsed, watcher = self.cooker.add_filewatch)
+                                        parsed=parsed, watcher=self.cooker.add_filewatch,
+                                        watch_manager=self.cooker.watcher)
         return True
 
     def reparse(self, filename):
-- 
2.7.4


