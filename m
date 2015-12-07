Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 7099765D4A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Dec 2015 15:53:23 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP; 07 Dec 2015 07:53:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,395,1444719600"; 
   d="scan'208";a="8948937"
Received: from jamullin-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.16.98])
	by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2015 07:53:05 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Dec 2015 15:53:01 +0000
Message-Id: <afdb6c5a5d9041c476ab7aa5e88b052975cd6f94.1449503378.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <f7697e87ed7575741fc89926d924a6bdb1956920.1449503378.git.elliot.smith@intel.com>
References: <f7697e87ed7575741fc89926d924a6bdb1956920.1449503378.git.elliot.smith@intel.com>
In-Reply-To: <cover.1449503378.git.elliot.smith@intel.com>
References: <cover.1449503378.git.elliot.smith@intel.com>
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH 2/2] toaster: tests Update UI tests to work with 2.0 changes
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
X-List-Received-Date: Mon, 07 Dec 2015 15:53:23 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Update tests that were referencing items removed in 2.0.

Update most xpath elements left to use IDs.

Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tts/toasteruitest/toaster_automation_test.py   | 335 +++++++++++++++------
 1 file changed, 247 insertions(+), 88 deletions(-)

diff --git a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index 3d3ebd8..d975d48 100755
--- a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -597,7 +597,7 @@ class toaster_cases_base(unittest.TestCase):
     def is_text_present (self, patterns):
         for pattern in patterns:
             if str(pattern) not in self.driver.page_source:
-                print pattern
+                print 'Text "'+pattern+'" is missing'
                 return False
         return True
 
@@ -606,6 +606,7 @@ class toaster_cases_base(unittest.TestCase):
         try:
             self.driver.find_element(how, what)
         except NoSuchElementException, e:
+            print 'Could not find element '+str(what)+' by ' + str(how)
             return False
         return True
 
@@ -744,7 +745,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("started_on").click()
         self.driver.find_element_by_id("edit-columns-button").click()
         # step 4
-        items = ["Outcome", "Completed on", "Started on", "Failed tasks", "Errors", "Warnings"]
+        items = ["Outcome", "Completed on", "Started on"]
         for item in items:
             try:
                 temp_element = self.find_element_by_text_in_table('otable', item)
@@ -810,10 +811,9 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("cpu_used").click()
         self.driver.find_element_by_id("disk_io").click()
-        self.driver.find_element_by_id("task_log").click()
         self.driver.find_element_by_id("recipe_version").click()
         self.driver.find_element_by_id("time_taken").click()
-        self.driver.find_element_by_css_selector("edit-columns-button").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # The operation is the same as case901
         # dict: {lint text name : actual class name}
         table_head_dict = {'Order':'order', 'Recipe':'recipe_name', 'Task':'task_name', 'Executed':'executed', \
@@ -863,9 +863,17 @@ class toaster_cases(toaster_cases_base):
                 self.save_screenshot(screenshot_type='selenium', append_name='step8')
                 # after the last option was clicked, we don't need operation below anymore
                 if number < len(avail_options)-1:
-                     temp_element = self.find_element_by_link_text_in_table(self.table_name, key)
-                     temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
-                     avail_options = self.driver.find_elements_by_xpath("//*[@id='" + filter_dict[key] + "']//*[@name='filter'][not(@disabled)]")
+                     try:
+                        temp_element = self.find_element_by_link_text_in_table(self.table_name, key)
+                        temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
+                        avail_options = self.driver.find_elements_by_xpath("//*[@id='" + filter_dict[key] + "']//*[@name='filter'][not(@disabled)]")
+                     except:
+                        print "in exception"
+                        self.find_element_by_text("Show all tasks").click()
+#                        self.driver.find_element_by_xpath("//*[@id='searchform']/button[2]").click()
+                        temp_element = self.find_element_by_link_text_in_table(self.table_name, key)
+                        temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
+                        avail_options = self.driver.find_elements_by_xpath("//*[@id='" + filter_dict[key] + "']//*[@name='filter'][not(@disabled)]")
                      self.browser_delay()
         # step 11
         for item in ['order', 'task_name', 'executed', 'outcome', 'recipe_name', 'recipe_version']:
@@ -942,11 +950,8 @@ class toaster_cases(toaster_cases_base):
         c_list = self.get_table_column_text_by_column_number('dependencies', 1)
         self.assertTrue(is_list_sequenced(c_list), msg=("list not in order"))
         texts = ['Size', 'License', 'Recipe', 'Recipe version', 'Layer', \
-                     'Layer branch', 'Layer commit']
-        time.sleep(1)
-#        for text in texts:
-#            self.assertTrue(self.is_text_present(text), msg=("text %s not in page" % text))
-        self.assertTrue(self.is_text_present(texts), msg=("text  not in page"))
+                     'Layer commit']
+        self.failUnless(self.is_text_present(texts))
 
 
         ##############
@@ -1113,8 +1118,10 @@ class toaster_cases(toaster_cases_base):
         # we deliberately want "no result" here
         self.driver.find_element_by_id("search").send_keys("no such input")
         self.driver.find_element_by_id("search-button").click()
-        self.find_element_by_text("Show all recipes").click()
-
+        try:
+            self.find_element_by_text("Show all recipes").click()
+        except:
+            self.fail(msg='Could not identify blank page elements')
 
         ##############
         #  CASE 912  #
@@ -1184,42 +1191,184 @@ class toaster_cases(toaster_cases_base):
     def test_914(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        self.driver.maximize_window()
-        self.driver.get(self.base_url)
-        self.find_element_by_link_text_in_table('otable', "core-image-minimal").click()
-        self.find_element_by_link_text_in_table('nav', 'Recipes').click()
-        # step 4
-        self.find_element_by_link_text_in_table('otable', "busybox").click()
-        # this step needs some observation here
-        self.save_screenshot(screenshot_type='selenium', append_name='step4')
-        # step 5
-        self.driver.find_element_by_partial_link_text('Packages (').click()
-        head_list = self.get_table_head_text('otable')
-        head_checklist = ['Version', 'Size']
-        for item in head_checklist:
-            self.assertTrue(item in head_list, msg=("%s should be in head list" % item))
-        # step 6
-        self.driver.find_element_by_partial_link_text('Build dependencies (').click()
-        # the dependencies number may vary(even 0), so screenshot here
-        self.save_screenshot(screenshot_type='selenium', append_name='step6')
-        self.driver.find_element_by_partial_link_text('Reverse build dependencies (').click()
-        self.save_screenshot(screenshot_type='selenium', append_name='step7')
-        # step 8
-        self.find_element_by_link_text_in_table('breadcrumb', "Recipes").click()
-        # in case that gdbm doesn't appear on the first page, we use "search"
-        self.driver.find_element_by_id("search").clear()
-        self.driver.find_element_by_id("search").send_keys("gdbm")
-        self.driver.find_element_by_id("search-button").click()
-        self.driver.find_element_by_link_text("gdbm").click()
-        # step 9
-        self.driver.find_element_by_partial_link_text('Packages (').click()
-        # below are different from the contents described in testcase web
-        # page, so .. screenshot again
-        self.save_screenshot(screenshot_type='selenium', append_name='step9')
-        self.driver.find_element_by_partial_link_text('Build dependencies (').click()
-        self.save_screenshot(screenshot_type='selenium', append_name='step10')
-        self.driver.find_element_by_partial_link_text('Reverse build dependencies (').click()
-        self.save_screenshot(screenshot_type='selenium', append_name='step11')
+        image_type="core-image-minimal"
+        test_package1="busybox"
+        test_package2="gdbm"
+        test_package3="gettext-native"
+        driver = self.driver
+        driver.maximize_window()
+        driver.get(self.base_url)
+        driver.find_element_by_link_text(image_type).click()
+        driver.find_element_by_link_text("Recipes").click()
+        driver.find_element_by_link_text(test_package1).click()
+
+        self.table_name = 'information'
+
+        tasks_row_count = len(driver.find_elements_by_xpath("//*[@id='"+self.table_name+"']/table/tbody/tr/td[1]"))
+        tasks_column_count = len(driver.find_elements_by_xpath("//*[@id='"+self.table_name+"']/table/tbody/tr[1]/td"))
+        print 'rows: '+str(tasks_row_count)
+        print 'columns: '+str(tasks_column_count)
+
+        Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
+        print ("Tasks_column=", Tasks_column)
+
+        key_tasks=["do_fetch", "do_unpack",  "do_patch", "do_configure", "do_compile", "do_install", "do_package", "do_build"]
+        i = 0
+        while i < len(key_tasks):
+            if key_tasks[i] not in Tasks_column:
+                print ("Error! Missing key task: %s" % key_tasks[i])
+            else:
+                print ("%s is in tasks" % key_tasks[i])
+            i = i + 1
+
+        if Tasks_column.index(key_tasks[0]) != 0:
+            print ("Error! %s is not in the right position" % key_tasks[0])
+        else:
+            print ("%s is in right position" % key_tasks[0])
+
+        if Tasks_column[-1] != key_tasks[-1]:
+            print ("Error! %s is not in the right position" % key_tasks[-1])
+        else:
+            print ("%s is in right position" % key_tasks[-1])
+
+        driver.find_element_by_partial_link_text("Packages (").click()
+        packages_name = driver.find_element_by_partial_link_text("Packages (").text
+        print packages_name
+        packages_num = int(filter(str.isdigit, repr(packages_name)))
+        print packages_num
+
+        #switch the table to show more than 10 rows at a time
+        self.driver.find_element_by_xpath("//*[@id='packages-built']/div[1]/div/select").click()
+        Select(driver.find_element_by_xpath("//*[@id='packages-built']/div[1]/div/select")).select_by_value('150')
+        self.driver.find_element_by_xpath("//*[@id='packages-built']/div[1]/div/select").send_keys(Keys.ENTER)
+
+        packages_row_count = len(driver.find_elements_by_xpath("//*[@id='otable']/tbody/tr/td[1]"))
+        print packages_row_count
+
+        if packages_num != packages_row_count:
+            print ("Error! The packages number is not correct")
+        else:
+            print ("The packages number is correct")
+
+        driver.find_element_by_partial_link_text("Build dependencies (").click()
+        depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
+        print depends_name
+        depends_num = int(filter(str.isdigit, repr(depends_name)))
+        print depends_num
+
+        if depends_num == 0:
+            depends_message = repr(driver.find_element_by_css_selector("div.alert.alert-info").text)
+            print depends_message
+            if depends_message.find("has no build dependencies.") < 0:
+                print ("Error! The message isn't expected.")
+            else:
+                print ("The message is expected")
+        else:
+            depends_row_count = len(driver.find_elements_by_xpath("//*[@id='dependencies']/table/tbody/tr/td[1]"))
+            print depends_row_count
+            if depends_num != depends_row_count:
+                print ("Error! The dependent packages number is not correct")
+            else:
+                print ("The dependent packages number is correct")
+
+        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
+        rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
+        print rdepends_name
+        rdepends_num = int(filter(str.isdigit, repr(rdepends_name)))
+        print rdepends_num
+
+        if rdepends_num == 0:
+            rdepends_message = repr(driver.find_element_by_css_selector("#brought-in-by > div.alert.alert-info").text)
+            print rdepends_message
+            if rdepends_message.find("has no reverse build dependencies.") < 0:
+                print ("Error! The message isn't expected.")
+            else:
+                print ("The message is expected")
+        else:
+            print ("The reverse dependent packages number is correct")
+
+        driver.find_element_by_link_text("Recipes").click()
+        driver.find_element_by_link_text(test_package2).click()
+        driver.find_element_by_partial_link_text("Packages (").click()
+        driver.find_element_by_partial_link_text("Build dependencies (").click()
+        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
+
+
+        driver.find_element_by_link_text("Recipes").click()
+        driver.find_element_by_link_text(test_package3).click()
+
+        native_tasks_row_count = len(driver.find_elements_by_xpath("//*[@id='information']/table/tbody/tr/td[1]"))
+        native_tasks_column_count = len(driver.find_elements_by_xpath("//*[@id='information']/table/tbody/tr[1]/td"))
+        print native_tasks_row_count
+        print native_tasks_column_count
+
+        Native_Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
+        print ("Native_Tasks_column=", Native_Tasks_column)
+
+        native_key_tasks=["do_fetch", "do_unpack",  "do_patch", "do_configure", "do_compile", "do_install", "do_build"]
+        i = 0
+        while i < len(native_key_tasks):
+            if native_key_tasks[i] not in Native_Tasks_column:
+                print ("Error! Missing key task: %s" % native_key_tasks[i])
+            else:
+                print ("%s is in tasks" % native_key_tasks[i])
+            i = i + 1
+
+        if Native_Tasks_column.index(native_key_tasks[0]) != 0:
+            print ("Error! %s is not in the right position" % native_key_tasks[0])
+        else:
+            print ("%s is in right position" % native_key_tasks[0])
+
+        if Native_Tasks_column[-1] != native_key_tasks[-1]:
+            print ("Error! %s is not in the right position" % native_key_tasks[-1])
+        else:
+            print ("%s is in right position" % native_key_tasks[-1])
+
+        driver.find_element_by_partial_link_text("Packages (").click()
+        native_packages_name = driver.find_element_by_partial_link_text("Packages (").text
+        print native_packages_name
+        native_packages_num = int(filter(str.isdigit, repr(native_packages_name)))
+        print native_packages_num
+
+        if native_packages_num != 0:
+            print ("Error! Native task shouldn't have any packages.")
+        else:
+            native_package_message = repr(driver.find_element_by_css_selector("#packages-built > div.alert.alert-info").text)
+            print native_package_message
+            if native_package_message.find("does not build any packages.") < 0:
+                print ("Error! The message for native task isn't expected.")
+            else:
+                print ("The message for native task is expected.")
+
+        driver.find_element_by_partial_link_text("Build dependencies (").click()
+        native_depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
+        print native_depends_name
+        native_depends_num = int(filter(str.isdigit, repr(native_depends_name)))
+        print native_depends_num
+
+        native_depends_row_count = len(driver.find_elements_by_xpath("//*[@id='dependencies']/table/tbody/tr/td[1]"))
+        print native_depends_row_count
+
+        if native_depends_num != native_depends_row_count:
+            print ("Error! The dependent packages number is not correct")
+        else:
+            print ("The dependent packages number is correct")
+
+        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
+        native_rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
+        print native_rdepends_name
+        native_rdepends_num = int(filter(str.isdigit, repr(native_rdepends_name)))
+        print native_rdepends_num
+
+        native_rdepends_row_count = len(driver.find_elements_by_xpath("//*[@id='brought-in-by']/table/tbody/tr/td[1]"))
+        print native_rdepends_row_count
+
+        if native_rdepends_num != native_rdepends_row_count:
+            print ("Error! The reverse dependent packages number is not correct")
+        else:
+            print ("The reverse dependent packages number is correct")
+
+        driver.find_element_by_link_text("Recipes").click()
 
 
         ##############
@@ -1307,12 +1456,11 @@ class toaster_cases(toaster_cases_base):
         # step 3
         self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("started_on").click()
-        self.driver.find_element_by_id("log").click()
         self.driver.find_element_by_id("time").click()
         self.driver.find_element_by_id("edit-columns-button").click()
         head_list = self.get_table_head_text('otable')
-        for item in ['Outcome', 'Recipe', 'Machine', 'Started on', 'Completed on', 'Failed tasks', 'Errors', 'Warnings', 'Warnings', 'Time']:
-            self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
+        for item in ['Outcome', 'Recipe', 'Machine', 'Started on', 'Completed on', 'Failed tasks', 'Errors', 'Warnings', 'Time', "Image files", "Project"]:
+            self.failUnless(item in head_list, msg=item+' is missing from table head.')
 
 
         ##############
@@ -1330,10 +1478,11 @@ class toaster_cases(toaster_cases_base):
         # Step 4
         # click Errors , order in "Completed on" should be disturbed. Then hide
         # error column to check if order in "Completed on" can be restored
-        self.find_element_by_link_text_in_table('otable', 'Errors').click()
-        self.driver.find_element_by_id("edit-columns-button").click()
-        self.driver.find_element_by_id("errors_no").click()
-        self.driver.find_element_by_id("edit-columns-button").click()
+#THIS TEST IS NO LONGER VALID DUE TO DESIGN CHANGES. LEAVING IN PENDING UPDATES TO DESIGN
+        #self.find_element_by_link_text_in_table('otable', 'Errors').click()
+        #self.driver.find_element_by_id("edit-columns-button").click()
+        #self.driver.find_element_by_id("errors_no").click()
+        #self.driver.find_element_by_id("edit-columns-button").click()
         # Note: without time.sleep here, there'll be unpredictable error..TBD
         time.sleep(1)
         c_list = self.get_table_column_text('class', 'completed_on')
@@ -1443,7 +1592,7 @@ class toaster_cases(toaster_cases_base):
         # otable is the recipes table here
         otable_head_text = self.get_table_head_text('otable')
         for item in ["Layer", "Layer branch", "Layer commit"]:
-            self.assertFalse(item not in otable_head_text, msg=("item %s should be in head row" % item))
+            self.failIf(item not in otable_head_text, msg=item+' not in table head.')
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
         self.assertTrue(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Recipe file"]), \
@@ -1499,25 +1648,22 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         for item in ["Packages", "Recipes", "Tasks"]:
             self.driver.get(self.base_url)
-            self.find_element_by_link_text_in_table('otable', "core-image-minimal").click()
-            self.driver.find_element_by_link_text(item).click()
-            # step 3
-            options = Select(self.driver.find_element_by_css_selector("select.pagesize")).options
-            options_numbers = []
-            for option in options:
-                options_numbers.append(int(option.text))
-            # the default options are : 10  25  50  100  150
-            self.assertTrue(options_numbers==[10, 25, 50, 100, 150], msg=("%s options not as expected" % item))
-            # step 4
-            # in this case it's 50
-            option_tobeselected = options_numbers[2]
-            Select(self.driver.find_element_by_css_selector("select.pagesize")).select_by_index(2)
-            xpath_otable=".//*[@id='otable']/tbody"
-            # examine if the 50th row exists while 51th does not
-            self.assertTrue(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected) +"]"),\
-                            msg=("Row %d should exist" %option_tobeselected))
-            self.assertFalse(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected+1) +"]"),\
-                            msg=("Row %d should not exist" %(option_tobeselected+1)))
+            self.driver.find_element_by_link_text("core-image-minimal").click()
+            self.driver.find_element_by_link_text(items).click()
+
+            # this may be page specific. If future page content changes, try to replace it with new xpath
+            xpath_showrows = "/html/body/div[4]/div/div/div[2]/div[2]/div[2]/div/div/div[2]/select"
+            xpath_table = "html/body/div[4]/div/div/div[2]/div[2]/table/tbody"#"id=('otable')/tbody"
+            self.driver.find_element_by_xpath(xpath_showrows).click()
+            rows_displayed = int(self.driver.find_element_by_xpath(xpath_showrows + "/option[2]").text)
+
+            # not sure if this is a Selenium Select bug: If page is not refreshed here, "select(by visible text)" operation will go back to 100-row page
+            # Sure we can use driver.get(url) to refresh page, but since page will vary, we use click link text here
+            self.driver.find_element_by_link_text(items).click()
+            Select(self.driver.find_element_by_css_selector("select.pagesize")).select_by_visible_text(str(rows_displayed))
+            self.failUnless(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
+            self.failIf(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
+
             # click 1st package, then go back to check if it's still those rows shown.
             self.driver.find_element_by_xpath(xpath_otable + "/tr[1]/td[1]/a").click()
             time.sleep(3)
@@ -1811,9 +1957,10 @@ class toaster_cases(toaster_cases_base):
         # step 2-3 need to run manually
         self.log.info("step 2-3: checking the help message when you hover on help icon of target,\
                        tasks, recipes, packages need to run manually")
-        self.driver.find_element_by_partial_link_text("Toaster manual").click()
-        if not self.is_text_present("Toaster Manual"):
-            self.assertFalse(True, msg=("please check [Toaster manual] link on page"))
+        self.driver.find_element_by_partial_link_text("Manual").click()
+        if not self.is_text_present("Manual"):
+            self.log.error("please check [Toaster manual] link on page")
+            self.failIf(True)
 
 ####################################################################################################
 # Starting backend tests ###########################################################################
@@ -1929,10 +2076,16 @@ class toaster_cases(toaster_cases_base):
         query = "select name from orm_branch where layer_source_id=1;"
         cursor.execute(query)
         data = cursor.fetchall()
-        for i in range(0,4):
-            data[i] = data[i][0]
+        lenght = len(data)
+        try:
+            for i in range(0,lenght):
+                data[i] = data[i][0]
+        except:
+            pass
         print data
         json_parse = json.loads(open('toasterconf.json').read())
+        json_location = json_parse['layersources'][0]['name']
+        print json_location
         json_data = json_parse['layersources'][0]['branches']
         print json_data
         self.failUnless(set(data) == set(json_data))
@@ -1940,13 +2093,16 @@ class toaster_cases(toaster_cases_base):
         print 'Checking branches for "OpenEmbedded"'
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
-        query = "select name from orm_branch where layer_source_id=2;"
+        query = "select name from orm_branch where layer_source_id=3;"
         cursor.execute(query)
         data = cursor.fetchall()
-        for i in range(0,3):
+        lenght = len(data)
+        for i in range(0,lenght):
             data[i] = data[i][0]
         print data
         json_parse = json.loads(open('toasterconf.json').read())
+        json_location = json_parse['layersources'][1]['name']
+        print json_location
         json_data = json_parse['layersources'][1]['branches']
         print json_data
         self.failUnless(set(data) == set(json_data))
@@ -1954,13 +2110,16 @@ class toaster_cases(toaster_cases_base):
         print 'Checking branches for "Imported layers"'
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
-        query = "select name from orm_branch where layer_source_id=3;"
+        query = "select name from orm_branch where layer_source_id=2;"
         cursor.execute(query)
         data = cursor.fetchall()
-        for i in range(0,4):
+        lenght = len(data)
+        for i in range(0,lenght):
             data[i] = data[i][0]
         print data
         json_parse = json.loads(open('toasterconf.json').read())
+        json_location = json_parse['layersources'][2]['name']
+        print json_location
         json_data = json_parse['layersources'][2]['branches']
         print json_data
         self.failUnless(set(data) == set(json_data))
@@ -2066,7 +2225,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id('change-machine-toggle').click()
         self.driver.find_element_by_id('machine-change-input').clear()
         self.driver.find_element_by_id('machine-change-input').send_keys('qemuarm64')
-        self.driver.find_element_by_id('machine-change-input').send_keys(Keys.RETURN)
+#        self.driver.find_element_by_id('machine-change-input').send_keys(Keys.RETURN)
         self.driver.find_element_by_id('machine-change-btn').click()
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
@@ -2093,7 +2252,7 @@ class toaster_cases(toaster_cases_base):
         cursor.execute(query)
         data = cursor.fetchall()
         try:
-            data = data[0]
+            data = data[0][0]
         except:
             pass
         print data
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


