Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id DC65A65CBB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 12:59:51 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 19 May 2016 05:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="106841839"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by fmsmga004.fm.intel.com with ESMTP; 19 May 2016 05:59:53 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 13:59:33 +0100
Message-Id: <1463662773-31389-6-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
References: <1463662773-31389-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 6/6] toaster: tests builds Add SSTATE_MISS as a valid condition for tc=833
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
X-List-Received-Date: Thu, 19 May 2016 12:59:52 -0000

From: Michael Wood <michael.g.wood@intel.com>

Task.SSTATE_NA and Task.SSTATE_MISS are both valid conditions for the
condition that a Task.OUTCOME_COVERED and Task.OUTCOME_PREBUILT.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/tests/builds/test_core_image_min.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/toaster/tests/builds/test_core_image_min.py b/bitbake/lib/toaster/tests/builds/test_core_image_min.py
index 87d29c7..dec0bfa 100644
--- a/bitbake/lib/toaster/tests/builds/test_core_image_min.py
+++ b/bitbake/lib/toaster/tests/builds/test_core_image_min.py
@@ -115,12 +115,19 @@ class BuildCoreImageMinimal(BuildTest):
     # be 0 (SSTATE_NA) - tc=833
     def test_Task_If_Outcome_1_3_Sstate_Result_Must_Be_0(self):
         tasks = Task.objects.filter(
-            outcome__in=(1, 3)).values('id', 'sstate_result')
+            outcome__in=(Task.OUTCOME_COVERED,
+                         Task.OUTCOME_PREBUILT)).values('id',
+                                                        'task_name',
+                                                        'sstate_result')
         cnt_err = []
 
         for task in tasks:
-            if (task['sstate_result'] != 0):
-                cnt_err.append(task['id'])
+            if (task['sstate_result'] != Task.SSTATE_NA and
+                    task['sstate_result'] != Task.SSTATE_MISS):
+                cnt_err.append({'id': task['id'],
+                                'name': task['task_name'],
+                                'sstate_result': task['sstate_result'],
+                               })
 
         self.assertEqual(len(cnt_err),
                          0,
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


