Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 08FA778225
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:50 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410425"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:08 +0200
Message-Id: <b4e9a9c57150a6e089ebe068f6ee2ea6f944de83.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 09/12] tinfoil: add simple API for getting cached recipe information
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:50 -0000

A common task for tinfoil-using scripts is to iterate over all recipes.
This isn't too difficult with the current API, but the pkg_* variables
are a little awkward and are really designed for bitbake's internal
usage - and it gets a bit more difficult when you want to access some of
the other information such as packages and rprovides. To resolve this,
create a new recipe info class and add an all_recipes() function to
generate this for all recipes. Also add a get_recipe_info() function to
get the information for a specific recipe (by PN).

(It might perhaps be suggested that we already have a structure similar
to this in the cache, however the one we add here is designed for
external use and allows the internal structures to change if needed
without affecting the API).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index feaeb56..7209cc9 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -217,6 +217,82 @@ class TinfoilCookerAdapter:
         return self.tinfoil.find_best_provider(pn)
 
 
+class TinfoilRecipeInfo:
+    """
+    Provides a convenient representation of the cached information for a single recipe.
+    Some attributes are set on construction, others are read on-demand (which internally
+    may result in a remote procedure call to the bitbake server the first time).
+    Note that only information which is cached is available through this object - if
+    you need other variable values you will need to parse the recipe using
+    Tinfoil.parse_recipe().
+    """
+    def __init__(self, recipecache, d, pn, fn, fns):
+        self._recipecache = recipecache
+        self._d = d
+        self.pn = pn
+        self.fn = fn
+        self.fns = fns
+        self.inherit_files = recipecache.inherits[fn]
+        self.depends = recipecache.deps[fn]
+        (self.pe, self.pv, self.pr) = recipecache.pkg_pepvpr[fn]
+        self._cached_packages = None
+        self._cached_rprovides = None
+        self._cached_packages_dynamic = None
+
+    def __getattr__(self, name):
+        if name == 'alternates':
+            return [x for x in self.fns if x != self.fn]
+        elif name == 'rdepends':
+            return self._recipecache.rundeps[self.fn]
+        elif name == 'rrecommends':
+            return self._recipecache.runrecs[self.fn]
+        elif name == 'provides':
+            return self._recipecache.fn_provides[self.fn]
+        elif name == 'packages':
+            if self._cached_packages is None:
+                self._cached_packages = []
+                for pkg, fns in self._recipecache.packages.items():
+                    if self.fn in fns:
+                        self._cached_packages.append(pkg)
+            return self._cached_packages
+        elif name == 'packages_dynamic':
+            if self._cached_packages_dynamic is None:
+                self._cached_packages_dynamic = []
+                for pkg, fns in self._recipecache.packages_dynamic.items():
+                    if self.fn in fns:
+                        self._cached_packages_dynamic.append(pkg)
+            return self._cached_packages_dynamic
+        elif name == 'rprovides':
+            if self._cached_rprovides is None:
+                self._cached_rprovides = []
+                for pkg, fns in self._recipecache.rproviders.items():
+                    if self.fn in fns:
+                        self._cached_rprovides.append(pkg)
+            return self._cached_rprovides
+        else:
+            raise AttributeError("%s instance has no attribute '%s'" % (self.__class__.__name__, name))
+    def inherits(self, only_recipe=False):
+        """
+        Get the inherited classes for a recipe. Returns the class names only.
+        Parameters:
+            only_recipe: True to return only the classes inherited by the recipe
+                         itself, False to return all classes inherited within
+                         the context for the recipe (which includes globally
+                         inherited classes).
+        """
+        if only_recipe:
+            global_inherit = [x for x in (self._d.getVar('BBINCLUDED') or '').split() if x.endswith('.bbclass')]
+        else:
+            global_inherit = []
+        for clsfile in self.inherit_files:
+            if only_recipe and clsfile in global_inherit:
+                continue
+            clsname = os.path.splitext(os.path.basename(clsfile))[0]
+            yield clsname
+    def __str__(self):
+        return '%s' % self.pn
+
+
 class Tinfoil:
 
     def __init__(self, output=sys.stdout, tracking=False, setup_logging=True):
@@ -401,6 +477,72 @@ class Tinfoil:
     def get_file_appends(self, fn):
         return self.run_command('getFileAppends', fn)
 
+    def all_recipes(self, mc='', sort=True):
+        """
+        Enable iterating over all recipes in the current configuration.
+        Returns an iterator over TinfoilRecipeInfo objects created on demand.
+        Parameters:
+            mc: The multiconfig, default of '' uses the main configuration.
+            sort: True to sort recipes alphabetically (default), False otherwise
+        """
+        recipecache = self.cooker.recipecaches[mc]
+        if sort:
+            recipes = sorted(recipecache.pkg_pn.items())
+        else:
+            recipes = recipecache.pkg_pn.items()
+        for pn, fns in recipes:
+            prov = self.find_best_provider(pn)
+            recipe = TinfoilRecipeInfo(recipecache,
+                                       self.config_data,
+                                       pn=pn,
+                                       fn=prov[3],
+                                       fns=fns)
+            yield recipe
+
+    def all_recipe_files(self, mc='', variants=True, preferred_only=False):
+        """
+        Enable iterating over all recipe files in the current configuration.
+        Returns an iterator over file paths.
+        Parameters:
+            mc: The multiconfig, default of '' uses the main configuration.
+            variants: True to include variants of recipes created through
+                      BBCLASSEXTEND (default) or False to exclude them
+            preferred_only: True to include only the preferred recipe where
+                      multiple exist providing the same PN, False to list
+                      all recipes
+        """
+        recipecache = self.cooker.recipecaches[mc]
+        if preferred_only:
+            files = []
+            for pn in recipecache.pkg_pn.keys():
+                prov = self.find_best_provider(pn)
+                files.append(prov[3])
+        else:
+            files = recipecache.pkg_fn.keys()
+        for fn in sorted(files):
+            if not variants and fn.startswith('virtual:'):
+                continue
+            yield fn
+
+
+    def get_recipe_info(self, pn, mc=''):
+        """
+        Get information on a specific recipe in the current configuration by name (PN).
+        Returns a TinfoilRecipeInfo object created on demand.
+        Parameters:
+            mc: The multiconfig, default of '' uses the main configuration.
+        """
+        recipecache = self.cooker.recipecaches[mc]
+        prov = self.find_best_provider(pn)
+        fn = prov[3]
+        actual_pn = recipecache.pkg_fn[fn]
+        recipe = TinfoilRecipeInfo(recipecache,
+                                    self.config_data,
+                                    pn=actual_pn,
+                                    fn=fn,
+                                    fns=recipecache.pkg_pn[actual_pn])
+        return recipe
+
     def parse_recipe(self, pn):
         """
         Parse the specified recipe and return a datastore object
-- 
2.9.4


