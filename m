Return-Path: <elliot.smith@intel.com>
X-Greylist: delayed 482 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 22 Jun 2016 09:18:56 UTC
Received: from gt-egress-003.mailchannels.net
	(antelope.tulip.relay.mailchannels.net [23.83.218.4])
	by mail.openembedded.org (Postfix) with ESMTP id B13306010D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jun 2016 09:18:55 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6355912013D;
	Wed, 22 Jun 2016 09:10:51 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-213-14-133.us-west-2.compute.internal [10.213.14.133])
	by relay.mailchannels.net (Postfix) with ESMTPA id B6BF9120D51;
	Wed, 22 Jun 2016 09:10:50 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.21.13.78])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.6.14); Wed, 22 Jun 2016 09:10:51 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1466586651115:3894320350
X-MC-Ingress-Time: 1466586651115
Received: from [176.251.19.34] (port=42832 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bFeDg-0004w7-CR; Wed, 22 Jun 2016 05:13:12 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2016 10:10:42 +0100
Message-Id: <1466586642-18896-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1466586642-18896-1-git-send-email-elliot.smith@intel.com>
References: <1466586642-18896-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 2/2] bitbake: toaster-tests: tests for project config
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
X-List-Received-Date: Wed, 22 Jun 2016 09:18:58 -0000

From: Sujith H <sujith.h@gmail.com>

Add basic tests to validate the value, user types
in the text box for DL_DIR and SSTATE_DIR. Added
test case to validate the first char and inclusion
of space between the characters.

[YOCTO #9646]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../tests/browser/test_project_config_page.py      | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/bitbake/lib/toaster/tests/browser/test_project_config_page.py b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
index 7fc1252..0710084 100644
--- a/bitbake/lib/toaster/tests/browser/test_project_config_page.py
+++ b/bitbake/lib/toaster/tests/browser/test_project_config_page.py
@@ -31,6 +31,9 @@ class TestProjectConfigsPage(SeleniumTestCase):
     """ Test data at /project/X/builds is displayed correctly """
 
     PROJECT_NAME = 'test project'
+    INVALID_PATH_START_TEXT = 'The directory path should either start with a /'
+    INVALID_PATH_CHAR_TEXT = 'The directory path cannot include spaces or ' \
+        'any of these characters'
 
     def setUp(self):
         bbv = BitbakeVersion.objects.create(name='bbv1', giturl='/tmp/',
@@ -116,3 +119,113 @@ class TestProjectConfigsPage(SeleniumTestCase):
                checkbox.click()
                self.assertTrue(("cpio" not in element.text),
                                "Image still present in the textbox")
+
+    def test_set_download_dir(self):
+        """
+        Validate the allowed and disallowed types in the directory field for
+        DL_DIR
+        """
+
+        ProjectVariable.objects.get_or_create(project=self.project1,
+            name='DL_DIR')
+        url = reverse('projectconf', args=(self.project1.id,))
+        self.get(url)
+
+        # activate the input to edit download dir
+        self.click('#change-dl_dir-icon')
+        self.wait_until_visible('#new-dl_dir')
+
+        # downloads dir path doesn't start with / or ${...}
+        self.enter_text('#new-dl_dir', 'home/foo')
+        element = self.wait_until_visible('#hintError-initialChar-dl_dir')
+
+        msg = 'downloads directory path starts with invalid character but ' \
+            'treated as valid'
+        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), msg)
+
+        # downloads dir path has a space
+        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '/foo/bar a')
+
+        element = self.wait_until_visible('#hintError-dl_dir')
+        msg = 'downloads directory path characters invalid but treated as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
+
+        # downloads dir path starts with ${...} but has a space
+        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
+
+        element = self.wait_until_visible('#hintError-dl_dir')
+        msg = 'downloads directory path characters invalid but treated as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
+
+        # downloads dir path starts with /
+        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '/bar/foo')
+
+        hidden_element = self.driver.find_element_by_id('hintError-dl_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'downloads directory path valid but treated as invalid')
+
+        # downloads dir path starts with ${...}
+        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '${TOPDIR}/down')
+
+        hidden_element = self.driver.find_element_by_id('hintError-dl_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'downloads directory path valid but treated as invalid')
+
+    def test_set_sstate_dir(self):
+        """
+        Validate the allowed and disallowed types in the directory field for
+        SSTATE_DIR
+        """
+
+        ProjectVariable.objects.get_or_create(project=self.project1,
+            name='SSTATE_DIR')
+        url = reverse('projectconf', args=(self.project1.id,))
+        self.get(url)
+
+        self.click('#change-sstate_dir-icon')
+
+        self.wait_until_visible('#new-sstate_dir')
+
+        # path doesn't start with / or ${...}
+        self.enter_text('#new-sstate_dir', 'home/foo')
+        element = self.wait_until_visible('#hintError-initialChar-sstate_dir')
+
+        msg = 'sstate directory path starts with invalid character but ' \
+            'treated as valid'
+        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), msg)
+
+        # path has a space
+        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '/foo/bar a')
+
+        element = self.wait_until_visible('#hintError-sstate_dir')
+        msg = 'sstate directory path characters invalid but treated as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
+
+        # path starts with ${...} but has a space
+        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
+
+        element = self.wait_until_visible('#hintError-sstate_dir')
+        msg = 'sstate directory path characters invalid but treated as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), msg)
+
+        # path starts with /
+        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '/bar/foo')
+
+        hidden_element = self.driver.find_element_by_id('hintError-sstate_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'sstate directory path valid but treated as invalid')
+
+        # paths starts with ${...}
+        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
+
+        hidden_element = self.driver.find_element_by_id('hintError-sstate_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'sstate directory path valid but treated as invalid')
\ No newline at end of file
-- 
2.7.4


