Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 810EE72207
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 16:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4EGwRQG015911 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:58:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ke0iO0ATu5AR for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:58:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4EGwCa5015895
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 17:58:23 +0100
Message-ID: <1431622692.18723.4.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 May 2015 17:58:12 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] tests/parse: Add very basic start of parse tests
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
X-List-Received-Date: Thu, 14 May 2015 16:58:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This tests very basic usage of the parser and then adds a test
to ensure that incomplete functions raise an exception.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 81e4c3c..8db6197 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -39,6 +39,7 @@ else:
              "bb.tests.cow",
              "bb.tests.data",
              "bb.tests.fetch",
+             "bb.tests.parse",
              "bb.tests.utils"]
 
 for t in tests:
diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
new file mode 100644
index 0000000..fa40327
--- /dev/null
+++ b/bitbake/lib/bb/tests/parse.py
@@ -0,0 +1,69 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Test for lib/bb/parse/
+#
+# Copyright (C) 2015 Richard Purdie
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
+import tempfile
+import logging
+import bb
+import os
+
+logger = logging.getLogger('BitBake.TestParse')
+
+import bb.parse
+import bb.data
+import bb.siggen
+
+class ParseTest(unittest.TestCase):
+
+    testfile = """
+A = "1"
+B = "2"
+do_install() {
+	echo "hello"
+}
+
+C = "3"
+"""
+
+    def setUp(self):
+        self.d = bb.data.init()
+        bb.parse.siggen = bb.siggen.init(self.d)
+
+    def parsehelper(self, content):
+
+        f = tempfile.NamedTemporaryFile(suffix = ".bb")
+        f.write(content)
+        f.flush()
+        os.chdir(os.path.dirname(f.name))
+        return f
+
+    def test_parse_simple(self):
+        f = self.parsehelper(self.testfile)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("A", True), "1")
+        self.assertEqual(d.getVar("B", True), "2")
+        self.assertEqual(d.getVar("C", True), "3")
+
+    def test_parse_incomplete_function(self):
+        testfileB = self.testfile.replace("}", "")
+        f = self.parsehelper(testfileB)
+        with self.assertRaises(bb.parse.ParseError):
+            d = bb.parse.handle(f.name, self.d)['']



