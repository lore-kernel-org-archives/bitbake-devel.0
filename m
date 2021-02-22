Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.32511.1613986682331572989
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 01:38:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=YFBsR8tK;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id g1so50096938ljj.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Feb 2021 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZwJUkIjIKzpgKBSkpnoPT127T5k/mVq2WbsWcz/AGc=;
        b=YFBsR8tKyNV3c5jMx2IBTXStNYhVJBc43xoHDOfWrxhxVEeWQSV/bRRCogaMa/hgmH
         YM3i6Pq4XmLNzap/X611puvBomZ+m1XvXi2ikC3r6GXa9tU56pghuAW2JpysE/X5lDrN
         DaTHutgEBEmTaRCZqjQ2GeIhpw+t3t2qWBdS7rvHBuH8Rr1gL2wOrwrVStHLwE1NWqBb
         uvQxZoq254WeDaYNOz4MLwRg1ECRsIvDTOF3cmFk7U73FSsb627f3kLNKvfWS0fpSkcn
         Ps1ZMAEW6oVpYL1AmmeHNziE2PyJSizuDFAO3C3AGrxGb6SAiubdfcnDs5bzHR6wlYHz
         G/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LZwJUkIjIKzpgKBSkpnoPT127T5k/mVq2WbsWcz/AGc=;
        b=n06Mz45d55K4J5IR/Sz2heEVlRfcwQsg1Utsk+3MWFqkuEaQOzmm6EfBx9A+Pn0Sjw
         OhoU1M2yb7LgyINJdcdnmvlULetB12pf0w9xtgbDIdQAxma5k6r9RjBzfHzgXgxQ8FWR
         ZPSeI5cBc/syiafVLPs+zVN0sZCUztKIN4g9HbcfcinIZTXfA3PIVPSznA2Lp7+CP+aP
         aAMN8DaBSVvKaLp8icXY7yvZOEc2Pv03ol2WIcZMtnFB4LcUFkpG3PCBmLIG8RTVP9rE
         dcKnHEMaom+lnHnEBiJksZS153aRR7Hg4SFjEZMDIZ9KRpLeRqTrU8vtOwdqI8pATbm+
         XPiw==
X-Gm-Message-State: AOAM531gzPkCpz+E7811cMgyNxqWrcxdBHG31FtE20PVMteMGvag7KDZ
	8jCi4zZ9CauGW9rfD+skJvl5U+ICGTk=
X-Google-Smtp-Source: ABdhPJy0M459YpM1AacRxT0E5R2IuTkCDTmZp8Qmndyc8oAqPeZEgPhe3FzKmH7zFBF1RIMlE8OmlQ==
X-Received: by 2002:a2e:9b0e:: with SMTP id u14mr1387405lji.327.1613986680121;
        Mon, 22 Feb 2021 01:38:00 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id b16sm1866681lfs.101.2021.02.22.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:37:59 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>,
	Paulo Neves <ptsneves@gmail.com>,
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
	Wiktor Baura <wbaura@gmail.com>,
	Kamil Kwiek <kamil.kwiek@gmail.com>
Subject: [PATCH] runqueue: Print pseudo.log if fakeroot task failed
Date: Mon, 22 Feb 2021 10:40:19 +0100
Message-Id: <20210222094019.1671-1-tomasz.dziendzielski@gmail.com>
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
---
 lib/bb/runqueue.py | 52 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 54ef245a..ce09aecf 100644
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

