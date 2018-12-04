Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id 44B976C52B;
	Tue,  4 Dec 2018 03:46:27 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id p197so12298129itp.0;
	Mon, 03 Dec 2018 19:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=QecZKq2cRCCx4/ep0UDQo/7qU+cbvPPA44h25mT5Ih0=;
	b=jQ3JivzlB+om5CLWZtgFORnd99cH61fNlzsum32hesMfHrr79y/1IhZfasCifClDRZ
	Tk6qw4v0rSjMpKv8m5xYZQ1IjVrbZoxMBsX6A7dkHV10hfMOB58/WMIZ1CC+WABT6Ln1
	F1kvVw2aRk9RJ5muuFwuAL+XVeFyly6KICUvmGCwU1I8wGRwYnepoEb51TLlxJ5Lx2o5
	3D08OdZ0pceNZ5DNA6lWk/Mot5owb0gNQ7fBzG8YUbtErOwfkoCGpD0Z/4q8uqzHMlrC
	72NDJPZ8U9rP4Wd54BAsmp9588/aD/VPpJGo6g496AS3rHnbaTA6xQS+TasCQ4WhGvet
	9cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=QecZKq2cRCCx4/ep0UDQo/7qU+cbvPPA44h25mT5Ih0=;
	b=E5KEGSXyv0wvPlDK32PunrkLOGsLU68UKQ17hMMddVBAqyvv5YKC/l0JAwOxZsEWP/
	wgRtdS8KStPTY7vSXW15Me+oCGs9Lex4iU4Zrgo0aY5FcehMaXPq0x8I9UMd3aDyt4GW
	ZdW0CmdkxpEXYV4PySJ6ipGlAm6uG5m3KApSat66CPP5UThwhDTDKW81m99kETMrJQ0i
	77ElE42jHKcMsOxwPaQjbhpLvnFDr7SNsjvA5ztK0H7+UpJqIU8Kpvt9RL9i5ILUaw3A
	0v4E8iXO6FhHRFbcDvBeCUnIjJ+dBK3TCZFCSjr4WGH8fw0Z/Dpq+EHZCco/k573Frt7
	wkhg==
X-Gm-Message-State: AA+aEWb2EsbF4GKGCrmf4esYrffjJc1h9EJcTp2h/qWgBSfgAZ9kcqm5
	zF1GisZgCnlrDCrzOT2Vthx8ViEed/U=
X-Google-Smtp-Source: AFSGD/VX3bmgjth8/g4hDkylF3ZJHbYQz/MAx5IBeXOCQLyOdun6IeEEkp/S4jxujMo627kzktulcw==
X-Received: by 2002:a24:d902:: with SMTP id p2mr9712122itg.112.1543895187831; 
	Mon, 03 Dec 2018 19:46:27 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:27 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:35 -0600
Message-Id: <20181204034245.25461-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 07/17] bitbake: tests/persist_data: Add tests
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:27 -0000
Content-Transfer-Encoding: 8bit

Adds a test suite for testing the persistent data cache

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-selftest         |   1 +
 bitbake/lib/bb/tests/persist_data.py | 188 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/persist_data.py

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index cfa7ac5391b..c970dcae90c 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -33,6 +33,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.event",
          "bb.tests.fetch",
          "bb.tests.parse",
+         "bb.tests.persist_data",
          "bb.tests.utils",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
diff --git a/bitbake/lib/bb/tests/persist_data.py b/bitbake/lib/bb/tests/persist_data.py
new file mode 100644
index 00000000000..055f1d9ce47
--- /dev/null
+++ b/bitbake/lib/bb/tests/persist_data.py
@@ -0,0 +1,188 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Test for lib/bb/persist_data/
+#
+# Copyright (C) 2018 Garmin Ltd.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+import unittest
+import bb.data
+import bb.persist_data
+import bb.fork
+import tempfile
+import threading
+
+class PersistDataTest(unittest.TestCase):
+    def _create_data(self):
+        return bb.persist_data.persist('TEST_PERSIST_DATA', self.d)
+
+    def setUp(self):
+        self.d = bb.data.init()
+        self.tempdir = tempfile.TemporaryDirectory()
+        self.d['PERSISTENT_DIR'] = self.tempdir.name
+        self.data = self._create_data()
+        self.items = {
+                'A1': '1',
+                'B1': '2',
+                'C2': '3'
+                }
+        self.stress_count = 10000
+        self.thread_count = 5
+
+        for k,v in self.items.items():
+            self.data[k] = v
+
+    def tearDown(self):
+        self.tempdir.cleanup()
+
+    def _iter_helper(self, seen, iterator):
+        with iter(iterator):
+            for v in iterator:
+                self.assertTrue(v in seen)
+                seen.remove(v)
+        self.assertEqual(len(seen), 0, '%s not seen' % seen)
+
+    def test_get(self):
+        for k, v in self.items.items():
+            self.assertEqual(self.data[k], v)
+
+        self.assertIsNone(self.data.get('D'))
+        with self.assertRaises(KeyError):
+            self.data['D']
+
+    def test_set(self):
+        for k, v in self.items.items():
+            self.data[k] += '-foo'
+
+        for k, v in self.items.items():
+            self.assertEqual(self.data[k], v + '-foo')
+
+    def test_delete(self):
+        self.data['D'] = '4'
+        self.assertEqual(self.data['D'], '4')
+        del self.data['D']
+        self.assertIsNone(self.data.get('D'))
+        with self.assertRaises(KeyError):
+            self.data['D']
+
+    def test_contains(self):
+        for k in self.items:
+            self.assertTrue(k in self.data)
+            self.assertTrue(self.data.has_key(k))
+        self.assertFalse('NotFound' in self.data)
+        self.assertFalse(self.data.has_key('NotFound'))
+
+    def test_len(self):
+        self.assertEqual(len(self.data), len(self.items))
+
+    def test_iter(self):
+        self._iter_helper(set(self.items.keys()), self.data)
+
+    def test_itervalues(self):
+        self._iter_helper(set(self.items.values()), self.data.itervalues())
+
+    def test_iteritems(self):
+        self._iter_helper(set(self.items.items()), self.data.iteritems())
+
+    def test_get_by_pattern(self):
+        self._iter_helper({'1', '2'}, self.data.get_by_pattern('_1'))
+
+    def _stress_read(self, data):
+        for i in range(self.stress_count):
+            for k in self.items:
+                data[k]
+
+    def _stress_write(self, data):
+        for i in range(self.stress_count):
+            for k, v in self.items.items():
+                data[k] = v + str(i)
+
+    def _validate_stress(self):
+        for k, v in self.items.items():
+            self.assertEqual(self.data[k], v + str(self.stress_count - 1))
+
+    def test_stress(self):
+        self._stress_read(self.data)
+        self._stress_write(self.data)
+        self._validate_stress()
+
+    def test_stress_threads(self):
+        def read_thread():
+            data = self._create_data()
+            self._stress_read(data)
+
+        def write_thread():
+            data = self._create_data()
+            self._stress_write(data)
+
+        threads = []
+        for i in range(self.thread_count):
+            threads.append(threading.Thread(target=read_thread))
+            threads.append(threading.Thread(target=write_thread))
+
+        for t in threads:
+            t.start()
+        self._stress_read(self.data)
+        for t in threads:
+            t.join()
+        self._validate_stress()
+
+    def test_stress_fork(self):
+        children = []
+        for i in range(self.thread_count):
+            # Create a writer
+            pid = bb.fork.fork()
+            if pid == 0:
+                try:
+                    self._stress_write(self.data)
+                except:
+                    os._exit(1)
+                else:
+                    os._exit(0)
+            else:
+                children.append(pid)
+
+            # Create a reader
+            pid = bb.fork.fork()
+            if pid == 0:
+                try:
+                    self._stress_read(self.data)
+                except:
+                    os._exit(1)
+                else:
+                    os._exit(0)
+            else:
+                children.append(pid)
+
+        self._stress_read(self.data)
+
+        for pid in children:
+            while True:
+                try:
+                    (_, status) = os.waitpid(pid, 0)
+                    break
+                # Python < 3.5 will raise this if waitpid() is interrupted
+                except InterruptedError:
+                    pass
+                except:
+                    raise
+
+            self.assertTrue(os.WIFEXITED(status), "PID %d did not exit normally" % pid)
+            self.assertEqual(os.WEXITSTATUS(status), 0, "PID %d exited with code %d" % (pid, os.WEXITSTATUS(status)))
+
+        self._validate_stress()
+
-- 
2.19.1


