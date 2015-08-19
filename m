Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id D972C73E11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 13:29:35 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so120798125wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Aug 2015 06:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=jChp2Q/JEC6YPhdrbcFyOgqkGdbx8A6XkqFCBMj9ils=;
	b=iYN+GldidJJWKO7vjvUz0E44WkcEY7d7WDEfxr4xfmfP82saLSHwwaY9zQzHa3XAbh
	tudBrPA4PMp3ZiA/LBvbel+OqPHy5SFsIA0FUa3I9PkoKbPstAI3crFNKFx8JaCLi7Wh
	eiXDNa4D0fWKUSMQGa7IeDa3YN0+HYFUy3k/ToreVf5PUKZY0E2gNuub34TDO5MpUOTU
	gSYL23JfNLM/JQqAqYeP/q5PhOI4MIbOP67XwqNQwbX8lsHUmhCXhVh4ukspaUtAhbhV
	FLPTY6tu3ZTe1k+ZGua2inpeVXJ+CuHOnyzCW9YQBuj27nTn/7R5X3PueUv6o7HBtWWz
	qrVg==
X-Gm-Message-State: ALoCoQkhubTAY8JxqQdkKNtXBiJPl+zMwrsPlykmaTIc656cC8NEozGTdnvhKny7J6ScNuxBUt46
X-Received: by 10.180.80.70 with SMTP id p6mr3153843wix.43.1439990975547;
	Wed, 19 Aug 2015 06:29:35 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	du6sm26027669wib.24.2015.08.19.06.29.34
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 19 Aug 2015 06:29:34 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Aug 2015 14:29:24 +0100
Message-Id: <1439990964-6636-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH] toasteruitest: Updated UI tests cases to use dom IDs and 1.9 UI changes
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
X-List-Received-Date: Wed, 19 Aug 2015 13:29:37 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Updated existing tests to use dom IDs where necessary.
Updated tests to use 1.9 specific UI changes:
    - removed deprecated columns(log and layer directory)
    - changed expected names for table header("Recipe" instead of "Target")
Added tests for TC 942 and 943 which were missing
Removed test for TC 959 which was deprecated under 1.9

Signed-off-by: Mihail Stanciu <stanciux.mihail@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../tts/toasteruitest/toaster_automation_test.py   | 307 +++++++++------------
 1 file changed, 133 insertions(+), 174 deletions(-)

diff --git a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index 0cb3934..2a2078f 100755
--- a/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -605,18 +605,16 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         # open all columns
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # adding explicitly wait for chromedriver..-_-
         self.browser_delay()
-        self.driver.find_element_by_id("log").click()
-        self.browser_delay()
         self.driver.find_element_by_id("started_on").click()
         self.browser_delay()
         self.driver.find_element_by_id("time").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # dict: {lint text name : actual class name}
-        table_head_dict = {'Outcome':'outcome', 'Target':'target', 'Machine':'machine', 'Started on':'started_on', 'Completed on':'completed_on', \
-                'Errors':'errors_no', 'Warnings':'warnings_no', 'Time':'time', 'Log':'log'}
+        table_head_dict = {'Outcome':'outcome', 'Recipe':'target', 'Machine':'machine', 'Started on':'started_on', 'Completed on':'completed_on', \
+                'Errors':'errors_no', 'Warnings':'warnings_no', 'Time':'time'}
         for key in table_head_dict:
             try:
                 self.driver.find_element_by_link_text(key).click()
@@ -653,7 +651,7 @@ class toaster_cases(toaster_cases_base):
             print ori_target_column_texts
             self.driver.find_element_by_id("search").clear()
             self.driver.find_element_by_id("search").send_keys(pattern)
-            self.driver.find_element_by_css_selector("button.btn").click()
+            self.driver.find_element_by_id("search-button").click()
             new_target_column_texts = self.get_table_column_text("class", "target")
             # if nothing found, we still count it as "pass"
             if new_target_column_texts:
@@ -673,11 +671,11 @@ class toaster_cases(toaster_cases_base):
         self.driver.maximize_window()
         self.driver.get(self.base_url)
         # when opening a new page, "started_on" is not displayed by default
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # currently all the delay are for chrome driver -_-
         self.browser_delay()
         self.driver.find_element_by_id("started_on").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # step 4
         items = ["Outcome", "Completed on", "Started on", "Failed tasks", "Errors", "Warnings"]
         for item in items:
@@ -711,7 +709,7 @@ class toaster_cases(toaster_cases_base):
         self.save_screenshot(screenshot_type='selenium', append_name='step6')
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("core-image")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
 
 
         ##############
@@ -737,24 +735,24 @@ class toaster_cases(toaster_cases_base):
 
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("busybox")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step5')
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         # Save screen here
         self.save_screenshot(screenshot_type='selenium', append_name='step5_2')
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("cpu_used").click()
         self.driver.find_element_by_id("disk_io").click()
         self.driver.find_element_by_id("task_log").click()
         self.driver.find_element_by_id("recipe_version").click()
         self.driver.find_element_by_id("time_taken").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_css_selector("edit-columns-button").click()
         # The operation is the same as case901
         # dict: {lint text name : actual class name}
         table_head_dict = {'Order':'order', 'Recipe':'recipe_name', 'Task':'task_name', 'Executed':'executed', \
                            'Outcome':'outcome', 'Cache attempt':'cache_attempt', 'Time (secs)':'time_taken', 'CPU usage':'cpu_used', \
-                           'Disk I/O (ms)':'disk_io', 'Log':'task_log'}
+                           'Disk I/O (ms)':'disk_io'}
         for key in table_head_dict:
 # This is tricky here: we are doing so because there may be more than 1
 # same-name link_text in one page. So we only find element inside the table
@@ -818,17 +816,17 @@ class toaster_cases(toaster_cases_base):
             'Time':{
                 'class':'time_taken',
                 'check_head_list':['Recipe', 'Task', 'Executed', 'Outcome', 'Time (secs)'],
-                'check_column_list':['cpu_used', 'cache_attempt', 'disk_io', 'task_log', 'order', 'recipe_version']
+                'check_column_list':['cpu_used', 'cache_attempt', 'disk_io', 'order', 'recipe_version']
             },
             'CPU usage':{
                 'class':'cpu_used',
                 'check_head_list':['Recipe', 'Task', 'Executed', 'Outcome', 'CPU usage'],
-                'check_column_list':['cache_attempt', 'disk_io', 'task_log', 'order', 'recipe_version', 'time_taken']
+                'check_column_list':['cache_attempt', 'disk_io', 'order', 'recipe_version', 'time_taken']
             },
             'Disk I/O':{
                 'class':'disk_io',
                 'check_head_list':['Recipe', 'Task', 'Executed', 'Outcome', 'Disk I/O (ms)'],
-                'check_column_list':['cpu_used', 'cache_attempt', 'task_log', 'order', 'recipe_version', 'time_taken']
+                'check_column_list':['cpu_used', 'cache_attempt', 'order', 'recipe_version', 'time_taken']
             }
         }
         for key in test_dict:
@@ -840,10 +838,10 @@ class toaster_cases(toaster_cases_base):
             column_list = self.get_table_column_text('class', test_dict[key]['class'])
             self.failUnless(is_list_inverted(column_list))
 
-            self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+            self.driver.find_element_by_id("edit-columns-button").click()
             for item2 in test_dict[key]['check_column_list']:
                 self.driver.find_element_by_id(item2).click()
-            self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+            self.driver.find_element_by_id("edit-columns-button").click()
             # TBD: save screen here
 
 
@@ -916,36 +914,35 @@ class toaster_cases(toaster_cases_base):
 
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys(test_package1)
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         # Save screen here
         self.save_screenshot(screenshot_type='selenium', append_name='step4')
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         self.save_screenshot(screenshot_type='selenium', append_name='step4_2')
 
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
 
         self.find_element_by_link_text_in_table(self.table_name, 'Recipe').click()
         # Check the inverted table by Recipe
         # Recipe doesn't have class name
-        inverted_tasks_column_count = len(self.driver.find_elements_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr/td[1]"))
-        print inverted_tasks_column_count
-        inverted_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
+        #inverted_tasks_column_count = len(self.driver.find_elements_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr/td[1]"))
+        #print inverted_tasks_column_count
+        #inverted_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
         #print inverted_column_list
 
-        self.driver.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr[1]/td[1]/a").click()
-        self.driver.back()
-        self.failUnless(is_list_inverted(inverted_column_list))
-        self.find_element_by_link_text_in_table(self.table_name, 'Recipe').click()
+        #self.driver.find_element_by_partial_link_text("zlib").click()
+        #self.driver.back()
+        #self.failUnless(is_list_inverted(inverted_column_list))
+        #self.find_element_by_link_text_in_table(self.table_name, 'Recipe').click()
 
-        table_head_dict = {'Recipe file':'recipe_file', 'Section':'recipe_section', \
+        table_head_dict = {'Recipe':'recipe__name', 'Recipe file':'recipe_file', 'Section':'recipe_section', \
                 'License':'recipe_license', 'Layer':'layer_version__layer__name', \
-                'Layer branch':'layer_version__branch', 'Layer directory':'layer_version__local_path'}
+                'Layer branch':'layer_version__branch'}
         for key in table_head_dict:
             self.find_element_by_link_text_in_table(self.table_name, key).click()
             column_list = self.get_table_column_text("class", table_head_dict[key])
@@ -954,14 +951,14 @@ class toaster_cases(toaster_cases_base):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
                 self.failUnless(is_list_sequenced(column_list) or is_list_inverted(column_list))
-                self.driver.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr[1]/td[1]/a").click()
+                self.driver.find_element_by_partial_link_text("acl").click()
                 self.driver.back()
                 self.failUnless(is_list_sequenced(column_list) or is_list_inverted(column_list))
                 # Search text box background text is "Search recipes"
                 self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
-                self.driver.find_element_by_css_selector("button.btn").click()
+                self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
                 self.failUnless(is_list_sequenced(column_search_list) or is_list_inverted(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
@@ -969,14 +966,14 @@ class toaster_cases(toaster_cases_base):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
                 self.failUnless(is_list_sequenced(column_list))
-                self.driver.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr[1]/td[1]/a").click()
+                self.driver.find_element_by_partial_link_text("acl").click()
                 self.driver.back()
                 self.failUnless(is_list_sequenced(column_list))
                 # Search text box background text is "Search recipes"
                 self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
-                self.driver.find_element_by_css_selector("button.btn").click()
+                self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
                 self.failUnless(is_list_sequenced(column_search_list))
                 self.driver.find_element_by_css_selector("i.icon-remove").click()
@@ -985,14 +982,17 @@ class toaster_cases(toaster_cases_base):
                 self.find_element_by_link_text_in_table(self.table_name, key).click()
                 column_list = self.get_table_column_text("class", table_head_dict[key])
                 self.failUnless(is_list_inverted(column_list))
-                self.driver.find_element_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr[1]/td[1]/a").click()
+                try:
+                    self.driver.find_element_by_partial_link_text("acl").click()
+                except:
+                    self.driver.find_element_by_partial_link_text("zlib").click()
                 self.driver.back()
                 self.failUnless(is_list_inverted(column_list))
                 # Search text box background text is "Search recipes"
                 self.failUnless(self.driver.find_element_by_xpath("//*[@id='searchform']/*[@placeholder='Search recipes']"))
                 self.driver.find_element_by_id("search").clear()
                 self.driver.find_element_by_id("search").send_keys(test_package2)
-                self.driver.find_element_by_css_selector("button.btn").click()
+                self.driver.find_element_by_id("search-button").click()
                 column_search_list = self.get_table_column_text("class", table_head_dict[key])
                 #print column_search_list
                 self.failUnless(is_list_inverted(column_search_list))
@@ -1002,23 +1002,23 @@ class toaster_cases(toaster_cases_base):
         for key in table_head_dict:
             print key
             self.find_element_by_link_text_in_table(self.table_name, key).click()
-            self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+            self.driver.find_element_by_id("edit-columns-button").click()
             self.driver.find_element_by_id(table_head_dict[key]).click()
-            self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+            self.driver.find_element_by_id("edit-columns-button").click()
             self.browser_delay()
             # After hide the column, the default table should be sorted by Recipe
-            tasks_column_count = len(self.driver.find_elements_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr/td[1]"))
+            tasks_column_count = len(self.driver.find_elements_by_partial_link_text("acl"))
             #print tasks_column_count
             default_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
             #print default_column_list
             self.failUnless(is_list_sequenced(default_column_list))
 
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("recipe_file").click()
         self.driver.find_element_by_id("recipe_section").click()
         self.driver.find_element_by_id("recipe_license").click()
         self.driver.find_element_by_id("layer_version__layer__name").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
 
 
         ##############
@@ -1034,15 +1034,15 @@ class toaster_cases(toaster_cases_base):
 # step 3-5
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         # save screen here for observation
         self.save_screenshot(screenshot_type='selenium', append_name='step5')
 # step 6
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         self.driver.find_element_by_id("search").clear()
         # we deliberately want "no result" here
-        self.driver.find_element_by_id("search").send_keys("what the hell")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search").send_keys("no such input")
+        self.driver.find_element_by_id("search-button").click()
         self.find_element_by_text("Show all recipes").click()
         self.driver.quit()
 
@@ -1066,7 +1066,6 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         # check if columns selected above is shown
@@ -1081,7 +1080,6 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_id("depends_on").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__local_path").click()
         self.driver.find_element_by_id("depends_by").click()
         self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
         # don't exist any more
@@ -1105,11 +1103,11 @@ class toaster_cases(toaster_cases_base):
         for item in ['Recipe', 'Recipe version', 'Recipe file', 'Section', 'License', 'Layer']:
             self.failUnless(item in head_list)
         # step 4
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # save screen
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step4')
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
 
 
         ##############
@@ -1308,7 +1306,7 @@ class toaster_cases(toaster_cases_base):
 # step 4
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         # save screen to see result
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step4')
@@ -1323,7 +1321,7 @@ class toaster_cases(toaster_cases_base):
         # head is still the same
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("poky")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         self.find_element_by_link_text_in_table('otable', 'Variable').click()
         head_list = self.get_table_head_text('otable')
         self.failUnless(head_list == ['Variable', 'Value', 'Set in file', 'Description'])
@@ -1355,7 +1353,7 @@ class toaster_cases(toaster_cases_base):
         # searching won't change the sequentiality
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("lib")
-        self.driver.find_element_by_css_selector("button.btn").click()
+        self.driver.find_element_by_id("search-button").click()
         variable_list = self.get_table_column_text('class', 'variable_name')
         self.failUnless(is_list_sequenced(variable_list))
 
@@ -1373,11 +1371,11 @@ class toaster_cases(toaster_cases_base):
         c_list = self.get_table_column_text('class', 'completed_on')
         self.failUnless(is_list_inverted(c_list))
         # step 3
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("started_on").click()
         self.driver.find_element_by_id("log").click()
         self.driver.find_element_by_id("time").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         head_list = self.get_table_head_text('otable')
         for item in ['Outcome', 'Target', 'Machine', 'Started on', 'Completed on', 'Failed tasks', 'Errors', 'Warnings', 'Warnings', 'Time']:
             self.failUnless(item in head_list)
@@ -1399,9 +1397,9 @@ class toaster_cases(toaster_cases_base):
         # click Errors , order in "Completed on" should be disturbed. Then hide
         # error column to check if order in "Completed on" can be restored
         self.find_element_by_link_text_in_table('otable', 'Errors').click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("errors_no").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # Note: without time.sleep here, there'll be unpredictable error..TBD
         time.sleep(1)
         c_list = self.get_table_column_text('class', 'completed_on')
@@ -1425,13 +1423,12 @@ class toaster_cases(toaster_cases_base):
 # Step 4
         # pulldown menu
         option_ids = ['recipe__layer_version__layer__name', 'recipe__layer_version__branch', \
-                      'recipe__layer_version__layer__commit', 'recipe__layer_version__local_path', \
-                      'license', 'recipe__version']
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+                      'recipe__layer_version__layer__commit', 'license', 'recipe__version']
+        self.driver.find_element_by_id("edit-columns-button").click()
         for item in option_ids:
             if not self.driver.find_element_by_id(item).is_selected():
                 self.driver.find_element_by_id(item).click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # save screen here to observe that 'Package' and 'Package version' is
         # not selectable
         self.browser_delay()
@@ -1456,6 +1453,44 @@ class toaster_cases(toaster_cases_base):
 
 
         ##############
+        #  CASE 942  #
+        ##############
+    def test_942(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_link_text("core-image-minimal").click()
+        self.driver.find_element_by_link_text("Packages").click()
+        #get initial table header
+        head_list = self.get_table_head_text('otable')
+        #remove the Recipe column from table header
+        self.driver.find_element_by_id("edit-columns-button").click()
+        self.driver.find_element_by_id("recipe__name").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
+        #get modified table header
+        new_head = self.get_table_head_text('otable')
+        self.failUnless(head_list > new_head)
+
+        ##############
+        #  CASE 943  #
+        ##############
+    def test_943(self):
+        self.case_no = self.get_case_number()
+        self.log.info(' CASE %s log: ' % str(self.case_no))
+        self.driver.maximize_window()
+        self.driver.get(self.base_url)
+        self.driver.find_element_by_link_text("core-image-minimal").click()
+        self.driver.find_element_by_link_text("Packages").click()
+        #search for the "bash" package -> this should definitely be present
+        self.driver.find_element_by_id("search").clear()
+        self.driver.find_element_by_id("search").send_keys("bash")
+        self.driver.find_element_by_id("search-button").click()
+        #check for the search result message "XX packages found"
+        self.failUnless(self.is_text_present("packages found"))
+
+
+        ##############
         #  CASE 944  #
         ##############
     def test_944(self):
@@ -1467,57 +1502,54 @@ class toaster_cases(toaster_cases_base):
         # step 1: test Recipes page stuff
         self.driver.find_element_by_link_text("Recipes").click()
         # for these 3 items, default status is not-checked
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("layer_version__branch").click()
         self.driver.find_element_by_id("layer_version__layer__commit").click()
-        self.driver.find_element_by_id("layer_version__local_path").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # otable is the recipes table here
         otable_head_text = self.get_table_head_text('otable')
         for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
             self.failIf(item not in otable_head_text)
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Layer directory", "Recipe file"]))
+        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Recipe file"]))
 
         # step 2: test Packages page stuff. almost same as above
         self.driver.back()
         self.browser_delay()
         self.driver.find_element_by_link_text("Packages").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("recipe__layer_version__layer__name").click()
         self.driver.find_element_by_id("recipe__layer_version__branch").click()
         self.driver.find_element_by_id("recipe__layer_version__layer__commit").click()
-        self.driver.find_element_by_id("recipe__layer_version__local_path").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         otable_head_text = self.get_table_head_text("otable")
-        for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
+        for item in ["Layer", "Layer branch", "Layer commit"]:
             self.failIf(item not in otable_head_text)
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Layer directory"]))
+        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit"]))
 
         # step 3: test Packages core-image-minimal(images) stuff. almost same as above. Note when future element-id changes...
         self.driver.back()
         self.driver.find_element_by_link_text("core-image-minimal").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         self.driver.find_element_by_id("layer_name").click()
         self.driver.find_element_by_id("layer_branch").click()
         self.driver.find_element_by_id("layer_commit").click()
-        self.driver.find_element_by_id("layer_directory").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         otable_head_text = self.get_table_head_text("otable")
-        for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
+        for item in ["Layer", "Layer branch", "Layer commit"]:
             self.failIf(item not in otable_head_text)
         # click the fist recipe, whatever it is
         self.get_table_element("otable", 1, 1).click()
-        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit", "Layer directory"]))
+        self.failUnless(self.is_text_present(["Layer", "Layer branch", "Layer commit"]))
 
         # step 4: check Configuration page
         self.driver.back()
         self.driver.find_element_by_link_text("Configuration").click()
         otable_head_text = self.get_table_head_text()
-        for item in ["Layer", "Layer branch", "Layer commit", "Layer directory"]:
+        for item in ["Layer", "Layer branch", "Layer commit"]:
             self.failIf(item not in otable_head_text)
 
 
@@ -1568,7 +1600,7 @@ class toaster_cases(toaster_cases_base):
         for item in check_list:
             if not self.is_element_present(how=By.LINK_TEXT, what=item):
                 self.log.error("%s not found" %item)
-        if not self.is_text_present(['Layers', 'Layer', 'Layer branch', 'Layer commit', 'Layer directory']):
+        if not self.is_text_present(['Layers', 'Layer', 'Layer branch', 'Layer commit']):
             self.log.error("text not found")
         # step 5
         self.driver.find_element_by_link_text("BitBake variables").click()
@@ -1579,18 +1611,24 @@ class toaster_cases(toaster_cases_base):
         temp_element = self.find_element_by_text_in_table('otable', "Set in file")
         temp_element.find_element_by_xpath("..//*/a/i[@class='icon-filter filtered']").click()
         self.browser_delay()
-        self.driver.find_element_by_xpath("(//input[@name='filter'])[2]").click()
-        self.driver.find_element_by_css_selector("button.btn.btn-primary").click()
+        self.driver.find_element_by_xpath("(//input[@name='filter'])[3]").click()
+        btns = self.driver.find_elements_by_css_selector("button.btn.btn-primary")
+        for btn in btns:
+            try:
+                btn.click()
+                break
+            except:
+                pass
         # save screen here
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step6')
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # save screen here
         # step 7
         # we should manually check the step 6-8 result using screenshot
         self.browser_delay()
         self.save_screenshot(screenshot_type='selenium', append_name='step7')
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # step 9
         # click the 1st item, no matter what it is
         self.driver.find_element_by_xpath("//*[@id='otable']/tbody/tr[1]/td[1]/a").click()
@@ -1602,7 +1640,7 @@ class toaster_cases(toaster_cases_base):
             if item not in element.text:
                 self.log.error("%s not found" %item)
         # any better way to close this pop-up? ... TBD
-        element.find_element_by_xpath(".//*[@class='close']").click()
+        element.find_element_by_class_name("close").click()
         # step 10 : need to manually check "Yocto Manual" in saved screen
         self.driver.find_element_by_css_selector("i.icon-share.get-info").click()
         # save screen here
@@ -1627,20 +1665,20 @@ class toaster_cases(toaster_cases_base):
             # return xpath of options under "Edit columns" button
             return self.shortest_xpath('id', 'navTab') + self.shortest_xpath('id', 'editcol') \
                 + self.shortest_xpath('id', column_name)
-        self.find_element_by_xpath_in_table('navTab', self.shortest_xpath('class', 'btn dropdown-toggle')).click()
+        self.driver.find_element_by_id('edit-columns-button').click()
         # by default, option "Description" and "Set in file" were checked
         self.driver.find_element_by_xpath(xpath_option('description')).click()
         self.driver.find_element_by_xpath(xpath_option('file')).click()
-        self.find_element_by_xpath_in_table('navTab', self.shortest_xpath('class', 'btn dropdown-toggle')).click()
+        self.driver.find_element_by_id('edit-columns-button').click()
         check_list = ['Description', 'Set in file']
         head_list = self.get_table_head_text('otable')
         for item in check_list:
             self.failIf(item in head_list)
         # check these 2 options and verify again
-        self.find_element_by_xpath_in_table('navTab', self.shortest_xpath('class', 'btn dropdown-toggle')).click()
+        self.driver.find_element_by_id('edit-columns-button').click()
         self.driver.find_element_by_xpath(xpath_option('description')).click()
         self.driver.find_element_by_xpath(xpath_option('file')).click()
-        self.find_element_by_xpath_in_table('navTab', self.shortest_xpath('class', 'btn dropdown-toggle')).click()
+        self.driver.find_element_by_id('edit-columns-button').click()
         head_list = self.get_table_head_text('otable')
         for item in check_list:
             self.failUnless(item in head_list)
@@ -1657,66 +1695,15 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_link_text("core-image-minimal").click()
         self.find_element_by_link_text_in_table('nav', 'Configuration').click()
         self.driver.find_element_by_link_text("BitBake variables").click()
-        number_before_search = list()
-        number_after_search = list()
-        # step 3
-        # temp_dict -- filter string : filter name in firepath
-        temp_dict = {'Set in file':'filter_vhistory__file_name', 'Description':'filter_description'}
-        count = 0
-        for key in temp_dict:
-            try:
-                temp_element = self.find_element_by_text_in_table('otable', key)
-                temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
-                # delay here. otherwise it won't get correct "text" we need.
-                # TBD
-                time.sleep(1)
-                # step 4-5, we need to make sure that "search" manipulation
-                # does reduce the number in the filter.
-                # in this case, text returned will be "All variables (xxx)"
-                temp_text = self.driver.find_element_by_xpath("//*[@id='" + temp_dict[key] + "']//*[@class='radio']").text
-                number_list = extract_number_from_string(temp_text)
-                print number_list
-                # probably we only need the first number. in this case.
-                number_before_search.append(eval(number_list[0]))
-                count +=1
-                # how we locate the close button
-                self.driver.find_element_by_xpath("//*[@id='" + temp_dict[key] + "']//*[@class='close']").click()
-                self.browser_delay()
-            except Exception,e:
-                self.log.error(e)
-                raise
+        #get number of variables visible by default
+        number_before_search = self.driver.find_element_by_class_name('page-header').text
         # search for a while...
         self.driver.find_element_by_id("search").clear()
         self.driver.find_element_by_id("search").send_keys("BB")
-        self.driver.find_element_by_css_selector("button.btn").click()
-        # same operation as above, only to get the new numbers in the filter
-        count = 0
-        for key in temp_dict:
-            try:
-                temp_element = self.find_element_by_text_in_table('otable', key)
-                temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
-                time.sleep(1)
-                # in this case, text returned will be "All variables (xxx)"
-                temp_text = self.driver.find_element_by_xpath("//*[@id='" + temp_dict[key] + "']//*[@class='radio']").text
-                number_list = extract_number_from_string(temp_text)
-                # probably we only need the first number. in this case.
-                number_after_search.append(eval(number_list[0]))
-                count += 1
-                # how we locate the close button
-                self.driver.find_element_by_xpath("//*[@id='" + temp_dict[key] + "']//*[@class='close']").click()
-                self.browser_delay()
-            except Exception,e:
-                self.log.error(e)
-                raise
-        for i in range(0, count):
-            print i
-            print number_after_search[i]
-            print number_before_search[i]
-            if number_after_search[i] < number_before_search[i]:
-                self.log.info("After search, filter number reduces")
-            else:
-                self.log.error("Error: After search, filter number doesn't reduce")
-                self.failIf(True)
+        self.driver.find_element_by_id("search-button").click()
+        #get number of variables visible after search
+        number_after_search = self.driver.find_element_by_class_name('page-header').text
+        self.failUnless(number_before_search > number_after_search)
 
 
         ##############
@@ -1741,11 +1728,11 @@ class toaster_cases(toaster_cases_base):
         for item in ['Package', 'Package version', 'Size', 'Dependencies', 'Reverse dependencies', 'Recipe']:
             self.failUnless(item in head_list)
         # step 5-6
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         selectable_class = 'checkbox'
         # minimum-table : means unselectable items
         unselectable_class = 'checkbox muted'
-        selectable_check_list = ['Dependencies', 'Layer', 'Layer branch', 'Layer commit', 'Layer directory', \
+        selectable_check_list = ['Dependencies', 'Layer', 'Layer branch', 'Layer commit', \
                                  'License', 'Recipe', 'Recipe version', 'Reverse dependencies', \
                                  'Size', 'Size over total (%)']
         unselectable_check_list = ['Package', 'Package version']
@@ -1766,7 +1753,7 @@ class toaster_cases(toaster_cases_base):
             if item not in unselectable_list:
                 self.log.error(" %s not found in dropdown menu \n" % item)
                 self.failIf(True)
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
+        self.driver.find_element_by_id("edit-columns-button").click()
         # step 7
         self.driver.find_element_by_partial_link_text("Directory structure").click()
         head_list = self.get_table_head_text('dirtable')
@@ -1894,31 +1881,3 @@ class toaster_cases(toaster_cases_base):
             self.log.error("please check [Toaster manual] link on page")
             self.failIf(True)
 
-
-        ##############
-        #  CASE 959  #
-        ##############
-    def test_959(self):
-        self.case_no = self.get_case_number()
-        self.log.info(' CASE %s log: ' % str(self.case_no))
-        self.driver.maximize_window()
-        self.driver.get(self.base_url)
-        self.driver.find_element_by_link_text("core-image-minimal").click()
-        # step 2-3
-        self.find_element_by_link_text_in_table('nav', 'Tasks').click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
-        self.driver.find_element_by_id("task_log").click()
-        self.driver.find_element_by_css_selector("button.btn.dropdown-toggle").click()
-        # step 4: "Not Executed" tasks have no log. So click "Log"...
-        self.find_element_by_link_text_in_table('otable', 'Log').click()
-        # save screen to see if there's "absolute path" of logs
-        self.browser_delay()
-        self.save_screenshot(screenshot_type='selenium', append_name='step4_1')
-        self.find_element_by_link_text_in_table('otable', 'Log').click()
-        # save screen to see if there's "absolute path" of logs
-        self.browser_delay()
-        self.save_screenshot(screenshot_type='selenium', append_name='step4_2')
-
-
-
-
-- 
2.1.4


