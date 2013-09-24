Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 040236CBAD
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:19 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Sep 2013 09:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948541"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 12D1B5625D2; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:26 +0100
Message-Id: <44ce6b2f8596f16b8ed4318a7f584d87dda74c4c.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 57/94] bitbake: webhob: store logfile and message for Tasks
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:22 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Since we get the reference to the log file, and a corresponding
message with Task* events, we store that in the database.

Corresponding changes to the model file.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 6 ++++++
 bitbake/lib/bb/ui/dsi.py             | 4 +++-
 bitbake/lib/webhob/orm/models.py     | 6 ++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index d435f19..232eea8 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -409,6 +409,12 @@ class BuildInfoHelper(object):
         except:
             pass
 
+        if 'logfile' in vars(event):
+            task_information['logfile'] = event.logfile
+
+        if '_message' in vars(event):
+            task_information['message'] = event._message
+
         if isinstance(event, (bb.runqueue.runQueueTaskCompleted, bb.runqueue.sceneQueueTaskCompleted)):
             task_information['outcome'] = Task.OUTCOME_SUCCESS     # TODO: needs to use constants
             task_build_stats = self._get_task_build_stats(self.orm_wrapper.get_update_task_object(task_information))
diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 78982f2..f72b1be 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -303,7 +303,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.BuildStarted):
                 buildinfohelper.store_started_build(event)
 
-            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent, bb.build.TaskFailed)):
+            if isinstance(event, (bb.build.TaskSucceeded, bb.build.TaskFailedSilent)):
                 buildinfohelper.update_and_store_task(event)
                 continue
 
@@ -338,6 +338,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.build.TaskFailed):
+                buildinfohelper.update_and_store_task(event)
                 return_value = 1
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
@@ -362,6 +363,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         if lines:
                             for line in lines:
                                 print(line)
+
             if isinstance(event, bb.build.TaskBase):
                 logger.info(event._message)
                 continue
diff --git a/bitbake/lib/webhob/orm/models.py b/bitbake/lib/webhob/orm/models.py
index 91a51ff..f51f53d 100644
--- a/bitbake/lib/webhob/orm/models.py
+++ b/bitbake/lib/webhob/orm/models.py
@@ -87,11 +87,9 @@ class Task(models.Model):
     disk_io = models.IntegerField(null=True)
     cpu_usage = models.DecimalField(max_digits=6, decimal_places=2, null=True)
     elapsed_time = models.CharField(max_length=50, default=0)
-    errors_no = models.IntegerField(default=0)
-    warnings_no = models.IntegerField(default=0)
-    error = models.TextField(null=True)
-    warning = models.TextField(null=True)
     sstate_result = models.IntegerField(choices=SSTATE_RESULT, default=SSTATE_NA)
+    message = models.CharField(max_length=240)
+    logfile = models.FilePathField(max_length=255, null=True)
 
     class Meta:
         ordering = ('order', 'recipe' ,)
-- 
1.8.1.2


