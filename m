Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id E74477404E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 14:29:42 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 23 Sep 2015 07:29:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,577,1437462000"; d="scan'208";a="811243965"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.24.133])
	by fmsmga002.fm.intel.com with ESMTP; 23 Sep 2015 07:29:39 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:18:11 +0100
Message-Id: <1443017891-31669-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: UI test improvements
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
X-List-Received-Date: Wed, 23 Sep 2015 14:29:43 -0000

From: Ke Zou <ke.zou@windriver.com>

* Add decorator in logging mechanism
* Add more debug information

Signed-off-by: Ke Zou <ke.zou@windriver.com>
Signed-off-by: Stanciu Mihail <stanciux.mihail@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tts/toasteruitest/toaster_automation_test.py   | 270 +++++++++++++--------
 1 file changed, 167 insertions(+), 103 deletions(-)

diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index 2a2078f..acf8fc4 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -221,6 +221,68 @@ def extract_number_from_string(s):
     """
     return re.findall(r'([0-9]+)', s)
 
+# Below is decorator derived from toaster backend test code
+class NoParsingFilter(logging.Filter):
+    def filter(self, record):
+        return record.levelno == 100
+
+def LogResults(original_class):
+    orig_method = original_class.run
+
+    #rewrite the run method of unittest.TestCase to add testcase logging
+    def run(self, result, *args, **kws):
+        orig_method(self, result, *args, **kws)
+        passed = True
+        testMethod = getattr(self, self._testMethodName)
+
+        #if test case is decorated then use it's number, else use it's name
+        try:
+            test_case = testMethod.test_case
+        except AttributeError:
+            test_case = self._testMethodName
+
+        #create custom logging level for filtering.
+        custom_log_level = 100
+        logging.addLevelName(custom_log_level, 'RESULTS')
+        caller = os.path.basename(sys.argv[0])
+
+        def results(self, message, *args, **kws):
+            if self.isEnabledFor(custom_log_level):
+                self.log(custom_log_level, message, *args, **kws)
+        logging.Logger.results = results
+
+        logging.basicConfig(filename=os.path.join(os.getcwd(),'results-'+caller+'.log'),
+                            filemode='w',
+                            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
+                            datefmt='%H:%M:%S',
+                            level=custom_log_level)
+        for handler in logging.root.handlers:
+            handler.addFilter(NoParsingFilter())
+#        local_log = logging.getLogger(caller)
+        local_log = logging.getLogger()
+
+        #check status of tests and record it
+        for (name, msg) in result.errors:
+            if self._testMethodName == str(name).split(' ')[0]:
+                local_log.results("Testcase "+str(test_case)+": ERROR")
+                local_log.results("Testcase "+str(test_case)+":\n"+msg+"\n\n\n")
+                passed = False
+        for (name, msg) in result.failures:
+            if self._testMethodName == str(name).split(' ')[0]:
+                local_log.results("Testcase "+str(test_case)+": FAILED")
+                local_log.results("Testcase "+str(test_case)+":\n"+msg+"\n\n\n")
+                passed = False
+        for (name, msg) in result.skipped:
+            if self._testMethodName == str(name).split(' ')[0]:
+                local_log.results("Testcase "+str(test_case)+": SKIPPED"+"\n\n\n")
+                passed = False
+        if passed:
+            local_log.results("Testcase "+str(test_case)+": PASSED"+"\n\n\n")
+
+    original_class.run = run
+    return original_class
+
+
 
 
 ###########################################
@@ -531,6 +593,7 @@ class toaster_cases_base(unittest.TestCase):
     def is_text_present (self, patterns):
         for pattern in patterns:
             if str(pattern) not in self.driver.page_source:
+                print pattern
                 return False
         return True
 
@@ -592,7 +655,7 @@ class toaster_cases_base(unittest.TestCase):
 # Note: to comply with the unittest framework, we call these test_xxx functions
 # from run_toastercases.py to avoid calling setUp() and tearDown() multiple times
 
-
+@LogResults
 class toaster_cases(toaster_cases_base):
         ##############
         #  CASE 901  #
@@ -627,12 +690,12 @@ class toaster_cases(toaster_cases_base):
             if is_list_inverted(column_list):
                 self.driver.find_element_by_link_text(key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list), msg=("%s column not in order" % key))
             else:
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list), msg=("%s column not sequenced" % key))
                 self.driver.find_element_by_link_text(key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_inverted(column_list))
+                self.assertTrue(is_list_inverted(column_list), msg=("%s column not inverted" % key))
         self.log.info("case passed")
 
 
@@ -656,10 +719,10 @@ class toaster_cases(toaster_cases_base):
             # if nothing found, we still count it as "pass"
             if new_target_column_texts:
                 for text in new_target_column_texts:
-                    self.failUnless(text.find(pattern))
+                    self.assertTrue(text.find(pattern), msg=("%s item doesn't exist " % pattern))
             self.driver.find_element_by_css_selector("i.icon-remove").click()
             target_column_texts = self.get_table_column_text("class", "target")
-            self.failUnless(ori_target_column_texts == target_column_texts)
+            self.assertTrue(ori_target_column_texts == target_column_texts, msg=("builds changed after operations"))
 
 
         ##############
@@ -682,10 +745,9 @@ class toaster_cases(toaster_cases_base):
             try:
                 temp_element = self.find_element_by_text_in_table('otable', item)
                 # this is how we find "filter icon" in the same level as temp_element(where "a" means clickable, "i" means icon)
-                self.failUnless(temp_element.find_element_by_xpath("..//*/a/i[@class='icon-filter filtered']"))
+                self.assertTrue(temp_element.find_element_by_xpath("..//*/a/i[@class='icon-filter filtered']"))
             except Exception,e:
-                self.log.error(" %s cannot be found! %s" % (item, e))
-                self.failIf(True)
+                self.assertFalse(True, msg=(" %s cannot be found! %s" % (item, e)))
                 raise
         # step 5-6
         temp_element = self.find_element_by_link_text_in_table('otable', 'Outcome')
@@ -728,10 +790,12 @@ class toaster_cases(toaster_cases_base):
         # This is how we find the "default" rows-number!
         rows_displayed = int(Select(self.driver.find_element_by_css_selector("select.pagesize")).first_selected_option.text)
         print rows_displayed
-        self.failUnless(self.get_table_element(self.table_name, rows_displayed))
-        self.failIf(self.get_table_element(self.table_name, rows_displayed + 1))
+        self.assertTrue(self.get_table_element(self.table_name, rows_displayed), msg=("not enough rows displayed"))
+        self.assertFalse(self.get_table_element(self.table_name, rows_displayed + 1), \
+                         msg=("more rows displayed than expected"))
         # Search text box background text is "Search tasks"
-        self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search tasks']"))
+        self.assertTrue(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search tasks']"),\
+                        msg=("background text doesn't exist"))
 
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("busybox")
@@ -760,22 +824,23 @@ class toaster_cases(toaster_cases_base):
             column_list = self.get_table_column_text("class", table_head_dict[key])
 # after 1st click, the list should be either sequenced or inverted, but we don't have a "default order" here
 # the point is, after another click, it should be another order
-# the fist case is special:this means every item in column_list is the same, so
+# the first case is special:this means every item in column_list is the same, so
 # after one click, either sequenced or inverted will be fine
             if (is_list_inverted(column_list) and is_list_sequenced(column_list)) \
                 or (not column_list) :
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_list) or is_list_inverted(column_list))
+                self.assertTrue(is_list_sequenced(column_list) or is_list_inverted(column_list), \
+                                msg=("%s column not in any order" % key))
             elif is_list_inverted(column_list):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list), msg=("%s column not in order" % key))
             else:
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list), msg=("%s column not in order" % key))
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_inverted(column_list))
+                self.assertTrue(is_list_inverted(column_list), msg=("%s column not inverted" % key))
 # step 8-10
         # filter dict: {link text name : filter table name in xpath}
         filter_dict = {'Executed':'filter_executed', 'Outcome':'filter_outcome', 'Cache attempt':'filter_cache_attempt'}
@@ -834,9 +899,9 @@ class toaster_cases(toaster_cases_base):
             self.find_element_by_link_text_in_table('nav', key).click()
             head_list = self.get_table_head_text('otable')
             for item in test_dict[key]['check_head_list']:
-                self.failUnless(item in head_list)
+                self.assertTrue(item in head_list, msg=("%s not in head row" % item))
             column_list = self.get_table_column_text('class', test_dict[key]['class'])
-            self.failUnless(is_list_inverted(column_list))
+            self.assertTrue(is_list_inverted(column_list), msg=("%s column not inverted" % key))
 
             self.driver.find_element_by_id("edit-columns-button").click()
             for item2 in test_dict[key]['check_column_list']:
@@ -862,21 +927,24 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_partial_link_text("Generated files").click()
         head_list = self.get_table_head_text('otable')
         for item in ['File', 'Size']:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("%s not in head row" % item))
         c_list = self.get_table_column_text('class', 'path')
-        self.failUnless(is_list_sequenced(c_list))
+        self.assertTrue(is_list_sequenced(c_list), msg=("column not in order"))
 # step 7
         self.driver.find_element_by_partial_link_text("Runtime dependencies").click()
         # save sceen here to observe...
         # note that here table name is not 'otable'
         head_list = self.get_table_head_text('dependencies')
         for item in ['Package', 'Version', 'Size']:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("%s not in head row" % item))
         c_list = self.get_table_column_text_by_column_number('dependencies', 1)
-        self.failUnless(is_list_sequenced(c_list))
+        self.assertTrue(is_list_sequenced(c_list), msg=("list not in order"))
         texts = ['Size', 'License', 'Recipe', 'Recipe version', 'Layer', \
-                     'Layer branch', 'Layer commit', 'Layer directory']
-        self.failUnless(self.is_text_present(texts))
+                     'Layer branch', 'Layer commit']
+        time.sleep(1)
+#        for text in texts:
+#            self.assertTrue(self.is_text_present(text), msg=("text %s not in page" % text))
+        self.assertTrue(self.is_text_present(texts), msg=("text  not in page"))
 
 
         ##############
@@ -898,8 +966,8 @@ class toaster_cases(toaster_cases_base):
         # This is how we find the "default" rows-number!
         rows_displayed = int(Select(self.driver.find_element_by_css_selector("select.pagesize")).first_selected_option.text)
         print rows_displayed
-        self.failUnless(self.get_table_element(self.table_name, rows_displayed))
-        self.failIf(self.get_table_element(self.table_name, rows_displayed + 1))
+        self.assertTrue(self.get_table_element(self.table_name, rows_displayed))
+        self.assertFalse(self.get_table_element(self.table_name, rows_displayed + 1))
 
         # Check the default table is sorted by Recipe
         tasks_column_count = len(self.driver.find_elements_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr/td[1]"))
@@ -907,10 +975,10 @@ class toaster_cases(toaster_cases_base):
         default_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
         #print default_column_list
 
-        self.failUnless(is_list_sequenced(default_column_list))
+        self.assertTrue(is_list_sequenced(default_column_list))
 
         # Search text box background text is "Search recipes"
-        self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
+        self.assertTrue(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
 
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys(test_package1)
@@ -937,7 +1005,7 @@ class toaster_cases(toaster_cases_base):
 
         #self.driver.find_element_by_partial_link_text("zlib").click()
         #self.driver.back()
-        #self.failUnless(is_list_inverted(inverted_column_list))
+        #self.assertTrue(is_list_inverted(inverted_column_list))
         #self.find_element_by_link_text_in_table(self.table_name, 'Recipe').click()
 
         table_head_dict = {'Recipe':'recipe__name', 'Recipe file':'recipe_file', 'Section':'recipe_section', \
@@ -950,52 +1018,52 @@ class toaster_cases(toaster_cases_base):
                     or (not column_list) :
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_list) or is_list_inverted(column_list))
+                self.assertTrue(is_list_sequenced(column_list) or is_list_inverted(column_list))
                 self.driver.find_element_by_partial_link_text("acl").click()
                 self.driver.back()
-                self.failUnless(is_list_sequenced(column_list) or is_list_inverted(column_list))
+                self.assertTrue(is_list_sequenced(column_list) or is_list_inverted(column_list))
                 # Search text box background text is "Search recipes"
-                self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
+                self.assertTrue(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
                 self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_search_list) or is_list_inverted(column_search_list))
+                self.assertTrue(is_list_sequenced(column_search_list) or is_list_inverted(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
             elif is_list_inverted(column_list):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list))
                 self.driver.find_element_by_partial_link_text("acl").click()
                 self.driver.back()
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list))
                 # Search text box background text is "Search recipes"
-                self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
+                self.assertTrue(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
                 self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_sequenced(column_search_list))
+                self.assertTrue(is_list_sequenced(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
             else:
-                self.failUnless(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list))
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
-                self.failUnless(is_list_inverted(column_list))
+                self.assertTrue(is_list_inverted(column_list))
                 try:
                     self.driver.find_element_by_partial_link_text("acl").click()
                 except:
                     self.driver.find_element_by_partial_link_text("zlib").click()
                 self.driver.back()
-                self.failUnless(is_list_inverted(column_list))
+                self.assertTrue(is_list_inverted(column_list))
                 # Search text box background text is "Search recipes"
-                self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
+                self.assertTrue(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
                 self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
                 #print column_search_list
-                self.failUnless(is_list_inverted(column_search_list))
+                self.assertTrue(is_list_inverted(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
 
         # Bug 5919
@@ -1011,7 +1079,7 @@ class toaster_cases(toaster_cases_base):
             #print tasks_column_count
             default_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
             #print default_column_list
-            self.failUnless(is_list_sequenced(default_column_list))
+            self.assertTrue(is_list_sequenced(default_column_list))
 
         self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("recipe_file").click()
@@ -1061,31 +1129,31 @@ class toaster_cases(toaster_cases_base):
         # step 3
         head_list = self.get_table_head_text('otable')
         for item in ['Recipe', 'Recipe version', 'Recipe file', 'Section', 'License', 'Layer']:
-            self.failUnless(item in head_list)
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
         self.driver.find_element_by_id("depends_by").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # check if columns selected above is shown
-        check_list = ['Dependencies', 'Layer branch', 'Layer commit', 'Layer directory', 'Reverse dependencies']
+        check_list = ['Dependencies', 'Layer branch', 'Layer commit', 'Reverse dependencies']
         head_list = self.get_table_head_text('otable')
         time.sleep(2)
         print head_list
         for item in check_list:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
         # un-check 'em all
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
         self.driver.find_element_by_id("depends_by").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # don't exist any more
         head_list = self.get_table_head_text('otable')
         for item in check_list:
-            self.failIf(item in head_list)
+            self.assertFalse(item in head_list, msg=("item %s should not be in head row" % item))
 
 
         ##############
@@ -1101,7 +1169,7 @@ class toaster_cases(toaster_cases_base):
         # step 3
         head_list = self.get_table_head_text('otable')
         for item in ['Recipe', 'Recipe version', 'Recipe file', 'Section', 'License', 'Layer']:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
         # step 4
         self.driver.find_element_by_id("edit-columns-button").click()
         # save screen
@@ -1315,7 +1383,8 @@ class toaster_cases(toaster_cases_base):
         head_list = self.get_table_head_text('otable')
         print head_list
         print len(head_list)
-        self.failUnless(head_list == ['Variable', 'Value', 'Set in file', 'Description'])
+        self.assertTrue(head_list == ['Variable', 'Value', 'Set in file', 'Description'], \
+                        msg=("head row contents wrong"))
 # step 8
         # search other string. and click "Variable" to re-sort, check if table
         # head is still the same
@@ -1324,10 +1393,12 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("search-button").click()
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
         head_list = self.get_table_head_text('otable')
-        self.failUnless(head_list == ['Variable', 'Value', 'Set in file', 'Description'])
+        self.assertTrue(head_list == ['Variable', 'Value', 'Set in file', 'Description'], \
+                        msg=("head row contents wrong"))
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
         head_list = self.get_table_head_text('otable')
-        self.failUnless(head_list == ['Variable', 'Value', 'Set in file', 'Description'])
+        self.assertTrue(head_list == ['Variable', 'Value', 'Set in file', 'Description'], \
+                        msg=("head row contents wrong"))
 
 
         ##############
@@ -1343,11 +1414,11 @@ class toaster_cases(toaster_cases_base):
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         self.driver.find_element_by_link_text("BitBake variables").click()
         variable_list = self.get_table_column_text('class', 'variable_name')
-        self.failUnless(is_list_sequenced(variable_list))
+        self.assertTrue(is_list_sequenced(variable_list), msg=("list not in order"))
 # step 4
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
         variable_list = self.get_table_column_text('class', 'variable_name')
-        self.failUnless(is_list_inverted(variable_list))
+        self.assertTrue(is_list_inverted(variable_list), msg=("list not inverted"))
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
 # step 5
         # searching won't change the sequentiality
@@ -1355,7 +1426,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("search").send_keys("lib")
         self.driver.find_element_by_id("search-button").click()
         variable_list = self.get_table_column_text('class', 'variable_name')
-        self.failUnless(is_list_sequenced(variable_list))
+        self.assertTrue(is_list_sequenced(variable_list), msg=("list not in order"))
 
 
         ##############
@@ -1369,7 +1440,7 @@ class toaster_cases(toaster_cases_base):
         # Step 2
         # default sequence in "Completed on" column is inverted
         c_list = self.get_table_column_text('class', 'completed_on')
-        self.failUnless(is_list_inverted(c_list))
+        self.assertTrue(is_list_inverted(c_list), msg=("list not inverted"))
         # step 3
         self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("started_on").click()
@@ -1377,8 +1448,8 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("time").click()
         self.driver.find_element_by_id("edit-columns-button").click()
         head_list = self.get_table_head_text('otable')
-        for item in ['Outcome', 'Target', 'Machine', 'Started on', 'Completed on', 'Failed tasks', 'Errors', 'Warnings', 'Warnings', 'Time']:
-            self.failUnless(item in head_list)
+        for item in ['Outcome', 'Recipe', 'Machine', 'Started on', 'Completed on', 'Failed tasks', 'Errors', 'Warnings', 'Warnings', 'Time']:
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
 
 
         ##############
@@ -1392,7 +1463,7 @@ class toaster_cases(toaster_cases_base):
         # Please refer to case 924 requirement
         # default sequence in "Completed on" column is inverted
         c_list = self.get_table_column_text('class', 'completed_on')
-        self.failUnless(is_list_inverted(c_list))
+        self.assertTrue(is_list_inverted(c_list), msg=("list not inverted"))
         # Step 4
         # click Errors , order in "Completed on" should be disturbed. Then hide
         # error column to check if order in "Completed on" can be restored
@@ -1403,7 +1474,7 @@ class toaster_cases(toaster_cases_base):
         # Note: without time.sleep here, there'll be unpredictable error..TBD
         time.sleep(1)
         c_list = self.get_table_column_text('class', 'completed_on')
-        self.failUnless(is_list_inverted(c_list))
+        self.assertTrue(is_list_inverted(c_list), msg=("list not inverted"))
 
 
         ##############
@@ -1419,7 +1490,7 @@ class toaster_cases(toaster_cases_base):
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
         check_head_list = ['Package', 'Package version', 'Size', 'Recipe']
         head_list = self.get_table_head_text('otable')
-        self.failUnless(head_list == check_head_list)
+        self.assertTrue(head_list == check_head_list, msg=("head row not as expected"))
 # Step 4
         # pulldown menu
         option_ids = ['recipe__layer_version__layer__name', 'recipe__layer_version__branch', \
@@ -1448,7 +1519,7 @@ class toaster_cases(toaster_cases_base):
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
         # column -- Package
         column_list = self.get_table_column_text_by_column_number('otable', 1)
-        self.failUnless(is_list_sequenced(column_list))
+        self.assertTrue(is_list_sequenced(column_list), msg=("list not in order"))
         self.find_element_by_link_text_in_table('otable', 'Size').click()
 
 
@@ -1470,7 +1541,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("edit-columns-button").click()
         #get modified table header
         new_head = self.get_table_head_text('otable')
-        self.failUnless(head_list > new_head)
+        self.assertTrue(head_list > new_head)
 
         ##############
         #  CASE 943  #
@@ -1487,7 +1558,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("search").send_keys("bash")
         self.driver.find_element_by_id("search-button").click()
         #check for the search result message "XX packages found"
-        self.failUnless(self.is_text_present("packages found"))
+        self.assertTrue(self.is_text_present("packages found"), msg=("no packages found text"))
 
 
         ##############
@@ -1508,11 +1579,12 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("edit-columns-button").click()
         # otable is the recipes table here
         otable_head_text = self.get_table_head_text('otable')
-        for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
-            self.failIf(item not in otable_head_text)
+        for item in ["Layer", "Layer branch", "Layer commit"]:
+            self.assertFalse(item not in otable_head_text, msg=("item %s should be in head row" % item))
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Recipe file"]))
+        self.assertTrue(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Recipe file"]), \
+                        msg=("text not in web page"))
 
         # step 2: test Packages page stuff. almost same as above
         self.driver.back()
@@ -1525,10 +1597,11 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("edit-columns-button").click()
         otable_head_text = self.get_table_head_text("otable")
         for item in ["Layer", "Layer branch", "Layer commit"]:
-            self.failIf(item not in otable_head_text)
+            self.assertFalse(item not in otable_head_text, msg=("item %s should be in head row" % item))
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit"]))
+        self.assertTrue(self.is_text_present(["Layer", "Layer branch", "Layer commit"]), \
+                        msg=("text not in web page"))
 
         # step 3: test Packages core-image-minimal(images) stuff. almost same as above. Note when future element-id changes...
         self.driver.back()
@@ -1540,17 +1613,18 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("edit-columns-button").click()
         otable_head_text = self.get_table_head_text("otable")
         for item in ["Layer", "Layer branch", "Layer commit"]:
-            self.failIf(item not in otable_head_text)
+            self.assertFalse(item not in otable_head_text, msg=("item %s should be in head row" % item))
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit"]))
+        self.assertTrue(self.is_text_present(["Layer", "Layer branch", "Layer commit"]), \
+                        msg=("text not in web page"))
 
         # step 4: check Configuration page
         self.driver.back()
         self.driver.find_element_by_link_text("Configuration").click()
         otable_head_text = self.get_table_head_text()
         for item in ["Layer", "Layer branch", "Layer commit"]:
-            self.failIf(item not in otable_head_text)
+            self.assertTrue(item not in otable_head_text, msg=("item %s should not be in head row" % item))
 
 
         ##############
@@ -1575,14 +1649,14 @@ class toaster_cases(toaster_cases_base):
             # Sure we can use driver.get(url) to refresh page, but since page will vary, we use click link text here
             self.driver.find_element_by_link_text(items).click()
             Select(self.driver.find_element_by_css_selector("select.pagesize")).select_by_visible_text(str(rows_displayed))
-            self.failUnless(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
-            self.failIf(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
+            self.assertTrue(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
+            self.assertFalse(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
 
             # click 1st package, then go back to check if it's still those rows shown.
             self.driver.find_element_by_xpath(xpath_table + "/tr[1]/td[1]").click()
             self.driver.find_element_by_link_text(items).click()
-            self.failUnless(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
-            self.failIf(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
+            self.assertTrue(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
+            self.assertFalse(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
 
 
         ##############
@@ -1673,7 +1747,7 @@ class toaster_cases(toaster_cases_base):
         check_list = ['Description', 'Set in file']
         head_list = self.get_table_head_text('otable')
         for item in check_list:
-            self.failIf(item in head_list)
+            self.assertFalse(item in head_list, msg=("item %s should not be in head row" % item))
         # check these 2 options and verify again
         self.driver.find_element_by_id('edit-columns-button').click()
         self.driver.find_element_by_xpath(xpath_option('description')).click()
@@ -1681,7 +1755,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id('edit-columns-button').click()
         head_list = self.get_table_head_text('otable')
         for item in check_list:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
 
 
         ##############
@@ -1703,7 +1777,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("search-button").click()
         #get number of variables visible after search
         number_after_search = self.driver.find_element_by_class_name('page-header').text
-        self.failUnless(number_before_search > number_after_search)
+        self.assertTrue(number_before_search > number_after_search, msg=("items should be less after search"))
 
 
         ##############
@@ -1722,11 +1796,11 @@ class toaster_cases(toaster_cases_base):
             self.driver.find_element_by_partial_link_text("Directory structure")
         except Exception,e:
             self.log.error(e)
-            self.failIf(True)
+            self.assertFalse(True)
         # step 4
         head_list = self.get_table_head_text('otable')
         for item in ['Package', 'Package version', 'Size', 'Dependencies', 'Reverse dependencies', 'Recipe']:
-            self.failUnless(item in head_list)
+            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
         # step 5-6
         self.driver.find_element_by_id("edit-columns-button").click()
         selectable_class = 'checkbox'
@@ -1746,22 +1820,15 @@ class toaster_cases(toaster_cases_base):
             unselectable_list.append(element.text)
         # check them
         for item in selectable_check_list:
-            if item not in selectable_list:
-                self.log.error(" %s not found in dropdown menu \n" % item)
-                self.failIf(True)
+            self.assertTrue(item in selectable_list, msg=("%s not found in dropdown menu" % item))
         for item in unselectable_check_list:
-            if item not in unselectable_list:
-                self.log.error(" %s not found in dropdown menu \n" % item)
-                self.failIf(True)
+            self.assertTrue(item in unselectable_list, msg=("%s not found in dropdown menu" % item))
         self.driver.find_element_by_id("edit-columns-button").click()
         # step 7
         self.driver.find_element_by_partial_link_text("Directory structure").click()
         head_list = self.get_table_head_text('dirtable')
         for item in ['Directory / File', 'Symbolic link to', 'Source package', 'Size', 'Permissions', 'Owner', 'Group']:
-            if item not in head_list:
-                self.log.error(" %s not found in Directory structure table head \n" % item)
-                self.failIf(True)
-
+            self.assertTrue(item in head_list, msg=("%s not found in Directory structure table head" % item))
 
         ##############
         #  CASE 950  #
@@ -1791,12 +1858,11 @@ class toaster_cases(toaster_cases_base):
                 try:
                     self.find_element_by_link_text_in_table('nav', item)
                 except Exception:
-                    self.log.error("link  %s cannot be found in the page" % item)
-                    self.failIf(True)
+                    self.assertFalse(True, msg=("link  %s cannot be found in the page" % item))
             # step 6
             check_list_2 = ['Packages included', 'Total package size', \
                       'License manifest', 'Image files']
-            self.failUnless(self.is_text_present(check_list_2))
+            self.assertTrue(self.is_text_present(check_list_2), msg=("text not in web page"))
             self.driver.back()
         try:
             fail_icon = self.driver.find_element_by_xpath("//*[@class='icon-minus-sign error']")
@@ -1813,12 +1879,11 @@ class toaster_cases(toaster_cases_base):
                 try:
                     self.find_element_by_link_text_in_table('nav', item)
                 except Exception:
-                    self.log.error("link  %s cannot be found in the page" % item)
-                    self.failIf(True)
+                    self.assertFalse(True, msg=("link  %s cannot be found in the page" % item))
             # step 7 involved
             check_list_3 = ['Machine', 'Distro', 'Layers', 'Total number of tasks', 'Tasks executed', \
                       'Tasks not executed', 'Reuse', 'Recipes built', 'Packages built']
-            self.failUnless(self.is_text_present(check_list_3))
+            self.assertTrue(self.is_text_present(check_list_3), msg=("text not in web page"))
             self.driver.back()
 
 
@@ -1878,6 +1943,5 @@ class toaster_cases(toaster_cases_base):
                        tasks, recipes, packages need to run manually")
         self.driver.find_element_by_partial_link_text("Toaster manual").click()
         if not self.is_text_present("Toaster Manual"):
-            self.log.error("please check [Toaster manual] link on page")
-            self.failIf(True)
+            self.assertFalse(True, msg=("please check [Toaster manual] link on page"))
 
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


