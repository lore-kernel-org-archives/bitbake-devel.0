Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail.openembedded.org (Postfix) with ESMTP id EF68878C13;
	Thu,  9 Aug 2018 22:10:48 +0000 (UTC)
Received: by mail-it0-f52.google.com with SMTP id h23-v6so130487ita.5;
	Thu, 09 Aug 2018 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=L+pXkdTOTGVRE4kbEuiqBROymCn2tPKOp+2fwSM12A4=;
	b=nZPUkywYS9fTplMxRbMh4yvfr89izf54ePNCUZg/d0nlU2g4R+WhC7qRetxjbZwmqN
	f+hJ8EzquNM1Uzxlq/w0XQqb1rboi/K7O+aNJhxpGnaAl1XPeohIT+6rhwF8485WfnIB
	3+d9MlWtFVCW4VdT0igqx+HQnEJnTwL1VP2CqPk9npeNYe4QzapeMKjtL4EiarYGsdor
	6kVESOFNgvnhJ5q+L9sc7R7dq3O7dOozN32dJR+3z2aJAyTLWthPtA+khXVla4Wqp/NN
	xLWoNGYP/9bGOHsHfoUmtU6oq/oBChK2h/egRyMZcBm0IE/k+KPt6yD1GFnbQEuqxg9w
	/1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=L+pXkdTOTGVRE4kbEuiqBROymCn2tPKOp+2fwSM12A4=;
	b=L9VEKboNMRrR5Hk+ct+ZJNkYIF6eIUI0YELV8QVIjLPn51QmyL2cW8/tvF4WuPbrMS
	BWdLa9lxEoqlFY+W3b59a/ntrfwmayxvqCTGDXWbFM22qgIATfsQvi2T6Y+OhaBv+ktN
	N32GDrmb24wRebKL5a055jkUb/2TXyUtcO/hE45h010H7V18hXd6O4cmg+M4I5p6W7Tj
	vsFY7d95qSt6WS9WALvtdN6wHuI8v2cQr7/wvm94wnoEuVub3q/7A6l6NVR5/jDntCTe
	4qpzymLMBA87R3CTOS1hUmatWPAuLvLlzUrv79UQgpaj4Bqf6ZE5CQS94LT7gbtPhZTJ
	1CZQ==
X-Gm-Message-State: AOUpUlG5rJw3I+/Z1l6o+mYgIowKfgCOblj+kw0RdFMgWiNtFmBraJ/y
	N36TL5bKxTd3I76vOXjH+pcOlpre
X-Google-Smtp-Source: AA+uWPzAwCkoRCKOu3G2F170ZuOKTiPfKgk8ihNGH8cTy4cm5uWLkDmXuRt+kJbgrWPkhCwQkZ16aw==
X-Received: by 2002:a02:8c3c:: with SMTP id
	l57-v6mr3547030jak.57.1533852649862; 
	Thu, 09 Aug 2018 15:10:49 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:31 -0500
Message-Id: <20180809220840.26697-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 07/16] bitbake: tests/persist_data: Add tests
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:49 -0000

Adds a test suite for testing the persistent data cache

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-selftest         |   1 +
 bitbake/lib/bb/tests/persist_data.py | 188 +++++++++++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/persist_data.py

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 7564de304c8..06a1c9a78dd 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -32,6 +32,7 @@ tests = ["bb.tests.codeparser",
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
2.17.1


