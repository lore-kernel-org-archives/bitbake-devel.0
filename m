Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 12F486CAF4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:08 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902445"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id BD9D6561485; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:57 +0100
Message-Id: <09f20a8ec17d901565e7ea6171bc9884bf3a1c01.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 28/94] bitbake: webhob: use defined constants for models
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

We change the models to use constants to improve
the legibility of the code.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 13 +++++----
 bitbake/lib/webhob/orm/models.py     | 55 ++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index f5e3f25..d489c87 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -47,9 +47,9 @@ class ORMWrapper(object):
 
     def update_build_object(self, build_obj, errors, warnings, taskfailures):
 
-        outcome = 0
+        outcome = Build.SUCCEEDED
         if errors or taskfailures:
-            outcome = 1
+            outcome = Build.FAILED
 
         build = Build.objects.get(uuid=build_obj.uuid)
         build.completed_on = datetime.datetime.now()
@@ -230,13 +230,13 @@ class BuildInfoHelper(object):
 
         task_information = {}
         task_information['build'] = self.internal_state['build']
-        task_information['outcome'] = 4
+        task_information['outcome'] = Task.OUTCOME_NA
         if isinstance(event, bb.runqueue.runQueueTaskSkipped):
             task_information['task_executed'] = False
             if event._skip == "covered":
-                task_information['outcome'] = 2
+                task_information['outcome'] = Task.OUTCOME_COVERED
             if event._skip == "existing":
-                task_information['outcome'] = 0
+                task_information['outcome'] = Task.OUTCOME_EXISTING
         else:
             task_information['task_executed'] = True
         task_information['recipe'] = recipe
@@ -363,6 +363,7 @@ class BuildInfoHelper(object):
 
         self.task_order += 1
         task_information['order'] = self.task_order
+        task_information['outcome'] = Task.OUTCOME_NA
         task_obj = self.orm_wrapper.get_update_task_object(task_information)
 
         self.internal_state[identifier] = {'start_time': datetime.datetime.now()}
@@ -378,7 +379,7 @@ class BuildInfoHelper(object):
             pass
 
         if isinstance(event, bb.runqueue.runQueueTaskCompleted):
-            task_information['outcome'] = 3     # TODO: needs to use constants
+            task_information['outcome'] = Task.OUTCOME_SUCCESS     # TODO: needs to use constants
             task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
             task_information['cpu_usage'] = task_build_stats['cpu_usage']
             task_information['disk_io'] = task_build_stats['disk_io']
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index dfbc0ae..83126d8 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -2,11 +2,14 @@ from django.db import models
 
 
 class Build(models.Model):
+    SUCCEEDED = 0
+    FAILED = 1
+    IN_PROGRESS = 2
 
     BUILD_OUTCOME = (
-        (0, 'Succeeded'),
-        (1, 'Failed'),
-        (2, 'In Progress'),
+        (SUCCEEDED, 'Succeeded'),
+        (FAILED, 'Failed'),
+        (IN_PROGRESS, 'In Progress'),
     )
 
     uuid = models.CharField(max_length=100, unique=True)
@@ -16,7 +19,7 @@ class Build(models.Model):
     distro_version = models.CharField(max_length=100)
     started_on = models.DateTimeField()
     completed_on = models.DateTimeField()
-    outcome = models.IntegerField(choices=BUILD_OUTCOME, default=2)
+    outcome = models.IntegerField(choices=BUILD_OUTCOME, default=IN_PROGRESS)
     errors_no = models.IntegerField(default=0)
     warnings_no = models.IntegerField(default=0)
     image_fstypes = models.CharField(max_length=100)
@@ -27,30 +30,46 @@ class Build(models.Model):
 
 class Task(models.Model):
 
+    SSTATE_NA = 0
+    SSTATE_MISS = 1
+    SSTATE_FAILED = 2
+    SSTATE_RESTORED = 3
+
     SSTATE_RESULT = (
-        (0, 'Not Applicable'), # For rest of tasks, but they still need checking.
-        (1, 'Unavailable'), # it is a miss
-        (2, 'Failed'), # there was a pkg, but the script failed
-        (3, 'Restored'), # succesfully restored
+        (SSTATE_NA, 'Not Applicable'), # For rest of tasks, but they still need checking.
+        (SSTATE_MISS, 'Missing'), # it is a miss
+        (SSTATE_FAILED, 'Failed'), # there was a pkg, but the script failed
+        (SSTATE_RESTORED, 'Restored'), # succesfully restored
     )
 
+    CODING_PYTHON = 0
+    CODING_SHELL = 1
+
     TASK_CODING = (
-        (0, 'Python'),
-        (1, 'Shell'),
+        (CODING_PYTHON, 'Python'),
+        (CODING_SHELL, 'Shell'),
     )
 
+    OUTCOME_SUCCESS = 0
+    OUTCOME_COVERED = 1
+    OUTCOME_SSTATE = 2
+    OUTCOME_EXISTING = 3
+    OUTCOME_FAILED = 4
+    OUTCOME_NA = 5
+
     TASK_OUTCOME = (
-        (0, 'Covered'),
-        (1, 'Sstate'),
-        (2, 'Existing'),
-        (3, 'Succeeded'),
-        (4, 'Failed'),
+        (OUTCOME_SUCCESS, 'Succeeded'),
+        (OUTCOME_COVERED, 'Covered'),
+        (OUTCOME_SSTATE, 'Sstate'),
+        (OUTCOME_EXISTING, 'Existing'),
+        (OUTCOME_FAILED, 'Failed'),
+        (OUTCOME_NA, 'Not Available'),
     )
 
     build = models.ForeignKey(Build, related_name='task_build')
     order = models.IntegerField(null=True)
     task_executed = models.BooleanField(default=False) # True means Executed, False means Prebuilt
-    outcome = models.IntegerField(choices=TASK_OUTCOME, default=4)
+    outcome = models.IntegerField(choices=TASK_OUTCOME, default=OUTCOME_NA)
     sstate_checksum = models.CharField(max_length=100, null=True)
     path_to_sstate_obj = models.FilePathField(max_length=500, blank=True)
     recipe = models.ForeignKey('Recipe', related_name='build_recipe')
@@ -58,7 +77,7 @@ class Task(models.Model):
     source_url = models.FilePathField(max_length=255, null=True)
     log_file = models.FilePathField(max_length=255, blank=True)
     work_directory = models.FilePathField(max_length=255, null=True)
-    script_type = models.IntegerField(choices=TASK_CODING, default=0)
+    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_PYTHON)
     line_number = models.IntegerField(default=0)
     py_stack_trace = models.TextField(null=True)
     disk_io = models.IntegerField(default=0)
@@ -68,7 +87,7 @@ class Task(models.Model):
     warnings_no = models.IntegerField(default=0)
     error = models.TextField(null=True)
     warning = models.TextField(null=True)
-    sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=0)
+    sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=SSTATE_NA)
 
     class Meta:
         ordering = ('order', 'recipe' ,)
-- 
1.8.1.2


