Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id D97A9770BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Oct 2015 09:43:32 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga102.fm.intel.com with ESMTP; 05 Oct 2015 02:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,637,1437462000"; d="scan'208";a="784630532"
Received: from blynch-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.31])
	by orsmga001.jf.intel.com with ESMTP; 05 Oct 2015 02:43:33 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Oct 2015 10:43:17 +0100
Message-Id: <3fb76edd99fb03532231d93e51d0197a5438dac8.1444038048.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
References: <04c22e69056969f61173107062a4eec82a4bc3ed.1444038048.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444038048.git.elliot.smith@intel.com>
References: <cover.1444038048.git.elliot.smith@intel.com>
Subject: [PATCH 5/6] toaster: ignore ReachableStamps event
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
X-List-Received-Date: Mon, 05 Oct 2015 09:43:33 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added ReachableStamps event to the list of known events to
ignore. This should stop toaster throwing error message:
ERROR: Unknown event: <bb.event.ReachableStamps>

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/bb/ui/toasterui.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index e0c278b..3891e63 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -308,7 +308,8 @@ def main(server, eventHandler, params ):
                                   bb.event.OperationProgress,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit,
-                                  bb.command.CommandCompleted)):
+                                  bb.command.CommandCompleted,
+                                  bb.event.ReachableStamps)):
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
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


