Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EF1DD60603
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 14:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uASEHQii026518; Mon, 28 Nov 2016 14:17:26 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id URL51t7DWLFe; Mon, 28 Nov 2016 14:17:26 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uASEHL9a026514
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Nov 2016 14:17:22 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cBMkD-0007gT-MT; Mon, 28 Nov 2016 14:17:21 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Nov 2016 14:17:20 +0000
Message-Id: <1480342640-29497-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] bitbake-worker: Handle cooker/worker IO deadlocking
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
X-List-Received-Date: Mon, 28 Nov 2016 14:17:27 -0000

I noiced builds where tasks seemed to be taking a surprisingly long time.
When I looked at the output of top/pstree, these tasks were no longer
running despite being listed in knotty. Some were in D/Z state waiting for
their exit code to be collected, others were simply not present at all.

strace showed communication problems between the worker and cooker, each
was trying to write to the other and nearly deadlocking. Eventually, timeouts
would allow them to echange 64kb of data but this was only happening every
few seconds.

Whilst this particularly affected builds on machines with large numbers
of cores (and hence highly parallal task execution) and in cases where
I had a lot of debug enabled, this situation is clearly bad in general.

This patch introduces a thread to the worker which is used to write data
back to cooker. This means that the deadlock can't occur and data flows
much more freely and effectively.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/bin/bitbake-worker | 52 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 9e709375d..7a35492 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -13,7 +13,9 @@ import signal
 import pickle
 import traceback
 import subprocess
+import queue
 from multiprocessing import Lock
+from threading import Thread
 
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
@@ -65,7 +67,7 @@ if 0:
     consolelog.setFormatter(conlogformat)
     logger.addHandler(consolelog)
 
-worker_queue = b""
+worker_queue = queue.Queue()
 
 def worker_fire(event, d):
     data = b"<event>" + pickle.dumps(event) + b"</event>"
@@ -74,21 +76,38 @@ def worker_fire(event, d):
 def worker_fire_prepickled(event):
     global worker_queue
 
-    worker_queue = worker_queue + event
-    worker_flush()
+    worker_queue.put(event)
 
-def worker_flush():
-    global worker_queue, worker_pipe
+#
+# We can end up with write contention with the cooker, it can be trying to send commands
+# and we can be trying to send event data back. Therefore use a separate thread for writing 
+# back data to cooker.
+#
+worker_thread_exit = False
 
-    if not worker_queue:
-        return
+def worker_flush(worker_queue):
+    worker_queue_int = b""
+    global worker_pipe, worker_thread_exit
 
-    try:
-        written = os.write(worker_pipe, worker_queue)
-        worker_queue = worker_queue[written:]
-    except (IOError, OSError) as e:
-        if e.errno != errno.EAGAIN and e.errno != errno.EPIPE:
-            raise
+    while True:
+        try:
+            worker_queue_int = worker_queue_int + worker_queue.get(True, 1)
+        except queue.Empty:
+            pass
+        while (worker_queue_int or not worker_queue.empty()):
+            try:
+                if not worker_queue.empty():
+                    worker_queue_int = worker_queue_int + worker_queue.get()
+                written = os.write(worker_pipe, worker_queue_int)
+                worker_queue_int = worker_queue_int[written:]
+            except (IOError, OSError) as e:
+                if e.errno != errno.EAGAIN and e.errno != errno.EPIPE:
+                    raise
+        if worker_thread_exit and worker_queue.empty() and not worker_queue_int:
+            return
+
+worker_thread = Thread(target=worker_flush, args=(worker_queue,))
+worker_thread.start()
 
 def worker_child_fire(event, d):
     global worker_pipe
@@ -366,7 +385,6 @@ class BitbakeWorker(object):
                 self.build_pipes[pipe].read()
             if len(self.build_pids):
                 self.process_waitpid()
-            worker_flush()
 
 
     def handle_item(self, item, func):
@@ -475,8 +493,10 @@ except BaseException as e:
         import traceback
         sys.stderr.write(traceback.format_exc())
         sys.stderr.write(str(e))
-while len(worker_queue):
-    worker_flush()
+
+worker_thread_exit = True
+worker_thread.join()
+
 workerlog_write("exitting")
 sys.exit(0)
 
-- 
2.7.4


