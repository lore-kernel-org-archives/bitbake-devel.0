Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f196.google.com (mail-it1-f196.google.com
	[209.85.166.196])
	by mail.openembedded.org (Postfix) with ESMTP id A01707BFE5;
	Tue, 18 Dec 2018 15:31:10 +0000 (UTC)
Received: by mail-it1-f196.google.com with SMTP id h193so4747747ita.5;
	Tue, 18 Dec 2018 07:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PFq3Sf2ftYXpVN36WRDeFMhmpeWqqzqo47bLojUOAtI=;
	b=DolchD8JYtUxaVfOZuk/g3h0PsUwEgv6RVxH0TMFLkVJLZSlQw8mTj0kSizMrXitHn
	77sE4sqMSY2ynJNdDH92P+kuvjicF9fNTtPBdsp5kYa+8/PkXUhh2k4FPfVp4DkizD7D
	XOFi0lIzXr/6lG3s0SNxlTXtjF6aGB9hCKO2YG/xLBRx94X1SzV/q03qHW+HDbt/O8Zk
	azhHa/FDR6RSdXWmhosy08RKvjSDT9onqsc3nk36q1iUpKzsai8q7v89UJFyTvMbBnwi
	P7zB8vVrDLxCSKB9tNLAeHcx7zkzr/YvWbMHa03qprv7qfRgpK/p706cS8hv0DB0ZKSD
	mqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PFq3Sf2ftYXpVN36WRDeFMhmpeWqqzqo47bLojUOAtI=;
	b=TLUB9ln6oq7HoJ80meRtTAHJ1F7YA0FiQCBYzXO+PLqrMkZZ9/X81Xic8nsibhpR+x
	DL7nhG9+6z4Xq04ptKtoTIh5Eca7U3ILCb2N0M9sEJHQtExwG0clGJEqdOLUrib+XpnJ
	SWDAqpF5tbL9ezrfQDMpkmyJGPxKL1dP8bAKBkfH5q28lEc8u/pvYhov3LFBJskSdIM/
	P/5KEEO71sv6DDYPLzRqPkk0XVURAxMHhx7iAUpN/9DFuhO/7zmPAxet5CsrBCIzTw6/
	Wt68DBQbkHX43wB1v+TBG1i7y21fI2yg/fXO+rKDdNDOjWj4Vmu5ZsZ31/mdjFAcQ1n7
	DJ0w==
X-Gm-Message-State: AA+aEWZ6jrI1wZD3BGjcvLljCdNPzOwOdwDZL9IPpF2KDeTNijsNRp2S
	FaurALqMZLxo5Naae3O355hE0Oiw
X-Google-Smtp-Source: AFSGD/Vk8V7ITbOrvoS+Mob0h0Rk1qEcPMCIcRuXDIuywW0NY5uX342QIbVYpqR8kQhZCv7FxTGH4Q==
X-Received: by 2002:a02:b70c:: with SMTP id g12mr15864477jam.60.1545147071351; 
	Tue, 18 Dec 2018 07:31:11 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:10 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:54 -0600
Message-Id: <20181218153101.9212-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 03/10] bitbake: tests/persist_data: Add tests
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:10 -0000
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
2.19.2


