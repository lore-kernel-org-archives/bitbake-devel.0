Return-Path: <jianxun.zhang@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 13544774A9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 20:24:21 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga104.jf.intel.com with ESMTP; 21 Dec 2016 12:24:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,385,1477983600"; d="scan'208";a="45173483"
Received: from chang-s2600cp.jf.intel.com ([10.54.77.22])
	by orsmga005.jf.intel.com with ESMTP; 21 Dec 2016 12:24:23 -0800
From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 12:27:37 -0800
Message-Id: <1482352057-26139-1-git-send-email-jianxun.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] use multiple processes to dump signatures.
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
X-List-Received-Date: Wed, 21 Dec 2016 20:24:22 -0000

This change significantly shortens the time on reparsing stage
of '-S' option.

Each file is reparsed and then dumped within a dedicated
process. The maximum number of the running processes is not
greater than the value of BB_NUMBER_PARSE_THREADS if it is set.

The dump_sigs() in class SignatureGeneratorBasic is _replaced_
by a new dump_sigfn() interface, so calls from the outside and
subclasses are dispatched to the implementation in the base
class of SignatureGeneratorBasic.

Fixes [YOCTO #10352]

Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py | 32 +++++++++++++++++++++++++++-----
 bitbake/lib/bb/siggen.py   |  4 ++--
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 2ad8aad..c7d8d53 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -36,6 +36,7 @@ from bb import msg, data, event
 from bb import monitordisk
 import subprocess
 import pickle
+from multiprocessing import Process
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -1302,15 +1303,36 @@ class RunQueue:
         else:
             self.rqexe.finish()
 
+    def rq_dump_sigfn(self, fn, options):
+        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
+        the_data = bb_cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn))
+        siggen = bb.parse.siggen
+        dataCaches = self.rqdata.dataCaches
+        siggen.dump_sigfn(fn, dataCaches, options)
+
     def dump_signatures(self, options):
-        done = set()
+        fns = set()
         bb.note("Reparsing files to collect dependency data")
-        bb_cache = bb.cache.NoCache(self.cooker.databuilder)
+
         for tid in self.rqdata.runtaskentries:
             fn = fn_from_tid(tid)
-            if fn not in done:
-                the_data = bb_cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn))
-                done.add(fn)
+            fns.add(fn)
+
+        max_process = int(self.cfgData.getVar("BB_NUMBER_PARSE_THREADS") or os.cpu_count() or 1)
+        # We cannot use the real multiprocessing.Pool easily due to some local data
+        # that can't be pickled. This is a cheap multi-process solution.
+        launched = []
+        while fns:
+            if len(launched) < max_process:
+                p = Process(target=self.rq_dump_sigfn, args=(fns.pop(), options))
+                p.start()
+                launched.append(p)
+            for q in launched:
+                # The finished processes are joined when calling is_alive()
+                if not q.is_alive():
+                    launched.remove(q)
+        for p in launched:
+                p.join()
 
         bb.parse.siggen.dump_sigs(self.rqdata.dataCaches, options)
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index b20b9cf..ae50a18 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -307,8 +307,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 pass
             raise err
 
-    def dump_sigs(self, dataCaches, options):
-        for fn in self.taskdeps:
+    def dump_sigfn(self, fn, dataCaches, options):
+        if fn in self.taskdeps:
             for task in self.taskdeps[fn]:
                 tid = fn + ":" + task
                 (mc, _, _) = bb.runqueue.split_tid(tid)
-- 
2.7.4


