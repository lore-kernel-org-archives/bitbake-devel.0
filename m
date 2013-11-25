Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AF2BE6D959
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:18:35 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPNITCv026371 for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:18:29 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EcueZNDDG_8n for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:18:29 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAPNIPpJ026367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Nov 2013 23:18:26 GMT
Message-ID: <1385421502.24083.26.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Nov 2013 23:18:22 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Share BB_TASKDEPDATA with tasks
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
X-List-Received-Date: Mon, 25 Nov 2013 23:18:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently tasks have no knowledge of which other tasks they depend
upon. This makes it impossible to do at least two things which would be
desirable/interesting:

a) Have the ability to create per recipe sysroots
b) Allow the aclocal files to be present only for the entries in
   DEPENDS (directly and indirectly)

By exporting task data through this new variable, tasks can inspect
their dependencies and then take actions based upon this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index ff20c1c..bc13b4f 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -81,7 +81,7 @@ def workerlog_write(msg):
         lf.write(msg)
         lf.flush()
 
-def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quieterrors=False):
+def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdata, quieterrors=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -148,6 +148,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, quieterror
                 os.umask(umask)
 
             data.setVar("BB_WORKERCONTEXT", "1")
+            data.setVar("BB_TASKDEPDATA", taskdepdata)
             data.setVar("BUILDNAME", workerdata["buildname"])
             data.setVar("DATE", workerdata["date"])
             data.setVar("TIME", workerdata["time"])
@@ -300,10 +301,10 @@ class BitbakeWorker(object):
         sys.exit(0)
 
     def handle_runtask(self, data):
-        fn, task, taskname, quieterrors, appends = pickle.loads(data)
+        fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, quieterrors)
+        pid, pipein, pipeout = fork_off_task(self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f984119..428cff1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1437,14 +1437,16 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 startevent = runQueueTaskStarted(task, self.stats, self.rq)
                 bb.event.fire(startevent, self.cfgData)
 
+            taskdepdata = self.build_taskdepdata(task)
+
             taskdep = self.rqdata.dataCache.task_deps[fn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + "</runtask>")
                 self.rq.fakeworker.stdin.flush()
             else:
-                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, task, taskname, False, self.cooker.collection.get_file_appends(fn), taskdepdata)) + "</runtask>")
                 self.rq.worker.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCache, fn)
@@ -1474,6 +1476,26 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         return True
 
+    def build_taskdepdata(self, task):
+        taskdepdata = {}
+        next = self.rqdata.runq_depends[task]
+        next.add(task)
+        while next:
+            additional = []
+            for revdep in next:
+                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[revdep]]
+                pn = self.rqdata.dataCache.pkg_fn[fn]
+                taskname = self.rqdata.runq_task[revdep]
+                deps = self.rqdata.runq_depends[revdep]
+                taskdepdata[revdep] = [pn, taskname, fn, deps]
+                for revdep2 in deps:
+                    if revdep2 not in taskdepdata:
+                        additional.append(revdep2)
+            next = additional
+
+        #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
+        return taskdepdata
+
 class RunQueueExecuteScenequeue(RunQueueExecute):
     def __init__(self, rq):
         RunQueueExecute.__init__(self, rq)
@@ -1784,10 +1806,10 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot']:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.fakeworker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + "</runtask>")
                 self.rq.fakeworker.stdin.flush()
             else:
-                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn))) + "</runtask>")
+                self.rq.worker.stdin.write("<runtask>" + pickle.dumps((fn, realtask, taskname, True, self.cooker.collection.get_file_appends(fn), None)) + "</runtask>")
                 self.rq.worker.stdin.flush()
 
             self.runq_running[task] = 1



