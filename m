Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 53BEF760A3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jan 2016 14:36:24 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 25 Jan 2016 06:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,344,1449561600"; d="scan'208";a="733892003"
Received: from njaughne-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.29.109])
	by orsmga003.jf.intel.com with ESMTP; 25 Jan 2016 06:36:23 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jan 2016 14:36:12 +0000
Message-Id: <1453732572-13180-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH][jethro] toaster: make runbuilds loop
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
X-List-Received-Date: Mon, 25 Jan 2016 14:36:25 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This avoids having a loop in shell code and initializing
heavy Django init machinery every second.

Ignore exceptions to prevent exiting the loop.

(Bitbake rev: e04da15556ca0936de652b8c085e4199e5551457)

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Ed Bartosh <eduard.bartosh@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../lib/toaster/bldcontrol/management/commands/runbuilds.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 5243a50..48dc618 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -5,6 +5,7 @@ from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdExcep
 from bldcontrol.models import BuildRequest, BuildEnvironment, BRError, BRVariable
 import os
 import logging
+import time
 
 logger = logging.getLogger("ToasterScheduler")
 
@@ -128,6 +129,12 @@ class Command(NoArgsCommand):
 
 
     def handle_noargs(self, **options):
-        self.cleanup()
-        self.archive()
-        self.schedule()
+        while True:
+            try:
+                self.cleanup()
+                self.archive()
+                self.schedule()
+            except:
+                pass
+
+            time.sleep(1)
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


