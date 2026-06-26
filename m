Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EFAC43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 17:00:49 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39461.1782493248163877348
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 10:00:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NE0p78AU;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e93a16acc6so721728a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493247; x=1783098047; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQigsD1RRMH3ZhVeRtkl5OFMIyalpvEhn8EsyHHRE8c=;
        b=NE0p78AU9cL+kv2S0uTbHhSV9q6FRIohvGeYi2K9cFnM3gMbZN9vBup+nP4h+Jk3lj
         9pRwx5hJWfmgsyATHF5Ai5gchmUwUHIqVTc6CdhA9riaxee0Jigi2Ox3V6q5T6fqkkmn
         J1P7Hl6EUiZk664dJrI/sLhYdpaxZuQRf/UTpGq8r8hUBaZANDCsglTX+05HtJxUyLZz
         i+va+f9sJtxPQ1TXEma8GJprYGOxNyZWr3YBc8YN1xz2zFJcHERkFNmMkm9RQRklj1P4
         nyb5FPy74gAU/ibCQdBZV99iEsX6ndYtjXl2NNKh/HpKt3N2YsrjL9uRcISNQ3GqvLta
         KQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493247; x=1783098047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQigsD1RRMH3ZhVeRtkl5OFMIyalpvEhn8EsyHHRE8c=;
        b=B3XG8pb40YBafCuPc7i/SygV72Nz36OCfoYbbOrv2m4zRyeM7DIOTuHMTZxU4WoVF+
         h5tCbs213CyPafjreya0UQAKrBjBC0mwrnZN3RRPtXG7iptuIzjzcLQS7EJpiEjmbozH
         gjM1c7kB36pM5fiHT3HSN44EfGuPx3Odpo865iQ9+/8P2QcshGU4El3uqriTfq371Tne
         CfKIc9RNIY5GI+pjZLt4tCsughZUTKBpdYG9iWiHlwCiGA+F5VR+FzYMd3lz1jJ3f8ni
         4evPASzsOnrk21iPoLgwJjN1m3bNCC5xWIbhSQcodOCu14WN485FU7ETgNXUehLQo7+Z
         AZSg==
X-Gm-Message-State: AOJu0YzpqzriadunhrAOSn+aoDO+YJKwwH4iL90sOckicq00RX94jFPo
	QFxMYtEwUDZNCfVCFZykeYvfobpOeTKzWcFAbDpaPdOPFEKlO4uJH1woUQwXBw==
X-Gm-Gg: AfdE7cld5TR0JQ4CSUQGOlam/ivPi0jfCVoLuDVyw3cMFFDineAPsci4J84mVRfa6mF
	2dWYQNgILidaiMDvbSHfOtr6ZlhqGs7dHFUrdBJxeAIjcT8EMXG908JngZsTBGo7rEAr6bvUE1e
	87rlhHTOI143wj5FjOLOucadpro3SiUhbTXYu3peRmbzEhkxdXiguHCpMgFZzoTIbFxvgrzpWeB
	nAEp3+39Aa1zOeTDgeOvYrR31nb86dElKGo8MWPBflhOsi2AkkTvbAx/DyJ8mV0fLNobmN7aDPA
	NXW5KShtkfHi/W9SQqlHNlDm9wIhpNUZNFRKlgkV3PFVMLFGSeDrp6P7TBAIHTxfSqow0uBxM6J
	i7G4dm6B+tHViL7j8XdtgOsPu231PqB8w6vaj2sC1DofzxU7sPKSbtsnd2cltww1bKiz+sYaDln
	85RDmTwa5Vlsggnci3j/mZ
X-Received: by 2002:a05:6830:2113:b0:7d7:58b0:7685 with SMTP id 46e09a7af769-7e9b4f38faamr758819a34.13.1782493246916;
        Fri, 26 Jun 2026 10:00:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::51a2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5d3500sm2034714a34.8.2026.06.26.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:00:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bb: Add prefuncs and postfuncs ordering
Date: Fri, 26 Jun 2026 11:00:44 -0600
Message-ID: <20260626170044.3829734-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 17:00:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19792

Adds the ability for functions specified in prefuncs and postfuncs to
specify the order in which they must execute. This allows specific
functions to indicate that they must run first or last (or second,
second to last, etc.) without needing all places in the code that
manipulate the function list to have to agree on how to order them
(a good example of this is sstate.bbclass and buildhistory.bbclass).

Ordering is done similar to how python list indices work; 0 is always
sorted first, 1 is second, -2 is second to last, -1 is last, etc. In the
event of functions having duplicate values, they are grouped together,
but keep their same relative ordering. If one or more functions do not
have an order assigned, they executed between the positive order
functions and the negative order functions, and keep their same relative
order (this means that existing behavior is preserved in the absence of
any ordering information).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../bitbake-user-manual-metadata.rst          | 31 ++++++++++-
 lib/bb/build.py                               | 52 ++++++++++++++++++-
 lib/bb/tests/runqueue-tests/recipes/funcs.inc | 44 ++++++++++++++++
 .../tests/runqueue-tests/recipes/postfuncs.bb | 10 ++++
 .../tests/runqueue-tests/recipes/prefuncs.bb  | 10 ++++
 lib/bb/tests/runqueue.py                      | 26 +++++++++-
 6 files changed, 168 insertions(+), 5 deletions(-)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/funcs.inc
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/postfuncs.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/prefuncs.bb

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 0c7c3ff99..607f98d02 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1827,10 +1827,37 @@ functionality of the task:
          the :term:`BB_NUMBER_THREADS` variable causes ``number_threads`` to
          have no effect.
 
--  ``[postfuncs]``: List of functions to call after the completion of
-   the task.
+-  ``[postfuncs]``: List of functions to call after the completion of the task.
+   Functions specified may set a ``[postfunc-order]`` flag to specify the order
+   in which they will execute. The ordering is based on the way that python
+   does list indexes. The first group of functions executed are those with a
+   positive or zero ``[postfunc-order]`` flag, in increasing order (i.e.  "0"
+   is first, "1" is second, etc.). The next group executed are functions that
+   do not have a ``[postfunc-order]`` flag set, in the relative order they are
+   specified in ``[postfuncs]``. The last group are functions with a negative
+   ``[postfunc-order]`` flag, in increasing order (i.e. "-2" is the second to
+   last, "-1" is the last). If two functions have the same ``[postfunc-order]``
+   value, they will be grouped together, but keep the same relative order they
+   had in ``[postfuncs]``.
+
+-  ``[postfunc-order]``: The order this function will be executed in when
+   listed in ``[postfuncs]``.
 
 -  ``[prefuncs]``: List of functions to call before the task executes.
+   Functions specified may set a ``[prefunc-order]`` flag to specify the order
+   in which they will execute.  The ordering is based on the way that python
+   does list indexes. The first group of functions executed are those with a
+   positive or zero ``[prefunc-order]`` flag, in increasing order (i.e.  "0" is
+   first, "1" is second, etc.). The next group executed are functions that do
+   not have a ``[prefunc-order]`` flag set, in the relative order they are
+   specified in ``[prefuncs]``. The last group are functions with a negative
+   ``[prefunc-order]`` flag, in increasing order (i.e. "-2" is the second to
+   last, "-1" is the last). If two functions have the same ``[prefunc-order]``
+   value, they will be grouped together, but keep the same relative order they
+   had in ``[prefuncs]``.
+
+-  ``[prefunc-order]``: The order this function will be executed in when
+   listed in ``[prefuncs]``.
 
 -  ``[rdepends]``: Controls inter-task runtime dependencies. See the
    :term:`RDEPENDS` variable, the
diff --git a/lib/bb/build.py b/lib/bb/build.py
index 40839a81b..7f8eda083 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -596,6 +596,54 @@ def _task_data(fn, task, d):
     bb.data.expandKeys(localdata)
     return localdata
 
+
+def _sort_funcs(d, funcs, key):
+    """
+    Sorts pre/post functions based on a priority flag of the function. The
+    function can define its order using one of three buckets:
+        1) A positive or zero priority
+        2) No priority
+        3) A negative priority
+
+    When sorting the functions, they are sorted in the following order:
+        1) Functions with positive or zero priority in ascending order
+        2) Functions with no priority in the order they were defined (e.g.
+           their relative priority is preserved)
+        3) Functions with negative priority, in ascending order
+
+    Practically speaking, this implements a similar sorting scheme to python
+    list indexing. "0" will always be the first function exeucted, "1" will be
+    the second (assuming there is a "0"), "-1" will always be the last function
+    executed, and "-2" will be the second to last (assuming there is a "-1").
+
+    Functions with no priority are preserved in their defined order, which keeps
+    this algorithm compatible with simply defining to execution order based on
+    the order in the variable.
+    """
+    # MAX_ORDER_VALUE is arbitrary; it just limits the maximum order priority
+    # that can be assigned to any function
+    MAX_ORDER_VALUE = 10000
+
+    def get_func_key(f):
+        v = d.getVarFlag(f, key, False)
+        if v is None or v == "":
+            return MAX_ORDER_VALUE
+
+        try:
+            v = int(v)
+        except ValueError as e:
+            bb.fatal(f"Invalid value for {prefix}-order varflag on function {f}: {e}")
+
+        if v >= MAX_ORDER_VALUE or v <= -MAX_ORDER_VALUE:
+            bb.fatal(f"Invalid value for {prefix}-order varflag on function {f}: {v} is out of range")
+
+        if v < 0:
+            return (2 * MAX_ORDER_VALUE) + v
+        return v
+
+    return sorted(funcs, key=get_func_key)
+
+
 def _exec_task(fn, task, d, quieterr):
     """Execute a BB 'task'
 
@@ -708,10 +756,10 @@ def _exec_task(fn, task, d, quieterr):
         try:
             event.fire(TaskStarted(task, fn, logfn, flags, localdata), localdata)
 
-            for func in (prefuncs or '').split():
+            for func in _sort_funcs(localdata, (prefuncs or '').split(), "prefunc-order"):
                 exec_func(func, localdata)
             exec_func(task, localdata)
-            for func in (postfuncs or '').split():
+            for func in _sort_funcs(localdata, (postfuncs or '').split(), "postfunc-order"):
                 exec_func(func, localdata)
         finally:
             # Need to flush and close the logs before sending events where the
diff --git a/lib/bb/tests/runqueue-tests/recipes/funcs.inc b/lib/bb/tests/runqueue-tests/recipes/funcs.inc
new file mode 100644
index 000000000..5e72b819e
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/funcs.inc
@@ -0,0 +1,44 @@
+TASKS = ""
+
+python do_build:append() {
+    d.appendVar("TASKS", " build")
+}
+
+python func_1() {
+    d.appendVar("TASKS", " 1")
+}
+
+python func_2() {
+    d.appendVar("TASKS", " 2")
+}
+
+python func_3() {
+    d.appendVar("TASKS", " 3")
+}
+
+python func_4() {
+    d.appendVar("TASKS", " 4")
+}
+
+python func_5() {
+    d.appendVar("TASKS", " 5")
+}
+
+python func_6() {
+    d.appendVar("TASKS", " 6")
+}
+
+python func_7() {
+    d.appendVar("TASKS", " 7")
+}
+
+python func_8() {
+    d.appendVar("TASKS", " 8")
+}
+
+python write_log() {
+    with open(d.getVar("ORDER_LOG"), "w") as f:
+        f.write(d.getVar("TASKS"))
+}
+write_log[postfunc-order] = "-1"
+do_build[postfuncs] += "write_log"
diff --git a/lib/bb/tests/runqueue-tests/recipes/postfuncs.bb b/lib/bb/tests/runqueue-tests/recipes/postfuncs.bb
new file mode 100644
index 000000000..be82b7302
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/postfuncs.bb
@@ -0,0 +1,10 @@
+require funcs.inc
+
+do_build[postfuncs] += "func_8 func_6 func_7 func_4 func_5 func_2 func_3 func_1"
+
+func_1[postfunc-order] = "0"
+func_2[postfunc-order] = "1"
+func_3[postfunc-order] = "1"
+func_6[postfunc-order] = "-3"
+func_7[postfunc-order] = "-3"
+func_8[postfunc-order] = "-2"
diff --git a/lib/bb/tests/runqueue-tests/recipes/prefuncs.bb b/lib/bb/tests/runqueue-tests/recipes/prefuncs.bb
new file mode 100644
index 000000000..6c8d1e380
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/prefuncs.bb
@@ -0,0 +1,10 @@
+require funcs.inc
+
+do_build[prefuncs] += "func_8 func_6 func_7 func_4 func_5 func_2 func_3 func_1"
+
+func_1[prefunc-order] = "0"
+func_2[prefunc-order] = "1"
+func_3[prefunc-order] = "1"
+func_6[prefunc-order] = "-3"
+func_7[prefunc-order] = "-3"
+func_8[prefunc-order] = "-2"
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 74f5ded2e..ecc6ab6db 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -12,6 +12,7 @@ import tempfile
 import subprocess
 import sys
 import time
+from contextlib import contextmanager
 
 #
 # TODO:
@@ -53,6 +54,14 @@ class RunQueueTests(unittest.TestCase):
                 os.remove(tasklog)
         return tasks
 
+    @contextmanager
+    def tempdir(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            try:
+                yield tempdir
+            finally:
+                self.shutdown(tempdir)
+
     def test_no_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -403,8 +412,23 @@ class RunQueueTests(unittest.TestCase):
 
             self.shutdown(tempdir)
 
+    def test_postfuncs(self):
+        with self.tempdir() as tempdir:
+            log = f"{tempdir}/postlog.txt"
+            tasks = self.run_bitbakecmd(["bitbake", "postfuncs"], tempdir, extraenv={"ORDER_LOG": log})
+            self.assertTrue(os.path.exists(log), "Log file not written")
+            with open(log, "r") as f:
+                self.assertEqual(f.read(), " build 1 2 3 4 5 6 7 8")
+
+    def test_prefuncs(self):
+        with self.tempdir() as tempdir:
+            log = f"{tempdir}/prelog.txt"
+            tasks = self.run_bitbakecmd(["bitbake", "prefuncs"], tempdir, extraenv={"ORDER_LOG": log})
+            self.assertTrue(os.path.exists(log), "Log file not written")
+            with open(log, "r") as f:
+                self.assertEqual(f.read(), " 1 2 3 4 5 6 7 8 build")
+
     def shutdown(self, tempdir):
         # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
         while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal") or os.path.exists(tempdir + "/bitbake.lock")):
             time.sleep(0.5)
-
-- 
2.54.0


