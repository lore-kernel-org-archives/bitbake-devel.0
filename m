Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9DB5760125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 14:31:52 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 07 Oct 2015 07:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,649,1437462000"; d="scan'208";a="659631950"
Received: from cdoyle2-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.38])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 07:31:52 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:31:20 +0100
Message-Id: <1444228280-21791-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: fix naming for clone directory
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
X-List-Received-Date: Wed, 07 Oct 2015 14:31:53 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Toaster uses git url and branch to make a clone directory
name. Current code leaves '@' and '%' characters unchanged,
which can cause generation of wrong directory names.

Fixed this issue by replacing '@' and '%' with underscore.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index a8d8398..3ee68ae 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -183,7 +183,7 @@ class LocalhostBEController(BuildEnvironmentController):
     def getGitCloneDirectory(self, url, branch):
         """Construct unique clone directory name out of url and branch."""
         if branch != "HEAD":
-            return "_toaster_clones/_%s_%s" % (re.sub('[:/]', '_', url), branch)
+            return "_toaster_clones/_%s_%s" % (re.sub('[:/@%]', '_', url), branch)
 
         # word of attention; this is a localhost-specific issue; only on the localhost we expect to have "HEAD" releases
         # which _ALWAYS_ means the current poky checkout
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


