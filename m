Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3C33577266
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:49 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272751"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:49 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:54 -0600
Message-Id: <1456188718-13755-5-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
References: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 4/8] toaster/tests: Adds setup test case.
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:49 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The setup test case is responsible to leave toaster in certain
state for execute ui tests now it creates selenium-project and
builds core-image-{minimal, sato} images.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/toaster/tests/setup.py | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 lib/toaster/tests/setup.py

diff --git a/lib/toaster/tests/setup.py b/lib/toaster/tests/setup.py
new file mode 100644
index 0000000..0acbb16
--- /dev/null
+++ b/lib/toaster/tests/setup.py
@@ -0,0 +1,77 @@
+import time
+
+from selenium import webdriver
+from selenium.common.exceptions import NoSuchElementException
+from selenium import selenium
+from selenium.webdriver.common.by import By
+from selenium.webdriver.common.keys import Keys
+from selenium.webdriver.support.ui import Select
+
+from toaster.tests.base import ToasterTestCase
+
+class ToasterSetupTestCase(ToasterTestCase):
+    def setUp(self):
+        self.driver = webdriver.Firefox()
+
+    def tearDown(self):
+        self.driver.close()
+
+    def is_text_present (self, patterns):
+        for pattern in patterns:
+            if str(pattern) not in self.driver.page_source:
+                self.logger.debug(pattern)
+                return False
+        return True
+
+    def test_setupToaster(self):
+        self.driver.maximize_window()
+        self.driver.get(self.opts.toaster_url)
+        try:
+            self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        except:
+            self.driver.find_element_by_id("new-project-button").click()
+            self.driver.find_element_by_id("new-project-name").send_keys("selenium-project")
+            self.driver.find_element_by_id("create-project-button").click()
+
+        try:
+            self.driver.find_element_by_link_text("selenium-project").click()
+        except:
+            self.driver.find_element_by_id("new-project-button").click()
+            self.driver.find_element_by_id("new-project-name").send_keys("selenium-project")
+            self.driver.find_element_by_id("create-project-button").click()
+        time.sleep(5)
+
+        #queue up a core-image-minimal
+        self.driver.find_element_by_id("build-input").send_keys("core-image-minimal")
+        self.driver.find_element_by_id("build-button").click()
+        time.sleep(5)
+        #queue up a core-image-sato
+        self.driver.find_element_by_id("build-input").send_keys("core-image-sato")
+        self.driver.find_element_by_id("build-button").click()
+        time.sleep(5)
+
+        #go back to the main project page
+        self.driver.find_element_by_css_selector("a[href='/toastergui/projects/']").click()
+        time.sleep(5)
+        self.driver.find_element_by_link_text("selenium-project").click()
+        time.sleep(5)
+
+        #move to all builds page
+        self.driver.find_element_by_css_selector("a[href='/toastergui/builds/']").click()
+        self.driver.refresh()
+        time.sleep(5)
+
+        #check progress bar is displayed to signal a build has started
+        try:
+            while (self.driver.find_element_by_xpath("//div[@class='progress']").is_displayed()):
+                self.logger.info('Builds are running ...')
+                self.driver.refresh()
+                time.sleep(15)
+        except:
+            pass
+
+        self.logger.info("Looking for successful build...")
+        if (self.driver.find_element_by_xpath("//div[@class='alert build-result alert-success project-name']").is_displayed()):
+            self.logger.info("Builds complete!")
+        else:
+            self.fail(msg="Builds did not complete successfully.")
-- 
2.1.4


