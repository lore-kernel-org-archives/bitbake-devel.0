Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 0112D6011A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Nov 2015 16:48:03 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 17 Nov 2015 08:48:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,308,1444719600"; d="scan'208";a="840703207"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.28.119])
	by fmsmga001.fm.intel.com with ESMTP; 17 Nov 2015 08:48:04 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Nov 2015 16:47:56 +0000
Message-Id: <1447778876-12207-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: toasterui Add ParseStarted/ParseProgress events to mask
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
X-List-Received-Date: Tue, 17 Nov 2015 16:48:04 -0000

From: brian avery <avery.brian@gmail.com>

Toaster is not able to see ParseStarted and ParseProgress events
for command-line builds. This means it's not possible for Toaster
to detect failed builds, if the failure occurs at a point before
the BuildStarted event, as the build won't show up at all.

Add these events to the event mask, so that Toaster's toasterui
can detect and respond to them.

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/toasterui.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/toasterui.py b/bitbake/lib/bb/ui/toasterui.py
index 3d26150..cdfe7ae 100644
--- a/bitbake/lib/bb/ui/toasterui.py
+++ b/bitbake/lib/bb/ui/toasterui.py
@@ -92,6 +92,15 @@ def _close_build_log(build_log):
         build_log.close()
         logger.removeHandler(build_log)
 
+_evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
+              "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
+              "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
+              "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
+              "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
+              "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
+              "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
+              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent"]
+
 def main(server, eventHandler, params):
     # set to a logging.FileHandler instance when a build starts;
     # see _open_build_log()
@@ -115,6 +124,9 @@ def main(server, eventHandler, params):
     console.setFormatter(formatter)
     logger.addHandler(console)
     logger.setLevel(logging.INFO)
+    llevel, debug_domains = bb.msg.constructLogOptions()
+    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+
 
     # verify and warn
     build_history_enabled = True
@@ -182,8 +194,6 @@ def main(server, eventHandler, params):
                 continue
 
             if isinstance(event, bb.event.BuildStarted):
-                # command-line builds don't fire a ParseStarted event,
-                # so we have to start the log file for those on BuildStarted instead
                 if not (build_log and build_log_file_path):
                     build_log, build_log_file_path = _open_build_log(log_dir)
 
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


