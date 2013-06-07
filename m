Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0E1B66A88F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:12:01 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HH7s7001969 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:17:07 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bsG1ZarUpM9o for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:17:07 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HH4Am001961
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:17:05 +0100
Message-ID: <1370625109.6864.52.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:11:49 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Move the bitbake-worker execution to a higher level
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
X-List-Received-Date: Fri, 07 Jun 2013 17:12:02 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The worker was being executed by each execution queue so would get
constructed twice for each build. This is wasteful so move execution
to the main runqueue so we only have to start the worker once.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index dd6e071..34a123b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -84,7 +84,6 @@ runQueueRunning = 6
 runQueueFailed = 7
 runQueueCleanUp = 8
 runQueueComplete = 9
-runQueueChildProcess = 10
 
 class RunQueueScheduler(object):
     """
@@ -800,6 +799,45 @@ class RunQueue:
         self.dm = monitordisk.diskMonitor(cfgData)
 
         self.rqexe = None
+        self.worker = None
+
+    def start_worker(self):
+        if self.worker:
+            self.teardown_worker()
+
+        logger.debug(1, "Starting bitbake-worker")
+        self.worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+        bb.utils.nonblockingfd(self.worker.stdout)
+        self.workerpipe = runQueuePipe(self.worker.stdout, None, self.cfgData, self)
+
+        workerdata = {
+            "taskdeps" : self.rqdata.dataCache.task_deps,
+            "fakerootenv" : self.rqdata.dataCache.fakerootenv,
+            "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
+            "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
+            "hashes" : self.rqdata.hashes,
+            "hash_deps" : self.rqdata.hash_deps,
+            "sigchecksums" : bb.parse.siggen.file_checksum_values,
+            "runq_hash" : self.rqdata.runq_hash,
+            "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
+            "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
+            "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
+            "logdefaultdomain" : bb.msg.loggerDefaultDomains,
+        }
+
+        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
+        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
+        self.worker.stdin.flush()
+
+    def teardown_worker(self):
+        logger.debug(1, "Teardown for bitbake-worker")
+        self.worker.stdin.write("<quit></quit>")
+        self.worker.stdin.flush()
+        while self.worker.returncode is None:
+            self.workerpipe.read()
+            self.worker.poll()
+        while self.workerpipe.read():
+            continue
 
     def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
@@ -891,6 +929,7 @@ class RunQueue:
             if self.cooker.configuration.dump_signatures:
                 self.dump_signatures()
             else:
+                self.start_worker()
                 self.rqexe = RunQueueExecuteScenequeue(self)
 
         if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
@@ -911,6 +950,7 @@ class RunQueue:
            self.rqexe.finish()
 
         if self.state is runQueueComplete or self.state is runQueueFailed:
+            self.teardown_worker()
             if self.rqexe.stats.failed:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
             else:
@@ -928,10 +968,6 @@ class RunQueue:
             # All done
             return False
 
-        if self.state is runQueueChildProcess:
-            print("Child process, eeek, shouldn't happen!")
-            return False
-
         # Loop
         return retval
 
@@ -946,7 +982,7 @@ class RunQueue:
         except:
             logger.error("An uncaught exception occured in runqueue, please see the failure below:")
             try:
-                self.rqexe.teardown()
+                self.teardown_worker()
             except:
                 pass
             self.state = runQueueComplete
@@ -996,29 +1032,7 @@ class RunQueueExecute:
 
         self.stampcache = {}
 
-        logger.debug(1, "Starting bitbake-worker")
-        self.worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
-        bb.utils.nonblockingfd(self.worker.stdout)
-        self.workerpipe = runQueuePipe(self.worker.stdout, None, self.cfgData, self)
-
-        workerdata = {
-            "taskdeps" : self.rqdata.dataCache.task_deps,
-            "fakerootenv" : self.rqdata.dataCache.fakerootenv,
-            "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
-            "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
-            "hashes" : self.rqdata.hashes,
-            "hash_deps" : self.rqdata.hash_deps,
-            "sigchecksums" : bb.parse.siggen.file_checksum_values,
-            "runq_hash" : self.rqdata.runq_hash,
-            "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
-            "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
-            "logdefaultverboselogs" : bb.msg.loggerVerboseLogs,
-            "logdefaultdomain" : bb.msg.loggerDefaultDomains,
-        }
-
-        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
-        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
-        self.worker.stdin.flush()
+        rq.workerpipe.setrunqueueexec(self)
 
     def runqueue_process_waitpid(self, task, status):
 
@@ -1034,10 +1048,8 @@ class RunQueueExecute:
 
     def finish_now(self):
 
-        self.worker.stdin.write("<finishnow></finishnow>")
-        self.worker.stdin.flush()
-
-        self.teardown()
+        self.rq.worker.stdin.write("<finishnow></finishnow>")
+        self.rq.worker.stdin.flush()
 
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
@@ -1051,11 +1063,9 @@ class RunQueueExecute:
 
         if self.stats.active > 0:
             bb.event.fire(runQueueExitWait(self.stats.active), self.cfgData)
-            self.workerpipe.read()
+            self.rq.workerpipe.read()
             return
 
-        self.teardown()
-
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
             return
@@ -1083,16 +1093,6 @@ class RunQueueExecute:
         valid = bb.utils.better_eval(call, locs)
         return valid
 
-    def teardown(self):
-        logger.debug(1, "Teardown for bitbake-worker")
-        self.worker.stdin.write("<quit></quit>")
-        self.worker.stdin.flush()
-        while self.worker.returncode is None:
-            self.workerpipe.read()
-            self.worker.poll()
-        while self.workerpipe.read():
-            continue
-
 class RunQueueExecuteDummy(RunQueueExecute):
     def __init__(self, rq):
         self.rq = rq
@@ -1257,7 +1257,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
         Run the tasks in a queue prepared by rqdata.prepare()
         """
 
-        self.workerpipe.read()
+        self.rq.workerpipe.read()
         
 
         if self.stats.total == 0:
@@ -1295,8 +1295,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent = runQueueTaskStarted(task, self.stats, self.rq)
                 bb.event.fire(startevent, self.cfgData)
 
-            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
-            self.worker.stdin.flush()
+            self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+            self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
             self.runq_running[task] = 1
@@ -1305,11 +1305,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 return True
 
         if self.stats.active > 0:
-            self.workerpipe.read()
+            self.rq.workerpipe.read()
             return 0.5
 
-        self.teardown()
-
         if len(self.failed_fnids) != 0:
             self.rq.state = runQueueFailed
             return True
@@ -1337,7 +1335,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # If we don't have any setscene functions, skip this step
         if len(self.rqdata.runq_setscene) == 0:
             rq.scenequeue_covered = set()
-            self.teardown()
             rq.state = runQueueRunInit
             return
 
@@ -1586,7 +1583,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         Run the tasks in a queue prepared by prepare_runqueue
         """
 
-        self.workerpipe.read()
+        self.rq.workerpipe.read()
 
         task = None
         if self.stats.active < self.number_tasks:
@@ -1628,8 +1625,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
-            self.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
-            self.worker.stdin.flush()
+            self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+            self.rq.worker.stdin.flush()
 
             self.runq_running[task] = 1
             self.stats.taskActive()
@@ -1637,7 +1634,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 return True
 
         if self.stats.active > 0:
-            self.workerpipe.read()
+            self.rq.workerpipe.read()
             return 0.5
 
         # Convert scenequeue_covered task numbers into full taskgraph ids
@@ -1652,7 +1649,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 
         self.rq.state = runQueueRunInit
-        self.teardown()
         return True
 
     def runqueue_process_waitpid(self, task, status):
@@ -1747,7 +1743,7 @@ class runQueuePipe():
         self.d = d
         self.rq = rq
 
-    def setrunqueue(self, rq):
+    def setrunqueueexec(self, rq):
         self.rq = rq
 
     def read(self):



