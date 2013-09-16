Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 27FD06158F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:56:59 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 16 Sep 2013 04:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="378817516"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 16 Sep 2013 04:56:59 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id BEDED56093A; Mon, 16 Sep 2013 12:57:00 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:55 +0100
Message-Id: <a5db8806dc326f93d8e0bb36ff1c7b83d1d77e6a.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/8] bitbake: build: add logfile path for all Task events
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
X-List-Received-Date: Mon, 16 Sep 2013 11:56:59 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add the path to the logfile for all Task events, so
that we can record the logfile locations during the run.

This is needed because the logfile symlinks will point
only to the last build logs, and there is no other link
between a certain build and the log file it produces.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/build.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1265bdc..8d001b1 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -91,13 +91,18 @@ class TaskBase(event.Event):
 
 class TaskStarted(TaskBase):
     """Task execution started"""
+    def __init__(self, task, logfile, metadata):
+        self.logfile = logfile
+        super(TaskStarted, self).__init__(task, metadata)
 
 class TaskSucceeded(TaskBase):
     """Task execution completed"""
+    def __init__(self, task, logfile, metadata):
+        self.logfile = logfile
+        super(TaskSucceeded, self).__init__(task, metadata)
 
 class TaskFailed(TaskBase):
     """Task execution failed"""
-
     def __init__(self, task, logfile, metadata, errprinted = False):
         self.logfile = logfile
         self.errprinted = errprinted
@@ -114,8 +119,8 @@ class TaskFailedSilent(TaskBase):
         return "Failed"
 
 class TaskInvalid(TaskBase):
-
-    def __init__(self, task, metadata):
+    def __init__(self, task, logfile, metadata):
+        self.logfile = logfile
         super(TaskInvalid, self).__init__(task, metadata)
         self._message = "No such task '%s'" % task
 
@@ -419,7 +424,7 @@ def _exec_task(fn, task, d, quieterr):
     localdata.setVar('BB_LOGFILE', logfn)
     localdata.setVar('BB_RUNTASK', task)
 
-    event.fire(TaskStarted(task, localdata), localdata)
+    event.fire(TaskStarted(task, logfn, localdata), localdata)
     try:
         for func in (prefuncs or '').split():
             exec_func(func, localdata)
@@ -456,7 +461,7 @@ def _exec_task(fn, task, d, quieterr):
             logger.debug(2, "Zero size logfn %s, removing", logfn)
             bb.utils.remove(logfn)
             bb.utils.remove(loglink)
-    event.fire(TaskSucceeded(task, localdata), localdata)
+    event.fire(TaskSucceeded(task, logfn, localdata), localdata)
 
     if not localdata.getVarFlag(task, 'nostamp') and not localdata.getVarFlag(task, 'selfstamp'):
         make_stamp(task, localdata)
-- 
1.8.1.2


