Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 86BFC6D2C7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2013 10:53:39 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 19 Nov 2013 02:53:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,728,1378882800"; d="scan'208";a="430134217"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2013 02:53:40 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 7272156069E; Tue, 19 Nov 2013 10:53:40 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Nov 2013 10:53:39 +0000
Message-Id: <1384858419-12869-2-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384858419-12869-1-git-send-email-alexandru.damian@intel.com>
References: <1384858419-12869-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toasterui: fix typo
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
X-List-Received-Date: Tue, 19 Nov 2013 10:53:40 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

A typo in buildinfo helper leads to a bug where
information about tasks is not correctly stored.

This patch fixes the typo.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 170ee12..2c9d77a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -543,7 +543,7 @@ class BuildInfoHelper(object):
             task_information['disk_io'] = task_build_stats['disk_io']
             del self.internal_state[identifier]
 
-        if isinstance(event, (bb.runqueue.runQueueTaskFailed, bb.runCommand.sceneQueueTaskFailed)):
+        if isinstance(event, (bb.runqueue.runQueueTaskFailed, bb.runqueue.sceneQueueTaskFailed)):
             task_information['outcome'] = Task.OUTCOME_FAILED
             del self.internal_state[identifier]
 
-- 
1.8.3.2


