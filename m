Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8843560110
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 12:18:49 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 22 Jan 2016 04:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,330,1449561600"; d="scan'208";a="639291927"
Received: from awasserm-mobl10.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.17.23])
	by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2016 04:18:48 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jan 2016 12:18:37 +0000
Message-Id: <1453465117-11320-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: run bitbake server with --read option
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
X-List-Received-Date: Fri, 22 Jan 2016 12:18:51 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster script run bitbake with --postread conf/toaster.conf.
It turned out that variables set this way don't influence the
build. Changing --postread to --read makes bitbake to read
variables earlier and should fix this issue.

[YOCTO #8781]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index e5041cb..72eae64 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -108,7 +108,7 @@ stop_system()
 
 start_bitbake() {
     unset BBSERVER
-    bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
+    bitbake --read conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
     if [ $? -ne 0 ]; then
         echo "Bitbake server start failed"
         return 1
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


