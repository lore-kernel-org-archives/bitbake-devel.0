Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3F3BE7680A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jan 2016 16:03:46 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 25 Jan 2016 08:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,345,1449561600"; d="scan'208";a="900761334"
Received: from njaughne-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.29.109])
	by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2016 08:03:41 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jan 2016 16:03:21 +0000
Message-Id: <1453737801-16071-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Daniel Istrate <daniel.alexandrux.istrate@intel.com>
Subject: [PATCH] toaster: Update UI test runner
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
X-List-Received-Date: Mon, 25 Jan 2016 16:03:47 -0000

From: Daniel Istrate <daniel.alexandrux.istrate@intel.com>

Add new runner options:
    --run-all-tests: finds all tests, ignores config
    --run-suite <suite> (from cfg)

Without arguments, run tests from current os section (config), e.g.:
    1. ./run_toastertests
    2. ./run_toastertests --run-all-tests
    3. ./run_toastertests --run-suite darwin

Update toaster logging to meet QA CI requirements.

Signed-off-by: Daniel Istrate <daniel.alexandrux.istrate@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../contrib/tts/toasteruitest/run_toastertests.py  | 164 +++++++++++++++------
 .../tts/toasteruitest/toaster_automation_test.py   |  92 +++++++-----
 2 files changed, 172 insertions(+), 84 deletions(-)

diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
index 880487c..2b312cb 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
@@ -28,60 +28,128 @@
 # put chromedriver in PATH, (e.g. /usr/bin/, bear in mind to chmod)
 # For windows host, you may put chromedriver.exe in the same directory as chrome.exe
 
-
-import unittest, time, re, sys, getopt, os, logging, platform
+import unittest, sys, os, platform
 import ConfigParser
-import subprocess
-
-
-class toaster_run_all():
-    def __init__(self):
-        # in case this script is called from other directory
-        os.chdir(os.path.abspath(sys.path[0]))
-        self.starttime = time.strptime(time.ctime())
-        self.parser = ConfigParser.SafeConfigParser()
-        found = self.parser.read('toaster_test.cfg')
-        self.host_os = platform.system().lower()
-        self.run_all_cases()
-        self.collect_log()
-
-    def get_test_cases(self):
-        # we have config groups for different os type in toaster_test.cfg
-        cases_to_run = eval(self.parser.get('toaster_test_' + self.host_os, 'test_cases'))
-        return cases_to_run
-
-
-    def run_all_cases(self):
-        cases_temp = self.get_test_cases()
-        for case in cases_temp:
-            single_case_cmd = "python -m unittest toaster_automation_test.toaster_cases.test_" + str(case)
-            print single_case_cmd
-            subprocess.call(single_case_cmd, shell=True)
-
-    def collect_log(self):
+import argparse
+from toaster_automation_test import toaster_cases
+
+
+def get_args_parser():
+    description = "Script that runs toaster auto tests."
+    parser = argparse.ArgumentParser(description=description)
+    parser.add_argument('--run-all-tests', required=False, action="store_true", dest="run_all_tests", default=False,
+                       help='Run all tests.')
+    parser.add_argument('--run-suite', required=False, dest='run_suite', default=False,
+                       help='run suite (defined in cfg file)')
+
+    return parser
+
+
+def get_tests():
+    testslist = []
+
+    prefix = 'toaster_automation_test.toaster_cases'
+
+    for t in dir(toaster_cases):
+        if t.startswith('test_'):
+            testslist.append('.'.join((prefix, t)))
+
+    return testslist
+
+
+def get_tests_from_cfg(suite=None):
+
+    testslist = []
+    config = ConfigParser.SafeConfigParser()
+    config.read('toaster_test.cfg')
+
+    if suite is not None:
+        target_suite = suite.lower()
+
+        # TODO: if suite is valid suite
+
+    else:
+        target_suite = platform.system().lower()
+
+    try:
+        tests_from_cfg = eval(config.get('toaster_test_' + target_suite, 'test_cases'))
+    except:
+        print 'Failed to get test cases from cfg file. Make sure the format is correct.'
+        return None
+
+    prefix = 'toaster_automation_test.toaster_cases.test_'
+    for t in tests_from_cfg:
+        testslist.append(prefix + str(t))
+
+    return testslist
+
+def main():
+
+    # In case this script is called from other directory
+    os.chdir(os.path.abspath(sys.path[0]))
+
+    parser = get_args_parser()
+    args = parser.parse_args()
+
+    if args.run_all_tests:
+        testslist = get_tests()
+    elif args.run_suite:
+        testslist = get_tests_from_cfg(args.run_suite)
+        os.environ['TOASTER_SUITE'] = args.run_suite
+    else:
+        testslist = get_tests_from_cfg()
+
+    if not testslist:
+        print 'Failed to get test cases.'
+        exit(1)
+
+    suite = unittest.TestSuite()
+    loader = unittest.TestLoader()
+    loader.sortTestMethodsUsing = None
+    runner = unittest.TextTestRunner(verbosity=2, resultclass=buildResultClass(args))
+
+    for test in testslist:
+        try:
+            suite.addTests(loader.loadTestsFromName(test))
+        except:
+            return 1
+
+    result = runner.run(suite)
+
+    if result.wasSuccessful():
+        return 0
+    else:
+        return 1
+
+
+def buildResultClass(args):
+    """Build a Result Class to use in the testcase execution"""
+
+    class StampedResult(unittest.TextTestResult):
         """
-        the log files are temporarily stored in ./log/tmp/..
-        After all cases are done, they should be transfered to ./log/$TIMESTAMP/
+        Custom TestResult that prints the time when a test starts.  As toaster-auto
+        can take a long time (ie a few hours) to run, timestamps help us understand
+        what tests are taking a long time to execute.
         """
-        def comple(number):
-            if number < 10:
-                return str(0) + str(number)
-            else:
-                return str(number)
-        now = self.starttime
-        now_str = comple(now.tm_year) + comple(now.tm_mon) + comple(now.tm_mday) + \
-                  comple(now.tm_hour) + comple(now.tm_min) + comple(now.tm_sec)
-        log_dir = os.path.abspath(sys.path[0]) + os.sep + 'log' + os.sep + now_str
-        log_tmp_dir = os.path.abspath(sys.path[0]) + os.sep + 'log' + os.sep + 'tmp'
-        try:
-            os.renames(log_tmp_dir, log_dir)
-        except OSError :
-            logging.error(" Cannot create log dir(timestamp)  under log, please check your privilege")
+        def startTest(self, test):
+            import time
+            self.stream.write(time.strftime("%Y-%m-%d %H:%M:%S", time.localtime()) + " - ")
+            super(StampedResult, self).startTest(test)
 
+    return StampedResult
 
-if __name__ == "__main__":
-    toaster_run_all()
 
+if __name__ == "__main__":
 
+    try:
+        ret = main()
+    except:
+        ret = 1
+        import traceback
+        traceback.print_exc(5)
+    finally:
+        if os.getenv('TOASTER_SUITE'):
+            del os.environ['TOASTER_SUITE']
+    sys.exit(ret)
 
 
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index d975d48..d8f838a 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -230,60 +230,70 @@ class NoParsingFilter(logging.Filter):
 def LogResults(original_class):
     orig_method = original_class.run
 
+    from time import strftime, gmtime
+    caller = 'toaster'
+    timestamp = strftime('%Y%m%d%H%M%S',gmtime())
+    logfile = os.path.join(os.getcwd(),'results-'+caller+'.'+timestamp+'.log')
+    linkfile = os.path.join(os.getcwd(),'results-'+caller+'.log')
+
     #rewrite the run method of unittest.TestCase to add testcase logging
     def run(self, result, *args, **kws):
         orig_method(self, result, *args, **kws)
         passed = True
         testMethod = getattr(self, self._testMethodName)
-
         #if test case is decorated then use it's number, else use it's name
         try:
             test_case = testMethod.test_case
         except AttributeError:
             test_case = self._testMethodName
 
+        class_name = str(testMethod.im_class).split("'")[1]
+
         #create custom logging level for filtering.
         custom_log_level = 100
         logging.addLevelName(custom_log_level, 'RESULTS')
-        caller = os.path.basename(sys.argv[0])
 
         def results(self, message, *args, **kws):
             if self.isEnabledFor(custom_log_level):
                 self.log(custom_log_level, message, *args, **kws)
         logging.Logger.results = results
 
-        logging.basicConfig(filename=os.path.join(os.getcwd(),'results-'+caller+'.log'),
+        logging.basicConfig(filename=logfile,
                             filemode='w',
                             format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
                             datefmt='%H:%M:%S',
                             level=custom_log_level)
         for handler in logging.root.handlers:
             handler.addFilter(NoParsingFilter())
-#        local_log = logging.getLogger(caller)
-        local_log = logging.getLogger()
+        local_log = logging.getLogger(caller)
 
         #check status of tests and record it
+
         for (name, msg) in result.errors:
-            if self._testMethodName == str(name).split(' ')[0]:
+            if (self._testMethodName == str(name).split(' ')[0]) and (class_name in str(name).split(' ')[1]):
                 local_log.results("Testcase "+str(test_case)+": ERROR")
-                local_log.results("Testcase "+str(test_case)+":\n"+msg+"\n\n\n")
+                local_log.results("Testcase "+str(test_case)+":\n"+msg)
                 passed = False
         for (name, msg) in result.failures:
-            if self._testMethodName == str(name).split(' ')[0]:
+            if (self._testMethodName == str(name).split(' ')[0]) and (class_name in str(name).split(' ')[1]):
                 local_log.results("Testcase "+str(test_case)+": FAILED")
-                local_log.results("Testcase "+str(test_case)+":\n"+msg+"\n\n\n")
+                local_log.results("Testcase "+str(test_case)+":\n"+msg)
                 passed = False
         for (name, msg) in result.skipped:
-            if self._testMethodName == str(name).split(' ')[0]:
-                local_log.results("Testcase "+str(test_case)+": SKIPPED"+"\n\n\n")
+            if (self._testMethodName == str(name).split(' ')[0]) and (class_name in str(name).split(' ')[1]):
+                local_log.results("Testcase "+str(test_case)+": SKIPPED")
                 passed = False
         if passed:
-            local_log.results("Testcase "+str(test_case)+": PASSED"+"\n\n\n")
+            local_log.results("Testcase "+str(test_case)+": PASSED")
 
-    original_class.run = run
-    return original_class
+        # Create symlink to the current log
+        if os.path.exists(linkfile):
+            os.remove(linkfile)
+        os.symlink(logfile, linkfile)
 
+    original_class.run = run
 
+    return original_class
 
 
 ###########################################
@@ -292,16 +302,26 @@ def LogResults(original_class):
 #                                         #
 ###########################################
 
+@LogResults
 class toaster_cases_base(unittest.TestCase):
 
+    @classmethod
+    def setUpClass(cls):
+        cls.log = cls.logger_create()
+
     def setUp(self):
         self.screenshot_sequence = 1
         self.verificationErrors = []
         self.accept_next_alert = True
         self.host_os = platform.system().lower()
+        if os.getenv('TOASTER_SUITE'):
+            self.target_suite = os.getenv('TOASTER_SUITE')
+        else:
+            self.target_suite = self.host_os
+
         self.parser = ConfigParser.SafeConfigParser()
-        configs = self.parser.read('toaster_test.cfg')
-        self.base_url = eval(self.parser.get('toaster_test_' + self.host_os, 'toaster_url'))
+        self.parser.read('toaster_test.cfg')
+        self.base_url = eval(self.parser.get('toaster_test_' + self.target_suite, 'toaster_url'))
 
         # create log dir . Currently , we put log files in log/tmp. After all
         # test cases are done, move them to log/$datetime dir
@@ -310,37 +330,37 @@ class toaster_cases_base(unittest.TestCase):
             mkdir_p(self.log_tmp_dir)
         except OSError :
             logging.error("%(asctime)s Cannot create tmp dir under log, please check your privilege")
-        self.log = self.logger_create()
+        # self.log = self.logger_create()
         # driver setup
         self.setup_browser()
 
-    def logger_create(self):
-        """
-        we use root logger for every testcase.
-        The reason why we don't use TOASTERXXX_logger is to avoid setting respective level for
-        root logger and TOASTERXXX_logger
-        To Be Discussed
-        """
-        log_level_dict = {'CRITICAL':logging.CRITICAL, 'ERROR':logging.ERROR, 'WARNING':logging.WARNING, \
-                          'INFO':logging.INFO, 'DEBUG':logging.DEBUG, 'NOTSET':logging.NOTSET}
-        log = logging.getLogger()
-#        log = logging.getLogger('TOASTER_' + str(self.case_no))
-        self.logging_level = eval(self.parser.get('toaster_test_' + self.host_os, 'logging_level'))
-        key = self.logging_level.upper()
-        log.setLevel(log_level_dict[key])
-        fh = logging.FileHandler(filename=self.log_tmp_dir + os.sep + 'case_all' + '.log', mode='a')
+    @staticmethod
+    def logger_create():
+        log_file = "toaster-auto-" + time.strftime("%Y%m%d%H%M%S") + ".log"
+        if os.path.exists("toaster-auto.log"): os.remove("toaster-auto.log")
+        os.symlink(log_file, "toaster-auto.log")
+
+        log = logging.getLogger("toaster")
+        log.setLevel(logging.DEBUG)
+
+        fh = logging.FileHandler(filename=log_file, mode='w')
+        fh.setLevel(logging.DEBUG)
+
         ch = logging.StreamHandler(sys.stdout)
-        formatter = logging.Formatter('%(pathname)s - %(lineno)d - %(asctime)s \n  \
-             %(name)s - %(levelname)s - %(message)s')
+        ch.setLevel(logging.INFO)
+
+        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
         fh.setFormatter(formatter)
         ch.setFormatter(formatter)
+
         log.addHandler(fh)
         log.addHandler(ch)
+
         return log
 
 
     def setup_browser(self, *browser_path):
-        self.browser = eval(self.parser.get('toaster_test_' + self.host_os, 'test_browser'))
+        self.browser = eval(self.parser.get('toaster_test_' + self.target_suite, 'test_browser'))
         print self.browser
         if self.browser == "firefox":
             driver = webdriver.Firefox()
@@ -660,7 +680,7 @@ class toaster_cases_base(unittest.TestCase):
 # Note: to comply with the unittest framework, we call these test_xxx functions
 # from run_toastercases.py to avoid calling setUp() and tearDown() multiple times
 
-@LogResults
+
 class toaster_cases(toaster_cases_base):
         ##############
         #  CASE 901  #
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


