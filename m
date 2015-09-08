Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5F34A65C8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 22:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MbpqZ012544 for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:37:51 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vl2g_ycn_Y2z for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 23:37:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MbY8n012536
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:37:45 +0100
Message-ID: <1441751854.24871.295.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Sep 2015 23:37:34 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Handle SIGKILL of parent gracefully
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
X-List-Received-Date: Tue, 08 Sep 2015 22:37:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we SIGKILL cooker (the parent process), ensure the worker notices
and shuts down gracefully. To do this:

* trigger the sigterm handler if the parent exits
* ensure broken pipe writes don't trigger backtraces which interfer with
  other exit work
* notice if our command pipe is broken due to EOF and sigterm if so

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index df59953..e66362a 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -80,7 +80,7 @@ def worker_flush():
         written = os.write(worker_pipe, worker_queue)
         worker_queue = worker_queue[written:]
     except (IOError, OSError) as e:
-        if e.errno != errno.EAGAIN:
+        if e.errno != errno.EAGAIN and e.errno != errno.EPIPE:
             raise
 
 def worker_child_fire(event, d):
@@ -158,6 +158,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             signal.signal(signal.SIGTERM, sigterm_handler)
             # Let SIGHUP exit as SIGTERM
             signal.signal(signal.SIGHUP, sigterm_handler)
+            bb.utils.signal_on_parent_exit("SIGTERM")
 
             # Save out the PID so that the event can include it the
             # events
@@ -298,7 +299,11 @@ class BitbakeWorker(object):
             (ready, _, _) = select.select([self.input] + [i.input for i in self.build_pipes.values()], [] , [], 1)
             if self.input in ready:
                 try:
-                    self.queue = self.queue + self.input.read()
+                    r = self.input.read()
+                    if len(r) == 0:
+                        # EOF on pipe, server must have terminated
+                        self.sigterm_exception(signal.SIGTERM, None)
+                    self.queue = self.queue + r
                 except (OSError, IOError):
                     pass
             if len(self.queue):



