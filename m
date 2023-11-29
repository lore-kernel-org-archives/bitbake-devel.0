Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB7C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 21:46:57 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.51786.1701294407284676926
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 13:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VFe5AtWJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so2022855e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701294405; x=1701899205; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmTNijtvehB0YjI4192gYV1yOTJ5DZRrjLvy/eJVA4E=;
        b=VFe5AtWJHmcILprHpZpoqLWyKLPiZa2YKiWiMc1bKdOtGj7zmbolHI5qWuySUwXzK2
         buwdivEivvZC03ydO4W3vLNYDTBBdTlnWAEved6WKXOxi1XPVwFmaz6T9MuMf/BHB5Ij
         ND+cwS3oyd08uc+jpjMXrc8LrXRnNW5K6WbdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294405; x=1701899205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmTNijtvehB0YjI4192gYV1yOTJ5DZRrjLvy/eJVA4E=;
        b=dfafafvxIawhm7UxZSb7DRIxrOvl/Lmoz6OYWmdKNJQjHDMQbm5LAHMdO6EaoUl/Rn
         QWgJpi3ZmMrr6kxEkIdOlc516G6YH53YTwkPa2jruwYvk2On3wudGzY4t2GKEqf9xLju
         YUIRtmyrpIS2SphV0Siqn8xdgz6D6IxSTjFnnkhq+KeIThC0e4AUsldhEwpWd+mrboiW
         RJ7IU7Zt3bw0ZHHNvOrltNGAq7puJO7zBzn0NfhvMb+QG0ih1hI0LvV+Y4p37gFxVmsu
         zEPVNF3u2/UZqTEQHtuuLdk22LAUhUlcFzbHTLXqUuGAwWLfWgr5lWiODpU0klPCtBbQ
         s9qg==
X-Gm-Message-State: AOJu0YxP4V1+Ud5l8x79ddFtRzG+vomIQytWJFHi2ofC0t/6Ts6HC3jV
	+7qrRwpbyPCSiA7C6Hm6PY4JBWBznrzoliawRK0=
X-Google-Smtp-Source: AGHT+IGVVYQ/5/IhliSc70evdnba0PjdPE3v5Z4k1tLjDdYwaqwop70yWj/4Qj2adpkc+zztIoUwtg==
X-Received: by 2002:a05:600c:4453:b0:40b:5464:b23d with SMTP id v19-20020a05600c445300b0040b5464b23dmr1939258wmn.37.1701294405361;
        Wed, 29 Nov 2023 13:46:45 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8ea1:d952:d81c:3bac])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b0040b4c59f133sm3523529wms.1.2023.11.29.13.46.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:46:44 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Improve inter setscene task dependency handling
Date: Wed, 29 Nov 2023 21:46:44 +0000
Message-Id: <20231129214644.536837-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 21:46:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15579

The way the code currently handles dependencies between setscene tasks is fairly
poor, basically by deleting chunks of dependencies and adding reversed dependency
relationships.

This was once the best way to handle things but now a lot of the surrounding code
has changed and this approach is suboptimal and can be improved.

This change firstly adds debug logging for "hard" setscene task dependencies since
previously the codepaths were missing from logs making them very hard to read.

The changes to the setscene dependency graph are removed entirely this these altered
graphs were a significant source of problems. Instead, if a hard dependency is run
into, we mark the hard dependency as buildable and defer the task until the hard
dependencies are met.

The code now also skips the check_dependencies() code for hard dependencies since
previously that code was having to list all possible hard dependencies. We don't
need to do that as we can safely assume hard dependencies are required.

With these changes to runqueue's behaviour, we stand some chance of being able to
fix other bugs in OE-Core related to useradd for example.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 02d7ff9768..8a5a2d2e9d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1813,6 +1813,7 @@ class RunQueueExecute:
         self.build_stamps2 = []
         self.failed_tids = []
         self.sq_deferred = {}
+        self.sq_needed_harddeps = set()
 
         self.stampcache = {}
 
@@ -2140,7 +2141,10 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
+                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
+                            nexttask not in self.sq_needed_harddeps and \
+                            self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
+                            self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
                             logger.debug2("Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
@@ -2148,6 +2152,18 @@ class RunQueueExecute:
                             if nexttask in self.sq_deferred:
                                 del self.sq_deferred[nexttask]
                             return True
+                    if nexttask in self.sqdata.sq_harddeps_rev and not self.sqdata.sq_harddeps_rev[nexttask].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                        logger.debug2("Deferring %s due to hard dependencies" % nexttask)
+                        updated = False
+                        for dep in self.sqdata.sq_harddeps_rev[nexttask]:
+                            if dep not in self.sq_needed_harddeps:
+                                logger.debug2("Enabling task %s as it is a hard dependency" % dep)
+                                self.sq_buildable.add(dep)
+                                self.sq_needed_harddeps.add(dep)
+                                updated = True
+                        if updated:
+                            return True
+                        continue
                     # If covered tasks are running, need to wait for them to complete
                     for t in self.sqdata.sq_covered_tasks[nexttask]:
                         if t in self.runq_running and t not in self.runq_complete:
@@ -2780,6 +2796,7 @@ class SQData(object):
         self.sq_revdeps = {}
         # Injected inter-setscene task dependencies
         self.sq_harddeps = {}
+        self.sq_harddeps_rev = {}
         # Cache of stamp files so duplicates can't run in parallel
         self.stamps = {}
         # Setscene tasks directly depended upon by the build
@@ -2907,6 +2924,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
         idepends = rqdata.taskData[mc].taskentries[realtid].idepends
         sqdata.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
 
+        sqdata.sq_harddeps_rev[tid] = set()
         for (depname, idependtask) in idepends:
 
             if depname not in rqdata.taskData[mc].build_targets:
@@ -2919,20 +2937,15 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
             if deptid not in rqdata.runtaskentries:
                 bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (realtid, depfn, idependtask))
 
+            logger.debug2("Adding hard setscene dependency %s for %s" % (deptid, tid))
+
             if not deptid in sqdata.sq_harddeps:
                 sqdata.sq_harddeps[deptid] = set()
             sqdata.sq_harddeps[deptid].add(tid)
-
-            sq_revdeps_squash[tid].add(deptid)
-            # Have to zero this to avoid circular dependencies
-            sq_revdeps_squash[deptid] = set()
+            sqdata.sq_harddeps_rev[tid].add(deptid)
 
     rqdata.init_progress_reporter.next_stage()
 
-    for task in sqdata.sq_harddeps:
-        for dep in sqdata.sq_harddeps[task]:
-            sq_revdeps_squash[dep].add(task)
-
     rqdata.init_progress_reporter.next_stage()
 
     #for tid in sq_revdeps_squash:
-- 
2.39.2


