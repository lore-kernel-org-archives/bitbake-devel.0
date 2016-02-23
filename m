Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 01765771C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:50 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272772"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:51 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:56 -0600
Message-Id: <1456188718-13755-7-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 6/8] toaster-test: Refactor and imporvements.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:51 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add command line options for specify config, toaster_config,
database, toaster url instance, web browser and verbose/debug.
Some options (toaster url, test cases) are read from conf first
and then command line option could override it.

Options are passed to the unit tests that now uses ToasterTestCase
base class. Also the logger is initialized and passed to the test
cases.

The logic for discover tests was improved now it looks at a fixed
dictionary test_suites and could be extended easily.

The setup test case is executed first before another test cases
like the UI one. If setup test case fails another tests aren't
executed.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bin/toaster-test | 278 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 172 insertions(+), 106 deletions(-)

diff --git a/bin/toaster-test b/bin/toaster-test
index 2b312cb..b0c26dc 100755
--- a/bin/toaster-test
+++ b/bin/toaster-test
@@ -1,155 +1,221 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 
-# Copyright
+import sys
+import os
+import argparse
+import unittest
+import logging
 
-# DESCRIPTION
-# This is script for running all selected toaster cases on
-# selected web browsers manifested in toaster_test.cfg.
+import importlib
 
-# 1. How to start toaster in yocto:
-# $ source poky/oe-init-build-env
-# $ source toaster start
-# $ bitbake core-image-minimal
+bitbake_libdir = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib')
+sys.path.insert(0, bitbake_libdir)
 
-# 2. How to install selenium on Ubuntu:
-# $ sudo apt-get install scrot python-pip
-# $ sudo pip install selenium
+from toaster.tests.base import ToasterOptions
+from toaster.tests.setup import ToasterSetupTestCase
 
-# 3. How to install selenium addon in firefox:
-# Download the lastest firefox addon from http://release.seleniumhq.org/selenium-ide/
-# Then install it. You can also install firebug and firepath addon
+DEFAULT_TOASTER_TESTS_CFG = os.path.join(bitbake_libdir,  'toaster', 'tests',
+    'toaster_test.cfg')
+DEFAULT_TOASTER_CFG = os.path.join(os.environ['BUILDDIR'],  '..', 'meta-yocto',
+    'conf', 'toasterconf.json')
+DEFAULT_TOASTER_DB = os.path.join(os.environ['BUILDDIR'], 'toaster.sqlite')
 
-# 4. How to start writing a new case:
-# All you need to do is to implement the function test_xxx() and  pile it on.
+test_suites = {}
+test_suites['toaster.tests.ui'] = ['toaster_cases']
 
-# 5. How to test with Chrome browser
-# Download/install chrome on host
-# Download chromedriver from https://code.google.com/p/chromedriver/downloads/list  according to your host type
-# put chromedriver in PATH, (e.g. /usr/bin/, bear in mind to chmod)
-# For windows host, you may put chromedriver.exe in the same directory as chrome.exe
+logger = None
 
-import unittest, sys, os, platform
-import ConfigParser
-import argparse
-from toaster_automation_test import toaster_cases
+def load_test(test, args, logger):
+    """
+        Returns an instance of class passing arguments
+        to the class.
+    """
 
+    module_name = '.'.join(test.split('.')[:-2])
+    class_name = test.split('.')[-2]
+    test_name = test.split('.')[-1]
 
-def get_args_parser():
-    description = "Script that runs toaster auto tests."
-    parser = argparse.ArgumentParser(description=description)
-    parser.add_argument('--run-all-tests', required=False, action="store_true", dest="run_all_tests", default=False,
-                       help='Run all tests.')
-    parser.add_argument('--run-suite', required=False, dest='run_suite', default=False,
-                       help='run suite (defined in cfg file)')
+    module = importlib.import_module(module_name)
+    clss = getattr(module, class_name)
 
-    return parser
+    return clss(test_name, args, logger)
 
+def get_tests(tests_filter=None):
+    """
+        Iterate over available tests suites and serach
+        for tests that starts with test_.
+
+        If tests_filter is specified only add tests that
+        are in the test_filter list.
+    """
 
-def get_tests():
     testslist = []
+    tests_filter_dic = None
+
+    if tests_filter:
+        tests_filter_dic = dict((str(tf), False) for tf in tests_filter)
+
+    def _filter_tests(test, tests_filter_dic):
+        if not tests_filter_dic:
+            return True
+        if test in tests_filter_dic.keys():
+            tests_filter_dic[test] = True
+            return True
+        return False
+
+    for ts in test_suites.keys():
+        m = importlib.import_module(ts)
+        for clss in test_suites[ts]:
+            for o in dir(getattr(m, clss)):
+                full_clss = '.'.join((ts, clss))
+                if o.startswith('test_') and _filter_tests(o[5:], tests_filter_dic):
+                    testslist.append('.'.join((full_clss, o)))
 
-    prefix = 'toaster_automation_test.toaster_cases'
+    return testslist
 
-    for t in dir(toaster_cases):
-        if t.startswith('test_'):
-            testslist.append('.'.join((prefix, t)))
+def get_all_tests():
+    return get_tests()
 
-    return testslist
+def get_tests_from_cfg(config, suite):
+    try:
+        tests_from_cfg = eval(config.get('toaster_test_' + suite, 'test_cases'))
+    except:
+        logger.error('Failed to get test cases from config file.' \
+            'Make sure the format is correct.')
+        raise
 
+    testslist = get_tests(tests_from_cfg)
 
-def get_tests_from_cfg(suite=None):
+    return testslist
 
-    testslist = []
-    config = ConfigParser.SafeConfigParser()
-    config.read('toaster_test.cfg')
+def buildResultClass(args):
+    """Build a Result Class to use in the testcase execution"""
 
-    if suite is not None:
-        target_suite = suite.lower()
+    class StampedResult(unittest.TextTestResult):
+        """
+        Custom TestResult that prints the time when a test starts.  As toaster-auto
+        can take a long time (ie a few hours) to run, timestamps help us understand
+        what tests are taking a long time to execute.
+        """
+        def startTest(self, test):
+            import time
+            self.stream.write(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + " - ")
+            super(StampedResult, self).startTest(test)
 
-        # TODO: if suite is valid suite
+    return StampedResult
 
+def get_args():
+    parser = argparse.ArgumentParser(description="Script for run toaster tests.")
+
+    parser.add_argument('--run-all-tests', required=False, action="store_true",
+        dest="run_all_tests", default=False, help='Run all tests.')
+    parser.add_argument('--run-suite', required=False, dest='run_suite',
+        choices=['linux', 'windows', 'darwin'],
+        help='Run suite (defined in config file)')
+    parser.add_argument('--config', dest="config",
+        default=DEFAULT_TOASTER_TESTS_CFG,
+        help='Configuration for toaster tests, default: %s' %\
+            DEFAULT_TOASTER_TESTS_CFG)
+    parser.add_argument('--toaster-config', dest="toaster_config",
+        default=DEFAULT_TOASTER_CFG,
+        help='Configuration of toaster, default: %s' %\
+            DEFAULT_TOASTER_CFG)
+    parser.add_argument('--toaster-db', dest="toaster_db",
+        default=DEFAULT_TOASTER_DB,
+        help='Database of toaster, default: %s' %\
+            DEFAULT_TOASTER_DB)
+    parser.add_argument('--toaster-url', dest="toaster_url",
+        help='URL of toaster instance')
+    parser.add_argument('--test-browser', dest='test_browser',
+        choices=['firefox', 'chrome', 'ie'],
+        help='Web browser for use to run tests.')
+    parser.add_argument('--verbose', required=False, action="store_true",
+        dest="verbose", default=False, help='Enable verbose mode.')
+    parser.add_argument('--debug', required=False, action="store_true",
+        dest="debug", default=False, help='Enable debug mode.')
+
+    return parser.parse_args()
+
+def get_options(args):
+    opts = ToasterOptions()
+
+    opts.host_os = args.host_os
+    opts.config = args.config
+    opts.toaster_config = args.toaster_config
+    opts.toaster_db = args.toaster_db
+    opts.toaster_url = args.toaster_url
+    opts.test_browser = args.test_browser
+
+    opts.test_list = args.test_list
+
+    return opts
+
+def main(args):
+    import platform
+    import ConfigParser
+
+    if args.verbose or args.debug:
+        logging.basicConfig(stream=sys.stdout)
+        root = logging.getLogger()
+        root.setLevel(logging.DEBUG if args.debug else logging.INFO)
     else:
-        target_suite = platform.system().lower()
+        logging.basicConfig(stream=sys.stderr)
+    logger = logging.getLogger()
 
-    try:
-        tests_from_cfg = eval(config.get('toaster_test_' + target_suite, 'test_cases'))
-    except:
-        print 'Failed to get test cases from cfg file. Make sure the format is correct.'
-        return None
+    args.host_os = platform.system().lower()
+    if not args.run_suite:
+        args.run_suite = args.host_os
 
-    prefix = 'toaster_automation_test.toaster_cases.test_'
-    for t in tests_from_cfg:
-        testslist.append(prefix + str(t))
+    config = ConfigParser.SafeConfigParser()
+    config.read(args.config)
 
-    return testslist
+    if args.run_all_tests:
+        args.test_list = get_all_tests()
+    else:
+        args.test_list = get_tests_from_cfg(config, args.run_suite)
 
-def main():
+    if not args.toaster_url:
+        args.toaster_url = eval(config.get('toaster_test_' + args.run_suite,
+            'toaster_url'))
+    if not args.test_browser:
+        args.test_browser = eval(config.get('toaster_test_' + args.run_suite,
+            'test_browser'))
 
-    # In case this script is called from other directory
-    os.chdir(os.path.abspath(sys.path[0]))
+    if not args.test_list:
+        logger.error('Failed to get test cases.')
+        sys.exit(1)
 
-    parser = get_args_parser()
-    args = parser.parse_args()
+    opts = get_options(args)
 
-    if args.run_all_tests:
-        testslist = get_tests()
-    elif args.run_suite:
-        testslist = get_tests_from_cfg(args.run_suite)
-        os.environ['TOASTER_SUITE'] = args.run_suite
-    else:
-        testslist = get_tests_from_cfg()
+    runner = unittest.TextTestRunner(verbosity=2, resultclass=buildResultClass(args))
 
-    if not testslist:
-        print 'Failed to get test cases.'
-        exit(1)
+    setup_suite = unittest.TestSuite()
+    setup_suite.addTest(ToasterSetupTestCase('test_setupToaster', opts, logger))
 
     suite = unittest.TestSuite()
-    loader = unittest.TestLoader()
-    loader.sortTestMethodsUsing = None
-    runner = unittest.TextTestRunner(verbosity=2, resultclass=buildResultClass(args))
-
-    for test in testslist:
+    for test in args.test_list:
         try:
-            suite.addTests(loader.loadTestsFromName(test))
+            suite.addTest(load_test(test, opts, logger))
         except:
-            return 1
+            logger.error("Can't load test %s" % str(test))
+            raise
 
-    result = runner.run(suite)
+    result = runner.run(setup_suite)
+    if result.wasSuccessful():
+        result = runner.run(suite)
 
     if result.wasSuccessful():
         return 0
     else:
         return 1
 
-
-def buildResultClass(args):
-    """Build a Result Class to use in the testcase execution"""
-
-    class StampedResult(unittest.TextTestResult):
-        """
-        Custom TestResult that prints the time when a test starts.  As toaster-auto
-        can take a long time (ie a few hours) to run, timestamps help us understand
-        what tests are taking a long time to execute.
-        """
-        def startTest(self, test):
-            import time
-            self.stream.write(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + " - ")
-            super(StampedResult, self).startTest(test)
-
-    return StampedResult
-
-
 if __name__ == "__main__":
+    args = get_args()
 
     try:
-        ret = main()
+        ret = main(args)
     except:
-        ret = 1
         import traceback
-        traceback.print_exc(5)
-    finally:
-        if os.getenv('TOASTER_SUITE'):
-            del os.environ['TOASTER_SUITE']
+        ret = 1
+        traceback.print_exc()
     sys.exit(ret)
-
-
-- 
2.1.4


