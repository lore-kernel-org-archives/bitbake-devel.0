Return-Path: <valentin.popa@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E81686B410
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jul 2013 08:26:21 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 30 Jul 2013 01:26:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,776,1367996400"; d="scan'208";a="378767614"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.70])
	by orsmga002.jf.intel.com with ESMTP; 30 Jul 2013 01:26:21 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jul 2013 11:27:28 +0300
Message-Id: <1375172848-13567-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] Bitbake: import needed package
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 30 Jul 2013 08:26:22 -0000

bitbake-worker makes use of signal package
but it doesn't import it. This patch fixes the issue.

[YOCTO #4750]

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/bin/bitbake-worker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 6580078..b438d98 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -9,6 +9,7 @@ import logging
 import bb
 import select
 import errno
+import signal
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or sys.argv[1] != "decafbad":
-- 
1.8.1.2


