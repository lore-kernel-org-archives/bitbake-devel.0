Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
	[209.85.166.66])
	by mail.openembedded.org (Postfix) with ESMTP id 7F0BA79DBF;
	Wed, 19 Dec 2018 03:10:38 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id l14so14473269ioj.5;
	Tue, 18 Dec 2018 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=qGhjIjb9bWe1yf0CnNAnxMMJFS+0v2tLDFsqgg+1y5c=;
	b=dWFo0EohBiVI8ii3kpYYidVVb+jBOsZHZrzX1d8rTbzFcLtJvIcZ+nGEwXSoqxdgOr
	/5Zuggfka7DQI2hj4CHM0zSIezGFTF8TbefHdkQVWUwqlS8tmUZJDeNfFC19CVsXySnD
	WjK6+IVKmP0y393cOsPY5XWALVcbHzj4Io44vIn8NUZL7p7tXZJuj5SroTuqBOYRWJ9Z
	icLUY8Y33vewr5esXh9nDTcDtNQoPQj3ZKabqzloWsfcIz60jEMX9LcuLPwwn1UIO/nY
	VujydrYScpnGmWd+pgvFOXFRp2Nxhe05TNg+1LyPTEXBFbaRtYFTqCu16JXWQpZRNunD
	s9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=qGhjIjb9bWe1yf0CnNAnxMMJFS+0v2tLDFsqgg+1y5c=;
	b=lvUoCQCEacZ2bvN8yGuRViVumdOvNHpzEiJ447AvRmKII20pviCfM+XAvWwc7gUPcC
	z+vzZKfFCwwdQwLCQIQedjoIMDUznW7Sa3/EwJePGVK5L5S8Dbun0205UBucHXamX4k4
	bNEQTSKvWdgZK9zAE2HZJ3UAkB/2m7GS+5zJAy9cUGHEubhLS7tZB1v0w2IBPyxzmy0T
	UViz6ZE4h1e5BYfXbaz/81d61DTSoMUlNxN9ZMVUZyY5v7UiJ3163T13dgB+SXiGFIaJ
	QeiBaMS8fGpfnuM+vxFQwuBQpT0YNiLY81yEbMScKCgbfJJ5dTuYP05ujCcF/fE2lN+h
	rFwg==
X-Gm-Message-State: AA+aEWbNAujBshFLFwr2hPvj5oXGvdQ/VCFfDhf16/NUKVm6WYurlRae
	SHdEgaOHskdoIWyyu4Ug59Q64acB
X-Google-Smtp-Source: AFSGD/VJtpX3nW0D3z+86JJryFqNfQnm2WBhy9AF3poyjdM1ND3wppa38JKy33Aw56O+su+HwJvcqQ==
X-Received: by 2002:a5d:9293:: with SMTP id s19mr102330iom.111.1545189039134; 
	Tue, 18 Dec 2018 19:10:39 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.38
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:38 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:26 -0600
Message-Id: <20181219031033.28045-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 1/8] bitbake: tests/persist_data: Add tests
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:38 -0000
Content-Transfer-Encoding: 8bit

Adds a test suite for testing the persistent data cache

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-selftest         |   1 +
 bitbake/lib/bb/tests/persist_data.py | 142 +++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)
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
index 00000000000..812bcbd7b8b
--- /dev/null
+++ b/bitbake/lib/bb/tests/persist_data.py
@@ -0,0 +1,142 @@
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
-- 
2.19.2


