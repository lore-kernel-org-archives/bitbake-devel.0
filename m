Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QSJ62-0000qF-KR
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 Jun 2011 03:22:43 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Jun 2011 18:18:25 -0700
X-ExtLoop1: 1
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.48])
	by orsmga002.jf.intel.com with ESMTP; 02 Jun 2011 18:18:24 -0700
From: Ke Liping <liping.ke@intel.com>
To: poky@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jun 2011 09:06:01 +0800
Message-Id: <9599544ad3b2ff33007f09d9ce4aeb75151fcd71.1307062861.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
In-Reply-To: <cover.1307062861.git.liping.ke@intel.com>
References: <cover.1307062861.git.liping.ke@intel.com>
Subject: [PATCH 1/4][Image Creator]Refactory Current Cache implementation
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
X-List-Received-Date: Fri, 03 Jun 2011 01:22:43 -0000

From: Liping Ke <liping.ke@intel.com>

This patch is for refactorying current cache implementation, the
main reason is for introducing extra cache fields requests for
image creator as well as other users. The refactory parts include:
Move cache data retrieve methods out of Cache Data Fields
Definition. Since this retrieve methods will be shared for
both CoreRecipeInfo as well as the new introduced extra RecipeInfo
in the following patches.

Signed-off-by: Liping Ke <liping.ke@intel.com>
---
 bitbake/lib/bb/cache.py |  358 ++++++++++++++++++++++-------------------------
 1 files changed, 165 insertions(+), 193 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index d083c51..09691d9 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -30,7 +30,7 @@
 
 import os
 import logging
-from collections import defaultdict, namedtuple
+from collections import defaultdict
 import bb.data
 import bb.utils
 
@@ -45,46 +45,11 @@ except ImportError:
 
 __cache_version__ = "138"
 
-recipe_fields = (
-    'pn',
-    'pv',
-    'pr',
-    'pe',
-    'defaultpref',
-    'depends',
-    'provides',
-    'task_deps',
-    'stamp',
-    'stamp_extrainfo',
-    'broken',
-    'not_world',
-    'skipped',
-    'timestamp',
-    'packages',
-    'packages_dynamic',
-    'rdepends',
-    'rdepends_pkg',
-    'rprovides',
-    'rprovides_pkg',
-    'rrecommends',
-    'rrecommends_pkg',
-    'nocache',
-    'variants',
-    'file_depends',
-    'tasks',
-    'basetaskhashes',
-    'hashfilename',
-    'inherits',
-    'summary',
-    'license',
-    'section',
-    'fakerootenv',
-    'fakerootdirs'
-)
-
-
-class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
-    __slots__ = ()
+
+# RecipeInfoCommon defines common data retrieving methods
+# from meta data for caches. CoreRecipeInfo as well as other
+# Extra RecipeInfo needs to inherit this class
+class RecipeInfoCommon(object):
 
     @classmethod
     def listvar(cls, var, metadata):
@@ -117,69 +82,162 @@ class RecipeInfo(namedtuple('RecipeInfo', recipe_fields)):
     def getvar(cls, var, metadata):
         return metadata.getVar(var, True) or ''
 
-    @classmethod
-    def make_optional(cls, default=None, **kwargs):
-        """Construct the namedtuple from the specified keyword arguments,
-        with every value considered optional, using the default value if
-        it was not specified."""
-        for field in cls._fields:
-            kwargs[field] = kwargs.get(field, default)
-        return cls(**kwargs)
+
+class CoreRecipeInfo(RecipeInfoCommon):
+    __slots__ = ()
+
+    def __init__(self, filename, metadata):
+        self.name = "base"
+        # please override this member with the correct data cache file
+        # such as (bb_cache.dat, bb_extracache_hob.dat) 
+        self.cachefile = "bb_cache.dat"        
+
+        self.file_depends = metadata.getVar('__depends', False)
+        self.timestamp = bb.parse.cached_mtime(filename)
+        self.variants = self.listvar('__VARIANTS', metadata) + ['']
+        self.nocache = self.getvar('__BB_DONT_CACHE', metadata)
+
+        if self.getvar('__SKIPPED', metadata):
+            self.skipped = True
+            return
+
+        self.tasks = metadata.getVar('__BBTASKS', False)
+
+        self.pn = self.getvar('PN', metadata)
+        self.packages = self.listvar('PACKAGES', metadata)
+        if not self.pn in self.packages:
+            self.packages.append(self.pn)
+
+        self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
+        self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
+
+        self.file_depends = metadata.getVar('__depends', False)
+        self.task_deps = metadata.getVar('_task_deps', False) or {'tasks': [], 'parents': {}}
+
+        self.skipped = False
+        self.pe = self.getvar('PE', metadata)
+        self.pv = self.getvar('PV', metadata)
+        self.pr = self.getvar('PR', metadata)
+        self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
+        self.broken = self.getvar('BROKEN', metadata)
+        self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
+        self.stamp = self.getvar('STAMP', metadata)
+        self.stamp_extrainfo = self.flaglist('stamp-extra-info', self.tasks, metadata)
+        self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
+        self.depends          = self.depvar('DEPENDS', metadata)
+        self.provides         = self.depvar('PROVIDES', metadata)
+        self.rdepends         = self.depvar('RDEPENDS', metadata)
+        self.rprovides        = self.depvar('RPROVIDES', metadata)
+        self.rrecommends      = self.depvar('RRECOMMENDS', metadata)
+        self.rprovides_pkg    = self.pkgvar('RPROVIDES', self.packages, metadata)
+        self.rdepends_pkg     = self.pkgvar('RDEPENDS', self.packages, metadata)
+        self.rrecommends_pkg  = self.pkgvar('RRECOMMENDS', self.packages, metadata)
+        self.inherits         = self.getvar('__inherit_cache', metadata)
+        self.summary          = self.getvar('SUMMARY', metadata)
+        self.license          = self.getvar('LICENSE', metadata)
+        self.section          = self.getvar('SECTION', metadata)
+        self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
+        self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
 
     @classmethod
-    def from_metadata(cls, filename, metadata):
-        if cls.getvar('__SKIPPED', metadata):
-            return cls.make_optional(skipped=True,
-                                     file_depends=metadata.getVar('__depends', False),
-                                     timestamp=bb.parse.cached_mtime(filename),
-                                     variants=cls.listvar('__VARIANTS', metadata) + [''])
-
-        tasks = metadata.getVar('__BBTASKS', False)
-
-        pn = cls.getvar('PN', metadata)
-        packages = cls.listvar('PACKAGES', metadata)
-        if not pn in packages:
-            packages.append(pn)
-
-        return RecipeInfo(
-            tasks            = tasks,
-            basetaskhashes   = cls.taskvar('BB_BASEHASH', tasks, metadata),
-            hashfilename     = cls.getvar('BB_HASHFILENAME', metadata),
-
-            file_depends     = metadata.getVar('__depends', False),
-            task_deps        = metadata.getVar('_task_deps', False) or
-                               {'tasks': [], 'parents': {}},
-            variants         = cls.listvar('__VARIANTS', metadata) + [''],
-
-            skipped          = False,
-            timestamp        = bb.parse.cached_mtime(filename),
-            packages         = cls.listvar('PACKAGES', metadata),
-            pn               = pn,
-            pe               = cls.getvar('PE', metadata),
-            pv               = cls.getvar('PV', metadata),
-            pr               = cls.getvar('PR', metadata),
-            nocache          = cls.getvar('__BB_DONT_CACHE', metadata),
-            defaultpref      = cls.intvar('DEFAULT_PREFERENCE', metadata),
-            broken           = cls.getvar('BROKEN', metadata),
-            not_world        = cls.getvar('EXCLUDE_FROM_WORLD', metadata),
-            stamp            = cls.getvar('STAMP', metadata),
-            stamp_extrainfo  = cls.flaglist('stamp-extra-info', tasks, metadata),
-            packages_dynamic = cls.listvar('PACKAGES_DYNAMIC', metadata),
-            depends          = cls.depvar('DEPENDS', metadata),
-            provides         = cls.depvar('PROVIDES', metadata),
-            rdepends         = cls.depvar('RDEPENDS', metadata),
-            rprovides        = cls.depvar('RPROVIDES', metadata),
-            rrecommends      = cls.depvar('RRECOMMENDS', metadata),
-            rprovides_pkg    = cls.pkgvar('RPROVIDES', packages, metadata),
-            rdepends_pkg     = cls.pkgvar('RDEPENDS', packages, metadata),
-            rrecommends_pkg  = cls.pkgvar('RRECOMMENDS', packages, metadata),
-            inherits         = cls.getvar('__inherit_cache', metadata),
-            summary          = cls.getvar('SUMMARY', metadata),
-            license          = cls.getvar('LICENSE', metadata),
-            section          = cls.getvar('SECTION', metadata),
-            fakerootenv      = cls.getvar('FAKEROOTENV', metadata),
-            fakerootdirs     = cls.getvar('FAKEROOTDIRS', metadata),
-        )
+    def init_cacheData(cls, cachedata):
+        # CacheData in Core RecipeInfo Class
+        cachedata.task_deps = {}
+        cachedata.pkg_fn = {}
+        cachedata.pkg_pn = defaultdict(list)
+        cachedata.pkg_pepvpr = {}
+        cachedata.pkg_dp = {}
+
+        cachedata.stamp = {}
+        cachedata.stamp_extrainfo = {}
+        cachedata.fn_provides = {}
+        cachedata.pn_provides = defaultdict(list)
+        cachedata.all_depends = []
+
+        cachedata.deps = defaultdict(list)
+        cachedata.packages = defaultdict(list)
+        cachedata.providers = defaultdict(list)
+        cachedata.rproviders = defaultdict(list)
+        cachedata.packages_dynamic = defaultdict(list)
+
+        cachedata.rundeps = defaultdict(lambda: defaultdict(list))
+        cachedata.runrecs = defaultdict(lambda: defaultdict(list))
+        cachedata.possible_world = []
+        cachedata.universe_target = []
+        cachedata.hashfn = {}
+
+        cachedata.basetaskhash = {}
+        cachedata.inherits = {}
+        cachedata.summary = {}
+        cachedata.license = {}
+        cachedata.section = {}
+        cachedata.fakerootenv = {}
+        cachedata.fakerootdirs = {}
+
+    def add_cacheData(self, cachedata, fn):
+        cachedata.task_deps[fn] = self.task_deps
+        cachedata.pkg_fn[fn] = self.pn
+        cachedata.pkg_pn[self].append(fn)
+        cachedata.pkg_pepvpr[fn] = (self.pe, self.pv, self.pr)
+        cachedata.pkg_dp[fn] = self.defaultpref
+        cachedata.stamp[fn] = self.stamp
+        cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
+
+        provides = [self.pn]
+        for provide in self.provides:
+            if provide not in provides:
+                provides.append(provide)
+        cachedata.fn_provides[fn] = provides
+
+        for provide in provides:
+            cachedata.providers[provide].append(fn)
+            if provide not in cachedata.pn_provides[self.pn]:
+                cachedata.pn_provides[self.pn].append(provide)
+
+        for dep in self.depends:
+            if dep not in cachedata.deps[fn]:
+                cachedata.deps[fn].append(dep)
+            if dep not in cachedata.all_depends:
+                cachedata.all_depends.append(dep)
+
+        rprovides = self.rprovides
+        for package in self.packages:
+            cachedata.packages[package].append(fn)
+            rprovides += self.rprovides_pkg[package]
+
+        for rprovide in rprovides:
+            cachedata.rproviders[rprovide].append(fn)
+
+        for package in self.packages_dynamic:
+            cachedata.packages_dynamic[package].append(fn)
+
+        # Build hash of runtime depends and rececommends
+        for package in self.packages + [self.pn]:
+            cachedata.rundeps[fn][package] = list(self.rdepends) + self.rdepends_pkg[package]
+            cachedata.runrecs[fn][package] = list(self.rrecommends) + self.rrecommends_pkg[package]
+
+        # Collect files we may need for possible world-dep
+        # calculations
+        if not self.broken and not self.not_world:
+            cachedata.possible_world.append(fn)
+
+        # create a collection of all targets for sanity checking
+        # tasks, such as upstream versions, license, and tools for
+        # task and image creation.
+        cachedata.universe_target.append(self.pn)
+
+        cachedata.hashfn[fn] = self.hashfilename
+        for task, taskhash in self.basetaskhashes.iteritems():
+            identifier = '%s.%s' % (fn, task)
+            cachedata.basetaskhash[identifier] = taskhash
+
+        cachedata.inherits[fn] = self.inherits
+        cachedata.summary[fn] = self.summary
+        cachedata.license[fn] = self.license
+        cachedata.section[fn] = self.section
+        cachedata.fakerootenv[fn] = self.fakerootenv
+        cachedata.fakerootdirs[fn] = self.fakerootdirs
+
 
 
 class Cache(object):
@@ -314,7 +372,7 @@ class Cache(object):
             depends |= (data.getVar("__depends", False) or set())
             if depends and not variant:
                 data.setVar("__depends", depends)
-            info = RecipeInfo.from_metadata(filename, data)
+            info = CoreRecipeInfo(filename, data)
             infos.append((virtualfn, info))
         return infos
 
@@ -500,7 +558,7 @@ class Cache(object):
         """
 
         realfn = self.virtualfn2realfn(file_name)[0]
-        info = RecipeInfo.from_metadata(realfn, data)
+        info = CoreRecipeInfo(realfn, data)
         self.add_info(file_name, info, cacheData, parsed)
 
     @staticmethod
@@ -566,38 +624,11 @@ class CacheData(object):
     """
 
     def __init__(self):
+        CoreRecipeInfo.init_cacheData(self)        
         # Direct cache variables
-        self.providers = defaultdict(list)
-        self.rproviders = defaultdict(list)
-        self.packages = defaultdict(list)
-        self.packages_dynamic = defaultdict(list)
-        self.possible_world = []
-        self.universe_target = []
-        self.pkg_pn = defaultdict(list)
-        self.pkg_fn = {}
-        self.pkg_pepvpr = {}
-        self.pkg_dp = {}
-        self.pn_provides = defaultdict(list)
-        self.fn_provides = {}
-        self.all_depends = []
-        self.deps = defaultdict(list)
-        self.rundeps = defaultdict(lambda: defaultdict(list))
-        self.runrecs = defaultdict(lambda: defaultdict(list))
         self.task_queues = {}
-        self.task_deps = {}
-        self.stamp = {}
-        self.stamp_extrainfo = {}
         self.preferred = {}
         self.tasks = {}
-        self.basetaskhash = {}
-        self.hashfn = {}
-        self.inherits = {}
-        self.summary = {}
-        self.license = {}
-        self.section = {}
-        self.fakerootenv = {}
-        self.fakerootdirs = {}
-
         # Indirect Cache variables (set elsewhere)
         self.ignored_dependencies = []
         self.world_target = set()
@@ -605,65 +636,6 @@ class CacheData(object):
         self.bbfile_config_priorities = []
 
     def add_from_recipeinfo(self, fn, info):
-        self.task_deps[fn] = info.task_deps
-        self.pkg_fn[fn] = info.pn
-        self.pkg_pn[info.pn].append(fn)
-        self.pkg_pepvpr[fn] = (info.pe, info.pv, info.pr)
-        self.pkg_dp[fn] = info.defaultpref
-        self.stamp[fn] = info.stamp
-        self.stamp_extrainfo[fn] = info.stamp_extrainfo
-
-        provides = [info.pn]
-        for provide in info.provides:
-            if provide not in provides:
-                provides.append(provide)
-        self.fn_provides[fn] = provides
-
-        for provide in provides:
-            self.providers[provide].append(fn)
-            if provide not in self.pn_provides[info.pn]:
-                self.pn_provides[info.pn].append(provide)
-
-        for dep in info.depends:
-            if dep not in self.deps[fn]:
-                self.deps[fn].append(dep)
-            if dep not in self.all_depends:
-                self.all_depends.append(dep)
-
-        rprovides = info.rprovides
-        for package in info.packages:
-            self.packages[package].append(fn)
-            rprovides += info.rprovides_pkg[package]
+        info.add_cacheData(self, fn)
 
-        for rprovide in rprovides:
-            self.rproviders[rprovide].append(fn)
-
-        for package in info.packages_dynamic:
-            self.packages_dynamic[package].append(fn)
-
-        # Build hash of runtime depends and rececommends
-        for package in info.packages + [info.pn]:
-            self.rundeps[fn][package] = list(info.rdepends) + info.rdepends_pkg[package]
-            self.runrecs[fn][package] = list(info.rrecommends) + info.rrecommends_pkg[package]
-
-        # Collect files we may need for possible world-dep
-        # calculations
-        if not info.broken and not info.not_world:
-            self.possible_world.append(fn)
-
-        # create a collection of all targets for sanity checking
-        # tasks, such as upstream versions, license, and tools for
-        # task and image creation.
-        self.universe_target.append(info.pn)
-
-        self.hashfn[fn] = info.hashfilename
-        for task, taskhash in info.basetaskhashes.iteritems():
-            identifier = '%s.%s' % (fn, task)
-            self.basetaskhash[identifier] = taskhash
-
-        self.inherits[fn] = info.inherits
-        self.summary[fn] = info.summary
-        self.license[fn] = info.license
-        self.section[fn] = info.section
-        self.fakerootenv[fn] = info.fakerootenv
-        self.fakerootdirs[fn] = info.fakerootdirs
+        
-- 
1.7.0.4



