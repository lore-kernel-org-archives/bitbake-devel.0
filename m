Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Rspeh-0002rV-5N
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Feb 2012 06:56:23 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Feb 2012 21:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="102974712"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.2])
	by orsmga001.jf.intel.com with ESMTP; 01 Feb 2012 21:48:16 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Feb 2012 14:05:27 +0800
Message-Id: <213886d7dc877c93686c896fe4584011bb4ce2ec.1328162622.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1328162622.git.shane.wang@intel.com>
References: <cover.1328162622.git.shane.wang@intel.com>
In-Reply-To: <cover.1328162622.git.shane.wang@intel.com>
References: <cover.1328162622.git.shane.wang@intel.com>
Subject: [PATCH 1/1] [V2] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Thu, 02 Feb 2012 05:56:23 -0000

Enable bitbake to cache description into the extra cache file and Hob2 will get its value for core-image-foo.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/cache.py       |    9 ---------
 bitbake/lib/bb/cache_extra.py |    3 +++
 bitbake/lib/bb/cooker.py      |    2 ++
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 6b7fa6f..99e0f34 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -137,9 +137,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.rdepends_pkg     = self.pkgvar('RDEPENDS', self.packages, metadata)
         self.rrecommends_pkg  = self.pkgvar('RRECOMMENDS', self.packages, metadata)
         self.inherits         = self.getvar('__inherit_cache', metadata)
-        self.summary          = self.getvar('SUMMARY', metadata)
-        self.license          = self.getvar('LICENSE', metadata)
-        self.section          = self.getvar('SECTION', metadata)
         self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
         self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
@@ -174,9 +171,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         cachedata.basetaskhash = {}
         cachedata.inherits = {}
-        cachedata.summary = {}
-        cachedata.license = {}
-        cachedata.section = {}
         cachedata.fakerootenv = {}
         cachedata.fakerootnoenv = {}
         cachedata.fakerootdirs = {}
@@ -240,9 +234,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
             cachedata.basetaskhash[identifier] = taskhash
 
         cachedata.inherits[fn] = self.inherits
-        cachedata.summary[fn] = self.summary
-        cachedata.license[fn] = self.license
-        cachedata.section[fn] = self.section
         cachedata.fakerootenv[fn] = self.fakerootenv
         cachedata.fakerootnoenv[fn] = self.fakerootnoenv
         cachedata.fakerootdirs[fn] = self.fakerootdirs
diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 4c8841f..40ba304 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -40,6 +40,7 @@ class HobRecipeInfo(RecipeInfoCommon):
         self.summary = self.getvar('SUMMARY', metadata)
         self.license = self.getvar('LICENSE', metadata)
         self.section = self.getvar('SECTION', metadata)
+        self.description = self.getvar('DESCRIPTION', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
@@ -47,8 +48,10 @@ class HobRecipeInfo(RecipeInfoCommon):
         cachedata.summary = {}
         cachedata.license = {}
         cachedata.section = {}
+        cachedata.description = {}
 
     def add_cacheData(self, cachedata, fn):
         cachedata.summary[fn] = self.summary
         cachedata.license[fn] = self.license
         cachedata.section[fn] = self.section
+        cachedata.description[fn] = self.description
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7dab38e..492cf6e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -455,6 +455,7 @@ class BBCooker:
             summary = self.status.summary[fn]
             lic = self.status.license[fn]
             section = self.status.section[fn]
+            description = self.status.description[fn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
@@ -462,6 +463,7 @@ class BBCooker:
                 depend_tree["pn"][pn]["summary"] = summary
                 depend_tree["pn"][pn]["license"] = lic
                 depend_tree["pn"][pn]["section"] = section
+                depend_tree["pn"][pn]["description"] = description
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
-- 
1.7.6



