Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0969A70031
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 13:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D3g87015608 for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:03:42 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GffUXK7P4LEF for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 14:03:42 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D3fek015603
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:03:42 +0100
Message-ID: <1462799021.21831.130.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 May 2016 14:03:41 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] tests: assertEquals -> assertEqual
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
X-List-Received-Date: Mon, 09 May 2016 13:03:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The preferred form is assertEqaual, assertEquals is deprecated and
not present in python v3. 

This is v2.7 safe.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
index bb820e4..5ea9d84 100644
--- a/bitbake/lib/bb/tests/codeparser.py
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -302,7 +302,7 @@ bb.data.getVar(a(), d, False)
 
         deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
 
-        self.assertEquals(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
+        self.assertEqual(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
 
 
     shelldata = """
@@ -349,7 +349,7 @@ esac
 
         deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
 
-        self.assertEquals(deps, set(["somevar", "inverted"] + execs))
+        self.assertEqual(deps, set(["somevar", "inverted"] + execs))
 
 
     def test_vardeps(self):
@@ -359,7 +359,7 @@ esac
 
         deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
 
-        self.assertEquals(deps, set(["oe_libinstall"]))
+        self.assertEqual(deps, set(["oe_libinstall"]))
 
     def test_vardeps_expand(self):
         self.d.setVar("oe_libinstall", "echo test")
@@ -368,7 +368,7 @@ esac
 
         deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
 
-        self.assertEquals(deps, set(["oe_libinstall"]))
+        self.assertEqual(deps, set(["oe_libinstall"]))
 
     #Currently no wildcard support
     #def test_vardeps_wildcards(self):
diff --git a/bitbake/lib/bb/tests/cow.py b/bitbake/lib/bb/tests/cow.py
index 35c5841..d149d84 100644
--- a/bitbake/lib/bb/tests/cow.py
+++ b/bitbake/lib/bb/tests/cow.py
@@ -34,14 +34,14 @@ class COWTestCase(unittest.TestCase):
         from bb.COW import COWDictBase
         a = COWDictBase.copy()
 
-        self.assertEquals(False, a.has_key('a'))
+        self.assertEqual(False, 'a' in a)
 
         a['a'] = 'a'
         a['b'] = 'b'
-        self.assertEquals(True, a.has_key('a'))
-        self.assertEquals(True, a.has_key('b'))
-        self.assertEquals('a', a['a'] )
-        self.assertEquals('b', a['b'] )
+        self.assertEqual(True, 'a' in a)
+        self.assertEqual(True, 'b' in a)
+        self.assertEqual('a', a['a'] )
+        self.assertEqual('b', a['b'] )
 
     def testCopyCopy(self):
         """
@@ -60,31 +60,31 @@ class COWTestCase(unittest.TestCase):
         c['a'] = 30
 
         # test separation of the two instances
-        self.assertEquals(False, c.has_key('c'))
-        self.assertEquals(30, c['a'])
-        self.assertEquals(10, b['a'])
+        self.assertEqual(False, 'c' in c)
+        self.assertEqual(30, c['a'])
+        self.assertEqual(10, b['a'])
 
         # test copy
         b_2 = b.copy()
         c_2 = c.copy()
 
-        self.assertEquals(False, c_2.has_key('c'))
-        self.assertEquals(10, b_2['a'])
+        self.assertEqual(False, 'c' in c_2)
+        self.assertEqual(10, b_2['a'])
 
         b_2['d'] = 40
-        self.assertEquals(False, c_2.has_key('d'))
-        self.assertEquals(True, b_2.has_key('d'))
-        self.assertEquals(40, b_2['d'])
-        self.assertEquals(False, b.has_key('d'))
-        self.assertEquals(False, c.has_key('d'))
+        self.assertEqual(False, 'd' in c_2)
+        self.assertEqual(True, 'd' in b_2)
+        self.assertEqual(40, b_2['d'])
+        self.assertEqual(False, 'd' in b)
+        self.assertEqual(False, 'd' in c)
 
         c_2['d'] = 30
-        self.assertEquals(True, c_2.has_key('d'))
-        self.assertEquals(True, b_2.has_key('d'))
-        self.assertEquals(30, c_2['d'])
-        self.assertEquals(40, b_2['d'])
-        self.assertEquals(False, b.has_key('d'))
-        self.assertEquals(False, c.has_key('d'))
+        self.assertEqual(True, 'd' in c_2)
+        self.assertEqual(True, 'd' in b_2)
+        self.assertEqual(30, c_2['d'])
+        self.assertEqual(40, b_2['d'])
+        self.assertEqual(False, 'd' in b)
+        self.assertEqual(False, 'd' in c)
 
         # test copy of the copy
         c_3 = c_2.copy()
@@ -92,19 +92,19 @@ class COWTestCase(unittest.TestCase):
         b_3_2 = b_2.copy()
 
         c_3['e'] = 4711
-        self.assertEquals(4711, c_3['e'])
-        self.assertEquals(False, c_2.has_key('e'))
-        self.assertEquals(False, b_3.has_key('e'))
-        self.assertEquals(False, b_3_2.has_key('e'))
-        self.assertEquals(False, b_2.has_key('e'))
+        self.assertEqual(4711, c_3['e'])
+        self.assertEqual(False, 'e' in c_2)
+        self.assertEqual(False, 'e' in b_3)
+        self.assertEqual(False, 'e' in b_3_2)
+        self.assertEqual(False, 'e' in b_2)
 
         b_3['e'] = 'viel'
-        self.assertEquals('viel', b_3['e'])
-        self.assertEquals(4711, c_3['e'])
-        self.assertEquals(False, c_2.has_key('e'))
-        self.assertEquals(True, b_3.has_key('e'))
-        self.assertEquals(False, b_3_2.has_key('e'))
-        self.assertEquals(False, b_2.has_key('e'))
+        self.assertEqual('viel', b_3['e'])
+        self.assertEqual(4711, c_3['e'])
+        self.assertEqual(False, 'e' in c_2)
+        self.assertEqual(True, 'e' in b_3)
+        self.assertEqual(False, 'e' in b_3_2)
+        self.assertEqual(False, 'e' in b_2)
 
     def testCow(self):
         from bb.COW import COWDictBase
@@ -115,12 +115,12 @@ class COWTestCase(unittest.TestCase):
 
         copy = c.copy()
 
-        self.assertEquals(1027, c['123'])
-        self.assertEquals(4711, c['other'])
-        self.assertEquals({'abc':10, 'bcd':20}, c['d'])
-        self.assertEquals(1027, copy['123'])
-        self.assertEquals(4711, copy['other'])
-        self.assertEquals({'abc':10, 'bcd':20}, copy['d'])
+        self.assertEqual(1027, c['123'])
+        self.assertEqual(4711, c['other'])
+        self.assertEqual({'abc':10, 'bcd':20}, c['d'])
+        self.assertEqual(1027, copy['123'])
+        self.assertEqual(4711, copy['other'])
+        self.assertEqual({'abc':10, 'bcd':20}, copy['d'])
 
         # cow it now
         copy['123'] = 1028
@@ -128,9 +128,9 @@ class COWTestCase(unittest.TestCase):
         copy['d']['abc'] = 20
 
 
-        self.assertEquals(1027, c['123'])
-        self.assertEquals(4711, c['other'])
-        self.assertEquals({'abc':10, 'bcd':20}, c['d'])
-        self.assertEquals(1028, copy['123'])
-        self.assertEquals(4712, copy['other'])
-        self.assertEquals({'abc':20, 'bcd':20}, copy['d'])
+        self.assertEqual(1027, c['123'])
+        self.assertEqual(4711, c['other'])
+        self.assertEqual({'abc':10, 'bcd':20}, c['d'])
+        self.assertEqual(1028, copy['123'])
+        self.assertEqual(4712, copy['other'])
+        self.assertEqual({'abc':20, 'bcd':20}, copy['d'])



