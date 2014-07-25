Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B62CC706D2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jul 2014 13:54:35 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6PDsCYu023876 for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jul 2014 14:54:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id htsxXvqihggU for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jul 2014 14:54:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6PDsSmQ023892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jul 2014 14:54:30 +0100
Message-ID: <1406296463.27697.27.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jul 2014 14:54:23 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] codeparser cache improvements
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
X-List-Received-Date: Fri, 25 Jul 2014 13:54:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

It turns out the codeparser cache is the bottleneck I've been observing when running
bitbake commands, particularly as it grows. There are some things we can do about
this:

* We were processing the cache with "intern()" at save time. Its actually much
  more memory efficient to do this at creation time.

* Use hashable objects such as frozenset rather than set so that we can
  compare objects

* De-duplicate the cache objects, link duplicates to the same object saving
  memory and disk usage and improving speed

* Using custom setstate/getstate to avoid the overhead of object attribute names
  in the cache file

To make this work, a global cache was needed for the list of set objects as
this was the only way I could find to get the data in at setstate object creation
time :(.

Parsing shows a modest improvement with these changes, cache load time is
significantly better, cache save time is reduced since there is now no need
to reprocess the data and cache is much smaller.

We can drop the compress_keys() code and internSet code from the shared cache 
core since its no longer used and replaced by codeparser specific pieces.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index c7f3b7a..f892d7d 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -764,16 +764,6 @@ class MultiProcessCache(object):
 
         self.cachedata = data
 
-    def internSet(self, items):
-        new = set()
-        for i in items:
-            new.add(intern(i))
-        return new
-
-    def compress_keys(self, data):
-        # Override in subclasses if desired
-        return
-
     def create_cachedata(self):
         data = [{}]
         return data
@@ -833,8 +823,6 @@ class MultiProcessCache(object):
             self.merge_data(extradata, data)
             os.unlink(f)
 
-        self.compress_keys(data)
-
         with open(self.cachefile, "wb") as f:
             p = pickle.Pickler(f, -1)
             p.dump([data, self.__class__.CACHE_VERSION])
diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index 2e8de12..8b8f91a 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -33,9 +33,82 @@ def check_indent(codestr):
     return codestr
 
 
+# Basically pickle, in python 2.7.3 at least, does badly with data duplication 
+# upon pickling and unpickling. Combine this with duplicate objects and things
+# are a mess.
+#
+# When the sets are originally created, python calls intern() on the set keys
+# which significantly improves memory usage. Sadly the pickle/unpickle process
+# doesn't call intern() on the keys and results in the same strings being duplicated
+# in memory. This also means pickle will save the same string multiple times in
+# the cache file.
+#
+# By having shell and python cacheline objects with setstate/getstate, we force
+# the object creation through our own routine where we can call intern (via internSet).
+#
+# We also use hashable frozensets and ensure we use references to these so that
+# duplicates can be removed, both in memory and in the resulting pickled data.
+#
+# By playing these games, the size of the cache file shrinks dramatically
+# meaning faster load times and the reloaded cache files also consume much less
+# memory. Smaller cache files, faster load times and lower memory usage is good.
+#
+# A custom getstate/setstate using tuples is actually worth 15% cachesize by
+# avoiding duplication of the attribute names!
+
+class SetCache(object):
+    def __init__(self):
+        self.setcache = {}
+
+    def internSet(self, items):
+        
+        new = []
+        for i in items:
+            new.append(intern(i))
+        s = frozenset(new)
+        if hash(s) in self.setcache:
+            return self.setcache[hash(s)]
+        self.setcache[hash(s)] = s
+        return s
+
+codecache = SetCache()
+
+class pythonCacheLine(object):
+    def __init__(self, refs, execs, contains):
+        self.refs = codecache.internSet(refs)
+        self.execs = codecache.internSet(execs)
+        self.contains = {}
+        for c in contains:
+            self.contains[c] = codecache.internSet(contains[c])
+
+    def __getstate__(self):
+        return (self.refs, self.execs, self.contains)
+
+    def __setstate__(self, state):
+        (refs, execs, contains) = state
+        self.__init__(refs, execs, contains)
+    def __hash__(self):
+        l = (hash(self.refs), hash(self.execs))
+        for c in sorted(self.contains.keys()):
+            l = l + (c, hash(self.contains[c]))
+        return hash(l)
+
+class shellCacheLine(object):
+    def __init__(self, execs):
+        self.execs = codecache.internSet(execs)
+
+    def __getstate__(self):
+        return (self.execs)
+
+    def __setstate__(self, state):
+        (execs) = state
+        self.__init__(execs)
+    def __hash__(self):
+        return hash(self.execs)
+
 class CodeParserCache(MultiProcessCache):
     cache_file_name = "bb_codeparser.dat"
-    CACHE_VERSION = 6
+    CACHE_VERSION = 7
 
     def __init__(self):
         MultiProcessCache.__init__(self)
@@ -44,6 +117,27 @@ class CodeParserCache(MultiProcessCache):
         self.pythoncacheextras = self.cachedata_extras[0]
         self.shellcacheextras = self.cachedata_extras[1]
 
+        # To avoid duplication in the codeparser cache, keep
+        # a lookup of hashes of objects we already have
+        self.pythoncachelines = {}
+        self.shellcachelines = {}
+
+    def newPythonCacheLine(self, refs, execs, contains):
+        cacheline = pythonCacheLine(refs, execs, contains)
+        h = hash(cacheline)
+        if h in self.pythoncachelines:
+            return self.pythoncachelines[h]
+        self.pythoncachelines[h] = cacheline
+        return cacheline
+
+    def newShellCacheLine(self, execs):
+        cacheline = shellCacheLine(execs)
+        h = hash(cacheline)
+        if h in self.shellcachelines:
+            return self.shellcachelines[h]
+        self.shellcachelines[h] = cacheline
+        return cacheline
+
     def init_cache(self, d):
         MultiProcessCache.init_cache(self, d)
 
@@ -51,25 +145,6 @@ class CodeParserCache(MultiProcessCache):
         self.pythoncache = self.cachedata[0]
         self.shellcache = self.cachedata[1]
 
-    def compress_keys(self, data):
-        # When the dicts are originally created, python calls intern() on the set keys
-        # which significantly improves memory usage. Sadly the pickle/unpickle process
-        # doesn't call intern() on the keys and results in the same strings being duplicated
-        # in memory. This also means pickle will save the same string multiple times in
-        # the cache file. By interning the data here, the cache file shrinks dramatically
-        # meaning faster load times and the reloaded cache files also consume much less
-        # memory. This is worth any performance hit from this loops and the use of the
-        # intern() data storage.
-        # Python 3.x may behave better in this area
-        for h in data[0]:
-            data[0][h]["refs"] = self.internSet(data[0][h]["refs"])
-            data[0][h]["execs"] = self.internSet(data[0][h]["execs"])
-            for k in data[0][h]["contains"]:
-                data[0][h]["contains"][k] = self.internSet(data[0][h]["contains"][k])
-        for h in data[1]:
-            data[1][h]["execs"] = self.internSet(data[1][h]["execs"])
-        return
-
     def create_cachedata(self):
         data = [{}, {}]
         return data
@@ -168,15 +243,19 @@ class PythonParser():
         h = hash(str(node))
 
         if h in codeparsercache.pythoncache:
-            self.references = codeparsercache.pythoncache[h]["refs"]
-            self.execs = codeparsercache.pythoncache[h]["execs"]
-            self.contains = codeparsercache.pythoncache[h]["contains"]
+            self.references = set(codeparsercache.pythoncache[h].refs)
+            self.execs = set(codeparsercache.pythoncache[h].execs)
+            self.contains = {}
+            for i in codeparsercache.pythoncache[h].contains:
+                self.contains[i] = set(codeparsercache.pythoncache[h].contains[i])
             return
 
         if h in codeparsercache.pythoncacheextras:
-            self.references = codeparsercache.pythoncacheextras[h]["refs"]
-            self.execs = codeparsercache.pythoncacheextras[h]["execs"]
-            self.contains = codeparsercache.pythoncacheextras[h]["contains"]
+            self.references = set(codeparsercache.pythoncacheextras[h].refs)
+            self.execs = set(codeparsercache.pythoncacheextras[h].execs)
+            self.contains = {}
+            for i in codeparsercache.pythoncacheextras[h].contains:
+                self.contains[i] = set(codeparsercache.pythoncacheextras[h].contains[i])
             return
 
         code = compile(check_indent(str(node)), "<string>", "exec",
@@ -188,10 +267,7 @@ class PythonParser():
 
         self.execs.update(self.var_execs)
 
-        codeparsercache.pythoncacheextras[h] = {}
-        codeparsercache.pythoncacheextras[h]["refs"] = self.references
-        codeparsercache.pythoncacheextras[h]["execs"] = self.execs
-        codeparsercache.pythoncacheextras[h]["contains"] = self.contains
+        codeparsercache.pythoncacheextras[h] = codeparsercache.newPythonCacheLine(self.references, self.execs, self.contains)
 
 class ShellParser():
     def __init__(self, name, log):
@@ -210,18 +286,17 @@ class ShellParser():
         h = hash(str(value))
 
         if h in codeparsercache.shellcache:
-            self.execs = codeparsercache.shellcache[h]["execs"]
+            self.execs = set(codeparsercache.shellcache[h].execs)
             return self.execs
 
         if h in codeparsercache.shellcacheextras:
-            self.execs = codeparsercache.shellcacheextras[h]["execs"]
+            self.execs = set(codeparsercache.shellcacheextras[h].execs)
             return self.execs
 
         self._parse_shell(value)
         self.execs = set(cmd for cmd in self.allexecs if cmd not in self.funcdefs)
 
-        codeparsercache.shellcacheextras[h] = {}
-        codeparsercache.shellcacheextras[h]["execs"] = self.execs
+        codeparsercache.shellcacheextras[h] = codeparsercache.newShellCacheLine(self.execs)
 
         return self.execs
 



