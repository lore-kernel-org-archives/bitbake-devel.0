Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QSJ6e-0000rp-JL
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 03:23:21 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Jun 2011 18:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,312,1304319600"; d="scan'208";a="11177179"
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.48])
	by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2011 18:18:58 -0700
From: Ke Liping <liping.ke@intel.com>
To: poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jun 2011 09:06:03 +0800
Message-Id: <6aaced2537533c04253b06d10812dd3cafd92b83.1307062861.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
Subject: [PATCH 3/4][Image Creator]Introduce new param caches_array into Cache impl.
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
X-List-Received-Date: Fri, 03 Jun 2011 01:23:21 -0000

From: Liping Ke <liping.ke@intel.com>

When using hob ui interface, we need extra cache fields.
We will save ui required extra cache fields into a separate
cache file. This patch introduce this caches_array parameter.
It will be used in the extra cache implementation (following patch).
Caches_array at least contains CoreRecipeInfo. If users need extra
cache fields support, such as 'hob', caches_array will contain
more relevant elements such as HobRecipeInfo.

Signed-off-by: Liping Ke <liping.ke@intel.com>
---
 bitbake/lib/bb/cache.py  |   15 ++++++++----
 bitbake/lib/bb/cooker.py |   52 ++++++++++++++++++++++++++++++++++++++-------
 bitbake/lib/bb/shell.py  |    2 +-
 bitbake/lib/bb/ui/hob.py |    2 +
 4 files changed, 57 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 09691d9..0620621 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -245,7 +245,11 @@ class Cache(object):
     BitBake Cache implementation
     """
 
-    def __init__(self, data):
+    def __init__(self, data, caches_array):
+        # Pass caches_array information into Cache Constructor
+        # It will be used in later for deciding whether we 
+        # need extra cache file dump/load support 
+        self.caches_array = caches_array
         self.cachedir = bb.data.getVar("CACHE", data, True)
         self.clean = set()
         self.checked = set()
@@ -360,7 +364,7 @@ class Cache(object):
         return bb_data[virtual]
 
     @classmethod
-    def parse(cls, filename, appends, configdata):
+    def parse(cls, filename, appends, configdata, caches_array):
         """Parse the specified filename, returning the recipe information"""
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
@@ -393,7 +397,7 @@ class Cache(object):
                 infos.append((virtualfn, self.depends_cache[virtualfn]))
         else:
             logger.debug(1, "Parsing %s", filename)
-            return self.parse(filename, appends, configdata)
+            return self.parse(filename, appends, configdata, self.caches_array)
 
         return cached, infos
 
@@ -623,8 +627,9 @@ class CacheData(object):
     The data structures we compile from the cached data
     """
 
-    def __init__(self):
-        CoreRecipeInfo.init_cacheData(self)        
+    def __init__(self, caches_array):
+        self.caches_array = caches_array
+        CoreRecipeInfo.init_cacheData(self)
         # Direct cache variables
         self.task_queues = {}
         self.preferred = {}
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0b52f18..89da7e9 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -72,6 +72,41 @@ class BBCooker:
 
         self.configuration = configuration
 
+        self.caches_array = []
+        # Currently, only Image Creator hob ui needs extra cache.
+        # So, we save Extra Cache class name and container file
+        # information into a extraCaches field in hob UI.  
+        # TODO: In future, bin/bitbake should pass information into cooker,
+        # instead of getting information from configuration.ui. Also, some
+        # UI start up issues need to be addressed at the same time.
+        caches_name_array = ['bb.cache:CoreRecipeInfo']
+        if configuration.ui:
+            try:
+                module = __import__('bb.ui', fromlist=[configuration.ui])
+                name_array = (getattr(module, configuration.ui)).extraCaches
+                for recipeInfoName in name_array:
+                    caches_name_array.append(recipeInfoName)
+            except ImportError, exc:
+                # bb.ui.XXX is not defined and imported. It's an error!
+                logger.critical("Unable to import '%s' interface from bb.ui: %s" % (configuration.ui, exc))
+                sys.exit("FATAL: Failed to import '%s' interface." % configuration.ui)
+            except AttributeError:
+                # This is not an error. If the field is not defined in the ui,
+                # this interface might need no extra cache fields, so
+                # just skip this error!
+                logger.debug("UI '%s' does not require extra cache!" % (configuration.ui))
+
+        # At least CoreRecipeInfo will be loaded, so caches_array will never be empty!
+        # This is the entry point, no further check needed!
+        for var in caches_name_array:
+            try:
+                module_name, cache_name = var.split(':')
+                module = __import__(module_name, fromlist=(cache_name,))
+                self.caches_array.append(getattr(module, cache_name)) 
+            except ImportError, exc:
+                logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
+                sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
+
         self.configuration.data = bb.data.init()
 
         if not server:
@@ -730,9 +765,10 @@ class BBCooker:
 
         self.buildSetVars()
 
-        self.status = bb.cache.CacheData()
+        self.status = bb.cache.CacheData(self.caches_array)
         infos = bb.cache.Cache.parse(fn, self.get_file_appends(fn), \
-                                     self.configuration.data)
+                                     self.configuration.data,
+                                     self.caches_array)
         infos = dict(infos)
 
         fn = bb.cache.Cache.realfn2virtual(fn, cls)
@@ -876,7 +912,7 @@ class BBCooker:
                 else:
                     collectlog.info("You have disabled Psyco. This decreases performance.")
 
-            self.status = bb.cache.CacheData()
+            self.status = bb.cache.CacheData(self.caches_array)
 
             ignore = bb.data.getVar("ASSUME_PROVIDED", self.configuration.data, 1) or ""
             self.status.ignored_dependencies = set(ignore.split())
@@ -1091,9 +1127,9 @@ class ParsingFailure(Exception):
         self.args = (realexception, recipe)
 
 def parse_file(task):
-    filename, appends = task
+    filename, appends, caches_array = task
     try:
-        return True, bb.cache.Cache.parse(filename, appends, parse_file.cfg)
+        return True, bb.cache.Cache.parse(filename, appends, parse_file.cfg, caches_array)
     except Exception, exc:
         exc.recipe = filename
         raise exc
@@ -1123,13 +1159,13 @@ class CookerParser(object):
         self.num_processes = int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS", True) or
                                  multiprocessing.cpu_count())
 
-        self.bb_cache = bb.cache.Cache(self.cfgdata)
+        self.bb_cache = bb.cache.Cache(self.cfgdata, cooker.caches_array)
         self.fromcache = []
         self.willparse = []
         for filename in self.filelist:
             appends = self.cooker.get_file_appends(filename)
             if not self.bb_cache.cacheValid(filename):
-                self.willparse.append((filename, appends))
+                self.willparse.append((filename, appends, cooker.caches_array))
             else:
                 self.fromcache.append((filename, appends))
         self.toparse = self.total - len(self.fromcache)
@@ -1205,6 +1241,6 @@ class CookerParser(object):
     def reparse(self, filename):
         infos = self.bb_cache.parse(filename,
                                     self.cooker.get_file_appends(filename),
-                                    self.cfgdata)
+                                    self.cfgdata, self.cooker.caches_array)
         for vfn, info in infos:
             self.cooker.status.add_from_recipeinfo(vfn, info)
diff --git a/bitbake/lib/bb/shell.py b/bitbake/lib/bb/shell.py
index 3319e2d..1dd8d54 100644
--- a/bitbake/lib/bb/shell.py
+++ b/bitbake/lib/bb/shell.py
@@ -407,7 +407,7 @@ SRC_URI = ""
 
     def parse( self, params ):
         """(Re-)parse .bb files and calculate the dependency graph"""
-        cooker.status = cache.CacheData()
+        cooker.status = cache.CacheData(cooker.caches_array)
         ignore = data.getVar("ASSUME_PROVIDED", cooker.configuration.data, 1) or ""
         cooker.status.ignored_dependencies = set( ignore.split() )
         cooker.handleCollections( data.getVar("BBFILE_COLLECTIONS", cooker.configuration.data, 1) )
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 0f8fe8c..ab6022b 100644
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -28,6 +28,8 @@ import xmlrpclib
 import logging
 import Queue
 
+extraCaches = ['bb.cache_extra:HobRecipeInfo']
+
 class MainWindow (gtk.Window):
             
     def __init__(self, taskmodel, handler, curr_mach=None, curr_distro=None):
-- 
1.7.0.4



