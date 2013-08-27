Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2AB766BB3D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 07:18:19 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Aug 2013 00:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,966,1367996400"; d="scan'208";a="369016283"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 27 Aug 2013 00:18:18 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Aug 2013 10:21:38 +0300
Message-Id: <1377588098-2149-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: add event handlers filtering in Hob
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
X-List-Received-Date: Tue, 27 Aug 2013 07:18:19 -0000

Create the _evt_list for hob; it is longer than the knotty
uses because it handles more events.
Whithout it, Hob is not passing the sanity checks, because the
handler for this event is not running.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/hob.py |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 2c75cb8..bc5ee14 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -58,6 +58,19 @@ def event_handle_idle_func(eventHandler, hobHandler):
         event = eventHandler.getEvent()
     return True
 
+_evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
+              "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
+              "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
+              "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
+              "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
+              "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
+              "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
+              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
+              "bb.event.SanityCheckPassed", "bb.event.SanityCheckFailed", "bb.event.PackageInfo",
+              "bb.event.TargetsTreeGenerated", "bb.event.ConfigFilesFound", "bb.event.ConfigFilePathFound",
+              "bb.event.FilesMatchingFound", "bb.event.NetworkTestFailed", "bb.event.NetworkTestPassed",
+              "bb.event.BuildStarted", "bb.event.BuildCompleted", "bb.event.DiskFull"]
+
 def main (server, eventHandler, params):
     params.updateFromServer(server)
     gobject.threads_init()
@@ -68,6 +81,8 @@ def main (server, eventHandler, params):
     recipe_model = RecipeListModel()
     package_model = PackageListModel()
 
+    llevel, debug_domains = bb.msg.constructLogOptions()
+    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
     hobHandler = HobHandler(server, recipe_model, package_model)
     builder = Builder(hobHandler, recipe_model, package_model)
 
-- 
1.7.9.5


