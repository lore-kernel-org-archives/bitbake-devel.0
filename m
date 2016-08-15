Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6D9C374197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH3VUQ011036 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:03:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X57uKNyCmO5D for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:03:31 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH3TVH011033
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:03:30 +0100
Message-ID: <1471280609.20391.99.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 18:03:29 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Build datastores from databuilder object
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
X-List-Received-Date: Mon, 15 Aug 2016 17:03:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rather than passing in a datastore to build on top of, use the data builder
object in the cache and base the parsed recipe from this. This turns
things into proper objects building from one another rather than messy
mixes of static and class functions.

This sets things up so we can support parsing and building multiple
configurations.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index b3353fb..96648da 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -199,15 +199,18 @@ def fork_off_task(worker, cfg, data, databuilder, workerdata, fn, task, taskname
             if umask:
                 os.umask(umask)
 
-            data.setVar("BB_WORKERCONTEXT", "1")
-            data.setVar("BB_TASKDEPDATA", taskdepdata)
-            data.setVar("BUILDNAME", workerdata["buildname"])
-            data.setVar("DATE", workerdata["date"])
-            data.setVar("TIME", workerdata["time"])
-            bb.parse.siggen.set_taskdata(workerdata["sigdata"])
-            ret = 0
             try:
-                the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
+                bb_cache = bb.cache.NoCache(databuilder)
+                the_data = databuilder.data
+                the_data.setVar("BB_WORKERCONTEXT", "1")
+                the_data.setVar("BB_TASKDEPDATA", taskdepdata)
+                the_data.setVar("BUILDNAME", workerdata["buildname"])
+                the_data.setVar("DATE", workerdata["date"])
+                the_data.setVar("TIME", workerdata["time"])
+                bb.parse.siggen.set_taskdata(workerdata["sigdata"])
+                ret = 0
+
+                the_data = bb_cache.loadDataFull(fn, appends)
                 the_data.setVar('BB_TASKHASH', workerdata["runq_hash"][task])
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN", True), taskname.replace("do_", "")))
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 8c1fe11..5f302d6 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -271,35 +271,44 @@ class NoCache(object):
         self.databuilder = databuilder
         self.data = databuilder.data
 
-    @classmethod
-    def loadDataFull(cls, virtualfn, appends, cfgData):
+    def loadDataFull(self, virtualfn, appends):
         """
         Return a complete set of data for fn.
         To do this, we need to parse the file.
         """
-
+        logger.debug(1, "Parsing %s (full)" % virtualfn)
         (fn, virtual) = virtualfn2realfn(virtualfn)
-
-        logger.debug(1, "Parsing %s (full)", fn)
-
-        cfgData.setVar("__ONLYFINALISE", virtual or "default")
-        bb_data = cls.load_bbfile(fn, appends, cfgData)
+        bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
         return bb_data[virtual]
 
-    @staticmethod
-    def load_bbfile(bbfile, appends, config):
+    def load_bbfile(self, bbfile, appends, virtonly = False):
         """
         Load and parse one .bb build file
         Return the data and whether parsing resulted in the file being skipped
         """
+
+        if virtonly:
+            (bbfile, virtual) = virtualfn2realfn(bbfile)
+            bb_data = self.data.createCopy()
+            bb_data.setVar("__BBMULTICONFIG", mc) 
+            bb_data.setVar("__ONLYFINALISE", virtual or "default")
+            datastores = self._load_bbfile(bb_data, bbfile, appends)
+            return datastores
+
+        bb_data = self.data.createCopy()
+        datastores = self._load_bbfile(bb_data, bbfile, appends)
+
+        return datastores
+
+    def _load_bbfile(self, bb_data, bbfile, appends):
         chdir_back = False
 
         # expand tmpdir to include this topdir
-        config.setVar('TMPDIR', config.getVar('TMPDIR', True) or "")
+        bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR', True) or "")
         bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
         oldpath = os.path.abspath(os.getcwd())
         bb.parse.cached_mtime_noerror(bbfile_loc)
-        bb_data = config.createCopy()
+
         # The ConfHandler first looks if there is a TOPDIR and if not
         # then it would call getcwd().
         # Previously, we chdir()ed to bbfile_loc, called the handler
@@ -431,12 +440,11 @@ class Cache(NoCache):
                                                   len(self.depends_cache)),
                       self.data)
 
-    @classmethod
-    def parse(cls, filename, appends, configdata, caches_array):
+    def parse(self, filename, appends):
         """Parse the specified filename, returning the recipe information"""
         logger.debug(1, "Parsing %s", filename)
         infos = []
-        datastores = cls.load_bbfile(filename, appends, configdata)
+        datastores = self.load_bbfile(filename, appends)
         depends = []
         variants = []
         # Process the "real" fn last so we can store variants list
@@ -451,14 +459,14 @@ class Cache(NoCache):
             if virtualfn == filename:
                 data.setVar("__VARIANTS", " ".join(variants))
             info_array = []
-            for cache_class in caches_array:
+            for cache_class in self.caches_array:
                 info = cache_class(filename, data)
                 info_array.append(info)
             infos.append((virtualfn, info_array))
 
         return infos
 
-    def load(self, filename, appends, configdata):
+    def load(self, filename, appends):
         """Obtain the recipe information for the specified filename,
         using cached values if available, otherwise parsing.
 
@@ -479,13 +487,13 @@ class Cache(NoCache):
 
         return cached, infos
 
-    def loadData(self, fn, appends, cfgData, cacheData):
+    def loadData(self, fn, appends, cacheData):
         """Load the recipe info for the specified filename,
         parsing and adding to the cache if necessary, and adding
         the recipe information to the supplied CacheData instance."""
         skipped, virtuals = 0, 0
 
-        cached, infos = self.load(fn, appends, cfgData)
+        cached, infos = self.load(fn, appends)
         for virtualfn, info_array in infos:
             if info_array[0].skipped:
                 logger.debug(1, "Skipping %s: %s", virtualfn, info_array[0].skipreason)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 43c4f78..fe95e73 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -617,7 +617,8 @@ class BBCooker:
 
         if fn:
             try:
-                envdata = bb.cache.Cache.loadDataFull(fn, self.collection.get_file_appends(fn), self.data)
+                bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
+                envdata = bb_cache.loadDataFull(fn, self.collection.get_file_appends(fn))
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
@@ -1254,9 +1255,9 @@ class BBCooker:
 
         self.buildSetVars()
 
-        infos = bb.cache.Cache.parse(fn, self.collection.get_file_appends(fn), \
-                                     self.data,
-                                     self.caches_array)
+        bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
+
+        infos = bb_cache.parse(fn, self.collection.get_file_appends(fn))
         infos = dict(infos)
 
         fn = bb.cache.realfn2virtual(fn, cls)
@@ -1943,7 +1944,7 @@ class Parser(multiprocessing.Process):
             except queue.Full:
                 pending.append(result)
 
-    def parse(self, filename, appends, caches_array):
+    def parse(self, filename, appends):
         try:
             # Record the filename we're parsing into any events generated
             def parse_filter(self, record):
@@ -1956,7 +1957,7 @@ class Parser(multiprocessing.Process):
             bb.event.set_class_handlers(self.handlers.copy())
             bb.event.LogHandler.filter = parse_filter
 
-            return True, bb.cache.Cache.parse(filename, appends, self.cfg, caches_array)
+            return True, self.bb_cache.parse(filename, appends)
         except Exception as exc:
             tb = sys.exc_info()[2]
             exc.recipe = filename
@@ -1995,7 +1996,7 @@ class CookerParser(object):
         for filename in self.filelist:
             appends = self.cooker.collection.get_file_appends(filename)
             if not self.bb_cache.cacheValid(filename, appends):
-                self.willparse.append((filename, appends, cooker.caches_array))
+                self.willparse.append((filename, appends))
             else:
                 self.fromcache.append((filename, appends))
         self.toparse = self.total - len(self.fromcache)
@@ -2013,7 +2014,7 @@ class CookerParser(object):
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
             def init():
-                Parser.cfg = self.cfgdata
+                Parser.bb_cache = self.bb_cache
                 bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
@@ -2084,7 +2085,7 @@ class CookerParser(object):
 
     def load_cached(self):
         for filename, appends in self.fromcache:
-            cached, infos = self.bb_cache.load(filename, appends, self.cfgdata)
+            cached, infos = self.bb_cache.load(filename, appends)
             yield not cached, infos
 
     def parse_generator(self):
@@ -2168,8 +2169,6 @@ class CookerParser(object):
         return True
 
     def reparse(self, filename):
-        infos = self.bb_cache.parse(filename,
-                                    self.cooker.collection.get_file_appends(filename),
-                                    self.cfgdata, self.cooker.caches_array)
+        infos = self.bb_cache.parse(filename, self.cooker.collection.get_file_appends(filename))
         for vfn, info_array in infos:
             self.cooker.recipecache.add_from_recipeinfo(vfn, info_array)



