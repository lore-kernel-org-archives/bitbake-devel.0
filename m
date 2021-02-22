Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web10.2860.1614026046835161220
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 12:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DTdijKHe;
 spf=pass (domain: gmail.com, ip: 209.85.208.182, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f182.google.com with SMTP id u4so60560405ljh.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Feb 2021 12:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVitNBKTYqjnG6eGa2kDbX3H4fvGCSGtALPel5var0k=;
        b=DTdijKHeqlJm2NTWHofiyzX2zclS/m9lP3yKlt6MbMjyrNlK3VmzIuL1sv3FqozUCW
         wy+7Yw2k+hjqfj0mlgMe0fDvXztaHPVZOr844Y0YE8ZuVmdD+iNxYbkka3TZh6I2jLUB
         G6bgDrJ25wDb8XLBoM84rotjkZfAJJttf4pG9laqkUXihcxMEn0w4Z7/hcasRczB3Gdc
         Y3f4JqpoeJ1kwcn4bQ5Ir8OSUr3oHXvX3TZ8NkcIemdKR+m1ePbgKJM5dnT0QwqCJdKj
         S55J4uLBxAwrfESgLJaLypIGZBzMp0mq69gcf3a42Nfpsj7CvMm8U/vhjcCdem3E4+3x
         emdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVitNBKTYqjnG6eGa2kDbX3H4fvGCSGtALPel5var0k=;
        b=UKFTyFiQnhTt0NKZxU5rwUv9q55kBPPRqfTdKbA4nBdJRR9PIjHhjWK3bek5hBQItq
         7DEkeSxRE/W0dBvN+ak6sYZVzvHwb8WsXqNkxxL0mT0eWObq74EqkdjLoyzgBhyNckw+
         usxy1owPrFOTtS6Abs+kr+jYSI8229+SdZYhdJJwHiF1Huxpj7Y1x5XK1+T2B8rs5CaP
         KBnKpN0Bqek1dWf8LP3ItL9iW1KoQIZz0kjznTSwm5lOL0kowVFCikVKNyGg4f5udcN2
         pf4i01ky6qLgjx+HG0uhE2qAgXFehw5TLgcY0g1iZqtTsswMAQq0Kiv544C1pAcrhPlV
         u9ew==
X-Gm-Message-State: AOAM532emmXq+x4r1eBqdNqbQP2Hjbe1Uqi/N90F9EYnBWczCZyjnzo1
	n1PB9KApxnJpSep6pilkFkyIbf8u0d4exA==
X-Google-Smtp-Source: ABdhPJwZm06ynXp6aI7suwTkak/vuoQK3hsMdPkag41CYTtCreFrExeDWLapJczHZV7Sc3N8J86xDg==
X-Received: by 2002:a2e:9e0b:: with SMTP id e11mr251913ljk.138.1614026044483;
        Mon, 22 Feb 2021 12:34:04 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id h15sm2147842lfj.230.2021.02.22.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:34:03 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: kergoth@gmail.com,
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>,
	Paulo Neves <ptsneves@gmail.com>,
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
	Wiktor Baura <wbaura@gmail.com>,
	Kamil Kwiek <kamil.kwiek@gmail.com>
Subject: [PATCH v3] runqueue: Print pseudo.log if fakeroot task failed
Date: Mon, 22 Feb 2021 21:36:30 +0100
Message-Id: <20210222203630.9686-1-tomasz.dziendzielski@gmail.com>
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

--- v3 use separate FAKEROOTLOGS variable with pseudo.log path from meta/conf/bitbake.conf, change var names from pseudo to fakeroot
---
 lib/bb/cache.py    |  3 +++
 lib/bb/runqueue.py | 53 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index aea2b8bc..27eb2717 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -126,6 +126,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.inherits         = self.getvar('__inherit_cache', metadata, expand=False)
         self.fakerootenv      = self.getvar('FAKEROOTENV', metadata)
         self.fakerootdirs     = self.getvar('FAKEROOTDIRS', metadata)
+        self.fakerootlogs     = self.getvar('FAKEROOTLOGS', metadata)
         self.fakerootnoenv    = self.getvar('FAKEROOTNOENV', metadata)
         self.extradepsfunc    = self.getvar('calculate_extra_depends', metadata)
 
@@ -163,6 +164,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootenv = {}
         cachedata.fakerootnoenv = {}
         cachedata.fakerootdirs = {}
+        cachedata.fakerootlogs = {}
         cachedata.extradepsfunc = {}
 
     def add_cacheData(self, cachedata, fn):
@@ -231,6 +233,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.fakerootenv[fn] = self.fakerootenv
         cachedata.fakerootnoenv[fn] = self.fakerootnoenv
         cachedata.fakerootdirs[fn] = self.fakerootdirs
+        cachedata.fakerootlogs[fn] = self.fakerootlogs
         cachedata.extradepsfunc[fn] = self.extradepsfunc
 
 def virtualfn2realfn(virtualfn):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 54ef245a..0e67253b 100644
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
+        fakerootlog = None
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
@@ -1251,10 +1252,12 @@ class RunQueue:
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
             worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            if taskfn and taskfn in self.rqdata.dataCaches[mc].fakerootlogs:
+                fakerootlog = self.rqdata.dataCaches[mc].fakerootlogs[taskfn]
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec, fakerootlog=fakerootlog)
 
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
+    def runqueue_process_waitpid(self, task, status, fakerootlog=None):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
         if task in self.build_stamps:
@@ -1787,7 +1790,7 @@ class RunQueueExecute:
             self.sq_live.remove(task)
         else:
             if status != 0:
-                self.task_fail(task, status)
+                self.task_fail(task, status, fakerootlog=fakerootlog)
             else:
                 self.task_complete(task)
         return True
@@ -1908,14 +1911,31 @@ class RunQueueExecute:
         self.task_completeoutright(task)
         self.runq_tasksrun.add(task)
 
-    def task_fail(self, task, exitcode):
+    def task_fail(self, task, exitcode, fakerootlog=None):
         """
         Called when a task has failed
         Updates the state engine with the failure
         """
         self.stats.taskFailed()
         self.failed_tids.append(task)
-        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq), self.cfgData)
+
+        fakeroot_log = ""
+        if fakerootlog and os.path.exists(fakerootlog):
+            with open(fakerootlog) as fakeroot_log_file:
+                fakeroot_failed = False
+                for line in reversed(fakeroot_log_file.readlines()):
+                    for fakeroot_error in ['mismatch', 'error', 'fatal']:
+                        if fakeroot_error in line.lower():
+                            fakeroot_failed = True
+                    if 'doing new pid setup and server start' in line:
+                        break
+                    fakeroot_log = line + fakeroot_log
+
+            if not fakeroot_failed:
+                fakeroot_log = None
+
+        bb.event.fire(runQueueTaskFailed(task, self.stats, exitcode, self.rq, fakeroot_log=fakeroot_log), self.cfgData)
+
         if self.rqdata.taskData[''].abort:
             self.rq.state = runQueueCleanUp
 
@@ -2050,7 +2070,7 @@ class RunQueueExecute:
             unihash = self.rqdata.get_task_unihash(task)
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
-                    self.rq.start_fakeworker(self, mc)
+                    self.rq.start_fakeworker(self, mc, taskfn=taskfn)
                 self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
@@ -2132,7 +2152,7 @@ class RunQueueExecute:
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
-                        self.rq.start_fakeworker(self, mc)
+                        self.rq.start_fakeworker(self, mc, taskfn=taskfn)
                     except OSError as exc:
                         logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
@@ -2876,12 +2896,16 @@ class runQueueTaskFailed(runQueueEvent):
     """
     Event notifying a task failed
     """
-    def __init__(self, task, stats, exitcode, rq):
+    def __init__(self, task, stats, exitcode, rq, fakeroot_log=None):
         runQueueEvent.__init__(self, task, stats, rq)
         self.exitcode = exitcode
+        self.fakeroot_log = fakeroot_log
 
     def __str__(self):
-        return "Task (%s) failed with exit code '%s'" % (self.taskstring, self.exitcode)
+        if self.fakeroot_log:
+            return "Task (%s) failed with exit code '%s' \nPseudo log:\n%s" % (self.taskstring, self.exitcode, self.fakeroot_log)
+        else:
+            return "Task (%s) failed with exit code '%s'" % (self.taskstring, self.exitcode)
 
 class sceneQueueTaskFailed(sceneQueueEvent):
     """
@@ -2933,7 +2957,7 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d, rq, rqexec):
+    def __init__(self, pipein, pipeout, d, rq, rqexec, fakerootlog=None):
         self.input = pipein
         if pipeout:
             pipeout.close()
@@ -2942,6 +2966,7 @@ class runQueuePipe():
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
+        self.fakerootlog = fakerootlog
 
     def setrunqueueexec(self, rqexec):
         self.rqexec = rqexec
@@ -2987,7 +3012,7 @@ class runQueuePipe():
                     task, status = pickle.loads(self.queue[10:index])
                 except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
-                self.rqexec.runqueue_process_waitpid(task, status)
+                self.rqexec.runqueue_process_waitpid(task, status, fakerootlog=self.fakerootlog)
                 found = True
                 self.queue = self.queue[index+11:]
                 index = self.queue.find(b"</exitcode>")
-- 
2.30.1

