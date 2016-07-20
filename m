Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id B4C54606A8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jul 2016 16:37:17 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4EF8D20FC7;
	Wed, 20 Jul 2016 16:37:10 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-10-199.us-west-2.compute.internal [10.229.10.199])
	by relay.mailchannels.net (Postfix) with ESMTPA id 9C5ED20F3E;
	Wed, 20 Jul 2016 16:37:09 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.91.5.35])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Wed, 20 Jul 2016 16:37:10 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469032629879:3156498227
X-MC-Ingress-Time: 1469032629879
Received: from [176.249.240.35] (port=52136 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bPuUe-0000Xi-F0; Wed, 20 Jul 2016 12:37:08 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jul 2016 17:37:03 +0100
Message-Id: <1469032624-484-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
X-AuthUser: elliot@townx.org
Subject: [PATCH 1/2] toaster-tests: define capabilities for latest Firefox driver
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
X-List-Received-Date: Wed, 20 Jul 2016 16:37:18 -0000

For the latest Firefox versions, WebDriver requires a download of a
separate binary and an additional capability to be defined on it.

Modify our tests so that when "marionette" is set as the browser,
this capability is defined on the Firefox driver. Also add a note to the
README about the additional installation steps required.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/tests/browser/README              | 19 +++++++++++++++++--
 .../toaster/tests/browser/selenium_helpers_base.py    |  5 +++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/tests/browser/README b/bitbake/lib/toaster/tests/browser/README
index f57154e..969f06c 100644
--- a/bitbake/lib/toaster/tests/browser/README
+++ b/bitbake/lib/toaster/tests/browser/README
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
 
diff --git a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
index 09b893c..14e9c15 100644
--- a/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/bitbake/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -35,6 +35,7 @@ import unittest
 from django.contrib.staticfiles.testing import StaticLiveServerTestCase
 from selenium import webdriver
 from selenium.webdriver.support.ui import WebDriverWait
+from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException
 
@@ -50,6 +51,10 @@ def create_selenium_driver(browser='chrome'):
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


