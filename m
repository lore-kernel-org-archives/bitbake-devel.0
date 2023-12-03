Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B664C07E97
	for <webhook@archiver.kernel.org>; Sun,  3 Dec 2023 19:56:46 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.47271.1701633398801314972
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Dec 2023 11:56:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BhMqUX9o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso3064545f8f.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 03 Dec 2023 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701633397; x=1702238197; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihklWlhLOtsdCyqUKWjuqGHsf+z4C+Pl+C7OXuYvq4c=;
        b=BhMqUX9oNLhrTlEssS+CtosXBqQk5DeBbfS9G6c47MzVvzswvIEDZdah3bMjHpM2cC
         gvOzVZTbhNKfHce9ho3qQqvYVGgTofgutIozkHprrkqrs0t+5/XMPxqIz0HE77/Jd9Bx
         fslRFh/Og2ozc2q/g5HahK7vy4aQrUE8lVJec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701633397; x=1702238197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihklWlhLOtsdCyqUKWjuqGHsf+z4C+Pl+C7OXuYvq4c=;
        b=kQX0OwjJa56BaSrqLJiJs4FlO4/jiq9wCLguBbP8uB/RDtaLj8NARMoU1V7ZHii5jJ
         mucyTkseC55PrpZ14jOM1HU0N+fZZlAOub9O59+0DBoA/SOptnLMTS3h7MJbErgaeksV
         QALMI2PenKzwK2RMLtxFJh8Zlj4NhYB6bCK2/GJS+srHLR+/+47OCByRv2YHQbsUAuHQ
         cD//9EpStzF2fjH4LavyQdPF5kl04QTsFxcL+tdrUruPwSEOawEdxxp70uECjRx6RYsz
         +j8Q8wetSjcITiN2nxCBFOLgjjn5AbyvOuEE9b1mQK6zpdockvBzfQWlP7It9AoLlRE/
         f2Eg==
X-Gm-Message-State: AOJu0YxJlc9ERNS0DP2DQvhd2G+0m7DWXYPGxSFSHhMmFtM9HBEhrLQT
	6oBdwzskT4ngHt3L+IuW8hCfH/cyvQcWziFbRLE=
X-Google-Smtp-Source: AGHT+IEa3cS+8+2CdIb1qvrh87aKHViicvicxl6uQGFS+nV2MqGNzEdUhR0aQA2Lfr3/XD4Gs7BTWw==
X-Received: by 2002:adf:ee41:0:b0:333:3117:c456 with SMTP id w1-20020adfee41000000b003333117c456mr1402952wro.231.1701633396705;
        Sun, 03 Dec 2023 11:56:36 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8764:964d:4cf8:1001])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b00332fd9b2b52sm4291032wrs.104.2023.12.03.11.56.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:56:36 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: Improve inter setscene task dependency handling
Date: Sun,  3 Dec 2023 19:56:35 +0000
Message-Id: <20231203195635.1157871-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 03 Dec 2023 19:56:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15605

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
 lib/bb/runqueue.py | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

v2 - fix bug when rehashing occurs causing build failures those tasks not executing

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 02d7ff9768..864708ee4a 100644
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
@@ -2596,8 +2612,8 @@ class RunQueueExecute:
         update_tasks2 = []
         for tid in update_tasks:
             harddepfail = False
-            for t in self.sqdata.sq_harddeps:
-                if tid in self.sqdata.sq_harddeps[t] and t in self.scenequeue_notcovered:
+            for t in self.sqdata.sq_harddeps_rev[tid]:
+                if t in self.scenequeue_notcovered:
                     harddepfail = True
                     break
             if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
@@ -2629,12 +2645,13 @@ class RunQueueExecute:
 
         if changed:
             self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
+            self.sq_needed_harddeps = set()
             self.holdoff_need_update = True
 
     def scenequeue_updatecounters(self, task, fail=False):
 
-        for dep in sorted(self.sqdata.sq_deps[task]):
-            if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+        if fail and task in self.sqdata.sq_harddeps:
+            for dep in sorted(self.sqdata.sq_harddeps[task]):
                 if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
                     # dependency could be already processed, e.g. noexec setscene task
                     continue
@@ -2644,6 +2661,7 @@ class RunQueueExecute:
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
+        for dep in sorted(self.sqdata.sq_deps[task]):
             if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
                 if dep not in self.sq_buildable:
                     self.sq_buildable.add(dep)
@@ -2780,6 +2798,7 @@ class SQData(object):
         self.sq_revdeps = {}
         # Injected inter-setscene task dependencies
         self.sq_harddeps = {}
+        self.sq_harddeps_rev = {}
         # Cache of stamp files so duplicates can't run in parallel
         self.stamps = {}
         # Setscene tasks directly depended upon by the build
@@ -2907,6 +2926,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
         idepends = rqdata.taskData[mc].taskentries[realtid].idepends
         sqdata.stamps[tid] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
 
+        sqdata.sq_harddeps_rev[tid] = set()
         for (depname, idependtask) in idepends:
 
             if depname not in rqdata.taskData[mc].build_targets:
@@ -2919,20 +2939,15 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
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


