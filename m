Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 5A32677047
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Sep 2016 08:26:45 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP; 15 Sep 2016 01:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,338,1470726000"; 
   d="scan'208";a="8842771"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga005.jf.intel.com with ESMTP; 15 Sep 2016 01:26:45 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 7E7F36A4080;
	Thu, 15 Sep 2016 01:26:21 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Sep 2016 11:26:28 +0300
Message-Id: <1473927988-11620-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1473926604.7207.71.camel@linuxfoundation.org>
References: <1473926604.7207.71.camel@linuxfoundation.org>
Subject: [PATCH v2] cooker: check if target contains task
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
X-List-Received-Date: Thu, 15 Sep 2016 08:26:47 -0000

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
index b7d7a7e..3fc96b1 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1421,7 +1421,8 @@ class BBCooker:
         if not task.startswith("do_"):
             task = "do_%s" % task
 
-        packages = ["%s:%s" % (target, task) for target in targets]
+        packages = [target if ':' in target else '%s:%s' % (target, task) for target in targets]
+
         bb.event.fire(bb.event.BuildInit(packages), self.expanded_data)
 
         taskdata, runlist = self.buildTaskData(targets, task, self.configuration.abort)
-- 
2.1.4


