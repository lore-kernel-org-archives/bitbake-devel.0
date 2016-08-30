Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A360073199
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 20:48:56 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 30 Aug 2016 13:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,258,1470726000"; d="scan'208";a="162622946"
Received: from ashuvini-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.135])
	by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2016 13:48:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Aug 2016 08:48:09 +1200
Message-Id: <a70189a2822f2a26dbdc15df4ec10fba3dc93b7a.1472589757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 4/4] tinfoil: add a parse_recipe_file function
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
X-List-Received-Date: Tue, 30 Aug 2016 20:48:56 -0000

Parsing a recipe is such a common task for tinfoil-using scripts, and is
a little awkward to do properly, so add an API function to do it. This
should also isolate scripts a little from future changes to the internal
code. The first user of this will be the OpenEmbedded layer index update
script.

Part of the fix for [YOCTO #10192].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 441be2c..8899e86 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -90,6 +90,42 @@ class Tinfoil:
             else:
                 self.parseRecipes()
 
+    def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
+        """
+        Parse the specified recipe file (with or without bbappends)
+        and return a datastore object representing the environment
+        for the recipe.
+        Parameters:
+            fn: recipe file to parse - can be a file path or virtual
+                specification
+            appends: True to apply bbappends, False otherwise
+            appendlist: optional list of bbappend files to apply, if you
+                        want to filter them
+            config_data: custom config datastore to use. NOTE: if you
+                         specify config_data then you cannot use a virtual
+                         specification for fn.
+        """
+        if appends and appendlist == []:
+            appends = False
+        if appends:
+            if appendlist:
+                appendfiles = appendlist
+            else:
+                if not hasattr(self.cooker, 'collection'):
+                    raise Exception('You must call tinfoil.prepare() with config_only=False in order to get bbappends')
+                appendfiles = self.cooker.collection.get_file_appends(fn)
+        else:
+            appendfiles = None
+        if config_data:
+            # We have to use a different function here if we're passing in a datastore
+            localdata = bb.data.createCopy(config_data)
+            envdata = bb.cache.parse_recipe(localdata, fn, appendfiles)['']
+        else:
+            # Use the standard path
+            parser = bb.cache.NoCache(self.cooker.databuilder)
+            envdata = parser.loadDataFull(fn, appendfiles)
+        return envdata
+
     def shutdown(self):
         self.cooker.shutdown(force=True)
         self.cooker.post_serve()
-- 
2.5.5


