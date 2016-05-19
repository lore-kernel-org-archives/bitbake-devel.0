Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 710536E668
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 May 2016 10:43:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 May 2016 03:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,334,1459839600"; d="scan'208";a="980343661"
Received: from gfois-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.121])
	by orsmga002.jf.intel.com with ESMTP; 19 May 2016 03:43:48 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 May 2016 11:43:32 +0100
Message-Id: <1463654612-30647-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1463654612-30647-1-git-send-email-elliot.smith@intel.com>
References: <1463654612-30647-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 3/3] bitbake: toaster-tests: tests for project config
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
X-List-Received-Date: Thu, 19 May 2016 10:43:48 -0000

From: Sujith H <sujith.h@gmail.com>

Add basic tests to validate the value user types
in the text box for IMAGEFS_TYPES. Added a test
case to show the checkbox get automatically selected
when user types value available in the check list.
Added a test case to verify if the check box is enabled
then the text box should also get updated accordingly.

[YOCTO #7828]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tests/browser/test_project_config_page.py      | 115 +++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_project_config_page.py

diff --git a/bitbake/lib/toaster/tests/browser/test_project_config_page.py b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
new file mode 100644
index 0000000..ede53b6
--- /dev/null
+++ b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
@@ -0,0 +1,115 @@
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
+import re
+
+from django.core.urlresolvers import reverse
+from django.utils import timezone
+from tests.browser.selenium_helpers import SeleniumTestCase
+
+from orm.models import BitbakeVersion, Release, Project, ProjectVariable
+
+class TestProjectConfigsPage(SeleniumTestCase):
+    """ Test data at /project/X/builds is displayed correctly """
+
+    PROJECT_NAME = 'test project'
+
+    def setUp(self):
+        bbv = BitbakeVersion.objects.create(name='bbv1', giturl='/tmp/',
+                                            branch='master', dirpath='')
+        release = Release.objects.create(name='release1',
+                                         bitbake_version=bbv)
+        self.project1 = Project.objects.create_project(name=self.PROJECT_NAME,
+                                                       release=release)
+        self.project1.save()
+
+
+    def test_no_underscore_iamgefs_type(self):
+        """
+        Should not accept IMAGEFS_TYPE with an underscore
+        """
+
+        imagefs_type = "foo_bar"
+
+        ProjectVariable.objects.get_or_create(project = self.project1, name = "IMAGE_FSTYPES", value = "abcd ")
+        url = reverse('projectconf', args=(self.project1.id,));
+        self.get(url);
+
+        self.click('#change-image_fstypes-icon')
+
+        self.enter_text('#new-imagefs_types', imagefs_type)
+
+        element = self.wait_until_visible('#hintError-image-fs_type')
+
+        self.assertTrue(("A valid image type cannot include underscores" in element.text),
+                        "Did not find underscore error message")
+
+
+    def test_checkbox_verification(self):
+        """
+        Should automatically check the checkbox if user enters value
+        text box, if value is there in the checkbox.
+        """
+        imagefs_type = "btrfs"
+
+        ProjectVariable.objects.get_or_create(project = self.project1, name = "IMAGE_FSTYPES", value = "abcd ")
+        url = reverse('projectconf', args=(self.project1.id,));
+        self.get(url);
+
+        self.click('#change-image_fstypes-icon')
+
+        self.enter_text('#new-imagefs_types', imagefs_type)
+
+        checkboxes = self.driver.find_elements_by_xpath("//input[@class='fs-checkbox-fstypes']")
+
+        for checkbox in checkboxes:
+            if checkbox.get_attribute("value") == "btrfs":
+               self.assertEqual(checkbox.is_selected(), True)
+
+
+    def test_textbox_with_checkbox_verification(self):
+        """
+        Should automatically add or remove value in textbox, if user checks
+        or unchecks checkboxes.
+        """
+
+        ProjectVariable.objects.get_or_create(project = self.project1, name = "IMAGE_FSTYPES", value = "abcd ")
+        url = reverse('projectconf', args=(self.project1.id,));
+        self.get(url);
+
+        self.click('#change-image_fstypes-icon')
+
+        self.wait_until_visible('#new-imagefs_types')
+
+        checkboxes = self.driver.find_elements_by_xpath("//input[@class='fs-checkbox-fstypes']")
+
+        for checkbox in checkboxes:
+            if checkbox.get_attribute("value") == "cpio":
+               checkbox.click()
+               element = self.driver.find_element_by_id('new-imagefs_types')
+
+               self.wait_until_visible('#new-imagefs_types')
+
+               self.assertTrue(("cpio" in element.get_attribute('value'),
+                               "Imagefs not added into the textbox"))
+               checkbox.click()
+               self.assertTrue(("cpio" not in element.text),
+                               "Image still present in the textbox")
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


