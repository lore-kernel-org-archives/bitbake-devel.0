Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 456D86D3AC
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:46 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337444"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:31 +0000
Message-Id: <56b4c18e1b9c2045ceeb3cc2f88a7985288407dd.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/8] build, toaster: record proper task type
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:46 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Bitbake tasks may be of type 'python' or 'shell',
or they may not be executed at all, which is record
as task type 'noexec'.

In order to record proper task type, this patch:

* creates no exec task type as the default value in
the toaster model definition

* adds full task flags to the bb.build.TaskStarted event
in build.py

* if the task actually starts, the toaster ui will
record the type of the task as either 'python' or 'shell'
based on the task flags.

[YOCTO #5073]
[YOCTO #5075]
[YOCTO #5327]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py              | 7 ++++++-
 lib/bb/ui/buildinfohelper.py | 7 +++++--
 lib/toaster/orm/models.py    | 8 +++++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 2e49a09..f9aca42 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -91,6 +91,9 @@ class TaskBase(event.Event):
 
 class TaskStarted(TaskBase):
     """Task execution started"""
+    def __init__(self, t, logfile, taskflags, d):
+        super(TaskStarted, self).__init__(t, logfile, d)
+        self.taskflags = taskflags
 
 class TaskSucceeded(TaskBase):
     """Task execution completed"""
@@ -422,7 +425,9 @@ def _exec_task(fn, task, d, quieterr):
     localdata.setVar('BB_LOGFILE', logfn)
     localdata.setVar('BB_RUNTASK', task)
 
-    event.fire(TaskStarted(task, logfn, localdata), localdata)
+    flags = localdata.getVarFlags(task)
+
+    event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
     try:
         for func in (prefuncs or '').split():
             exec_func(func, localdata)
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5881d13..4996b42 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -483,6 +483,8 @@ class BuildInfoHelper(object):
                 task_information['outcome'] = Task.OUTCOME_EXISTING
         else:
             task_information['task_executed'] = True
+            if 'noexec' in vars(event) and event.noexec == True:
+                task_information['script_type'] = Task.CODING_NOEXEC
 
         self.task_order += 1
         task_information['order'] = self.task_order
@@ -506,8 +508,9 @@ class BuildInfoHelper(object):
         if '_message' in vars(event):
             task_information['message'] = event._message
 
-        if 'ispython' in vars(event):
-            if event.ispython:
+        if 'taskflags' in vars(event):
+            # with TaskStarted, we get even more information
+            if 'python' in event.taskflags.keys() and event.taskflags['python'] == '1':
                 task_information['script_type'] = Task.CODING_PYTHON
             else:
                 task_information['script_type'] = Task.CODING_SHELL
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index cb6581c..53b9e3a 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -74,10 +74,12 @@ class Task(models.Model):
         (SSTATE_RESTORED, 'Restored'), # succesfully restored
     )
 
-    CODING_PYTHON = 0
-    CODING_SHELL = 1
+    CODING_NOEXEC = 0
+    CODING_PYTHON = 1
+    CODING_SHELL = 2
 
     TASK_CODING = (
+        (CODING_NOEXEC, 'NoExec'),
         (CODING_PYTHON, 'Python'),
         (CODING_SHELL, 'Shell'),
     )
@@ -108,7 +110,7 @@ class Task(models.Model):
     task_name = models.CharField(max_length=100)
     source_url = models.FilePathField(max_length=255, blank=True)
     work_directory = models.FilePathField(max_length=255, blank=True)
-    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_PYTHON)
+    script_type = models.IntegerField(choices=TASK_CODING, default=CODING_NOEXEC)
     line_number = models.IntegerField(default=0)
     disk_io = models.IntegerField(null=True)
     cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
-- 
1.8.1.2


