Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 83AC16FF7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 04:37:13 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 29 Aug 2016 21:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,254,1470726000"; d="scan'208";a="872441207"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.182.37])
	by orsmga003.jf.intel.com with ESMTP; 29 Aug 2016 21:37:13 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 16:36:38 +1200
Message-Id: <84157c8e45d40788c11c3ef5955825e3b5b20112.1472531645.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472531645.git.paul.eggleton@linux.intel.com>
References: <cover.1472531645.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472531645.git.paul.eggleton@linux.intel.com>
References: <cover.1472531645.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] tinfoil: add a parse_recipe_file function
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
X-List-Received-Date: Tue, 30 Aug 2016 04:37:13 -0000

Parsing a recipe is such a common task for tinfoil-using scripts, and is
a little awkward to do properly, so we should add an API function to do
it. This should also isolate scripts a little from future changes to the
internal code.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 441be2c..793565f 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -90,6 +90,27 @@ class Tinfoil:
             else:
                 self.parseRecipes()
 
+    def parse_recipe_file(self, fn, appends=True, appendlist=None):
+        """
+        Parse the specified recipe file (with or without bbappends)
+        and return a datastore object representing the environment
+        for the recipe.
+        """
+        if appends and appendlist == []:
+            appends = False
+        parser = bb.cache.NoCache(self.cooker.databuilder)
+        if appends:
+            if appendlist:
+                appendfiles = appendlist
+            else:
+                if not hasattr(self.cooker, 'collection'):
+                    raise Exception('You must call tinfoil.prepare() with config_only=False in order to get bbappends')
+                appendfiles = self.cooker.collection.get_file_appends(fn)
+        else:
+            appendfiles = None
+        envdata = parser.loadDataFull(fn, appendfiles)
+        return envdata
+
     def shutdown(self):
         self.cooker.shutdown(force=True)
         self.cooker.post_serve()
-- 
2.5.5


