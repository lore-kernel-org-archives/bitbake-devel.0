Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8957475D22
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Nov 2015 14:33:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 04 Nov 2015 06:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,243,1444719600"; d="scan'208";a="826861766"
Received: from hsvensso-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.75])
	by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2015 06:32:57 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Nov 2015 14:32:22 +0000
Message-Id: <1446647542-18959-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: tests: Re-write some cases to make them more maintainable
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
X-List-Received-Date: Wed, 04 Nov 2015 14:33:03 -0000

From: Ke Zou <ke.zou@windriver.com>

Signed-off-by: Ke Zou <ke.zou@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tts/toasteruitest/toaster_automation_test.py   | 312 ++++++---------------
 1 file changed, 89 insertions(+), 223 deletions(-)

diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index eac167b..8be9ce2 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -787,8 +787,6 @@ class toaster_cases(toaster_cases_base):
         self.driver.get(self.base_url)
         self.driver.find_element_by_partial_link_text("core-image").click()
         self.driver.find_element_by_link_text("Tasks").click()
-#        self.driver.find_element_by_link_text("All builds").click()
-#        self.driver.back()
         self.table_name = 'otable'
         # This is how we find the "default" rows-number!
         rows_displayed = int(Select(self.driver.find_element_by_css_selector("select.pagesize")).first_selected_option.text)
@@ -821,14 +819,14 @@ class toaster_cases(toaster_cases_base):
                            'Outcome':'outcome', 'Cache attempt':'cache_attempt', 'Time (secs)':'time_taken', 'CPU usage':'cpu_used', \
                            'Disk I/O (ms)':'disk_io'}
         for key in table_head_dict:
-# This is tricky here: we are doing so because there may be more than 1
-# same-name link_text in one page. So we only find element inside the table
+        # This is tricky here: we are doing so because there may be more than 1
+        # same-name link_text in one page. So we only find element inside the table
             self.find_element_by_link_text_in_table(self.table_name, key).click()
             column_list = self.get_table_column_text("class", table_head_dict[key])
-# after 1st click, the list should be either sequenced or inverted, but we don't have a "default order" here
-# the point is, after another click, it should be another order
-# the first case is special:this means every item in column_list is the same, so
-# after one click, either sequenced or inverted will be fine
+        # after 1st click, the list should be either sequenced or inverted, but we don't have a "default order" here
+        # the point is, after another click, it should be another order
+        # the first case is special:this means every item in column_list is the same, so
+        # after one click, either sequenced or inverted will be fine
             if (is_list_inverted(column_list) and is_list_sequenced(column_list)) \
                 or (not column_list) :
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
@@ -844,7 +842,7 @@ class toaster_cases(toaster_cases_base):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
                 self.assertTrue(is_list_inverted(column_list), msg=("%s column not inverted" % key))
-# step 8-10
+        # step 8-10
         # filter dict: {link text name : filter table name in xpath}
         filter_dict = {'Executed':'filter_executed', 'Outcome':'filter_outcome', 'Cache attempt':'filter_cache_attempt'}
         for key in filter_dict:
@@ -868,7 +866,7 @@ class toaster_cases(toaster_cases_base):
                      temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
                      avail_options = self.driver.find_elements_by_xpath("//*[@id='" + filter_dict[key] + "']//*[@name='filter'][not(@disabled)]")
                      self.browser_delay()
-# step 11
+        # step 11
         for item in ['order', 'task_name', 'executed', 'outcome', 'recipe_name', 'recipe_version']:
             try:
                 self.find_element_by_xpath_in_table(self.table_name, "./tbody/tr[1]/*[@class='" + item + "']/a").click()
@@ -878,7 +876,7 @@ class toaster_cases(toaster_cases_base):
             # insert screen shot here
             self.save_screenshot(screenshot_type='selenium', append_name='step11')
             self.driver.back()
-# step 12-14
+        # step 12-14
         # about test_dict: please refer to testcase 904 requirement step 12-14
         test_dict = {
             'Time':{
@@ -926,14 +924,14 @@ class toaster_cases(toaster_cases_base):
         # find "bash" in first column (Packages)
         self.driver.find_element_by_xpath("//*[@id='otable']//td[1]//*[text()='bash']").click()
         # save sceen here to observe...
-# step 6
+        # step 6
         self.driver.find_element_by_partial_link_text("Generated files").click()
         head_list = self.get_table_head_text('otable')
         for item in ['File', 'Size']:
             self.assertTrue(item in head_list, msg=("%s not in head row" % item))
         c_list = self.get_table_column_text('class', 'path')
         self.assertTrue(is_list_sequenced(c_list), msg=("column not in order"))
-# step 7
+        # step 7
         self.driver.find_element_by_partial_link_text("Runtime dependencies").click()
         # save sceen here to observe...
         # note that here table name is not 'otable'
@@ -1049,7 +1047,7 @@ class toaster_cases(toaster_cases_base):
                 self.assertTrue(is_list_sequenced(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
             else:
-                self.assertTrue(is_list_sequenced(column_list))
+                self.assertTrue(is_list_sequenced(column_list),  msg=("list %s not sequenced" % key))
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
                 self.assertTrue(is_list_inverted(column_list))
@@ -1102,20 +1100,19 @@ class toaster_cases(toaster_cases_base):
         self.driver.get(self.base_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Recipes').click()
-# step 3-5
+        # step 3-5
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
         self.driver.find_element_by_id("search-button").click()
         # save screen here for observation
         self.save_screenshot(screenshot_type='selenium', append_name='step5')
-# step 6
+        # step 6
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         self.driver.find_element_by_id("search").clear()
         # we deliberately want "no result" here
         self.driver.find_element_by_id("search").send_keys("no such input")
         self.driver.find_element_by_id("search-button").click()
         self.find_element_by_text("Show all recipes").click()
-        self.driver.quit()
 
 
         ##############
@@ -1124,7 +1121,6 @@ class toaster_cases(toaster_cases_base):
     def test_912(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        self.driver = self.setup_browser(self)
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
@@ -1187,179 +1183,42 @@ class toaster_cases(toaster_cases_base):
     def test_914(self):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
-        image_type="core-image-minimal"
-        test_package1="busybox"
-        test_package2="gdbm"
-        test_package3="gettext-native"
-        driver = self.driver
-        driver.maximize_window()
-        driver.get(self.base_url)
-        driver.find_element_by_link_text(image_type).click()
-        driver.find_element_by_link_text("Recipes").click()
-        driver.find_element_by_link_text(test_package1).click()
-
-        self.table_name = 'information'
-
-        tasks_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[1]/table/tbody/tr/td[1]"))
-        tasks_column_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[1]/table/tbody/tr[1]/td"))
-        print tasks_row_count
-        print tasks_column_count
-
-        Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
-        print ("Tasks_column=", Tasks_column)
-
-        key_tasks=["do_fetch", "do_unpack",  "do_patch", "do_configure", "do_compile", "do_install", "do_package", "do_build"]
-        i = 0
-        while i < len(key_tasks):
-            if key_tasks[i] not in Tasks_column:
-                print ("Error! Missing key task: %s" % key_tasks[i])
-            else:
-                print ("%s is in tasks" % key_tasks[i])
-            i = i + 1
-
-        if Tasks_column.index(key_tasks[0]) != 0:
-            print ("Error! %s is not in the right position" % key_tasks[0])
-        else:
-            print ("%s is in right position" % key_tasks[0])
-
-        if Tasks_column[-1] != key_tasks[-1]:
-            print ("Error! %s is not in the right position" % key_tasks[-1])
-        else:
-            print ("%s is in right position" % key_tasks[-1])
-
-        driver.find_element_by_partial_link_text("Packages (").click()
-        packages_name = driver.find_element_by_partial_link_text("Packages (").text
-        print packages_name
-        packages_num = string.atoi(filter(str.isdigit, repr(packages_name)))
-        print packages_num
-
-        packages_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[2]/table/tbody/tr/td[1]"))
-        print packages_row_count
-
-        if packages_num != packages_row_count:
-            print ("Error! The packages number is not correct")
-        else:
-            print ("The pakcages number is correct")
-
-        driver.find_element_by_partial_link_text("Build dependencies (").click()
-        depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
-        print depends_name
-        depends_num = string.atoi(filter(str.isdigit, repr(depends_name)))
-        print depends_num
-
-        if depends_num == 0:
-            depends_message = repr(driver.find_element_by_css_selector("div.alert.alert-info").text)
-            print depends_message
-            if depends_message.find("has no build dependencies.") < 0:
-                print ("Error! The message isn't expected.")
-            else:
-                print ("The message is expected")
-        else:
-            depends_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[3]/table/tbody/tr/td[1]"))
-            print depends_row_count
-            if depends_num != depends_row_count:
-                print ("Error! The dependent packages number is not correct")
-            else:
-                print ("The dependent packages number is correct")
-
-        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
-        rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
-        print rdepends_name
-        rdepends_num = string.atoi(filter(str.isdigit, repr(rdepends_name)))
-        print rdepends_num
-
-        if rdepends_num == 0:
-            rdepends_message = repr(driver.find_element_by_css_selector("#brought-in-by > div.alert.alert-info").text)
-            print rdepends_message
-            if rdepends_message.find("has no reverse build dependencies.") < 0:
-                print ("Error! The message isn't expected.")
-            else:
-                print ("The message is expected")
-        else:
-            print ("The reverse dependent packages number is correct")
-
-        driver.find_element_by_link_text("Recipes").click()
-        driver.find_element_by_link_text(test_package2).click()
-        driver.find_element_by_partial_link_text("Packages (").click()
-        driver.find_element_by_partial_link_text("Build dependencies (").click()
-        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
-
-
-        driver.find_element_by_link_text("Recipes").click()
-        driver.find_element_by_link_text(test_package3).click()
-
-        native_tasks_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[1]/table/tbody/tr/td[1]"))
-        native_tasks_column_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[1]/table/tbody/tr[1]/td"))
-        print native_tasks_row_count
-        print native_tasks_column_count
-
-        Native_Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
-        print ("Native_Tasks_column=", Native_Tasks_column)
-
-        native_key_tasks=["do_fetch", "do_unpack",  "do_patch", "do_configure", "do_compile", "do_install", "do_build"]
-        i = 0
-        while i < len(native_key_tasks):
-            if native_key_tasks[i] not in Native_Tasks_column:
-                print ("Error! Missing key task: %s" % native_key_tasks[i])
-            else:
-                print ("%s is in tasks" % native_key_tasks[i])
-            i = i + 1
-
-        if Native_Tasks_column.index(native_key_tasks[0]) != 0:
-            print ("Error! %s is not in the right position" % native_key_tasks[0])
-        else:
-            print ("%s is in right position" % native_key_tasks[0])
-
-        if Native_Tasks_column[-1] != native_key_tasks[-1]:
-            print ("Error! %s is not in the right position" % native_key_tasks[-1])
-        else:
-            print ("%s is in right position" % native_key_tasks[-1])
-
-        driver.find_element_by_partial_link_text("Packages (").click()
-        native_packages_name = driver.find_element_by_partial_link_text("Packages (").text
-        print native_packages_name
-        native_packages_num = string.atoi(filter(str.isdigit, repr(native_packages_name)))
-        print native_packages_num
-
-        if native_packages_num != 0:
-            print ("Error! Native task shouldn't have any packages.")
-        else:
-            native_package_message = repr(driver.find_element_by_css_selector("div.alert.alert-info").text)
-            print native_package_message
-            if native_package_message.find("does not build any packages.") < 0:
-                print ("Error! The message for native task isn't expected.")
-            else:
-                print ("The message for native task is expected.")
-
-        driver.find_element_by_partial_link_text("Build dependencies (").click()
-        native_depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
-        print native_depends_name
-        native_depends_num = string.atoi(filter(str.isdigit, repr(native_depends_name)))
-        print native_depends_num
-
-        native_depends_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[3]/table/tbody/tr/td[1]"))
-        print native_depends_row_count
-
-        if native_depends_num != native_depends_row_count:
-            print ("Error! The dependent packages number is not correct")
-        else:
-            print ("The dependent packages number is correct")
-
-        driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
-        native_rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
-        print native_rdepends_name
-        native_rdepends_num = string.atoi(filter(str.isdigit, repr(native_rdepends_name)))
-        print native_rdepends_num
-
-        native_rdepends_row_count = len(driver.find_elements_by_xpath("/html/body/div[2]/div/div[3]/div/div[4]/table/tbody/tr/td[1]"))
-        print native_rdepends_row_count
-
-        if native_rdepends_num != native_rdepends_row_count:
-            print ("Error! The reverse dependent packages number is not correct")
-        else:
-            print ("The reverse dependent packages number is correct")
-
-        driver.find_element_by_link_text("Recipes").click()
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.find_element_by_link_text_in_table('otable', "core-image-minimal").click()
+        self.find_element_by_link_text_in_table('nav', 'Recipes').click()
+        # step 4
+        self.find_element_by_link_text_in_table('otable', "busybox").click()
+        # this step needs some observation here
+        self.save_screenshot(screenshot_type='selenium', append_name='step4')
+        # step 5
+        self.driver.find_element_by_partial_link_text('Packages (').click()
+        head_list = self.get_table_head_text('otable')
+        head_checklist = ['Version', 'Size']
+        for item in head_checklist:
+            self.assertTrue(item in head_list, msg=("%s should be in head list" % item))
+        # step 6
+        self.driver.find_element_by_partial_link_text('Build dependencies (').click()
+        # the dependencies number may vary(even 0), so screenshot here
+        self.save_screenshot(screenshot_type='selenium', append_name='step6')
+        self.driver.find_element_by_partial_link_text('Reverse build dependencies (').click()
+        self.save_screenshot(screenshot_type='selenium', append_name='step7')
+        # step 8
+        self.find_element_by_link_text_in_table('breadcrumb', "Recipes").click()
+        # in case that gdbm doesn't appear on the first page, we use "search"
+        self.driver.find_element_by_id("search").clear()
+        self.driver.find_element_by_id("search").send_keys("gdbm")
+        self.driver.find_element_by_id("search-button").click()
+        self.driver.find_element_by_link_text("gdbm").click()
+        # step 9
+        self.driver.find_element_by_partial_link_text('Packages (').click()
+        # below are different from the contents described in testcase web
+        # page, so .. screenshot again
+        self.save_screenshot(screenshot_type='selenium', append_name='step9')
+        self.driver.find_element_by_partial_link_text('Build dependencies (').click()
+        self.save_screenshot(screenshot_type='selenium', append_name='step10')
+        self.driver.find_element_by_partial_link_text('Reverse build dependencies (').click()
+        self.save_screenshot(screenshot_type='selenium', append_name='step11')
 
 
         ##############
@@ -1371,24 +1230,24 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
-# step 3
+        # step 3
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         self.driver.find_element_by_link_text("BitBake variables").click()
-# step 4
+        # step 4
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
         self.driver.find_element_by_id("search-button").click()
         # save screen to see result
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step4')
-# step 5
+        # step 5
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         head_list = self.get_table_head_text('otable')
         print head_list
         print len(head_list)
         self.assertTrue(head_list == ['Variable', 'Value', 'Set in file', 'Description'], \
                         msg=("head row contents wrong"))
-# step 8
+        # step 8
         # search other string. and click "Variable" to re-sort, check if table
         # head is still the same
         self.driver.find_element_by_id("search").clear()
@@ -1413,17 +1272,17 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
-# step 2-3
+        # step 2-3
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         self.driver.find_element_by_link_text("BitBake variables").click()
         variable_list = self.get_table_column_text('class', 'variable_name')
         self.assertTrue(is_list_sequenced(variable_list), msg=("list not in order"))
-# step 4
+        # step 4
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
         variable_list = self.get_table_column_text('class', 'variable_name')
         self.assertTrue(is_list_inverted(variable_list), msg=("list not inverted"))
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
-# step 5
+        # step 5
         # searching won't change the sequentiality
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
@@ -1489,12 +1348,12 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         self.driver.find_element_by_link_text("core-image-minimal").click()
-# Step 2-3
+        # Step 2-3
         self.find_element_by_link_text_in_table('nav', 'Packages').click()
         check_head_list = ['Package', 'Package version', 'Size', 'Recipe']
         head_list = self.get_table_head_text('otable')
         self.assertTrue(head_list == check_head_list, msg=("head row not as expected"))
-# Step 4
+        # Step 4
         # pulldown menu
         option_ids = ['recipe__layer_version__layer__name', 'recipe__layer_version__branch', \
                       'recipe__layer_version__layer__commit', 'license', 'recipe__version']
@@ -1626,8 +1485,8 @@ class toaster_cases(toaster_cases_base):
         self.driver.back()
         self.driver.find_element_by_link_text("Configuration").click()
         otable_head_text = self.get_table_head_text()
-        for item in ["Layer", "Layer branch", "Layer commit"]:
-            self.assertTrue(item not in otable_head_text, msg=("item %s should not be in head row" % item))
+        self.assertTrue(self.is_text_present(["Layer", "Layer branch", "Layer commit"]), \
+                        msg=("text not in web page"))
 
 
         ##############
@@ -1637,29 +1496,36 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
         self.driver.maximize_window()
-        for items in ["Packages", "Recipes", "Tasks"]:
+        for item in ["Packages", "Recipes", "Tasks"]:
             self.driver.get(self.base_url)
-            self.driver.find_element_by_link_text("core-image-minimal").click()
-            self.driver.find_element_by_link_text(items).click()
-
-            # this may be page specific. If future page content changes, try to replace it with new xpath
-            xpath_showrows = "/html/body/div[2]/div/div[2]/div[2]/div[2]/div/div/div[2]/select"
-            xpath_table = "/html/body/div[2]/div/div[2]/div[2]/table/tbody"
-            self.driver.find_element_by_xpath(xpath_showrows).click()
-            rows_displayed = int(self.driver.find_element_by_xpath(xpath_showrows + "/option[2]").text)
-
-            # not sure if this is a Selenium Select bug: If page is not refreshed here, "select(by visible text)" operation will go back to 100-row page
-            # Sure we can use driver.get(url) to refresh page, but since page will vary, we use click link text here
-            self.driver.find_element_by_link_text(items).click()
-            Select(self.driver.find_element_by_css_selector("select.pagesize")).select_by_visible_text(str(rows_displayed))
-            self.assertTrue(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
-            self.assertFalse(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
-
+            self.find_element_by_link_text_in_table('otable', "core-image-minimal").click()
+            self.driver.find_element_by_link_text(item).click()
+            # step 3
+            options = Select(self.driver.find_element_by_css_selector("select.pagesize")).options
+            options_numbers = []
+            for option in options:
+                options_numbers.append(int(option.text))
+            # the default options are : 10  25  50  100  150
+            self.assertTrue(options_numbers==[10, 25, 50, 100, 150], msg=("%s options not as expected" % item))
+            # step 4
+            # in this case it's 50
+            option_tobeselected = options_numbers[2]
+            Select(self.driver.find_element_by_css_selector("select.pagesize")).select_by_index(2)
+            xpath_otable=".//*[@id='otable']/tbody"
+            # examine if the 50th row exists while 51th does not
+            self.assertTrue(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected) +"]"),\
+                            msg=("Row %d should exist" %option_tobeselected))
+            self.assertFalse(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected+1) +"]"),\
+                            msg=("Row %d should not exist" %(option_tobeselected+1)))
             # click 1st package, then go back to check if it's still those rows shown.
-            self.driver.find_element_by_xpath(xpath_table + "/tr[1]/td[1]").click()
-            self.driver.find_element_by_link_text(items).click()
-            self.assertTrue(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed) +"]"))
-            self.assertFalse(self.is_element_present(By.XPATH, xpath_table + "/tr[" + str(rows_displayed+1) +"]"))
+            self.driver.find_element_by_xpath(xpath_otable + "/tr[1]/td[1]/a").click()
+            time.sleep(3)
+            self.driver.find_element_by_link_text(item).click()
+            self.assertTrue(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected) +"]"),\
+                            msg=("Row %d should exist" %option_tobeselected))
+            self.assertFalse(self.is_element_present(By.XPATH, xpath_otable + "/tr[" + str(option_tobeselected+1) +"]"),\
+                            msg=("Row %d should not exist" %(option_tobeselected+1)))
+
 
 
         ##############
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


