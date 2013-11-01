Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 7DBBC6D383
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 09:13:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Nov 2013 02:14:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,615,1378882800"; d="scan'208";a="426339693"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2013 02:13:42 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 11:18:45 +0200
Message-Id: <1383297526-16557-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: populate error_msg when hob receives a CommandFailed event
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
X-List-Received-Date: Fri, 01 Nov 2013 09:13:58 -0000

When Hob receives a bb.command.CommandFailed event, it doesn't show any error,
because the error_msg is empty. If so, it is hard to detect the issue, because
Hob continues to run till it blocks because of an information gap.

[YOCTO #5097]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7854742..2a629e2 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -97,6 +97,7 @@ class HobHandler(gobject.GObject):
 
         self.server = server
         self.error_msg = ""
+        self.lastCommand = ""
         self.initcmd = None
         self.parsing = False
 
@@ -111,6 +112,7 @@ class HobHandler(gobject.GObject):
             self.generating = False
 
     def runCommand(self, commandline):
+        self.lastCommand = commandline[0]
         try:
             result, error = self.server.runCommand(commandline)
             if error:
@@ -252,6 +254,10 @@ class HobHandler(gobject.GObject):
             self.current_phase = None
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
+            if self.error_msg == "":
+                self.error_msg = "The command \"" + self.lastCommand
+                self.error_msg += "\" was sent to bitbake server but it failed. Please"
+                self.error_msg += " check the code executed by this command in bitbake."
             self.commands_async = []
             self.display_error()
         elif isinstance(event, (bb.event.ParseStarted,
-- 
1.7.9.5


