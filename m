Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.10654.1614944501687846863
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Mar 2021 03:41:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=MhnwHsl0;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id k9so3036661lfo.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Mar 2021 03:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz6RfxEJ0vz0cuKSnKSCIsP9oetZIU7fh6mihxEbqcE=;
        b=MhnwHsl0yI5gW7A/D3CBZiFz8Kg1d5tYzyYaQXnEOdAFbpYEX3fyAAE6mLnc6SD7nl
         vOy3lnAFnaCiahk+KBO6JdIcuBkyIATdVMCCgQU/Dj0hWoDzFD4EhvM3A9LmPDRxg+OL
         lUu0TkpKLcYBu+gQCzDh4tAYLlBJlHc8xCwR/GfwU1F2nBmRtJ9GOopwBqbcpuScoIGw
         gDYP5BbVjXLQTsd6NCnuDcGn7B3wKgDqIHLIxE647xJWhoWS6tEohkH8cc8QvTCxcDCJ
         9mqX/gcNpwswILIZKi+SagSBV7It9LOph4SihpJcr5z1lbsIFDJjTE8ab4uXAmUuxDnq
         ZPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oz6RfxEJ0vz0cuKSnKSCIsP9oetZIU7fh6mihxEbqcE=;
        b=Pc/IKZ4pSYYRgIVbkpraBJDtn4GI226OpPmWrmUuVZQpjrBExyvGqNMGH0z9O3goKm
         G3Q0SuY6Mmj5ANgNsKyT/thOCRerqiDekXVhoEQ7Eetn75awqUN4jRuA/lDd+kh9P57t
         lg7C6jsWICSbTl9C0LVDD7oqF+EFmcaGhErJO7M6rOJwZ9g4pzpHzWw2FTBVc7iaYi6b
         HwJNuqS6Owg7kl23HxzZGLdoM/ZJtMWxtDlIvu5F/3YtXdJXI2p1ac1JGCiT0ORuWTaA
         WeSXYuF8eSbFmFxWjDGuf6B6lxrHWc6J+de7JmDCCEG25GD0wbbQuKCScdFATFa5Xtlg
         9CkQ==
X-Gm-Message-State: AOAM530DTzkZ2EF4GOz3NaK7Aux3vODGsMOyrQSpt6c0OQaIMd9RPE+P
	MOintnK6XQewGfol+AC1w8L8weIQpOmtPQ==
X-Google-Smtp-Source: ABdhPJz1ITJNkIlm1A5I+vT7kURBlO/n1hEoxMVFx62x5lgg1KUQh4DyX+zvW497lwqbCACP4Qja8Q==
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr5107237lfu.593.1614944499480;
        Fri, 05 Mar 2021 03:41:39 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id b28sm275268lfo.219.2021.03.05.03.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 03:41:39 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Jan Brzezanski <jan.brzezanski@gmail.com>,
	Paulo Neves <ptsneves@gmail.com>,
	Mikolaj Lasota <mikolaj.lasota@protonmail.com>,
	Wiktor Baura <wbaura@gmail.com>,
	Kamil Kwiek <kamil.kwiek@gmail.com>
Subject: [PATCH v4] runqueue: Print pseudo.log if fakeroot task failed
Date: Fri,  5 Mar 2021 12:44:24 +0100
Message-Id: <20210305114424.10665-1-tomasz.dziendzielski@gmail.com>
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

--- v4 get taskfn and fakerootlog in runQueuePipe separately for every task, not for every fakeworker (per multiconfig) in RunQueue
---
 lib/bb/cache.py    |  3 +++
 lib/bb/runqueue.py | 46 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 40 insertions(+), 9 deletions(-)

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
index 54ef245a..945ac3c6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1242,6 +1242,7 @@ class RunQueue:
         magic = "decafbad"
         if self.cooker.configuration.profile:
             magic = "decafbadbad"
+        fakerootlogs = None
         if fakeroot:
             magic = magic + "beef"
             mcdata = self.cooker.databuilder.mcdata[mc]
@@ -1251,10 +1252,11 @@ class RunQueue:
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
             worker = subprocess.Popen(fakerootcmd + ["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            fakerootlogs = self.rqdata.dataCaches[mc].fakerootlogs
         else:
             worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec, fakerootlogs=fakerootlogs)
 
         workerdata = {
             "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
@@ -1772,7 +1774,7 @@ class RunQueueExecute:
         self.sqdata = SQData()
         build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
-    def runqueue_process_waitpid(self, task, status):
+    def runqueue_process_waitpid(self, task, status, fakerootlog=None):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
         if task in self.build_stamps:
@@ -1787,7 +1789,7 @@ class RunQueueExecute:
             self.sq_live.remove(task)
         else:
             if status != 0:
-                self.task_fail(task, status)
+                self.task_fail(task, status, fakerootlog=fakerootlog)
             else:
                 self.task_complete(task)
         return True
@@ -1908,14 +1910,31 @@ class RunQueueExecute:
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
 
@@ -2876,12 +2895,16 @@ class runQueueTaskFailed(runQueueEvent):
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
@@ -2933,7 +2956,7 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d, rq, rqexec):
+    def __init__(self, pipein, pipeout, d, rq, rqexec, fakerootlogs=None):
         self.input = pipein
         if pipeout:
             pipeout.close()
@@ -2942,6 +2965,7 @@ class runQueuePipe():
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
+        self.fakerootlogs = fakerootlogs
 
     def setrunqueueexec(self, rqexec):
         self.rqexec = rqexec
@@ -2987,7 +3011,11 @@ class runQueuePipe():
                     task, status = pickle.loads(self.queue[10:index])
                 except (ValueError, pickle.UnpicklingError, AttributeError, IndexError) as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
-                self.rqexec.runqueue_process_waitpid(task, status)
+                (_, _, _, taskfn) = split_tid_mcfn(task)
+                fakerootlog = None
+                if self.fakerootlogs and taskfn and taskfn in self.fakerootlogs:
+                    fakerootlog = self.fakerootlogs[taskfn]
+                self.rqexec.runqueue_process_waitpid(task, status, fakerootlog=fakerootlog)
                 found = True
                 self.queue = self.queue[index+11:]
                 index = self.queue.find(b"</exitcode>")
-- 
2.30.1

