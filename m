Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 80ACE65CC2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Mar 2016 11:59:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 17 Mar 2016 04:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,349,1455004800"; d="scan'208";a="912931976"
Received: from wmalikow-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.20.136])
	by orsmga001.jf.intel.com with ESMTP; 17 Mar 2016 04:59:05 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Mar 2016 11:59:02 +0000
Message-Id: <1458215942-18397-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toasterui: remove ParseStarted from the event list
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
X-List-Received-Date: Thu, 17 Mar 2016 11:59:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

bb.event.ParseStarted event is not processed by toasterui, but
present in event list. This causes the following error:
   WARNING: Unknown event: <bb.event.ParseStarted object at ...
and non-zero return code:
   WARNING: Return value is 1

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/toasterui.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 29aed2e..df85bbd 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -115,7 +115,6 @@ _evt_list = [
     "bb.event.NoProvider",
     "bb.event.ParseCompleted",
     "bb.event.ParseProgress",
-    "bb.event.ParseStarted",
     "bb.event.RecipeParsed",
     "bb.event.SanityCheck",
     "bb.event.SanityCheckPassed",
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


