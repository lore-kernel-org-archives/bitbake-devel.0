Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE22C433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 21:14:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.619.1636060497174857447
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 14:14:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iSAHMoom;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id d3so10628111wrh.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrNRPaKw/IGmzQ06wc0DULMKTf5khGdD7zkktlsgqZA=;
        b=iSAHMoomy4m11F8ccnK2iH6LlVigpzS5oYTc4+cURr9l4AwS9pgRTRTVNuwbwxGElu
         bRkCuUv60zPWX/IPXUVI3WCA1H5iNovkLB3p5a05vvW/tVc/35kX57q6424NafYNuxqE
         cR4Yndmu/fdSv/hSdIHgxJoPehFR7JV1E/CD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rrNRPaKw/IGmzQ06wc0DULMKTf5khGdD7zkktlsgqZA=;
        b=MX5zoHiDoMVHFHWJf1sIumQCWVB9L1lJ8qBvSR58mqa5pF4JEq3DsMOYu4JzRLM03Z
         I/cDHNbS3sfShlMOw3cP9rcxPkeN7ZSB5O31Pd6tEwHSgsEJjh+1D0exG1Gy5PO7qe5J
         XybE+26kqdXlgHcmYZWtdzAJTO1GWrSE0Af+Lj6yJKq/ZlkBDwYpsnFfly0Keem43NhT
         EA2Apv0PSbD+8y2E9o/3RjtMWjdRA2cOTgia5TQ2NRGM6sFyeXwV+u/t9lMG03SAL1HA
         xmg3f7nQJfR7w/PSjp4bZJcgUA/g+yoVZ7ua4h0wHQDauvBhbQfphOf8t8+UcixOrg11
         NuzA==
X-Gm-Message-State: AOAM531XpcHTJeq4GbC6VPhp6u39rIjcDCxyXIdPsrkhLl5VdO9KLuBB
	//1TUQN8+30Q/GVlG0/ev9XlQYTLepEh4Q==
X-Google-Smtp-Source: 
 ABdhPJxWkCQw5dWoeOO6HsUuweXYDnSiR/Ra/rHFadrsWQRsIwMEhaOBzJ2PG40S8Do6pRMvhmqCIQ==
X-Received: by 2002:a05:6000:1201:: with SMTP id
 e1mr56391195wrx.298.1636060495256;
        Thu, 04 Nov 2021 14:14:55 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:38e6:15ea:3134:28e5])
        by smtp.gmail.com with ESMTPSA id
 j38sm9644781wms.29.2021.11.04.14.14.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 14:14:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix runall option task deletion ordering issue
Date: Thu,  4 Nov 2021 21:14:54 +0000
Message-Id: <20211104211454.3632198-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 21:14:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12883

The runbuild option handling in runqueue was flawed as items deleted from the
main task list may be dependencies and hence cause index errors.

Rather than modify runtaskentries straight away, compute a new shorted list
and use that as an input to the second phase. This avoids the need to add tasks
back to the list meaning delcount can be simplifed to a simple counter.

The second use case in runonly doen't re-add items so doesn't have this
issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 774cdbca0b..7d4cbed775 100644
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
             if not self.runtaskentries:
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
 
             if not self.runtaskentries:
-- 
2.32.0


