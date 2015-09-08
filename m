Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7026276E7C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 09:40:26 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 08 Sep 2015 02:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,489,1437462000"; d="scan'208";a="557427811"
Received: from almacarr-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.11.248])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2015 02:40:25 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Sep 2015 10:40:20 +0100
Message-Id: <b6b55c4ec22e12553e70a39339fdae0cdfc4757f.1441705002.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <f5290147ed6e226f39004b18c867e1ed2042c354.1441705002.git.elliot.smith@intel.com>
References: <f5290147ed6e226f39004b18c867e1ed2042c354.1441705002.git.elliot.smith@intel.com>
In-Reply-To: <cover.1441705002.git.elliot.smith@intel.com>
References: <cover.1441705002.git.elliot.smith@intel.com>
Subject: [PATCH 3/3] toaster: replace ETA with % of tasks done
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
X-List-Received-Date: Tue, 08 Sep 2015 09:40:26 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The ETA we show for builds in progress is woefully
inaccurate. In the 1.8 release we replaced it with
the % of tasks completed. Somehow, we regressed to
the ETA, so bringing the task % back.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 57a6f9b..396fb8e 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -84,7 +84,7 @@
                     <div style="width: {{build.completeper}}%;" class="bar"></div>
                 </div>
             </div>
-            <div class="lead pull-right">ETA: in {{build.eta|naturaltime}}</div>
+            <div class="lead pull-right">{{build.completeper}}% of tasks complete</div>
     {%endif%}
         </div>
     </div>
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


