Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5E4E66CB15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:07 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442561"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B38B7561334; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:53 +0100
Message-Id: <f61e47d18d0eaad4d647e96bff7243586c953823.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 24/94] bitbake: dsi: event data change
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Changes in the BuildInfoHelper and DSI as to record task
file names and task names coming through the bb.build.Task*
events.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 22 +++++++++++++---------
 bitbake/lib/bb/ui/dsi.py             |  1 +
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 820e0f8..e43aa8c 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -116,7 +116,7 @@ class ORMWrapper(object):
         task_information['log_file'] = 'Not Available'
         task_information['work_directory'] = 'Not Available'
         task_information['script_type'] = 0
-        task_information['file_path'] = 'Not Available'
+        task_information['file_path'] = event.taskfile
         task_information['line_number'] = 0
         task_information['py_stack_trace'] = 'Not Available'
         task_information['disk_io'] = 0
@@ -132,7 +132,7 @@ class ORMWrapper(object):
 
     def create_task_object(self, task_information):
         self.task_order += 1
-        identifier = task_information['recipe'].name + task_information['task_name']
+        identifier = task_information['recipe'].file_path + task_information['task_name']
 
         task_object = Task.objects.get_or_create(
                                 build=task_information['build'],
@@ -173,14 +173,16 @@ class ORMWrapper(object):
 
         if isinstance(event, bb.runqueue.runQueueTaskCompleted):
             task.outcome = 3
+            task.save()
+
+        if isinstance(event, bb.build.TaskBase):
+            task.recipe.name = event._package
+            task.recipe.save()
 
         task_build_stats = self._get_task_build_stats(task)
         task.cpu_usage = task_build_stats['cpu_usage']
         task.disk_io = task_build_stats['disk_io']
 
-        if outcome_info.get('error', ''):
-            task.error = outcome_info['error']
-
         #TODO: get error number
         #TODO: get warnings number
         #TODO: get warning information
@@ -264,7 +266,7 @@ class ORMWrapper(object):
         build_layer_obj = self._get_build_layer_object(event)
 
         recipe_info = {}
-        recipe_info['name'] = event.taskpackage
+        recipe_info['name'] = 'N/A'
         recipe_info['version'] = 'Not Available'
         recipe_info['layer'] = build_layer_obj
         recipe_info['summary'] = 'Not Available'
@@ -275,7 +277,8 @@ class ORMWrapper(object):
         recipe_info['homepage'] = 'Not Available'
         recipe_info['bugtracker'] = 'Not Available'
         recipe_info['author'] = 'Not Available'
-        recipe_info['file_path'] = 'Not Available'
+        recipe_info['file_path'] = event.taskfile
+
 
         return recipe_info
 
@@ -406,7 +409,8 @@ class BuildInfoHelper(object):
         task_obj = self.orm_wrapper.create_task_object(task_information)
 
     def update_and_store_task(self, event):
-        identifier = event.taskpackage + event.taskname
+        identifier = event.taskfile + event.taskname
         task_dictionary = self.orm_wrapper.transport_utils[identifier]
         self.orm_wrapper.update_task_object(task_dictionary, event)
-        del self.orm_wrapper.transport_utils[identifier]
+        if isinstance(event,bb.runqueue.runQueueTaskCompleted):
+            del self.orm_wrapper.transport_utils[identifier]
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 90dd732..22b35e2 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -288,6 +288,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 buildinfohelper.store_started_build(event)
 
             if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
+                buildinfohelper.update_and_store_task(event)
                 continue
 
             if isinstance(event, bb.event.LogExecTTY):
-- 
1.8.1.2


