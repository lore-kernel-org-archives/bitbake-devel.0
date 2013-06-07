Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BE1416A88F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:12:45 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HHoMT001995 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:17:50 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 5e15cz52Xh_9 for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:17:50 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HHjIS001987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:17:46 +0100
Message-ID: <1370625150.6864.53.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:12:30 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Abstract the start and teardown worker functions
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
X-List-Received-Date: Fri, 07 Jun 2013 17:12:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We're going to need a fakeroot/pseudo version of the worker so
abstract the code to start the worker process.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 34a123b..3e694ba 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -800,15 +800,13 @@ class RunQueue:
 
         self.rqexe = None
         self.worker = None
+        self.workerpipe = None
 
-    def start_worker(self):
-        if self.worker:
-            self.teardown_worker()
-
+    def _start_worker(self):
         logger.debug(1, "Starting bitbake-worker")
-        self.worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
-        bb.utils.nonblockingfd(self.worker.stdout)
-        self.workerpipe = runQueuePipe(self.worker.stdout, None, self.cfgData, self)
+        worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+        bb.utils.nonblockingfd(worker.stdout)
+        workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, None)
 
         workerdata = {
             "taskdeps" : self.rqdata.dataCache.task_deps,
@@ -825,19 +823,35 @@ class RunQueue:
             "logdefaultdomain" : bb.msg.loggerDefaultDomains,
         }
 
-        self.worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
-        self.worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
-        self.worker.stdin.flush()
+        worker.stdin.write("<cookerconfig>" + pickle.dumps(self.cooker.configuration) + "</cookerconfig>")
+        worker.stdin.write("<workerdata>" + pickle.dumps(workerdata) + "</workerdata>")
+        worker.stdin.flush()
 
-    def teardown_worker(self):
+        return worker, workerpipe
+
+    def _teardown_worker(self, worker, workerpipe):
+        if not worker:
+            return
         logger.debug(1, "Teardown for bitbake-worker")
-        self.worker.stdin.write("<quit></quit>")
-        self.worker.stdin.flush()
-        while self.worker.returncode is None:
-            self.workerpipe.read()
-            self.worker.poll()
-        while self.workerpipe.read():
+        worker.stdin.write("<quit></quit>")
+        worker.stdin.flush()
+        while worker.returncode is None:
+            workerpipe.read()
+            worker.poll()
+        while workerpipe.read():
             continue
+        workerpipe.close()
+
+    def start_worker(self):
+        if self.worker:
+            self.teardown_worker()
+
+        self.worker, self.workerpipe = self._start_worker()
+
+    def teardown_worker(self):
+        self._teardown_worker(self.worker, self.workerpipe)
+        self.worker = None
+        self.workerpipe = None
 
     def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):



