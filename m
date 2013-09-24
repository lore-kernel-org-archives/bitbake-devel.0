Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 58D136CB37
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:11 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405745"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:12 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 0691F56239E; Tue, 24 Sep 2013 17:53:05 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:21 +0100
Message-Id: <da465ea855e97d7b81d7a14f0ff6bfa390d8542b.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 52/94] bitbake: dsi: update build object on command end
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We need to make the final update to the build object on
command completion, regardless of the status of the completion,
in order to avoid leaving builds in the "In Progress" state.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/dsi.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/ui/dsi.py b/bitbake/lib/bb/ui/dsi.py
index 98d225b..3e0b7ff 100644
--- a/bitbake/lib/bb/ui/dsi.py
+++ b/bitbake/lib/bb/ui/dsi.py
@@ -474,6 +474,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.command.CommandExit)):
 
                 # we start a new build info
+                buildinfohelper.update_build_information(event, errors, warnings, taskfailures)
                 buildinfohelper = BuildInfoHelper(server, build_history_enabled)
                 buildinfohelper.store_layer_info()
                 continue
-- 
1.8.1.2


