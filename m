Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 59AB9605BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Feb 2016 14:24:00 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 29 Feb 2016 06:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,520,1449561600"; d="scan'208";a="755234898"
Received: from dpatrice-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.133])
	by orsmga003.jf.intel.com with ESMTP; 29 Feb 2016 06:24:00 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Feb 2016 14:23:33 +0000
Message-Id: <1456755813-17315-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] cooker: pass exception to finishAsyncCommand
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
X-List-Received-Date: Mon, 29 Feb 2016 14:24:02 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

An invalid task causes bitbake to exit incorrectly, firing a
CommandCompleted event rather than a CommandFailed one. This
means that clients listening for CommandFailed events are
unable to detect the build failure even though one occurred.

Passing an exception string to finishAsyncCommand when a task
fails causes the CommandFailed event to be fired correctly.

[YOCTO #9087]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 96cefc7..3014697 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1349,7 +1349,7 @@ class BBCooker:
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
-                self.command.finishAsyncCommand()
+                self.command.finishAsyncCommand(str(exc))
                 return False
 
             if not retval:
@@ -1385,7 +1385,7 @@ class BBCooker:
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
-                self.command.finishAsyncCommand()
+                self.command.finishAsyncCommand(str(exc))
                 return False
 
             if not retval:
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


