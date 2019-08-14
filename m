Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 420177E963
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:21 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c3so2921594wrd.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=NYd9fCPqmyTHiHChDsWPz7IUhNJSDxBzwSfmkhGJhOk=;
	b=RQKz8/md2r+5eSMxEX6o6SAiYQHbllfgQUIWGZQCMc8uzs2VFwg+8O+i7RhN34ElI+
	PQMTQHVmDX4mCfvegx16AcQ5Y0950Hr/tHGDPIok9Rl4YVoq9b7huxRMJYMX/Kb7bynZ
	fzFw4VckplDYc/KadB3jrxxXztNBQDVGn6o84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=NYd9fCPqmyTHiHChDsWPz7IUhNJSDxBzwSfmkhGJhOk=;
	b=Tw/OV80X7Y5DbAapFmI0T4KEXwAZ/vxWlUa7V/LrTcXEk4BaXhNDmjGyycwNjcMJrG
	EelCR6npR8xMRBCnX5iUNNcXEdrpq/r4ulryUIhTdOm6aCHmVKCdgBGoOgPAUrdzwA9z
	JWTPIXf+aJHuAaE82pEqgqVbck4HcvotMOeVy9DKzhdQwphsSL9VA84JPGcVvoaaNB+5
	jJ/ombK9H584/6Gq+eUyenEu6kLozdWmxsTGUwpV80xv9N6//2wD1vLd1Z9cSXcvDaVH
	msqJEQ7alcPAhHrhg4mt4H6Vi2IJ6AQq26a8Z080FpPFetgeKgBB8lyC8i7yCAiGSCwx
	PXWQ==
X-Gm-Message-State: APjAAAXzrSc/qWQgERqIVkLDhzNiS16pfvg+E/Px7+Ouq+pDiowhYnTV
	QBcQVWyFEndyL08Z7nIJ2PtLp2JY+tLpNw==
X-Google-Smtp-Source: APXvYqzu+tzXWO87+5kvtQt6o0sATL47XAGDYxuBb+PoL7WwV7blSkMS7hpDY9/BSwzr8XyRgMo2Ww==
X-Received: by 2002:adf:9482:: with SMTP id 2mr20703643wrr.91.1565790800598;
	Wed, 14 Aug 2019 06:53:20 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:20 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:10 +0100
Message-Id: <20190814135317.28887-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 03/10] tests/runqueue: Add further hash equivalence tests
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:22 -0000
Content-Transfer-Encoding: 8bit

Add some extra hash equivalence runqueue tests based on recent scenarios
that caused problems during testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/runqueue-tests/classes/base.bbclass |  20 ++-
 lib/bb/tests/runqueue-tests/conf/bitbake.conf |   2 +-
 lib/bb/tests/runqueue-tests/recipes/e1.bb     |   1 +
 lib/bb/tests/runqueue.py                      | 155 +++++++++++++++++-
 4 files changed, 166 insertions(+), 12 deletions(-)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/e1.bb

diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index 138edc3fa9..b57650d591 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -7,7 +7,7 @@ def stamptask(d):
     thistask = d.expand("${PN}:${BB_CURRENTTASK}")
     stampname = d.expand("${TOPDIR}/%s.run" % thistask)
     with open(stampname, "a+") as f:
-        f.write("\n")
+        f.write(d.getVar("BB_UNIHASH") + "\n")
 
     if d.getVar("BB_CURRENT_MC") != "default":
         thistask = d.expand("${BB_CURRENT_MC}:${PN}:${BB_CURRENTTASK}")
@@ -235,18 +235,28 @@ def sstate_checkhashes(sq_data, d, siginfo=False, currentcount=0, **kwargs):
 
     valid = d.getVar("SSTATEVALID").split()
 
-    for tid in sq_data['hash']:
+    for tid in sorted(sq_data['hash']):
         n = os.path.basename(bb.runqueue.fn_from_tid(tid)).split(".")[0] + ":do_" + bb.runqueue.taskname_from_tid(tid)[3:]
         print(n)
+        stampfile = d.expand("${TOPDIR}/%s.run" % n.replace("do_", ""))
         if n in valid:
             bb.note("SState: Found valid sstate for %s" % n)
             found.add(tid)
-        elif os.path.exists(d.expand("${TOPDIR}/%s.run" % n.replace("do_", ""))):
-            bb.note("SState: Found valid sstate for %s (already run)" % n)
+        elif n + ":" + sq_data['hash'][tid] in valid:
+            bb.note("SState: Found valid sstate for %s" % n)
             found.add(tid)
+        elif os.path.exists(stampfile):
+            with open(stampfile, "r") as f:
+                hash = f.readline().strip()
+            if hash == sq_data['hash'][tid]:
+                bb.note("SState: Found valid sstate for %s (already run)" % n)
+                found.add(tid)
+            else:
+                bb.note("SState: sstate hash didn't match previous run for %s (%s vs %s)" % (n, sq_data['hash'][tid], hash))
+                missed.add(tid)
         else:
             missed.add(tid)
-            bb.note("SState: Found no valid sstate for %s" % n)
+            bb.note("SState: Found no valid sstate for %s (%s)" % (n, sq_data['hash'][tid]))
 
     return found
 
diff --git a/lib/bb/tests/runqueue-tests/conf/bitbake.conf b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
index 1c61f27607..ab0f6bcfac 100644
--- a/lib/bb/tests/runqueue-tests/conf/bitbake.conf
+++ b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
@@ -11,6 +11,6 @@ STAMP = "${TMPDIR}/stamps/${PN}"
 T = "${TMPDIR}/workdir/${PN}/temp"
 BB_NUMBER_THREADS = "4"
 
-BB_HASHBASE_WHITELIST = "BB_CURRENT_MC BB_HASHSERVE"
+BB_HASHBASE_WHITELIST = "BB_CURRENT_MC BB_HASHSERVE TMPDIR TOPDIR SLOWTASKS SSTATEVALID"
 
 include conf/multiconfig/${BB_CURRENT_MC}.conf
diff --git a/lib/bb/tests/runqueue-tests/recipes/e1.bb b/lib/bb/tests/runqueue-tests/recipes/e1.bb
new file mode 100644
index 0000000000..1588bc8a59
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/e1.bb
@@ -0,0 +1 @@
+DEPENDS = "b1"
\ No newline at end of file
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index fbdacccfa1..1103f905f9 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -40,10 +40,12 @@ class RunQueueTests(unittest.TestCase):
         except subprocess.CalledProcessError as e:
             self.fail("Command %s failed with %s" % (cmd, e.output))
         tasks = []
-        with open(builddir + "/task.log", "r") as f:
-            tasks = [line.rstrip() for line in f]
-        if cleanup:
-            os.remove(builddir + "/task.log")
+        tasklog = builddir + "/task.log"
+        if os.path.exists(tasklog):
+            with open(tasklog, "r") as f:
+                tasks = [line.rstrip() for line in f]
+            if cleanup:
+                os.remove(tasklog)
         return tasks
 
     def test_no_setscenevalid(self):
@@ -229,7 +231,7 @@ class RunQueueTests(unittest.TestCase):
             self.assertEqual(set(tasks), set(expected))
 
 
-    def test_hashserv(self):
+    def test_hashserv_single(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
                 "BB_HASHSERVE" : "localhost:0",
@@ -248,6 +250,147 @@ class RunQueueTests(unittest.TestCase):
             self.assertEqual(set(tasks), set(expected))
             cmd = ["bitbake", "a1", "b1"]
             tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
-            expected = ['a1:' + x for x in setscenetasks] + ['b1:' + x for x in setscenetasks] + ['a1:build', 'b1:build']
+            expected = ['a1:populate_sysroot', 'a1:package', 'a1:package_write_rpm_setscene', 'a1:packagedata_setscene',
+                        'a1:package_write_ipk_setscene', 'a1:package_qa_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+    def test_hashserv_double(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BB_HASHSERVE" : "localhost:0",
+                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
+            }
+            cmd = ["bitbake", "a1", "b1", "e1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks] + ['e1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            cmd = ["bitbake", "a1", "b1", "-c", "install", "-fn"]
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            cmd = ["bitbake", "e1"]
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
+                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
+                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
+
+    def test_hashserv_multiple_setscene(self):
+        # Runs e1:do_package_setscene twice
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BB_HASHSERVE" : "localhost:0",
+                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
+            }
+            cmd = ["bitbake", "a1", "b1", "e1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks] + ['e1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            cmd = ["bitbake", "a1", "b1", "-c", "install", "-fn"]
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            cmd = ["bitbake", "e1"]
+            sstatevalid = "e1:do_package"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True, slowtasks="a1:populate_sysroot b1:populate_sysroot")
+            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
+                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
+                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
+                        'e1:package_setscene']
+            self.assertEqual(set(tasks), set(expected))
+            for i in expected:
+                if i in ["e1:package_setscene"]:
+                    self.assertEqual(tasks.count(i), 4, "%s not in task list four times" % i)
+                else:
+                    self.assertEqual(tasks.count(i), 1, "%s not in task list once" % i)
+
+    def test_hashserv_partial_match(self):
+        # e1:do_package matches initial built but not second hash value
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BB_HASHSERVE" : "localhost:0",
+                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
+            }
+            cmd = ["bitbake", "a1", "b1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
+               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
+            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
+               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
+            cmd = ["bitbake", "e1"]
+            sstatevalid = "e1:do_package:cb47e017ab549d87aab614c0f49dcf969ff6414745909094f0af7e657cedc657"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
+                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
+                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
+                        'e1:package_setscene'] + ['e1:' + x for x in self.alltasks]
+            expected.remove('e1:package')
+            self.assertEqual(set(tasks), set(expected))
+
+    def test_hashserv_partial_match2(self):
+        # e1:do_package + e1:do_populate_sysroot matches initial built but not second hash value
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BB_HASHSERVE" : "localhost:0",
+                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
+            }
+            cmd = ["bitbake", "a1", "b1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
+               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
+            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
+               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
+            cmd = ["bitbake", "e1"]
+            sstatevalid = "e1:do_package:cb47e017ab549d87aab614c0f49dcf969ff6414745909094f0af7e657cedc657 e1:do_populate_sysroot:aa6a915229f04af429d3c6c59c303516c500650b7c48da8e07b20a53acd86c5f"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
+                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
+                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
+                        'e1:package_setscene', 'e1:populate_sysroot_setscene', 'e1:build', 'e1:package_qa', 'e1:package_write_rpm', 'e1:package_write_ipk', 'e1:packagedata']
+            self.assertEqual(set(tasks), set(expected))
+
+
+    def test_hashserv_partial_match3(self):
+        # e1:do_package is valid for a1 but not after b1
+        # In former buggy code, this triggered e1:do_fetch, then e1:do_populate_sysroot to run
+        # with none of the intermediate tasks which is a serious bug
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BB_HASHSERVE" : "localhost:0",
+                "BB_SIGNATURE_HANDLER" : "TestEquivHash"
+            }
+            cmd = ["bitbake", "a1", "b1"]
+            setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
+                             'populate_sysroot_setscene', 'package_qa_setscene']
+            sstatevalid = ""
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+            with open(tempdir + "/stamps/a1.do_install.taint", "w") as f:
+               f.write("d460a29e-903f-4b76-a96b-3bcc22a65994")
+            with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
+               f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
+            cmd = ["bitbake", "e1", "-DD"]
+            sstatevalid = "e1:do_package:b710f6312ffed900b4b2761cc05538645f4ff3e7e0b70d688c70c0f3bcc2e1a2"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True, slowtasks="e1:fetch")
+            expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
+                        'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
+                        'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
+                        'e1:package_setscene']  + ['e1:' + x for x in self.alltasks]
+            expected.remove('e1:package')
+            self.assertEqual(set(tasks), set(expected))
+
+
-- 
2.20.1


