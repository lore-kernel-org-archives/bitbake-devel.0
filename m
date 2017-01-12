Return-Path: <juro.bystricky@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 2FEF06B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 19:27:42 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP; 12 Jan 2017 11:27:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,219,1477983600"; d="scan'208";a="29649696"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.149])
	by orsmga002.jf.intel.com with ESMTP; 12 Jan 2017 11:27:42 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Jan 2017 11:23:56 -0800
Message-Id: <1484249037-36445-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: jurobystricky@hotmail.com
Subject: [PATCH 1/2] cooker.py: run sanity checks for multiconfig
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
X-List-Received-Date: Thu, 12 Jan 2017 19:27:44 -0000

Also run sanity check for all multiconfig configurations as listed in
BBMULTICONFIG.

[YOCTO#10810]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 182d044..f6bad36 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1610,7 +1610,9 @@ class BBCooker:
         if self.state != state.parsing and not self.parsecache_valid:
             self.parseConfiguration ()
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
-                bb.event.fire(bb.event.SanityCheck(False), self.data)
+
+                for mc in self.multiconfigs:
+                    bb.event.fire(bb.event.SanityCheck(False), self.databuilder.mcdata[mc])
 
             for mc in self.multiconfigs:
                 ignore = self.databuilder.mcdata[mc].getVar("ASSUME_PROVIDED") or ""
-- 
2.7.4


