Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UZeO0-0000Uh-4y
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 11:40:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 4575A19DDC
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DljrBkkzB2tC for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 2790419DC6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 011648A7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.localdomain (Postfix) with ESMTP id E90A38A0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id E5CA83E05E
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0;
	Tue, 7 May 2013 11:22:38 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id C8C049C083; 
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 7 May 2013 11:22:38 +0200
Message-ID: <1367918558-16136-3-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
References: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [WIP 2/2] initial work on supporting shell arith
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 May 2013 09:40:55 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bin/bitbake-selftest       |    1 +
 lib/bb/pysh/pyshlex.py     |   46 +++++++++++++++--
 lib/bb/tests/codeparser.py |   22 ++++++++
 lib/bb/tests/pysh.py       |  119 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 3 deletions(-)
 create mode 100644 lib/bb/tests/pysh.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 48a58fe..904a801 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -29,6 +29,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.cow",
          "bb.tests.data",
          "bb.tests.fetch",
+         "bb.tests.pysh",
          "bb.tests.utils"]
 
 for t in tests:
diff --git a/lib/bb/pysh/pyshlex.py b/lib/bb/pysh/pyshlex.py
index b301236..0c68e57 100644
--- a/lib/bb/pysh/pyshlex.py
+++ b/lib/bb/pysh/pyshlex.py
@@ -211,7 +211,45 @@ class WordLexer:
         else:
             #Keep everything until the separator and defer processing
             return pos, False
-            
+
+    def _find_balanced(self, buf, delim, escapes=True):
+        expr = 1
+        pos = 0
+
+        while expr > 0 and pos < len(buf):
+            # open delimiter
+            if ( delim[0] is not None and
+                 ''.join(buf[pos : pos+len(delim[0])]) == delim[0]):
+                expr += 1
+                pos += len(delim[0]) - 1
+            # closing delimiter
+            elif ''.join(buf[pos : pos+len(delim[1])]) == delim[1]:
+                expr -= 1
+                pos += len(delim[1]) - 1
+            elif escapes and buf[pos] == '\\':
+                pos += 1 # skip next, it's escaped!
+
+            pos += 1
+
+        if expr > 0:
+            return -1 # Could not find matching pair of delims
+        return pos
+
+    def _parse_arithmetic(self, buf, result, eof):
+        if not buf:
+            raise NeedMore()
+
+        pos = self._find_balanced(buf, ("$((", "))"))
+
+        if pos < 0:
+            raise NeedMore()
+
+        result[-1] += ''.join(buf[:pos-2])
+        result.append("))")
+
+        has_eof = len(buf) <= pos
+        return pos, has_eof
+
     def _parse_command(self, buf, result, eof):
         if not buf:
             raise NeedMore()
@@ -229,7 +267,7 @@ class WordLexer:
             return pos+1, True
         else:
             return pos, False
-            
+
     def _parse_parameter(self, buf, result, eof):
         if not buf:
             raise NeedMore()
@@ -289,6 +327,8 @@ class WordLexer:
         sep = result[0]    
         if sep=='$(':
             parsefunc = self._parse_command
+        elif sep=='$((':
+            parsefunc = self._parse_arithmetic
         elif sep=='${':
             parsefunc = self._parse_parameter
         else:
@@ -386,7 +426,7 @@ def make_wordtree(token, here_document=False):
         try:
             result, remaining = WordLexer(heredoc = here_document).add(remaining, True)
         except NeedMore:
-            raise ShellSyntaxError('Invalid token "%s"')
+            raise ShellSyntaxError('Invalid token "%s"' % remaining)
         tree.append(result)
         
                 
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 938b04b..debb933 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -110,6 +110,28 @@ ${D}${libdir}/pkgconfig/*.pc
         self.parseExpression("foo=$(echo bar)")
         self.assertExecs(set(["echo"]))
 
+    def test_assign_arith(self):
+        self.parseExpression("python2.$((8-1))")
+        self.assertExecs(set(["python2.$((8-1))"]))
+
+    def test_assign_arith_only(self):
+        self.parseExpression("$((8-1))")
+        self.assertExecs(set(["$((8-1))"]))
+
+    @unittest.skip(
+        "FIXME: multiple shell arith expressions are not supported")
+    def test_assign_arith_dual(self):
+        self.parseExpression("$((1+1))to$((4-1))")
+        self.assertExecs(set(["$((1+1))to$((4-1))"]))
+
+    def test_assign_arith_nested1(self):
+        self.parseExpression("$((1+$((1))))")
+        self.assertExecs(set(["$((1+$((1))))"]))
+
+    def test_assign_arith_nested2(self):
+        self.parseExpression("$(( 1 + $(( 1 )) ))")
+        self.assertExecs(set(["$(( 1 + $(( 1 )) ))"]))
+
     def test_shell_unexpanded(self):
         self.setEmptyVars(["QT_BASE_NAME"])
         self.parseExpression('echo "${QT_BASE_NAME}"')
diff --git a/lib/bb/tests/pysh.py b/lib/bb/tests/pysh.py
new file mode 100644
index 0000000..3f64f14
--- /dev/null
+++ b/lib/bb/tests/pysh.py
@@ -0,0 +1,119 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Tests for the pysh lexer (pysh/)
+#
+# Copyright (C) 2013 Olof Johansson <olof.johansson@axis.com>
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
+from bb.pysh.pyshlex import WordLexer, NeedMore
+
+orig_init = WordLexer.__init__
+
+class WordLexerParseTest(unittest.TestCase):
+    # mock out WordLexer's constructor
+    def SetUp(self):
+        WordLexer.__init__ = lambda: None
+
+    def TearDown(self):
+        WordLexer.__init__ = orig_init
+
+    # The arithmetic tests make sure that WordLexer's _parse_arithmetic
+    # method can parse out the expected shell arithmetic expression,
+    # including support for nested expressions.
+    def assertArithmeticParser(self, expr, expect=None, eof=True, length=None):
+        expr = expr[3:] # strip off $((
+        result = ["$((", ""]
+        buf = list(expr)
+
+        # Unless stated otherwise, let's assume the complete buf
+        # is an shell arithmetic expression.
+        if not expect:
+            expect = ["$((", expr[:-2], "))"]
+        if not length:
+            length = len(expr)
+
+        wl = WordLexer()
+        pos, got_eof = WordLexer._parse_arithmetic(wl, buf, result, True)
+
+        self.assertEqual(buf, list(expr))
+        self.assertEqual(result, expect)
+        self.assertEqual(pos, length)
+        self.assertEqual(got_eof, eof)
+
+    def test_parse_arithmetic_simple(self):
+        self.assertArithmeticParser("$((1+1))")
+
+    def test_parse_arithmetic_simple_trailing(self):
+        self.assertArithmeticParser(
+            "$((1+1)); uptime",
+            expect=["$((", "1+1", "))"],
+            length=5,
+            eof=False)
+
+    def test_parse_arithmetic_incomplete(self):
+        wl = WordLexer()
+        res = ["$((", ""]
+        buf = list("10+")
+
+        needs_more = False
+        try:
+            pos, got_eof = WordLexer._parse_arithmetic(wl, buf, res, True)
+        except NeedMore:
+            needs_more = True
+
+        self.assertTrue(needs_more)
+
+    def test_parse_arithmetic_empty(self):
+        wl = WordLexer()
+        res = ["$((", ""]
+        buf = list("")
+
+        needs_more = False
+        try:
+            pos, got_eof = WordLexer._parse_arithmetic(wl, buf, res, True)
+        except NeedMore:
+            needs_more = True
+
+        self.assertTrue(needs_more)
+
+    def test_parse_arithmetic_simple_whitespace(self):
+        self.assertArithmeticParser("$(( 1 + 1 ))")
+
+    def test_parse_arithmetic_nested1(self):
+        self.assertArithmeticParser("$((1+$((1+2))))")
+
+    def test_parse_arithmetic_nested2(self):
+        self.assertArithmeticParser("$(($((1+2))+$((1+2))))")
+
+    def assertCommandParser(self, command="", sep=("$(", ")"), eof=True):
+        result = [sep[0], ""]
+        buf = ''.join([command, sep[1]])
+
+        wl = WordLexer()
+        pos, got_eof = WordLexer._parse_command(wl, buf, result, True)
+
+        self.assertEqual(result, [sep[0], command, sep[1]])
+
+    def test_parse_command_simple(self):
+        self.assertCommandParser("uptime")
+
+    def test_parse_command_backticks(self):
+        self.assertCommandParser("echo bar", sep=("`", "`"))
+
+    #def test_parse_command_nested(self):
+    #    self.assertCommandParser("echo $(uptime)")
-- 
1.7.10.4



