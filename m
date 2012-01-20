Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1RoCig-0003uH-Ib
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 12:33:23 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 20 Jan 2012 03:25:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="100788098"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.2])
	by orsmga002.jf.intel.com with ESMTP; 20 Jan 2012 03:25:40 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Jan 2012 19:39:03 +0800
Message-Id: <8895391158c0009ef8c76ae667df7c6bf5312661.1327059385.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1327059385.git.shane.wang@intel.com>
References: <cover.1327059385.git.shane.wang@intel.com>
In-Reply-To: <cover.1327059385.git.shane.wang@intel.com>
References: <cover.1327059385.git.shane.wang@intel.com>
Subject: [PATCH 1/1] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Fri, 20 Jan 2012 11:33:23 -0000

enable bitbake to cache description into the extra cache file and Hob2 will get its value for core-image-foo.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/cache_extra.py |   13 +++----------
 bitbake/lib/bb/cooker.py      |    2 ++
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 4c8841f..723b97f 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -36,19 +36,12 @@ class HobRecipeInfo(RecipeInfoCommon):
     cachefile = "bb_extracache_" + classname +".dat"        
 
     def __init__(self, filename, metadata):
-
-        self.summary = self.getvar('SUMMARY', metadata)
-        self.license = self.getvar('LICENSE', metadata)
-        self.section = self.getvar('SECTION', metadata)
+        self.description = self.getvar('DESCRIPTION', metadata)
 
     @classmethod
     def init_cacheData(cls, cachedata):
         # CacheData in Hob RecipeInfo Class
-        cachedata.summary = {}
-        cachedata.license = {}
-        cachedata.section = {}
+        cachedata.description = {}
 
     def add_cacheData(self, cachedata, fn):
-        cachedata.summary[fn] = self.summary
-        cachedata.license[fn] = self.license
-        cachedata.section[fn] = self.section
+        cachedata.description[fn] = self.description
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4197a02..cc5d190 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -466,6 +466,7 @@ class BBCooker:
             summary = self.status.summary[fn]
             lic = self.status.license[fn]
             section = self.status.section[fn]
+            description = self.status.description[fn]
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
@@ -473,6 +474,7 @@ class BBCooker:
                 depend_tree["pn"][pn]["summary"] = summary
                 depend_tree["pn"][pn]["license"] = lic
                 depend_tree["pn"][pn]["section"] = section
+                depend_tree["pn"][pn]["description"] = description
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
-- 
1.7.6



