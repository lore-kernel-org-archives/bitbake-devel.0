Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5C4C06F58F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 01:00:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2A105o3028121 for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 01:00:05 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id c8WBriVHjqKx for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 01:00:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2A0xwi0028091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Mar 2014 01:00:03 GMT
Message-ID: <1394413193.7883.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 09 Mar 2014 17:59:53 -0700
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Use SIGCHLD instead of polling waitpid
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
X-List-Received-Date: Mon, 10 Mar 2014 01:00:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Instead of a significant number of calls to waitpid, register a SIGCHLD
handler instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index c486c98..6650bd8 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -912,10 +912,28 @@ class RunQueue:
             continue
         workerpipe.close()
 
+    def sigchild_exception(self, signum, stackframe):
+        pid = True
+        while pid:
+            try:
+                pid, status = os.waitpid(-1, os.WNOHANG)
+                if pid != 0 and not self.teardown:
+                    if self.worker and pid == self.worker.pid:
+                        name = "Worker"
+                    elif self.fakeworker and pid == self.fakeworker.pid:
+                        name = "Fakeroot"
+                    else:
+                        name = "Unknown"
+                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
+                    self.finish_runqueue(True)
+            except OSError:
+                pid = False
+
     def start_worker(self):
         if self.worker:
             self.teardown_workers()
         self.teardown = False
+        signal.signal(signal.SIGCHLD, self.sigchild_exception)
         self.worker, self.workerpipe = self._start_worker()
 
     def start_fakeworker(self, rqexec):
@@ -924,6 +942,7 @@ class RunQueue:
 
     def teardown_workers(self):
         self.teardown = True
+        signal.signal(signal.SIGCHLD, signal.SIG_DFL)
         self._teardown_worker(self.worker, self.workerpipe)
         self.worker = None
         self.workerpipe = None
@@ -2090,20 +2109,6 @@ class runQueuePipe():
         self.rqexec = rqexec
 
     def read(self):
-        try:
-            pid, status = os.waitpid(-1, os.WNOHANG)
-            if pid != 0 and not self.rq.teardown:
-                if self.rq.worker and pid == self.rq.worker.pid:
-                    name = "Worker"
-                elif self.rq.fakeworker and pid == self.rq.fakeworker.pid:
-                    name = "Fakeroot"
-                else:
-                    name = "Unknown"
-                bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, pid, str(status)))
-                self.rq.finish_runqueue(True)
-        except OSError:
-            pass
-
         start = len(self.queue)
         try:
             self.queue = self.queue + self.input.read(102400)



