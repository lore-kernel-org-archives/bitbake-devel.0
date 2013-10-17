Return-Path: <valentin.popa@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id E5D3D60FF0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Oct 2013 15:54:07 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 17 Oct 2013 08:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,514,1378882800"; d="scan'208";a="309141356"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Oct 2013 08:53:47 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Oct 2013 18:55:14 +0300
Message-Id: <1382025314-29807-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] Cache parse warnings
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
X-List-Received-Date: Thu, 17 Oct 2013 15:54:09 -0000

During parsing, if .bb files are already parsed,
bitbake loads the cache and doesn't throw any
of the warnings generated during the previously
parsing process.
With this patch, bitbake caches also the warnings
that appear during parsing.

In case of loading from cache, the warnings are sent after
CacheLoadCompleted event and the parse warnings log handler
has to mutate the records so HobEventHandler can discriminate
warnings.

[YOCTO #3783]
Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/cache.py                     | 41 ++++++++++++++++++++++++++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |  7 ++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 318781b..ac343ff 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -31,11 +31,16 @@
 
 import os
 import logging
+import copy
 from collections import defaultdict
 import bb.utils
 
 logger = logging.getLogger("BitBake.Cache")
 
+#logger to handle warnings during parsing
+parseLogger = logging.getLogger("BitBake")
+parseLogger.setLevel(logging.WARNING)
+
 try:
     import cPickle as pickle
 except ImportError:
@@ -45,6 +50,24 @@ except ImportError:
 
 __cache_version__ = "147"
 
+
+class ParseLogHandler(logging.Handler):
+    """
+    Handler for warnings generated during parsing.
+    Mutates records' name so the event handler can
+    discrimate between warnings generated during the
+    parsing and other warnings.
+    """
+    def __init__(self, queue):
+        logging.Handler.__init__(self)
+        self.queue = queue
+
+    def emit(self, record):
+        self.record = record
+        self.record.name = "Bitbake.Parsing"
+        self.queue.append(self.record)
+
+
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
 
@@ -94,7 +117,8 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
     cachefile = "bb_cache.dat"   
 
-    def __init__(self, filename, metadata):      
+    def __init__(self, filename, metadata):
+        self.parse_warnings = []
         self.file_depends = metadata.getVar('__depends', False)
         self.timestamp = bb.parse.cached_mtime(filename)
         self.variants = self.listvar('__VARIANTS', metadata) + ['']
@@ -150,6 +174,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
     @classmethod
     def init_cacheData(cls, cachedata):
         # CacheData in Core RecipeInfo Class
+        cachedata.parse_warnings = []
         cachedata.task_deps = {}
         cachedata.pkg_fn = {}
         cachedata.pkg_pn = defaultdict(list)
@@ -197,6 +222,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
         cachedata.file_checksums[fn] = self.file_checksums
 
+        if self.parse_warnings:
+            cachedata.parse_warnings = self.parse_warnings
+
         provides = [self.pn]
         for provide in self.provides:
             if provide not in provides:
@@ -413,9 +441,14 @@ class Cache(object):
                 data.setVar("__depends", depends)
 
             info_array = []
+
             for cache_class in caches_array:
                 if type(cache_class) is type and issubclass(cache_class, RecipeInfoCommon):
+                    warnings = []
+                    handler = ParseLogHandler(warnings)
+                    parseLogger.addHandler(handler)
                     info = cache_class(filename, data)
+                    info.parse_warnings = copy.deepcopy(warnings);
                     info_array.append(info)
             infos.append((virtualfn, info_array))
 
@@ -434,6 +467,12 @@ class Cache(object):
             infos = []
             # info_array item is a list of [CoreRecipeInfo, XXXRecipeInfo]
             info_array = self.depends_cache[filename]
+
+            if isinstance(info_array[0], CoreRecipeInfo):
+                if info_array[0].parse_warnings:
+                    for record in info_array[0].parse_warnings:
+                        logger.callHandlers(record)
+
             for variant in info_array[0].variants:
                 virtualfn = self.realfn2virtual(filename, variant)
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 393c258..069df82 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -216,7 +216,12 @@ class HobHandler(gobject.GObject):
                     formatter = bb.msg.BBLogFormatter()
                     msg = formatter.format(event)
                     self.error_msg += msg + '\n'
-                elif event.levelno >= logging.WARNING and self.parsing == True:
+
+                #elif there are warnings during the parsing or after
+                #CacheLoadCompleted event (and records belonging to
+                #'Bitbake.Parsing' logger exist) then emit parsing-warning signal
+                elif event.levelno >= logging.WARNING and (self.parsing == True or
+                        event.name == "Bitbake.Parsing"):
                     formatter = bb.msg.BBLogFormatter()
                     msg = formatter.format(event)
                     warn_msg = msg + '\n'
-- 
1.8.1.2


