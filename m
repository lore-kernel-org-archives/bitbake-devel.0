Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id F199A6A5AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Sep 2013 15:48:04 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 10 Sep 2013 08:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,879,1371106800"; d="scan'208";a="376107140"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 10 Sep 2013 08:48:04 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 24C425606CA; Tue, 10 Sep 2013 16:48:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Tue, 10 Sep 2013 16:48:01 +0100
Message-Id: <1378828081-22646-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] bitbake: cooker: clear up state on stateShutdown command
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
X-List-Received-Date: Tue, 10 Sep 2013 15:48:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

On resident bitbake server, a stateShutdown command (first
Ctrl-C in client) will leave the server in an unusable state.

This patch forces the server to reload data and begin
processing commands again, coping correctly with Ctrl-C commands.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index c3721aa..42eec2c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1101,6 +1101,7 @@ class BBCooker:
                 rq.finish_runqueue(True)
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
+                self.state = state.initial
             failures = 0
             try:
                 retval = rq.execute_runqueue()
@@ -1191,7 +1192,7 @@ class BBCooker:
         if self.state == state.running:
             return
 
-        if self.state in (state.shutdown, state.stop):
+        if self.state == state.stop:
             self.parser.shutdown(clean=False, force = True)
             sys.exit(1)
 
-- 
1.8.1.2


