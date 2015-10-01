Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A9E557700B
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Oct 2015 09:41:49 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 01 Oct 2015 02:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,616,1437462000"; d="scan'208";a="817039364"
Received: from mhalasin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.78])
	by orsmga002.jf.intel.com with ESMTP; 01 Oct 2015 02:41:47 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Oct 2015 10:41:26 +0100
Message-Id: <1443692486-15472-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: Fix broken test case
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
X-List-Received-Date: Thu, 01 Oct 2015 09:41:50 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed test_show_tasks_in_projectbuilds broken by latest changes in
project build view.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/tests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/toastergui/tests.py b/bitbake/lib/toaster/toastergui/tests.py
index 5d15ac9..95790a2 100644
--- a/bitbake/lib/toaster/toastergui/tests.py
+++ b/bitbake/lib/toaster/toastergui/tests.py
@@ -564,7 +564,7 @@ class ProjectBuildsDisplayTest(TestCase):
         url = reverse("projectbuilds", args=(self.project1.id,))
         response = self.client.get(url, follow=True)
         result = re.findall('^ +bash:clean$', response.content, re.MULTILINE)
-        self.assertEqual(len(result), 1)
+        self.assertEqual(len(result), 2)
 
     def test_show_tasks_in_allbuilds(self):
         build = Build.objects.create(**self.project1_build_success)
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


