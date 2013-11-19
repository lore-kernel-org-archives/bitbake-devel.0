Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 6CD4E6D000
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 16:46:41 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 19 Nov 2013 08:46:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,730,1378882800"; d="scan'208";a="430343917"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2013 08:46:42 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 99D1B5611BF; Tue, 19 Nov 2013 16:46:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Nov 2013 16:46:41 +0000
Message-Id: <1384879601-23407-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] bitbake: cooker, toaster: mark interrupted builds as failed
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
X-List-Received-Date: Tue, 19 Nov 2013 16:46:43 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch changes bitbake to log an error to the
command line when the build is interrupted via Ctrl-C.

This is needed to inform the user that not all tasks
required for the build have been executed, and
the build is not complete.

Internally, the Bitbake server will return a CommandFailed
event that will be logged by Toaster as build failure.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 12cb419..84de06a 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1114,10 +1114,13 @@ class BBCooker:
 
         def buildFileIdle(server, rq, abort):
 
+            msg = None
             if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
+                msg = "Forced shutdown"
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
+                msg = "Stopped build"
             failures = 0
             try:
                 retval = rq.execute_runqueue()
@@ -1130,7 +1133,7 @@ class BBCooker:
 
             if not retval:
                 bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, item, failures), self.event_data)
-                self.command.finishAsyncCommand()
+                self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
                 return True
@@ -1144,10 +1147,13 @@ class BBCooker:
         """
 
         def buildTargetsIdle(server, rq, abort):
+            msg = None
             if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
+                msg = "Forced shutdown"
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
+                msg = "Stopped build"
             failures = 0
             try:
                 retval = rq.execute_runqueue()
@@ -1160,7 +1166,7 @@ class BBCooker:
 
             if not retval:
                 bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runq_fnid), buildname, targets, failures), self.data)
-                self.command.finishAsyncCommand()
+                self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
                 return True
diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 69c6474..92955f8 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -237,6 +237,13 @@ def main(server, eventHandler, params ):
             if isinstance(event, (bb.command.CommandCompleted,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
+                if (isinstance(event, bb.command.CommandFailed)):
+                    event.levelno = format.ERROR
+                    event.msg = event.error
+                    event.pathname = ""
+                    event.lineno = 0
+                    buildinfohelper.store_log_event(event)
+                    errors += 1
 
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
 
-- 
1.8.3.2


