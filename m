Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7D3C57F357
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:21:03 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id c2so74354995wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=m1yTLR48o57s8MSYoAcVt6BvJunyz9PXGuHqinS83qw=;
	b=FI+4DBoY6JPGy2I1LCehIRJAduuc15PLMzIb+FLbwk/9GaRD254tVr8GiMxyc8VRqg
	ppmmzuKU7yjOfxAGyulpoy85aeLLJu0MB4+3kb2r6eIXxWbqJpvvc+2bbaibU+RIaw5H
	uyRvEC758psg2m773eTyWgaBO7UFt87VcK9zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=m1yTLR48o57s8MSYoAcVt6BvJunyz9PXGuHqinS83qw=;
	b=UiXHLNP5/Pmv1+ypwI3rATJgIuXhMJPT9oOmTdxBf6Bi8b3bsTFSPDaHZ3Wat7Ohrn
	uZpHPjNPQSY2LMKzqhOV57iynIsIKQUsOhh7fW4NuyG0duR4pKmvIGPdZxI6ySC8XtI3
	bSdWk/YqJV2FM+Ug9A3X0hdK2m0dmS2jUCqmQS8ajmJ+J0qyH3jp1Eyp01vkwdxUJvR0
	2ZlATUt1qFF9OVIfZjeEQCQl1WvW2hKjHkHQPCYl/r8X5TUX6c1zpFfnH8CpXojZOB+T
	TihQxO7qcTgFU8hXwNu7/9sISD57SIJhHE0rHumIuwmzt788FvhFDIYoJSjXuc4mx9Ne
	2e+Q==
X-Gm-Message-State: APjAAAWJFvYU3hr25XpPxpSzieQX0EHDm/Gfabhu63vDjzQWp2kHdd4G
	+Y4iVBg3RdBpAfQ0hl7BTw8UlAUt/gw=
X-Google-Smtp-Source: APXvYqwZxtPLFdHwSE+NdU+OujWibnh/U2iHiAzbS7ttZviazlxjF/upFO61btwVBFHVsY0aNBuzaA==
X-Received: by 2002:a5d:69c4:: with SMTP id s4mr117676828wrw.163.1564759264007;
	Fri, 02 Aug 2019 08:21:04 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.21.03
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:21:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:48 +0100
Message-Id: <20190802152049.16529-15-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 15/16] tests/runqueue: Add hashserv+runqueue test
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
X-List-Received-Date: Fri, 02 Aug 2019 15:21:03 -0000
Content-Transfer-Encoding: 8bit

Add a test which tests the runqueue adaptations for hash equivalency.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py                              | 23 +++++++++++++---
 .../tests/runqueue-tests/classes/base.bbclass | 14 +++++++++-
 lib/bb/tests/runqueue-tests/conf/bitbake.conf |  2 +-
 lib/bb/tests/runqueue.py                      | 27 ++++++++++++++++++-
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 912c92c8be..b503559305 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -12,6 +12,7 @@ import bb.data
 import difflib
 import simplediff
 from bb.checksum import FileChecksumCache
+from bb import runqueue
 
 logger = logging.getLogger('BitBake.SigGen')
 
@@ -473,10 +474,12 @@ class SignatureGeneratorUniHashMixIn(object):
 
             locs = {'path': path, 'sigfile': sigfile, 'task': task, 'd': d}
 
-            (module, method) = self.method.rsplit('.', 1)
-            locs['method'] = getattr(importlib.import_module(module), method)
-
-            outhash = bb.utils.better_eval('method(path, sigfile, task, d)', locs)
+            if "." in self.method:
+                (module, method) = self.method.rsplit('.', 1)
+                locs['method'] = getattr(importlib.import_module(module), method)
+                outhash = bb.utils.better_eval('method(path, sigfile, task, d)', locs)
+            else:
+                outhash = bb.utils.better_eval(self.method + '(path, sigfile, task, d)', locs)
 
             try:
                 url = '%s/v1/equivalent' % self.server
@@ -527,6 +530,18 @@ class SignatureGeneratorUniHashMixIn(object):
                 except OSError:
                     pass
 
+
+#
+# Dummy class used for bitbake-selftest
+#
+class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureGeneratorBasicHash):
+    name = "TestEquivHash"
+    def init_rundepcheck(self, data):
+        super().init_rundepcheck(data)
+        self.server = "http://" + data.getVar('BB_HASHSERVE')
+        self.method = "sstate_output_hash"
+
+
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")
diff --git a/lib/bb/tests/runqueue-tests/classes/base.bbclass b/lib/bb/tests/runqueue-tests/classes/base.bbclass
index 3a0f151c9a..138edc3fa9 100644
--- a/lib/bb/tests/runqueue-tests/classes/base.bbclass
+++ b/lib/bb/tests/runqueue-tests/classes/base.bbclass
@@ -5,7 +5,8 @@ def stamptask(d):
     import time
 
     thistask = d.expand("${PN}:${BB_CURRENTTASK}")
-    with open(d.expand("${TOPDIR}/%s.run") % thistask, "a+") as f:
+    stampname = d.expand("${TOPDIR}/%s.run" % thistask)
+    with open(stampname, "a+") as f:
         f.write("\n")
 
     if d.getVar("BB_CURRENT_MC") != "default":
@@ -13,10 +14,21 @@ def stamptask(d):
     if thistask in d.getVar("SLOWTASKS").split():
         bb.note("Slowing task %s" % thistask)
         time.sleep(0.5)
+    if d.getVar("BB_HASHSERVE"):
+        task = d.getVar("BB_CURRENTTASK")
+        if task in ['package', 'package_qa', 'packagedata', 'package_write_ipk', 'package_write_rpm', 'populate_lic', 'populate_sysroot']:
+            bb.parse.siggen.report_unihash(os.getcwd(), d.getVar("BB_CURRENTTASK"), d)
 
     with open(d.expand("${TOPDIR}/task.log"), "a+") as f:
         f.write(thistask + "\n")
 
+
+def sstate_output_hash(path, sigfile, task, d):
+    import hashlib
+    h = hashlib.sha256()
+    h.update(d.expand("${PN}:${BB_CURRENTTASK}").encode('utf-8'))
+    return h.hexdigest()
+
 python do_fetch() {
     # fetch
     stamptask(d)
diff --git a/lib/bb/tests/runqueue-tests/conf/bitbake.conf b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
index 96ee1cd5ec..1c61f27607 100644
--- a/lib/bb/tests/runqueue-tests/conf/bitbake.conf
+++ b/lib/bb/tests/runqueue-tests/conf/bitbake.conf
@@ -11,6 +11,6 @@ STAMP = "${TMPDIR}/stamps/${PN}"
 T = "${TMPDIR}/workdir/${PN}/temp"
 BB_NUMBER_THREADS = "4"
 
-BB_HASHBASE_WHITELIST = "BB_CURRENT_MC"
+BB_HASHBASE_WHITELIST = "BB_CURRENT_MC BB_HASHSERVE"
 
 include conf/multiconfig/${BB_CURRENT_MC}.conf
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index f22ad4bd81..fbdacccfa1 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -25,7 +25,7 @@ class RunQueueTests(unittest.TestCase):
     a1_sstatevalid = "a1:do_package a1:do_package_qa a1:do_packagedata a1:do_package_write_ipk a1:do_package_write_rpm a1:do_populate_lic a1:do_populate_sysroot"
     b1_sstatevalid = "b1:do_package b1:do_package_qa b1:do_packagedata b1:do_package_write_ipk b1:do_package_write_rpm b1:do_populate_lic b1:do_populate_sysroot"
 
-    def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None):
+    def run_bitbakecmd(self, cmd, builddir, sstatevalid="", slowtasks="", extraenv=None, cleanup=False):
         env = os.environ.copy()
         env["BBPATH"] = os.path.realpath(os.path.join(os.path.dirname(__file__), "runqueue-tests"))
         env["BB_ENV_EXTRAWHITE"] = "SSTATEVALID SLOWTASKS"
@@ -42,6 +42,8 @@ class RunQueueTests(unittest.TestCase):
         tasks = []
         with open(builddir + "/task.log", "r") as f:
             tasks = [line.rstrip() for line in f]
+        if cleanup:
+            os.remove(builddir + "/task.log")
         return tasks
 
     def test_no_setscenevalid(self):
@@ -226,3 +228,26 @@ class RunQueueTests(unittest.TestCase):
                 expected.remove(x)
             self.assertEqual(set(tasks), set(expected))
 
+
+    def test_hashserv(self):
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
+            cmd = ["bitbake", "a1", "-c", "install", "-f"]
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:install']
+            self.assertEqual(set(tasks), set(expected))
+            cmd = ["bitbake", "a1", "b1"]
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True)
+            expected = ['a1:' + x for x in setscenetasks] + ['b1:' + x for x in setscenetasks] + ['a1:build', 'b1:build']
+            self.assertEqual(set(tasks), set(expected))
+
-- 
2.20.1


