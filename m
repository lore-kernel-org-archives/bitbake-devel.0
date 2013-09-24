Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id CE9426CB83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:18 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,972,1371106800"; d="scan'208";a="364948488"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 24 Sep 2013 09:53:07 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id A4E975611A4; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:47 +0100
Message-Id: <07219c6e7020e80121f217666c951e75d27173d6.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 18/94] bitbake: buildinfohelper: clearing up task order
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:20 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Moved code around so that the task order is issued only
on creating new task method, and not on get information.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index f7f98d8..c743751 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -130,11 +130,12 @@ class ORMWrapper(object):
 
     def create_task_object(self, task_information):
         # This needs to be imported after we have configured the Django settings file
+        self.task_order += 1
         identifier = task_information['recipe'].name + task_information['task_name']
 
         task_object = Task.objects.get_or_create(
                                 build=task_information['build'],
-                                order=task_information['order'],
+                                order=self.task_order,
                                 task_executed=task_information['task_executed'],
                                 outcome=task_information['outcome'],
                                 sstate_checksum=task_information['sstate_checksum'],
-- 
1.8.1.2


