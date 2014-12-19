Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9F07972909
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 10:20:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 19 Dec 2014 02:20:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,606,1413270000"; d="scan'208";a="640218087"
Received: from khamid-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.31.61])
	by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2014 02:20:52 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 10:20:32 +0000
Message-Id: <a7b33001c50e9fed2059de049e6511f5c7baa331.1418984377.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] cooker: add ability to ignore unmatched regexes in BBFILE_PATTERN
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
X-List-Received-Date: Fri, 19 Dec 2014 10:20:53 -0000

Add a BBFILE_PATTERN_IGNORE_EMPTY variable to allow ignoring the fact
that a regex specified in BBFILE_PATTERN for a particular collection
doesn't match any recipes. This will be used in OpenEmbedded in the
workspace layers created by "devtool" which may not always contain any
recipes (which is not cause for warning the user).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 16fd4ad..0d9b85e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1385,7 +1385,7 @@ class BBCooker:
                 raise bb.BBHandledException()
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
-            self.recipecache.bbfile_priority = self.collection.collection_priorities(self.recipecache.pkg_fn)
+            self.recipecache.bbfile_priority = self.collection.collection_priorities(self.recipecache.pkg_fn, self.data)
             self.state = state.running
             return None
 
@@ -1610,7 +1610,7 @@ class CookerCollectFiles(object):
                     filelist.append(filename)
         return filelist
 
-    def collection_priorities(self, pkgfns):
+    def collection_priorities(self, pkgfns, d):
 
         priorities = {}
 
@@ -1639,7 +1639,8 @@ class CookerCollectFiles(object):
 
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
             if regex in unmatched:
-                collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
+                if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection, True) != '1':
+                    collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
         return priorities
 
-- 
1.9.3


