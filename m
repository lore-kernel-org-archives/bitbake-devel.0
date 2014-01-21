Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 817AE60DBB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 15:56:29 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jan 2014 07:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; d="scan'208";a="442320739"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by orsmga001.jf.intel.com with ESMTP; 21 Jan 2014 07:55:48 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jan 2014 17:59:35 +0200
Message-Id: <1390319978-31756-1-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
References: <y>
Subject: [PATCH 1/4] hob: change error_msg for CommandFailed event
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
X-List-Received-Date: Tue, 21 Jan 2014 15:56:29 -0000

When a bb.command.CommandFailed event is received by Hob, the error
message is stored inside event.error.
This information tells exactly why bitbake failed, so Hob should display
it instead of the current composed message.

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index b12f2d8..a3bd264 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -98,7 +98,6 @@ class HobHandler(gobject.GObject):
 
         self.server = server
         self.error_msg = ""
-        self.lastCommand = ""
         self.initcmd = None
         self.parsing = False
 
@@ -113,7 +112,6 @@ class HobHandler(gobject.GObject):
             self.generating = False
 
     def runCommand(self, commandline):
-        self.lastCommand = commandline[0]
         try:
             result, error = self.server.runCommand(commandline)
             if error:
@@ -252,10 +250,7 @@ class HobHandler(gobject.GObject):
             self.current_phase = None
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
-            if self.error_msg == "":
-                self.error_msg = "The command \"" + self.lastCommand
-                self.error_msg += "\" was sent to bitbake server but it failed. Please"
-                self.error_msg += " check the code executed by this command in bitbake."
+            self.error_msg += event.error
             self.commands_async = []
             self.display_error()
         elif isinstance(event, (bb.event.ParseStarted,
-- 
1.7.9.5


