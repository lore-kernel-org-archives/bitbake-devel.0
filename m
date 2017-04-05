Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id BE6B060079
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491428060; x=1522964060;
	h=from:to:cc:subject:date:message-id;
	bh=2dLiKWXZWDhbk+yWZXy99shwYiyRi1BEFX29ssdh3wk=;
	b=hrGxz4ztpwy8l74TpjVh32+S/iOaVwfjBPBEHaB6FE9h2fJYjh1gEq5L
	DBv13SZvXqX+wAhayHgSAaWgws49EA==;
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Apr 2017 14:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,280,1488873600"; d="scan'208";a="952329640"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga003.jf.intel.com with ESMTP; 05 Apr 2017 14:34:06 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Apr 2017 14:34:05 -0700
Message-Id: <1491428045-10132-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] cooker.py: multiconfig support for findBestProvider
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
X-List-Received-Date: Wed, 05 Apr 2017 21:34:18 -0000

In a multiconfig environment, a tinfoil call such as

    tinfoil.parse_recipe("multiconfig:arduino-101-sss:gcc")

can fail with an error such as:

  File "/data/master/poky/bitbake/lib/bb/tinfoil.py", line 373, in get_recipe_file
    raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
bb.providers.NoProvider: Unable to find any recipe file matching "multiconfig:arduino-101-sss:gcc"

The culprit is findBestProvider (only called from tinfoil), which does not
handle multiconfig. This patch fixes the error and the tinfoil call returns absolute path
to the recipe, i.e:

  "/data/master/poky/meta/recipes-devtools/gcc/gcc_6.3.bb"

[YOCTO#11210]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/cooker.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index bc8574a..bf9593e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -160,6 +160,19 @@ class EventWriter:
 #============================================================================#
 # BBCooker
 #============================================================================#
+
+def split_mc_pn(pn):
+    if pn.startswith("multiconfig:"):
+        mc = pn.split(":")[1]
+        pn = ":".join(pn.split(":")[2:])
+        return (mc, pn)
+    return ('', pn)
+
+def split_pn(pn):
+    if pn.startswith("multiconfig:"):
+       return ":".join(pn.split(":")[2:])
+    return pn
+
 class BBCooker:
     """
     Manages one bitbake build run
@@ -1104,11 +1117,12 @@ class BBCooker:
     def findProviders(self, mc=''):
         return bb.providers.findProviders(self.data, self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
 
-    def findBestProvider(self, pn, mc=''):
+    def findBestProvider(self, pn):
+        (mc, pn) = split_mc_pn(pn)
         if pn in self.recipecaches[mc].providers:
             filenames = self.recipecaches[mc].providers[pn]
             eligible, foundUnique = bb.providers.filterProviders(filenames, pn, self.data, self.recipecaches[mc])
-            filename = eligible[0]
+            filename = split_pn(eligible[0])
             return None, None, None, filename
         elif pn in self.recipecaches[mc].pkg_pn:
             return bb.providers.findBestProvider(pn, self.data, self.recipecaches[mc], self.recipecaches[mc].pkg_pn)
-- 
2.7.4


