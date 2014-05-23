Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (unknown [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8B3986A9C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 15:22:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 May 2014 08:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="545581367"
Received: from bidesilv-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.159])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2014 08:22:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 16:22:16 +0100
Message-Id: <96b84cf62432688842c17ff28d768f59398538bf.1400858501.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-layers: show-cross-depends: ignore self-satisfied RDEPENDS
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
X-List-Received-Date: Fri, 23 May 2014 15:22:37 -0000

Overlayed recipes caused this to show false positives because the
overlaying version appeared to be satisfying the overlayed version's
RDEPENDS; but you'd never be building both at the same time.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 326239a..135096b 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -626,6 +626,9 @@ The .bbappend file can impact the dependency.
             for rdep in all_rdeps:
                 all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rdep)
                 if all_p:
+                    if f in all_p:
+                        # The recipe provides this one itself, ignore
+                        continue
                     best = bb.providers.filterProvidersRunTime(all_p, rdep,
                                     self.bbhandler.config_data,
                                     self.bbhandler.cooker_data)[0][0]
-- 
1.9.0


