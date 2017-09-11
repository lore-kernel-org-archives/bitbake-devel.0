Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id AFF4C784B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Sep 2017 22:50:29 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Sep 2017 15:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,380,1500966000"; d="scan'208";a="150679286"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2017 15:50:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 10:49:53 +1200
Message-Id: <6e46d92224a7a4d668d507a9bf73cdb7206ba80c.1505170163.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1505170163.git.paul.eggleton@linux.intel.com>
References: <cover.1505170163.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] runqueue: fix BB_SETSCENE_ENFORCE with empty BB_SETSCENE_ENFORCE_WHITELIST
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
X-List-Received-Date: Mon, 11 Sep 2017 22:50:29 -0000

The whitelist shouldn't have to be populated in order for the
enforcement to work properly - check if the list is not None in order to
determine whether the functionality is enabled or not since that is how
the function that sets up the list behaves.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/runqueue.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6b3a0fc..ae12c25 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1834,7 +1834,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        if self.rqdata.setscenewhitelist and not self.rqdata.setscenewhitelist_checked:
+        if self.rqdata.setscenewhitelist is not None and not self.rqdata.setscenewhitelist_checked:
             self.rqdata.setscenewhitelist_checked = True
 
             # Check tasks that are going to run against the whitelist
@@ -2249,7 +2249,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.scenequeue_updatecounters(task)
 
     def check_taskfail(self, task):
-        if self.rqdata.setscenewhitelist:
+        if self.rqdata.setscenewhitelist is not None:
             realtask = task.split('_setscene')[0]
             (mc, fn, taskname, taskfn) = split_tid_mcfn(realtask)
             pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
@@ -2603,7 +2603,7 @@ def get_setscene_enforce_whitelist(d):
 
 def check_setscene_enforce_whitelist(pn, taskname, whitelist):
     import fnmatch
-    if whitelist:
+    if whitelist is not None:
         item = '%s:%s' % (pn, taskname)
         for whitelist_item in whitelist:
             if fnmatch.fnmatch(item, whitelist_item):
-- 
2.9.5


