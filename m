Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 88D427F00E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:26 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id c2so1023858wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=RtFnC5zv9rZYqEh7SsHeMGVzoPw6OdDd7tMfpjH7qqw=;
	b=RGlPH8NzhS47U1Q2SN0eOaIW2WoA1zNMM4mEoez3hf9XoaSCFWs+Lcg1Vt9lQh/b/i
	C3qM683cpRZ6A9sSd+MLVvMUWJSfUWtUAabB7Iv126f0cyJBT9Z6Ah7CPV1dhHtjQx3i
	9m3GN4bqB5+aeKkiXxG8lRCHXLPwlOJkqXqcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=RtFnC5zv9rZYqEh7SsHeMGVzoPw6OdDd7tMfpjH7qqw=;
	b=ddswUx2x8HGyK9f9uTY+9I3nJe4fUCP8J7p7CIn+9tAU/Kiy5dbsuBCzbVyhu260er
	++RgeSnm69ppidfkcVlpjdWLrFHaYHaJV2sTBJheq1WjNYd9y0ISkg7aW3yvvEbYklUv
	fwG+jNm9WZjA1FPW7gSz/UgJWLefVQ3Gi/Bo+HSMId45GV5Y3e3p1eGJCy28qo1W9NrH
	wZUeuFMu5caKwCbM8ELiEZLXBpmSWzf5+mbLM6DJuA4ActNFEbX/pRuQeaJ2VGmG2eqT
	PB1MgvOoncs5lApGzI/75vfI1zHNuOJDqj6lBdfs7VHr2MCbtPjxAFK2+fLm2rgyq5eV
	/pfg==
X-Gm-Message-State: APjAAAWxXLU/45Sou/ythhlXkJ9YJHRiaIWmbU0NT6WqPN/aLb3WCdrk
	K39IPT4lbeIdpTZM2Uc0tUNcdT1YCIc=
X-Google-Smtp-Source: APXvYqwdarzridQcZ82Pb5wydSMIKB8cJAg6tXZi/TflXzQIrayZl4KNqQ+dSDu29BH86ohzctn6fg==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr232519wrt.295.1562802866925; 
	Wed, 10 Jul 2019 16:54:26 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:00 +0100
Message-Id: <20190710235420.23825-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 06/26] runqueue: Factor out the process_setscene_whitelist checks
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:26 -0000
Content-Transfer-Encoding: 8bit

For ease of refactoring, move this code to its own separate function
until it becomes clear what we should do with it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 85 ++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b6943f238f..b8b35ecabe 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1679,6 +1679,50 @@ class RunQueue:
                 output = bb.siggen.compare_sigfiles(latestmatch, match, recursecb)
                 bb.plain("\nTask %s:%s couldn't be used from the cache because:\n  We need hash %s, closest matching task was %s\n  " % (pn, taskname, h, prevh) + '\n  '.join(output))
 
+def process_setscene_whitelist(rq, rqdata, stampcache, sched, rqex):
+    # Check tasks that are going to run against the whitelist
+    def check_norun_task(tid, showerror=False):
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+        # Ignore covered tasks
+        if tid in rq.scenequeue_covered:
+            return False
+        # Ignore stamped tasks
+        if rq.check_stamp_task(tid, taskname, cache=stampcache):
+            return False
+        # Ignore noexec tasks
+        taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
+        if 'noexec' in taskdep and taskname in taskdep['noexec']:
+            return False
+
+        pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
+        if not check_setscene_enforce_whitelist(pn, taskname, rqdata.setscenewhitelist):
+            if showerror:
+                if tid in rqdata.runq_setscene_tids:
+                    logger.error('Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname))
+                else:
+                    logger.error('Task %s.%s attempted to execute unexpectedly' % (pn, taskname))
+            return True
+        return False
+    # Look to see if any tasks that we think shouldn't run are going to
+    unexpected = False
+    for tid in rqdata.runtaskentries:
+        if check_norun_task(tid):
+            unexpected = True
+            break
+    if unexpected:
+        # Run through the tasks in the rough order they'd have executed and print errors
+        # (since the order can be useful - usually missing sstate for the last few tasks
+        # is the cause of the problem)
+        task = sched.next()
+        while task is not None:
+            check_norun_task(task, showerror=True)
+            rqex.task_skip(task, 'Setscene enforcement check')
+            task = sched.next()
+
+        rq.state = runQueueCleanUp
+        return True
+
+
 class RunQueueExecute:
 
     def __init__(self, rq):
@@ -1920,46 +1964,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         if self.rqdata.setscenewhitelist is not None and not self.rqdata.setscenewhitelist_checked:
             self.rqdata.setscenewhitelist_checked = True
 
-            # Check tasks that are going to run against the whitelist
-            def check_norun_task(tid, showerror=False):
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-                # Ignore covered tasks
-                if tid in self.rq.scenequeue_covered:
-                    return False
-                # Ignore stamped tasks
-                if self.rq.check_stamp_task(tid, taskname, cache=self.stampcache):
-                    return False
-                # Ignore noexec tasks
-                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-                if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                    return False
-
-                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-                if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
-                    if showerror:
-                        if tid in self.rqdata.runq_setscene_tids:
-                            logger.error('Task %s.%s attempted to execute unexpectedly and should have been setscened' % (pn, taskname))
-                        else:
-                            logger.error('Task %s.%s attempted to execute unexpectedly' % (pn, taskname))
-                    return True
-                return False
-            # Look to see if any tasks that we think shouldn't run are going to
-            unexpected = False
-            for tid in self.rqdata.runtaskentries:
-                if check_norun_task(tid):
-                    unexpected = True
-                    break
-            if unexpected:
-                # Run through the tasks in the rough order they'd have executed and print errors
-                # (since the order can be useful - usually missing sstate for the last few tasks
-                # is the cause of the problem)
-                task = self.sched.next()
-                while task is not None:
-                    check_norun_task(task, showerror=True)
-                    self.task_skip(task, 'Setscene enforcement check')
-                    task = self.sched.next()
-
-                self.rq.state = runQueueCleanUp
+            if process_setscenewhitelist(self.rq, self.rqdata, self.stampcache, self.sched, self):
                 return True
 
         self.rq.read_workers()
-- 
2.20.1


