Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E74216FAF2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:26:43 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2PMQcoP021802 for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:26:39 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gmX7uYzNPIjr for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:26:38 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2PMQWG2021791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 22:26:34 GMT
Message-ID: <1395786386.24890.64.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Mar 2014 22:26:26 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: test/data: Add in test for append/prepend/remove override operations
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
X-List-Received-Date: Tue, 25 Mar 2014 22:26:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We currently don't have test cases for _append, _prepend and _remove. This
patch adds some basic tests and includes a test case for a recently reported
issue with the _remove operator.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 6ec2736..ee66b22 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -213,6 +213,47 @@ class TestConcat(unittest.TestCase):
         self.d.appendVar("TEST", ":${BAR}")
         self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
 
+class TestConcatOverride(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("FOO", "foo")
+        self.d.setVar("VAL", "val")
+        self.d.setVar("BAR", "bar")
+
+    def test_prepend(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.setVar("TEST_prepend", "${FOO}:")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "foo:val")
+
+    def test_append(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.setVar("TEST_append", ":${BAR}")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "val:bar")
+
+    def test_multiple_append(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.setVar("TEST_prepend", "${FOO}:")
+        self.d.setVar("TEST_append", ":val2")
+        self.d.setVar("TEST_append", ":${BAR}")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
+
+    def test_remove(self):
+        self.d.setVar("TEST", "${VAL} ${BAR}")
+        self.d.setVar("TEST_remove", "val")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "bar")
+
+    def test_doubleref_remove(self):
+        self.d.setVar("TEST", "${VAL} ${BAR}")
+        self.d.setVar("TEST_remove", "val")
+        self.d.setVar("TEST_TEST", "${TEST} ${TEST}")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST_TEST", True), "bar bar")
+
+
 class TestOverrides(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()



