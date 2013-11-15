Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 934276D7C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Nov 2013 11:29:17 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 15 Nov 2013 03:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,707,1378882800"; d="scan'208";a="433990672"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2013 03:29:18 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Nov 2013 13:34:46 +0200
Message-Id: <1384515286-17662-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: task with outcome 2 (sstate), should have sstate_result!=0
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
X-List-Received-Date: Fri, 15 Nov 2013 11:29:17 -0000

0 (not applicable) is not a valid sstate_result for tasks with
outcome 2 (sstate), which should return 3 (restored), 2
(failed) or 1 (missed).
Sstate_result for tasks with outcome 2 is equal to the outcome
of _setscene corespondent task.

[YOCTO #5220]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index fbf7546..7e3b572 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -93,6 +93,12 @@ class ORMWrapper(object):
         # if we got covered by a setscene task, we're SSTATE
         if task_object.outcome == Task.OUTCOME_COVERED and 1 == Task.objects.filter(task_executed=True, build = task_object.build, recipe = task_object.recipe, task_name=task_object.task_name+"_setscene").count():
             task_object.outcome = Task.OUTCOME_SSTATE
+            outcome_task_setscene = Task.objects.get(task_executed=True, build = task_object.build,
+                                    recipe = task_object.recipe, task_name=task_object.task_name+"_setscene").outcome
+            if outcome_task_setscene == Task.OUTCOME_SUCCESS:
+                task_object.sstate_result = Task.SSTATE_RESTORED
+            elif outcome_task_setscene == Task.OUTCOME_FAILED:
+                task_object.sstate_result = Task.SSTATE_FAILED
 
         # mark down duration if we have a start time
         if 'start_time' in task_information.keys():
-- 
1.7.9.5


