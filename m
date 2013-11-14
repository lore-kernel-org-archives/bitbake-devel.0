Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 3856E6D684
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 10:53:41 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 14 Nov 2013 02:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,699,1378882800"; d="scan'208";a="433318199"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2013 02:53:05 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 21DDB56051B; Thu, 14 Nov 2013 10:53:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 10:53:01 +0000
Message-Id: <1384426381-7869-6-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/5] toasterui: mark failed sceneQueue tasks as failed
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
X-List-Received-Date: Thu, 14 Nov 2013 10:53:41 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch addresses an issue where a failed sceneQueue task
entry was not updated on the Fail event. As a result, it
always showed the task as not-available.

    [YOCTO #5216]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 92d6bbe..38e89ec 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -537,7 +537,7 @@ class BuildInfoHelper(object):
             task_information['disk_io'] = task_build_stats['disk_io']
             del self.internal_state[identifier]
 
-        if isinstance(event, bb.runqueue.runQueueTaskFailed):
+        if isinstance(event, (bb.runqueue.runQueueTaskFailed, bb.runCommand.sceneQueueTaskFailed)):
             task_information['outcome'] = Task.OUTCOME_FAILED
             del self.internal_state[identifier]
 
-- 
1.8.3.2


