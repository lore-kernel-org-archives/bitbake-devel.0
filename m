Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1EE406CACE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:04 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="408442541"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2013 09:53:05 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8CA8056109B; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:39 +0100
Message-Id: <032d0e7c33869e6ce7d76ad334a2d355fd2ad8d5.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 10/94] bitbake: webhob: use buildcompleted event as the end of a build operation
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:04 -0000

From: Calin Dragomir <calinx.l.dragomir@intel.com>

The BuildCompleted event marks the end of a build, so the code will
use this timestamp for computing the duration of a build operation.

Signed-off-by: Calin Dragomir <calinx.l.dragomir@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/dsi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 54364ce..d5fe733 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -448,7 +448,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
-            if isinstance(event, (bb.command.CommandFailed, bb.command.CommandExit, bb.command.CommandCompleted, bb.cooker.CookerExit)):
+            if isinstance(event, bb.event.BuildCompleted):
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 main.shutdown = 2
 
-- 
1.8.1.2


