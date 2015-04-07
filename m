Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BA74C60089
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Apr 2015 13:15:04 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 07 Apr 2015 06:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,538,1422950400"; d="scan'208";a="704652162"
Received: from esinnott-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.27.139])
	by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2015 06:14:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Apr 2015 14:14:04 +0100
Message-Id: <1428412444-19193-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH] bitbake-layers: ensure non-extended recipe name is preferred
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
X-List-Received-Date: Tue, 07 Apr 2015 13:15:08 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In show-recipes and show-overlayed, we only list one variant of each
recipe where multiple exist, therefore we should show the main one (e.g.
in OpenEmbedded, we now show openssl and not nativesdk-openssl which
would otherwise sort first.)

Fixes [YOCTO #7514].

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index c1c65aa..5116e59 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -501,7 +501,13 @@ skipped recipes will also be listed, with a " (skipped)" suffix.
 
             if len(allproviders[p]) > 1 or not show_multi_provider_only:
                 pref = preferred_versions[p]
-                preffile = bb.cache.Cache.virtualfn2realfn(pref[1])[0]
+                realfn = bb.cache.Cache.virtualfn2realfn(pref[1])
+                preffile = realfn[0]
+                # We only display once per recipe, we should prefer non extended versions of the
+                # recipe if present (so e.g. in OpenEmbedded, openssl rather than nativesdk-openssl
+                # which would otherwise sort first).
+                if realfn[1] and realfn[0] in self.bbhandler.cooker.recipecache.pkg_fn:
+                    continue
                 if preffile not in preffiles:
                     preflayer = self.get_file_layer(preffile)
                     multilayer = False
-- 
2.1.0


