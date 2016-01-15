Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 529DF6E6B1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 16:35:11 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP; 15 Jan 2016 08:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,300,1449561600"; d="scan'208";a="29993551"
Received: from ffolivei-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.20.40])
	by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2016 08:35:11 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jan 2016 16:35:03 +0000
Message-Id: <1452875703-15101-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: increase timeout
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
X-List-Received-Date: Fri, 15 Jan 2016 16:35:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Sometimes Toaster connection to the bitbake server fails with
this error in the log:
   ERROR: Could not connect to server 0.0.0.0:46572
   : Could not register UI event handler
It happens more often on slow machines.

Increasing timeout after restarting bitbake should fix this issue.

[YOCTO #8776]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 1f98490..e5041cb 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -228,7 +228,7 @@ if [ "$1" = 'restart-bitbake' ] ; then
     sleep 1
     start_bitbake
     rc=$?
-    sleep 1
+    sleep 3
     return $rc
 fi
 
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


