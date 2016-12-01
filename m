Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 0DF8771AF1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Dec 2016 03:31:14 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id c4so43113366pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2016 19:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=dngZ7fDuOsG0qggRsxq+gi9LLL2puut+MaSd9JR87NA=;
	b=f338061mPmfWNZQ+I4piAYSktv+C+BX6nqwjufsKiAwKzJ6YA5IntcxYAUL5kGpuCJ
	g0QM4tVuY39Bte0wUK4nwXs7sC51Ug5l8pZODfcD3s800pmULUV5PCpgX80Z5sM/9qRS
	2aLyOKJZVz+ZZfIA2UDv5FixAgwi46MJaUYa2M2lbkV7WtdzVnlqeNWnghN68kL4mhbe
	8u53WOw0WKoB5ILStUqjyvfulAQuM8Ev/S/u+wT6n2cRzwOdya4zqZPRoXwwlKlEQQcH
	CU3oaEwJUdrixYehVLjajewSwUo1FoT1yxzMBjZhFHSL4bQ5G2hXh1LhwZi2/HFrDe4b
	qBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=dngZ7fDuOsG0qggRsxq+gi9LLL2puut+MaSd9JR87NA=;
	b=X1GUSSS/iZl86o2Tt4qyJUvnf8KV+6Yy0yHDqpDGGKrEk54MEs0dkj5RcSHeKvlt43
	+H6TShfguffj0k6o1Gz/tsz0VMODPsEMysUfSQ6rvgkDgr2ZzKyziHJBDDSrXE4NHv4i
	zC9v0gJaMjeLOP7QL6nZ1QJpJ1zqH2MxWYLUEXm2+rUK1IXiPHI8lgK9edfKzWBc6oTY
	DFWIhF2OdAfHR7FOoDSwbYSouHp7gYaNbQXdVY9hTP3fNkl9SiObKDEWdDp8mNo5bHsf
	/VaEQGVsXaMYUxCBvdMLfEuYczelhr4RdkK7Iz35GhpwLX3zrzZ4po/Us2I51Z97r0tf
	fzmw==
X-Gm-Message-State: AKaTC03UnZvY7Kgu7fNrU4VkkmfOwRkmzMV7q0ZliU6QkdDvsN40GHLxnj4CKadaZfkYhw==
X-Received: by 10.98.15.206 with SMTP id 75mr37028456pfp.105.1480563076126;
	Wed, 30 Nov 2016 19:31:16 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	89sm105862449pfi.70.2016.11.30.19.31.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 30 Nov 2016 19:31:15 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Nov 2016 19:35:27 -0800
Message-Id: <c8cfe42a0afffcdbe688a9cf4e6026bd482a79a3.1480563227.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1480563227.git.brian.avery@intel.com>
References: <cover.1480563227.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: browser tests - add Selenium Docker container as driver
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
X-List-Received-Date: Thu, 01 Dec 2016 03:31:15 -0000

Adds the ability to specify a Selenium Docker container server as
a driver. This allows for repeatable tests independent of host.
Currently we assume you are using the Firefox container. Instructions
are located in the README in tests/browser.

Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/tests/browser/README                   | 21 +++++++++++++++++++--
 lib/toaster/tests/browser/selenium_helpers_base.py | 13 +++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/tests/browser/README b/lib/toaster/tests/browser/README
index 6b09d20..e841a3f 100644
--- a/lib/toaster/tests/browser/README
+++ b/lib/toaster/tests/browser/README
@@ -18,7 +18,7 @@ To run tests against Chrome:
 * On Windows, put chromedriver.exe in the same directory as chrome.exe
 
 To run tests against PhantomJS (headless):
-
+--NOTE - Selenium seems to be deprecating support for this mode ---
 * Download and install PhantomJS:
   http://phantomjs.org/download.html
 * On *nix systems, put phantomjs on PATH
@@ -43,13 +43,30 @@ Marionette driver.)
 The test cases will instantiate a Selenium driver set by the
 TOASTER_TESTS_BROWSER environment variable, or Chrome if this is not specified.
 
+To run tests against the Selenium Firefox Docker container:
+More explanation is located at https://wiki.yoctoproject.org/wiki/TipsAndTricks/TestingToasterWithContainers
+* Run the Selenium container:
+  ** docker run -it --rm=true -p 5900:5900 -p 4444:4444 --name=selenium selenium/standalone-firefox-debug:2.53.0
+  *** 5900 is the default vnc port. If you are runing a vnc server on your machine map a different port e.g. -p 6900:5900 and connect vnc client to 127.0.0.1:6900
+  *** 4444 is the default selenium sever port.
+* Run the tests
+  ** TOASTER_TESTS_BROWSER=http://127.0.0.1:4444/wd/hub TOASTER_TESTS_URL=http://172.17.0.1:8000 ./bitbake/lib/toaster/manage.py test --liveserver=172.17.0.1:8000 tests.browser
+  ** TOASTER_TESTS_BROWSER=remote TOASTER_REMOTE_HUB=http://127.0.0.1:4444/wd/hub ./bitbake/lib/toaster/manage.py test --liveserver=172.17.0.1:8000 tests.browser
+  *** TOASTER_REMOTE_HUB - This is the address for the Selenium Remote Web Driver hub. Assuming you ran the contianer with -p 4444:4444 it will be http://127.0.0.1:4444/wd/hub.
+  ***  --liveserver=xxx tells Django to run the test server on an interface and port reachable by both host and container.
+  **** 172.17.0.1 is the default docker bridge on linux, viewable from inside and outside the contianers. Find it with "ip -4 addr show dev docker0"
+* connect to the vnc server to see the tests if you would like
+   ** xtightvncviewer 127.0.0.1:5900
+   ** note, you need to wait for the test container to come up before this can connect.
+
 Available drivers:
 
 * chrome (default)
 * firefox
 * marionette (for newer Firefoxes)
 * ie
-* phantomjs
+* phantomjs (deprecated)
+* remote
 
 e.g. to run the test suite with phantomjs where you have phantomjs installed
 in /home/me/apps/phantomjs:
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 14e9c15..156d639 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -39,7 +39,7 @@ from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException
 
-def create_selenium_driver(browser='chrome'):
+def create_selenium_driver(cls,browser='chrome'):
     # set default browser string based on env (if available)
     env_browser = os.environ.get('TOASTER_TESTS_BROWSER')
     if env_browser:
@@ -59,6 +59,15 @@ def create_selenium_driver(browser='chrome'):
         return webdriver.Ie()
     elif browser == 'phantomjs':
         return webdriver.PhantomJS()
+    elif browser == 'remote':
+        # if we were to add yet another env variable like TOASTER_REMOTE_BROWSER
+        # we could let people pick firefox or chrome, left for later
+        remote_hub= os.environ.get('TOASTER_REMOTE_HUB')
+        driver = webdriver.Remote(remote_hub,
+                                  webdriver.DesiredCapabilities.FIREFOX.copy())
+
+        driver.get("http://%s:%s"%(cls.server_thread.host,cls.server_thread.port))
+        return driver
     else:
         msg = 'Selenium driver for browser %s is not available' % browser
         raise RuntimeError(msg)
@@ -135,7 +144,7 @@ class SeleniumTestCaseBase(unittest.TestCase):
 
         # instantiate the Selenium webdriver once for all the test methods
         # in this test case
-        cls.driver = create_selenium_driver()
+        cls.driver = create_selenium_driver(cls)
         cls.driver.maximize_window()
 
     @classmethod
-- 
1.9.1


