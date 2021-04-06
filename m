Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.9275.1617697879788721384
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Apr 2021 01:31:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e8T5Rw6V;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id b9so5345760wrs.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Apr 2021 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtiS9Z24/clxhFo8/63gTdxLSdKlmOsP0IMWr1hak9U=;
        b=e8T5Rw6VnSnbrAgMm8RBUjmGgV4YdloInGJzdWloHVunYo3WuXIyqIUx9DsPmpBCOU
         6jZNpit6FgPtqOC4xbFzkjkUIpIyzw/NesFMiqAVKCv+JeylEJm6sTVyhy+D7O0WT44h
         hBxIJgjHwrIQ4ADdEaR4bW2rYZpeaoF6VKjHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtiS9Z24/clxhFo8/63gTdxLSdKlmOsP0IMWr1hak9U=;
        b=f2bE4mSwKLkdwZanoTMdrFTi/AQPMkeiCDA+z/inoVgqMNzrk8He+OUC8CG/5cYLeb
         dgNnTL/n8pU8uqi1xrLeQqTBOctYzibMv4UrOfgA+i1d26eB0tvDv67AD/fEAyN5Y/IP
         ppmc8pQJpm1bcXkB2OPHmJNwTILSDhECtbd8hq2BQ1f17RIbt5oPL9M1hpqKNneVLZPk
         09f2ASrH1fwBZwe1FasYteFf5mTsiZ7QOcCR+YlI/M0UjBz1IwiZAAZev0PJGb1M6T0H
         X9Ab8ZDc2VJuC/5g4npzCnrDYJ0AI8mBXFlkn6BvTNJ2i1IsNqtAFOnhXQTK+gkd4iJk
         txVw==
X-Gm-Message-State: AOAM532HaghhtZhj6+m3costTNHsKQgUA0NCjGEz2+bcpn2C5bTJJGFL
	6VsVVFKC9+7ID1XoUX89WqUInxE0pIfk5A==
X-Google-Smtp-Source: ABdhPJyRyVeTMq/d1IadATI1F7rccpqmr05S6iv5maxdlhMrYU/rXW02DsFiZAMSNsbN0nCmo6vm3Q==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr32563959wrs.415.1617697878093;
        Tue, 06 Apr 2021 01:31:18 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:c23e:cb99:a254:f609])
        by smtp.gmail.com with ESMTPSA id j1sm1098223wrq.90.2021.04.06.01.31.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:31:17 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Further fixes for confused setscene tasks
Date: Tue,  6 Apr 2021 09:31:17 +0100
Message-Id: <20210406083117.985349-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is further evidence of tasks ending up being "covered" and "notcovered"
which shouldn't happen and is bad. The code that caused this problem last
time appears to have issues where stamps for tasks already exist.

Split out the setscene stamp checking code to a separate function and
use this when checking "hard dependencies" (like pseudo-native) so
that if the stamps exist and it will be "covered", it is not put on
the notcovered list.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 80d7f6ca6b..cd56a55472 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2457,6 +2457,9 @@ class RunQueueExecute:
                 if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
                     # dependency could be already processed, e.g. noexec setscene task
                     continue
+                noexec, stamppresent = check_setscene_stamps(dep, self.rqdata, self.rq, self.stampcache)
+                if noexec or stamppresent:
+                    continue
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
@@ -2795,6 +2798,26 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         event = bb.event.StaleSetSceneTasks(found[mc])
         bb.event.fire(event, cooker.databuilder.mcdata[mc])
 
+def check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=False):
+
+    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+
+    taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
+
+    if 'noexec' in taskdep and taskname in taskdep['noexec']:
+        bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
+        return True, False
+
+    if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
+        logger.debug2('Setscene stamp current for task %s', tid)
+        return False, True
+
+    if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
+        logger.debug2('Normal stamp current for task %s', tid)
+        return False, True
+
+    return False, False
+
 def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True):
 
     tocheck = set()
@@ -2805,24 +2828,14 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
         if tid in sqdata.valid:
             sqdata.valid.remove(tid)
 
-        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-
-        taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
+        noexec, stamppresent = check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=True)
 
-        if 'noexec' in taskdep and taskname in taskdep['noexec']:
+        if noexec:
             sqdata.noexec.add(tid)
             sqrq.sq_task_skip(tid)
-            bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
-            continue
-
-        if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
-            logger.debug2('Setscene stamp current for task %s', tid)
-            sqdata.stamppresent.add(tid)
-            sqrq.sq_task_skip(tid)
             continue
 
-        if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
-            logger.debug2('Normal stamp current for task %s', tid)
+        if stamppresent:
             sqdata.stamppresent.add(tid)
             sqrq.sq_task_skip(tid)
             continue
-- 
2.30.2

