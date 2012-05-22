Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SWyaI-0005N9-9Y
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 01:33:47 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2012 16:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="103080365"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.180])
	by AZSMGA002.ch.intel.com with ESMTP; 22 May 2012 16:23:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 May 2012 00:23:31 +0100
Message-Id: <e2c8c60013f8cda84fd5ec5819811583862c8c53.1337728949.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1337728949.git.paul.eggleton@linux.intel.com>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1337728949.git.paul.eggleton@linux.intel.com>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: refactor out codeparser cache into a separate class
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
X-List-Received-Date: Tue, 22 May 2012 23:33:47 -0000

We want to be able to reuse most this functionality for the file
checksum cache.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cache.py      |  116 ++++++++++++++++++++++++-
 bitbake/lib/bb/codeparser.py |  191 +++++++++++++-----------------------------
 2 files changed, 171 insertions(+), 136 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 47e814b..36e6356 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -1,11 +1,12 @@
 # ex:ts=4:sw=4:sts=4:et
 # -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
-# BitBake 'Event' implementation
+# BitBake Cache implementation
 #
 # Caching of bitbake variables before task execution
 
 # Copyright (C) 2006        Richard Purdie
+# Copyright (C) 2012        Intel Corporation
 
 # but small sections based on code from bin/bitbake:
 # Copyright (C) 2003, 2004  Chris Larson
@@ -703,4 +704,115 @@ class CacheData(object):
         for info in info_array:
             info.add_cacheData(self, fn)
 
-        
+
+class MultiProcessCache(object):
+    """
+    BitBake multi-process cache implementation
+
+    Used by the codeparser & file checksum caches
+    """
+
+    def __init__(self):
+        self.cachefile = None
+        self.cachedata = self.create_cachedata()
+        self.cachedata_extras = self.create_cachedata()
+
+    def init_cache(self, d):
+        cachedir = (d.getVar("PERSISTENT_DIR", True) or
+                    d.getVar("CACHE", True))
+        if cachedir in [None, '']:
+            return
+        bb.utils.mkdirhier(cachedir)
+        self.cachefile = os.path.join(cachedir, self.__class__.cache_file_name)
+        logger.debug(1, "Using cache in '%s'", self.cachefile)
+
+        try:
+            p = pickle.Unpickler(file(self.cachefile, "rb"))
+            data, version = p.load()
+        except:
+            return
+
+        if version != self.__class__.CACHE_VERSION:
+            return
+
+        self.cachedata = data
+
+    def internSet(self, items):
+        new = set()
+        for i in items:
+            new.add(intern(i))
+        return new
+
+    def compress_keys(self, data):
+        # Override in subclasses if desired
+        return
+
+    def create_cachedata(self):
+        data = [{}]
+        return data
+
+    def save_extras(self, d):
+        if not self.cachefile:
+            return
+
+        glf = bb.utils.lockfile(self.cachefile + ".lock", shared=True)
+
+        i = os.getpid()
+        lf = None
+        while not lf:
+            lf = bb.utils.lockfile(self.cachefile + ".lock." + str(i), retry=False)
+            if not lf or os.path.exists(self.cachefile + "-" + str(i)):
+                if lf:
+                    bb.utils.unlockfile(lf)
+                    lf = None
+                i = i + 1
+                continue
+
+            p = pickle.Pickler(file(self.cachefile + "-" + str(i), "wb"), -1)
+            p.dump([self.cachedata_extras, self.__class__.CACHE_VERSION])
+
+        bb.utils.unlockfile(lf)
+        bb.utils.unlockfile(glf)
+
+    def merge_data(self, source, dest):
+        for j in range(0,len(dest)):
+            for h in source[j]:
+                if h not in dest[j]:
+                    dest[j][h] = source[j][h]
+
+    def save_merge(self, d):
+        if not self.cachefile:
+            return
+
+        glf = bb.utils.lockfile(self.cachefile + ".lock")
+
+        try:
+            p = pickle.Unpickler(file(self.cachefile, "rb"))
+            data, version = p.load()
+        except (IOError, EOFError):
+            data, version = None, None
+
+        if version != self.__class__.CACHE_VERSION:
+            data = self.create_cachedata()
+
+        for f in [y for y in os.listdir(os.path.dirname(self.cachefile)) if y.startswith(os.path.basename(self.cachefile) + '-')]:
+            f = os.path.join(os.path.dirname(self.cachefile), f)
+            try:
+                p = pickle.Unpickler(file(f, "rb"))
+                extradata, version = p.load()
+            except (IOError, EOFError):
+                extradata, version = self.create_cachedata(), None
+
+            if version != self.__class__.CACHE_VERSION:
+                continue
+
+            self.merge_data(extradata, data)
+            os.unlink(f)
+
+        self.compress_keys(data)
+
+        p = pickle.Pickler(file(self.cachefile, "wb"), -1)
+        p.dump([data, self.__class__.CACHE_VERSION])
+
+        bb.utils.unlockfile(glf)
+
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index af2e194..d7d3f51 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -5,10 +5,10 @@ import os.path
 import bb.utils, bb.data
 from itertools import chain
 from pysh import pyshyacc, pyshlex, sherrors
+from bb.cache import MultiProcessCache
 
 
 logger = logging.getLogger('BitBake.CodeParser')
-PARSERCACHE_VERSION = 2
 
 try:
     import cPickle as pickle
@@ -32,133 +32,56 @@ def check_indent(codestr):
 
     return codestr
 
-pythonparsecache = {}
-shellparsecache = {}
-pythonparsecacheextras = {}
-shellparsecacheextras = {}
 
-
-def parser_cachefile(d):
-    cachedir = (d.getVar("PERSISTENT_DIR", True) or
-                d.getVar("CACHE", True))
-    if cachedir in [None, '']:
-        return None
-    bb.utils.mkdirhier(cachedir)
-    cachefile = os.path.join(cachedir, "bb_codeparser.dat")
-    logger.debug(1, "Using cache in '%s' for codeparser cache", cachefile)
-    return cachefile
-
-def parser_cache_init(d):
-    global pythonparsecache
-    global shellparsecache
-
-    cachefile = parser_cachefile(d)
-    if not cachefile:
+class CodeParserCache(MultiProcessCache):
+    cache_file_name = "bb_codeparser.dat"
+    CACHE_VERSION = 2
+
+    def __init__(self):
+        MultiProcessCache.__init__(self)
+        self.pythoncache = self.cachedata[0]
+        self.shellcache = self.cachedata[1]
+        self.pythoncacheextras = self.cachedata_extras[0]
+        self.shellcacheextras = self.cachedata_extras[1]
+
+    def init_cache(self, d):
+        MultiProcessCache.init_cache(self, d)
+
+        # cachedata gets re-assigned in the parent
+        self.pythoncache = self.cachedata[0]
+        self.shellcache = self.cachedata[1]
+
+    def compress_keys(self, data):
+        # When the dicts are originally created, python calls intern() on the set keys
+        # which significantly improves memory usage. Sadly the pickle/unpickle process
+        # doesn't call intern() on the keys and results in the same strings being duplicated
+        # in memory. This also means pickle will save the same string multiple times in
+        # the cache file. By interning the data here, the cache file shrinks dramatically
+        # meaning faster load times and the reloaded cache files also consume much less
+        # memory. This is worth any performance hit from this loops and the use of the
+        # intern() data storage.
+        # Python 3.x may behave better in this area
+        for h in data[0]:
+            data[0][h]["refs"] = self.internSet(data[0][h]["refs"])
+            data[0][h]["execs"] = self.internSet(data[0][h]["execs"])
+        for h in data[1]:
+            data[1][h]["execs"] = self.internSet(data[1][h]["execs"])
         return
 
-    try:
-        p = pickle.Unpickler(file(cachefile, "rb"))
-        data, version = p.load()
-    except:
-        return
+    def create_cachedata(self):
+        data = [{}, {}]
+        return data
 
-    if version != PARSERCACHE_VERSION:
-        return
+codeparsercache = CodeParserCache()
 
-    pythonparsecache = data[0]
-    shellparsecache = data[1]
+def parser_cache_init(d):
+    codeparsercache.init_cache(d)
 
 def parser_cache_save(d):
-    cachefile = parser_cachefile(d)
-    if not cachefile:
-        return
-
-    glf = bb.utils.lockfile(cachefile + ".lock", shared=True)
-
-    i = os.getpid()
-    lf = None
-    while not lf:
-        shellcache = {}
-        pythoncache = {}
-
-        lf = bb.utils.lockfile(cachefile + ".lock." + str(i), retry=False)
-        if not lf or os.path.exists(cachefile + "-" + str(i)):
-            if lf:
-               bb.utils.unlockfile(lf) 
-               lf = None
-            i = i + 1
-            continue
-
-        shellcache = shellparsecacheextras
-        pythoncache = pythonparsecacheextras
-
-        p = pickle.Pickler(file(cachefile + "-" + str(i), "wb"), -1)
-        p.dump([[pythoncache, shellcache], PARSERCACHE_VERSION])
-
-    bb.utils.unlockfile(lf)
-    bb.utils.unlockfile(glf)
-
-def internSet(items):
-    new = set()
-    for i in items:
-        new.add(intern(i))
-    return new
+    codeparsercache.save_extras(d)
 
 def parser_cache_savemerge(d):
-    cachefile = parser_cachefile(d)
-    if not cachefile:
-        return
-
-    glf = bb.utils.lockfile(cachefile + ".lock")
-
-    try:
-        p = pickle.Unpickler(file(cachefile, "rb"))
-        data, version = p.load()
-    except (IOError, EOFError):
-        data, version = None, None
-
-    if version != PARSERCACHE_VERSION:
-        data = [{}, {}]
-
-    for f in [y for y in os.listdir(os.path.dirname(cachefile)) if y.startswith(os.path.basename(cachefile) + '-')]:
-        f = os.path.join(os.path.dirname(cachefile), f)
-        try:
-            p = pickle.Unpickler(file(f, "rb"))
-            extradata, version = p.load()
-        except (IOError, EOFError):
-            extradata, version = [{}, {}], None
-        
-        if version != PARSERCACHE_VERSION:
-            continue
-
-        for h in extradata[0]:
-            if h not in data[0]:
-                data[0][h] = extradata[0][h]
-        for h in extradata[1]:
-            if h not in data[1]:
-                data[1][h] = extradata[1][h]
-        os.unlink(f)
-
-    # When the dicts are originally created, python calls intern() on the set keys
-    # which significantly improves memory usage. Sadly the pickle/unpickle process 
-    # doesn't call intern() on the keys and results in the same strings being duplicated
-    # in memory. This also means pickle will save the same string multiple times in 
-    # the cache file. By interning the data here, the cache file shrinks dramatically
-    # meaning faster load times and the reloaded cache files also consume much less 
-    # memory. This is worth any performance hit from this loops and the use of the 
-    # intern() data storage.
-    # Python 3.x may behave better in this area
-    for h in data[0]:
-        data[0][h]["refs"] = internSet(data[0][h]["refs"])
-        data[0][h]["execs"] = internSet(data[0][h]["execs"])
-    for h in data[1]:
-        data[1][h]["execs"] = internSet(data[1][h]["execs"])
-
-    p = pickle.Pickler(file(cachefile, "wb"), -1)
-    p.dump([data, PARSERCACHE_VERSION])
-
-    bb.utils.unlockfile(glf)
-
+    codeparsercache.save_merge(d)
 
 Logger = logging.getLoggerClass()
 class BufferedLogger(Logger):
@@ -235,14 +158,14 @@ class PythonParser():
     def parse_python(self, node):
         h = hash(str(node))
 
-        if h in pythonparsecache:
-            self.references = pythonparsecache[h]["refs"]
-            self.execs = pythonparsecache[h]["execs"]
+        if h in codeparsercache.pythoncache:
+            self.references = codeparsercache.pythoncache[h]["refs"]
+            self.execs = codeparsercache.pythoncache[h]["execs"]
             return
 
-        if h in pythonparsecacheextras:
-            self.references = pythonparsecacheextras[h]["refs"]
-            self.execs = pythonparsecacheextras[h]["execs"]
+        if h in codeparsercache.pythoncacheextras:
+            self.references = codeparsercache.pythoncacheextras[h]["refs"]
+            self.execs = codeparsercache.pythoncacheextras[h]["execs"]
             return
 
 
@@ -256,9 +179,9 @@ class PythonParser():
         self.references.update(self.var_references)
         self.references.update(self.var_execs)
 
-        pythonparsecacheextras[h] = {}
-        pythonparsecacheextras[h]["refs"] = self.references
-        pythonparsecacheextras[h]["execs"] = self.execs
+        codeparsercache.pythoncacheextras[h] = {}
+        codeparsercache.pythoncacheextras[h]["refs"] = self.references
+        codeparsercache.pythoncacheextras[h]["execs"] = self.execs
 
 class ShellParser():
     def __init__(self, name, log):
@@ -276,12 +199,12 @@ class ShellParser():
 
         h = hash(str(value))
 
-        if h in shellparsecache:
-            self.execs = shellparsecache[h]["execs"]
+        if h in codeparsercache.shellcache:
+            self.execs = codeparsercache.shellcache[h]["execs"]
             return self.execs
 
-        if h in shellparsecacheextras:
-            self.execs = shellparsecacheextras[h]["execs"]
+        if h in codeparsercache.shellcacheextras:
+            self.execs = codeparsercache.shellcacheextras[h]["execs"]
             return self.execs
 
         try:
@@ -293,8 +216,8 @@ class ShellParser():
             self.process_tokens(token)
         self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
 
-        shellparsecacheextras[h] = {}
-        shellparsecacheextras[h]["execs"] = self.execs
+        codeparsercache.shellcacheextras[h] = {}
+        codeparsercache.shellcacheextras[h]["execs"] = self.execs
 
         return self.execs
 
-- 
1.7.9.5



