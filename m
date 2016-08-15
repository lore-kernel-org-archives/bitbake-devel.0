Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4850374197
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH1xh6010865 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:01:59 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FUGVhORGrcsU for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:01:59 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FH1sYA010862
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 18:01:55 +0100
Message-ID: <1471280514.20391.97.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 18:01:54 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache/cooker: Pass databuilder into bb.cache.Cache()
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
X-List-Received-Date: Mon, 15 Aug 2016 17:02:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rather that the current mix of static and class methods, refactor
so that the cache has the databuilder object internally. This becomes
useful for the following patches for multi config support.

It effectively completes some of the object oriented work we've been
working towards in the bitbake core for a while.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index bd7bd4e..b3353fb 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -116,7 +116,7 @@ def sigterm_handler(signum, frame):
     os.killpg(0, signal.SIGTERM)
     sys.exit()
 
-def fork_off_task(worker, cfg, data, workerdata, fn, task, taskname, appends, taskdepdata, quieterrors=False):
+def fork_off_task(worker, cfg, data, databuilder, workerdata, fn, task, taskname, appends, taskdepdata, quieterrors=False):
     # We need to setup the environment BEFORE the fork, since
     # a fork() or exec*() activates PSEUDO...
 
@@ -402,7 +402,7 @@ class BitbakeWorker(object):
         fn, task, taskname, quieterrors, appends, taskdepdata = pickle.loads(data)
         workerlog_write("Handling runtask %s %s %s\n" % (task, fn, taskname))
 
-        pid, pipein, pipeout = fork_off_task(self, self.cookercfg, self.data, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
+        pid, pipein, pipeout = fork_off_task(self, self.cookercfg, self.data, self.databuilder, self.workerdata, fn, task, taskname, appends, taskdepdata, quieterrors)
 
         self.build_pids[pid] = task
         self.build_pipes[pid] = runQueueWorkerPipe(pipein, pipeout)
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index c915bb9..7118c83 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -270,7 +270,9 @@ class Cache(object):
     BitBake Cache implementation
     """
 
-    def __init__(self, data, data_hash, caches_array):
+    def __init__(self, databuilder, data_hash, caches_array):
+        data = databuilder.data
+
         # Pass caches_array information into Cache Constructor
         # It will be used later for deciding whether we 
         # need extra cache file dump/load support 
@@ -279,7 +281,6 @@ class Cache(object):
         self.clean = set()
         self.checked = set()
         self.depends_cache = {}
-        self.data = None
         self.data_fn = None
         self.cacheclean = True
         self.data_hash = data_hash
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 11c611d..43c4f78 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1974,6 +1974,7 @@ class CookerParser(object):
         self.cooker = cooker
         self.cfgdata = cooker.data
         self.cfghash = cooker.data_hash
+        self.cfgbuilder = cooker.databuilder
 
         # Accounting statistics
         self.parsed = 0
@@ -1988,7 +1989,7 @@ class CookerParser(object):
         self.current = 0
         self.process_names = []
 
-        self.bb_cache = bb.cache.Cache(self.cfgdata, self.cfghash, cooker.caches_array)
+        self.bb_cache = bb.cache.Cache(self.cfgbuilder, self.cfghash, cooker.caches_array)
         self.fromcache = []
         self.willparse = []
         for filename in self.filelist:



