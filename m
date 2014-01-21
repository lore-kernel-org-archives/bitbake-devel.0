Return-Path: <irina.patru@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B19896E858
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Jan 2014 15:56:30 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 21 Jan 2014 07:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,696,1384329600"; d="scan'208";a="442320771"
Received: from irina-vostro-460.rb.intel.com ([10.237.105.140])
	by orsmga001.jf.intel.com with ESMTP; 21 Jan 2014 07:55:52 -0800
From: Irina Patru <irina.patru@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jan 2014 17:59:38 +0200
Message-Id: <1390319978-31756-4-git-send-email-irina.patru@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1390319978-31756-1-git-send-email-irina.patru@intel.com>
References: <y>
 <1390319978-31756-1-git-send-email-irina.patru@intel.com>
Subject: [PATCH 4/4] hob: don't display interruptions as fails
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
X-List-Received-Date: Tue, 21 Jan 2014 15:56:31 -0000

When Hob receives a bb.command.CommandFailed event, it should check if
it's a log kind of information.
"Forced shutdown" and "Stopped build" are messages that show when a build
is not complete, but Hob considered them error.

[HOB #5609]

Signed-off-by: Irina Patru <irina.patru@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index a3bd264..3792328 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -250,7 +250,8 @@ class HobHandler(gobject.GObject):
             self.current_phase = None
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
-            self.error_msg += event.error
+            if event.error not in ("Forced shutdown", "Stopped build"):
+                self.error_msg += event.error
             self.commands_async = []
             self.display_error()
         elif isinstance(event, (bb.event.ParseStarted,
-- 
1.7.9.5


