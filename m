Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id DF9A9606D0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jul 2016 10:32:21 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8D890100EC0;
	Fri, 15 Jul 2016 10:32:20 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-120-4-226.us-west-2.compute.internal [10.120.4.226])
	by relay.mailchannels.net (Postfix) with ESMTPA id B3034100368;
	Fri, 15 Jul 2016 10:32:19 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.107.128.240])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.16); Fri, 15 Jul 2016 10:32:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1468578740191:2074854944
X-MC-Ingress-Time: 1468578740191
Received: from [176.253.151.47] (port=58976 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bO0Pq-0001ho-4p; Fri, 15 Jul 2016 06:32:18 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2016 11:32:07 +0100
Message-Id: <1468578727-30368-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-AuthUser: elliot@townx.org
Subject: [PATCH] toaster-tests: add class SeleniumTestCaseBase for browser tests
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
X-List-Received-Date: Fri, 15 Jul 2016 10:32:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>

In order to reuse the Selenium helper outside a Django
environment (for functional testing), add a new module
containing the base class SeleniumTestCaseBase, which only
inherits unittest.TestCase

Add a class SeleniumTestCase with multiple inheritance of
StaticLiveServerTestCase and SeleniumTestCaseBase to prevent
existing tests from breaking.

Signed-off-by: An=C3=ADbal Lim=C3=B3n <anibal.limon@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../lib/toaster/tests/browser/selenium_helpers.py  | 187 +--------------=
---
 .../toaster/tests/browser/selenium_helpers_base.py | 216 +++++++++++++++=
++++++
 2 files changed, 221 insertions(+), 182 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/browser/selenium_helpers_ba=
se.py

diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers.py b/bitb=
ake/lib/toaster/tests/browser/selenium_helpers.py
index ef07858..ddb43fd 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers.py
@@ -23,195 +23,18 @@
 # modified from Patchwork, released under the same licence terms as Toas=
ter:
 # https://github.com/dlespiau/patchwork/blob/master/patchwork/tests.brow=
ser.py
=20
+from django.contrib.staticfiles.testing import StaticLiveServerTestCase
+from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
+
 """
 Helper methods for creating Toaster Selenium tests which run within
 the context of Django unit tests.
 """
=20
-import os
-import time
-
-from django.contrib.staticfiles.testing import StaticLiveServerTestCase
-from selenium import webdriver
-from selenium.webdriver.support.ui import WebDriverWait
-from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
-from selenium.common.exceptions import NoSuchElementException, \
-        StaleElementReferenceException, TimeoutException
-
-def create_selenium_driver(browser=3D'chrome'):
-    # set default browser string based on env (if available)
-    env_browser =3D os.environ.get('TOASTER_TESTS_BROWSER')
-    if env_browser:
-        browser =3D env_browser
-
-    if browser =3D=3D 'chrome':
-        return webdriver.Chrome(
-            service_args=3D["--verbose", "--log-path=3Dselenium.log"]
-        )
-    elif browser =3D=3D 'firefox':
-        return webdriver.Firefox()
-    elif browser =3D=3D 'marionette':
-        capabilities =3D DesiredCapabilities.FIREFOX
-        capabilities['marionette'] =3D True
-        return webdriver.Firefox(capabilities=3Dcapabilities)
-    elif browser =3D=3D 'ie':
-        return webdriver.Ie()
-    elif browser =3D=3D 'phantomjs':
-        return webdriver.PhantomJS()
-    else:
-        msg =3D 'Selenium driver for browser %s is not available' % brow=
ser
-        raise RuntimeError(msg)
-
-class Wait(WebDriverWait):
-    """
-    Subclass of WebDriverWait with predetermined timeout and poll
-    frequency. Also deals with a wider variety of exceptions.
-    """
-    _TIMEOUT =3D 10
-    _POLL_FREQUENCY =3D 0.5
-
-    def __init__(self, driver):
-        super(Wait, self).__init__(driver, self._TIMEOUT, self._POLL_FRE=
QUENCY)
-
-    def until(self, method, message=3D''):
-        """
-        Calls the method provided with the driver as an argument until t=
he
-        return value is not False.
-        """
-
-        end_time =3D time.time() + self._timeout
-        while True:
-            try:
-                value =3D method(self._driver)
-                if value:
-                    return value
-            except NoSuchElementException:
-                pass
-            except StaleElementReferenceException:
-                pass
-
-            time.sleep(self._poll)
-            if time.time() > end_time:
-                break
-
-        raise TimeoutException(message)
-
-    def until_not(self, method, message=3D''):
-        """
-        Calls the method provided with the driver as an argument until t=
he
-        return value is False.
-        """
-
-        end_time =3D time.time() + self._timeout
-        while True:
-            try:
-                value =3D method(self._driver)
-                if not value:
-                    return value
-            except NoSuchElementException:
-                return True
-            except StaleElementReferenceException:
-                pass
-
-            time.sleep(self._poll)
-            if time.time() > end_time:
-                break
-
-        raise TimeoutException(message)
-
-class SeleniumTestCase(StaticLiveServerTestCase):
+class SeleniumTestCase(SeleniumTestCaseBase, StaticLiveServerTestCase):
     """
     NB StaticLiveServerTestCase is used as the base test case so that
     static files are served correctly in a Selenium test run context; se=
e
     https://docs.djangoproject.com/en/1.9/ref/contrib/staticfiles/#speci=
alized-test-case-to-support-live-testing
     """
-
-    @classmethod
-    def setUpClass(cls):
-        """ Create a webdriver driver at the class level """
-
-        super(SeleniumTestCase, cls).setUpClass()
-
-        # instantiate the Selenium webdriver once for all the test metho=
ds
-        # in this test case
-        cls.driver =3D create_selenium_driver()
-        cls.driver.maximize_window()
-
-    @classmethod
-    def tearDownClass(cls):
-        """ Clean up webdriver driver """
-
-        cls.driver.quit()
-        super(SeleniumTestCase, cls).tearDownClass()
-
-    def get(self, url):
-        """
-        Selenium requires absolute URLs, so convert Django URLs returned
-        by resolve() or similar to absolute ones and get using the
-        webdriver instance.
-
-        url: a relative URL
-        """
-        abs_url =3D '%s%s' % (self.live_server_url, url)
-        self.driver.get(abs_url)
-
-    def find(self, selector):
-        """ Find single element by CSS selector """
-        return self.driver.find_element_by_css_selector(selector)
-
-    def find_all(self, selector):
-        """ Find all elements matching CSS selector """
-        return self.driver.find_elements_by_css_selector(selector)
-
-    def element_exists(self, selector):
-        """
-        Return True if one element matching selector exists,
-        False otherwise
-        """
-        return len(self.find_all(selector)) =3D=3D 1
-
-    def focused_element(self):
-        """ Return the element which currently has focus on the page """
-        return self.driver.switch_to.active_element
-
-    def wait_until_present(self, selector):
-        """ Wait until element matching CSS selector is on the page """
-        is_present =3D lambda driver: self.find(selector)
-        msg =3D 'An element matching "%s" should be on the page' % selec=
tor
-        element =3D Wait(self.driver).until(is_present, msg)
-        return element
-
-    def wait_until_visible(self, selector):
-        """ Wait until element matching CSS selector is visible on the p=
age """
-        is_visible =3D lambda driver: self.find(selector).is_displayed()
-        msg =3D 'An element matching "%s" should be visible' % selector
-        Wait(self.driver).until(is_visible, msg)
-        return self.find(selector)
-
-    def wait_until_focused(self, selector):
-        """ Wait until element matching CSS selector has focus """
-        is_focused =3D \
-            lambda driver: self.find(selector) =3D=3D self.focused_eleme=
nt()
-        msg =3D 'An element matching "%s" should be focused' % selector
-        Wait(self.driver).until(is_focused, msg)
-        return self.find(selector)
-
-    def enter_text(self, selector, value):
-        """ Insert text into element matching selector """
-        # note that keyup events don't occur until the element is clicke=
d
-        # (in the case of <input type=3D"text"...>, for example), so sim=
ulate
-        # user clicking the element before inserting text into it
-        field =3D self.click(selector)
-
-        field.send_keys(value)
-        return field
-
-    def click(self, selector):
-        """ Click on element which matches CSS selector """
-        element =3D self.wait_until_visible(selector)
-        element.click()
-        return element
-
-    def get_page_source(self):
-        """ Get raw HTML for the current page """
-        return self.driver.page_source
+    pass
diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py b=
/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
new file mode 100644
index 0000000..c4161d7
--- /dev/null
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -0,0 +1,216 @@
+#! /usr/bin/env python
+# ex:ts=3D4:sw=3D4:sts=3D4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+#
+# BitBake Toaster Implementation
+#
+# Copyright (C) 2013-2016 Intel Corporation
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
+# You should have received a copy of the GNU General Public License alon=
g
+# with this program; if not, write to the Free Software Foundation, Inc.=
,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# The Wait class and some of SeleniumDriverHelper and SeleniumTestCase a=
re
+# modified from Patchwork, released under the same licence terms as Toas=
ter:
+# https://github.com/dlespiau/patchwork/blob/master/patchwork/tests.brow=
ser.py
+
+"""
+Base helper methods for creating Toaster Selenium tests.
+"""
+
+import os
+import time
+import unittest
+
+from selenium import webdriver
+from selenium.webdriver.support.ui import WebDriverWait
+from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
+from selenium.common.exceptions import NoSuchElementException, \
+        StaleElementReferenceException, TimeoutException
+
+def create_selenium_driver(browser=3D'chrome'):
+    # set default browser string based on env (if available)
+    env_browser =3D os.environ.get('TOASTER_TESTS_BROWSER')
+    if env_browser:
+        browser =3D env_browser
+
+    if browser =3D=3D 'chrome':
+        return webdriver.Chrome(
+            service_args=3D["--verbose", "--log-path=3Dselenium.log"]
+        )
+    elif browser =3D=3D 'firefox':
+        return webdriver.Firefox()
+    elif browser =3D=3D 'marionette':
+        capabilities =3D DesiredCapabilities.FIREFOX
+        capabilities['marionette'] =3D True
+        return webdriver.Firefox(capabilities=3Dcapabilities)
+    elif browser =3D=3D 'ie':
+        return webdriver.Ie()
+    elif browser =3D=3D 'phantomjs':
+        return webdriver.PhantomJS()
+    else:
+        msg =3D 'Selenium driver for browser %s is not available' % brow=
ser
+        raise RuntimeError(msg)
+
+class Wait(WebDriverWait):
+    """
+    Subclass of WebDriverWait with predetermined timeout and poll
+    frequency. Also deals with a wider variety of exceptions.
+    """
+    _TIMEOUT =3D 10
+    _POLL_FREQUENCY =3D 0.5
+
+    def __init__(self, driver):
+        super(Wait, self).__init__(driver, self._TIMEOUT, self._POLL_FRE=
QUENCY)
+
+    def until(self, method, message=3D''):
+        """
+        Calls the method provided with the driver as an argument until t=
he
+        return value is not False.
+        """
+
+        end_time =3D time.time() + self._timeout
+        while True:
+            try:
+                value =3D method(self._driver)
+                if value:
+                    return value
+            except NoSuchElementException:
+                pass
+            except StaleElementReferenceException:
+                pass
+
+            time.sleep(self._poll)
+            if time.time() > end_time:
+                break
+
+        raise TimeoutException(message)
+
+    def until_not(self, method, message=3D''):
+        """
+        Calls the method provided with the driver as an argument until t=
he
+        return value is False.
+        """
+
+        end_time =3D time.time() + self._timeout
+        while True:
+            try:
+                value =3D method(self._driver)
+                if not value:
+                    return value
+            except NoSuchElementException:
+                return True
+            except StaleElementReferenceException:
+                pass
+
+            time.sleep(self._poll)
+            if time.time() > end_time:
+                break
+
+        raise TimeoutException(message)
+
+class SeleniumTestCaseBase(unittest.TestCase):
+    """
+    NB StaticLiveServerTestCase is used as the base test case so that
+    static files are served correctly in a Selenium test run context; se=
e
+    https://docs.djangoproject.com/en/1.9/ref/contrib/staticfiles/#speci=
alized-test-case-to-support-live-testing
+    """
+
+    @classmethod
+    def setUpClass(cls):
+        """ Create a webdriver driver at the class level """
+
+        super(SeleniumTestCaseBase, cls).setUpClass()
+
+        # instantiate the Selenium webdriver once for all the test metho=
ds
+        # in this test case
+        cls.driver =3D create_selenium_driver()
+        cls.driver.maximize_window()
+
+    @classmethod
+    def tearDownClass(cls):
+        """ Clean up webdriver driver """
+
+        cls.driver.quit()
+        super(SeleniumTestCaseBase, cls).tearDownClass()
+
+    def get(self, url):
+        """
+        Selenium requires absolute URLs, so convert Django URLs returned
+        by resolve() or similar to absolute ones and get using the
+        webdriver instance.
+
+        url: a relative URL
+        """
+        abs_url =3D '%s%s' % (self.live_server_url, url)
+        self.driver.get(abs_url)
+
+    def find(self, selector):
+        """ Find single element by CSS selector """
+        return self.driver.find_element_by_css_selector(selector)
+
+    def find_all(self, selector):
+        """ Find all elements matching CSS selector """
+        return self.driver.find_elements_by_css_selector(selector)
+
+    def element_exists(self, selector):
+        """
+        Return True if one element matching selector exists,
+        False otherwise
+        """
+        return len(self.find_all(selector)) =3D=3D 1
+
+    def focused_element(self):
+        """ Return the element which currently has focus on the page """
+        return self.driver.switch_to.active_element
+
+    def wait_until_present(self, selector):
+        """ Wait until element matching CSS selector is on the page """
+        is_present =3D lambda driver: self.find(selector)
+        msg =3D 'An element matching "%s" should be on the page' % selec=
tor
+        element =3D Wait(self.driver).until(is_present, msg)
+        return element
+
+    def wait_until_visible(self, selector):
+        """ Wait until element matching CSS selector is visible on the p=
age """
+        is_visible =3D lambda driver: self.find(selector).is_displayed()
+        msg =3D 'An element matching "%s" should be visible' % selector
+        Wait(self.driver).until(is_visible, msg)
+        return self.find(selector)
+
+    def wait_until_focused(self, selector):
+        """ Wait until element matching CSS selector has focus """
+        is_focused =3D \
+            lambda driver: self.find(selector) =3D=3D self.focused_eleme=
nt()
+        msg =3D 'An element matching "%s" should be focused' % selector
+        Wait(self.driver).until(is_focused, msg)
+        return self.find(selector)
+
+    def enter_text(self, selector, value):
+        """ Insert text into element matching selector """
+        # note that keyup events don't occur until the element is clicke=
d
+        # (in the case of <input type=3D"text"...>, for example), so sim=
ulate
+        # user clicking the element before inserting text into it
+        field =3D self.click(selector)
+
+        field.send_keys(value)
+        return field
+
+    def click(self, selector):
+        """ Click on element which matches CSS selector """
+        element =3D self.wait_until_visible(selector)
+        element.click()
+        return element
+
+    def get_page_source(self):
+        """ Get raw HTML for the current page """
+        return self.driver.page_source
--=20
2.7.4


