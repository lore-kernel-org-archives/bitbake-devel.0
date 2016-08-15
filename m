Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BB38E74197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH2icn010898 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:02:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ibipwUQlkSxv for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:02:43 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH2fto010895
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:02:42 +0100
Message-ID: <1471280561.20391.98.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 18:02:41 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache: Split Cache() into a NoCache() parent object
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
X-List-Received-Date: Mon, 15 Aug 2016 17:02:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are some cases we want to parse recipes without any cache
setup or involvement. Split out the standalone functions into
a NoCache variant which the Cache is based upon, setting the scene
for further cleanup and restructuring.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 7118c83..8c1fe11 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -265,12 +265,68 @@ def realfn2virtual(realfn, cls):
         return realfn
     return "virtual:" + cls + ":" + realfn
 
-class Cache(object):
+class NoCache(object):
+
+    def __init__(self, databuilder):
+        self.databuilder = databuilder
+        self.data = databuilder.data
+
+    @classmethod
+    def loadDataFull(cls, virtualfn, appends, cfgData):
+        """
+        Return a complete set of data for fn.
+        To do this, we need to parse the file.
+        """
+
+        (fn, virtual) = virtualfn2realfn(virtualfn)
+
+        logger.debug(1, "Parsing %s (full)", fn)
+
+        cfgData.setVar("__ONLYFINALISE", virtual or "default")
+        bb_data = cls.load_bbfile(fn, appends, cfgData)
+        return bb_data[virtual]
+
+    @staticmethod
+    def load_bbfile(bbfile, appends, config):
+        """
+        Load and parse one .bb build file
+        Return the data and whether parsing resulted in the file being skipped
+        """
+        chdir_back = False
+
+        # expand tmpdir to include this topdir
+        config.setVar('TMPDIR', config.getVar('TMPDIR', True) or "")
+        bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
+        oldpath = os.path.abspath(os.getcwd())
+        bb.parse.cached_mtime_noerror(bbfile_loc)
+        bb_data = config.createCopy()
+        # The ConfHandler first looks if there is a TOPDIR and if not
+        # then it would call getcwd().
+        # Previously, we chdir()ed to bbfile_loc, called the handler
+        # and finally chdir()ed back, a couple of thousand times. We now
+        # just fill in TOPDIR to point to bbfile_loc if there is no TOPDIR yet.
+        if not bb_data.getVar('TOPDIR', False):
+            chdir_back = True
+            bb_data.setVar('TOPDIR', bbfile_loc)
+        try:
+            if appends:
+                bb_data.setVar('__BBAPPEND', " ".join(appends))
+            bb_data = bb.parse.handle(bbfile, bb_data)
+            if chdir_back:
+                os.chdir(oldpath)
+            return bb_data
+        except:
+            if chdir_back:
+                os.chdir(oldpath)
+            raise
+
+class Cache(NoCache):
     """
     BitBake Cache implementation
     """
 
     def __init__(self, databuilder, data_hash, caches_array):
+        super().__init__(databuilder)
         data = databuilder.data
 
         # Pass caches_array information into Cache Constructor
@@ -376,21 +432,6 @@ class Cache(object):
                       self.data)
 
     @classmethod
-    def loadDataFull(cls, virtualfn, appends, cfgData):
-        """
-        Return a complete set of data for fn.
-        To do this, we need to parse the file.
-        """
-
-        (fn, virtual) = virtualfn2realfn(virtualfn)
-
-        logger.debug(1, "Parsing %s (full)", fn)
-
-        cfgData.setVar("__ONLYFINALISE", virtual or "default")
-        bb_data = cls.load_bbfile(fn, appends, cfgData)
-        return bb_data[virtual]
-
-    @classmethod
     def parse(cls, filename, appends, configdata, caches_array):
         """Parse the specified filename, returning the recipe information"""
         logger.debug(1, "Parsing %s", filename)
@@ -648,42 +689,6 @@ class Cache(object):
             info_array.append(cache_class(realfn, data))
         self.add_info(file_name, info_array, cacheData, parsed)
 
-    @staticmethod
-    def load_bbfile(bbfile, appends, config):
-        """
-        Load and parse one .bb build file
-        Return the data and whether parsing resulted in the file being skipped
-        """
-        chdir_back = False
-
-        from bb import parse
-
-        # expand tmpdir to include this topdir
-        config.setVar('TMPDIR', config.getVar('TMPDIR', True) or "")
-        bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
-        oldpath = os.path.abspath(os.getcwd())
-        parse.cached_mtime_noerror(bbfile_loc)
-        bb_data = config.createCopy()
-        # The ConfHandler first looks if there is a TOPDIR and if not
-        # then it would call getcwd().
-        # Previously, we chdir()ed to bbfile_loc, called the handler
-        # and finally chdir()ed back, a couple of thousand times. We now
-        # just fill in TOPDIR to point to bbfile_loc if there is no TOPDIR yet.
-        if not bb_data.getVar('TOPDIR', False):
-            chdir_back = True
-            bb_data.setVar('TOPDIR', bbfile_loc)
-        try:
-            if appends:
-                bb_data.setVar('__BBAPPEND', " ".join(appends))
-            bb_data = parse.handle(bbfile, bb_data)
-            if chdir_back:
-                os.chdir(oldpath)
-            return bb_data
-        except:
-            if chdir_back:
-                os.chdir(oldpath)
-            raise
-
 
 def init(cooker):
     """



