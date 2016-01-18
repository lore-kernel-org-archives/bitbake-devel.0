Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 8BEAE6FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 15:42:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 18 Jan 2016 07:42:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,312,1449561600"; d="scan'208";a="883962738"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2016 07:42:53 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id CA2962C8001
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jan 2016 08:30:48 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jan 2016 15:45:08 +0200
Message-Id: <f0a74ba9665026d3875ab5279150afd7d9297e52.1453124453.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1453124453.git.ed.bartosh@linux.intel.com>
References: <cover.1453124453.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/3] toaster: toasterui: listen for bb.event.MetadataEvent
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
X-List-Received-Date: Mon, 18 Jan 2016 15:42:54 -0000

From: Elliot Smith <elliot.smith@intel.com>

The event mask for toasterui doesn't include MetadataEvents.
This means that we're missing the ArtifactFileSize event
(among others), which is the one we use to populate the SDK
artifact table.

Add that event type to the toasterui event mask so we can
record SDK artifacts as they are created.

[YOCTO #7603]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/bb/ui/toasterui.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 0265df7..19be623 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -99,7 +99,8 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
               "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
-              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent"]
+              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
+              "bb.event.MetadataEvent"]
 
 def main(server, eventHandler, params):
     # set to a logging.FileHandler instance when a build starts;
-- 
2.1.4


