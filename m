Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B6EFA764C8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jul 2015 09:25:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="738931639"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga001.jf.intel.com with ESMTP; 30 Jul 2015 09:25:44 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 508476A4005;
	Thu, 30 Jul 2015 09:24:58 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:18 +0300
Message-Id: <2674de4b9a97e359e2152571c98c888da889f83a.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
References: <89ab50af017d1c1d78b263b16ee50be955db2cb2.1438271912.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1438271912.git.ed.bartosh@linux.intel.com>
References: <cover.1438271912.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 10/11] toaster: tts: execute tests in numeric order
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:59 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

As the tests are verifying different type of the functionality,
it is usually the case that a failing early test will completely
make the subsequent tests failing, e.g. if the system cannot
start due to a bug, there is little point in testing other
functions.

In order to prevent uneeded test runs, and to generate repeatable
test patterns, the test cases have now a numeric order in the
class name (e.g. Test01XXX). The tests are executed in this order,
and the first test failing will stop the test run.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 lib/toaster/contrib/tts/runner.py | 11 +++++++----
 lib/toaster/contrib/tts/tests.py  |  6 +++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/contrib/tts/runner.py b/lib/toaster/contrib/tts/runner.py
index 6fc3e77..bed6651 100755
--- a/lib/toaster/contrib/tts/runner.py
+++ b/lib/toaster/contrib/tts/runner.py
@@ -31,7 +31,7 @@ from __future__ import print_function
 import sys, os
 import unittest, importlib
 import logging, pprint, json
-
+import re
 from shellutils import ShellCmdException, mkdirhier, run_shell_cmd
 
 import config
@@ -121,13 +121,16 @@ def execute_tests(dir_under_test, testname):
     # pylint: disable=broad-except
     # we disable the broad-except because we want to actually catch all possible exceptions
     try:
+        # sorting the tests by the numeric order in the class name
+        tests = sorted(tests, key=lambda x: int(re.search(r"[0-9]+", x[1]).group(0)))
         config.logger.debug("Discovered test clases: %s", pprint.pformat(tests))
         unittest.installHandler()
         suite = unittest.TestSuite()
         loader = unittest.TestLoader()
         result = unittest.TestResult()
-        for module_file, name in tests:
-            suite.addTest(loader.loadTestsFromName("%s.%s" % (module_file, name)))
+        result.failfast = True
+        for module_file, test_name in tests:
+            suite.addTest(loader.loadTestsFromName("%s.%s" % (module_file, test_name)))
         config.logger.info("Running %d test(s)", suite.countTestCases())
         suite.run(result)
 
@@ -202,7 +205,7 @@ def main():
         config.TESTDIR = testdir    # we let tests know where to run
 
         # ensure that the test dir only contains no *.pyc leftovers
-        run_shell_cmd("find '%s' -type f -name *.pyc -exec rm {} \;" % testdir)
+        run_shell_cmd("find '%s' -type f -name *.pyc -exec rm {} \\;" % testdir)
 
         no_failures = execute_tests(testdir, options.singletest)
 
diff --git a/lib/toaster/contrib/tts/tests.py b/lib/toaster/contrib/tts/tests.py
index 9acef46..3a4eed1 100644
--- a/lib/toaster/contrib/tts/tests.py
+++ b/lib/toaster/contrib/tts/tests.py
@@ -30,7 +30,7 @@ import config
 import pexpect
 import sys, os, signal, time
 
-class TestPyCompilable(unittest.TestCase):
+class Test00PyCompilable(unittest.TestCase):
     ''' Verifies that all Python files are syntactically correct '''
     def test_compile_file(self):
         try:
@@ -38,7 +38,7 @@ class TestPyCompilable(unittest.TestCase):
         except ShellCmdException as exc:
             self.fail("Error compiling python files: %s" % (exc))
 
-class TestPySystemStart(unittest.TestCase):
+class Test01PySystemStart(unittest.TestCase):
     ''' Attempts to start Toaster, verify that it is succesfull, and stop it '''
     def setUp(self):
         run_shell_cmd("bash -c 'rm -f build/*log'")
@@ -55,7 +55,7 @@ class TestPySystemStart(unittest.TestCase):
         except ShellCmdException as exc:
             self.fail("Failed starting managed mode: %s" % (exc))
 
-class TestHTML5Compliance(unittest.TestCase):
+class Test02HTML5Compliance(unittest.TestCase):
     def setUp(self):
         self.origdir = os.getcwd()
         self.crtdir = os.path.dirname(config.TESTDIR)
-- 
2.1.4


