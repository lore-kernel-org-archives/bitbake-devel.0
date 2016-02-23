Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 88F4F77281
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:48 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272740"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:48 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:53 -0600
Message-Id: <1456188718-13755-4-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 3/8] toaster/tests: Improve ui.py module.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove shebang because this module can't be executed.

Minor fix use os.path.lexists instead of os.path.exists when
test if symlink exists.

The toaster_cases_base class now inherit ToasterTestCase from
base.py it enables to use self.opts instead of hardcod'ed sqlite
db path, browser and toaster url.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/ui.py | 158 ++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 85 deletions(-)

diff --git a/lib/toaster/tests/ui.py b/lib/toaster/tests/ui.py
index d8f838a..cb11184 100644
--- a/lib/toaster/tests/ui.py
+++ b/lib/toaster/tests/ui.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python
 # Copyright
 
 # DESCRIPTION
@@ -32,6 +31,8 @@ from selenium.webdriver.common.keys import Keys
 from selenium.webdriver.support.ui import Select
 import sqlite3 as sqlite
 
+from toaster.tests.base import ToasterTestCase
+
 
 ###########################################
 #                                         #
@@ -287,7 +288,7 @@ def LogResults(original_class):
             local_log.results("Testcase "+str(test_case)+": PASSED")
 
         # Create symlink to the current log
-        if os.path.exists(linkfile):
+        if os.path.lexists(linkfile):
             os.remove(linkfile)
         os.symlink(logfile, linkfile)
 
@@ -303,7 +304,7 @@ def LogResults(original_class):
 ###########################################
 
 @LogResults
-class toaster_cases_base(unittest.TestCase):
+class toaster_cases_base(ToasterTestCase):
 
     @classmethod
     def setUpClass(cls):
@@ -313,18 +314,6 @@ class toaster_cases_base(unittest.TestCase):
         self.screenshot_sequence = 1
         self.verificationErrors = []
         self.accept_next_alert = True
-        self.host_os = platform.system().lower()
-        if os.getenv('TOASTER_SUITE'):
-            self.target_suite = os.getenv('TOASTER_SUITE')
-        else:
-            self.target_suite = self.host_os
-
-        self.parser = ConfigParser.SafeConfigParser()
-        self.parser.read('toaster_test.cfg')
-        self.base_url = eval(self.parser.get('toaster_test_' + self.target_suite, 'toaster_url'))
-
-        # create log dir . Currently , we put log files in log/tmp. After all
-        # test cases are done, move them to log/$datetime dir
         self.log_tmp_dir = os.path.abspath(sys.path[0]) + os.sep + 'log' + os.sep + 'tmp'
         try:
             mkdir_p(self.log_tmp_dir)
@@ -360,13 +349,12 @@ class toaster_cases_base(unittest.TestCase):
 
 
     def setup_browser(self, *browser_path):
-        self.browser = eval(self.parser.get('toaster_test_' + self.target_suite, 'test_browser'))
-        print self.browser
-        if self.browser == "firefox":
+        print self.opts.test_browser
+        if self.opts.test_browser == "firefox":
             driver = webdriver.Firefox()
-        elif self.browser == "chrome":
+        elif self.opts.test_browser == "chrome":
             driver = webdriver.Chrome()
-        elif self.browser == "ie":
+        elif self.opts.test_browser == "ie":
             driver = webdriver.Ie()
         else:
             driver = None
@@ -401,12 +389,12 @@ class toaster_cases_base(unittest.TestCase):
         for item in types:
             log_dir = self.log_tmp_dir + os.sep + sub_dir
             mkdir_p(log_dir)
-            log_path = log_dir + os.sep +  self.browser + '-' +\
+            log_path = log_dir + os.sep +  self.opts.test_browser + '-' +\
                     item + '-' + add_name + '-' + str(self.screenshot_sequence) + '.png'
             if item == 'native':
-                if self.host_os == "linux":
+                if self.opts.host_os == "linux":
                     os.system("scrot " + log_path)
-                elif self.host_os=="darwin":
+                elif self.opts.host_os=="darwin":
                     os.system("screencapture -x " + log_path)
             elif item == 'selenium':
                 self.driver.get_screenshot_as_file(log_path)
@@ -419,7 +407,7 @@ class toaster_cases_base(unittest.TestCase):
         But for firefox, mostly we don't need this.
         To be discussed
         """
-        if self.browser == "chrome":
+        if self.opts.test_browser == "chrome":
             time.sleep(1)
         return
 
@@ -691,7 +679,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # open all columns
         self.driver.find_element_by_id("edit-columns-button").click()
         # adding explicitly wait for chromedriver..-_-
@@ -731,7 +719,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # Could add more test patterns here in the future. Also, could search some items other than target column in future..
         patterns = ["minimal", "sato"]
         for pattern in patterns:
@@ -757,7 +745,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # when opening a new page, "started_on" is not displayed by default
         self.driver.find_element_by_id("edit-columns-button").click()
         # currently all the delay are for chrome driver -_-
@@ -806,7 +794,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_partial_link_text("core-image").click()
         self.driver.find_element_by_link_text("Tasks").click()
         self.table_name = 'otable'
@@ -947,7 +935,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
         # find "bash" in first column (Packages)
@@ -984,7 +972,7 @@ class toaster_cases(toaster_cases_base):
         test_package1="busybox"
         test_package2="lib"
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text(image_type).click()
         self.driver.find_element_by_link_text("Recipes").click()
         self.save_screenshot(screenshot_type='selenium', append_name='step3')
@@ -1123,7 +1111,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Recipes').click()
         # step 3-5
@@ -1150,7 +1138,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Recipes').click()
         # step 3
@@ -1190,7 +1178,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Recipes').click()
         # step 3
@@ -1217,7 +1205,7 @@ class toaster_cases(toaster_cases_base):
         test_package3="gettext-native"
         driver = self.driver
         driver.maximize_window()
-        driver.get(self.base_url)
+        driver.get(self.opts.toaster_url)
         driver.find_element_by_link_text(image_type).click()
         driver.find_element_by_link_text("Recipes").click()
         driver.find_element_by_link_text(test_package1).click()
@@ -1398,7 +1386,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         # step 3
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
@@ -1440,7 +1428,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         # step 2-3
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
@@ -1468,7 +1456,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # Step 2
         # default sequence in "Completed on" column is inverted
         c_list = self.get_table_column_text('class', 'completed_on')
@@ -1490,7 +1478,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # Please refer to case 924 requirement
         # default sequence in "Completed on" column is inverted
         c_list = self.get_table_column_text('class', 'completed_on')
@@ -1516,7 +1504,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         # Step 2-3
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
@@ -1545,7 +1533,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         # Step 2-3
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
@@ -1562,7 +1550,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.driver.find_element_by_link_text("Packages").click()
         #get initial table header
@@ -1582,7 +1570,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.driver.find_element_by_link_text("Packages").click()
         #search for the "bash" package -> this should definitely be present
@@ -1600,7 +1588,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         # step 1: test Recipes page stuff
         self.driver.find_element_by_link_text("Recipes").click()
@@ -1667,7 +1655,7 @@ class toaster_cases(toaster_cases_base):
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
         for item in ["Packages", "Recipes", "Tasks"]:
-            self.driver.get(self.base_url)
+            self.driver.get(self.opts.toaster_url)
             self.driver.find_element_by_link_text("core-image-minimal").click()
             self.driver.find_element_by_link_text(items).click()
 
@@ -1702,7 +1690,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.driver.find_element_by_link_text("Configuration").click()
         # step 3-4
@@ -1765,7 +1753,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         # step 2
@@ -1801,7 +1789,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         self.driver.find_element_by_link_text("BitBake variables").click()
@@ -1823,7 +1811,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'core-image-minimal').click()
         # step 3
@@ -1873,7 +1861,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # step3&4: so far we're not sure if there's "successful build" or "failed
         # build".If either of them doesn't exist, we can still go on other steps
         check_list = ['Configuration', 'Tasks', 'Recipes', 'Packages', 'Time', 'CPU usage', 'Disk I/O']
@@ -1930,7 +1918,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # currently test case itself isn't responsible for creating "1 successful and
         # 1 failed build"
         has_successful_build = 1
@@ -1957,7 +1945,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.log.info(" You should manually create all images before test starts!")
         # So far the case itself is not responsable for creating all sorts of images.
         # So assuming they are already there
@@ -1973,7 +1961,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         # step 2-3 need to run manually
         self.log.info("step 2-3: checking the help message when you hover on help icon of target,\
                        tasks, recipes, packages need to run manually")
@@ -1992,7 +1980,7 @@ class toaster_cases(toaster_cases_base):
     def test_1066(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select count(name) from orm_project a, auth_user b where a.user_id = b.id and b.username='_anonuser';"
         cursor.execute(query)
@@ -2006,7 +1994,7 @@ class toaster_cases(toaster_cases_base):
     def test_1071(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_release;"
         cursor.execute(query)
@@ -2015,7 +2003,7 @@ class toaster_cases(toaster_cases_base):
             data[i] = data[i][0]
         data.sort()
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data = []
         for i in range (0,4):
             json_data.append(json_parse['releases'][i]['name'])
@@ -2029,7 +2017,7 @@ class toaster_cases(toaster_cases_base):
     def test_1072(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select value from orm_toastersetting where name like 'DEFCONF%';"
         cursor.execute(query)
@@ -2037,7 +2025,7 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,6):
             data[i] = data[i][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data=json_parse['config']
         json_data = json_data.values()
         print json_data
@@ -2050,7 +2038,7 @@ class toaster_cases(toaster_cases_base):
     def test_1074(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_layersource;"
         cursor.execute(query)
@@ -2058,7 +2046,7 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,3):
             data[i] = data[i][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data = []
         for i in range(0,3):
             json_data.append(json_parse['layersources'][i]['name'])
@@ -2071,14 +2059,14 @@ class toaster_cases(toaster_cases_base):
     def test_1075(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select value from orm_toastersetting where name like 'DEFAULT_RELEASE';"
         cursor.execute(query)
         data = cursor.fetchall()
         data = data[0][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data = json_parse['defaultrelease']
         print json_data
         self.failUnless(set(data) == set(json_data))
@@ -2091,7 +2079,7 @@ class toaster_cases(toaster_cases_base):
         self.log.info(' CASE %s log: ' % str(self.case_no))
 
         print 'Checking branches for "Local Yocto Project"'
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=1;"
         cursor.execute(query)
@@ -2103,7 +2091,7 @@ class toaster_cases(toaster_cases_base):
         except:
             pass
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_location = json_parse['layersources'][0]['name']
         print json_location
         json_data = json_parse['layersources'][0]['branches']
@@ -2111,7 +2099,7 @@ class toaster_cases(toaster_cases_base):
         self.failUnless(set(data) == set(json_data))
 
         print 'Checking branches for "OpenEmbedded"'
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=3;"
         cursor.execute(query)
@@ -2120,7 +2108,7 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,lenght):
             data[i] = data[i][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_location = json_parse['layersources'][1]['name']
         print json_location
         json_data = json_parse['layersources'][1]['branches']
@@ -2128,7 +2116,7 @@ class toaster_cases(toaster_cases_base):
         self.failUnless(set(data) == set(json_data))
 
         print 'Checking branches for "Imported layers"'
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=2;"
         cursor.execute(query)
@@ -2137,7 +2125,7 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,lenght):
             data[i] = data[i][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_location = json_parse['layersources'][2]['name']
         print json_location
         json_data = json_parse['layersources'][2]['branches']
@@ -2151,7 +2139,7 @@ class toaster_cases(toaster_cases_base):
     def test_1077(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select name from orm_bitbakeversion;"
         cursor.execute(query)
@@ -2159,7 +2147,7 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,4):
             data[i] = data[i][0]
         print data
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data = []
         for i in range(0,4):
             json_data.append(json_parse['bitbake'][i]['name'])
@@ -2173,11 +2161,11 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_id("new-project-button").click()
         self.driver.find_element_by_id("new-project-name").send_keys("new-test-project")
         self.driver.find_element_by_id("create-project-button").click()
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select count(name) from orm_project where name = 'new-test-project';"
         cursor.execute(query)
@@ -2192,16 +2180,16 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_id("new-project-button").click()
         self.driver.find_element_by_id("new-project-name").send_keys("new-default-project")
         self.driver.find_element_by_id("create-project-button").click()
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select a.name from orm_release a, orm_project b where a.id = b.release_id and b.name = 'new-default-project' limit 1;"
         cursor.execute(query)
         db_data = str(cursor.fetchone()[0])
-        json_parse = json.loads(open('toasterconf.json').read())
+        json_parse = json.loads(open(self.opts.toaster_config).read())
         json_data = str(json_parse['defaultrelease'])
         self.failUnless(db_data == json_data)
 
@@ -2212,14 +2200,14 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
         self.driver.find_element_by_link_text('new-default-project').click()
         self.driver.find_element_by_id('project-change-form-toggle').click()
         self.driver.find_element_by_id('project-name-change-input').clear()
         self.driver.find_element_by_id('project-name-change-input').send_keys('new-name')
         self.driver.find_element_by_id('project-name-change-btn').click()
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select count(name) from orm_project where name = 'new-name';"
         cursor.execute(query)
@@ -2239,7 +2227,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
         self.driver.find_element_by_link_text('new-default-project').click()
         self.driver.find_element_by_id('change-machine-toggle').click()
@@ -2247,7 +2235,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id('machine-change-input').send_keys('qemuarm64')
 #        self.driver.find_element_by_id('machine-change-input').send_keys(Keys.RETURN)
         self.driver.find_element_by_id('machine-change-btn').click()
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select count(id) from orm_projectvariable where name like 'machine' and value like 'qemuarm64';"
         cursor.execute(query)
@@ -2266,7 +2254,7 @@ class toaster_cases(toaster_cases_base):
     def test_1090(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select username from auth_user where is_superuser = 1;"
         cursor.execute(query)
@@ -2285,7 +2273,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        self.driver.get(self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
         self.driver.find_element_by_link_text('new-default-project').click()
         self.driver.find_element_by_id('release-change-toggle').click()
@@ -2296,7 +2284,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id('change-release-btn').click()
         #wait for the changes to register in the DB
         time.sleep(1)
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select count(*) from orm_layer_version a, orm_projectlayer b, orm_project c where a.\"commit\"=\"HEAD\" and a.id = b.layercommit_id and b.project_id=c.id and c.name='new-default-project';"
         cursor.execute(query)
@@ -2319,7 +2307,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select a.name, a.value from orm_projectvariable a, orm_project b where a.project_id = b.id and b.name = 'new-default-project';"
         cursor.execute(query)
@@ -2336,7 +2324,7 @@ class toaster_cases(toaster_cases_base):
         self.log.info(' CASE %s log: ' % str(self.case_no))
 
         #get initial values
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
         cursor.execute(query)
@@ -2344,7 +2332,7 @@ class toaster_cases(toaster_cases_base):
         print data_initial
 
         self.driver.maximize_window()
-        self.driver.get('localhost:8000')#self.base_url)
+        self.driver.get(self.opts.toaster_url)
         self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
         self.driver.find_element_by_link_text('new-default-project').click()
         self.driver.find_element_by_id('release-change-toggle').click()
@@ -2357,7 +2345,7 @@ class toaster_cases(toaster_cases_base):
         time.sleep(1)
 
         #get changed values
-        con=sqlite.connect('toaster.sqlite')
+        con=sqlite.connect(self.opts.toaster_db)
         cursor = con.cursor()
         query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
         cursor.execute(query)
-- 
2.1.4


