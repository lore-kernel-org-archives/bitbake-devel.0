Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 028B27016E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 20:48:53 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 30 Aug 2016 13:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,258,1470726000"; d="scan'208";a="162622932"
Received: from ashuvini-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.135])
	by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2016 13:48:53 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Aug 2016 08:48:08 +1200
Message-Id: <634deb5b43cf3470c41e1ee86cef05c7fd31df9d.1472589757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 3/4] cache: allow parsing a recipe with a custom config datastore
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
X-List-Received-Date: Tue, 30 Aug 2016 20:48:54 -0000

To accommodate the OpenEmbedded layer index recipe parsing, we have to
have the ability to pass in a custom config datastore since it
constructs a synthetic one. To make this possible after the multi-config
changes, rename the internal _load_bbfile() function to parse_recipe(),
make it a function at the module level (since it doesn't actually need
to access any members of the class or instance) and move setting
__BBMULTICONFIG inside it since other code will expect that to be set.

Part of the fix for [YOCTO #10192].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cache.py | 73 ++++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 0d5a034..ccad5c8 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -286,6 +286,42 @@ def variant2virtual(realfn, variant):
         return "multiconfig:" + elems[1] + ":" + realfn
     return "virtual:" + variant + ":" + realfn
 
+def parse_recipe(bb_data, bbfile, appends, mc=''):
+    """
+    Parse a recipe
+    """
+
+    chdir_back = False
+
+    bb_data.setVar("__BBMULTICONFIG", mc)
+
+    # expand tmpdir to include this topdir
+    bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR', True) or "")
+    bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
+    oldpath = os.path.abspath(os.getcwd())
+    bb.parse.cached_mtime_noerror(bbfile_loc)
+
+    # The ConfHandler first looks if there is a TOPDIR and if not
+    # then it would call getcwd().
+    # Previously, we chdir()ed to bbfile_loc, called the handler
+    # and finally chdir()ed back, a couple of thousand times. We now
+    # just fill in TOPDIR to point to bbfile_loc if there is no TOPDIR yet.
+    if not bb_data.getVar('TOPDIR', False):
+        chdir_back = True
+        bb_data.setVar('TOPDIR', bbfile_loc)
+    try:
+        if appends:
+            bb_data.setVar('__BBAPPEND', " ".join(appends))
+        bb_data = bb.parse.handle(bbfile, bb_data)
+        if chdir_back:
+            os.chdir(oldpath)
+        return bb_data
+    except:
+        if chdir_back:
+            os.chdir(oldpath)
+        raise
+
+
 
 class NoCache(object):
 
@@ -312,54 +348,23 @@ class NoCache(object):
         if virtonly:
             (bbfile, virtual, mc) = virtualfn2realfn(bbfile)
             bb_data = self.databuilder.mcdata[mc].createCopy()
-            bb_data.setVar("__BBMULTICONFIG", mc) 
             bb_data.setVar("__ONLYFINALISE", virtual or "default")
-            datastores = self._load_bbfile(bb_data, bbfile, appends)
+            datastores = parse_recipe(bb_data, bbfile, appends, mc)
             return datastores
 
         bb_data = self.data.createCopy()
-        datastores = self._load_bbfile(bb_data, bbfile, appends)
+        datastores = parse_recipe(bb_data, bbfile, appends, mc)
 
         for mc in self.databuilder.mcdata:
             if not mc:
                 continue
             bb_data = self.databuilder.mcdata[mc].createCopy()
-            bb_data.setVar("__BBMULTICONFIG", mc) 
-            newstores = self._load_bbfile(bb_data, bbfile, appends)
+            newstores = parse_recipe(bb_data, bbfile, appends, mc)
             for ns in newstores:
                 datastores["multiconfig:%s:%s" % (mc, ns)] = newstores[ns]
 
         return datastores
 
-    def _load_bbfile(self, bb_data, bbfile, appends):
-        chdir_back = False
-
-        # expand tmpdir to include this topdir
-        bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR', True) or "")
-        bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
-        oldpath = os.path.abspath(os.getcwd())
-        bb.parse.cached_mtime_noerror(bbfile_loc)
-
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
-            bb_data = bb.parse.handle(bbfile, bb_data)
-            if chdir_back:
-                os.chdir(oldpath)
-            return bb_data
-        except:
-            if chdir_back:
-                os.chdir(oldpath)
-            raise
-
 class Cache(NoCache):
     """
     BitBake Cache implementation
-- 
2.5.5


