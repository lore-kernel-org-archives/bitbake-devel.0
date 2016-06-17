Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 14D1073CBD
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 17:52:56 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id v199so6995830wmv.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jun 2016 10:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=BakXSNAZbXtvLpoAUMQvP11wIPGKDAIR0TcsNj/8MB4=;
	b=0Rxx7+Z2aP+EHlqLVMEfIyMtIEhLCv0IBjdEXqXiXCwFC2sIVKJp0d8jOSQDvc2tIh
	npGYmJCCzlH0SNQt24LR4+UVhXrJExGx5t2o/LXcyqc2aiimssEvf8ctmxBZcaB+0u/P
	FXKw6oiTEhElSzP9qwePsUy+Qx4NE5mvcYKes/cGklpqJbc/S7EuLej9q1NvSDz3UECm
	kjmuwwoA6hspvVFn9Q271kwT72f+1j/t6yh/+hauImPdmH24o/95gaI2EN9MUbhTYJpH
	Lh13L78pI1cyg77Mi/Opb3+lUafZKnupN4Ui/kZ7mfU8Oh8WIuW2ny8chYgRylBqwz03
	FpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=BakXSNAZbXtvLpoAUMQvP11wIPGKDAIR0TcsNj/8MB4=;
	b=L756h5Fa71dwW4yNtsa5FJP9UW/BsysSk3flHEPePC1+VAzbqQhzj8JApPlspjjIi9
	tO6tZV22sqA9JPjNe/oEk/wHJPlfSMrJgu/OaHP/9aKvSyXn9/UV/5rN01ElpwltkqDX
	pYvrZYAMERiecJWIVgouvJ3xSQD0SfO6yFWPKXVz8RQXKH5Veryb69wUkYCmFJ4L+MYJ
	dROdWadZMxBGpZ5T35IBXQuyYg1M/URbeuEVV31cq6X/HLSr51MzWfw+2gozS9Yd5oEO
	fwHasEkrNCzRKhP4Yuhx9fzvWcKGOyun7PSN7Tbk0/R38U4slEPbCYgCbBcHsAxcSyp/
	SsUA==
X-Gm-Message-State: ALyK8tL6IkngTDt4BVGgriuVC4RpfYjF2822r75Lj/HF83QDKy7MIeIw2z7kOAnIZ4u8WJXD
X-Received: by 10.28.27.8 with SMTP id b8mr846249wmb.40.1466185976521;
	Fri, 17 Jun 2016 10:52:56 -0700 (PDT)
Received: from localhost.localdomain
	(host86-169-85-169.range86-169.btcentralplus.com. [86.169.85.169])
	by smtp.gmail.com with ESMTPSA id a129sm488171wma.2.2016.06.17.10.52.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 17 Jun 2016 10:52:55 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jun 2016 18:52:51 +0100
Message-Id: <1466185971-18537-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1466185971-18537-1-git-send-email-michael.g.wood@intel.com>
References: <1466185971-18537-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/2] toaster-tests: define capabilities for latest Firefox driver
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
X-List-Received-Date: Fri, 17 Jun 2016 17:52:57 -0000

From: Elliot Smith <elliot.smith@intel.com>

For the latest Firefox versions, WebDriver requires a download of a
separate binary and an additional capability to be defined on it.

Modify our tests so that when "marionette" is set as the browser,
this capability is defined on the Firefox driver. Also add a note to the
README about the additional installation steps required.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/browser/README              | 19 +++++++++++++++++--
 lib/toaster/tests/browser/selenium_helpers.py |  5 +++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/README b/lib/toaster/tests/browser/README
index f57154e..969f06c 100644
--- a/lib/toaster/tests/browser/README
+++ b/lib/toaster/tests/browser/README
@@ -24,15 +24,30 @@ To run tests against PhantomJS (headless):
 * On *nix systems, put phantomjs on PATH
 * Not tested on Windows
 
-Firefox should work without requiring additional software to be installed.
+To run tests against Firefox, you may need to install the Marionette driver,
+depending on how new your version of Firefox is. One clue that you need to do
+this is if you see an exception like:
 
-The test case will instantiate a Selenium driver set by the
+  selenium.common.exceptions.WebDriverException: Message: The browser
+  appears to have exited before we could connect. If you specified
+  a log_file in the FirefoxBinary constructor, check it for details.
+
+See https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette/WebDriver
+for installation instructions. Ensure that the Marionette executable (renamed
+as wires on Linux or wires.exe on Windows) is on your PATH; and use "marionette"
+as the browser string passed via TOASTER_TESTS_BROWSER (see below).
+
+(Note: The Toaster tests have been checked against Firefox 47 with the
+Marionette driver.)
+
+The test cases will instantiate a Selenium driver set by the
 TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not specified.
 
 Available drivers:
 
 * chrome (default)
 * firefox
+* marionette (for newer Firefoxes)
 * ie
 * phantomjs
 
diff --git a/lib/toaster/tests/browser/selenium_helpers.py b/lib/toaster/tests/browser/selenium_helpers.py
index 54db2e8..000937f 100644
--- a/lib/toaster/tests/browser/selenium_helpers.py
+++ b/lib/toaster/tests/browser/selenium_helpers.py
@@ -34,6 +34,7 @@ import time
 from django.contrib.staticfiles.testing import StaticLiveServerTestCase
 from selenium import webdriver
 from selenium.webdriver.support.ui import WebDriverWait
+from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException
 
@@ -49,6 +50,10 @@ def create_selenium_driver(browser='chrome'):
         )
     elif browser == 'firefox':
         return webdriver.Firefox()
+    elif browser == 'marionette':
+        capabilities = DesiredCapabilities.FIREFOX
+        capabilities['marionette'] = True
+        return webdriver.Firefox(capabilities=capabilities)
     elif browser == 'ie':
         return webdriver.Ie()
     elif browser == 'phantomjs':
-- 
2.7.4


