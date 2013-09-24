Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id EB71C6CB05
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902442"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id C095B561710; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:58 +0100
Message-Id: <503d29a10820131264247495f7740bf5207195aa.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 29/94] bitbake: dsi: fix the reading of task event information
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fixing a problem where the event outcome wasn't processed.
Moving all the event-type-dependent code at the same level
in the class.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index d489c87..6eafea0 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -231,14 +231,6 @@ class BuildInfoHelper(object):
         task_information = {}
         task_information['build'] = self.internal_state['build']
         task_information['outcome'] = Task.OUTCOME_NA
-        if isinstance(event, bb.runqueue.runQueueTaskSkipped):
-            task_information['task_executed'] = False
-            if event._skip == "covered":
-                task_information['outcome'] = Task.OUTCOME_COVERED
-            if event._skip == "existing":
-                task_information['outcome'] = Task.OUTCOME_EXISTING
-        else:
-            task_information['task_executed'] = True
         task_information['recipe'] = recipe
         task_information['task_name'] = event.taskname
         return task_information
@@ -360,10 +352,19 @@ class BuildInfoHelper(object):
         recipe = self.orm_wrapper.get_update_recipe_object(recipe_information)
 
         task_information = self._get_task_information(event, recipe)
+        task_information['outcome'] = Task.OUTCOME_NA
+
+        if isinstance(event, bb.runqueue.runQueueTaskSkipped):
+            task_information['task_executed'] = False
+            if event.reason == "covered":
+                task_information['outcome'] = Task.OUTCOME_COVERED
+            if event.reason == "existing":
+                task_information['outcome'] = Task.OUTCOME_EXISTING
+        else:
+            task_information['task_executed'] = True
 
         self.task_order += 1
         task_information['order'] = self.task_order
-        task_information['outcome'] = Task.OUTCOME_NA
         task_obj = self.orm_wrapper.get_update_task_object(task_information)
 
         self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
@@ -385,6 +386,10 @@ class BuildInfoHelper(object):
             task_information['disk_io'] = task_build_stats['disk_io']
             del self.internal_state[identifier]
 
+        if isinstance(event, bb.runqueue.runQueueTaskFailed):
+            task_information['outcome'] = Task.OUTCOME_FAILED
+            del self.internal_state[identifier]
+
         #TODO: get error number
         #TODO: get warnings number
         #TODO: get warning information
-- 
1.8.1.2


