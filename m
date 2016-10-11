Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 660BE71999
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Oct 2016 22:36:20 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 11 Oct 2016 15:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,479,1473145200"; d="scan'208";a="1063541455"
Received: from bitbang.jf.intel.com ([10.7.199.68])
	by orsmga002.jf.intel.com with ESMTP; 11 Oct 2016 15:36:22 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Oct 2016 15:36:19 -0700
Message-Id: <1476225379-11423-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] runqueue.py: Remove redundant whitelist checks
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
X-List-Received-Date: Tue, 11 Oct 2016 22:36:26 -0000

The whitelist checks for BB_SETSCENE_ENFORCE were running for every call
to execute(). Since the task list doesn't change for each call into
execute, the checks only need to be ran once.

[YOCTO #10369]

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1306263..84b2685 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -265,6 +265,7 @@ class RunQueueData:
         self.stampwhitelist = cfgData.getVar("BB_STAMP_WHITELIST", True) or ""
         self.multi_provider_whitelist = (cfgData.getVar("MULTI_PROVIDER_WHITELIST", True) or "").split()
         self.setscenewhitelist = get_setscene_enforce_whitelist(cfgData)
+        self.setscenewhitelist_checked = False
         self.init_progress_reporter = bb.progress.DummyMultiStageProcessProgressReporter()
 
         self.reset()
@@ -1701,7 +1702,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        if self.rqdata.setscenewhitelist:
+        if self.rqdata.setscenewhitelist and not self.rqdata.setscenewhitelist_checked:
+            self.rqdata.setscenewhitelist_checked = True
+
             # Check tasks that are going to run against the whitelist
             def check_norun_task(tid, showerror=False):
                 (mc, fn, taskname, _) = split_tid_mcfn(tid)
-- 
2.7.4


