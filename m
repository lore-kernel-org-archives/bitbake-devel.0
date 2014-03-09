Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D62496F60F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:00:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s29H0UZk020174
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:00:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Xl9Q9jaNRj33 for <bitbake-devel@lists.openembedded.org>;
	Sun,  9 Mar 2014 17:00:30 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s29H0NxQ020170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 9 Mar 2014 17:00:27 GMT
Message-ID: <1394384417.7883.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 10:00:17 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue.py: Handle worker disappearing gracefully
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
X-List-Received-Date: Sun, 09 Mar 2014 17:00:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the worker (or fakeworker) process disappears for some reason, the
system doesn't currently even notice. To fix this, we call waitpid
periodically, looking for exit events of our children. If these
occur, we can gracefully shutdown the server.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 241e387..967e944 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -869,7 +869,7 @@ class RunQueue:
         else:
             worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
-        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, rqexec)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
 
         workerdata = {
             "taskdeps" : self.rqdata.dataCache.task_deps,
@@ -912,6 +912,7 @@ class RunQueue:
     def start_worker(self):
         if self.worker:
             self.teardown_workers()
+        self.teardown = False
         self.worker, self.workerpipe = self._start_worker()
 
     def start_fakeworker(self, rqexec):
@@ -919,6 +920,7 @@ class RunQueue:
             self.fakeworker, self.fakeworkerpipe = self._start_worker(True, rqexec)
 
     def teardown_workers(self):
+        self.teardown = True
         self._teardown_worker(self.worker, self.workerpipe)
         self.worker = None
         self.workerpipe = None
@@ -2067,7 +2069,7 @@ class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
     """
-    def __init__(self, pipein, pipeout, d, rq):
+    def __init__(self, pipein, pipeout, d, rq, rqexec):
         self.input = pipein
         if pipeout:
             pipeout.close()
@@ -2075,11 +2077,26 @@ class runQueuePipe():
         self.queue = ""
         self.d = d
         self.rq = rq
+        self.rqexec = rqexec
 
-    def setrunqueueexec(self, rq):
-        self.rq = rq
+    def setrunqueueexec(self, rqexec):
+        self.rqexec = rqexec
 
     def read(self):
+        try:
+            pid, status = os.waitpid(-1, os.WNOHANG)
+            if pid != 0 and not self.rq.teardown:
+                if self.rq.worker and pid == self.rq.worker.pid:
+                    name = "Worker"
+                elif self.rq.fakeworker and pid == self.rq.fakeworker.pid:
+                    name = "Fakeroot"
+                else:
+                    name = "Unknown"
+                bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
+                self.rq.finish_runqueue(True)
+        except OSError:
+            pass
+
         start = len(self.queue)
         try:
             self.queue = self.queue + self.input.read(102400)
@@ -2106,7 +2123,7 @@ class runQueuePipe():
                     task, status = pickle.loads(self.queue[10:index])
                 except ValueError as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[10:index]))
-                self.rq.runqueue_process_waitpid(task, status)
+                self.rqexec.runqueue_process_waitpid(task, status)
                 found = True
                 self.queue = self.queue[index+11:]
                 index = self.queue.find("</exitcode>")



