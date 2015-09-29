Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 097A076903
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 08:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8T8SbvF022239 for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 09:28:37 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rVlNb6vmA1ry for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 09:28:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8T8SOEX022192
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 09:28:36 +0100
Message-ID: <1443515304.5162.12.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Sep 2015 09:28:24 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Guard against multiprocessing corruption of event data
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
X-List-Received-Date: Tue, 29 Sep 2015 08:28:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In the forked child, we may use multiprocessing. There is only one event
pipe to the worker controlling process and if we're unlucky, multiple
processes can write to it at once corrupting the data by intermixing it.

We don't see this often but when we do, its quite puzzling. I suspect it
only happens in tasks which use multiprocessng (do_rootfs, do_package)
and is much more likely to happen when we have long messages, usually many
times PAGE_SIZE since PAGE_SIZE writes are atomic. This makes it much more
likely within do_roofs, when for example a subprocess lists the contents
of a rootfs.

To fix this, we give each child a Lock() object and use this to serialise
writes to the controlling worker.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 45a78ec..1dcd590 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -10,6 +10,7 @@ import bb
 import select
 import errno
 import signal
+from multiprocessing import Lock
 
 # Users shouldn't be running this code directly
 if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
@@ -44,6 +45,9 @@ except ImportError:
 
 worker_pipe = sys.stdout.fileno()
 bb.utils.nonblockingfd(worker_pipe)
+# Need to guard against multiprocessing being used in child processes
+# and multiple processes trying to write to the parent at the same time
+worker_pipe_lock = None
 
 handler = bb.event.LogHandler()
 logger.addHandler(handler)
@@ -85,10 +89,13 @@ def worker_flush():
 
 def worker_child_fire(event, d):
     global worker_pipe
+    global worker_pipe_lock
 
     data = "<event>" + pickle.dumps(event) + "</event>"
     try:
+        worker_pipe_lock.acquire()
         worker_pipe.write(data)
+        worker_pipe_lock.release()
     except IOError:
         sigterm_handler(None, None)
         raise
@@ -157,6 +164,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
     if pid == 0:
         def child():
             global worker_pipe
+            global worker_pipe_lock
             pipein.close()
 
             signal.signal(signal.SIGTERM, sigterm_handler)
@@ -169,6 +177,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             bb.event.worker_pid = os.getpid()
             bb.event.worker_fire = worker_child_fire
             worker_pipe = pipeout
+            worker_pipe_lock = Lock()
 
             # Make the child the process group leader and ensure no
             # child process will be controlled by the current terminal



