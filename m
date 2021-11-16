Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80ECC433F5
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:55 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.5172.1637033566840862534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:54 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369181"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369181"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:54 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232257"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:53 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 7/8] runqueue: Fix runall option task deletion ordering
 issue
Date: Tue, 16 Nov 2021 11:32:36 +0800
Message-Id: 
 <44574295d54ec9e48c9ecdd4eb869c4494e77679.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13055

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The runbuild option handling in runqueue was flawed as items deleted from the
main task list may be dependencies and hence cause index errors.

Rather than modify runtaskentries straight away, compute a new shorted list
and use that as an input to the second phase. This avoids the need to add tasks
back to the list meaning delcount can be simplifed to a simple counter.

The second use case in runonly doen't re-add items so doesn't have this
issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3428e3c54eb5cc03ff96f9cee6dc839afee7a419)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 10511a09..3300bb4f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -926,38 +926,35 @@ class RunQueueData:
         #
         # Once all active tasks are marked, prune the ones we don't need.
 
-        delcount = {}
-        for tid in list(self.runtaskentries.keys()):
-            if tid not in runq_build:
-                delcount[tid] = self.runtaskentries[tid]
-                del self.runtaskentries[tid]
-
         # Handle --runall
         if self.cooker.configuration.runall:
             # re-run the mark_active and then drop unused tasks from new list
-            runq_build = {}
+            reduced_tasklist = set(self.runtaskentries.keys())
+            for tid in list(self.runtaskentries.keys()):
+                if tid not in runq_build:
+                   reduced_tasklist.remove(tid)
 
             for task in self.cooker.configuration.runall:
                 if not task.startswith("do_"):
                     task = "do_{0}".format(task)
                 runall_tids = set()
-                for tid in list(self.runtaskentries):
+                for tid in reduced_tasklist:
                     wanttid = "{0}:{1}".format(fn_from_tid(tid), task)
-                    if wanttid in delcount:
-                        self.runtaskentries[wanttid] = delcount[wanttid]
                     if wanttid in self.runtaskentries:
                         runall_tids.add(wanttid)
 
                 for tid in list(runall_tids):
-                    mark_active(tid,1)
+                    mark_active(tid, 1)
                     if self.cooker.configuration.force:
                         invalidate_task(tid, False)
 
-            for tid in list(self.runtaskentries.keys()):
-                if tid not in runq_build:
-                    delcount[tid] = self.runtaskentries[tid]
-                    del self.runtaskentries[tid]
+        delcount = set()
+        for tid in list(self.runtaskentries.keys()):
+            if tid not in runq_build:
+                delcount.add(tid)
+                del self.runtaskentries[tid]
 
+        if self.cooker.configuration.runall:
             if len(self.runtaskentries) == 0:
                 bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the recipes of the taskgraphs of the targets %s" % (str(self.cooker.configuration.runall), str(self.targets)))
 
@@ -971,16 +968,16 @@ class RunQueueData:
             for task in self.cooker.configuration.runonly:
                 if not task.startswith("do_"):
                     task = "do_{0}".format(task)
-                runonly_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == task }
+                runonly_tids = [k for k in self.runtaskentries.keys() if taskname_from_tid(k) == task]
 
-                for tid in list(runonly_tids):
-                    mark_active(tid,1)
+                for tid in runonly_tids:
+                    mark_active(tid, 1)
                     if self.cooker.configuration.force:
                         invalidate_task(tid, False)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
-                    delcount[tid] = self.runtaskentries[tid]
+                    delcount.add(tid)
                     del self.runtaskentries[tid]
 
             if len(self.runtaskentries) == 0:
-- 
2.33.1


