Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.111.1631794508564024252
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 05:15:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DPm4ailw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id d21so9099207wra.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 05:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0LV5CRhgZELpbqYd94YJBioxAh1RZ9BIeE3ix3p7jg=;
        b=DPm4ailw4WI/AJ0vOGs794ua6p+UOVPKFjz5rl+7GFO8P/84ms04ilAVffpPy3Svmf
         R5Cct1kJzVtNh3wI+AUKyS9iKXYUOAbq+9qW0Iy5zETflQIzBnC0fdL8GV1CjPi9CJHx
         /HkGfBrfamrv+XnNCjvu3bqSN8XqrL+Wh3g2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0LV5CRhgZELpbqYd94YJBioxAh1RZ9BIeE3ix3p7jg=;
        b=lyLTKm+7lGyrJB2FcTjJm14Y2zd7PBPXnsUJQ3JdwQtSA93uJYlgEVPjPPx+kaXA4O
         BmIcHNzweXqnPzOdvMz/sLrevG7xxxPIHV0RIQafhyarJNMxZwfPWBER55SP+6C2y3bF
         ZNrVcr/W5zK50xy3v+G5QOj/8YqitH+NFZlv22uslYC7vCwxnItofwcwlWps+wYo8qCt
         f5Xv98enW/4HPm3JNRORf+SwxRVzNLZijUDFHfqbSSCi9IGszn9SYxU99W9lliwzMJMB
         jiEMA8cZ5q49xYMmfTac7DaaLge/+rIk46RC0RqBfdUR9v2sccUZKY9IGVnzboeo1LUZ
         QlNQ==
X-Gm-Message-State: AOAM533GpUxXI8ja5lWX3J1yjq4poLbMCrnCkQlN1F/VlpUc7Ni9vLgu
	7dKPBkJ8FU1yyscUFtOAkZ2q3Mg5H/b4tbA9
X-Google-Smtp-Source: ABdhPJxFV2IYTQYLr/PPVxeQLudt3+qjWWBuUKwCuECWdfZvMCA5qPocrNpj+lMWlERqRUA1aL1qFw==
X-Received: by 2002:adf:f2c4:: with SMTP id d4mr5840092wrp.434.1631794506692;
        Thu, 16 Sep 2021 05:15:06 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f11f:8fd1:42b2:e87c])
        by smtp.gmail.com with ESMTPSA id g1sm3265599wrr.2.2021.09.16.05.15.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:15:06 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue/knotty: Improve UI handling of setscene task counting
Date: Thu, 16 Sep 2021 13:15:05 +0100
Message-Id: <20210916121505.1445997-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent fixes to merge setscene and normal task accounting in runqueue
fixed some display issues but broke the task numbering of setscene tasks.

Add new accounting methods to the stats structure specifically designed
for setscene. This accounts for the fact that setscene tasks can rerun
multiple times in the build.

Then use the new data in the UI to correctly display the numbers the
user wants to see to understand progress.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py    | 21 ++++++++++++++++++---
 lib/bb/ui/knotty.py   |  2 +-
 lib/bb/ui/uihelper.py |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6ce0ce80f6..10511a09dc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -85,15 +85,19 @@ class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
     """
-    def __init__(self, total):
+    def __init__(self, total, setscene_total):
         self.completed = 0
         self.skipped = 0
         self.failed = 0
         self.active = 0
+        self.setscene_active = 0
+        self.setscene_covered = 0
+        self.setscene_notcovered = 0
+        self.setscene_total = setscene_total
         self.total = total
 
     def copy(self):
-        obj = self.__class__(self.total)
+        obj = self.__class__(self.total, self.setscene_total)
         obj.__dict__.update(self.__dict__)
         return obj
 
@@ -112,6 +116,13 @@ class RunQueueStats:
     def taskActive(self):
         self.active = self.active + 1
 
+    def updateCovered(self, covered, notcovered):
+        self.setscene_covered = covered
+        self.setscene_notcovered = notcovered
+
+    def updateActiveSetscene(self, active):
+        self.setscene_active = active
+
 # These values indicate the next step due to be run in the
 # runQueue state machine
 runQueuePrepare = 2
@@ -1735,7 +1746,7 @@ class RunQueueExecute:
         self.holdoff_need_update = True
         self.sqdone = False
 
-        self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
+        self.stats = RunQueueStats(len(self.rqdata.runtaskentries), len(self.rqdata.runq_setscene_tids))
 
         for mc in rq.worker:
             rq.worker[mc].pipe.setrunqueueexec(self)
@@ -1786,6 +1797,7 @@ class RunQueueExecute:
             else:
                 self.sq_task_complete(task)
             self.sq_live.remove(task)
+            self.stats.updateActiveSetscene(len(self.sq_live))
         else:
             if status != 0:
                 self.task_fail(task, status, fakerootlog=fakerootlog)
@@ -2087,6 +2099,7 @@ class RunQueueExecute:
             self.build_stamps2.append(self.build_stamps[task])
             self.sq_running.add(task)
             self.sq_live.add(task)
+            self.stats.updateActiveSetscene(len(self.sq_live))
             if self.can_start_task():
                 return True
 
@@ -2462,6 +2475,7 @@ class RunQueueExecute:
                 self.sq_task_failoutright(tid)
 
         if changed:
+            self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
             self.holdoff_need_update = True
 
     def scenequeue_updatecounters(self, task, fail=False):
@@ -2495,6 +2509,7 @@ class RunQueueExecute:
                         new.add(dep)
             next = new
 
+        self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
         self.holdoff_need_update = True
 
     def sq_task_completeoutright(self, task):
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 65ff2727dc..8df745d130 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -753,7 +753,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 continue
 
             if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
-                logger.info("Running setscene task %d of %d (%s)" % (event.stats.completed + event.stats.active + event.stats.failed + 1, event.stats.total, event.taskstring))
+                logger.info("Running setscene task %d of %d (%s)" % (event.stats.setscene_covered + event.stats.setscene_active + event.stats.setscene_notcovered + 1, event.stats.setscene_total, event.taskstring))
                 continue
 
             if isinstance(event, bb.runqueue.runQueueTaskStarted):
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 40c7c5a5ef..52fdae3fec 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -50,7 +50,7 @@ class BBUIHelper:
             removetid(event.pid, tid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
         elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
-            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
+            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + event.stats.setscene_active + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskProgress):
-- 
2.32.0

