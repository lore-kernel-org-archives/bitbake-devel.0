Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579B9C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 14:50:45 +0000 (UTC)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web12.13084.1636469435357316700
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 06:50:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="293287558"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="293287558"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800";
   d="scan'208";a="588760053"
Received: from chinboon-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.234.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2021 06:50:42 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 6/7] runqueue: Fix runall option task deletion ordering
 issue
Date: Tue,  9 Nov 2021 22:50:27 +0800
Message-Id: 
 <c9bf2b15605ad83d1b4fb988355add46a5b99816.1636469164.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636469164.git.anuj.mittal@intel.com>
References: <cover.1636469164.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 14:50:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12979

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
index 10511a09d..3300bb4f9 100644
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
2.31.1


