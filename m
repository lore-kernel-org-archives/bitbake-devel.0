Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
	[209.85.221.45])
	by mail.openembedded.org (Postfix) with ESMTP id BBFD67F11D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 15:22:15 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id f9so10334812wre.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wNmqqftcxdkWIlSHEYehLSXSn1nqJ3Jkn76ywWlpd8Q=;
	b=iNa334v7K4mDknFz7x3/6pMnMAglO6/dxivP/GVte0bh42FHWqBH/7uB8F1TJ8DZn9
	cIKetJPrO5Yl2IiFhUmMYqkHhHUy0C8Ne7IZjIoynzNwbQkJjzuEts0QTVIAOCXW6OwE
	TeEAMEZe39NOsKxNJL250c0K/UMRS6gCvCq3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=wNmqqftcxdkWIlSHEYehLSXSn1nqJ3Jkn76ywWlpd8Q=;
	b=KwUFupbX+cSAcFp64iCEFKmO9+pqTcEa0oZp2mDkQEWzrZfQh7Kx8aYte1r2e5fxzm
	yTaJxV83ExzQC2BRv2YsyraVdImPnxmvAE1xuLhjdvWA7t5CLKLNWfabk9nlvZNQlNji
	y7SJqrjmMVS0IIsmHLLv8Q6Ds5N8bqfTY34rB95mMaPiuvp9M2Rl3RlsM23GcrC3Jf+s
	8uUWiFLGwi9lAGwOeLMjTu1g0mS7LIy+nVwZZNYin9f7ftpTyKUd411MdUuCMaFn6l3P
	93MQw7d6F6AnZCuT3x64eW1MH0uXqYDVwuMfNvIscTFx0TJuEaRqDYkSs9hpPHxgWaUK
	jZWw==
X-Gm-Message-State: APjAAAVu2qRz5mHz516475Mh/Y+2Ix3962vYoPeGpr4sIOTXARtNEEXf
	CLWHrWiqvkteYTxj8nzwjNmYUHgIwPU=
X-Google-Smtp-Source: APXvYqw/FQNUIcCIWoQQQY+U+HBHX1TAFjMENpGWd/qY+3W6g9jSGaBMZwvTGwxav62J9yVhMChBYw==
X-Received: by 2002:adf:b60c:: with SMTP id f12mr12541898wre.231.1562944935988;
	Fri, 12 Jul 2019 08:22:15 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	d10sm10755988wro.18.2019.07.12.08.22.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 12 Jul 2019 08:22:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Jul 2019 16:22:14 +0100
Message-Id: <20190712152214.20201-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Optimise multiconfig with overlapping setscene
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
X-List-Received-Date: Fri, 12 Jul 2019 15:22:16 -0000
Content-Transfer-Encoding: 8bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py                            | 60 ++++++++++++++++---
 .../tests/runqueue-tests/classes/base.bbclass | 19 +++++-
 lib/bb/tests/runqueue-tests/conf/bitbake.conf |  9 ++-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |  1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |  1 +
 lib/bb/tests/runqueue.py                      | 19 ++++++
 6 files changed, 99 insertions(+), 10 deletions(-)
 create mode 100644 lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
 create mode 100644 lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1cc2bf267c..1a689e5073 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -68,6 +68,14 @@ def build_tid(mc, fn, taskname):
         return "mc:" + mc + ":" + fn + ":" + taskname
     return fn + ":" + taskname
 
+# Index used to pair up potentially matching multiconfig tasks
+# We match on PN, taskname and hash being equal
+def pending_hash_index(tid, rqdata):
+    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+    pn = rqdata.dataCaches[mc].pkg_fn[taskfn]
+    h = rqdata.runtaskentries[tid].hash
+    return pn + ":" + "taskname" + h
+
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -1717,6 +1725,8 @@ class RunQueueExecute:
         self.build_stamps = {}
         self.build_stamps2 = []
         self.failed_tids = []
+        self.pending_hashes = {}
+        self.sq_deferred = set()
 
         self.stampcache = {}
 
@@ -1884,6 +1894,10 @@ class RunQueueExecute:
             if alldeps:
                 self.setbuildable(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
+        if task in self.rqdata.runq_setscene_tids:
+           h = pending_hash_index(task, self.rqdata)
+           if h in self.pending_hashes:
+               del self.pending_hashes[h]
 
     def task_complete(self, task):
         self.stats.taskCompleted()
@@ -1921,14 +1935,25 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.rqdata.runq_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask in self.sqdata.unskippable:
-                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
                             logger.debug(2, "Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
+                    if pending_hash_index(nexttask, self.rqdata) in self.pending_hashes:
+                        # This setscene task has a hash matching something we're currently building, so wait
+                        continue
+                    if nexttask in self.sq_deferred:
+                        logger.debug(1, "Task %s no longer deferred" % nexttask)
+                        self.sq_deferred.remove(nexttask)
+                        valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, None, False)
+                        if not valid:
+                            logger.debug(1, "%s didn't become valid, skipping setscene" % nexttask)
+                            self.sq_task_failoutright(nexttask)
+                            return True
+                    if nexttask in self.sqdata.unskippable:
+                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     task = nexttask
                     break
         if task is not None:
@@ -1979,7 +2004,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if not self.sq_live and not self.sqdone:
+        if not self.sq_live and not self.sqdone and not self.sq_deferred:
             logger.info("Setscene tasks completed")
             logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
@@ -2080,6 +2105,13 @@ class RunQueueExecute:
             self.rq.read_workers()
             return self.rq.active_fds()
 
+        # No more tasks can be run. If we have deferred setscene tasks we should run them.
+        if self.sq_deferred:
+            tid = self.sq_deferred.pop()
+            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
+            self.sq_task_failoutright(tid)
+            return True
+
         if len(self.failed_tids) != 0:
             self.rq.state = runQueueFailed
             return True
@@ -2248,6 +2280,8 @@ class RunQueueExecute:
         bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.tasks_notcovered.add(task)
+        h = pending_hash_index(task, self.rqdata)
+        self.pending_hashes[h] = task
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
 
@@ -2258,6 +2292,8 @@ class RunQueueExecute:
         self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.tasks_notcovered.add(task)
+        h = pending_hash_index(task, self.rqdata)
+        self.pending_hashes[h] = task
         self.scenequeue_updatecounters(task, True)
 
     def sq_task_skip(self, task):
@@ -2505,7 +2541,9 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     rqdata.init_progress_reporter.next_stage()
 
+    multiconfigs = set()
     for tid in sqdata.sq_revdeps:
+        multiconfigs.add(mc_from_tid(tid))
         if len(sqdata.sq_revdeps[tid]) == 0:
             sqrq.sq_buildable.add(tid)
 
@@ -2547,10 +2585,18 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         for v in valid:
             valid_new.append(v)
 
-        for tid in sqdata.sq_revdeps:
-            if tid not in valid_new and tid not in noexec:
-                logger.debug(2, 'No package found, so skipping setscene task %s', tid)
-                sqrq.sq_task_failoutright(tid)
+        for mc in sorted(multiconfigs):
+            for tid in sqdata.sq_revdeps:
+                if mc_from_tid(tid) != mc:
+                    continue
+                if tid not in valid_new and tid not in noexec and tid not in sqrq.scenequeue_notcovered:
+                    h = pending_hash_index(tid, rqdata)
+                    if h in sqrq.pending_hashes:
+                        logger.debug(1, "Deferring %s due to %s" % (tid, sqrq.pending_hashes[h]))
+                        sqrq.sq_deferred.add(tid)
+                        continue
+                    logger.debug(2, 'No package found, so skipping setscene task %s', tid)
+                    sqrq.sq_task_failoutright(tid)
 
 class TaskFailure(Exception):
     """
diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index e81df7ac42..b966568dc7 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -4,7 +4,9 @@ SSTATEVALID ??= ""
 def stamptask(d):
     import time
 
-    thistask = d.expand("${PN}:${BB_CURRENTTASK}") 
+    thistask = d.expand("${PN}:${BB_CURRENTTASK}")
+    if d.getVar("BB_CURRENT_MC") != "default":
+        thistask = d.expand("${BB_CURRENT_MC}:${PN}:${BB_CURRENTTASK}")
     if thistask in d.getVar("SLOWTASKS").split():
         bb.note("Slowing task %s" % thistask)
         time.sleep(0.5)
@@ -13,48 +15,63 @@ def stamptask(d):
         f.write(thistask + "\n")
 
 python do_fetch() {
+    # fetch
     stamptask(d)
 }
 python do_unpack() {
+    # unpack
     stamptask(d)
 }
 python do_patch() {
+    # patch
     stamptask(d)
 }
 python do_populate_lic() {
+    # populate_lic
     stamptask(d)
 }
 python do_prepare_recipe_sysroot() {
+    # prepare_recipe_sysroot
     stamptask(d)
 }
 python do_configure() {
+    # configure
     stamptask(d)
 }
 python do_compile() {
+    # compile
     stamptask(d)
 }
 python do_install() {
+    # install
     stamptask(d)
 }
 python do_populate_sysroot() {
+    # populate_sysroot
     stamptask(d)
 }
 python do_package() {
+    # package
     stamptask(d)
 }
 python do_package_write_ipk() {
+    # package_write_ipk
     stamptask(d)
 }
 python do_package_write_rpm() {
+    # package_write_rpm
     stamptask(d)
 }
 python do_packagedata() {
+    # packagedata
     stamptask(d)
 }
 python do_package_qa() {
+    # package_qa
     stamptask(d)
 }
 python do_build() {
+    # build
     stamptask(d)
 }
 do_prepare_recipe_sysroot[deptask] = "do_populate_sysroot"
diff --git a/lib/bb/tests/runqueue-tests/conf/bitbake.conf b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
index cccd677966..d87ded29a7 100644
--- a/lib/bb/tests/runqueue-tests/conf/bitbake.conf
+++ b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
@@ -5,6 +5,11 @@ BBFILES = "${COREBASE}/recipes/*.bb"
 PROVIDES = "${PN}"
 PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0]}"
 export PATH
-STAMP = "${TOPDIR}/stamps/${PN}"
-T = "${TOPDIR}/workdir/${PN}/temp"
+TMPDIR ??= "${TOPDIR}"
+STAMP = "${TMPDIR}/stamps/${PN}"
+T = "${TMPDIR}/workdir/${PN}/temp"
 BB_NUMBER_THREADS = "4"
+
+BB_HASHBASE_WHITELIST = "BB_CURRENT_MC"
+
+include conf/multiconfig/${BB_CURRENT_MC}.conf
diff --git a/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
new file mode 100644
index 0000000000..ecf23e1c73
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
@@ -0,0 +1 @@
+TMPDIR = "${TOPDIR}/mc1/"
diff --git a/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
new file mode 100644
index 0000000000..eef338e4cc
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
@@ -0,0 +1 @@
+TMPDIR = "${TOPDIR}/mc2/"
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index b1a23bc5d4..8b29fde864 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -189,3 +189,22 @@ class RunQueueTests(unittest.TestCase):
                         'b1:packagedata_setscene', 'b1:package_qa_setscene', 'b1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+    def test_multiconfig_setscene_optimise(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BBMULTICONFIG" : "mc1 mc2",
+                "BB_SIGNATURE_HANDLER" : "basic"
+            }
+            cmd = ["bitbake", "b1", "mc:mc1:b1", "mc:mc2:b1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks] + \
+                       ['mc1:b1:' + x for x in setscenetasks] + ['mc1:a1:' + x for x in setscenetasks] + \
+                       ['mc2:b1:' + x for x in setscenetasks] + ['mc2:a1:' + x for x in setscenetasks] + \
+                       ['mc1:b1:build', 'mc2:b1:build']
+            for x in ['mc1:a1:package_qa_setscene', 'mc2:a1:package_qa_setscene', 'a1:build', 'a1:package_qa']:
+                expected.remove(x)
+            self.assertEqual(set(tasks), set(expected))
+
-- 
2.20.1


