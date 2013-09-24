Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id C5FE06CBC5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:20 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948548"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 184FA562700; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:28 +0100
Message-Id: <8922e5e78c371989836fe7a094d26295eb41833d.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 59/94] bitbake: dsi: clear up global variables between builds
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We're making sure that global variables that track
a build data get reset when the build ends.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/dsi.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index f72b1be..c139cd2 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -479,8 +479,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit)):
 
-                # we start a new build info
                 buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
+
+                # we start a new build info
+                errors = 0
+                warnings = 0
+                taskfailures = []
                 buildinfohelper = BuildInfoHelper(server, build_history_enabled)
                 buildinfohelper.store_layer_info()
                 continue
-- 
1.8.1.2


