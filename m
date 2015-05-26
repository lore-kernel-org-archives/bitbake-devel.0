Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8806670331
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 15:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QFIuI7011894 for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:18:56 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zLsyh2Vk8jBv for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:18:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t4QFIhJ5011890
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 May 2015 16:18:54 +0100
Message-ID: <1432653523.404.13.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 26 May 2015 16:18:43 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] tests/data: Add key expansion unit test
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
X-List-Received-Date: Tue, 26 May 2015 15:18:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This ensures basic key expansion works and that overlapping
keys generate a log message.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 6ed80fb..ced2d7b 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -323,6 +323,19 @@ class TestOverrides(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
 
+class TestKeyExpansion(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("FOO", "foo")
+        self.d.setVar("BAR", "foo")
+
+    def test_keyexpand(self):
+        self.d.setVar("VAL_${FOO}", "A")
+        self.d.setVar("VAL_${BAR}", "B")
+        with LogRecord() as logs:
+            bb.data.expandKeys(self.d)
+            self.assertTrue(LogContains("Variable key VAL_${FOO} (A) replaces original key VAL_foo (B)", logs))
+        self.assertEqual(self.d.getVar("VAL_foo", True), "A")
 
 class TestFlags(unittest.TestCase):
     def setUp(self):



