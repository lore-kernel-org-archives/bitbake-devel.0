Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 138056A88F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:13:16 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HIMn9002054 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:18:22 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id m8tzh_HK6OSb for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:18:22 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HIIYT002050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:18:20 +0100
Message-ID: <1370625184.6864.54.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:13:04 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Spawn a separate worker for fakeroot tasks
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2013 17:13:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3e694ba..577f04a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -801,12 +801,22 @@ class RunQueue:
         self.rqexe = None
         self.worker = None
         self.workerpipe = None
+        self.fakeworker = None
+        self.fakeworkerpipe = None
 
-    def _start_worker(self):
+    def _start_worker(self, fakeroot = False, rqexec = None):
         logger.debug(1, "Starting bitbake-worker")
-        worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+        if fakeroot:
+            fakerootcmd = self.cfgData.getVar("FAKEROOTCMD", True)
+            fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV", True) or "").split()
+            env = os.environ.copy()
+            for key, value in (var.split('=') for var in fakerootenv):
+                env[key] = value
+            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+        else:
+            worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, None)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, rqexec)
 
         workerdata = {
             "taskdeps" : self.rqdata.dataCache.task_deps,
@@ -844,14 +854,25 @@ class RunQueue:
 
     def start_worker(self):
         if self.worker:
-            self.teardown_worker()
-
+            self.teardown_workers()
         self.worker, self.workerpipe = self._start_worker()
 
-    def teardown_worker(self):
+    def start_fakeworker(self, rqexec):
+        if not self.fakeworker:
+            self.fakeworker, self.fakeworkerpipe = self._start_worker(True, rqexec)
+
+    def teardown_workers(self):
         self._teardown_worker(self.worker, self.workerpipe)
         self.worker = None
         self.workerpipe = None
+        self._teardown_worker(self.fakeworker, self.fakeworkerpipe)
+        self.fakeworker = None
+        self.fakeworkerpipe = None
+
+    def read_workers(self):
+        self.workerpipe.read()
+        if self.fakeworkerpipe:
+            self.fakeworkerpipe.read()
 
     def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
@@ -964,7 +985,7 @@ class RunQueue:
            self.rqexe.finish()
 
         if self.state is runQueueComplete or self.state is runQueueFailed:
-            self.teardown_worker()
+            self.teardown_workers()
             if self.rqexe.stats.failed:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
             else:
@@ -996,7 +1017,7 @@ class RunQueue:
         except:
             logger.error("An uncaught exception occured in runqueue, please see the failure below:")
             try:
-                self.teardown_worker()
+                self.teardown_workers()
             except:
                 pass
             self.state = runQueueComplete
@@ -1047,6 +1068,8 @@ class RunQueueExecute:
         self.stampcache = {}
 
         rq.workerpipe.setrunqueueexec(self)
+        if rq.fakeworkerpipe:
+            rq.fakeworkerpipe.setrunqueueexec(self)
 
     def runqueue_process_waitpid(self, task, status):
 
@@ -1064,6 +1087,9 @@ class RunQueueExecute:
 
         self.rq.worker.stdin.write("<finishnow></finishnow>")
         self.rq.worker.stdin.flush()
+        if self.rq.fakeworker:
+            self.rq.fakeworker.stdin.write("<finishnow></finishnow>")
+            self.rq.fakeworker.stdin.flush()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
@@ -1077,7 +1103,8 @@ class RunQueueExecute:
 
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgData)
-            self.rq.workerpipe.read()
+            self.rq.read_workers()
+
             return
 
         if len(self.failed_fnids) != 0:
@@ -1271,7 +1298,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        self.rq.workerpipe.read()
+        self.rq.read_workers()
         
 
         if self.stats.total == 0:
@@ -1309,8 +1336,15 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent = runQueueTaskStarted(task, self.stats, self.rq)
                 bb.event.fire(startevent, self.cfgData)
 
-            self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
-            self.rq.worker.stdin.flush()
+            taskdep = self.rqdata.dataCache.task_deps[fn]
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+                if not self.rq.fakeworker:
+                    self.rq.start_fakeworker(self)
+                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.fakeworker.stdin.flush()
+            else:
+                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
             self.runq_running[task] = 1
@@ -1319,7 +1353,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 return True
 
         if self.stats.active > 0:
-            self.rq.workerpipe.read()
+            self.rq.read_workers()
             return 0.5
 
         if len(self.failed_fnids) != 0:
@@ -1597,7 +1631,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         Run the tasks in a queue prepared by prepare_runqueue
         """
 
-        self.rq.workerpipe.read()
+        self.rq.read_workers()
 
         task = None
         if self.stats.active < self.number_tasks:
@@ -1639,8 +1673,15 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
-            self.rq.worker.stdin.flush()
+            taskdep = self.rqdata.dataCache.task_deps[fn]
+            if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
+                if not self.rq.fakeworker:
+                    self.rq.start_fakeworker(self)
+                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.fakeworker.stdin.flush()
+            else:
+                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.worker.stdin.flush()
 
             self.runq_running[task] = 1
             self.stats.taskActive()
@@ -1648,7 +1689,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 return True
 
         if self.stats.active > 0:
-            self.rq.workerpipe.read()
+            self.rq.read_workers()
             return 0.5
 
         # Convert scenequeue_covered task numbers into full taskgraph ids



