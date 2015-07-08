Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0FF7075E05
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8R026688; Wed, 8 Jul 2015 15:59:26 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z7GvGkn30IZ1; Wed,  8 Jul 2015 15:59:26 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExN05026613
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:24 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqog-0004TM-CE; Wed, 08 Jul 2015 15:59:18 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:10 +0100
Message-Id: <d7d9233169cbc44bbd70bf1bb144d3871a140175.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 16/16] tests/data: Add new data tests
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:28 -0000

Add a variety of tests which were found to be useful when working
on the data store recently.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/data.py  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tests/parse.py | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 2c2e7ae..e9aab57 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -270,6 +270,13 @@ class TestConcatOverride(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
 
+    def test_append_unset(self):
+        self.d.setVar("TEST_prepend", "${FOO}:")
+        self.d.setVar("TEST_append", ":val2")
+        self.d.setVar("TEST_append", ":${BAR}")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "foo::val2:bar")
+
     def test_remove(self):
         self.d.setVar("TEST", "${VAL} ${BAR}")
         self.d.setVar("TEST_remove", "val")
@@ -318,12 +325,52 @@ class TestOverrides(unittest.TestCase):
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "testvalue2")
 
+    def test_one_override_unset(self):
+        self.d.setVar("TEST2_bar", "testvalue2")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST2", True), "testvalue2")
+        self.assertItemsEqual(self.d.keys(), ['TEST', 'TEST2', 'OVERRIDES', 'TEST2_bar'])
+
     def test_multiple_override(self):
         self.d.setVar("TEST_bar", "testvalue2")
         self.d.setVar("TEST_local", "testvalue3")
         self.d.setVar("TEST_foo", "testvalue4")
         bb.data.update_data(self.d)
         self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+        self.assertItemsEqual(self.d.keys(), ['TEST', 'TEST_foo', 'OVERRIDES', 'TEST_bar', 'TEST_local'])
+
+    def test_multiple_combined_overrides(self):
+        self.d.setVar("TEST_local_foo_bar", "testvalue3")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+
+    def test_multiple_overrides_unset(self):
+        self.d.setVar("TEST2_local_foo_bar", "testvalue3")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST2", True), "testvalue3")
+
+    def test_keyexpansion_override(self):
+        self.d.setVar("LOCAL", "local")
+        self.d.setVar("TEST_bar", "testvalue2")
+        self.d.setVar("TEST_${LOCAL}", "testvalue3")
+        self.d.setVar("TEST_foo", "testvalue4")
+        bb.data.update_data(self.d)
+        bb.data.expandKeys(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+
+    def test_rename_override(self):
+        self.d.setVar("ALTERNATIVE_ncurses-tools_class-target", "a")
+        self.d.setVar("OVERRIDES", "class-target")
+        bb.data.update_data(self.d)
+        self.d.renameVar("ALTERNATIVE_ncurses-tools", "ALTERNATIVE_lib32-ncurses-tools")
+        self.assertEqual(self.d.getVar("ALTERNATIVE_lib32-ncurses-tools", True), "a")
+
+    def test_underscore_override(self):
+        self.d.setVar("TEST_bar", "testvalue2")
+        self.d.setVar("TEST_some_val", "testvalue3")
+        self.d.setVar("TEST_foo", "testvalue4")
+        self.d.setVar("OVERRIDES", "foo:bar:some_val")
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
 
 class TestKeyExpansion(unittest.TestCase):
     def setUp(self):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index fa40327..21fd78a 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -67,3 +67,49 @@ C = "3"
         f = self.parsehelper(testfileB)
         with self.assertRaises(bb.parse.ParseError):
             d = bb.parse.handle(f.name, self.d)['']
+
+    overridetest = """
+RRECOMMENDS_${PN} = "a"
+RRECOMMENDS_${PN}_libc = "b"
+OVERRIDES = "libc:${PN}"
+PN = "gtk+"
+"""
+
+    def test_parse_overrides(self):
+        f = self.parsehelper(self.overridetest)
+        d = bb.parse.handle(f.name, self.d)['']
+        self.assertEqual(d.getVar("RRECOMMENDS", True), "b")
+        bb.data.expandKeys(d)
+        self.assertEqual(d.getVar("RRECOMMENDS", True), "b")
+        d.setVar("RRECOMMENDS_gtk+", "c")
+        self.assertEqual(d.getVar("RRECOMMENDS", True), "c")
+
+    overridetest2 = """
+EXTRA_OECONF = ""
+EXTRA_OECONF_class-target = "b"
+EXTRA_OECONF_append = " c"
+"""
+
+    def test_parse_overrides(self):
+        f = self.parsehelper(self.overridetest2)
+        d = bb.parse.handle(f.name, self.d)['']
+        d.appendVar("EXTRA_OECONF", " d")
+        d.setVar("OVERRIDES", "class-target")
+        self.assertEqual(d.getVar("EXTRA_OECONF", True), "b c d")
+
+    overridetest3 = """
+DESCRIPTION = "A"
+DESCRIPTION_${PN}-dev = "${DESCRIPTION} B"
+PN = "bc"
+"""
+
+    def test_parse_combinations(self):
+        f = self.parsehelper(self.overridetest3)
+        d = bb.parse.handle(f.name, self.d)['']
+        bb.data.expandKeys(d)
+        self.assertEqual(d.getVar("DESCRIPTION_bc-dev", True), "A B")
+        d.setVar("DESCRIPTION", "E")
+        d.setVar("DESCRIPTION_bc-dev", "C D")
+        d.setVar("OVERRIDES", "bc-dev")
+        self.assertEqual(d.getVar("DESCRIPTION", True), "C D")
+
-- 
2.1.0


