Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 661C66C920
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Sep 2013 10:46:38 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8LB0RMA016284 for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Sep 2013 12:01:11 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id p3yk0qCDxvJU for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Sep 2013 12:01:11 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8LB18BD016305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Sat, 21 Sep 2013 12:01:10 +0100
Message-ID: <1379760387.18603.194.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 21 Sep 2013 11:46:27 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] tests/data: Whitespace in key names is a really bad idea
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
X-List-Received-Date: Sat, 21 Sep 2013 10:46:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The parser never has supported it, the datastore API did happen to work
but whitespace in key names is a really bad idea and not something I think we
should encourage or support.

Fix test case failures after explicitly ignoring it for variable expansion
purposes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
index 5161586..f281a35 100644
--- a/bitbake/lib/bb/tests/data.py
+++ b/bitbake/lib/bb/tests/data.py
@@ -27,21 +27,21 @@ import bb.data
 class DataExpansions(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
-        self.d["foo"] = "value of foo"
-        self.d["bar"] = "value of bar"
-        self.d["value of foo"] = "value of 'value of foo'"
+        self.d["foo"] = "value_of_foo"
+        self.d["bar"] = "value_of_bar"
+        self.d["value_of_foo"] = "value_of_'value_of_foo'"
 
     def test_one_var(self):
         val = self.d.expand("${foo}")
-        self.assertEqual(str(val), "value of foo")
+        self.assertEqual(str(val), "value_of_foo")
 
     def test_indirect_one_var(self):
         val = self.d.expand("${${foo}}")
-        self.assertEqual(str(val), "value of 'value of foo'")
+        self.assertEqual(str(val), "value_of_'value_of_foo'")
 
     def test_indirect_and_another(self):
         val = self.d.expand("${${foo}} ${bar}")
-        self.assertEqual(str(val), "value of 'value of foo' value of bar")
+        self.assertEqual(str(val), "value_of_'value_of_foo' value_of_bar")
 
     def test_python_snippet(self):
         val = self.d.expand("${@5*12}")
@@ -49,11 +49,11 @@ class DataExpansions(unittest.TestCase):
 
     def test_expand_in_python_snippet(self):
         val = self.d.expand("${@'boo ' + '${foo}'}")
-        self.assertEqual(str(val), "boo value of foo")
+        self.assertEqual(str(val), "boo value_of_foo")
 
     def test_python_snippet_getvar(self):
         val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
-        self.assertEqual(str(val), "value of foo value of bar")
+        self.assertEqual(str(val), "value_of_foo value_of_bar")
 
     def test_python_snippet_syntax_error(self):
         self.d.setVar("FOO", "${@foo = 5}")
@@ -70,7 +70,7 @@ class DataExpansions(unittest.TestCase):
 
     def test_value_containing_value(self):
         val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
-        self.assertEqual(str(val), "value of foo value of bar")
+        self.assertEqual(str(val), "value_of_foo value_of_bar")
 
     def test_reference_undefined_var(self):
         val = self.d.expand("${undefinedvar} meh")
@@ -109,7 +109,7 @@ class DataExpansions(unittest.TestCase):
 
     def test_rename(self):
         self.d.renameVar("foo", "newfoo")
-        self.assertEqual(self.d.getVar("newfoo"), "value of foo")
+        self.assertEqual(self.d.getVar("newfoo"), "value_of_foo")
         self.assertEqual(self.d.getVar("foo"), None)
 
     def test_deletion(self):
@@ -118,17 +118,17 @@ class DataExpansions(unittest.TestCase):
 
     def test_keys(self):
         keys = self.d.keys()
-        self.assertEqual(keys, ['value of foo', 'foo', 'bar'])
+        self.assertEqual(keys, ['value_of_foo', 'foo', 'bar'])
 
 class TestNestedExpansions(unittest.TestCase):
     def setUp(self):
         self.d = bb.data.init()
         self.d["foo"] = "foo"
         self.d["bar"] = "bar"
-        self.d["value of foobar"] = "187"
+        self.d["value_of_foobar"] = "187"
 
     def test_refs(self):
-        val = self.d.expand("${value of ${foo}${bar}}")
+        val = self.d.expand("${value_of_${foo}${bar}}")
         self.assertEqual(str(val), "187")
 
     #def test_python_refs(self):
@@ -154,11 +154,11 @@ class TestNestedExpansions(unittest.TestCase):
     #    self.assertEqual(str(val), str(depth + 1))
 
     def test_mixed(self):
-        val = self.d.expand("${value of ${@('${foo}'+'bar')[0:3]}${${@'BAR'.lower()}}}")
+        val = self.d.expand("${value_of_${@('${foo}'+'bar')[0:3]}${${@'BAR'.lower()}}}")
         self.assertEqual(str(val), "187")
 
     def test_runtime(self):
-        val = self.d.expand("${${@'value of' + ' f'+'o'+'o'+'b'+'a'+'r'}}")
+        val = self.d.expand("${${@'value_of' + '_f'+'o'+'o'+'b'+'a'+'r'}}")
         self.assertEqual(str(val), "187")
 
 class TestMemoize(unittest.TestCase):
--
cgit v0.9.1



