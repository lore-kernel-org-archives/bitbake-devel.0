Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id B6CB17EFE9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 16:12:28 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id j8so2845184wrj.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 09:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Ce4OM/P78v28m0M+UXQeS5FoXtyMgSE5Pw3KUcxitmM=;
	b=XMBycVC1qFklVI65odrXFs+ccpYHKpWZrQsIF0o5cD6j5zQuImRGrLaV/rO8lHjGpX
	fehpcJO4g8fexvoRYR1NiwpKa79nM1joQkz5uGV+XTkPK/Im4LSAJpPgRjABsm20gvg9
	VzF02OvclGN+MO5LFTNmXxNV2H1ipcOvwYPoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Ce4OM/P78v28m0M+UXQeS5FoXtyMgSE5Pw3KUcxitmM=;
	b=DbOOtArDBenH4GIqJil4/IA+iWoyO3/xef347+CPF6fusEHPcRqq4cfJrf19lxXFl2
	lKM43tnYVEflbkmEU2oIIWyeT1O8L69MXIccKKZ5/DD8qsBIQEOpAfVb2C46PwnP7AMs
	ylBfO78s1nYNndPN4LrF8I6zZ9BDthOTbUS+0JaLYbDQDPmPSoPSQ0xPFl1fMhiowvxw
	KeuvAx4Y4CpiwrJEOTp2l1rbB9V5lAWCMqW0+QGaZF7twr+B4GjGyD0RnR6MGaZGuqVp
	gY4riv8f+c+yICda+7Wsiv9hLQ9YD0OBfAhWJ7pzohAk93Q5ARPiCFXM2E00gSidw6KE
	wdgw==
X-Gm-Message-State: APjAAAXEoezyufuPiDavZv4usHA95ATG9ZduexYFKAMK0AqWSrIELG4U
	coukUk3ymjB9G4r71Z2OusyeANhi3Tc=
X-Google-Smtp-Source: APXvYqylZ+xVmEW7RiTrrsDcbJViN6Q1oobMdGzFNbQSB0MhjViMTg02/DR2jQChvS6bglSFpBaOEQ==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr5881191wrt.20.1562861549084;
	Thu, 11 Jul 2019 09:12:29 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	c7sm4841279wro.70.2019.07.11.09.12.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 11 Jul 2019 09:12:28 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 17:12:23 +0100
Message-Id: <20190711161223.12376-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
References: <20190711161223.12376-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 5/5] runqueue: Optimise multiconfig with overlapping setscene
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
X-List-Received-Date: Thu, 11 Jul 2019 16:12:29 -0000
Content-Transfer-Encoding: 8bit

Currently if a multiconfig build has setscene tasks which share the same
hash but it wasn't present in an sstate cache at the start of the build,
the tasks would all rebuild the same artefact.

This changes the code to spot this and start building the first hash whilst
holding the other tasks in the scenequeue. When the first task finishes,
the others in the scenequeue are allowed to proceed and should then be able
to take advantage of a shared sstate directory.

This change adds in a unit test for this which complicates the testing
metadata slight more. In particular comments are added to the tasks to
ensure they do have differing signatures to make the test results more
obvious and as expected.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py                            | 22 +++++++++++++++----
 .../tests/runqueue-tests/classes/base.bbclass | 19 +++++++++++++++-
 lib/bb/tests/runqueue-tests/conf/bitbake.conf |  9 ++++++--
 .../runqueue-tests/conf/multiconfig/mc1.conf  |  1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |  1 +
 lib/bb/tests/runqueue.py                      | 19 ++++++++++++++++
 6 files changed, 64 insertions(+), 7 deletions(-)
 create mode 100644 lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
 create mode 100644 lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 624cc756fd..6f9ac5e46c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1701,6 +1701,7 @@ class RunQueueExecute:
         self.build_stamps = {}
         self.build_stamps2 = []
         self.failed_tids = []
+        self.pending_hashes = {}
 
         self.stampcache = {}
 
@@ -1868,6 +1869,10 @@ class RunQueueExecute:
             if alldeps:
                 self.setbuildable(revdep)
                 logger.debug(1, "Marking task %s as buildable", revdep)
+        if task in self.rqdata.runq_setscene_tids:
+           h = self.rqdata.runtaskentries[task].hash
+           if h in self.pending_hashes:
+               del self.pending_hashes[h]
 
     def task_complete(self, task):
         self.stats.taskCompleted()
@@ -1899,20 +1904,25 @@ class RunQueueExecute:
         """
 
         self.rq.read_workers()
+        pending = 0
 
         task = None
         if not self.sqdone and self.can_start_task():
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
+                    if self.rqdata.runtaskentries[nexttask].hash in self.pending_hashes:
+                        pending += 1
+                        # This setscene task has a hash matching something we're currently building, so wait
+                        continue
+                    if nexttask in self.sqdata.unskippable:
+                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     task = nexttask
                     break
         if task is not None:
@@ -1963,7 +1973,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if not self.sq_live and not self.sqdone:
+        if not self.sq_live and not self.sqdone and not pending:
             logger.info("Setscene tasks completed")
             logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
@@ -2232,6 +2242,8 @@ class RunQueueExecute:
         bb.event.fire(sceneQueueTaskFailed(task, self.sq_stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.tasks_notcovered.add(task)
+        h = self.rqdata.runtaskentries[task].hash
+        self.pending_hashes[h] = task
         self.scenequeue_updatecounters(task, True)
         self.sq_check_taskfail(task)
 
@@ -2242,6 +2254,8 @@ class RunQueueExecute:
         self.sq_stats.taskCompleted()
         self.scenequeue_notcovered.add(task)
         self.tasks_notcovered.add(task)
+        h = self.rqdata.runtaskentries[task].hash
+        self.pending_hashes[h] = task
         self.scenequeue_updatecounters(task, True)
 
     def sq_task_skip(self, task):
@@ -2546,7 +2560,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             valid_new.append(sq_task[v])
 
         for tid in sqdata.sq_revdeps:
-            if tid not in valid_new and tid not in noexec:
+            if tid not in valid_new and tid not in noexec and rqdata.runtaskentries[tid].hash not in sqrq.pending_hashes:
                 logger.debug(2, 'No package found, so skipping setscene task %s', tid)
                 sqrq.sq_task_failoutright(tid)
 
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


