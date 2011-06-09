Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QUiOh-0005Bu-By
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 18:47:55 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Jun 2011 09:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,342,1304319600"; d="scan'208";a="11418002"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.6])
	by orsmga002.jf.intel.com with ESMTP; 09 Jun 2011 09:44:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2011 17:42:37 +0100
Message-Id: <6c12b7b1099c77b87d4431d55e949cf7c5f52ded.1307636663.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1307636663.git.paul.eggleton@linux.intel.com>
References: <cover.1307636663.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1307636663.git.paul.eggleton@linux.intel.com>
References: <cover.1307636663.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: track skipped packages
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
X-List-Received-Date: Thu, 09 Jun 2011 16:47:55 -0000

Add skiplist to cooker that allows access to the list of packages skipped
via SkipPackage (this includes COMPATIBLE_MACHINE, INCOMPATIBLE_LICENSE,
etc.) This can be used to enhance error reporting.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cache.py     |    9 ++++++---
 bitbake/lib/bb/cooker.py    |   16 ++++++++++++++++
 bitbake/lib/bb/parse/ast.py |   12 ++++++------
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 5b8e3ee..a0df93e 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "139"
+__cache_version__ = "140"
 
 def getCacheFile(path, filename):
     return os.path.join(path, filename)
@@ -96,8 +96,11 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.variants = self.listvar('__VARIANTS', metadata) + ['']
         self.nocache = self.getvar('__BB_DONT_CACHE', metadata)
 
-        if self.getvar('__SKIPPED', metadata):
+        self.skipreason = self.getvar('__SKIPPED', metadata)
+        if self.skipreason:
             self.skipped = True
+            self.provides  = self.depvar('PROVIDES', metadata)
+            self.rprovides = self.depvar('RPROVIDES', metadata)
             return
 
         self.tasks = metadata.getVar('__BBTASKS', False)
@@ -446,7 +449,7 @@ class Cache(object):
         cached, infos = self.load(fn, appends, cfgData)
         for virtualfn, info_array in infos:
             if info_array[0].skipped:
-                logger.debug(1, "Skipping %s", virtualfn)
+                logger.debug(1, "Skipping %s: %s", virtualfn, info_array[0].skipreason)
                 skipped += 1
             else:
                 self.add_info(virtualfn, info_array, cacheData, not cached)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5bdf90f..a64ee52 100644
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
     def __init__(self, configuration, server_registration_cb):
         self.status = None
         self.appendlist = {}
+        self.skiplist = {}
 
         self.server_registration_cb = server_registration_cb
 
@@ -1261,6 +1276,7 @@ class CookerParser(object):
         for virtualfn, info_array in result:
             if info_array[0].skipped:
                 self.skipped += 1
+                self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
             self.bb_cache.add_info(virtualfn, info_array, self.cooker.status,
                                         parsed=parsed)
         return True
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index b296562..722d542 100644
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



