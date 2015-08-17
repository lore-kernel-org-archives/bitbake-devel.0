Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5D212606E8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:42 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564801"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:23 +0100
Message-Id: <d9d7a2e847af44de8f672b2beb62109eef74a3a2.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 08/13] cooker: drop appliedappendlist
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:42 -0000

Whilst collecting this list on the fly may be quicker, doing so within a
function that's meant to *query* the list of bbappends is poor practice.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a2b0bb5..5452deb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -919,15 +919,25 @@ class BBCooker:
         print("}", file=tdepends_file)
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
-    def show_appends_with_no_recipes( self ):
-        appends_without_recipes = [self.collection.appendlist[recipe]
-                                   for recipe in self.collection.appendlist
-                                   if recipe not in self.collection.appliedappendlist]
+    def show_appends_with_no_recipes(self):
+        # Determine which bbappends haven't been applied
+
+        # First get list of recipes, including skipped
+        recipefns = self.recipecache.pkg_fn.keys()
+        recipefns.extend(self.skiplist.keys())
+
+        # Work out list of bbappends that have been applied
+        applied_appends = []
+        for fn in recipefns:
+            applied_appends.extend(self.collection.get_file_appends(fn))
+
+        appends_without_recipes = []
+        for _, appendfn in self.collection.bbappends:
+            if not appendfn in applied_appends:
+                appends_without_recipes.append(appendfn)
+
         if appends_without_recipes:
-            appendlines = ('  %s' % append
-                           for appends in appends_without_recipes
-                           for append in appends)
-            msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
+            msg = 'No recipes available for:\n  %s' % '\n  '.join(appends_without_recipes)
             warn_only = self.data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
                  False) or "no"
             if warn_only.lower() in ("1", "yes", "true"):
@@ -1646,7 +1656,6 @@ class CookerCollectFiles(object):
     def __init__(self, priorities):
         self.appendlist = {}
         self.bbappends = []
-        self.appliedappendlist = []
         self.bbfile_config_priorities = priorities
 
     def calc_bbfile_priority( self, filename, matched = None ):
@@ -1769,7 +1778,6 @@ class CookerCollectFiles(object):
         for b in self.bbappends:
             (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
-                self.appliedappendlist.append(bbappend)
                 filelist.append(filename)
         return filelist
 
-- 
2.1.0


