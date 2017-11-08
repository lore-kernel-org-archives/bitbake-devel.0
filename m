Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id EE31D78488
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Nov 2017 02:20:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 07 Nov 2017 18:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,361,1505804400"; d="scan'208";a="1241188823"
Received: from tkdhir-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.68.14])
	by fmsmga002.fm.intel.com with ESMTP; 07 Nov 2017 18:20:39 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Nov 2017 15:20:27 +1300
Message-Id: <51bdd2d5ba3a51269422b9bbdba6d0249f82e3dd.1510107572.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1510107572.git.paul.eggleton@linux.intel.com>
References: <cover.1510107572.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] tinfoil: ensure get_recipe_info() returns Null if recipe not found
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
X-List-Received-Date: Wed, 08 Nov 2017 02:20:56 -0000

If a matching recipe is not found then return Null instead of raising
KeyError because we were blindly using None as a key for pkg_fn.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index fb2ee4a..8bac394 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -604,13 +604,16 @@ class Tinfoil:
         recipecache = self.cooker.recipecaches[mc]
         prov = self.find_best_provider(pn)
         fn = prov[3]
-        actual_pn = recipecache.pkg_fn[fn]
-        recipe = TinfoilRecipeInfo(recipecache,
-                                    self.config_data,
-                                    pn=actual_pn,
-                                    fn=fn,
-                                    fns=recipecache.pkg_pn[actual_pn])
-        return recipe
+        if fn:
+            actual_pn = recipecache.pkg_fn[fn]
+            recipe = TinfoilRecipeInfo(recipecache,
+                                        self.config_data,
+                                        pn=actual_pn,
+                                        fn=fn,
+                                        fns=recipecache.pkg_pn[actual_pn])
+            return recipe
+        else:
+            return None
 
     def parse_recipe(self, pn):
         """
-- 
2.9.5


