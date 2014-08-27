Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8730D7067B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 13:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDtoDl001807 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:55:50 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EBtwDTV6GXHx for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:55:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7RDtmHH001804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 14:55:49 +0100
Message-ID: <1409147750.5772.50.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Aug 2014 14:55:50 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] bitbake-worker: Extra profiling data dump
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
X-List-Received-Date: Wed, 27 Aug 2014 13:55:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently we get no profiling oversight into either the main bitbake worker
process, or the overall parsing before task execution. This adds in extra
profiling hooks so we can truly capture all parts of bitbake's execution
into the profile data.

To do this we modify the 'magic' value passed to bitbake-worker to trigger
the profiling, before the configuration data is sent over to the worker.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index d1ff5b3..c7992f7 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -12,10 +12,18 @@ import errno
 import signal
 
 # Users shouldn't be running this code directly
-if len(sys.argv) != 2 or sys.argv[1] != "decafbad":
+if len(sys.argv) != 2 or not sys.argv[1].startswith("decafbad"):
     print("bitbake-worker is meant for internal execution by bitbake itself, please don't use it standalone.")
     sys.exit(1)
 
+profiling = False
+if sys.argv[1] == "decafbadbad":
+    profiling = True
+    try:
+        import cProfile as profile
+    except:
+        import profile
+
 logger = logging.getLogger("BitBake")
 
 try:
@@ -134,6 +142,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
         bb.msg.fatal("RunQueue", "fork failed: %d (%s)" % (e.errno, e.strerror))
 
     if pid == 0:
+        def child():
             global worker_pipe
             pipein.close()
 
@@ -185,10 +194,20 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
                 os._exit(1)
             try:
                 if not cfg.dry_run:
-                    ret = bb.build.exec_task(fn, taskname, the_data, cfg.profile)
-                os._exit(ret)
+                    return bb.build.exec_task(fn, taskname, the_data, cfg.profile)
             except:
                 os._exit(1)
+        if not profiling:
+            os._exit(child())
+        else:
+            profname = "profile-%s.log" % (fn.replace("/", "-") + "-" + taskname)
+            prof = profile.Profile()
+            try: 
+                ret = profile.Profile.runcall(prof, child)
+            finally:
+                prof.dump_stats(profname)
+                bb.utils.process_profilelog(profname)
+                os._exit(ret)
     else:
         for key, value in envbackup.iteritems():
             if value is None:
@@ -363,7 +382,16 @@ class BitbakeWorker(object):
 
 try:
     worker = BitbakeWorker(sys.stdin)
-    worker.serve()
+    if not profiling:
+        worker.serve()
+    else:
+        profname = "profile-worker.log"
+        prof = profile.Profile()
+        try:
+            profile.Profile.runcall(prof, worker.serve)
+        finally:
+            prof.dump_stats(profname)
+            bb.utils.process_profilelog(profname)
 except BaseException as e:
     if not normalexit:
         import traceback
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e32f81a..39df794 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -859,15 +859,18 @@ class RunQueue:
 
     def _start_worker(self, fakeroot = False, rqexec = None):
         logger.debug(1, "Starting bitbake-worker")
+        magic = "decafbad"
+        if self.cooker.configuration.profile:
+            magic = "decafbadbad"
         if fakeroot:
             fakerootcmd = self.cfgData.getVar("FAKEROOTCMD", True)
             fakerootenv = (self.cfgData.getVar("FAKEROOTBASEENV", True) or "").split()
             env = os.environ.copy()
             for key, value in (var.split('=') for var in fakerootenv):
                 env[key] = value
-            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
+            worker = subprocess.Popen([fakerootcmd, "bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
         else:
-            worker = subprocess.Popen(["bitbake-worker", "decafbad"], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
+            worker = subprocess.Popen(["bitbake-worker", magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE)
         bb.utils.nonblockingfd(worker.stdout)
         workerpipe = runQueuePipe(worker.stdout, None, self.cfgData, self, rqexec)
 



