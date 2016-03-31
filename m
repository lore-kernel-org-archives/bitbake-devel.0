Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 5C3B760745
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 18:56:02 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id f198so13464229wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Mar 2016 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=mRkrLEgzi+qeUDoXJaHjHJ/ijIyp1CMEjw/NYAz8ivA=;
	b=enJDHqBMCaz7H+EORLReu7grpHg6wr6c96OAfWJPmSz6yZ/yssxU9voY7G7liGx31D
	YIE+TmSJv+3+N16l0DR2KIKNK8IOfiBe6CW5irFqpySModaPsgqBpr+vji8qJ7yoGpiW
	vVXqQOX2vG5SvdaewViM0X4s3CQVyLLsB+bHxyRsO/ciQHitzcWGu1dlwPP8MAyZlxLq
	rR9UqETmCvHf+S/guH2D8MVeb/IkBR4g4Tf4IwjKSk4jiYB7aCajMlUYOv6+wyEnuMOM
	oT1jp9OnELsEKmcakXYDaqK2RcbiUyZPeoCm9oZODzEW9tGBfSz4dH+72brtqXePnhkz
	2oLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=mRkrLEgzi+qeUDoXJaHjHJ/ijIyp1CMEjw/NYAz8ivA=;
	b=ksf9gXje0+t+VI+rJMOKBVrXe18QjfPCpZEbRn9L+pAP2u1lgIfUYYNauAtVN9u4a9
	bflTkI0E0zUgTcL0mIZ+AFUuyj7+QUe7L/E4q3RWk2MalN0FC09G81e+H8gZQ1Rjtx+i
	2PbsqWY0aDoAcHHmvdvQn8CoRHY1Y5F/AaNNUsHDMIPelu+Lb2reEWp+uCdFBaLB5zOo
	dTsc3rCz580Q0XTRCa0js4IXqNqnAGGNFr50z5lT5+IR4gkpodDvMazi/x3gncleCsze
	Lf5uSwL4/1YHXg4/6BJ5b546ePgZyxWg5/i7Xf5GlvyZbDX52mg8oyXDLm7K6n1c2bIU
	Ow3w==
X-Gm-Message-State: AD7BkJJ9JYJS2s8/P3IWqtB3RvrwqwARYmRP+AjoKvyQs76WH43rAUEh2nSiCaBq2dfzyxsn
X-Received: by 10.28.223.70 with SMTP id w67mr4048876wmg.92.1459450563062;
	Thu, 31 Mar 2016 11:56:03 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fv6sm10406288wjc.12.2016.03.31.11.56.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 31 Mar 2016 11:56:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Mar 2016 19:55:43 +0100
Message-Id: <1459450547-26248-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 1/5] toaster: tests Migrate to Selenium for UI tests
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
X-List-Received-Date: Thu, 31 Mar 2016 18:56:03 -0000

From: Elliot Smith <elliot.smith@intel.com>

Create a new folder for Selenium tests.

Add a new base Selenium testcase class and a helper which
instantiates a webdriver for a given browser.

Add a sample Selenium test case which can be used as a template
for creating new tests.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/__init__.py                    |   0
 lib/toaster/tests/browser/README                 |  41 +++++
 lib/toaster/tests/browser/__init__.py            |   0
 lib/toaster/tests/browser/selenium_helpers.py    | 200 +++++++++++++++++++++++
 lib/toaster/tests/browser/test_sample.py         |  41 +++++
 lib/toaster/tests/toaster-tests-requirements.txt |   1 +
 6 files changed, 283 insertions(+)
 create mode 100644 lib/toaster/tests/__init__.py
 create mode 100644 lib/toaster/tests/browser/README
 create mode 100644 lib/toaster/tests/browser/__init__.py
 create mode 100644 lib/toaster/tests/browser/selenium_helpers.py
 create mode 100644 lib/toaster/tests/browser/test_sample.py
 create mode 100644 lib/toaster/tests/toaster-tests-requirements.txt

diff --git a/lib/toaster/tests/__init__.py b/lib/toaster/tests/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/browser/README b/lib/toaster/tests/browser/README
new file mode 100644
index 0000000..63e8169
--- /dev/null
+++ b/lib/toaster/tests/browser/README
@@ -0,0 +1,41 @@
+# Running Toaster's browser-based test suite
+
+These tests require Selenium to be installed in your Python environment.
+
+The simplest way to install this is via pip:
+
+  pip install selenium
+
+Alternatively, if you used pip to install the libraries required by Toaster,
+selenium will already be installed.
+
+To run tests against Chrome:
+
+* Download chromedriver for your host OS from
+  https://code.google.com/p/chromedriver/downloads/list
+* On *nix systems, put chromedriver on PATH
+* On Windows, put chromedriver.exe in the same directory as chrome.exe
+
+To run tests against PhantomJS (headless):
+
+* Download and install PhantomJS:
+  http://phantomjs.org/download.html
+* On *nix systems, put phantomjs on PATH
+* Not tested on Windows
+
+Firefox should work without requiring additional software to be installed.
+
+The test case will instantiate a Selenium driver set by the
+TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not specified.
+
+Available drivers:
+
+* chrome (default)
+* firefox
+* ie
+* phantomjs
+
+e.g. to run the test suite with phantomjs where you have phantomjs installed
+in /home/me/apps/phantomjs:
+
+PATH=/home/me/apps/phantomjs/bin:$PATH TOASTER_TESTS_BROWSER=phantomjs manage.py test tests.browser
diff --git a/lib/toaster/tests/browser/__init__.py b/lib/toaster/tests/browser/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
new file mode 100644
index 0000000..d3ab3ca
--- /dev/null
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -0,0 +1,200 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
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
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# The Wait class and some of SeleniumDriverHelper and SeleniumTestCase are
+# modified from Patchwork, released under the same licence terms as Toaster:
+# https://github.com/dlespiau/patchwork/blob/master/patchwork/tests.browser.py
+
+"""
+Helper methods for creating Toaster Selenium tests which run within
+the context of Django unit tests.
+"""
+
+import os
+import time
+
+from django.contrib.staticfiles.testing import StaticLiveServerTestCase
+from selenium import webdriver
+from selenium.webdriver.support.ui import WebDriverWait
+from selenium.common.exceptions import NoSuchElementException, \
+        StaleElementReferenceException, TimeoutException
+
+def create_selenium_driver(browser='chrome'):
+    # set default browser string based on env (if available)
+    env_browser = os.environ.get('TOASTER_TESTS_BROWSER')
+    if env_browser:
+        browser = env_browser
+
+    if browser == 'chrome':
+        return webdriver.Chrome(
+            service_args=["--verbose", "--log-path=selenium.log"]
+        )
+    elif browser == 'firefox':
+        return webdriver.Firefox()
+    elif browser == 'ie':
+        return webdriver.Ie()
+    elif browser == 'phantomjs':
+        return webdriver.PhantomJS()
+    else:
+        msg = 'Selenium driver for browser %s is not available' % browser
+        raise RuntimeError(msg)
+
+class Wait(WebDriverWait):
+    """
+    Subclass of WebDriverWait with predetermined timeout and poll
+    frequency. Also deals with a wider variety of exceptions.
+    """
+    _TIMEOUT = 10
+    _POLL_FREQUENCY = 0.5
+
+    def __init__(self, driver):
+        super(Wait, self).__init__(driver, self._TIMEOUT, self._POLL_FREQUENCY)
+
+    def until(self, method, message=''):
+        """
+        Calls the method provided with the driver as an argument until the
+        return value is not False.
+        """
+
+        end_time = time.time() + self._timeout
+        while True:
+            try:
+                value = method(self._driver)
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
+    def until_not(self, method, message=''):
+        """
+        Calls the method provided with the driver as an argument until the
+        return value is False.
+        """
+
+        end_time = time.time() + self._timeout
+        while True:
+            try:
+                value = method(self._driver)
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
+class SeleniumTestCase(StaticLiveServerTestCase):
+    """
+    NB StaticLiveServerTestCase is used as the base test case so that
+    static files are served correctly in a Selenium test run context; see
+    https://docs.djangoproject.com/en/1.9/ref/contrib/staticfiles/#specialized-test-case-to-support-live-testing
+    """
+
+    @classmethod
+    def setUpClass(cls):
+        """ Create a webdriver driver at the class level """
+
+        super(SeleniumTestCase, cls).setUpClass()
+
+        # instantiate the Selenium webdriver once for all the test methods
+        # in this test case
+        cls.driver = create_selenium_driver()
+
+    @classmethod
+    def tearDownClass(cls):
+        """ Clean up webdriver driver """
+
+        cls.driver.quit()
+        super(SeleniumTestCase, cls).tearDownClass()
+
+    def get(self, url):
+        """
+        Selenium requires absolute URLs, so convert Django URLs returned
+        by resolve() or similar to absolute ones and get using the
+        webdriver instance.
+
+        url: a relative URL
+        """
+        abs_url = '%s%s' % (self.live_server_url, url)
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
+    def focused_element(self):
+        """ Return the element which currently has focus on the page """
+        return self.driver.switch_to.active_element
+
+    def wait_until_present(self, selector):
+        """ Wait until element matching CSS selector is on the page """
+        is_present = lambda driver: self.find(selector)
+        msg = 'An element matching "%s" should be on the page' % selector
+        element = Wait(self.driver).until(is_present, msg)
+        return element
+
+    def wait_until_visible(self, selector):
+        """ Wait until element matching CSS selector is visible on the page """
+        is_visible = lambda driver: self.find(selector).is_displayed()
+        msg = 'An element matching "%s" should be visible' % selector
+        Wait(self.driver).until(is_visible, msg)
+        return self.find(selector)
+
+    def wait_until_focused(self, selector):
+        """ Wait until element matching CSS selector has focus """
+        is_focused = \
+            lambda driver: self.find(selector) == self.focused_element()
+        msg = 'An element matching "%s" should be focused' % selector
+        Wait(self.driver).until(is_focused, msg)
+        return self.find(selector)
+
+    def enter_text(self, selector, value):
+        """ Insert text into element matching selector """
+        field = self.wait_until_present(selector)
+        field.send_keys(value)
+        return field
+
+    def click(self, selector):
+        """ Click on element which matches CSS selector """
+        element = self.wait_until_visible(selector)
+        element.click()
+        return element
+
+    def get_page_source(self):
+        """ Get raw HTML for the current page """
+        return self.driver.page_source
diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests/browser/test_sample.py
new file mode 100644
index 0000000..7bb8b97
--- /dev/null
+++ b/lib/toaster/tests/browser/test_sample.py
@@ -0,0 +1,41 @@
+#! /usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
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
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+"""
+A small example test demonstrating the basics of writing a test with
+Toaster's SeleniumTestCase; this just fetches the Toaster home page
+and checks it has the word "Toaster" in the brand link
+
+New test files should follow this structure, should be named "test_*.py",
+and should be in the same directory as this sample.
+"""
+
+from django.core.urlresolvers import reverse
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+class TestSample(SeleniumTestCase):
+    """ Test landing page shows the Toaster brand """
+
+    def test_landing_page_has_brand(self):
+        url = reverse('landing')
+        self.get(url)
+        brand_link = self.find('span.brand a')
+        self.assertEqual(brand_link.text.strip(), 'Toaster')
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster/tests/toaster-tests-requirements.txt
new file mode 100644
index 0000000..4f9fcc4
--- /dev/null
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -0,0 +1 @@
+selenium==2.49.2
-- 
2.1.4


