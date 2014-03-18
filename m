Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1B4E16F936
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Mar 2014 22:59:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2IMx4CH021127 for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Mar 2014 22:59:04 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lt42Ocrx3TEY for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Mar 2014 22:59:04 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2IMwvGK021123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Mar 2014 22:58:59 GMT
Message-ID: <1395183532.3808.99.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Mar 2014 22:58:52 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Really fix sigchld handling
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
X-List-Received-Date: Tue, 18 Mar 2014 22:59:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are several problems. Firstly, a return value of "None" can mean
there is a C signal handler installed so we need to better handle that
case. signal.SIG_DFL is 0 which equates to false so we also need to
handle that by testing explicitly for None.

Finally, the signal handler *must* call waitpid on all child processes
else it will just get called repeatedly, leading to the hanging behaviour
we've been seeing. The solution is to only error for the worker children,
we warn about any other stray children which we'll have to figure out the
sources of in due course.

Hopefully this patch gets things working again properly though.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 055db48..3ab5439 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -914,32 +914,32 @@ class RunQueue:
         workerpipe.close()
 
     def sigchild_exception(self, *args, **kwargs):
-        for w in [self.worker, self.fakeworker]:
-            if not w:
-                continue
+        pid = -1
+        while pid:
             try:
-                pid, status = os.waitpid(w.pid, os.WNOHANG)
+                pid, status = os.waitpid(-1, os.WNOHANG)
                 if pid != 0 and not self.teardown:
+                    name = None
                     if self.worker and pid == self.worker.pid:
                         name = "Worker"
                     elif self.fakeworker and pid == self.fakeworker.pid:
                         name = "Fakeroot"
                     else:
-                        name = "Unknown"
-                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
-                    self.finish_runqueue(True)
+                        bb.warn("Unknown process (%s) exited unexpectedly (%s), shutting down..." % (pid, str(status)))
+                    if name and not self.teardown:
+                        bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
+                        self.finish_runqueue(True)
             except OSError:
-                pid = False
-        if callable(self.oldsigchld):
-            self.oldsigchld(*args, **kwargs)
+                return
 
     def start_worker(self):
         if self.worker:
             self.teardown_workers()
         self.teardown = False
-        if not self.oldsigchld:
-            self.oldsigchld = signal.getsignal(signal.SIGCHLD)
-            signal.signal(signal.SIGCHLD, self.sigchild_exception)
+        if self.oldsigchld is None:
+            self.oldsigchld = signal.signal(signal.SIGCHLD, self.sigchild_exception)
+            if self.oldsigchld is None:
+                self.oldsigchld = signal.SIG_DFL
         self.worker, self.workerpipe = self._start_worker()
 
     def start_fakeworker(self, rqexec):
@@ -948,7 +948,7 @@ class RunQueue:
 
     def teardown_workers(self):
         self.teardown = True
-        if self.oldsigchld:
+        if self.oldsigchld is not None:
             signal.signal(signal.SIGCHLD, self.oldsigchld)
             self.oldsigchld = None
         self._teardown_worker(self.worker, self.workerpipe)



