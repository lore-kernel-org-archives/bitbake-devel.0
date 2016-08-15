Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 71CB6758DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 16:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGvvYP010681 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:58:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r3CdbYLizxpO for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:58:44 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGwdGA010708
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:58:40 +0100
Message-ID: <1471280319.20391.93.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 17:58:39 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Abstract worker functionality to an object/array
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
X-List-Received-Date: Mon, 15 Aug 2016 16:58:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

With the introduction of multi-config and the possibility of distributed
builds we need arrays of workers rather than the existing two.

This refactors the code to have a dict() of workers and a dict of
fakeworkers, represented by objects. The code can iterate over these.

This is separated out from the multi-config changes since its separable
and clearer this way.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index fd8072d..f8bb641 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -922,6 +922,11 @@ class RunQueueData:
                          self.runtaskentries[tid].depends,
                          self.runtaskentries[tid].revdeps)
 
+class RunQueueWorker():
+    def __init__(self, process, pipe):
+        self.process = process
+        self.pipe = pipe
+
 class RunQueue:
     def __init__(self, cooker, cfgData, dataCache, taskData, targets):
 
@@ -940,10 +945,8 @@ class RunQueue:
         self.dm = monitordisk.diskMonitor(cfgData)
 
         self.rqexe = None
-        self.worker = None
-        self.workerpipe = None
-        self.fakeworker = None
-        self.fakeworkerpipe = None
+        self.worker = {}
+        self.fakeworker = {}
 
     def _start_worker(self, fakeroot = False, rqexec = None):
         logger.debug(1, "Starting bitbake-worker")
@@ -988,55 +991,56 @@ class RunQueue:
         worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) + b"</workerdata>")
         worker.stdin.flush()
 
-        return worker, workerpipe
+        return RunQueueWorker(worker, workerpipe)
 
-    def _teardown_worker(self, worker, workerpipe):
+    def _teardown_worker(self, worker):
         if not worker:
             return
         logger.debug(1, "Teardown for bitbake-worker")
         try:
-           worker.stdin.write(b"<quit></quit>")
-           worker.stdin.flush()
-           worker.stdin.close()
+           worker.process.stdin.write(b"<quit></quit>")
+           worker.process.stdin.flush()
+           worker.process.stdin.close()
         except IOError:
            pass
-        while worker.returncode is None:
-            workerpipe.read()
-            worker.poll()
-        while workerpipe.read():
+        while worker.process.returncode is None:
+            worker.pipe.read()
+            worker.process.poll()
+        while worker.pipe.read():
             continue
-        workerpipe.close()
+        worker.pipe.close()
 
     def start_worker(self):
         if self.worker:
             self.teardown_workers()
         self.teardown = False
-        self.worker, self.workerpipe = self._start_worker()
+        self.worker[''] = self._start_worker()
 
     def start_fakeworker(self, rqexec):
         if not self.fakeworker:
-            self.fakeworker, self.fakeworkerpipe = self._start_worker(True, rqexec)
+            self.fakeworker[''] = self._start_worker(True, rqexec)
 
     def teardown_workers(self):
         self.teardown = True
-        self._teardown_worker(self.worker, self.workerpipe)
-        self.worker = None
-        self.workerpipe = None
-        self._teardown_worker(self.fakeworker, self.fakeworkerpipe)
-        self.fakeworker = None
-        self.fakeworkerpipe = None
+        for mc in self.worker:
+            self._teardown_worker(self.worker[mc])
+        self.worker = {}
+        for mc in self.fakeworker:
+            self._teardown_worker(self.fakeworker[mc])
+        self.fakeworker = {}
 
     def read_workers(self):
-        self.workerpipe.read()
-        if self.fakeworkerpipe:
-            self.fakeworkerpipe.read()
+        for mc in self.worker:
+            self.worker[mc].pipe.read()
+        for mc in self.fakeworker:
+            self.fakeworker[mc].pipe.read()
 
     def active_fds(self):
         fds = []
-        if self.workerpipe:
-            fds.append(self.workerpipe.input)
-        if self.fakeworkerpipe:
-            fds.append(self.fakeworkerpipe.input)
+        for mc in self.worker:
+            fds.append(self.worker[mc].pipe.input)
+        for mc in self.fakeworker:
+            fds.append(self.fakeworker[mc].pipe.input)
         return fds
 
     def check_stamp_task(self, tid, taskname = None, recurse = False, cache = None):
@@ -1392,9 +1396,10 @@ class RunQueueExecute:
 
         self.stampcache = {}
 
-        rq.workerpipe.setrunqueueexec(self)
-        if rq.fakeworkerpipe:
-            rq.fakeworkerpipe.setrunqueueexec(self)
+        for mc in rq.worker:
+            rq.worker[mc].pipe.setrunqueueexec(self)
+        for mc in rq.fakeworker:
+            rq.fakeworker[mc].pipe.setrunqueueexec(self)
 
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
@@ -1413,15 +1418,21 @@ class RunQueueExecute:
         return True
 
     def finish_now(self):
-        for worker in [self.rq.worker, self.rq.fakeworker]:
-            if not worker:
-                continue
+        for mc in rq.worker:
+            try:
+                rq.worker[mc].process.stdin.write(b"<finishnow></finishnow>")
+                rq.worker[mc].process.stdin.flush()
+            except IOError:
+                # worker must have died?
+                pass
+        for mc in rq.fakeworker:
             try:
-                worker.stdin.write(b"<finishnow></finishnow>")
-                worker.stdin.flush()
+                rq.fakeworker[mc].process.stdin.write(b"<finishnow></finishnow>")
+                rq.fakeworker[mc].process.stdin.flush()
             except IOError:
                 # worker must have died?
                 pass
+
         if len(self.failed_fns) != 0:
             self.rq.state = runQueueFailed
             return
@@ -1732,11 +1743,11 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         logger.critical("Failed to spawn fakeroot worker to run %s: %s" % (task, str(exc)))
                         self.rq.state = runQueueFailed
                         return True
-                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
-                self.rq.fakeworker.stdin.flush()
+                self.rq.fakeworker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
+                self.rq.fakeworker[''].process.stdin.flush()
             else:
-                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
-                self.rq.worker.stdin.flush()
+                self.rq.worker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + b"</runtask>")
+                self.rq.worker[''].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
             self.build_stamps2.append(self.build_stamps[task])
@@ -2155,11 +2166,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
-                self.rq.fakeworker.stdin.flush()
+                self.rq.fakeworker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
+                self.rq.fakeworker[''].process.stdin.flush()
             else:
-                self.rq.worker.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
-                self.rq.worker.stdin.flush()
+                self.rq.worker[''].process.stdin.write(b"<runtask>" + pickle.dumps((fn, task, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + b"</runtask>")
+                self.rq.worker[''].process.stdin.flush()
 
             self.runq_running.add(task)
             self.stats.taskActive()
@@ -2313,17 +2324,16 @@ class runQueuePipe():
 
     def read(self):
         for w in [self.rq.worker, self.rq.fakeworker]:
-            if not w:
-                continue
-            w.poll()
-            if w.returncode is not None and not self.rq.teardown:
-                name = None
-                if self.rq.worker and w.pid == self.rq.worker.pid:
-                    name = "Worker"
-                elif self.rq.fakeworker and w.pid == self.rq.fakeworker.pid:
-                    name = "Fakeroot"
-                bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, w.pid, str(w.returncode)))
-                self.rq.finish_runqueue(True)
+            for mc in w:
+                w[mc].process.poll()
+                if w[mc].process.returncode is not None and not self.rq.teardown:
+                    name = None
+                    if w in self.rq.worker:
+                        name = "Worker"
+                    elif w in self.rq.fakeworker:
+                        name = "Fakeroot"
+                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, w.pid, str(w.returncode)))
+                    self.rq.finish_runqueue(True)
 
         start = len(self.queue)
         try:



