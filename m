Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FADC4332F
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 15:29:34 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.19020.1668698973230291984
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Nov 2022 07:29:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ev4sOw22;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id g2so774519wrv.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq6A+mNPu9L50A4WdKEIaGdSCb5z4HyjEIZQS/Bws+M=;
        b=ev4sOw22PT+GvHaL6nxxEX/9Qx1WtZ+cNPhi3bh8ZBPWb1PjZC5ZyAQbbJemcJjb2u
         YcW8FPuf4R+d9Btx1ecTA1xNAd8WXmVyYwsEIWiopwHf+rGbQAtaByOsYODZt26cpcdq
         Qd35c972H9RDKO/mgd2gSKqWu9Y1XAHZSTzK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jq6A+mNPu9L50A4WdKEIaGdSCb5z4HyjEIZQS/Bws+M=;
        b=e2b6cJ8wGbb+o/43U8BS5ntA/G6OA28Cslsygxuud42tHLDu/QnI6YJHMvJDPnuAZk
         xwXbrXhizb11BZpBXB3T0FFITpQIb3w5m7is/F360X8TkQ668t6+WjT8MGEsb7o/3XWA
         0vjj6PlgrD6q6df+9QkNkyAxqFbvZLzdfROmn3Bs7jvj5TZDe3PUv39pY2I4NGfxj72T
         +73G+QB4/iECt/lMqwiXBpVdfzEkwArEpgpXKSbV3jawsDbynTETyusN86qJlY280z+u
         g2Z3IVEKFUey9hdv8/A+WWsoe3vmX144H7fawvkpIA6gYUdCWAMz3gEbaRJ5L9OjAjg8
         215Q==
X-Gm-Message-State: ANoB5pkedgIzbsZSUUqaB3o1IK/Pmt5E/tJTBMxpnV+Bf0epP1ykJZUJ
	t7bQgCHHUAaBy9T+HRme/wpaCfxP9BNdRw==
X-Google-Smtp-Source: AA0mqf4XKcW1e5TXLC8stMLZKrHaTUN1IF2QImmzJd767LVD8lMPJ4ONGk+hCxKUfKgNZz6g9Eknfw==
X-Received: by 2002:adf:f206:0:b0:236:698d:9c44 with SMTP id p6-20020adff206000000b00236698d9c44mr1791503wro.571.1668698970714;
        Thu, 17 Nov 2022 07:29:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:76d7:bdc9:5165:906c])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b00236695ff94fsm1254306wrt.34.2022.11.17.07.29.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:29:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] worker/runqueue: Reduce initial data transfer in workerdata
Date: Thu, 17 Nov 2022 15:29:27 +0000
Message-Id: <20221117152928.2738113-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117152928.2738113-1-richard.purdie@linuxfoundation.org>
References: <20221117152928.2738113-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 15:29:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14089

When setting up the worker we were transfering large amounts of data
which aren't needed until task execution time.

Defer the fakeroot and taskdeps data until they're needed for a specific
task. This will duplicate some information when executing different tasks
for a given recipe but as is is spread over the build run, it shouldn't
be an issue overall.

Also take the opportunity to clean up the silly length argument lists
that were being passed around at the expense of extra dictionary keys.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 32 +++++++++++++++++++---------
 lib/bb/runqueue.py | 52 ++++++++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index d54044f361..3799b170cb 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -145,7 +145,16 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, extraconfigdata, quieterrors=False, dry_run_exec=False):
+def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
+
+    fn = runtask['fn']
+    task = runtask['task']
+    taskname = runtask['taskname']
+    taskhash = runtask['taskhash']
+    unihash = runtask['unihash']
+    appends = runtask['appends']
+    taskdepdata = runtask['taskdepdata']
+    quieterrors = runtask['quieterrors']
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -157,8 +166,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
     uid = os.getuid()
     gid = os.getgid()
 
-
-    taskdep = workerdata["taskdeps"][fn]
+    taskdep = runtask['taskdep']
     if 'umask' in taskdep and taskname in taskdep['umask']:
         umask = taskdep['umask'][taskname]
     elif workerdata["umask"]:
@@ -170,24 +178,24 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
         except TypeError:
              pass
 
-    dry_run = cfg.dry_run or dry_run_exec
+    dry_run = cfg.dry_run or runtask['dry_run']
 
     # We can't use the fakeroot environment in a dry run as it possibly hasn't been built
     if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not dry_run:
         fakeroot = True
-        envvars = (workerdata["fakerootenv"][fn] or "").split()
+        envvars = (runtask['fakerootenv'] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
             os.environ[key] = value
             fakeenv[key] = value
 
-        fakedirs = (workerdata["fakerootdirs"][fn] or "").split()
+        fakedirs = (runtask['fakerootdirs'] or "").split()
         for p in fakedirs:
             bb.utils.mkdirhier(p)
         logger.debug2('Running %s:%s under fakeroot, fakedirs: %s' %
                         (fn, taskname, ', '.join(fakedirs)))
     else:
-        envvars = (workerdata["fakerootnoenv"][fn] or "").split()
+        envvars = (runtask['fakerootnoenv'] or "").split()
         for key, value in (var.split('=') for var in envvars):
             envbackup[key] = os.environ.get(key)
             os.environ[key] = value
@@ -474,11 +482,15 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, taskhash, unihash, quieterrors, appends, taskdepdata, dry_run_exec = pickle.loads(data)
-        workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
+        runtask = pickle.loads(data)
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, taskhash, unihash, appends, taskdepdata, self.extraconfigdata, quieterrors, dry_run_exec)
+        fn = runtask['fn']
+        task = runtask['task']
+        taskname = runtask['taskname']
+
+        workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.databuilder, self.workerdata, self.extraconfigdata, runtask)
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 437f4a185c..595a58883e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1311,10 +1311,6 @@ class RunQueue:
         workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec, fakerootlogs=fakerootlogs)
 
         workerdata = {
-            "taskdeps" : self.rqdata.dataCaches[mc].task_deps,
-            "fakerootenv" : self.rqdata.dataCaches[mc].fakerootenv,
-            "fakerootdirs" : self.rqdata.dataCaches[mc].fakerootdirs,
-            "fakerootnoenv" : self.rqdata.dataCaches[mc].fakerootnoenv,
             "sigdata" : bb.parse.siggen.get_taskdata(),
             "logdefaultlevel" : bb.msg.loggerDefaultLogLevel,
             "build_verbose_shell" : self.cooker.configuration.build_verbose_shell,
@@ -2139,18 +2135,30 @@ class RunQueueExecute:
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            taskdepdata = self.sq_build_taskdepdata(task)
-
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-            taskhash = self.rqdata.get_task_hash(task)
-            unihash = self.rqdata.get_task_unihash(task)
+            runtask = {
+                'fn' : taskfn,
+                'task' : task,
+                'taskname' : taskname,
+                'taskhash' : self.rqdata.get_task_hash(task),
+                'unihash' : self.rqdata.get_task_unihash(task),
+                'quieterrors' : True,
+                'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
+                'taskdepdata' : self.sq_build_taskdepdata(task),
+                'dry_run' : False,
+                'taskdep': taskdep,
+                'fakerootenv' : self.rqdata.dataCaches[mc].fakerootenv[taskfn],
+                'fakerootdirs' : self.rqdata.dataCaches[mc].fakerootdirs[taskfn],
+                'fakerootnoenv' : self.rqdata.dataCaches[mc].fakerootnoenv[taskfn]
+            }
+
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2220,11 +2228,23 @@ class RunQueueExecute:
                 startevent = runQueueTaskStarted(task, self.stats, self.rq)
                 bb.event.fire(startevent, self.cfgData)
 
-            taskdepdata = self.build_taskdepdata(task)
-
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-            taskhash = self.rqdata.get_task_hash(task)
-            unihash = self.rqdata.get_task_unihash(task)
+            runtask = {
+                'fn' : taskfn,
+                'task' : task,
+                'taskname' : taskname,
+                'taskhash' : self.rqdata.get_task_hash(task),
+                'unihash' : self.rqdata.get_task_unihash(task),
+                'quieterrors' : False,
+                'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
+                'taskdepdata' : self.build_taskdepdata(task),
+                'dry_run' : self.rqdata.setscene_enforce,
+                'taskdep': taskdep,
+                'fakerootenv' : self.rqdata.dataCaches[mc].fakerootenv[taskfn],
+                'fakerootdirs' : self.rqdata.dataCaches[mc].fakerootdirs[taskfn],
+                'fakerootnoenv' : self.rqdata.dataCaches[mc].fakerootnoenv[taskfn]
+            }
+
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not (self.cooker.configuration.dry_run or self.rqdata.setscene_enforce):
                 if not mc in self.rq.fakeworker:
                     try:
@@ -2234,10 +2254,10 @@ class RunQueueExecute:
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
-- 
2.34.1


