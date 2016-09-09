Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id D427075D4B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Sep 2016 14:49:13 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga104.jf.intel.com with ESMTP; 09 Sep 2016 07:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,305,1470726000"; 
   d="scan'208";a="6568840"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga005.jf.intel.com with ESMTP; 09 Sep 2016 07:49:13 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 742EF6A4080;
	Fri,  9 Sep 2016 07:48:51 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Sep 2016 17:49:00 +0300
Message-Id: <1473432540-22120-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: check if target contains task
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
X-List-Received-Date: Fri, 09 Sep 2016 14:49:17 -0000

Task name was incorrectly added to the targets that already
contained :task suffix and fired with BuildInit event. This
caused Toaster to create incorrect Target objects and show
them in UI.

[YOCTO #10221]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b7d7a7e..2952f9e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1421,7 +1421,8 @@ class BBCooker:
         if not task.startswith("do_"):
             task = "do_%s" % task
 
-        packages = ["%s:%s" % (target, task) for target in targets]
+        packages = [target if ':' in target else '%s:%s' (target, task) for target in targets]
+
         bb.event.fire(bb.event.BuildInit(packages), self.expanded_data)
 
         taskdata, runlist = self.buildTaskData(targets, task, self.configuration.abort)
-- 
2.1.4


