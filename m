Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id A18C96B7A6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 13:01:43 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2JD1axp012649 for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 13:01:39 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Iih2FhqwCuaW for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 13:01:39 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2JD1Zmm012632
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Mar 2014 13:01:37 GMT
Message-ID: <1395234090.3808.113.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 19 Mar 2014 13:01:30 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Revert child signal handler for now
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
X-List-Received-Date: Wed, 19 Mar 2014 13:01:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We're running into processes using 100% cpu. It appears theses are locked in
a subprocess.poll() type loop where the process has exited but the code is
looping as its not handling the ECHILD error.

http://bugs.python.org/issue14396
http://bugs.python.org/issue15756

This is likely due to one or both of the above bugs. The question is what actually
grabbed the child exit code as it wasn't this code. Its likely there is therefore
some other code racing and taking that code, it may be some kind of race like:

http://hg.python.org/cpython/rev/767420808a62/

where the fix effectively catches the childs codes in a different part of the system.

We could try and get everyone onto python 2.7.4 where the above bugs are fixed however
for now its safer to admit defeat and go back to polling explictly for our worker exit
codes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 7ef5501..5b7613b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -856,7 +856,6 @@ class RunQueue:
         self.workerpipe = None
         self.fakeworker = None
         self.fakeworkerpipe = None
-        self.oldsigchld = None
 
     def _start_worker(self, fakeroot = False, rqexec = None):
         logger.debug(1, "Starting bitbake-worker")
@@ -913,34 +912,10 @@ class RunQueue:
             continue
         workerpipe.close()
 
-    def sigchild_exception(self, *args, **kwargs):
-        for w in [self.worker, self.fakeworker]:
-            if not w:
-                continue
-            try:
-                pid, status = os.waitpid(w.pid, os.WNOHANG)
-                if pid != 0 and not self.teardown:
-                    name = None
-                    if self.worker and pid == self.worker.pid:
-                        name = "Worker"
-                    elif self.fakeworker and pid == self.fakeworker.pid:
-                        name = "Fakeroot"
-                    else:
-                        bb.warn("Unknown process (%s) exited unexpectedly (%s), shutting down..." % (pid, str(status)))
-                    if name and not self.teardown:
-                        bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
-                        self.finish_runqueue(True)
-            except OSError:
-                return
-
     def start_worker(self):
         if self.worker:
             self.teardown_workers()
         self.teardown = False
-        if self.oldsigchld is None:
-            self.oldsigchld = signal.signal(signal.SIGCHLD, self.sigchild_exception)
-            if self.oldsigchld is None:
-                self.oldsigchld = signal.SIG_DFL
         self.worker, self.workerpipe = self._start_worker()
 
     def start_fakeworker(self, rqexec):
@@ -949,9 +924,6 @@ class RunQueue:
 
     def teardown_workers(self):
         self.teardown = True
-        if self.oldsigchld is not None:
-            signal.signal(signal.SIGCHLD, self.oldsigchld)
-            self.oldsigchld = None
         self._teardown_worker(self.worker, self.workerpipe)
         self.worker = None
         self.workerpipe = None
@@ -2131,6 +2103,23 @@ class runQueuePipe():
         self.rqexec = rqexec
 
     def read(self):
+        try:
+            for w in [self.rq.worker, self.rq.fakeworker]:
+                if not w:
+                    continue
+                pid, status = os.waitpid(w.pid, os.WNOHANG)
+                if pid != 0 and not self.rq.teardown:
+                    if self.rq.worker and pid == self.rq.worker.pid:
+                        name = "Worker"
+                    elif self.rq.fakeworker and pid == self.rq.fakeworker.pid:
+                        name = "Fakeroot"
+                    else:
+                        name = "Unknown"
+                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
+                    self.rq.finish_runqueue(True)
+        except OSError:
+            pass
+
         start = len(self.queue)
         try:
             self.queue = self.queue + self.input.read(102400)



