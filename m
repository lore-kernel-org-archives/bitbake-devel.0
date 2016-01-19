Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B26B173190
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jan 2016 16:13:54 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 19 Jan 2016 08:13:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,317,1449561600"; d="scan'208";a="893876495"
Received: from kosulliv-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.31.224])
	by orsmga002.jf.intel.com with ESMTP; 19 Jan 2016 08:13:53 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jan 2016 16:13:28 +0000
Message-Id: <1453220008-25718-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: write variables to toaster.conf
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
X-List-Received-Date: Tue, 19 Jan 2016 16:13:54 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

With the resent change in rootfs creation code setVariable
rpc calls don't set variables for bitbake workers anymore.

Writen variables to toaster.conf should solve this issue.

[YOCTO #8910]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 4f6f15c..2215d7af2 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -280,6 +280,13 @@ class LocalhostBEController(BuildEnvironmentController):
         # set up the build environment with the needed layers
         self.setLayers(bitbake, layers, targets)
 
+        # write configuration file
+        filepath = os.path.join(self.be.builddir, "conf/toaster.conf")
+        with open(filepath, 'w') as conf:
+            for var in variables:
+                conf.write('%s="%s"\n' % (var.name, var.value))
+            conf.write('INHERIT+="toaster buildhistory"')
+
         # get the bb server running with the build req id and build env id
         bbctrl = self.getBBController()
 
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


