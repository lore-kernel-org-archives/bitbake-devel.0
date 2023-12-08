Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE8C10DC3
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:53:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.10265.1702000412564188550
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:53:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Zlgl1t0t;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CBFFB9C33BA
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:53:31 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0PPbllN2CEFu; Thu,  7 Dec 2023 20:53:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6FD0E9C33E2;
	Thu,  7 Dec 2023 20:53:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6FD0E9C33E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000409; bh=pD2TC+aByrxAp1AwQjbm4/ivgOg7xUgsyRvZN6Wb2Sw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Zlgl1t0tltYhg41+lxQyN0h7pqdKfdmNaLw5N7UqoY1mqJgZQBx7HtCEL92D53b2O
	 dSZ3iD/5mvX75jCzL8qI1AVVCPZJC5Db5dQ6fh3tinbHEoEwzs38Azx34BDapje1SR
	 ntnqrh8R8MuyIG9rVm8rekS8UmRR9+QhgHTm++nU4nUVt7cX8uk78bNIuBa+uMdlSS
	 4ircsDA45ZOmI+3t32rg7xtQFMUSMkmNlTKuWQIqE8C4MGIUvEIUSGyAfkHRjALDt/
	 WW+MqlVb/gqEv/GRnmVGumyp1u7ZJtgWz3QXGIwMTPSqkqX5qyjqMEnwkMpAXHFNEa
	 837FvJ+6/5ZGg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iCIQkPJEpMEm; Thu,  7 Dec 2023 20:53:29 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4577F9C3472;
	Thu,  7 Dec 2023 20:53:28 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/4] toaster/test: Refactorize tests/functional
Date: Fri,  8 Dec 2023 02:53:18 +0100
Message-Id: <20231208015319.677993-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
References: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15636

- Split testcases from test_project_page_tab_config into tow files
- Added new testcases in test_project_config
    - Test changing distro variable
    - Test setting IMAGE_INSTALL:append variable
    - Test setting PACKAGE_CLASSES variable
    - Test creating new bitbake variable

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_config.py   | 335 ++++++++++++
 .../test_project_page_tab_config.py           | 495 ++++++++----------
 2 files changed, 554 insertions(+), 276 deletions(-)
 create mode 100644 lib/toaster/tests/functional/test_project_config.py

diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/to=
aster/tests/functional/test_project_config.py
new file mode 100644
index 00000000..2d162d81
--- /dev/null
+++ b/lib/toaster/tests/functional/test_project_config.py
@@ -0,0 +1,335 @@
+#! /usr/bin/env python3 #
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import string
+import random
+import pytest
+from django.urls import reverse
+from selenium.webdriver import Keys
+from selenium.webdriver.support.select import Select
+from selenium.common.exceptions import TimeoutException
+from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
+from selenium.webdriver.common.by import By
+
+from .utils import get_projectId_from_url
+
+
+@pytest.mark.django_db
+@pytest.mark.order("last")
+class TestProjectConfig(SeleniumFunctionalTestCase):
+    project_id =3D None
+    PROJECT_NAME =3D 'TestProjectConfig'
+    INVALID_PATH_START_TEXT =3D 'The directory path should either start =
with a /'
+    INVALID_PATH_CHAR_TEXT =3D 'The directory path cannot include spaces=
 or ' \
+        'any of these characters'
+
+    def _create_project(self, project_name):
+        """ Create/Test new project using:
+          - Project Name: Any string
+          - Release: Any string
+          - Merge Toaster settings: True or False
+        """
+        self.get(reverse('newproject'))
+        self.wait_until_visible('#new-project-name', poll=3D2)
+        self.find("#new-project-name").send_keys(project_name)
+        select =3D Select(self.find("#projectversion"))
+        select.select_by_value('3')
+
+        # check merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if not checkbox.is_selected():
+            checkbox.click()
+
+        if self.PROJECT_NAME !=3D 'TestProjectConfig':
+            # Reset project name if it's not the default one
+            self.PROJECT_NAME =3D 'TestProjectConfig'
+
+        self.find("#create-project-button").click()
+
+        try:
+            self.wait_until_visible('#hint-error-project-name', poll=3D2=
)
+            url =3D reverse('project', args=3D(TestProjectConfig.project=
_id, ))
+            self.get(url)
+            self.wait_until_visible('#config-nav', poll=3D3)
+        except TimeoutException:
+            self.wait_until_visible('#config-nav', poll=3D3)
+
+    def _random_string(self, length):
+        return ''.join(
+            random.choice(string.ascii_letters) for _ in range(length)
+        )
+
+    def _get_config_nav_item(self, index):
+        config_nav =3D self.find('#config-nav')
+        return config_nav.find_elements(By.TAG_NAME, 'li')[index]
+
+    def _navigate_bbv_page(self):
+        """ Navigate to project BitBake variables page """
+        # check if the menu is displayed
+        if TestProjectConfig.project_id is None:
+            self._create_project(project_name=3Dself._random_string(10))
+            current_url =3D self.driver.current_url
+            TestProjectConfig.project_id =3D get_projectId_from_url(curr=
ent_url)
+        else:
+            url =3D reverse('projectconf', args=3D(TestProjectConfig.pro=
ject_id,))
+            self.get(url)
+        self.wait_until_visible('#config-nav', poll=3D3)
+        bbv_page_link =3D self._get_config_nav_item(9)
+        bbv_page_link.click()
+        self.wait_until_visible('#config-nav', poll=3D3)
+
+    def test_no_underscore_iamgefs_type(self):
+        """
+        Should not accept IMAGEFS_TYPE with an underscore
+        """
+        self._navigate_bbv_page()
+        imagefs_type =3D "foo_bar"
+
+        self.wait_until_visible('#change-image_fstypes-icon', poll=3D2)
+
+        self.click('#change-image_fstypes-icon')
+
+        self.enter_text('#new-imagefs_types', imagefs_type)
+
+        element =3D self.wait_until_visible('#hintError-image-fs_type', =
poll=3D2)
+
+        self.assertTrue(("A valid image type cannot include underscores"=
 in element.text),
+                        "Did not find underscore error message")
+
+    def test_checkbox_verification(self):
+        """
+        Should automatically check the checkbox if user enters value
+        text box, if value is there in the checkbox.
+        """
+        self._navigate_bbv_page()
+
+        imagefs_type =3D "btrfs"
+
+        self.wait_until_visible('#change-image_fstypes-icon', poll=3D2)
+
+        self.click('#change-image_fstypes-icon')
+
+        self.enter_text('#new-imagefs_types', imagefs_type)
+
+        checkboxes =3D self.driver.find_elements(By.XPATH, "//input[@cla=
ss=3D'fs-checkbox-fstypes']")
+
+        for checkbox in checkboxes:
+            if checkbox.get_attribute("value") =3D=3D "btrfs":
+               self.assertEqual(checkbox.is_selected(), True)
+
+    def test_textbox_with_checkbox_verification(self):
+        """
+        Should automatically add or remove value in textbox, if user che=
cks
+        or unchecks checkboxes.
+        """
+        self._navigate_bbv_page()
+
+        self.wait_until_visible('#change-image_fstypes-icon', poll=3D2)
+
+        self.click('#change-image_fstypes-icon')
+
+        checkboxes_selector =3D '.fs-checkbox-fstypes'
+
+        self.wait_until_visible(checkboxes_selector, poll=3D2)
+        checkboxes =3D self.find_all(checkboxes_selector)
+
+        for checkbox in checkboxes:
+            if checkbox.get_attribute("value") =3D=3D "cpio":
+               checkbox.click()
+               element =3D self.driver.find_element(By.ID, 'new-imagefs_=
types')
+
+               self.wait_until_visible('#new-imagefs_types', poll=3D2)
+
+               self.assertTrue(("cpio" in element.get_attribute('value')=
,
+                               "Imagefs not added into the textbox"))
+               checkbox.click()
+               self.assertTrue(("cpio" not in element.text),
+                               "Image still present in the textbox")
+
+    def test_set_download_dir(self):
+        """
+        Validate the allowed and disallowed types in the directory field=
 for
+        DL_DIR
+        """
+        self._navigate_bbv_page()
+
+        # activate the input to edit download dir
+        try:
+            change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
+        except TimeoutException:
+            # If download dir is not displayed, test is skipped
+            return True
+        change_dl_dir_btn =3D self.wait_until_visible('#change-dl_dir-ic=
on', poll=3D2)
+        change_dl_dir_btn.click()
+
+        # downloads dir path doesn't start with / or ${...}
+        input_field =3D self.wait_until_visible('#new-dl_dir', poll=3D2)
+        input_field.clear()
+        self.enter_text('#new-dl_dir', 'home/foo')
+        element =3D self.wait_until_visible('#hintError-initialChar-dl_d=
ir', poll=3D2)
+
+        msg =3D 'downloads directory path starts with invalid character =
but ' \
+            'treated as valid'
+        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
+
+        # downloads dir path has a space
+        self.driver.find_element(By.ID, 'new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '/foo/bar a')
+
+        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
+        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+
+        # downloads dir path starts with ${...} but has a space
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
+
+        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
+        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+
+        # downloads dir path starts with /
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '/bar/foo')
+
+        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'downloads directory path valid but treated as invalid')
+
+        # downloads dir path starts with ${...}
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
+        self.enter_text('#new-dl_dir', '${TOPDIR}/down')
+
+        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'downloads directory path valid but treated as invalid')
+
+    def test_set_sstate_dir(self):
+        """
+        Validate the allowed and disallowed types in the directory field=
 for
+        SSTATE_DIR
+        """
+        self._navigate_bbv_page()
+
+        try:
+            self.wait_until_visible('#change-sstate_dir-icon', poll=3D2)
+            self.click('#change-sstate_dir-icon')
+        except TimeoutException:
+            # If sstate_dir is not displayed, test is skipped
+            return True
+
+        # path doesn't start with / or ${...}
+        input_field =3D self.wait_until_visible('#new-sstate_dir', poll=3D=
2)
+        input_field.clear()
+        self.enter_text('#new-sstate_dir', 'home/foo')
+        element =3D self.wait_until_visible('#hintError-initialChar-ssta=
te_dir', poll=3D2)
+
+        msg =3D 'sstate directory path starts with invalid character but=
 ' \
+            'treated as valid'
+        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
+
+        # path has a space
+        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '/foo/bar a')
+
+        element =3D self.wait_until_visible('#hintError-sstate_dir', pol=
l=3D2)
+        msg =3D 'sstate directory path characters invalid but treated as=
 valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+
+        # path starts with ${...} but has a space
+        self.driver.find_element(By.ID,'new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
+
+        element =3D self.wait_until_visible('#hintError-sstate_dir', pol=
l=3D2)
+        msg =3D 'sstate directory path characters invalid but treated as=
 valid'
+        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
+
+        # path starts with /
+        self.driver.find_element(By.ID,'new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '/bar/foo')
+
+        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'sstate directory path valid but treated as invalid')
+
+        # paths starts with ${...}
+        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
+        self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
+
+        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
+        self.assertEqual(hidden_element.is_displayed(), False,
+            'sstate directory path valid but treated as invalid')
+
+    def _change_bbv_value(self, **kwargs):
+        var_name, field, btn_id, input_id, value, save_btn, *_ =3D kwarg=
s.values()
+        """ Change bitbake variable value """
+        self._navigate_bbv_page()
+        self.wait_until_visible(f'#{btn_id}', poll=3D2)
+        if kwargs.get('new_variable'):
+            self.find(f"#{btn_id}").clear()
+            self.enter_text(f"#{btn_id}", f"{var_name}")
+        else:
+            self.click(f'#{btn_id}')
+            self.wait_until_visible(f'#{input_id}', poll=3D2)
+
+        if kwargs.get('is_select'):
+            select =3D Select(self.find(f'#{input_id}'))
+            select.select_by_visible_text(value)
+        else:
+            self.find(f"#{input_id}").clear()
+            self.enter_text(f'#{input_id}', f'{value}')
+        self.click(f'#{save_btn}')
+        value_displayed =3D str(self.wait_until_visible(f'#{field}').tex=
t).lower()
+        msg =3D f'{var_name} variable not changed'
+        self.assertTrue(str(value).lower() in value_displayed, msg)
+
+    def test_change_distro_var(self):
+        """ Test changing distro variable """
+        self._change_bbv_value(
+            var_name=3D'DISTRO',
+            field=3D'distro',
+            btn_id=3D'change-distro-icon',
+            input_id=3D'new-distro',
+            value=3D'poky-changed',
+            save_btn=3D"apply-change-distro",
+        )
+
+    def test_set_image_install_append_var(self):
+        """ Test setting IMAGE_INSTALL:append variable """
+        self._change_bbv_value(
+            var_name=3D'IMAGE_INSTALL:append',
+            field=3D'image_install',
+            btn_id=3D'change-image_install-icon',
+            input_id=3D'new-image_install',
+            value=3D'bash, apt, busybox',
+            save_btn=3D"apply-change-image_install",
+        )
+
+    def test_set_package_classes_var(self):
+        """ Test setting PACKAGE_CLASSES variable """
+        self._change_bbv_value(
+            var_name=3D'PACKAGE_CLASSES',
+            field=3D'package_classes',
+            btn_id=3D'change-package_classes-icon',
+            input_id=3D'package_classes-select',
+            value=3D'package_deb',
+            save_btn=3D"apply-change-package_classes",
+            is_select=3DTrue,
+        )
+
+    def test_create_new_bbv(self):
+        """ Test creating new bitbake variable """
+        self._change_bbv_value(
+            var_name=3D'New_Custom_Variable',
+            field=3D'configvar-list',
+            btn_id=3D'variable',
+            input_id=3D'value',
+            value=3D'new variable value',
+            save_btn=3D"add-configvar-button",
+            new_variable=3DTrue
+        )
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 23012d78..d911ff00 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -6,87 +6,81 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-from time import sleep
+import string
+import random
 import pytest
-from django.utils import timezone
 from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
-from selenium.common.exceptions import NoSuchElementException
-from orm.models import Build, Project, Target
+from selenium.common.exceptions import TimeoutException
+from orm.models import Project
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from selenium.webdriver.common.by import By
=20
+from .utils import get_projectId_from_url, wait_until_build, wait_until_=
build_cancelled
+
=20
 @pytest.mark.django_db
+@pytest.mark.order("last")
 class TestProjectConfigTab(SeleniumFunctionalTestCase):
+    PROJECT_NAME =3D 'TestProjectConfigTab'
+    project_id =3D None
=20
-    def setUp(self):
-        self.recipe =3D None
-        super().setUp()
-        release =3D '3'
-        project_name =3D 'projectmaster'
-        self._create_test_new_project(
-            project_name,
-            release,
-            False,
-        )
-
-    def _create_test_new_project(
-        self,
-        project_name,
-        release,
-        merge_toaster_settings,
-    ):
+    def _create_project(self, project_name):
         """ Create/Test new project using:
           - Project Name: Any string
           - Release: Any string
           - Merge Toaster settings: True or False
         """
         self.get(reverse('newproject'))
-        self.driver.find_element(By.ID,
-                                 "new-project-name").send_keys(project_n=
ame)
-
-        select =3D Select(self.find('#projectversion'))
-        select.select_by_value(release)
+        self.wait_until_visible('#new-project-name')
+        self.find("#new-project-name").send_keys(project_name)
+        select =3D Select(self.find("#projectversion"))
+        select.select_by_value('3')
=20
         # check merge toaster settings
         checkbox =3D self.find('.checkbox-mergeattr')
-        if merge_toaster_settings:
-            if not checkbox.is_selected():
-                checkbox.click()
+        if not checkbox.is_selected():
+            checkbox.click()
+
+        if self.PROJECT_NAME !=3D 'TestProjectConfigTab':
+            # Reset project name if it's not the default one
+            self.PROJECT_NAME =3D 'TestProjectConfigTab'
+
+        self.find("#create-project-button").click()
+
+        try:
+            self.wait_until_visible('#hint-error-project-name')
+            url =3D reverse('project', args=3D(TestProjectConfigTab.proj=
ect_id, ))
+            self.get(url)
+            self.wait_until_visible('#config-nav', poll=3D3)
+        except TimeoutException:
+            self.wait_until_visible('#config-nav', poll=3D3)
+
+    def _random_string(self, length):
+        return ''.join(
+            random.choice(string.ascii_letters) for _ in range(length)
+        )
+
+    def _navigate_to_project_page(self):
+        # Navigate to project page
+        if TestProjectConfigTab.project_id is None:
+            self._create_project(project_name=3Dself._random_string(10))
+            current_url =3D self.driver.current_url
+            TestProjectConfigTab.project_id =3D get_projectId_from_url(c=
urrent_url)
         else:
-            if checkbox.is_selected():
-                checkbox.click()
-
-        self.driver.find_element(By.ID, "create-project-button").click()
-
-    @classmethod
-    def _wait_until_build(cls, state):
-        while True:
-            try:
-                last_build_state =3D cls.driver.find_element(
-                    By.XPATH,
-                    '//*[@id=3D"latest-builds"]/div[1]//div[@class=3D"bu=
ild-state"]',
-                )
-                build_state =3D last_build_state.get_attribute(
-                    'data-build-state')
-                state_text =3D state.lower().split()
-                if any(x in str(build_state).lower() for x in state_text=
):
-                    break
-            except NoSuchElementException:
-                continue
-            sleep(1)
+            url =3D reverse('project', args=3D(TestProjectConfigTab.proj=
ect_id,))
+            self.get(url)
+        self.wait_until_visible('#config-nav')
=20
     def _create_builds(self):
         # check search box can be use to build recipes
         search_box =3D self.find('#build-input')
         search_box.send_keys('core-image-minimal')
         self.find('#build-button').click()
-        sleep(1)
         self.wait_until_visible('#latest-builds')
         # loop until reach the parsing state
-        self._wait_until_build('parsing starting cloning')
+        build_state =3D wait_until_build(self, 'parsing starting cloning=
')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div',
@@ -100,8 +94,9 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase)=
:
             '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
         )
         cancel_button.click()
-        sleep(1)
-        self._wait_until_build('cancelled')
+        if 'starting' not in build_state:  # change build state when can=
celled in starting state
+            wait_until_build_cancelled(self)
+        return build_state
=20
     def _get_tabs(self):
         # tabs links list
@@ -114,64 +109,6 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         config_nav =3D self.find('#config-nav')
         return config_nav.find_elements(By.TAG_NAME, 'li')[index]
=20
-    def _get_create_builds(self, **kwargs):
-        """ Create a build and return the build object """
-        # parameters for builds to associate with the projects
-        now =3D timezone.now()
-        release =3D '3'
-        project_name =3D 'projectmaster'
-        self._create_test_new_project(
-            project_name+"2",
-            release,
-            False,
-        )
-
-        self.project1_build_success =3D {
-            'project': Project.objects.get(id=3D1),
-            'started_on': now,
-            'completed_on': now,
-            'outcome': Build.SUCCEEDED
-        }
-
-        self.project1_build_failure =3D {
-            'project': Project.objects.get(id=3D1),
-            'started_on': now,
-            'completed_on': now,
-            'outcome': Build.FAILED
-        }
-        build1 =3D Build.objects.create(**self.project1_build_success)
-        build2 =3D Build.objects.create(**self.project1_build_failure)
-
-        # add some targets to these builds so they have recipe links
-        # (and so we can find the row in the ToasterTable corresponding =
to
-        # a particular build)
-        Target.objects.create(build=3Dbuild1, target=3D'foo')
-        Target.objects.create(build=3Dbuild2, target=3D'bar')
-
-        if kwargs:
-            # Create kwargs.get('success') builds with success status wi=
th target
-            # and kwargs.get('failure') builds with failure status with =
target
-            for i in range(kwargs.get('success', 0)):
-                now =3D timezone.now()
-                self.project1_build_success['started_on'] =3D now
-                self.project1_build_success[
-                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
-                build =3D Build.objects.create(**self.project1_build_suc=
cess)
-                Target.objects.create(build=3Dbuild,
-                                      target=3Df'{i}_success_recipe',
-                                      task=3Df'{i}_success_task')
-
-            for i in range(kwargs.get('failure', 0)):
-                now =3D timezone.now()
-                self.project1_build_failure['started_on'] =3D now
-                self.project1_build_failure[
-                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
-                build =3D Build.objects.create(**self.project1_build_fai=
lure)
-                Target.objects.create(build=3Dbuild,
-                                      target=3Df'{i}_fail_recipe',
-                                      task=3Df'{i}_fail_task')
-        return build1, build2
-
     def test_project_config_nav(self):
         """ Test project config tab navigation:
         - Check if the menu is displayed and contains the right elements=
:
@@ -188,13 +125,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
             - Actions
             - Delete project
         """
-        # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-
-        # check if the menu is displayed
-        self.wait_until_visible('#config-nav')
-
+        self._navigate_to_project_page()
         def _get_config_nav_item(index):
             config_nav =3D self.find('#config-nav')
             return config_nav.find_elements(By.TAG_NAME, 'li')[index]
@@ -221,14 +152,14 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
         self.assertTrue("actions" in str(actions.text).lower())
=20
         conf_nav_list =3D [
-            [0, 'Configuration', f"/toastergui/project/1"],  # config
-            [2, 'Custom images', f"/toastergui/project/1/customimages"],=
  # custom images
-            [3, 'Image recipes', f"/toastergui/project/1/images"],  # im=
age recipes
-            [4, 'Software recipes', f"/toastergui/project/1/softwarereci=
pes"],  # software recipes
-            [5, 'Machines', f"/toastergui/project/1/machines"],  # machi=
nes
-            [6, 'Layers', f"/toastergui/project/1/layers"],  # layers
-            [7, 'Distro', f"/toastergui/project/1/distro"],  # distro
-            [9, 'BitBake variables', f"/toastergui/project/1/configurati=
on"],  # bitbake variables
+            [0, 'Configuration', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}"],  # config
+            [2, 'Custom images', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}/customimages"],  # custom images
+            [3, 'Image recipes', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}/images"],  # image recipes
+            [4, 'Software recipes', f"/toastergui/project/{TestProjectCo=
nfigTab.project_id}/softwarerecipes"],  # software recipes
+            [5, 'Machines', f"/toastergui/project/{TestProjectConfigTab.=
project_id}/machines"],  # machines
+            [6, 'Layers', f"/toastergui/project/{TestProjectConfigTab.pr=
oject_id}/layers"],  # layers
+            [7, 'Distros', f"/toastergui/project/{TestProjectConfigTab.p=
roject_id}/distros"],  # distro
+            #  [9, 'BitBake variables', f"/toastergui/project/{TestProje=
ctConfigTab.project_id}/configuration"],  # bitbake variables
         ]
         for index, item_name, url in conf_nav_list:
             item =3D _get_config_nav_item(index)
@@ -236,6 +167,96 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
                 item.click()
             check_config_nav_item(index, item_name, url)
=20
+    def test_image_recipe_editColumn(self):
+        """ Test the edit column feature in image recipe table on projec=
t page """
+        def test_edit_column(check_box_id):
+            # Check that we can hide/show table column
+            check_box =3D self.find(f'#{check_box_id}')
+            th_class =3D str(check_box_id).replace('checkbox-', '')
+            if check_box.is_selected():
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+                check_box.click()
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+            else:
+                # check if column is hidden in table
+                self.assertFalse(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
+                )
+                check_box.click()
+                # check if column is visible in table
+                self.assertTrue(
+                    self.find(
+                        f'#imagerecipestable thead th.{th_class}'
+                    ).is_displayed(),
+                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
+                )
+
+        self._navigate_to_project_page()
+        # navigate to project image recipe page
+        recipe_image_page_link =3D self._get_config_nav_item(3)
+        recipe_image_page_link.click()
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        # Check edit column
+        edit_column =3D self.find('#edit-columns-button')
+        self.assertTrue(edit_column.is_displayed())
+        edit_column.click()
+        # Check dropdown is visible
+        self.wait_until_visible('ul.dropdown-menu.editcol')
+
+        # Check that we can hide the edit column
+        test_edit_column('checkbox-get_description_or_summary')
+        test_edit_column('checkbox-layer_version__get_vcs_reference')
+        test_edit_column('checkbox-layer_version__layer__name')
+        test_edit_column('checkbox-license')
+        test_edit_column('checkbox-recipe-file')
+        test_edit_column('checkbox-section')
+        test_edit_column('checkbox-version')
+
+    def test_image_recipe_show_rows(self):
+        """ Test the show rows feature in image recipe table on project =
page """
+        def test_show_rows(row_to_show, show_row_link):
+            # Check that we can show rows =3D=3D row_to_show
+            show_row_link.select_by_value(str(row_to_show))
+            self.wait_until_visible('#imagerecipestable tbody tr')
+            self.assertTrue(
+                len(self.find_all('#imagerecipestable tbody tr')) =3D=3D=
 row_to_show
+            )
+
+        self._navigate_to_project_page()
+        # navigate to project image recipe page
+        recipe_image_page_link =3D self._get_config_nav_item(3)
+        recipe_image_page_link.click()
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        show_rows =3D self.driver.find_elements(
+            By.XPATH,
+            '//select[@class=3D"form-control pagesize-imagerecipestable"=
]'
+        )
+        # Check show rows
+        for show_row_link in show_rows:
+            show_row_link =3D Select(show_row_link)
+            test_show_rows(10, show_row_link)
+            test_show_rows(25, show_row_link)
+            test_show_rows(50, show_row_link)
+            test_show_rows(100, show_row_link)
+            test_show_rows(150, show_row_link)
+
     def test_project_config_tab_right_section(self):
         """ Test project config tab right section contains five blocks:
             - Machine:
@@ -257,35 +278,36 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
                     - meta-poky
                     - meta-yocto-bsp
         """
-        # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-
+        # Create a new project for this test
+        project_name =3D self._random_string(10)
+        self._create_project(project_name=3Dproject_name)
+        current_url =3D self.driver.current_url
+        TestProjectConfigTab.project_id =3D get_projectId_from_url(curre=
nt_url)
+        url =3D current_url.split('?')[0]
         # check if the menu is displayed
         self.wait_until_visible('#project-page')
         block_l =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[2]')
-        machine =3D self.find('#machine-section')
-        distro =3D self.find('#distro-section')
         most_built_recipes =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
         project_release =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[4]')
         layers =3D block_l.find_element(By.ID, 'layer-container')
=20
-        def check_machine_distro(self, item_name, new_item_name, block):
+        def check_machine_distro(self, item_name, new_item_name, block_i=
d):
+            block =3D self.find(f'#{block_id}')
             title =3D block.find_element(By.TAG_NAME, 'h3')
             self.assertTrue(item_name.capitalize() in title.text)
-            edit_btn =3D block.find_element(By.ID, f'change-{item_name}-=
toggle')
+            edit_btn =3D self.find(f'#change-{item_name}-toggle')
             edit_btn.click()
-            sleep(1)
-            name_input =3D block.find_element(By.ID, f'{item_name}-chang=
e-input')
+            self.wait_until_visible(f'#{item_name}-change-input')
+            name_input =3D self.find(f'#{item_name}-change-input')
             name_input.clear()
             name_input.send_keys(new_item_name)
-            change_btn =3D block.find_element(By.ID, f'{item_name}-chang=
e-btn')
+            change_btn =3D self.find(f'#{item_name}-change-btn')
             change_btn.click()
-            sleep(1)
-            project_name =3D block.find_element(By.ID, f'project-{item_n=
ame}-name')
+            self.wait_until_visible(f'#project-{item_name}-name')
+            project_name =3D self.find(f'#project-{item_name}-name')
             self.assertTrue(new_item_name in project_name.text)
             # check change notificaiton is displayed
             change_notification =3D self.find('#change-notification')
@@ -293,10 +315,30 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
                 f'You have changed the {item_name} to: {new_item_name}' =
in change_notification.text
             )
=20
+        def rebuild_from_most_build_recipes(recipe_list_items):
+            checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, =
'input')
+            checkbox.click()
+            build_btn =3D self.find('#freq-build-btn')
+            build_btn.click()
+            self.wait_until_visible('#latest-builds')
+            build_state =3D wait_until_build(self, 'parsing starting clo=
ning queued')
+            lastest_builds =3D self.driver.find_elements(
+                By.XPATH,
+                '//div[@id=3D"latest-builds"]/div'
+            )
+            last_build =3D lastest_builds[0]
+            self.assertTrue(len(lastest_builds) >=3D 2)
+            cancel_button =3D last_build.find_element(
+                By.XPATH,
+                '//span[@class=3D"cancel-build-btn pull-right alert-link=
"]',
+            )
+            cancel_button.click()
+            if 'starting' not in build_state:  # change build state when=
 cancelled in starting state
+                wait_until_build_cancelled(self)
         # Machine
-        check_machine_distro(self, 'machine', 'qemux86-64', machine)
+        check_machine_distro(self, 'machine', 'qemux86-64', 'machine-sec=
tion')
         # Distro
-        check_machine_distro(self, 'distro', 'poky-altcfg', distro)
+        check_machine_distro(self, 'distro', 'poky-altcfg', 'distro-sect=
ion')
=20
         # Project release
         title =3D project_release.find_element(By.TAG_NAME, 'h3')
@@ -304,7 +346,6 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
         self.assertTrue(
             "Yocto Project master" in self.find('#project-release-title'=
).text
         )
-
         # Layers
         title =3D layers.find_element(By.TAG_NAME, 'h3')
         self.assertTrue("Layers" in title.text)
@@ -314,7 +355,9 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
         # meta-yocto-bsp
         layers_list =3D layers.find_element(By.ID, 'layers-in-project-li=
st')
         layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
-        self.assertTrue(len(layers_list_items) =3D=3D 3)
+        # remove all layers except the first three layers
+        for i in range(3, len(layers_list_items)):
+            layers_list_items[i].find_element(By.TAG_NAME, 'span').click=
()
         # check can add a layer if exists
         add_layer_input =3D layers.find_element(By.ID, 'layer-add-input'=
)
         add_layer_input.send_keys('meta-oe')
@@ -326,7 +369,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
         dropdown_item.click()
         add_layer_btn =3D layers.find_element(By.ID, 'add-layer-btn')
         add_layer_btn.click()
-        sleep(1)
+        self.wait_until_visible('#layers-in-project-list')
         # check layer is added
         layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
         self.assertTrue(len(layers_list_items) =3D=3D 4)
@@ -334,48 +377,33 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
         # Most built recipes
         title =3D most_built_recipes.find_element(By.TAG_NAME, 'h3')
         self.assertTrue("Most built recipes" in title.text)
-        # Create a new builds 5
-        self._create_builds()
+        # Create a new builds
+        build_state =3D self._create_builds()
=20
         # Refresh the page
-        self.get(url)
+        self.driver.get(url)
=20
-        sleep(1)  # wait for page to load
-        self.wait_until_visible('#project-page')
+        self.wait_until_visible('#project-page', poll=3D3)
         # check can select a recipe and build it
         most_built_recipes =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
         recipe_list =3D most_built_recipes.find_element(By.ID, 'freq-bui=
ld-list')
         recipe_list_items =3D recipe_list.find_elements(By.TAG_NAME, 'li=
')
-        self.assertTrue(
-            len(recipe_list_items) > 0,
-            msg=3D"No recipes found in the most built recipes list",
-        )
-        checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, 'inp=
ut')
-        checkbox.click()
-        build_btn =3D self.find('#freq-build-btn')
-        build_btn.click()
-        sleep(1)  # wait for page to load
-        self.wait_until_visible('#latest-builds')
-        self._wait_until_build('parsing starting cloning queueing')
-        lastest_builds =3D self.driver.find_elements(
-            By.XPATH,
-            '//div[@id=3D"latest-builds"]/div'
-        )
-        last_build =3D lastest_builds[0]
-        cancel_button =3D last_build.find_element(
-            By.XPATH,
-            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
-        )
-        cancel_button.click()
-        self.assertTrue(len(lastest_builds) =3D=3D 2)
+        if 'starting' not in build_state:  # Build will not appear in th=
e list if canceled in starting state
+            self.assertTrue(
+                len(recipe_list_items) > 0,
+                msg=3D"No recipes found in the most built recipes list",
+            )
+            rebuild_from_most_build_recipes(recipe_list_items)
+        else:
+            self.assertTrue(
+                len(recipe_list_items) =3D=3D 0,
+                msg=3D"Recipes found in the most built recipes list",
+            )
=20
     def test_project_page_tab_importlayer(self):
         """ Test project page tab import layer """
-        # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-
+        self._navigate_to_project_page()
         # navigate to "Import layers" tab
         import_layers_tab =3D self._get_tabs()[2]
         import_layers_tab.find_element(By.TAG_NAME, 'a').click()
@@ -415,10 +443,10 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
=20
     def test_project_page_custom_image_no_image(self):
         """ Test project page tab "New custom image" when no custom imag=
e """
-        # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-
+        project_name =3D self._random_string(10)
+        self._create_project(project_name=3Dproject_name)
+        current_url =3D self.driver.current_url
+        TestProjectConfigTab.project_id =3D get_projectId_from_url(curre=
nt_url)
         # navigate to "Custom image" tab
         custom_image_section =3D self._get_config_nav_item(2)
         custom_image_section.click()
@@ -433,8 +461,10 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         div_empty_msg =3D self.find('#empty-state-customimagestable')
         link_create_custom_image =3D div_empty_msg.find_element(
             By.TAG_NAME, 'a')
+        last_project_id =3D Project.objects.get(name=3Dproject_name).id
+        self.assertTrue(last_project_id is not None)
         self.assertTrue(
-            f"/toastergui/project/1/newcustomimage" in str(
+            f"/toastergui/project/{last_project_id}/newcustomimage" in s=
tr(
                 link_create_custom_image.get_attribute('href')
             )
         )
@@ -451,11 +481,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
             - Check image recipe build button works
             - Check image recipe table features(show/hide column, pagina=
tion)
         """
-        # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-        self.wait_until_visible('#config-nav')
-
+        self._navigate_to_project_page()
         # navigate to "Images section"
         images_section =3D self._get_config_nav_item(3)
         images_section.click()
@@ -479,100 +505,17 @@ class TestProjectConfigTab(SeleniumFunctionalTestC=
ase):
             '//td[@class=3D"add-del-layers"]'
         )
         build_btn.click()
-        self._wait_until_build('parsing starting cloning')
+        build_state =3D wait_until_build(self, 'parsing starting cloning=
 queued')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div'
         )
         self.assertTrue(len(lastest_builds) > 0)
-
-    def test_image_recipe_editColumn(self):
-        """ Test the edit column feature in image recipe table on projec=
t page """
-        self._get_create_builds(success=3D10, failure=3D10)
-
-        def test_edit_column(check_box_id):
-            # Check that we can hide/show table column
-            check_box =3D self.find(f'#{check_box_id}')
-            th_class =3D str(check_box_id).replace('checkbox-', '')
-            if check_box.is_selected():
-                # check if column is visible in table
-                self.assertTrue(
-                    self.find(
-                        f'#imagerecipestable thead th.{th_class}'
-                    ).is_displayed(),
-                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
-                )
-                check_box.click()
-                # check if column is hidden in table
-                self.assertFalse(
-                    self.find(
-                        f'#imagerecipestable thead th.{th_class}'
-                    ).is_displayed(),
-                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
-                )
-            else:
-                # check if column is hidden in table
-                self.assertFalse(
-                    self.find(
-                        f'#imagerecipestable thead th.{th_class}'
-                    ).is_displayed(),
-                    f"The {th_class} column is unchecked in EditColumn d=
ropdown, but it's visible in table"
-                )
-                check_box.click()
-                # check if column is visible in table
-                self.assertTrue(
-                    self.find(
-                        f'#imagerecipestable thead th.{th_class}'
-                    ).is_displayed(),
-                    f"The {th_class} column is checked in EditColumn dro=
pdown, but it's not visible in table"
-                )
-
-        url =3D reverse('projectimagerecipes', args=3D(1,))
-        self.get(url)
-        self.wait_until_present('#imagerecipestable tbody tr')
-
-        # Check edit column
-        edit_column =3D self.find('#edit-columns-button')
-        self.assertTrue(edit_column.is_displayed())
-        edit_column.click()
-        # Check dropdown is visible
-        self.wait_until_visible('ul.dropdown-menu.editcol')
-
-        # Check that we can hide the edit column
-        test_edit_column('checkbox-get_description_or_summary')
-        test_edit_column('checkbox-layer_version__get_vcs_reference')
-        test_edit_column('checkbox-layer_version__layer__name')
-        test_edit_column('checkbox-license')
-        test_edit_column('checkbox-recipe-file')
-        test_edit_column('checkbox-section')
-        test_edit_column('checkbox-version')
-
-    def test_image_recipe_show_rows(self):
-        """ Test the show rows feature in image recipe table on project =
page """
-        self._get_create_builds(success=3D100, failure=3D100)
-
-        def test_show_rows(row_to_show, show_row_link):
-            # Check that we can show rows =3D=3D row_to_show
-            show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_present('#imagerecipestable tbody tr')
-            sleep(1)
-            self.assertTrue(
-                len(self.find_all('#imagerecipestable tbody tr')) =3D=3D=
 row_to_show
-            )
-
-        url =3D reverse('projectimagerecipes', args=3D(2,))
-        self.get(url)
-        self.wait_until_present('#imagerecipestable tbody tr')
-
-        show_rows =3D self.driver.find_elements(
+        last_build =3D lastest_builds[0]
+        cancel_button =3D last_build.find_element(
             By.XPATH,
-            '//select[@class=3D"form-control pagesize-imagerecipestable"=
]'
+            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
         )
-        # Check show rows
-        for show_row_link in show_rows:
-            show_row_link =3D Select(show_row_link)
-            test_show_rows(10, show_row_link)
-            test_show_rows(25, show_row_link)
-            test_show_rows(50, show_row_link)
-            test_show_rows(100, show_row_link)
-            test_show_rows(150, show_row_link)
+        cancel_button.click()
+        if 'starting' not in build_state:  # change build state when can=
celled in starting state
+            wait_until_build_cancelled(self)
--=20
2.34.1


