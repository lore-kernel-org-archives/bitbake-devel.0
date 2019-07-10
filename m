Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
	[209.85.221.48])
	by mail.openembedded.org (Postfix) with ESMTP id 408E17F067
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:46 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id p13so4203664wru.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=31rK08Xz5/uRY6RuwEmd8TNYjlvqxXbau4xhJgPdlas=;
	b=bdkJ1bfmuDkUv4c5PH+NVujwDZI1oO/JIO8D/OHNb+cDwK++l811f2zo5vt0SSvdAF
	1oYj3bf3xAZqNFp1bOdLxkvEKHZs0vBk5UOdZFrC8fusWpvEVu4/0SfkW6TUxcaWuvDl
	rDNB+r5KJCP7OvQgmmunY1TVF6apcLGGILAoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=31rK08Xz5/uRY6RuwEmd8TNYjlvqxXbau4xhJgPdlas=;
	b=q42VoYjYeH23MUzoTBGx2mopa7DYvT6modjeM1C/x+xXMmZnh0x/NkN0jZExtqcLD2
	mMozDGxr7KA0DLcU24NoZZhRvkim58u1c9kT5lyp3OYm2Aspj6wOLKt5R6pejOOLAEn3
	cpSCD/UPhHvVc03qWkApswyJalJuEf2mmrO0gMziSjMDsNmVrO4XsX8zfaPrYUP/6Sqv
	sKXRNHuwQGMSGeqzuL45zrp5OSm9HNwGbJyCbasNj4S9USYcUOyg64crgCsFOwx11gyP
	Kq6BHO1YwGeqz0HUPPab1p97Ic+cO84D0xg5dHQDtkVRRvveuN7Ko2EcEJFY2KbL4Hs1
	/ivQ==
X-Gm-Message-State: APjAAAVi3MHtaka2yQ4MrZUMtRCS6FnriWqPbDRv1XDnCyhbBA55FvMx
	QXz3bH4T5Zc5LLEIEd4NONXJ27rx5vE=
X-Google-Smtp-Source: APXvYqxtXMogVxW6CaryrL0iqGacL0aQIRnMkajnl+DuGNG1wMkoMWL69HdHiC0XyEMrht6RCMCCbw==
X-Received: by 2002:a5d:5152:: with SMTP id u18mr249479wrt.9.1562802886398;
	Wed, 10 Jul 2019 16:54:46 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.45
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:20 +0100
Message-Id: <20190710235420.23825-26-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 26/26] tests: Add initial scenario based test for runqueue
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:46 -0000
Content-Transfer-Encoding: 8bit

We need some tests for runqueue, its been something which has been hard to test
for a long time. Add some dummy metadata to allow this, mirroring the OE
structure in spirit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-selftest                          |   1 +
 .../tests/runqueue-tests/classes/base.bbclass | 219 ++++++++++++++++++
 .../runqueue-tests/classes/image.bbclass      |   5 +
 .../runqueue-tests/classes/native.bbclass     |   2 +
 lib/bb/tests/runqueue-tests/conf/bitbake.conf |  10 +
 lib/bb/tests/runqueue-tests/recipes/a1.bb     |   0
 lib/bb/tests/runqueue-tests/recipes/b1.bb     |   1 +
 lib/bb/tests/runqueue-tests/recipes/c1.bb     |   0
 lib/bb/tests/runqueue-tests/recipes/d1.bb     |   3 +
 lib/bb/tests/runqueue.py                      | 191 +++++++++++++++
 10 files changed, 432 insertions(+)
 create mode 100644 lib/bb/tests/runqueue-tests/classes/base.bbclass
 create mode 100644 lib/bb/tests/runqueue-tests/classes/image.bbclass
 create mode 100644 lib/bb/tests/runqueue-tests/classes/native.bbclass
 create mode 100644 lib/bb/tests/runqueue-tests/conf/bitbake.conf
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/a1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/b1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/c1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/d1.bb
 create mode 100644 lib/bb/tests/runqueue.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 20553e9814..041a2719f0 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -25,6 +25,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.fetch",
          "bb.tests.parse",
          "bb.tests.persist_data",
+         "bb.tests.runqueue",
          "bb.tests.utils",
          "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
new file mode 100644
index 0000000000..e81df7ac42
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -0,0 +1,219 @@
+SLOWTASKS ??= ""
+SSTATEVALID ??= ""
+
+def stamptask(d):
+    import time
+
+    thistask = d.expand("${PN}:${BB_CURRENTTASK}") 
+    if thistask in d.getVar("SLOWTASKS").split():
+        bb.note("Slowing task %s" % thistask)
+        time.sleep(0.5)
+
+    with open(d.expand("${TOPDIR}/task.log"), "a+") as f:
+        f.write(thistask + "\n")
+
+python do_fetch() {
+    stamptask(d)
+}
+python do_unpack() {
+    stamptask(d)
+}
+python do_patch() {
+    stamptask(d)
+}
+python do_populate_lic() {
+    stamptask(d)
+}
+python do_prepare_recipe_sysroot() {
+    stamptask(d)
+}
+python do_configure() {
+    stamptask(d)
+}
+python do_compile() {
+    stamptask(d)
+}
+python do_install() {
+    stamptask(d)
+}
+python do_populate_sysroot() {
+    stamptask(d)
+}
+python do_package() {
+    stamptask(d)
+}
+python do_package_write_ipk() {
+    stamptask(d)
+}
+python do_package_write_rpm() {
+    stamptask(d)
+}
+python do_packagedata() {
+    stamptask(d)
+}
+python do_package_qa() {
+    stamptask(d)
+}
+python do_build() {
+    stamptask(d)
+}
+do_prepare_recipe_sysroot[deptask] = "do_populate_sysroot"
+do_package[deptask] += "do_packagedata"
+do_build[recrdeptask] += "do_deploy"
+do_build[recrdeptask] += "do_package_write_ipk"
+do_build[recrdeptask] += "do_package_write_rpm"
+do_package_qa[rdeptask] = "do_packagedata"
+do_populate_lic_deploy[recrdeptask] += "do_populate_lic do_deploy"
+
+DEBIANRDEP = "do_packagedata"
+oo_package_write_ipk[rdeptask] = "${DEBIANRDEP}"
+do_package_write_rpm[rdeptask] = "${DEBIANRDEP}"
+
+addtask fetch
+addtask unpack after do_fetch
+addtask patch after do_unpack
+addtask prepare_recipe_sysroot after do_patch
+addtask configure after do_prepare_recipe_sysroot
+addtask compile after do_configure
+addtask install after do_compile
+addtask populate_sysroot after do_install
+addtask package after do_install
+addtask package_write_ipk after do_packagedata package
+addtask package_write_rpm after do_packagedata package
+addtask packagedata after do_package
+addtask package_qa after do_package
+addtask build after do_package_qa do_package_write_rpm do_package_write_ipk do_populate_sysroot
+
+python do_package_setscene() {
+    stamptask(d)
+}
+python do_package_qa_setscene() {
+    stamptask(d)
+}
+python do_package_write_ipk_setscene() {
+    stamptask(d)
+}
+python do_package_write_rpm_setscene() {
+    stamptask(d)
+}
+python do_packagedata_setscene() {
+    stamptask(d)
+}
+python do_populate_lic_setscene() {
+    stamptask(d)
+}
+python do_populate_sysroot_setscene() {
+    stamptask(d)
+}
+
+addtask package_setscene
+addtask package_qa_setscene
+addtask package_write_ipk_setscene
+addtask package_write_rpm_setscene
+addtask packagedata_setscene
+addtask populate_lic_setscene
+addtask populate_sysroot_setscene
+
+BB_SETSCENE_DEPVALID = "setscene_depvalid"
+
+def setscene_depvalid(task, taskdependees, notneeded, d, log=None):
+    # taskdependees is a dict of tasks which depend on task, each being a 3 item list of [PN, TASKNAME, FILENAME]
+    # task is included in taskdependees too
+    # Return - False - We need this dependency
+    #        - True - We can skip this dependency
+    import re
+
+    def logit(msg, log):
+        if log is not None:
+            log.append(msg)
+        else:
+            bb.debug(2, msg)
+
+    logit("Considering setscene task: %s" % (str(taskdependees[task])), log)
+
+    def isNativeCross(x):
+        return x.endswith("-native") or "-cross-" in x or "-crosssdk" in x or x.endswith("-cross")
+
+    # We only need to trigger populate_lic through direct dependencies
+    if taskdependees[task][1] == "do_populate_lic":
+        return True
+
+    # We only need to trigger packagedata through direct dependencies
+    # but need to preserve packagedata on packagedata links
+    if taskdependees[task][1] == "do_packagedata":
+        for dep in taskdependees:
+            if taskdependees[dep][1] == "do_packagedata":
+                return False
+        return True
+
+    for dep in taskdependees:
+        logit("  considering dependency: %s" % (str(taskdependees[dep])), log)
+        if task == dep:
+            continue
+        if dep in notneeded:
+            continue
+        # do_package_write_* and do_package doesn't need do_package
+        if taskdependees[task][1] == "do_package" and taskdependees[dep][1] in ['do_package', 'do_package_write_ipk', 'do_package_write_rpm', 'do_packagedata', 'do_package_qa']:
+            continue
+        # do_package_write_* need do_populate_sysroot as they're mainly postinstall dependencies
+        if taskdependees[task][1] == "do_populate_sysroot" and taskdependees[dep][1] in ['do_package_write_ipk', 'do_package_write_rpm']:
+            return False
+        # do_package/packagedata/package_qa don't need do_populate_sysroot
+        if taskdependees[task][1] == "do_populate_sysroot" and taskdependees[dep][1] in ['do_package', 'do_packagedata', 'do_package_qa']:
+            continue
+        # Native/Cross packages don't exist and are noexec anyway
+        if isNativeCross(taskdependees[dep][0]) and taskdependees[dep][1] in ['do_package_write_ipk', 'do_package_write_rpm', 'do_packagedata', 'do_package', 'do_package_qa']:
+            continue
+
+        # This is due to the [depends] in useradd.bbclass complicating matters
+        # The logic *is* reversed here due to the way hard setscene dependencies are injected
+        if (taskdependees[task][1] == 'do_package' or taskdependees[task][1] == 'do_populate_sysroot') and taskdependees[dep][0].endswith(('shadow-native', 'shadow-sysroot', 'base-passwd', 'pseudo-native')) and taskdependees[dep][1] == 'do_populate_sysroot':
+            continue
+
+        # Consider sysroot depending on sysroot tasks
+        if taskdependees[task][1] == 'do_populate_sysroot' and taskdependees[dep][1] == 'do_populate_sysroot':
+            # Native/Cross populate_sysroot need their dependencies
+            if isNativeCross(taskdependees[task][0]) and isNativeCross(taskdependees[dep][0]):
+                return False
+            # Target populate_sysroot depended on by cross tools need to be installed
+            if isNativeCross(taskdependees[dep][0]):
+                return False
+            # Native/cross tools depended upon by target sysroot are not needed
+            # Add an exception for shadow-native as required by useradd.bbclass
+            if isNativeCross(taskdependees[task][0]) and taskdependees[task][0] != 'shadow-native':
+                continue
+            # Target populate_sysroot need their dependencies
+            return False
+
+
+        if taskdependees[dep][1] == "do_populate_lic":
+            continue
+
+        # Safe fallthrough default
+        logit(" Default setscene dependency fall through due to dependency: %s" % (str(taskdependees[dep])), log)
+        return False
+    return True
+
+BB_HASHCHECK_FUNCTION = "sstate_checkhashes"
+
+def sstate_checkhashes(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=False, *, sq_unihash=None):
+
+    ret = []
+    missed = []
+
+    valid = d.getVar("SSTATEVALID").split()
+
+    for task in range(len(sq_fn)):
+        n = os.path.basename(sq_fn[task]).rsplit(".", 1)[0] + ":" + sq_task[task]
+        if n in valid:
+            bb.note("SState: Found valid sstate for %s" % n)
+            ret.append(task)
+        else:
+            missed.append(task)
+            bb.note("SState: Found no valid sstate for %s" % n)
+
+    if hasattr(bb.parse.siggen, "checkhashes"):
+        bb.parse.siggen.checkhashes(missed, ret, sq_fn, sq_task, sq_hash, sq_hashfn, d)
+
+    return ret
+
diff --git a/lib/bb/tests/runqueue-tests/classes/image.bbclass b/lib/bb/tests/runqueue-tests/classes/image.bbclass
new file mode 100644
index 0000000000..da9ff11064
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/classes/image.bbclass
@@ -0,0 +1,5 @@
+do_rootfs[recrdeptask] += "do_package_write_deb do_package_qa"
+do_rootfs[recrdeptask] += "do_package_write_ipk do_package_qa"
+do_rootfs[recrdeptask] += "do_package_write_rpm do_package_qa
+do_rootfs[recrdeptask] += "do_packagedata"
+do_rootfs[recrdeptask] += "do_populate_lic"
diff --git a/lib/bb/tests/runqueue-tests/classes/native.bbclass b/lib/bb/tests/runqueue-tests/classes/native.bbclass
new file mode 100644
index 0000000000..7eaaee54ad
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/classes/native.bbclass
@@ -0,0 +1,2 @@
+RECIPERDEPTASK = "do_populate_sysroot"
+do_populate_sysroot[rdeptask] = "${RECIPERDEPTASK}"
diff --git a/lib/bb/tests/runqueue-tests/conf/bitbake.conf b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
new file mode 100644
index 0000000000..cccd677966
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
@@ -0,0 +1,10 @@
+CACHE = "${TOPDIR}/cache"
+THISDIR = "${@os.path.dirname(d.getVar('FILE'))}"
+COREBASE := "${@os.path.normpath(os.path.dirname(d.getVar('FILE')+'/../../'))}"
+BBFILES = "${COREBASE}/recipes/*.bb"
+PROVIDES = "${PN}"
+PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0]}"
+export PATH
+STAMP = "${TOPDIR}/stamps/${PN}"
+T = "${TOPDIR}/workdir/${PN}/temp"
+BB_NUMBER_THREADS = "4"
diff --git a/lib/bb/tests/runqueue-tests/recipes/a1.bb b/lib/bb/tests/runqueue-tests/recipes/a1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/lib/bb/tests/runqueue-tests/recipes/b1.bb b/lib/bb/tests/runqueue-tests/recipes/b1.bb
new file mode 100644
index 0000000000..c0b288e5bc
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/b1.bb
@@ -0,0 +1 @@
+DEPENDS = "a1"
\ No newline at end of file
diff --git a/lib/bb/tests/runqueue-tests/recipes/c1.bb b/lib/bb/tests/runqueue-tests/recipes/c1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/lib/bb/tests/runqueue-tests/recipes/d1.bb b/lib/bb/tests/runqueue-tests/recipes/d1.bb
new file mode 100644
index 0000000000..5ba197515b
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/d1.bb
@@ -0,0 +1,3 @@
+DEPENDS = "a1"
+
+do_package_setscene[depends] = "a1:do_populate_sysroot_setscene"
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
new file mode 100644
index 0000000000..b1a23bc5d4
--- /dev/null
+++ b/lib/bb/tests/runqueue.py
@@ -0,0 +1,191 @@
+#
+# BitBake Tests for runqueue task processing
+#
+# Copyright (C) 2019 Richard Purdie
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import unittest
+import bb
+import os
+import tempfile
+import subprocess
+
+#
+# TODO:
+# Add tests on task ordering (X happens before Y after Z)
+#
+
+class RunQueueTests(unittest.TestCase):
+
+    alltasks = ['package', 'fetch', 'unpack', 'patch', 'prepare_recipe_sysroot', 'configure',
+                'compile', 'install', 'packagedata', 'package_qa', 'package_write_rpm', 'package_write_ipk',
+                'populate_sysroot', 'build']
+    a1_sstatevalid = "a1:do_package a1:do_package_qa a1:do_packagedata a1:do_package_write_ipk a1:do_package_write_rpm a1:do_populate_lic a1:do_populate_sysroot"
+    b1_sstatevalid = "b1:do_package b1:do_package_qa b1:do_packagedata b1:do_package_write_ipk b1:do_package_write_rpm b1:do_populate_lic b1:do_populate_sysroot"
+
+    def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None):
+        env = os.environ.copy()
+        env["BBPATH"] = os.path.realpath(os.path.join(os.path.dirname(__file__), "runqueue-tests"))
+        env["BB_ENV_EXTRAWHITE"] = "SSTATEVALID SLOWTASKS"
+        env["SSTATEVALID"] = sstatevalid
+        env["SLOWTASKS"] = slowtasks
+        if extraenv:
+            for k in extraenv:
+                env[k] = extraenv[k]
+                env["BB_ENV_EXTRAWHITE"] = env["BB_ENV_EXTRAWHITE"] + " " + k
+        try:
+            output = subprocess.check_output(cmd, env=env, stderr=subprocess.STDOUT,universal_newlines=True, cwd=builddir)
+        except subprocess.CalledProcessError as e:
+            self.fail("Command %s failed with %s" % (cmd, e.output))
+        tasks = []
+        with open(builddir + "/task.log", "r") as f:
+            tasks = [line.rstrip() for line in f]
+        return tasks
+
+    def test_no_setscenevalid(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_single_setscenevalid(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            sstatevalid = "a1:do_package"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_setscene', 'a1:fetch', 'a1:unpack', 'a1:patch', 'a1:prepare_recipe_sysroot', 'a1:configure',
+                        'a1:compile', 'a1:install', 'a1:packagedata', 'a1:package_qa', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot', 'a1:build']
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_intermediate_setscenevalid(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            sstatevalid = "a1:do_package a1:do_populate_sysroot"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_setscene', 'a1:packagedata', 'a1:package_qa', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot_setscene', 'a1:build']
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_all_setscenevalid(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            sstatevalid = self.a1_sstatevalid
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_write_ipk_setscene', 'a1:package_write_rpm_setscene', 'a1:packagedata_setscene',
+                        'a1:package_qa_setscene', 'a1:build', 'a1:populate_sysroot_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_no_settasks(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1", "-c", "patch"]
+            sstatevalid = self.a1_sstatevalid
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:fetch', 'a1:unpack', 'a1:patch']
+            self.assertEqual(set(tasks), set(expected))
+
+    # Test targets with intermediate setscene tasks alongside a target with no intermediate setscene tasks
+    def test_mixed_direct_tasks_setscene_tasks(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "c1:do_patch", "a1"]
+            sstatevalid = self.a1_sstatevalid
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['c1:fetch', 'c1:unpack', 'c1:patch', 'a1:package_write_ipk_setscene', 'a1:package_write_rpm_setscene', 'a1:packagedata_setscene',
+                        'a1:package_qa_setscene', 'a1:build', 'a1:populate_sysroot_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
+    # This test slows down the execution of do_package_setscene until after other real tasks have
+    # started running which tests for a bug where tasks were being lost from the buildable list of real
+    # tasks if they weren't in tasks_covered or tasks_notcovered
+    def test_slow_setscene(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            sstatevalid = "a1:do_package"
+            slowtasks = "a1:package_setscene"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, slowtasks)
+            expected = ['a1:package_setscene', 'a1:fetch', 'a1:unpack', 'a1:patch', 'a1:prepare_recipe_sysroot', 'a1:configure',
+                        'a1:compile', 'a1:install', 'a1:packagedata', 'a1:package_qa', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot', 'a1:build']
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_setscenewhitelist(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1"]
+            extraenv = {
+                "BB_SETSCENE_ENFORCE" : "1",
+                "BB_SETSCENE_ENFORCE_WHITELIST" : "a1:do_package_write_rpm a1:do_build"
+            }
+            sstatevalid = "a1:do_package a1:do_package_qa a1:do_packagedata a1:do_package_write_ipk a1:do_populate_lic a1:do_populate_sysroot"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv)
+            expected = ['a1:packagedata_setscene', 'a1:package_qa_setscene', 'a1:package_write_ipk_setscene',
+                        'a1:populate_sysroot_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
+    # Tests for problems with dependencies between setscene tasks
+    def test_no_setscenevalid_harddeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "d1"]
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package', 'a1:fetch', 'a1:unpack', 'a1:patch', 'a1:prepare_recipe_sysroot', 'a1:configure',
+                        'a1:compile', 'a1:install', 'a1:packagedata', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot', 'd1:package', 'd1:fetch', 'd1:unpack', 'd1:patch', 'd1:prepare_recipe_sysroot', 'd1:configure',
+                        'd1:compile', 'd1:install', 'd1:packagedata', 'd1:package_qa', 'd1:package_write_rpm', 'd1:package_write_ipk',
+                        'd1:populate_sysroot', 'd1:build']
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_no_setscenevalid_withdeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "b1"]
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
+            expected.remove('a1:build')
+            expected.remove('a1:package_qa')
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_single_a1_setscenevalid_withdeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "b1"]
+            sstatevalid = "a1:do_package"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_setscene', 'a1:fetch', 'a1:unpack', 'a1:patch', 'a1:prepare_recipe_sysroot', 'a1:configure',
+                        'a1:compile', 'a1:install', 'a1:packagedata', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot'] + ['b1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_single_b1_setscenevalid_withdeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "b1"]
+            sstatevalid = "b1:do_package"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package', 'a1:fetch', 'a1:unpack', 'a1:patch', 'a1:prepare_recipe_sysroot', 'a1:configure',
+                        'a1:compile', 'a1:install', 'a1:packagedata', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot', 'b1:package_setscene'] + ['b1:' + x for x in self.alltasks]
+            expected.remove('b1:package')
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_intermediate_setscenevalid_withdeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "b1"]
+            sstatevalid = "a1:do_package a1:do_populate_sysroot b1:do_package"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_setscene', 'a1:packagedata', 'a1:package_write_rpm', 'a1:package_write_ipk',
+                        'a1:populate_sysroot_setscene', 'b1:package_setscene'] + ['b1:' + x for x in self.alltasks]
+            expected.remove('b1:package')
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_all_setscenevalid_withdeps(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "b1"]
+            sstatevalid = self.a1_sstatevalid + " " + self.b1_sstatevalid
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:package_write_ipk_setscene', 'a1:package_write_rpm_setscene', 'a1:packagedata_setscene',
+                        'b1:build', 'a1:populate_sysroot_setscene', 'b1:package_write_ipk_setscene', 'b1:package_write_rpm_setscene',
+                        'b1:packagedata_setscene', 'b1:package_qa_setscene', 'b1:populate_sysroot_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
-- 
2.20.1


