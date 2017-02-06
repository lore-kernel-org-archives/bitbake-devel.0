Return-Path: <juro.bystricky@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 807EF71997
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Feb 2017 16:53:14 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 06 Feb 2017 08:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,342,1477983600"; d="scan'208";a="930737371"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.149])
	by orsmga003.jf.intel.com with ESMTP; 06 Feb 2017 08:53:14 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  6 Feb 2017 08:49:20 -0800
Message-Id: <1486399760-14115-2-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1486399760-14115-1-git-send-email-juro.bystricky@intel.com>
References: <1486399760-14115-1-git-send-email-juro.bystricky@intel.com>
Cc: jurobystricky@hotmail.com
Subject: [PATCH 1/1] cooker.py: run sanity checks for multiconfig
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
X-List-Received-Date: Mon, 06 Feb 2017 16:53:15 -0000

Also run sanity check for all additional multiconfig configurations
as listed in BBMULTICONFIG, not just the "default" configuration.

[YOCTO#10810]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 80007c5..f8def47 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1641,7 +1641,8 @@ class BBCooker:
         if self.state != state.parsing and not self.parsecache_valid:
             self.parseConfiguration ()
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
-                bb.event.fire(bb.event.SanityCheck(False), self.data)
+                for mc in self.multiconfigs:
+                    bb.event.fire(bb.event.SanityCheck(False), self.databuilder.mcdata[mc])
 
             for mc in self.multiconfigs:
                 ignore = self.databuilder.mcdata[mc].getVar("ASSUME_PROVIDED") or ""
-- 
2.7.4


