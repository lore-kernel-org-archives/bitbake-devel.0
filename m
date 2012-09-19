Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TEHfs-0003BB-48
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Sep 2012 12:38:32 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Sep 2012 03:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,447,1344236400"; d="scan'208";a="223991587"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.228])
	by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2012 03:25:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Sep 2012 11:25:42 +0100
Message-Id: <1348050342-5402-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: report event handler failures
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Sep 2012 10:38:32 -0000

If an event handler failed we were not recieving an error message -
parsing just "froze" at 99%. This is because we were expecting a
CommandFailure event and this never happened in the case of
RequestPackageInfo which is where the failure was occurring.

This also required tweaking the error formatting slightly, taking the
return value of the format function rather than the message property
since the latter only seems to contain the first line without the
traceback in the case of event handler failure. Other error cases were
tested and their message formatting is unaffected by this change.

Final part of the fix for [YOCTO #2651].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 35cbded..8fc1732 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -156,6 +156,13 @@ class HobHandler(gobject.GObject):
                 targets.append(self.toolchain)
             self.runCommand(["buildTargets", targets, self.default_task])
 
+    def display_error(self):
+        self.clear_busy()
+        self.emit("command-failed", self.error_msg)
+        self.error_msg = ""
+        if self.building:
+            self.building = False
+
     def handle_event(self, event):
         if not event:
             return
@@ -178,8 +185,8 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, logging.LogRecord):
             if event.levelno >= logging.ERROR:
                 formatter = bb.msg.BBLogFormatter()
-                formatter.format(event)
-                self.error_msg += event.message + '\n'
+                msg = formatter.format(event)
+                self.error_msg += msg + '\n'
 
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.current_phase = "data generation"
@@ -211,11 +218,7 @@ class HobHandler(gobject.GObject):
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
             self.commands_async = []
-            self.clear_busy()
-            self.emit("command-failed", self.error_msg)
-            self.error_msg = ""
-            if self.building:
-                self.building = False
+            self.display_error()
         elif isinstance(event, (bb.event.ParseStarted,
                  bb.event.CacheLoadStarted,
                  bb.event.TreeDataPreparationStarted,
@@ -245,6 +248,9 @@ class HobHandler(gobject.GObject):
             message["title"] = "Parsing recipes: "
             self.emit("parsing-completed", message)
 
+        if self.error_msg and not self.commands_async:
+            self.display_error()
+
         return
 
     def init_cooker(self):
-- 
1.7.9.5



