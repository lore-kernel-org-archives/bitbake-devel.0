Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 98AEE77D24
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Apr 2017 23:19:27 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 02 Apr 2017 16:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,266,1486454400"; d="scan'208";a="243247998"
Received: from rbek-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.164.56])
	by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2017 16:19:27 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 11:19:05 +1200
Message-Id: <9b49033fce7e895fffce66c0d83a3fe984527ac2.1491175014.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491175014.git.paul.eggleton@linux.intel.com>
References: <cover.1491175014.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] bitbake-selftest: add contains tests
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
X-List-Received-Date: Sun, 02 Apr 2017 23:19:27 -0000

Add some tests to verify that we are extracting "contains" information
from python expressions in the code in the bb.data and bb.codeparser
modules.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/codeparser.py | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index a45a582..e30e78c 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -49,6 +49,9 @@ class ReferenceTest(unittest.TestCase):
     def assertExecs(self, execs):
         self.assertEqual(self.execs, execs)
 
+    def assertContains(self, contains):
+        self.assertEqual(self.contains, contains)
+
 class VariableReferenceTest(ReferenceTest):
 
     def parseExpression(self, exp):
@@ -201,6 +204,7 @@ class PythonReferenceTest(ReferenceTest):
 
         self.references = parsedvar.references | parser.references
         self.execs = parser.execs
+        self.contains = parser.contains
 
     @staticmethod
     def indent(value):
@@ -265,6 +269,26 @@ be. These unit tests are testing snippets."""
         self.assertExecs(set(["testget"]))
         del self.context["testget"]
 
+    def test_contains(self):
+        self.parseExpression('bb.utils.contains("TESTVAR", "one", "true", "false", d)')
+        self.assertContains({'TESTVAR': {'one'}})
+
+    def test_contains_multi(self):
+        self.parseExpression('bb.utils.contains("TESTVAR", "one two", "true", "false", d)')
+        self.assertContains({'TESTVAR': {'one two'}})
+
+    def test_contains_any(self):
+        self.parseExpression('bb.utils.contains_any("TESTVAR", "hello", "true", "false", d)')
+        self.assertContains({'TESTVAR': {'hello'}})
+
+    def test_contains_any_multi(self):
+        self.parseExpression('bb.utils.contains_any("TESTVAR", "one two three", "true", "false", d)')
+        self.assertContains({'TESTVAR': {'one', 'two', 'three'}})
+
+    def test_contains_filter(self):
+        self.parseExpression('bb.utils.filter("TESTVAR", "hello there world", d)')
+        self.assertContains({'TESTVAR': {'hello', 'there', 'world'}})
+
 
 class DependencyReferenceTest(ReferenceTest):
 
@@ -370,6 +394,30 @@ esac
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
+    def test_contains_vardeps(self):
+        expr = '${@bb.utils.filter("TESTVAR", "somevalue anothervalue", d)} \
+                ${@bb.utils.contains("TESTVAR", "testval testval2", "yetanothervalue", "", d)} \
+                ${@bb.utils.contains("TESTVAR", "testval2 testval3", "blah", "", d)} \
+                ${@bb.utils.contains_any("TESTVAR", "testval2 testval3", "lastone", "", d)}'
+        parsedvar = self.d.expandWithRefs(expr, None)
+        # Check contains
+        self.assertEqual(parsedvar.contains, {'TESTVAR': {'testval2 testval3', 'anothervalue', 'somevalue', 'testval testval2', 'testval2', 'testval3'}})
+        # Check dependencies
+        self.d.setVar('ANOTHERVAR', expr)
+        self.d.setVar('TESTVAR', 'anothervalue testval testval2')
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), self.d)
+        self.assertEqual(sorted(values.splitlines()),
+                         sorted([expr,
+                          'TESTVAR{anothervalue} = Set',
+                          'TESTVAR{somevalue} = Unset',
+                          'TESTVAR{testval testval2} = Set',
+                          'TESTVAR{testval2 testval3} = Unset',
+                          'TESTVAR{testval2} = Set',
+                          'TESTVAR{testval3} = Unset'
+                          ]))
+        # Check final value
+        self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['anothervalue', 'yetanothervalue', 'lastone'])
+
     #Currently no wildcard support
     #def test_vardeps_wildcards(self):
     #    self.d.setVar("oe_libinstall", "echo test")
-- 
2.9.3


