Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C2118719F4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Dec 2016 12:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7C4tLV006366; Wed, 7 Dec 2016 12:04:55 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qQHDAS3m3J9Z; Wed,  7 Dec 2016 12:04:55 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7C4pAs006357
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Dec 2016 12:04:52 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cEaxv-0008NH-99; Wed, 07 Dec 2016 12:04:51 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Dec 2016 12:04:43 +0000
Message-Id: <1481112285-32150-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/3] bitbake-worker: Further IO performance tweaks
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
X-List-Received-Date: Wed, 07 Dec 2016 12:04:56 -0000

Looking further at the CPU loads on systems running large numbers of tasks,
the following things helps performance:

* Loop on waitpid until there are no processes still waiting
* Using select to wait for the cooker pipe to be writable before writing
  avoiding pointless 100% cpu usage
* Only reading from worker pipes that select highlights are readable

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/bin/bitbake-worker | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index a70791e..3d00c9e 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -97,6 +97,7 @@ def worker_flush(worker_queue):
             pass
         while (worker_queue_int or not worker_queue.empty()):
             try:
+                (_, ready, _) = select.select([], [worker_pipe], [], 1)
                 if not worker_queue.empty():
                     worker_queue_int = worker_queue_int + worker_queue.get()
                 written = os.write(worker_pipe, worker_queue_int)
@@ -383,9 +384,11 @@ class BitbakeWorker(object):
                 self.handle_item(b"quit", self.handle_quit)
 
             for pipe in self.build_pipes:
-                self.build_pipes[pipe].read()
+                if self.build_pipes[pipe].input in ready:
+                    self.build_pipes[pipe].read()
             if len(self.build_pids):
-                self.process_waitpid()
+                while self.process_waitpid():
+                    continue
 
 
     def handle_item(self, item, func):
@@ -440,9 +443,9 @@ class BitbakeWorker(object):
         try:
             pid, status = os.waitpid(-1, os.WNOHANG)
             if pid == 0 or os.WIFSTOPPED(status):
-                return None
+                return False
         except OSError:
-            return None
+            return False
 
         workerlog_write("Exit code of %s for pid %s\n" % (status, pid))
 
@@ -464,6 +467,7 @@ class BitbakeWorker(object):
         if pid in self.cpuused:
             self.cpuavail.append(self.cpuused[pid])
             del self.cpuused[pid]
+        return True
 
     def handle_finishnow(self, _):
         if self.build_pids:
-- 
2.7.4


