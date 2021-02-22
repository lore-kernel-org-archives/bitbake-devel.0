Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web12.33461.1613992878410318637
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 03:21:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=OR4U0ybI;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id y7so54726207lji.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Feb 2021 03:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rt5vbO+UEq92Wy/pQnYh+ZkvI1vGfmE5AuNsDOvS0Cg=;
        b=OR4U0ybIRKHd4qHl69kmy+IgxTMKmC6hf9v2fXpxPpmctsAjXi/hlqNua/em+PZc6S
         uENXnBiylKTi84uRL4lOXGWeaC2hV6ZQ1s+mSIjoee+G+XcMf0LUWzxU+LlmcG4UivXn
         WPd5wiyGFGrsY/zHTOXHAvoT/0VvzjRCVsijyp9Wpy6b6JW9Rl3OIhTR+J+3msli7xtc
         U68xZCaox8kc5IkWtklxDefGgHgkOp5r5GiDSriDIGHOd/ladfHu6UjiDxCKfqIN7emH
         KNCixY2AN9upknUIX+SI2C3z7WtzVmcADMXcMkehIUSL+n41yu28vhjoJ+oU8UfsDajf
         AsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rt5vbO+UEq92Wy/pQnYh+ZkvI1vGfmE5AuNsDOvS0Cg=;
        b=NHWqjFlmdfp93uVAFutLGHwex9F+Ehy8LTJBFqDzMGvUQqplwN1ZrMBtPwI5A7FVXE
         P1fygoHrTiW6fKpxRIOzNqGzjoU3yUclZ92hKWd+gUFIM9aQi9ERKcQtMrw/5phhhOJW
         Tn0tXbJAHd3fXTBBQMZBRa5nd6lezCgnbpMiI8my/msqiCqCPShIBCXstdU8hJ9Gqcst
         gCDJzqu9EFNxvEwCe4TJZJWPbisVaNgE3Gw5HnvQJH9c61u3jwXNjggvE26rvLklTZ++
         z7EFqx7V2BSgvA3QiUAHvCdQCo5CtCzQJWaQ0bJPH23PLick3yDx1UNWEHL5Ivi+ye8T
         RB+g==
X-Gm-Message-State: AOAM530jpMth94N6D7gN4+KLe24Bj2Z2HR89IoxlcksQBVSQJku/iNsD
	lBbYuTSnP5+dskq7gMGRBwRCMaHqKCt04A==
X-Google-Smtp-Source: ABdhPJyTO1YQkD4QFJ6J8M3S60iadqvV9mJOh/D80Wuu4/2j9RUxtxE++2kU84ZL3JAB0NTxENrchA==
X-Received: by 2002:a19:810c:: with SMTP id c12mr14040697lfd.244.1613992876155;
        Mon, 22 Feb 2021 03:21:16 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id v2sm1006253lfd.111.2021.02.22.03.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 03:21:15 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>,
	Paulo Neves <ptsneves@gmail.com>,
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
	Wiktor Baura <wbaura@gmail.com>,
	Kamil Kwiek <kamil.kwiek@gmail.com>
Subject: [PATCH v2] runqueue: Print pseudo.log if fakeroot task failed
Date: Mon, 22 Feb 2021 12:24:00 +0100
Message-Id: <20210222112400.1961-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if pseudo fails we can only see the path to pseudo.log. If we
have no access to server and can only rely on bitbake log then debugging
becomes impossible. This printing needs to be added in runqueue level,
not inside task execution, because in some cases task fails with pseudo
abort really early and we don't even see any log.

In this change I'm adding pseudo log printing in every fakeroot task
failure that logged `mismatch`, `error` or `fatal` to logfile, because
we have no other way to communicate with pseudo if it failed or not.
Only lines from last pseudo server execution will be printed.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
Signed-off-by: Adrian Walag
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
Signed-off-by: Mikolaj Lasota <mikolaj.lasota@protonmail.com>
Signed-off-by: Wiktor Baura <wbaura@gmail.com>
Signed-off-by: Kamil Kwiek <kamil.kwiek@gmail.com>

--- v2 Pass taskfn in all start_fakeworker execution
---
 lib/bb/runqueue.py | 54 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 54ef245a..aa06d706 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1237,11 +1237,12 @@ class RunQueue:
         self.worker = {}
         self.fakeworker = {}
 
-    def _start_worker(self, mc, fakeroot = False, rqexec = None):
+    def _start_worker(self, mc, fakeroot = False, rqexec = None, taskfn=None):
         logger.debug("Starting bitbake-worker")
         magic = "decafbad"
         if self.cooker.configuration.profile:
             magic = "decafbadbad"
+        fakerootdir = None
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
@@ -1251,10 +1252,12 @@ class RunQueue:
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
             worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            if taskfn and taskfn in self.rqdata.dataCaches[mc].fakerootdirs:
+                fakerootdir = self.rqdata.dataCaches[mc].fakerootdirs[taskfn]
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec, fakerootdir=fakerootdir)
 
         workerdata = {
             "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
@@ -1305,9 +1308,9 @@ class RunQueue:
         for mc in self.rqdata.dataCaches:
             self.worker[mc] = self._start_worker(mc)
 
-    def start_fakeworker(self, rqexec, mc):
+    def start_fakeworker(self, rqexec, mc, taskfn=None):
         if not mc in self.fakeworker:
-            self.fakeworker[mc] = self._start_worker(mc, True, rqexec)
+            self.fakeworker[mc] = self._start_worker(mc, True, rqexec, taskfn=taskfn)
 
     def teardown_workers(self):
         self.teardown = True
@@ -1772,7 +1775,7 @@ class RunQueueExecute:
         self.sqdata = SQData()
         build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
-    def runqueue_process_waitpid(self, task, status):
+    def runqueue_process_waitpid(self, task, status, fakerootdir=None):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
         if task in self.build_stamps:
@@ -1787,7 +1790,7 @@ class RunQueueExecute:
             self.sq_live.remove(task)
         else:
             if status != 0:
-                self.task_fail(task, status)
+                self.task_fail(task, status, fakerootdir=fakerootdir)
             else:
                 self.task_complete(task)
         return True
@@ -1908,14 +1911,32 @@ class RunQueueExecute:
         self.task_completeoutright(task)
         self.runq_tasksrun.add(task)
 
-    def task_fail(self, task, exitcode):
+    def task_fail(self, task, exitcode, fakerootdir=None):
         """
         Called when a task has failed
         Updates the state engine with the failure
         """
         self.stats.taskFailed()
         self.failed_tids.append(task)
-        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq), self.cfgData)
+
+        pseudo_log = ""
+        if fakerootdir and os.path.exists(os.path.join(fakerootdir, "pseudo.log")):
+            with open(os.path.join(fakerootdir, "pseudo.log")) as pseudo_log_file:
+
+                pseudo_failed = False
+                for line in reversed(pseudo_log_file.readlines()):
+                    for pseudo_error in ['mismatch', 'error', 'fatal']:
+                        if pseudo_error in line.lower():
+                            pseudo_failed = True
+                    if 'doing new pid setup and server start' in line:
+                        break
+                    pseudo_log = line + pseudo_log
+
+            if not pseudo_failed:
+                pseudo_log = None
+
+        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq, pseudo_log=pseudo_log), self.cfgData)
+
         if self.rqdata.taskData[''].abort:
             self.rq.state = runQueueCleanUp
 
@@ -2050,7 +2071,7 @@ class RunQueueExecute:
             unihash = self.rqdata.get_task_unihash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
-                    self.rq.start_fakeworker(self, mc)
+                    self.rq.start_fakeworker(self, mc, taskfn=taskfn)
                 self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
@@ -2132,7 +2153,7 @@ class RunQueueExecute:
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
-                        self.rq.start_fakeworker(self, mc)
+                        self.rq.start_fakeworker(self, mc, taskfn=taskfn)
                     except OSError as exc:
                         logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
@@ -2876,12 +2897,16 @@ class runQueueTaskFailed(runQueueEvent):
     """
     Event notifying a task failed
     """
-    def __init__(self, task, stats, exitcode, rq):
+    def __init__(self, task, stats, exitcode, rq, pseudo_log=None):
         runQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
+        self.pseudo_log = pseudo_log
 
     def __str__(self):
-        return "Task (%s) failed with exit code '%s'" % (self.taskstring, self.exitcode)
+        if self.pseudo_log:
+            return "Task (%s) failed with exit code '%s' \nPseudo log:\n%s" % (self.taskstring, self.exitcode, self.pseudo_log)
+        else:
+            return "Task (%s) failed with exit code '%s'" % (self.taskstring, self.exitcode)
 
 class sceneQueueTaskFailed(sceneQueueEvent):
     """
@@ -2933,7 +2958,7 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d, rq, rqexec):
+    def __init__(self, pipein, pipeout, d, rq, rqexec, fakerootdir=None):
         self.input = pipein
         if pipeout:
             pipeout.close()
@@ -2942,6 +2967,7 @@ class runQueuePipe():
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
+        self.fakerootdir = fakerootdir
 
     def setrunqueueexec(self, rqexec):
         self.rqexec = rqexec
@@ -2987,7 +3013,7 @@ class runQueuePipe():
                     task, status = pickle.loads(self.queue[10:index])
                 except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
-                self.rqexec.runqueue_process_waitpid(task, status)
+                self.rqexec.runqueue_process_waitpid(task, status, fakerootdir=self.fakerootdir)
                 found = True
                 self.queue = self.queue[index+11:]
                 index = self.queue.find(b"</exitcode>")
-- 
2.30.1

