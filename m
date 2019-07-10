Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	by mail.openembedded.org (Postfix) with ESMTP id 49B6E7F056
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:42 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id v19so3900518wmj.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=JL39eIyDDRHjo5fOQOH8d5i+iMxYRtxnoPXDim6TyWM=;
	b=O9/I2gy/JardXc1UT+C5win/4naZcb1GG3p7Ivq6kSDcRzYf/K4BGDJyRi/wKubYRJ
	3F6+7mPgmZU5a1Dg8KDId1uCmYRoG3/k76NdJkEnD89bwqq131xmuib6ex7XH3+xauht
	M2FjMaFoMThnpkdr1bhmUaSGXiYXvsaHyc5vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JL39eIyDDRHjo5fOQOH8d5i+iMxYRtxnoPXDim6TyWM=;
	b=dihawAH9O3tE8SPlRxFfE7GVzE6o/noELwK/cF+Amr9SxhfXT+vZYCXS2IulY1TkQx
	x5zj/6615FE3XAlqJGcfdOT2DsD6B9d7vtqDmvTo9WEuKTEBtXgeVF4mKJ4ofkGJOeoU
	LlUC/XMxmainT5P7T53bEWp8O9g1jksPV7uDWn1vtc5bktt5/aE3ayRjnl8+o+pCmEbj
	Gz7hxcKQY2o60+2uzCPdmOKMoFdY9qveAuWksR5gfV14+v4AWgDjsHY8PSgdkg3Fw0hY
	xpidq4mYwTKGGr7unUKBPV+EFodF+YZIkZwY1DU+zHlKaqapSBGYSjSSurywmTjR+Aaj
	qDig==
X-Gm-Message-State: APjAAAXCJelid+4KvL9czVE4RmdzSCR/unOLfuBg+DUjPhIDVdjyrxI0
	isPusITsFGVmh2r1TP4yJCnpNGPIi5Q=
X-Google-Smtp-Source: APXvYqzGA7ZvOj0HKeyXo+ckGb1tMhpn7AAetiPY6+/JoIUJLeyhBo8v/twnm+tz3MYg0nDL9lPbxA==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr293822wme.12.1562802882823;
	Wed, 10 Jul 2019 16:54:42 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.41
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:17 +0100
Message-Id: <20190710235420.23825-23-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 23/26] runqueue: Alter setscenewhitelist handling
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:42 -0000
Content-Transfer-Encoding: 8bit

Since there is now parallel execution of setscene and normal tasks, the way
setscenewhitelist handling worked can't function the way it did. Paul and I
never liked its error output anyway.

This code tries a different approach, checking the task at execution time
but printing the uncovered task list.

This code may need improvement after real world usage but can
work with the new task flows.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 78 +++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 49 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e4994f6c52..e7ba610723 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1681,49 +1681,6 @@ class RunQueue:
                 output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
                 bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
 
-def process_setscene_whitelist(rq, rqdata, stampcache, sched, rqex):
-    # Check tasks that are going to run against the whitelist
-    def check_norun_task(tid, showerror=False):
-        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-        # Ignore covered tasks
-        if tid in rqex.tasks_covered:
-            return False
-        # Ignore stamped tasks
-        if rq.check_stamp_task(tid, taskname, cache=stampcache):
-            return False
-        # Ignore noexec tasks
-        taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
-        if 'noexec' in taskdep and taskname in taskdep['noexec']:
-            return False
-
-        pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
-        if not check_setscene_enforce_whitelist(pn, taskname, rqdata.setscenewhitelist):
-            if showerror:
-                if tid in rqdata.runq_setscene_tids:
-                    logger.error('Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname))
-                else:
-                    logger.error('Task %s.%s attempted to execute unexpectedly' % (pn, taskname))
-            return True
-        return False
-    # Look to see if any tasks that we think shouldn't run are going to
-    unexpected = False
-    for tid in rqdata.runtaskentries:
-        if check_norun_task(tid):
-            unexpected = True
-            break
-    if unexpected:
-        # Run through the tasks in the rough order they'd have executed and print errors
-        # (since the order can be useful - usually missing sstate for the last few tasks
-        # is the cause of the problem)
-        task = sched.next()
-        while task is not None:
-            check_norun_task(task, showerror=True)
-            rqex.task_skip(task, 'Setscene enforcement check')
-            task = sched.next()
-
-        rq.state = runQueueCleanUp
-        return True
-
 
 class RunQueueExecute:
 
@@ -1944,12 +1901,6 @@ class RunQueueExecute:
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        if self.rqdata.setscenewhitelist is not None and not self.rqdata.setscenewhitelist_checked:
-            self.rqdata.setscenewhitelist_checked = True
-
-            if process_setscenewhitelist(self.rq, self.rqdata, self.stampcache, self.sched, self):
-                return True
-
         if self.cooker.configuration.setsceneonly:
             return True
 
@@ -1963,6 +1914,11 @@ class RunQueueExecute:
         if task is not None:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
 
+            if self.rqdata.setscenewhitelist is not None:
+                if self.check_setscenewhitelist(task):
+                    self.task_fail(task, "setscene whitelist")
+                    return True
+
             if task in self.tasks_covered:
                 logger.debug(2, "Setscene covered task %s", task)
                 self.task_skip(task, "covered")
@@ -2357,6 +2313,30 @@ class RunQueueExecute:
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
+    def check_setscenewhitelist(self, tid):
+        # Check task that is going to run against the whitelist
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+        # Ignore covered tasks
+        if tid in self.tasks_covered:
+            return False
+        # Ignore stamped tasks
+        if self.rq.check_stamp_task(tid, taskname, cache=self.stampcache):
+            return False
+        # Ignore noexec tasks
+        taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+        if 'noexec' in taskdep and taskname in taskdep['noexec']:
+            return False
+
+        pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
+        if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
+            if tid in self.rqdata.runq_setscene_tids:
+                msg = 'Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname)
+            else:
+                msg = 'Task %s.%s attempted to execute unexpectedly' % (pn, taskname)
+            logger.error(msg + '\nThis is usually due to missing setscene tasks. Those missing in this build were: %s' % pprint.pformat(self.scenequeue_notcovered))
+            return True
+        return False
+
 class SQData(object):
     def __init__(self):
         self.sq_harddeps = {}
-- 
2.20.1


