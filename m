Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UapLv-00006c-EA for bitbake-devel@lists.openembedded.org;
	Fri, 10 May 2013 17:35:33 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFJoMd010516 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:19:50 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DCQaIbi09Qbl for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:19:49 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFJk8D010509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:19:47 +0100
Message-ID: <1368199026.11129.34.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 May 2013 16:17:06 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Separate out collections handling code into its own class
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
X-List-Received-Date: Fri, 10 May 2013 15:35:34 -0000
X-List-Received-Date: Fri, 10 May 2013 15:35:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



The Cooker class is too large and needs to be split up into different
functional units. Splitting out the collections code into its own class
seems like a good place to start to try and disentangle things.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5c52d85..da598c9 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -89,7 +89,6 @@ class BBCooker:
 
     def __init__(self, configuration, server_registration_cb, savedenv={}):
         self.status = None
-        self.appendlist = {}
         self.skiplist = {}
 
         self.server_registration_cb = server_registration_cb
@@ -419,7 +418,7 @@ class BBCooker:
 
         if fn:
             try:
-                envdata = bb.cache.Cache.loadDataFull(fn, self.get_file_appends(fn), self.configuration.data)
+                envdata = bb.cache.Cache.loadDataFull(fn, self.collection.get_file_appends(fn), self.configuration.data)
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
@@ -698,22 +697,13 @@ class BBCooker:
         print("}", file=tdepends_file)
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
-    def calc_bbfile_priority( self, filename, matched = None ):
-        for _, _, regex, pri in self.status.bbfile_config_priorities:
-            if regex.match(filename):
-                if matched != None:
-                    if not regex in matched:
-                        matched.add(regex)
-                return pri
-        return 0
-
     def show_appends_with_no_recipes( self ):
         recipes = set(os.path.basename(f)
                       for f in self.status.pkg_fn.iterkeys())
         recipes |= set(os.path.basename(f)
                       for f in self.skiplist.iterkeys())
-        appended_recipes = self.appendlist.iterkeys()
-        appends_without_recipes = [self.appendlist[recipe]
+        appended_recipes = self.collection.appendlist.iterkeys()
+        appends_without_recipes = [self.collection.appendlist[recipe]
                                    for recipe in appended_recipes
                                    if recipe not in recipes]
         if appends_without_recipes:
@@ -747,32 +737,8 @@ class BBCooker:
                 providerlog.error("conflicting preferences for %s: both %s and %s specified", providee, provider, self.status.preferred[providee])
             self.status.preferred[providee] = provider
 
-        # Calculate priorities for each file
-        matched = set()
-        for p in self.status.pkg_fn:
-            realfn, cls = bb.cache.Cache.virtualfn2realfn(p)
-            self.status.bbfile_priority[p] = self.calc_bbfile_priority(realfn, matched)
  
-        # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
-        unmatched = set()
-        for _, _, regex, pri in self.status.bbfile_config_priorities:        
-            if not regex in matched:
-                unmatched.add(regex)
-
-        def findmatch(regex):
-            for bbfile in self.appendlist:
-                for append in self.appendlist[bbfile]:
-                    if regex.match(append):
-                        return True
-            return False
-
-        for unmatch in unmatched.copy():
-            if findmatch(unmatch):
-                unmatched.remove(unmatch)
-
-        for collection, pattern, regex, _ in self.status.bbfile_config_priorities:
-            if regex in unmatched:
-                collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
+        self.status.bbfile_priority = self.collection.collection_priorities(self.status.pkg_fn)
 
     def findCoreBaseFiles(self, subdir, configfile):
         corebase = self.configuration.data.getVar('COREBASE', True) or ""
@@ -1111,7 +1077,9 @@ class BBCooker:
         """
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
-        filelist, masked = self.collect_bbfiles()
+
+        self.collection = CookerCollectFiles(self.status.bbfile_config_priorities)
+        filelist, masked = self.collection.collect_bbfiles(self.configuration.data, self.configuration.event_data)
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1165,7 +1133,7 @@ class BBCooker:
         self.buildSetVars()
 
         self.status = bb.cache.CacheData(self.caches_array)
-        infos = bb.cache.Cache.parse(fn, self.get_file_appends(fn), \
+        infos = bb.cache.Cache.parse(fn, self.collection.get_file_appends(fn), \
                                      self.configuration.data,
                                      self.caches_array)
         infos = dict(infos)
@@ -1332,7 +1300,9 @@ class BBCooker:
             for dep in self.configuration.extra_assume_provided:
                 self.status.ignored_dependencies.add(dep)
 
-            (filelist, masked) = self.collect_bbfiles()
+            self.collection = CookerCollectFiles(self.status.bbfile_config_priorities)
+            (filelist, masked) = self.collection.collect_bbfiles(self.configuration.data, self.configuration.event_data)
+
             self.configuration.data.renameVar("__depends", "__base_depends")
 
             self.parser = CookerParser(self, filelist, masked)
@@ -1369,7 +1339,87 @@ class BBCooker:
 
         return pkgs_to_build
 
-    def get_bbfiles( self, path = os.getcwd() ):
+
+
+
+    def pre_serve(self):
+        # Empty the environment. The environment will be populated as
+        # necessary from the data store.
+        #bb.utils.empty_environment()
+        try:
+            prserv.serv.auto_start(self.configuration.data)
+        except prserv.serv.PRServiceConfigError:
+            bb.event.fire(CookerExit(), self.configuration.event_data)
+        return
+
+    def post_serve(self):
+        prserv.serv.auto_shutdown(self.configuration.data)
+        bb.event.fire(CookerExit(), self.configuration.event_data)
+
+    def shutdown(self):
+        self.state = state.shutdown
+
+    def stop(self):
+        self.state = state.stop
+
+    def reparseFiles(self):
+        return
+
+    def initialize(self):
+        self.state = state.initial
+        self.initConfigurationData()
+
+    def reset(self):
+        self.state = state.initial
+        self.loadConfigurationData()
+
+def server_main(cooker, func, *args):
+    cooker.pre_serve()
+
+    if cooker.configuration.profile:
+        try:
+            import cProfile as profile
+        except:
+            import profile
+        prof = profile.Profile()
+
+        ret = profile.Profile.runcall(prof, func, *args)
+
+        prof.dump_stats("profile.log")
+        bb.utils.process_profilelog("profile.log")
+        print("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
+
+    else:
+        ret = func(*args)
+
+    cooker.post_serve()
+
+    return ret
+
+class CookerExit(bb.event.Event):
+    """
+    Notify clients of the Cooker shutdown
+    """
+
+    def __init__(self):
+        bb.event.Event.__init__(self)
+
+
+class CookerCollectFiles(object):
+    def __init__(self, priorities):
+        self.appendlist = {}
+        self.bbfile_config_priorities = priorities
+
+    def calc_bbfile_priority( self, filename, matched = None ):
+        for _, _, regex, pri in self.bbfile_config_priorities:
+            if regex.match(filename):
+                if matched != None:
+                    if not regex in matched:
+                        matched.add(regex)
+                return pri
+        return 0
+
+    def get_bbfiles(self, path = os.getcwd()):
         """Get list of default .bb files by reading out the current directory"""
         contents = os.listdir(path)
         bbfiles = []
@@ -1379,7 +1429,7 @@ class BBCooker:
                 bbfiles.append(os.path.abspath(os.path.join(os.getcwd(), f)))
         return bbfiles
 
-    def find_bbfiles( self, path ):
+    def find_bbfiles(self, path):
         """Find all the .bb and .bbappend files in a directory"""
         from os.path import join
 
@@ -1392,14 +1442,14 @@ class BBCooker:
 
         return found
 
-    def collect_bbfiles( self ):
+    def collect_bbfiles(self, config, eventdata):
         """Collect all available .bb build files"""
         masked = 0
 
         collectlog.debug(1, "collecting .bb files")
 
-        files = (data.getVar( "BBFILES", self.configuration.data, True) or "").split()
-        data.setVar("BBFILES", " ".join(files), self.configuration.data)
+        files = (config.getVar( "BBFILES", True) or "").split()
+        config.setVar("BBFILES", " ".join(files))
 
         # Sort files by priority
         files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem) )
@@ -1409,7 +1459,7 @@ class BBCooker:
 
         if not len(files):
             collectlog.error("no recipe files to build, check your BBPATH and BBFILES?")
-            bb.event.fire(CookerExit(), self.configuration.event_data)
+            bb.event.fire(CookerExit(), eventdata)
 
         # Can't use set here as order is important
         newfiles = []
@@ -1427,7 +1477,7 @@ class BBCooker:
                     if g not in newfiles:
                         newfiles.append(g)
 
-        bbmask = self.configuration.data.getVar('BBMASK', True)
+        bbmask = config.getVar('BBMASK', True)
 
         if bbmask:
             try:
@@ -1475,74 +1525,44 @@ class BBCooker:
     def get_file_appends(self, fn):
         """
         Returns a list of .bbappend files to apply to fn
-        NB: collect_bbfiles() must have been called prior to this
         """
         f = os.path.basename(fn)
         if f in self.appendlist:
             return self.appendlist[f]
         return []
 
-    def pre_serve(self):
-        # Empty the environment. The environment will be populated as
-        # necessary from the data store.
-        #bb.utils.empty_environment()
-        try:
-            prserv.serv.auto_start(self.configuration.data)
-        except prserv.serv.PRServiceConfigError:
-            bb.event.fire(CookerExit(), self.configuration.event_data)
-        return
-
-    def post_serve(self):
-        prserv.serv.auto_shutdown(self.configuration.data)
-        bb.event.fire(CookerExit(), self.configuration.event_data)
-
-    def shutdown(self):
-        self.state = state.shutdown
+    def collection_priorities(self, pkgfns):
 
-    def stop(self):
-        self.state = state.stop
-
-    def reparseFiles(self):
-        return
-
-    def initialize(self):
-        self.state = state.initial
-        self.initConfigurationData()
-
-    def reset(self):
-        self.state = state.initial
-        self.loadConfigurationData()
+        priorities = {}
 
-def server_main(cooker, func, *args):
-    cooker.pre_serve()
-
-    if cooker.configuration.profile:
-        try:
-            import cProfile as profile
-        except:
-            import profile
-        prof = profile.Profile()
-
-        ret = profile.Profile.runcall(prof, func, *args)
-
-        prof.dump_stats("profile.log")
-        bb.utils.process_profilelog("profile.log")
-        print("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
-
-    else:
-        ret = func(*args)
+        # Calculate priorities for each file
+        matched = set()
+        for p in pkgfns:
+            realfn, cls = bb.cache.Cache.virtualfn2realfn(p)
+            priorities[p] = self.calc_bbfile_priority(realfn, matched)
+ 
+        # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
+        unmatched = set()
+        for _, _, regex, pri in self.bbfile_config_priorities:        
+            if not regex in matched:
+                unmatched.add(regex)
 
-    cooker.post_serve()
+        def findmatch(regex):
+            for bbfile in self.appendlist:
+                for append in self.appendlist[bbfile]:
+                    if regex.match(append):
+                        return True
+            return False
 
-    return ret
+        for unmatch in unmatched.copy():
+            if findmatch(unmatch):
+                unmatched.remove(unmatch)
 
-class CookerExit(bb.event.Event):
-    """
-    Notify clients of the Cooker shutdown
-    """
+        for collection, pattern, regex, _ in self.bbfile_config_priorities:
+            if regex in unmatched:
+                collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
-    def __init__(self):
-        bb.event.Event.__init__(self)
+        return priorities
 
 def catch_parse_error(func):
     """Exception handling bits for our parsing"""
@@ -1677,7 +1697,7 @@ class CookerParser(object):
         self.fromcache = []
         self.willparse = []
         for filename in self.filelist:
-            appends = self.cooker.get_file_appends(filename)
+            appends = self.cooker.collection.get_file_appends(filename)
             if not self.bb_cache.cacheValid(filename, appends):
                 self.willparse.append((filename, appends, cooker.caches_array))
             else:
@@ -1840,7 +1860,7 @@ class CookerParser(object):
 
     def reparse(self, filename):
         infos = self.bb_cache.parse(filename,
-                                    self.cooker.get_file_appends(filename),
+                                    self.cooker.collection.get_file_appends(filename),
                                     self.cfgdata, self.cooker.caches_array)
         for vfn, info_array in infos:
             self.cooker.status.add_from_recipeinfo(vfn, info_array)




