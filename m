Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3390E71388
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Sep 2014 09:34:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s859Yk7M004278 for <bitbake-devel@lists.openembedded.org>;
	Fri, 5 Sep 2014 10:34:46 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0eqY8OfLhSer for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Sep 2014 10:34:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s859YeGF004275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 5 Sep 2014 10:34:42 +0100
Message-ID: <1409909681.12482.58.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 05 Sep 2014 10:34:41 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] siggen/runqueue/bitbake-worker: Improve siggen data transfer interface
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
X-List-Received-Date: Fri, 05 Sep 2014 09:34:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We need to transfer some of the siggen data from the core/cooker into
the worker instances. There was a partial API created for this but
its ugly and its not possible to extend it from the siggen class.

This patch completes the interface/abstraction for the data and
means the class can extend/customise it in any siggen class.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index c7992f7..b2935f6 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -168,7 +168,7 @@ def fork_off_task(cfg, data, workerdata, fn, task, taskname, appends, taskdepdat
             data.setVar("BUILDNAME", workerdata["buildname"])
             data.setVar("DATE", workerdata["date"])
             data.setVar("TIME", workerdata["time"])
-            bb.parse.siggen.set_taskdata(workerdata["hashes"], workerdata["hash_deps"], workerdata["sigchecksums"])
+            bb.parse.siggen.set_taskdata(workerdata["sigdata"])
             ret = 0
             try:
                 the_data = bb.cache.Cache.loadDataFull(fn, appends, data)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 39df794..6d9cf3f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -879,9 +879,7 @@ class RunQueue:
             "fakerootenv" : self.rqdata.dataCache.fakerootenv,
             "fakerootdirs" : self.rqdata.dataCache.fakerootdirs,
             "fakerootnoenv" : self.rqdata.dataCache.fakerootnoenv,
-            "hashes" : bb.parse.siggen.taskhash,
-            "hash_deps" : bb.parse.siggen.runtaskdeps,
-            "sigchecksums" : bb.parse.siggen.file_checksum_values,
+            "sigdata" : bb.parse.siggen.get_taskdata(),
             "runq_hash" : self.rqdata.runq_hash,
             "logdefaultdebug" : bb.msg.loggerDefaultDebugLevel,
             "logdefaultverbose" : bb.msg.loggerDefaultVerbose,
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 548f50d..86d9ca0 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -197,10 +197,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
 
-    def set_taskdata(self, hashes, deps, checksums):
-        self.runtaskdeps = deps
-        self.taskhash = hashes
-        self.file_checksum_values = checksums
+    def get_taskdata(self):
+       return (self.runtaskdeps, self.taskhash, self.file_checksum_values)
+
+    def set_taskdata(self, data):
+        self.runtaskdeps, self.taskhash, self.file_checksum_values = data
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
         k = fn + "." + task



