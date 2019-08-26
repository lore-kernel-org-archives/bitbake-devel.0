Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 3CC187E97A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2019 21:27:23 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id x4so40883692iog.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2019 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ednbdbgHk3kTPlCffV77KaDP9+GG7tQwB09c8UQt4EI=;
	b=chbytiEJFWbP1XTKqkKJW6M2gG0SSKMItqU2UFA6g4dwtb2ILk4d5+6Z3IWH4vVmy8
	+DF0HurcCyHexQ/iESbLZsEFjgq7mBxq3rnosttnYx+K0zn5OlClWBXvjWxhE9jXCSLa
	6V8bTWKIj5cxiNe8B0y0moszXv7bcBvHcfIR/nEp9SdqNEc72CNIF1cX8hLZsDDKxVtg
	TJjjN1WMakrNk0EOV7yWv8kF+eoOm4gPy8RuiUAtfOt0NTmFeFXt2Ck9dysblt7I1q5/
	4dy3av+326+iOAeziBEG4P7xk+kCOEP4GV/t8JICqXFDXvF4+THBE5RnAAvEo0lCGlWt
	1KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ednbdbgHk3kTPlCffV77KaDP9+GG7tQwB09c8UQt4EI=;
	b=IKT+rK9eG+NTJYfmQqHjyEVCbVfXYD0rxacvwnIg6yz7o4/HzRz+xA2XeZUCfPbs23
	Af8XR5IFHjaOFuSEZQCrUtEfbye2rh3v0i8B7l4w13Vk3yzUIgXE0HnjPa/Ib6jAoQuY
	whIajGaiWaMubz6xbBeYM8hSur/KRG0kbgzN5/B4F/woCQ7JHZdKokNbEhtnOOycWqvl
	CmSHwiFNaVW8Kqb8iJKYaBYyk3d74e9cigRSpvsf9sH7QDGB7ARWH8vcEId0OO/uybOK
	C2nAfbyjPOrowlYG9lvPH7nY7hkYXGEE6Jev4BTBhCTnge1hz1mqkuMJS52Xv12V0Kdq
	ou/Q==
X-Gm-Message-State: APjAAAW7mZ5L/kQObNoJrLooI19noMKDMTK9bgfRbANHhHaansS7EoX9
	7tzGu01gfxRygZN6hPHnpLjXwwNi
X-Google-Smtp-Source: APXvYqzEkq96RbrLtlOJLK4KWJO6pGGMRyZ72VwjiShPh6UAdL56IwQwF/Rklk6gG32qwthPbMmpnQ==
X-Received: by 2002:a6b:6c09:: with SMTP id a9mr407186ioh.27.1566854843802;
	Mon, 26 Aug 2019 14:27:23 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z9sm17964095ior.79.2019.08.26.14.27.22
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 26 Aug 2019 14:27:23 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Aug 2019 16:27:20 -0500
Message-Id: <20190826212720.25980-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] bitbake: respect force flag in runall and runonly
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
X-List-Received-Date: Mon, 26 Aug 2019 21:27:23 -0000
Content-Transfer-Encoding: 8bit

Specifying the force flag will now cause runall and runonly to
invalidate the tasks before running them. This allows a --runall or
--runonly to force the tasks to run, even if they would have otherwise
been skipped, e.g.:

 bitbake -f --runall fetch

Will run all do_fetch tasks even if they wouldn't be necessary (for
example, skipped by setscene)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 4f69578e466..addb2bb82fd 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -849,6 +849,20 @@ class RunQueueData:
             for depend in depends:
                 mark_active(depend, depth+1)
 
+        def invalidate_task(tid, error_nostamp):
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            taskdep = self.dataCaches[mc].task_deps[taskfn]
+            if fn + ":" + taskname not in taskData[mc].taskentries:
+                logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
+            if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
+                if error_nostamp:
+                    bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
+                else:
+                    bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
+            else:
+                logger.verbose("Invalidate task %s, %s", taskname, fn)
+                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], taskfn)
+
         self.target_tids = []
         for (mc, target, task, fn) in self.targets:
 
@@ -917,6 +931,8 @@ class RunQueueData:
 
                 for tid in list(runall_tids):
                     mark_active(tid,1)
+                    if self.cooker.configuration.force:
+                        invalidate_task(tid, False)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
@@ -938,6 +954,8 @@ class RunQueueData:
 
                 for tid in list(runonly_tids):
                     mark_active(tid,1)
+                    if self.cooker.configuration.force:
+                        invalidate_task(tid, False)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
@@ -1114,20 +1132,6 @@ class RunQueueData:
                     continue
                 self.runq_setscene_tids.append(tid)
 
-        def invalidate_task(tid, error_nostamp):
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            taskdep = self.dataCaches[mc].task_deps[taskfn]
-            if fn + ":" + taskname not in taskData[mc].taskentries:
-                logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
-            if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
-                if error_nostamp:
-                    bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
-                else:
-                    bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
-            else:
-                logger.verbose("Invalidate task %s, %s", taskname, fn)
-                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], taskfn)
-
         self.init_progress_reporter.next_stage()
 
         # Invalidate task if force mode active
-- 
2.21.0


