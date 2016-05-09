Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E15A870031
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 13:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D5Cpt015682 for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:05:12 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id opSz5fJmZNax for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 14:05:12 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u49D59tr015679
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 May 2016 14:05:10 +0100
Message-ID: <1462799109.21831.132.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 May 2016 14:05:09 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] bin, toaster: Fix print and exception syntax
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
X-List-Received-Date: Mon, 09 May 2016 13:05:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This updates the print "" syntax to print() and fixes some exception
handling syntax such that its compatible with python v2 and v3.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 196f0b7..67c60db 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -95,7 +95,7 @@ def find_compare_task(bbhandler, pn, taskname):
         # Recurse into signature comparison
         output = bb.siggen.compare_sigfiles(latestfiles[0], latestfiles[1], recursecb)
         if output:
-            print '\n'.join(output)
+            print('\n'.join(output))
     sys.exit(0)
 
 
@@ -130,9 +130,9 @@ else:
         except IOError as e:
             logger.error(str(e))
             sys.exit(1)
-        except cPickle.UnpicklingError, EOFError:
+        except (pickle.UnpicklingError, EOFError):
             logger.error('Invalid signature data - ensure you are specifying sigdata/siginfo files')
             sys.exit(1)
 
         if output:
-            print '\n'.join(output)
+            print('\n'.join(output))
diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index 656d93a..ffaed1f 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -57,9 +57,9 @@ else:
     except IOError as e:
         logger.error(str(e))
         sys.exit(1)
-    except cPickle.UnpicklingError, EOFError:
+    except (pickle.UnpicklingError, EOFError):
         logger.error('Invalid signature data - ensure you are specifying a sigdata/siginfo file')
         sys.exit(1)
 
     if output:
-        print '\n'.join(output)
+        print('\n'.join(output))
diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
index 5e70437..6b1da1b 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -70,11 +70,11 @@ class Command(NoArgsCommand):
                     return True
 
                 if len(be.sourcedir) == 0:
-                    print "\n -- Validation: The layers checkout directory must be set."
+                    print("\n -- Validation: The layers checkout directory must be set.")
                     is_changed = _update_sourcedir()
 
                 if not be.sourcedir.startswith("/"):
-                    print "\n -- Validation: The layers checkout directory must be set to an absolute path."
+                    print("\n -- Validation: The layers checkout directory must be set to an absolute path.")
                     is_changed = _update_sourcedir()
 
                 if is_changed:
@@ -87,16 +87,16 @@ class Command(NoArgsCommand):
                     return True
 
                 if len(be.builddir) == 0:
-                    print "\n -- Validation: The build directory must be set."
+                    print("\n -- Validation: The build directory must be set.")
                     is_changed = _update_builddir()
 
                 if not be.builddir.startswith("/"):
-                    print "\n -- Validation: The build directory must to be set to an absolute path."
+                    print("\n -- Validation: The build directory must to be set to an absolute path.")
                     is_changed = _update_builddir()
 
 
                 if is_changed:
-                    print "\nBuild configuration saved"
+                    print("\nBuild configuration saved")
                     be.save()
                     return True
 
@@ -104,20 +104,20 @@ class Command(NoArgsCommand):
                 if be.needs_import:
                     try:
                         config_file = os.environ.get('TOASTER_CONF')
-                        print "\nImporting file: %s" % config_file
+                        print("\nImporting file: %s" % config_file)
                         from loadconf import Command as LoadConfigCommand
 
                         LoadConfigCommand()._import_layer_config(config_file)
                         # we run lsupdates after config update
-                        print "\nLayer configuration imported. Updating information from the layer sources, please wait.\nYou can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates"
+                        print("\nLayer configuration imported. Updating information from the layer sources, please wait.\nYou can re-update any time later by running bitbake/lib/toaster/manage.py lsupdates")
                         from django.core.management import call_command
                         call_command("lsupdates")
 
                         # we don't look for any other config files
                         return is_changed
                     except Exception as e:
-                        print "Failure while trying to import the toaster config file %s: %s" %\
-                            (config_file, e)
+                        print("Failure while trying to import the toaster config file %s: %s" %\
+                            (config_file, e))
                         traceback.print_exc(e)
 
                 return is_changed
diff --git a/bitbake/lib/toaster/bldcontrol/tests.py b/bitbake/lib/toaster/bldcontrol/tests.py
index f20cc7d..32985c3 100644
--- a/bitbake/lib/toaster/bldcontrol/tests.py
+++ b/bitbake/lib/toaster/bldcontrol/tests.py
@@ -53,7 +53,7 @@ class BEControllerTests(object):
             # setting layers, skip any layer info
             bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
         except NotImplementedError:
-            print "Test skipped due to command not implemented yet"
+            print("Test skipped due to command not implemented yet")
             return True
         # We are ok with the exception as we're handling the git already exists
         except BuildSetupException:
@@ -79,7 +79,7 @@ class BEControllerTests(object):
             # setting layers, skip any layer info
             layerSet = bc.setLayers(BITBAKE_LAYER, POKY_LAYERS)
         except NotImplementedError:
-            print "Test skipped due to command not implemented yet"
+            print("Test skipped due to command not implemented yet")
             return True
         # We are ok with the exception as we're handling the git already exists
         except BuildSetupException:
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
index 754636f..8ca45a8 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
@@ -74,7 +74,7 @@ def get_tests_from_cfg(suite=None):
     try:
         tests_from_cfg = eval(config.get('toaster_test_' + target_suite, 'test_cases'))
     except:
-        print 'Failed to get test cases from cfg file. Make sure the format is correct.'
+        print('Failed to get test cases from cfg file. Make sure the format is correct.')
         return None
 
     prefix = 'toaster_automation_test.toaster_cases.test_'
@@ -100,7 +100,7 @@ def main():
         testslist = get_tests_from_cfg()
 
     if not testslist:
-        print 'Failed to get test cases.'
+        print('Failed to get test cases.')
         exit(1)
 
     suite = unittest.TestSuite()
diff --git a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
index d8f838a..1a786fa 100755
--- a/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
+++ b/bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
@@ -61,7 +61,7 @@ def get_log_root_dir():
             break
 
     if number == (max_depth - 1):
-        print 'No log dir found. Please check'
+        print('No log dir found. Please check')
         raise Exception
 
     return log_root_dir
@@ -152,7 +152,7 @@ def is_list_sequenced(testlist):
         return (sorted(list_number) == list_number)
 
     else:
-        print 'Unrecognized list type, please check'
+        print('Unrecognized list type, please check')
         return False
 
 
@@ -201,7 +201,7 @@ def is_list_inverted(testlist):
         return (sorted(list_number, reverse = True) == list_number)
 
     else:
-        print 'Unrecognized list type, please check'
+        print('Unrecognized list type, please check')
         return False
 
 def replace_file_content(filename, item, option):
@@ -361,7 +361,7 @@ class toaster_cases_base(unittest.TestCase):
 
     def setup_browser(self, *browser_path):
         self.browser = eval(self.parser.get('toaster_test_' + self.target_suite, 'test_browser'))
-        print self.browser
+        print(self.browser)
         if self.browser == "firefox":
             driver = webdriver.Firefox()
         elif self.browser == "chrome":
@@ -370,7 +370,7 @@ class toaster_cases_base(unittest.TestCase):
             driver = webdriver.Ie()
         else:
             driver = None
-            print "unrecognized browser type, please check"
+            print("unrecognized browser type, please check")
         self.driver = driver
         self.driver.implicitly_wait(30)
         return self.driver
@@ -440,8 +440,8 @@ class toaster_cases_base(unittest.TestCase):
         try:
             table_element = self.get_table_element(table_id)
             element = table_element.find_element_by_xpath("//*[text()='" + text_string + "']")
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
         return element
 
@@ -454,8 +454,8 @@ class toaster_cases_base(unittest.TestCase):
         try:
             table_element = self.get_table_element(table_id)
             element = table_element.find_element_by_link_text(link_text)
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
         return element
 
@@ -467,8 +467,8 @@ class toaster_cases_base(unittest.TestCase):
         try:
             table_element = self.get_table_element(table_id)
             element_list = table_element.find_elements_by_link_text(link_text)
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
         return element_list
 
@@ -481,8 +481,8 @@ class toaster_cases_base(unittest.TestCase):
             table_element = self.get_table_element(table_id)
             element = table_element.find_element_by_partial_link_text(link_text)
             return element
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
 
 
@@ -494,8 +494,8 @@ class toaster_cases_base(unittest.TestCase):
             table_element = self.get_table_element(table_id)
             element_list = table_element.find_elements_by_partial_link_text(link_text)
             return element_list
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
 
 
@@ -506,8 +506,8 @@ class toaster_cases_base(unittest.TestCase):
         try:
             table_element = self.get_table_element(table_id)
             element = table_element.find_element_by_xpath(xpath)
-        except NoSuchElementException, e:
-            print 'no element found'
+        except NoSuchElementException as e:
+            print('no element found')
             raise
         return element
 
@@ -519,8 +519,8 @@ class toaster_cases_base(unittest.TestCase):
         try:
             table_element = self.get_table_element(table_id)
             element_list = table_element.find_elements_by_xpath(xpath)
-        except NoSuchElementException, e:
-            print 'no elements found'
+        except NoSuchElementException as e:
+            print('no elements found')
             raise
         return element_list
 
@@ -570,7 +570,7 @@ class toaster_cases_base(unittest.TestCase):
             element_xpath = "//*[@id='" + table_id + "']"
             try:
                 element = self.driver.find_element_by_xpath(element_xpath)
-            except NoSuchElementException, e:
+            except NoSuchElementException as e:
                 raise
             return element
         row = coordinate[0]
@@ -580,7 +580,7 @@ class toaster_cases_base(unittest.TestCase):
             element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]"
             try:
                 element = self.driver.find_element_by_xpath(element_xpath)
-            except NoSuchElementException, e:
+            except NoSuchElementException as e:
                 return False
             return element
 #now we are looking for an element with specified X and Y
@@ -589,7 +589,7 @@ class toaster_cases_base(unittest.TestCase):
         element_xpath = "//*[@id='" + table_id + "']/tbody/tr[" + str(row) + "]/td[" + str(column) + "]"
         try:
             element = self.driver.find_element_by_xpath(element_xpath)
-        except NoSuchElementException, e:
+        except NoSuchElementException as e:
             return False
         return element
 
@@ -607,7 +607,7 @@ class toaster_cases_base(unittest.TestCase):
                 column = column + 1
                 print("row_content=",row_content)
             Lists.extend(row_content)
-            print Lists[row-1][0]
+            print(Lists[row-1][0])
             row = row + 1
         return Lists
 
@@ -617,7 +617,7 @@ class toaster_cases_base(unittest.TestCase):
     def is_text_present (self, patterns):
         for pattern in patterns:
             if str(pattern) not in self.driver.page_source:
-                print 'Text "'+pattern+'" is missing'
+                print('Text "'+pattern+'" is missing')
                 return False
         return True
 
@@ -625,15 +625,15 @@ class toaster_cases_base(unittest.TestCase):
     def is_element_present(self, how, what):
         try:
             self.driver.find_element(how, what)
-        except NoSuchElementException, e:
-            print 'Could not find element '+str(what)+' by ' + str(how)
+        except NoSuchElementException as e:
+            print('Could not find element '+str(what)+' by ' + str(how))
             return False
         return True
 
 
     def is_alert_present(self):
         try: self.driver.switch_to_alert()
-        except NoAlertPresentException, e: return False
+        except NoAlertPresentException as e: return False
         return True
 
 
@@ -658,7 +658,7 @@ class toaster_cases_base(unittest.TestCase):
         try:
             caseno = int(caseno_str)
         except ValueError:
-            print "get case number error! please check if func name is test_xxx"
+            print("get case number error! please check if func name is test_xxx")
             return False
         return caseno
 
@@ -706,7 +706,7 @@ class toaster_cases(toaster_cases_base):
         for key in table_head_dict:
             try:
                 self.driver.find_element_by_link_text(key).click()
-            except Exception, e:
+            except Exception as e:
                 self.log.error("%s cannot be found on page" % key)
                 raise
             column_list = self.get_table_column_text("class", table_head_dict[key])
@@ -736,7 +736,7 @@ class toaster_cases(toaster_cases_base):
         patterns = ["minimal", "sato"]
         for pattern in patterns:
             ori_target_column_texts = self.get_table_column_text("class", "target")
-            print ori_target_column_texts
+            print(ori_target_column_texts)
             self.driver.find_element_by_id("search").clear()
             self.driver.find_element_by_id("search").send_keys(pattern)
             self.driver.find_element_by_id("search-button").click()
@@ -771,7 +771,7 @@ class toaster_cases(toaster_cases_base):
                 temp_element = self.find_element_by_text_in_table('otable', item)
                 # this is how we find "filter icon" in the same level as temp_element(where "a" means clickable, "i" means icon)
                 self.assertTrue(temp_element.find_element_by_xpath("..//*/a/i[@class='icon-filter filtered']"))
-            except Exception,e:
+            except Exception as e:
                 self.assertFalse(True, msg=(" %s cannot be found! %s" % (item, e)))
                 raise
         # step 5-6
@@ -812,7 +812,7 @@ class toaster_cases(toaster_cases_base):
         self.table_name = 'otable'
         # This is how we find the "default" rows-number!
         rows_displayed = int(Select(self.driver.find_element_by_css_selector("select.pagesize")).first_selected_option.text)
-        print rows_displayed
+        print(rows_displayed)
         self.assertTrue(self.get_table_element(self.table_name, rows_displayed), msg=("not enough rows displayed"))
         self.assertFalse(self.get_table_element(self.table_name, rows_displayed + 1), \
                          msg=("more rows displayed than expected"))
@@ -888,7 +888,7 @@ class toaster_cases(toaster_cases_base):
                         temp_element.find_element_by_xpath("..//*[@class='icon-filter filtered']").click()
                         avail_options = self.driver.find_elements_by_xpath("//*[@id='" + filter_dict[key] + "']//*[@name='filter'][not(@disabled)]")
                      except:
-                        print "in exception"
+                        print("in exception")
                         self.find_element_by_text("Show all tasks").click()
 #                        self.driver.find_element_by_xpath("//*[@id='searchform']/button[2]").click()
                         temp_element = self.find_element_by_link_text_in_table(self.table_name, key)
@@ -899,9 +899,9 @@ class toaster_cases(toaster_cases_base):
         for item in ['order', 'task_name', 'executed', 'outcome', 'recipe_name', 'recipe_version']:
             try:
                 self.find_element_by_xpath_in_table(self.table_name, "./tbody/tr[1]/*[@class='" + item + "']/a").click()
-            except NoSuchElementException, e:
+            except NoSuchElementException as e:
             # let it go...
-                print 'no item in the colum' + item
+                print('no item in the colum' + item)
             # insert screen shot here
             self.save_screenshot(screenshot_type='selenium', append_name='step11')
             self.driver.back()
@@ -992,13 +992,13 @@ class toaster_cases(toaster_cases_base):
         self.table_name = 'otable'
         # This is how we find the "default" rows-number!
         rows_displayed = int(Select(self.driver.find_element_by_css_selector("select.pagesize")).first_selected_option.text)
-        print rows_displayed
+        print(rows_displayed)
         self.assertTrue(self.get_table_element(self.table_name, rows_displayed))
         self.assertFalse(self.get_table_element(self.table_name, rows_displayed + 1))
 
         # Check the default table is sorted by Recipe
         tasks_column_count = len(self.driver.find_elements_by_xpath("/html/body/div[2]/div/div[2]/div[2]/table/tbody/tr/td[1]"))
-        print tasks_column_count
+        print(tasks_column_count)
         default_column_list = self.get_table_column_text_by_column_number(self.table_name, 1)
         #print default_column_list
 
@@ -1095,7 +1095,7 @@ class toaster_cases(toaster_cases_base):
 
         # Bug 5919
         for key in table_head_dict:
-            print key
+            print(key)
             self.find_element_by_link_text_in_table(self.table_name, key).click()
             self.driver.find_element_by_id("edit-columns-button").click()
             self.driver.find_element_by_id(table_head_dict[key]).click()
@@ -1167,7 +1167,7 @@ class toaster_cases(toaster_cases_base):
         check_list = ['Dependencies', 'Layer branch', 'Layer commit', 'Reverse dependencies']
         head_list = self.get_table_head_text('otable')
         time.sleep(2)
-        print head_list
+        print(head_list)
         for item in check_list:
             self.assertTrue(item in head_list, msg=("item %s not in head row" % item))
         # un-check 'em all
@@ -1226,8 +1226,8 @@ class toaster_cases(toaster_cases_base):
 
         tasks_row_count = len(driver.find_elements_by_xpath("//*[@id='"+self.table_name+"']/table/tbody/tr/td[1]"))
         tasks_column_count = len(driver.find_elements_by_xpath("//*[@id='"+self.table_name+"']/table/tbody/tr[1]/td"))
-        print 'rows: '+str(tasks_row_count)
-        print 'columns: '+str(tasks_column_count)
+        print('rows: '+str(tasks_row_count))
+        print('columns: '+str(tasks_column_count))
 
         Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
         print ("Tasks_column=", Tasks_column)
@@ -1253,9 +1253,9 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Packages (").click()
         packages_name = driver.find_element_by_partial_link_text("Packages (").text
-        print packages_name
+        print(packages_name)
         packages_num = int(filter(str.isdigit, repr(packages_name)))
-        print packages_num
+        print(packages_num)
 
         #switch the table to show more than 10 rows at a time
         self.driver.find_element_by_xpath("//*[@id='packages-built']/div[1]/div/select").click()
@@ -1263,7 +1263,7 @@ class toaster_cases(toaster_cases_base):
         self.driver.find_element_by_xpath("//*[@id='packages-built']/div[1]/div/select").send_keys(Keys.ENTER)
 
         packages_row_count = len(driver.find_elements_by_xpath("//*[@id='otable']/tbody/tr/td[1]"))
-        print packages_row_count
+        print(packages_row_count)
 
         if packages_num != packages_row_count:
             print ("Error! The packages number is not correct")
@@ -1272,20 +1272,20 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Build dependencies (").click()
         depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
-        print depends_name
-        depends_num = int(filter(str.isdigit, repr(depends_name)))
-        print depends_num
+        print(depends_name)
+        depends_num = int(list(filter(str.isdigit, repr(depends_name))))
+        print(depends_num)
 
         if depends_num == 0:
             depends_message = repr(driver.find_element_by_css_selector("div.alert.alert-info").text)
-            print depends_message
+            print(depends_message)
             if depends_message.find("has no build dependencies.") < 0:
                 print ("Error! The message isn't expected.")
             else:
                 print ("The message is expected")
         else:
             depends_row_count = len(driver.find_elements_by_xpath("//*[@id='dependencies']/table/tbody/tr/td[1]"))
-            print depends_row_count
+            print(depends_row_count)
             if depends_num != depends_row_count:
                 print ("Error! The dependent packages number is not correct")
             else:
@@ -1293,13 +1293,13 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
         rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
-        print rdepends_name
+        print(rdepends_name)
         rdepends_num = int(filter(str.isdigit, repr(rdepends_name)))
-        print rdepends_num
+        print(rdepends_num)
 
         if rdepends_num == 0:
             rdepends_message = repr(driver.find_element_by_css_selector("#brought-in-by > div.alert.alert-info").text)
-            print rdepends_message
+            print(rdepends_message)
             if rdepends_message.find("has no reverse build dependencies.") < 0:
                 print ("Error! The message isn't expected.")
             else:
@@ -1319,8 +1319,8 @@ class toaster_cases(toaster_cases_base):
 
         native_tasks_row_count = len(driver.find_elements_by_xpath("//*[@id='information']/table/tbody/tr/td[1]"))
         native_tasks_column_count = len(driver.find_elements_by_xpath("//*[@id='information']/table/tbody/tr[1]/td"))
-        print native_tasks_row_count
-        print native_tasks_column_count
+        print(native_tasks_row_count)
+        print(native_tasks_column_count)
 
         Native_Tasks_column = self.get_table_column_text_by_column_number(self.table_name, 2)
         print ("Native_Tasks_column=", Native_Tasks_column)
@@ -1346,15 +1346,15 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Packages (").click()
         native_packages_name = driver.find_element_by_partial_link_text("Packages (").text
-        print native_packages_name
+        print(native_packages_name)
         native_packages_num = int(filter(str.isdigit, repr(native_packages_name)))
-        print native_packages_num
+        print(native_packages_num)
 
         if native_packages_num != 0:
             print ("Error! Native task shouldn't have any packages.")
         else:
             native_package_message = repr(driver.find_element_by_css_selector("#packages-built > div.alert.alert-info").text)
-            print native_package_message
+            print(native_package_message)
             if native_package_message.find("does not build any packages.") < 0:
                 print ("Error! The message for native task isn't expected.")
             else:
@@ -1362,12 +1362,12 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Build dependencies (").click()
         native_depends_name = driver.find_element_by_partial_link_text("Build dependencies (").text
-        print native_depends_name
+        print(native_depends_name)
         native_depends_num = int(filter(str.isdigit, repr(native_depends_name)))
-        print native_depends_num
+        print(native_depends_num)
 
         native_depends_row_count = len(driver.find_elements_by_xpath("//*[@id='dependencies']/table/tbody/tr/td[1]"))
-        print native_depends_row_count
+        print(native_depends_row_count)
 
         if native_depends_num != native_depends_row_count:
             print ("Error! The dependent packages number is not correct")
@@ -1376,12 +1376,12 @@ class toaster_cases(toaster_cases_base):
 
         driver.find_element_by_partial_link_text("Reverse build dependencies (").click()
         native_rdepends_name = driver.find_element_by_partial_link_text("Reverse build dependencies (").text
-        print native_rdepends_name
+        print(native_rdepends_name)
         native_rdepends_num = int(filter(str.isdigit, repr(native_rdepends_name)))
-        print native_rdepends_num
+        print(native_rdepends_num)
 
         native_rdepends_row_count = len(driver.find_elements_by_xpath("//*[@id='brought-in-by']/table/tbody/tr/td[1]"))
-        print native_rdepends_row_count
+        print(native_rdepends_row_count)
 
         if native_rdepends_num != native_rdepends_row_count:
             print ("Error! The reverse dependent packages number is not correct")
@@ -1413,8 +1413,8 @@ class toaster_cases(toaster_cases_base):
         # step 5
         self.driver.find_element_by_css_selector("i.icon-remove").click()
         head_list = self.get_table_head_text('otable')
-        print head_list
-        print len(head_list)
+        print(head_list)
+        print(len(head_list))
         self.assertTrue(head_list == ['Variable', 'Value', 'Set in file', 'Description'], \
                         msg=("head row contents wrong"))
         # step 8
@@ -1830,7 +1830,7 @@ class toaster_cases(toaster_cases_base):
         try:
             self.driver.find_element_by_partial_link_text("Packages included")
             self.driver.find_element_by_partial_link_text("Directory structure")
-        except Exception,e:
+        except Exception as e:
             self.log.error(e)
             self.assertFalse(True)
         # step 4
@@ -2014,13 +2014,13 @@ class toaster_cases(toaster_cases_base):
         for i in range(0,4):
             data[i] = data[i][0]
         data.sort()
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_data = []
         for i in range (0,4):
             json_data.append(json_parse['releases'][i]['name'])
         json_data.sort()
-        print json_data
+        print(json_data)
         self.failUnless(data == json_data)
 
         ##############
@@ -2036,11 +2036,11 @@ class toaster_cases(toaster_cases_base):
         data = cursor.fetchall()
         for i in range(0,6):
             data[i] = data[i][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_data=json_parse['config']
         json_data = json_data.values()
-        print json_data
+        print(json_data)
         self.failUnless(data == json_data)
 
 
@@ -2057,12 +2057,12 @@ class toaster_cases(toaster_cases_base):
         data = cursor.fetchall()
         for i in range(0,3):
             data[i] = data[i][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_data = []
         for i in range(0,3):
             json_data.append(json_parse['layersources'][i]['name'])
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
         ##############
@@ -2077,10 +2077,10 @@ class toaster_cases(toaster_cases_base):
         cursor.execute(query)
         data = cursor.fetchall()
         data = data[0][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_data = json_parse['defaultrelease']
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
         ##############
@@ -2090,7 +2090,7 @@ class toaster_cases(toaster_cases_base):
         self.case_no = self.get_case_number()
         self.log.info(' CASE %s log: ' % str(self.case_no))
 
-        print 'Checking branches for "Local Yocto Project"'
+        print('Checking branches for "Local Yocto Project"')
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=1;"
@@ -2102,15 +2102,15 @@ class toaster_cases(toaster_cases_base):
                 data[i] = data[i][0]
         except:
             pass
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_location = json_parse['layersources'][0]['name']
-        print json_location
+        print(json_location)
         json_data = json_parse['layersources'][0]['branches']
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
-        print 'Checking branches for "OpenEmbedded"'
+        print('Checking branches for "OpenEmbedded"')
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=3;"
@@ -2119,15 +2119,15 @@ class toaster_cases(toaster_cases_base):
         lenght = len(data)
         for i in range(0,lenght):
             data[i] = data[i][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_location = json_parse['layersources'][1]['name']
-        print json_location
+        print(json_location)
         json_data = json_parse['layersources'][1]['branches']
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
-        print 'Checking branches for "Imported layers"'
+        print('Checking branches for "Imported layers"')
         con=sqlite.connect('toaster.sqlite')
         cursor = con.cursor()
         query = "select name from orm_branch where layer_source_id=2;"
@@ -2136,12 +2136,12 @@ class toaster_cases(toaster_cases_base):
         lenght = len(data)
         for i in range(0,lenght):
             data[i] = data[i][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_location = json_parse['layersources'][2]['name']
-        print json_location
+        print(json_location)
         json_data = json_parse['layersources'][2]['branches']
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
 
@@ -2158,12 +2158,12 @@ class toaster_cases(toaster_cases_base):
         data = cursor.fetchall()
         for i in range(0,4):
             data[i] = data[i][0]
-        print data
+        print(data)
         json_parse = json.loads(open('toasterconf.json').read())
         json_data = []
         for i in range(0,4):
             json_data.append(json_parse['bitbake'][i]['name'])
-        print json_data
+        print(json_data)
         self.failUnless(set(data) == set(json_data))
 
         ##############
@@ -2182,7 +2182,7 @@ class toaster_cases(toaster_cases_base):
         query = "select count(name) from orm_project where name = 'new-test-project';"
         cursor.execute(query)
         data = cursor.fetchone()
-        print 'data: %s' % data
+        print('data: %s' % data)
         self.failUnless(data >= 1)
 
         ##############
@@ -2275,7 +2275,7 @@ class toaster_cases(toaster_cases_base):
             data = data[0][0]
         except:
             pass
-        print data
+        print(data)
         self.failUnless(data == 'toaster_admin')
 
         ##############
@@ -2324,7 +2324,7 @@ class toaster_cases(toaster_cases_base):
         query = "select a.name, a.value from orm_projectvariable a, orm_project b where a.project_id = b.id and b.name = 'new-default-project';"
         cursor.execute(query)
         data = dict(cursor.fetchall())
-        print data
+        print(data)
         default_values = {u'IMAGE_INSTALL_append': u'', u'PACKAGE_CLASSES': u'package_rpm', u'MACHINE': u'qemux86', u'SDKMACHINE': u'x86_64', u'DISTRO': u'poky', u'IMAGE_FSTYPES': u'ext3 jffs2 tar.bz2'}
         self.failUnless(data == default_values)
 
@@ -2341,7 +2341,7 @@ class toaster_cases(toaster_cases_base):
         query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
         cursor.execute(query)
         data_initial = cursor.fetchall()
-        print data_initial
+        print(data_initial)
 
         self.driver.maximize_window()
         self.driver.get('localhost:8000')#self.base_url)
@@ -2362,7 +2362,7 @@ class toaster_cases(toaster_cases_base):
         query = "select layercommit_id from orm_projectlayer a, orm_project b where a.project_id=b.id and b.name='new-default-project';"
         cursor.execute(query)
         data_changed = cursor.fetchall()
-        print data_changed
+        print(data_changed)
 
         #resetting release to default
         self.driver.find_element_by_id('release-change-toggle').click()
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 30295a7..ee184e9 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -908,7 +908,7 @@ def _get_dir_entries(build_id, target_id, start):
             response.append(entry)
 
         except Exception as e:
-            print "Exception ", e
+            print("Exception ", e)
             traceback.print_exc(e)
 
     # sort by directories first, then by name
diff --git a/bitbake/lib/toaster/toastermain/management/commands/builddelete.py b/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
index ff93e54..0bef8d4 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
@@ -15,7 +15,7 @@ class Command(BaseCommand):
             try:
                 b = Build.objects.get(pk = bid)
             except ObjectDoesNotExist:
-                print 'build %s does not exist, skipping...' %(bid)
+                print('build %s does not exist, skipping...' %(bid))
                 continue
             # theoretically, just b.delete() would suffice
             # however SQLite runs into problems when you try to
diff --git a/bitbake/lib/toaster/toastermain/management/commands/buildslist.py b/bitbake/lib/toaster/toastermain/management/commands/buildslist.py
index cad987f..8dfef0a 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/buildslist.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/buildslist.py
@@ -10,4 +10,4 @@ class Command(NoArgsCommand):
 
     def handle_noargs(self,**options):
         for b in Build.objects.all():
-            print "%d: %s %s %s" % (b.pk, b.machine, b.distro, ",".join([x.target for x in b.target_set.all()]))
+            print("%d: %s %s %s" % (b.pk, b.machine, b.distro, ",".join([x.target for x in b.target_set.all()])))
diff --git a/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py b/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py
index 22b3eb7..911296f 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/get-dburl.py
@@ -6,4 +6,4 @@ class Command(NoArgsCommand):
     help    = "get database url"
 
     def handle_noargs(self,**options):
-        print getDATABASE_URL()
+        print(getDATABASE_URL())
diff --git a/bitbake/lib/toaster/toastermain/management/commands/perf.py b/bitbake/lib/toaster/toastermain/management/commands/perf.py
index 71a48e9..6b450bb 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/perf.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/perf.py
@@ -25,7 +25,7 @@ class Command(BaseCommand):
 			info = self.url_info(full_url)
 			status_code = info[0]
 			load_time = info[1]
-			print 'Trying \'' + full_url + '\', ' + str(status_code) + ', ' + str(load_time)
+			print('Trying \'' + full_url + '\', ' + str(status_code) + ', ' + str(load_time))
 
     def get_full_url(self, url_patt, url_root_res):
 	full_url = str(url_patt).split('^')[1].replace('$>', '').replace('(?P<file_path>(?:/[', '/bin/busybox').replace('.*', '')
@@ -54,5 +54,5 @@ class Command(BaseCommand):
 
     def error(self, *args):
 	for arg in args:
-	    print >>sys.stderr, arg,
-	print >>sys.stderr
+	    print(arg, end=' ', file=sys.stderr)
+	print(file=sys.stderr)
diff --git a/bitbake/lib/toaster/toastermain/settings.py b/bitbake/lib/toaster/toastermain/settings.py
index 74ab604..8662f39 100644
--- a/bitbake/lib/toaster/toastermain/settings.py
+++ b/bitbake/lib/toaster/toastermain/settings.py
@@ -138,7 +138,7 @@ else:
                 try:
                     if pytz.timezone(zonename) is not None:
                         zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
-                except UnknownTimeZoneError, ValueError:
+                except UnknownTimeZoneError as ValueError:
                     # we expect timezone failures here, just move over
                     pass
             except ImportError:




