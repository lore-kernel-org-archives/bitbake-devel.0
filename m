Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQKR6-0001pZ-Bg for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 17:28:49 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44FJ17M015313
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 16:19:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15276-01 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 May 2012 16:18:56 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44FIpRw015307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 16:18:52 +0100
Message-ID: <1336144735.23777.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 May 2012 16:18:55 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake: Add start of bitbake regression/self testing
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
X-List-Received-Date: Fri, 04 May 2012 15:28:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This adds some basic unit testing for the codeparser and data store code. Many of
the actual test cases were taken from work by Chris Larson's OE-Signatures work but with
changes to adapt to the current bitbake APIs we need to test.

I also imported CoW tests written by Holger Freyther from the original bitbake-test
codebase: http://svn.berlios.de/wsvn/bitbake/trunk/bitbake-tests/tests/ and
some tests from the doctests that were removed in commit:
http://git.openembedded.org/bitbake/commit?id=3a11c2807972bbbddffde2fa67fc380d159da467

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
new file mode 100755
index 0000000..48a58fe
--- /dev/null
+++ b/bitbake/bin/bitbake-selftest
@@ -0,0 +1,38 @@
+#!/usr/bin/env python
+#
+# Copyright (C) 2012 Richard Purdie
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
+
+import os
+import sys, logging
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
+
+import unittest
+try:
+    import bb
+except RuntimeError as exc:
+    sys.exit(str(exc))
+
+tests = ["bb.tests.codeparser", 
+         "bb.tests.cow",
+         "bb.tests.data",
+         "bb.tests.fetch",
+         "bb.tests.utils"]
+
+for t in tests:
+    __import__(t)
+
+unittest.main(argv=["bitbake-selftest"] + tests)
+
diff --git a/bitbake/lib/bb/tests/__init__.py b/bitbake/lib/bb/tests/__init__.py
new file mode 100644
index 0000000..e69de29
--- a/dev/null
+++ b/bitbake/lib/bb/tests/__init__.py
diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
new file mode 100644
index 0000000..9b2d588
--- /dev/null
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -0,0 +1,369 @@
+#
+# BitBake Test for codeparser.py
+#
+# Copyright (C) 2010 Chris Larson
+# Copyright (C) 2012 Richard Purdie
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
+import logging
+import bb
+
+logger = logging.getLogger('BitBake.TestCodeParser')
+
+import bb.data
+
+class ReferenceTest(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+
+    def setEmptyVars(self, varlist):
+        for k in varlist:
+            self.d.setVar(k, "")
+
+    def setValues(self, values):
+        for k, v in values.items():
+            self.d.setVar(k, v)
+
+    def assertReferences(self, refs):
+        self.assertEqual(self.references, refs)
+
+    def assertExecs(self, execs):
+        self.assertEqual(self.execs, execs)
+
+class VariableReferenceTest(ReferenceTest):
+
+    def parseExpression(self, exp):
+        parsedvar = self.d.expandWithRefs(exp, None)
+        self.references = parsedvar.references
+
+    def test_simple_reference(self):
+        self.setEmptyVars(["FOO"])
+        self.parseExpression("${FOO}")
+        self.assertReferences(set(["FOO"]))
+
+    def test_nested_reference(self):
+        self.setEmptyVars(["BAR"])
+        self.d.setVar("FOO", "BAR")
+        self.parseExpression("${${FOO}}")
+        self.assertReferences(set(["FOO", "BAR"]))
+
+    def test_python_reference(self):
+        self.setEmptyVars(["BAR"])
+        self.parseExpression("${@bb.data.getVar('BAR', d, True) + 'foo'}")
+        self.assertReferences(set(["BAR"]))
+
+class ShellReferenceTest(ReferenceTest):
+
+    def parseExpression(self, exp):
+        parsedvar = self.d.expandWithRefs(exp, None)
+        parser = bb.codeparser.ShellParser("ParserTest", logger)
+        parser.parse_shell(parsedvar.value)
+
+        self.references = parsedvar.references
+        self.execs = parser.execs
+
+    def test_quotes_inside_assign(self):
+        self.parseExpression('foo=foo"bar"baz')
+        self.assertReferences(set([]))
+
+    def test_quotes_inside_arg(self):
+        self.parseExpression('sed s#"bar baz"#"alpha beta"#g')
+        self.assertExecs(set(["sed"]))
+
+    def test_arg_continuation(self):
+        self.parseExpression("sed -i -e s,foo,bar,g \\\n *.pc")
+        self.assertExecs(set(["sed"]))
+
+    def test_dollar_in_quoted(self):
+        self.parseExpression('sed -i -e "foo$" *.pc')
+        self.assertExecs(set(["sed"]))
+
+    def test_quotes_inside_arg_continuation(self):
+        self.setEmptyVars(["bindir", "D", "libdir"])
+        self.parseExpression("""
+sed -i -e s#"moc_location=.*$"#"moc_location=${bindir}/moc4"# \\
+-e s#"uic_location=.*$"#"uic_location=${bindir}/uic4"# \\
+${D}${libdir}/pkgconfig/*.pc
+""")
+        self.assertReferences(set(["bindir", "D", "libdir"]))
+
+    def test_assign_subshell_expansion(self):
+        self.parseExpression("foo=$(echo bar)")
+        self.assertExecs(set(["echo"]))
+
+    def test_shell_unexpanded(self):
+        self.setEmptyVars(["QT_BASE_NAME"])
+        self.parseExpression('echo "${QT_BASE_NAME}"')
+        self.assertExecs(set(["echo"]))
+        self.assertReferences(set(["QT_BASE_NAME"]))
+
+    def test_incomplete_varexp_single_quotes(self):
+        self.parseExpression("sed -i -e 's:IP{:I${:g' $pc")
+        self.assertExecs(set(["sed"]))
+
+
+    def test_until(self):
+        self.parseExpression("until false; do echo true; done")
+        self.assertExecs(set(["false", "echo"]))
+        self.assertReferences(set())
+
+    def test_case(self):
+        self.parseExpression("""
+case $foo in
+*)
+bar
+;;
+esac
+""")
+        self.assertExecs(set(["bar"]))
+        self.assertReferences(set())
+
+    def test_assign_exec(self):
+        self.parseExpression("a=b c='foo bar' alpha 1 2 3")
+        self.assertExecs(set(["alpha"]))
+
+    def test_redirect_to_file(self):
+        self.setEmptyVars(["foo"])
+        self.parseExpression("echo foo >${foo}/bar")
+        self.assertExecs(set(["echo"]))
+        self.assertReferences(set(["foo"]))
+
+    def test_heredoc(self):
+        self.setEmptyVars(["theta"])
+        self.parseExpression("""
+cat <<END
+alpha
+beta
+${theta}
+END
+""")
+        self.assertReferences(set(["theta"]))
+
+    def test_redirect_from_heredoc(self):
+        v = ["B", "SHADOW_MAILDIR", "SHADOW_MAILFILE", "SHADOW_UTMPDIR", "SHADOW_LOGDIR", "bindir"]
+        self.setEmptyVars(v)
+        self.parseExpression("""
+cat <<END >${B}/cachedpaths
+shadow_cv_maildir=${SHADOW_MAILDIR}
+shadow_cv_mailfile=${SHADOW_MAILFILE}
+shadow_cv_utmpdir=${SHADOW_UTMPDIR}
+shadow_cv_logdir=${SHADOW_LOGDIR}
+shadow_cv_passwd_dir=${bindir}
+END
+""")
+        self.assertReferences(set(v))
+        self.assertExecs(set(["cat"]))
+
+#    def test_incomplete_command_expansion(self):
+#        self.assertRaises(reftracker.ShellSyntaxError, reftracker.execs,
+#                          bbvalue.shparse("cp foo`", self.d), self.d)
+
+#    def test_rogue_dollarsign(self):
+#        self.setValues({"D" : "/tmp"})
+#        self.parseExpression("install -d ${D}$")
+#        self.assertReferences(set(["D"]))
+#        self.assertExecs(set(["install"]))
+
+
+class PythonReferenceTest(ReferenceTest):
+
+    def setUp(self):
+        self.d = bb.data.init()
+        if hasattr(bb.utils, "_context"):
+            self.context = bb.utils._context
+        else:
+            import __builtin__
+            self.context = __builtin__.__dict__
+
+    def parseExpression(self, exp):
+        parsedvar = self.d.expandWithRefs(exp, None)
+        parser = bb.codeparser.PythonParser("ParserTest", logger)
+        parser.parse_python(parsedvar.value)
+
+        self.references = parsedvar.references | parser.references
+        self.execs = parser.execs
+
+    @staticmethod
+    def indent(value):
+        """Python Snippets have to be indented, python values don't have to
+be. These unit tests are testing snippets."""
+        return " " + value
+
+    def test_getvar_reference(self):
+        self.parseExpression("bb.data.getVar('foo', d, True)")
+        self.assertReferences(set(["foo"]))
+        self.assertExecs(set())
+
+    def test_getvar_computed_reference(self):
+        self.parseExpression("bb.data.getVar('f' + 'o' + 'o', d, True)")
+        self.assertReferences(set())
+        self.assertExecs(set())
+
+    def test_getvar_exec_reference(self):
+        self.parseExpression("eval('bb.data.getVar(\"foo\", d, True)')")
+        self.assertReferences(set())
+        self.assertExecs(set(["eval"]))
+
+    def test_var_reference(self):
+        self.context["foo"] = lambda x: x
+        self.setEmptyVars(["FOO"])
+        self.parseExpression("foo('${FOO}')")
+        self.assertReferences(set(["FOO"]))
+        self.assertExecs(set(["foo"]))
+        del self.context["foo"]
+
+    def test_var_exec(self):
+        for etype in ("func", "task"):
+            self.d.setVar("do_something", "echo 'hi mom! ${FOO}'")
+            self.d.setVarFlag("do_something", etype, True)
+            self.parseExpression("bb.build.exec_func('do_something', d)")
+            self.assertReferences(set(["do_something"]))
+
+    def test_function_reference(self):
+        self.context["testfunc"] = lambda msg: bb.msg.note(1, None, msg)
+        self.d.setVar("FOO", "Hello, World!")
+        self.parseExpression("testfunc('${FOO}')")
+        self.assertReferences(set(["FOO"]))
+        self.assertExecs(set(["testfunc"]))
+        del self.context["testfunc"]
+
+    def test_qualified_function_reference(self):
+        self.parseExpression("time.time()")
+        self.assertExecs(set(["time.time"]))
+
+    def test_qualified_function_reference_2(self):
+        self.parseExpression("os.path.dirname('/foo/bar')")
+        self.assertExecs(set(["os.path.dirname"]))
+
+    def test_qualified_function_reference_nested(self):
+        self.parseExpression("time.strftime('%Y%m%d',time.gmtime())")
+        self.assertExecs(set(["time.strftime", "time.gmtime"]))
+
+    def test_function_reference_chained(self):
+        self.context["testget"] = lambda: "\tstrip me "
+        self.parseExpression("testget().strip()")
+        self.assertExecs(set(["testget"]))
+        del self.context["testget"]
+
+
+class DependencyReferenceTest(ReferenceTest):
+
+    pydata = """
+bb.data.getVar('somevar', d, True)
+def test(d):
+    foo = 'bar %s' % 'foo'
+def test2(d):
+    d.getVar(foo, True)
+    d.getVar('bar', False)
+    test2(d)
+
+def a():
+    \"\"\"some
+    stuff
+    \"\"\"
+    return "heh"
+
+test(d)
+
+bb.data.expand(bb.data.getVar("something", False, d), d)
+bb.data.expand("${inexpand} somethingelse", d)
+bb.data.getVar(a(), d, False)
+"""
+
+    def test_python(self):
+        self.d.setVar("FOO", self.pydata)
+        self.setEmptyVars(["inexpand", "a", "test2", "test"])
+        self.d.setVarFlags("FOO", {"func": True, "python": True})
+
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+
+        self.assertEquals(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
+
+
+    shelldata = """
+foo () {
+bar
+}
+{
+echo baz
+$(heh)
+eval `moo`
+}
+a=b
+c=d
+(
+true && false
+test -f foo
+testval=something
+$testval
+) || aiee
+! inverted
+echo ${somevar}
+
+case foo in
+bar)
+echo bar
+;;
+baz)
+echo baz
+;;
+foo*)
+echo foo
+;;
+esac
+"""
+
+    def test_shell(self):
+        execs = ["bar", "echo", "heh", "moo", "true", "aiee"]
+        self.d.setVar("somevar", "heh")
+        self.d.setVar("inverted", "echo inverted...")
+        self.d.setVarFlag("inverted", "func", True)
+        self.d.setVar("FOO", self.shelldata)
+        self.d.setVarFlags("FOO", {"func": True})
+        self.setEmptyVars(execs)
+
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+
+        self.assertEquals(deps, set(["somevar", "inverted"] + execs))
+
+
+    def test_vardeps(self):
+        self.d.setVar("oe_libinstall", "echo test")
+        self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
+        self.d.setVarFlag("FOO", "vardeps", "oe_libinstall")
+
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+
+        self.assertEquals(deps, set(["oe_libinstall"]))
+
+    def test_vardeps_expand(self):
+        self.d.setVar("oe_libinstall", "echo test")
+        self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
+        self.d.setVarFlag("FOO", "vardeps", "${@'oe_libinstall'}")
+
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+
+        self.assertEquals(deps, set(["oe_libinstall"]))
+
+    #Currently no wildcard support
+    #def test_vardeps_wildcards(self):
+    #    self.d.setVar("oe_libinstall", "echo test")
+    #    self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
+    #    self.d.setVarFlag("FOO", "vardeps", "oe_*")
+    #    self.assertEquals(deps, set(["oe_libinstall"]))
+
+
diff --git a/bitbake/lib/bb/tests/cow.py b/bitbake/lib/bb/tests/cow.py
new file mode 100644
index 0000000..599b2aa
--- /dev/null
+++ b/bitbake/lib/bb/tests/cow.py
@@ -0,0 +1,134 @@
+#
+# BitBake Tests for Copy-on-Write (cow.py)
+#
+# Copyright 2006 Holger Freyther <freyther@handhelds.org>
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
+import os
+
+class COWTestCase(unittest.TestCase):
+    """
+    Test case for the COW module from mithro
+    """
+
+    def testGetSet(self):
+        """
+        Test and set
+        """
+        from bb.COW import COWDictBase
+        a = COWDictBase.copy()
+
+        self.assertEquals(False, a.has_key('a'))
+
+        a['a'] = 'a'
+        a['b'] = 'b'
+        self.assertEquals(True, a.has_key('a'))
+        self.assertEquals(True, a.has_key('b'))
+        self.assertEquals('a', a['a'] )
+        self.assertEquals('b', a['b'] )
+
+    def testCopyCopy(self):
+        """
+        Test the copy of copies
+        """
+
+        from bb.COW import COWDictBase
+
+        # create two COW dict 'instances'
+        b = COWDictBase.copy()
+        c = COWDictBase.copy()
+
+        # assign some keys to one instance, some keys to another
+        b['a'] = 10
+        b['c'] = 20
+        c['a'] = 30
+
+        # test separation of the two instances
+        self.assertEquals(False, c.has_key('c'))
+        self.assertEquals(30, c['a'])
+        self.assertEquals(10, b['a'])
+
+        # test copy
+        b_2 = b.copy()
+        c_2 = c.copy()
+
+        self.assertEquals(False, c_2.has_key('c'))
+        self.assertEquals(10, b_2['a'])
+
+        b_2['d'] = 40
+        self.assertEquals(False, c_2.has_key('d'))
+        self.assertEquals(True, b_2.has_key('d'))
+        self.assertEquals(40, b_2['d'])
+        self.assertEquals(False, b.has_key('d'))
+        self.assertEquals(False, c.has_key('d'))
+
+        c_2['d'] = 30
+        self.assertEquals(True, c_2.has_key('d'))
+        self.assertEquals(True, b_2.has_key('d'))
+        self.assertEquals(30, c_2['d'])
+        self.assertEquals(40, b_2['d'])
+        self.assertEquals(False, b.has_key('d'))
+        self.assertEquals(False, c.has_key('d'))
+
+        # test copy of the copy
+        c_3 = c_2.copy()
+        b_3 = b_2.copy()
+        b_3_2 = b_2.copy()
+
+        c_3['e'] = 4711
+        self.assertEquals(4711, c_3['e'])
+        self.assertEquals(False, c_2.has_key('e'))
+        self.assertEquals(False, b_3.has_key('e'))
+        self.assertEquals(False, b_3_2.has_key('e'))
+        self.assertEquals(False, b_2.has_key('e'))
+
+        b_3['e'] = 'viel'
+        self.assertEquals('viel', b_3['e'])
+        self.assertEquals(4711, c_3['e'])
+        self.assertEquals(False, c_2.has_key('e'))
+        self.assertEquals(True, b_3.has_key('e'))
+        self.assertEquals(False, b_3_2.has_key('e'))
+        self.assertEquals(False, b_2.has_key('e'))
+
+    def testCow(self):
+        from bb.COW import COWDictBase
+        c = COWDictBase.copy()
+        c['123'] = 1027
+        c['other'] = 4711
+        c['d'] = { 'abc' : 10, 'bcd' : 20 }
+
+        copy = c.copy()
+
+        self.assertEquals(1027, c['123'])
+        self.assertEquals(4711, c['other'])
+        self.assertEquals({'abc':10, 'bcd':20}, c['d'])
+        self.assertEquals(1027, copy['123'])
+        self.assertEquals(4711, copy['other'])
+        self.assertEquals({'abc':10, 'bcd':20}, copy['d'])
+
+        # cow it now
+        copy['123'] = 1028
+        copy['other'] = 4712
+        copy['d']['abc'] = 20
+
+
+        self.assertEquals(1027, c['123'])
+        self.assertEquals(4711, c['other'])
+        self.assertEquals({'abc':10, 'bcd':20}, c['d'])
+        self.assertEquals(1028, copy['123'])
+        self.assertEquals(4712, copy['other'])
+        self.assertEquals({'abc':20, 'bcd':20}, copy['d'])
diff --git a/bitbake/lib/bb/tests/data.py b/bitbake/lib/bb/tests/data.py
new file mode 100644
index 0000000..b2ab8ee
--- /dev/null
+++ b/bitbake/lib/bb/tests/data.py
@@ -0,0 +1,252 @@
+#
+# BitBake Tests for the Data Store (data.py/data_smart.py)
+#
+# Copyright (C) 2010 Chris Larson
+# Copyright (C) 2012 Richard Purdie
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
+import bb
+import bb.data
+
+class DataExpansions(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d["foo"] = "value of foo"
+        self.d["bar"] = "value of bar"
+        self.d["value of foo"] = "value of 'value of foo'"
+
+    def test_one_var(self):
+        val = self.d.expand("${foo}")
+        self.assertEqual(str(val), "value of foo")
+
+    def test_indirect_one_var(self):
+        val = self.d.expand("${${foo}}")
+        self.assertEqual(str(val), "value of 'value of foo'")
+
+    def test_indirect_and_another(self):
+        val = self.d.expand("${${foo}} ${bar}")
+        self.assertEqual(str(val), "value of 'value of foo' value of bar")
+
+    def test_python_snippet(self):
+        val = self.d.expand("${@5*12}")
+        self.assertEqual(str(val), "60")
+
+    def test_expand_in_python_snippet(self):
+        val = self.d.expand("${@'boo ' + '${foo}'}")
+        self.assertEqual(str(val), "boo value of foo")
+
+    def test_python_snippet_getvar(self):
+        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
+        self.assertEqual(str(val), "value of foo value of bar")
+
+    def test_python_snippet_syntax_error(self):
+        self.d.setVar("FOO", "${@foo = 5}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_python_snippet_runtime_error(self):
+        self.d.setVar("FOO", "${@int('test')}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_python_snippet_error_path(self):
+        self.d.setVar("FOO", "foo value ${BAR}")
+        self.d.setVar("BAR", "bar value ${@int('test')}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_value_containing_value(self):
+        val = self.d.expand("${@d.getVar('foo', True) + ' ${bar}'}")
+        self.assertEqual(str(val), "value of foo value of bar")
+
+    def test_reference_undefined_var(self):
+        val = self.d.expand("${undefinedvar} meh")
+        self.assertEqual(str(val), "${undefinedvar} meh")
+
+    def test_double_reference(self):
+        self.d.setVar("BAR", "bar value")
+        self.d.setVar("FOO", "${BAR} foo ${BAR}")
+        val = self.d.getVar("FOO", True)
+        self.assertEqual(str(val), "bar value foo bar value")
+
+    def test_direct_recursion(self):
+        self.d.setVar("FOO", "${FOO}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_indirect_recursion(self):
+        self.d.setVar("FOO", "${BAR}")
+        self.d.setVar("BAR", "${BAZ}")
+        self.d.setVar("BAZ", "${FOO}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_recursion_exception(self):
+        self.d.setVar("FOO", "${BAR}")
+        self.d.setVar("BAR", "${${@'FOO'}}")
+        self.assertRaises(bb.data_smart.ExpansionError, self.d.getVar, "FOO", True)
+
+    def test_incomplete_varexp_single_quotes(self):
+        self.d.setVar("FOO", "sed -i -e 's:IP{:I${:g' $pc")
+        val = self.d.getVar("FOO", True)
+        self.assertEqual(str(val), "sed -i -e 's:IP{:I${:g' $pc")
+
+    def test_nonstring(self):
+        self.d.setVar("TEST", 5)
+        val = self.d.getVar("TEST", True)
+        self.assertEqual(str(val), "5")
+
+    def test_rename(self):
+        self.d.renameVar("foo", "newfoo")
+        self.assertEqual(self.d.getVar("newfoo"), "value of foo")
+        self.assertEqual(self.d.getVar("foo"), None)
+
+    def test_deletion(self):
+        self.d.delVar("foo")
+        self.assertEqual(self.d.getVar("foo"), None)
+
+    def test_keys(self):
+        keys = self.d.keys()
+        self.assertEqual(keys, ['value of foo', 'foo', 'bar'])
+
+class TestNestedExpansions(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d["foo"] = "foo"
+        self.d["bar"] = "bar"
+        self.d["value of foobar"] = "187"
+
+    def test_refs(self):
+        val = self.d.expand("${value of ${foo}${bar}}")
+        self.assertEqual(str(val), "187")
+
+    #def test_python_refs(self):
+    #    val = self.d.expand("${@${@3}**2 + ${@4}**2}")
+    #    self.assertEqual(str(val), "25")
+
+    def test_ref_in_python_ref(self):
+        val = self.d.expand("${@'${foo}' + 'bar'}")
+        self.assertEqual(str(val), "foobar")
+
+    def test_python_ref_in_ref(self):
+        val = self.d.expand("${${@'f'+'o'+'o'}}")
+        self.assertEqual(str(val), "foo")
+
+    def test_deep_nesting(self):
+        depth = 100
+        val = self.d.expand("${" * depth + "foo" + "}" * depth)
+        self.assertEqual(str(val), "foo")
+
+    #def test_deep_python_nesting(self):
+    #    depth = 50
+    #    val = self.d.expand("${@" * depth + "1" + "+1}" * depth)
+    #    self.assertEqual(str(val), str(depth + 1))
+
+    def test_mixed(self):
+        val = self.d.expand("${value of ${@('${foo}'+'bar')[0:3]}${${@'BAR'.lower()}}}")
+        self.assertEqual(str(val), "187")
+
+    def test_runtime(self):
+        val = self.d.expand("${${@'value of' + ' f'+'o'+'o'+'b'+'a'+'r'}}")
+        self.assertEqual(str(val), "187")
+
+class TestMemoize(unittest.TestCase):
+    def test_memoized(self):
+        d = bb.data.init()
+        d.setVar("FOO", "bar")
+        self.assertTrue(d.getVar("FOO") is d.getVar("FOO"))
+
+    def test_not_memoized(self):
+        d1 = bb.data.init()
+        d2 = bb.data.init()
+        d1.setVar("FOO", "bar")
+        d2.setVar("FOO", "bar2")
+        self.assertTrue(d1.getVar("FOO") is not d2.getVar("FOO"))
+
+    def test_changed_after_memoized(self):
+        d = bb.data.init()
+        d.setVar("foo", "value of foo")
+        self.assertEqual(str(d.getVar("foo")), "value of foo")
+        d.setVar("foo", "second value of foo")
+        self.assertEqual(str(d.getVar("foo")), "second value of foo")
+
+    def test_same_value(self):
+        d = bb.data.init()
+        d.setVar("foo", "value of")
+        d.setVar("bar", "value of")
+        self.assertEqual(d.getVar("foo"),
+                         d.getVar("bar"))
+
+class TestConcat(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("FOO", "foo")
+        self.d.setVar("VAL", "val")
+        self.d.setVar("BAR", "bar")
+
+    def test_prepend(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.prependVar("TEST", "${FOO}:")
+        self.assertEqual(self.d.getVar("TEST", True), "foo:val")
+
+    def test_append(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.appendVar("TEST", ":${BAR}")
+        self.assertEqual(self.d.getVar("TEST", True), "val:bar")
+
+    def test_multiple_append(self):
+        self.d.setVar("TEST", "${VAL}")
+        self.d.prependVar("TEST", "${FOO}:")
+        self.d.appendVar("TEST", ":val2")
+        self.d.appendVar("TEST", ":${BAR}")
+        self.assertEqual(self.d.getVar("TEST", True), "foo:val:val2:bar")
+
+class TestOverrides(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("OVERRIDES", "foo:bar:local")
+        self.d.setVar("TEST", "testvalue")
+
+    def test_no_override(self):
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue")
+
+    def test_one_override(self):
+        self.d.setVar("TEST_bar", "testvalue2")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue2")
+
+    def test_multiple_override(self):
+        self.d.setVar("TEST_bar", "testvalue2")
+        self.d.setVar("TEST_local", "testvalue3")
+        self.d.setVar("TEST_foo", "testvalue4")
+        bb.data.update_data(self.d)
+        self.assertEqual(self.d.getVar("TEST", True), "testvalue3")
+
+
+class TestFlags(unittest.TestCase):
+    def setUp(self):
+        self.d = bb.data.init()
+        self.d.setVar("foo", "value of foo")
+        self.d.setVarFlag("foo", "flag1", "value of flag1")
+        self.d.setVarFlag("foo", "flag2", "value of flag2")
+
+    def test_setflag(self):
+        self.assertEqual(self.d.getVarFlag("foo", "flag1"), "value of flag1")
+        self.assertEqual(self.d.getVarFlag("foo", "flag2"), "value of flag2")
+
+    def test_delflag(self):
+        self.d.delVarFlag("foo", "flag2")
+        self.assertEqual(self.d.getVarFlag("foo", "flag1"), "value of flag1")
+        self.assertEqual(self.d.getVarFlag("foo", "flag2"), None)
+
+
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
new file mode 100644
index 0000000..8bd3e89
--- /dev/null
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -0,0 +1,42 @@
+#
+# BitBake Tests for the Fetcher (fetch2/)
+#
+# Copyright (C) 2012 Richard Purdie
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
+import bb
+
+class URLHandle(unittest.TestCase):
+
+    datatable = {
+       "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
+       "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
+       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'})
+    }
+
+    def test_decodeurl(self):
+        for k, v in self.datatable.items():
+            result = bb.fetch.decodeurl(k)
+            self.assertEqual(result, v)
+
+    def test_encodeurl(self):
+        for k, v in self.datatable.items():
+            result = bb.fetch.encodeurl(v)
+            self.assertEqual(result, k)
+
+
+
diff --git a/bitbake/lib/bb/tests/utils.py b/bitbake/lib/bb/tests/utils.py
new file mode 100644
index 0000000..04e8d5d
--- /dev/null
+++ b/bitbake/lib/bb/tests/utils.py
@@ -0,0 +1,36 @@
+#
+# BitBake Tests for utils.py
+#
+# Copyright (C) 2012 Richard Purdie
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
+import bb
+
+class VerCmpString(unittest.TestCase):
+
+    def test_vercmpstring(self):
+        result = bb.utils.vercmp_string('1', '2')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('2', '1')
+        self.assertTrue(result > 0)
+        result = bb.utils.vercmp_string('1', '1.0')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1', '1.1')
+        self.assertTrue(result < 0)
+        result = bb.utils.vercmp_string('1.1', '1_p2')
+        self.assertTrue(result < 0)
+




