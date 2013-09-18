Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id E47156BDAF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:16:22 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="397540765"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 18 Sep 2013 05:15:55 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A2F9E56088B; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:50 +0100
Message-Id: <e8d7eac3b5ef37e5cb016d85e86930fb47ea3b62.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
	<89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/7] bitbake: cooker: get extra information from recipe cache
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
X-List-Received-Date: Wed, 18 Sep 2013 12:16:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The loaded cache modules may add extra attributes to
the recipecache, that will be populated by the cache
classes required by the UI. These attributes
will be used by the UI to display relevant information.

Adds cachefields cache class field to specify
for each cache class which attributes will be set
in the recipecache.

Adds code to automatically expand depends tree with the
fields exported by the extra cache class.

Fixes a cache field name in the HOB UI.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/cache_extra.py            |  6 ++++
 bitbake/lib/bb/cooker.py                 | 50 ++++++++++++++++++--------------
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |  2 +-
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/cache_extra.py b/bitbake/lib/bb/cache_extra.py
index 9e38a43..83f4959 100644
--- a/bitbake/lib/bb/cache_extra.py
+++ b/bitbake/lib/bb/cache_extra.py
@@ -35,6 +35,12 @@ class HobRecipeInfo(RecipeInfoCommon):
     # such as (bb_cache.dat, bb_extracache_hob.dat) 
     cachefile = "bb_extracache_" + classname +".dat"        
 
+    # override this member with the list of extra cache fields
+    # that this class will provide
+    cachefields = ['summary', 'license', 'section',
+            'description', 'homepage', 'bugtracker',
+            'prevision', 'files_info']
+
     def __init__(self, filename, metadata):
 
         self.summary = self.getvar('SUMMARY', metadata)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index dd45ae8..fafa518 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -481,6 +481,19 @@ class BBCooker:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
                 depend_tree["pn"][pn]["version"] = version
+
+                # if we have extra caches, list all attributes they bring in
+                extra_info = []
+                for cache_class in self.caches_array:
+                    if type(cache_class) is type and issubclass(cache_class, bb.cache.RecipeInfoCommon) and hasattr(cache_class, 'cachefields'):
+                        cachefields = getattr(cache_class, 'cachefields', [])
+                        extra_info = extra_info + cachefields
+
+                # for all attributes stored, add them to the dependency tree
+                for ei in extra_info:
+                    depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
+
+
             for dep in rq.rqdata.runq_depends[task]:
                 depfn = taskdata.fn_index[rq.rqdata.runq_fnid[dep]]
                 deppn = self.recipecache.pkg_fn[depfn]
@@ -543,35 +556,30 @@ class BBCooker:
         depend_tree["rdepends-pkg"] = {}
         depend_tree["rrecs-pkg"] = {}
 
+        # if we have extra caches, list all attributes they bring in
+        extra_info = []
+        for cache_class in self.caches_array:
+            if type(cache_class) is type and issubclass(cache_class, bb.cache.RecipeInfoCommon) and hasattr(cache_class, 'cachefields'):
+                cachefields = getattr(cache_class, 'cachefields', [])
+                extra_info = extra_info + cachefields
+
         for task in xrange(len(tasks_fnid)):
             fnid = tasks_fnid[task]
             fn = taskdata.fn_index[fnid]
             pn = self.recipecache.pkg_fn[fn]
-            version  = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
-            summary = self.recipecache.summary[fn]
-            lic = self.recipecache.license[fn]
-            section = self.recipecache.section[fn]
-            description = self.recipecache.description[fn]
-            homepage = self.recipecache.homepage[fn]
-            bugtracker = self.recipecache.bugtracker[fn]
-            files_info = self.recipecache.files_info[fn]
-            rdepends = self.recipecache.rundeps[fn]
-            rrecs = self.recipecache.runrecs[fn]
-            prevision = self.recipecache.prevision[fn]
-            inherits = self.recipecache.inherits.get(fn, None)
+
             if pn not in depend_tree["pn"]:
                 depend_tree["pn"][pn] = {}
                 depend_tree["pn"][pn]["filename"] = fn
+                version  = "%s:%s-%s" % self.recipecache.pkg_pepvpr[fn]
                 depend_tree["pn"][pn]["version"] = version
-                depend_tree["pn"][pn]["summary"] = summary
-                depend_tree["pn"][pn]["license"] = lic
-                depend_tree["pn"][pn]["section"] = section
-                depend_tree["pn"][pn]["description"] = description
-                depend_tree["pn"][pn]["inherits"] = inherits
-                depend_tree["pn"][pn]["homepage"] = homepage
-                depend_tree["pn"][pn]["bugtracker"] = bugtracker
-                depend_tree["pn"][pn]["files_info"] = files_info
-                depend_tree["pn"][pn]["revision"] = prevision
+                rdepends = self.recipecache.rundeps[fn]
+                rrecs = self.recipecache.runrecs[fn]
+                depend_tree["pn"][pn]["inherits"] = self.recipecache.inherits.get(fn, None)
+
+                # for all extra attributes stored, add them to the dependency tree
+                for ei in extra_info:
+                    depend_tree["pn"][pn][ei] = vars(self.recipecache)[ei][fn]
 
             if fnid not in seen_fnids:
                 seen_fnids.append(fnid)
diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index 74d335c..b4d2a62 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -690,7 +690,7 @@ class RecipeListModel(gtk.ListStore):
             inherits = event_model["pn"][item]["inherits"]
             summary = event_model["pn"][item]["summary"]
             version = event_model["pn"][item]["version"]
-            revision = event_model["pn"][item]["revision"]
+            revision = event_model["pn"][item]["prevision"]
             homepage = event_model["pn"][item]["homepage"]
             bugtracker = event_model["pn"][item]["bugtracker"]
             filename = event_model["pn"][item]["filename"]
-- 
1.8.1.2


