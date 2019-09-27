Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id A11507F31C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 12:33:50 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id h7so2531964wrw.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=XbD5idM3hs2kDJ3dFZcaQ4Bu67X35Q4wxPMcV4hnymg=;
	b=OAfehmkVE5sLPp0YiYiyzlMR4QkBxOwKaY0InZoaX5fp514Kr5ETHGCVj27FdD9pn9
	uaKQfd7T/qatOyClZZMW9yanqXRjSzo9YI79Ze/nnqJ83uFt2OcIIRNkSIZxA5J4q+u5
	gZr7tSeFenaNsz9OvgZSI0euWixUqmMTEIXNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=XbD5idM3hs2kDJ3dFZcaQ4Bu67X35Q4wxPMcV4hnymg=;
	b=BqkBR1Cr6/S5DhB3QwRSmtDvPNqCn3RgPDpiVFCmDxsq+6WdUhtFgeO8dGuzs8TtUH
	3WVqWDxjJs5JwaOpuFB7ZGcmI7pPoUf/hE66TgB8QIIDobSpm+3CaCdRBLAfMdFqzb73
	DlbpbtvDV2499IJOul22NdbqWajDlTgKDVAFGT8fYZcwxkLRnRsyJUCIsoO5HLdO0AR2
	1UFoNGK9T9JGttM+diPdrLbMM3Nsx3WPAR4CCzyle+9qYpU7jowXU6Kmywzr1Q2QyelB
	IZ3Qwam3aT9+vnWLzTaFW/L7Ux6ZrZE5RzJ9KawSmY60Yaa8GjvYymFdeZ+gmgYaYNMx
	R6Ig==
X-Gm-Message-State: APjAAAW1ufSmygkEW5CHhof/mtuYXzDgANAokrkVhp9RyAIDMVyMWVOS
	aO4o4qpewkua4bZwH7yMhs1CrP3t0zo=
X-Google-Smtp-Source: APXvYqzHGSVCLScc5H5qWZFoJopbzgwfIsbYaUJraxSFqnfWeTnV6lu5cyVzMvpichyqD8tniKdc+Q==
X-Received: by 2002:adf:f00b:: with SMTP id j11mr2629000wro.298.1569587630917; 
	Fri, 27 Sep 2019 05:33:50 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	g73sm6543031wme.10.2019.09.27.05.33.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 27 Sep 2019 05:33:50 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 27 Sep 2019 13:33:40 +0100
Message-Id: <20190927123347.19276-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
References: <20190927123347.19276-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/9] runqueue: Fix task migration problems
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
X-List-Received-Date: Fri, 27 Sep 2019 12:33:51 -0000
Content-Transfer-Encoding: 8bit

Tasks were not migrating consistently, particularly:

* if a task was rehashed which had already run
* if a task which was valid became invalid due to a rehash

We need to always run the migration code for rehashed tasks and then
reprocess them for hash validity. This means rearranging the code.

It also means several tests are no longer correct and can't be written
correctly to work on all possible workflows so those are removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py       | 99 ++++++++++++++++++++++------------------
 lib/bb/tests/runqueue.py | 89 ------------------------------------
 2 files changed, 55 insertions(+), 133 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index d9a67a3167..02160ef4d7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -73,7 +73,7 @@ def build_tid(mc, fn, taskname):
 def pending_hash_index(tid, rqdata):
     (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
     pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
-    h = rqdata.runtaskentries[tid].hash
+    h = rqdata.runtaskentries[tid].unihash
     return pn + ":" + "taskname" + h
 
 class RunQueueStats:
@@ -2299,9 +2299,6 @@ class RunQueueExecute:
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
-            valid = self.rq.validate_hashes(set([tid]), self.cooker.data, None, False)
-            if not valid:
-                continue
             if tid in self.runq_running:
                 continue
             if tid not in self.pending_migrations:
@@ -2358,6 +2355,7 @@ class RunQueueExecute:
 
             logger.info("Setscene task %s now valid and being rerun" % tid)
             self.sqdone = False
+            update_scenequeue_data([tid], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
         if changed:
             self.holdoff_need_update = True
@@ -2674,64 +2672,77 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     rqdata.init_progress_reporter.next_stage()
 
-    multiconfigs = set()
+    sqdata.multiconfigs = set()
     for tid in sqdata.sq_revdeps:
-        multiconfigs.add(mc_from_tid(tid))
+        sqdata.multiconfigs.add(mc_from_tid(tid))
         if len(sqdata.sq_revdeps[tid]) == 0:
             sqrq.sq_buildable.add(tid)
 
     rqdata.init_progress_reporter.finish()
 
-    if rq.hashvalidate:
-        noexec = []
-        stamppresent = []
-        tocheck = set()
+    sqdata.noexec = set()
+    sqdata.stamppresent = set()
+    sqdata.valid = set()
 
-        for tid in sorted(sqdata.sq_revdeps):
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+    update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq)
 
-            taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
+def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
-            if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                noexec.append(tid)
-                sqrq.sq_task_skip(tid)
-                bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
-                continue
+    tocheck = set()
 
-            if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
-                logger.debug(2, 'Setscene stamp current for task %s', tid)
-                stamppresent.append(tid)
-                sqrq.sq_task_skip(tid)
-                continue
+    for tid in sorted(tids):
+        if tid in sqdata.stamppresent:
+            sqdata.stamppresent.remove(tid)
+        if tid in sqdata.valid:
+            sqdata.valid.remove(tid)
 
-            if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
-                logger.debug(2, 'Normal stamp current for task %s', tid)
-                stamppresent.append(tid)
-                sqrq.sq_task_skip(tid)
-                continue
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
-            tocheck.add(tid)
+        taskdep = rqdata.dataCaches[mc].task_deps[taskfn]
 
-        valid = rq.validate_hashes(tocheck, cooker.data, len(stamppresent), False)
+        if 'noexec' in taskdep and taskname in taskdep['noexec']:
+            sqdata.noexec.add(tid)
+            sqrq.sq_task_skip(tid)
+            bb.build.make_stamp(taskname + "_setscene", rqdata.dataCaches[mc], taskfn)
+            continue
+
+        if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
+            logger.debug(2, 'Setscene stamp current for task %s', tid)
+            sqdata.stamppresent.add(tid)
+            sqrq.sq_task_skip(tid)
+            continue
 
-        valid_new = stamppresent
-        for v in valid:
-            valid_new.append(v)
+        if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
+            logger.debug(2, 'Normal stamp current for task %s', tid)
+            sqdata.stamppresent.add(tid)
+            sqrq.sq_task_skip(tid)
+            continue
 
-        hashes = {}
-        for mc in sorted(multiconfigs):
-          for tid in sorted(sqdata.sq_revdeps):
+        tocheck.add(tid)
+
+    sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False)
+
+    sqdata.hashes = {}
+    for mc in sorted(sqdata.multiconfigs):
+        for tid in sorted(sqdata.sq_revdeps):
             if mc_from_tid(tid) != mc:
                 continue
-            if tid not in valid_new and tid not in noexec and tid not in sqrq.scenequeue_notcovered:
-                sqdata.outrightfail.add(tid)
+            if tid in sqdata.stamppresent:
+                continue
+            if tid in sqdata.valid:
+                continue
+            if tid in sqdata.noexec:
+                continue
+            if tid in sqrq.scenequeue_notcovered:
+                continue
+            sqdata.outrightfail.add(tid)
 
-                h = pending_hash_index(tid, rqdata)
-                if h not in hashes:
-                    hashes[h] = tid
-                else:
-                    sqrq.sq_deferred[tid] = hashes[h]
-                    bb.warn("Deferring %s after %s" % (tid, hashes[h]))
+            h = pending_hash_index(tid, rqdata)
+            if h not in sqdata.hashes:
+                sqdata.hashes[h] = tid
+            else:
+                sqrq.sq_deferred[tid] = sqdata.hashes[h]
+                bb.warn("Deferring %s after %s" % (tid, sqdata.hashes[h]))
 
 
 class TaskFailure(Exception):
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index cb4d526f13..01b992c47c 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -312,92 +312,3 @@ class RunQueueTests(unittest.TestCase):
                 else:
                     self.assertEqual(tasks.count(i), 1, "%s not in task list once" % i)
 
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
-    def test_hashserv_partial_match(self):
-        # e1:do_package matches initial built but not second hash value
-        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-            extraenv = {
-                "BB_HASHSERVE" : "auto",
-                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
-            }
-            cmd = ["bitbake", "a1", "b1"]
-            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
-                             'populate_sysroot_setscene', 'package_qa_setscene']
-            sstatevalid = ""
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
-            self.assertEqual(set(tasks), set(expected))
-            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
-               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
-            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
-               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
-            cmd = ["bitbake", "e1"]
-            sstatevalid = "e1:do_package:685e69a026b2f029483fdefe6a11e1e06641dd2a0f6f86e27b9b550f8f21229d"
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
-                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
-                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
-                        'e1:package_setscene'] + ['e1:' + x for x in self.alltasks]
-            expected.remove('e1:package')
-            self.assertEqual(set(tasks), set(expected))
-
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
-    def test_hashserv_partial_match2(self):
-        # e1:do_package + e1:do_populate_sysroot matches initial built but not second hash value
-        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-            extraenv = {
-                "BB_HASHSERVE" : "auto",
-                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
-            }
-            cmd = ["bitbake", "a1", "b1"]
-            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
-                             'populate_sysroot_setscene', 'package_qa_setscene']
-            sstatevalid = ""
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
-            self.assertEqual(set(tasks), set(expected))
-            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
-               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
-            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
-               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
-            cmd = ["bitbake", "e1"]
-            sstatevalid = "e1:do_package:685e69a026b2f029483fdefe6a11e1e06641dd2a0f6f86e27b9b550f8f21229d e1:do_populate_sysroot:ef7dc0e2dd55d0534e75cba50731ff42f949818b6f29a65d72bc05856e56711d"
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
-                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
-                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
-                        'e1:package_setscene', 'e1:populate_sysroot_setscene', 'e1:build', 'e1:package_qa', 'e1:package_write_rpm', 'e1:package_write_ipk', 'e1:packagedata']
-            self.assertEqual(set(tasks), set(expected))
-
-    @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
-    def test_hashserv_partial_match3(self):
-        # e1:do_package is valid for a1 but not after b1
-        # In former buggy code, this triggered e1:do_fetch, then e1:do_populate_sysroot to run
-        # with none of the intermediate tasks which is a serious bug
-        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-            extraenv = {
-                "BB_HASHSERVE" : "auto",
-                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
-            }
-            cmd = ["bitbake", "a1", "b1"]
-            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
-                             'populate_sysroot_setscene', 'package_qa_setscene']
-            sstatevalid = ""
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
-            self.assertEqual(set(tasks), set(expected))
-            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
-               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
-            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
-               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
-            cmd = ["bitbake", "e1", "-DD"]
-            sstatevalid = "e1:do_package:af056eae12a733a6a8c4f4da8c6757e588e13565852c94e2aad4d953a3989c13 e1:do_package:a3677703db82b22d28d57c1820a47851dd780104580863f5bd32e66e003a779d"
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True, slowtasks="e1:fetch b1:install")
-            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
-                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
-                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
-                        'e1:package_setscene']  + ['e1:' + x for x in self.alltasks]
-            expected.remove('e1:package')
-            self.assertEqual(set(tasks), set(expected))
-
-
-- 
2.20.1


