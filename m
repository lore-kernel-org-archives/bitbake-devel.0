Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QRpFw-0003oi-F8
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 19:30:57 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jun 2011 10:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,304,1304319600"; d="scan'208";a="10449761"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.133])
	by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2011 10:26:33 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2011 18:26:29 +0100
Message-Id: <1cd9d0b284c1cd1966b0c2c1ea9fbad15c5ed5fc.1306947210.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1306947210.git.paul.eggleton@linux.intel.com>
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1306947210.git.paul.eggleton@linux.intel.com>
References: <cover.1306947210.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 1/2] bitbake: track skipped packages
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
X-List-Received-Date: Wed, 01 Jun 2011 17:30:57 -0000

Add skiplist to cooker that allows access to the list of packages skipped
via SkipPackage (this includes COMPATIBLE_MACHINE, INCOMPATIBLE_LICENSE,
etc.) This can be used to enhance error reporting.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cache.py     |   12 +++++++++---
 bitbake/lib/bb/cooker.py    |   16 ++++++++++++++++
 bitbake/lib/bb/parse/ast.py |   12 ++++++------
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index d083c51..076262b 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -59,6 +59,7 @@ recipe_fields = (
     'broken',
     'not_world',
     'skipped',
+    'skipreason',
     'timestamp',
     'packages',
     'packages_dynamic',
@@ -128,11 +129,15 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
 
     @classmethod
     def from_metadata(cls, filename, metadata):
-        if cls.getvar('__SKIPPED', metadata):
+        skipval = cls.getvar('__SKIPPED', metadata)
+        if skipval:
             return cls.make_optional(skipped=True,
+                                     skipreason=skipval,
                                      file_depends=metadata.getVar('__depends', False),
                                      timestamp=bb.parse.cached_mtime(filename),
-                                     variants=cls.listvar('__VARIANTS', metadata) + [''])
+                                     variants=cls.listvar('__VARIANTS', metadata) + [''],
+                                     provides=cls.depvar('PROVIDES', metadata),
+                                     rprovides=cls.depvar('RPROVIDES', metadata))
 
         tasks = metadata.getVar('__BBTASKS', False)
 
@@ -152,6 +157,7 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
             variants         = cls.listvar('__VARIANTS', metadata) + [''],
 
             skipped          = False,
+            skipreason       = None,
             timestamp        = bb.parse.cached_mtime(filename),
             packages         = cls.listvar('PACKAGES', metadata),
             pn               = pn,
@@ -348,7 +354,7 @@ class Cache(object):
         cached, infos = self.load(fn, appends, cfgData)
         for virtualfn, info in infos:
             if info.skipped:
-                logger.debug(1, "Skipping %s", virtualfn)
+                logger.debug(1, "Skipping %s: %s", (virtualfn, info.skipreason) )
                 skipped += 1
             else:
                 self.add_info(virtualfn, info, cacheData, not cached)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0b52f18..9b12e0d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -55,6 +55,20 @@ class NothingToBuild(Exception):
 class state:
     initial, parsing, running, shutdown, stop = range(5)
 
+
+class SkippedPackage:
+    def __init__(self, info = None, reason = None):
+        self.skipreason = None
+        self.provides = None
+        self.rprovides = None
+
+        if info:
+            self.skipreason = info.skipreason
+            self.provides = info.provides
+            self.rprovides = info.rprovides
+        elif reason:
+            self.skipreason = reason
+
 #============================================================================#
 # BBCooker
 #============================================================================#
@@ -66,6 +80,7 @@ class BBCooker:
     def __init__(self, configuration, server):
         self.status = None
         self.appendlist = {}
+        self.skiplist = {}
 
         if server:
             self.server = server.BitBakeServer(self)
@@ -1198,6 +1213,7 @@ class CookerParser(object):
         for virtualfn, info in result:
             if info.skipped:
                 self.skipped += 1
+                self.cooker.skiplist[virtualfn] = SkippedPackage(info)
             self.bb_cache.add_info(virtualfn, info, self.cooker.status,
                                         parsed=parsed)
         return True
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 375dc61..18e491c 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -376,8 +376,8 @@ def multi_finalize(fn, d):
     try:
         if not onlyfinalise or "default" in onlyfinalise:
             finalize(fn, d)
-    except bb.parse.SkipPackage:
-        bb.data.setVar("__SKIPPED", True, d)
+    except bb.parse.SkipPackage as e:
+        bb.data.setVar("__SKIPPED", e.args[0], d)
     datastores = {"": safe_d}
 
     versions = (d.getVar("BBVERSIONS", True) or "").split()
@@ -419,8 +419,8 @@ def multi_finalize(fn, d):
             verfunc(pv, d, safe_d)
             try:
                 finalize(fn, d)
-            except bb.parse.SkipPackage:
-                bb.data.setVar("__SKIPPED", True, d)
+            except bb.parse.SkipPackage as e:
+                bb.data.setVar("__SKIPPED", e.args[0], d)
 
         _create_variants(datastores, versions, verfunc)
 
@@ -439,8 +439,8 @@ def multi_finalize(fn, d):
             try:
                 if not onlyfinalise or variant in onlyfinalise:
                     finalize(fn, variant_d, variant)
-            except bb.parse.SkipPackage:
-                bb.data.setVar("__SKIPPED", True, variant_d)
+            except bb.parse.SkipPackage as e:
+                bb.data.setVar("__SKIPPED", e.args[0], variant_d)
 
     if len(datastores) > 1:
         variants = filter(None, datastores.iterkeys())
-- 
1.7.4.1



