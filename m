Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477FCC61D96
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:40 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.40843.1700574697823412119
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=WpgzwcuQ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2D80D9C3496
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:37 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id q5YJ0FhZdkKT; Tue, 21 Nov 2023 08:51:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5AA0B9C3373;
	Tue, 21 Nov 2023 08:51:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5AA0B9C3373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574696; bh=Y6q0/szke9Hv2egvcEYhi57k18HN1LYA/zjUDnTHL0U=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=WpgzwcuQ6rCeh8KPENVy9fu73XT/5wcJ5qof/L90bCitux8cJnnCjtr6nmD66zXmf
	 cM1e72qkyoks9xLih2TdEDoKE6hynRo7gc9CtGiQHW0ib7m1Q6drFui+LMDpan555X
	 K6xMIs1hMCd15E02ARerf+V5/GCVn0pmOmpnoceR+6dCkvlDS0ufs5LGndqLR2j4mL
	 5ZnDVGKgrfuZF11/JKrexQtkMYKiE+zrK6sqqawslEs9nyXtfJ9FyF+zazw3zZ1Y35
	 Itc0Qi4jI5bvbZCCAZHX+GBYl2vB+oiUiMfdMxmUmSPUKKBWNCu/wh+btKi2Z7A9Nk
	 BmbWla/yN73/Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uQpBDCse_YXv; Tue, 21 Nov 2023 08:51:36 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5BC1B9C2B49;
	Tue, 21 Nov 2023 08:51:35 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/7] Toaster: Write UI TestCase -> Test project config tab navigation:
Date: Tue, 21 Nov 2023 14:51:25 +0100
Message-Id: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15552

- Check if the menu is displayed and contains the right elements:
    - Configuration
    - COMPATIBLE METADATA
    - Custom images
    - Image recipes
    - Software recipes
    - Machines
    - Layers
    - Distro
    - EXTRA CONFIGURATION
    - Bitbake variables
    - Actions
    - Delete project

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 lib/toaster/tests/functional/test_project_page_tab_co=
nfig.py

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
new file mode 100644
index 00000000..f0c6aacf
--- /dev/null
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -0,0 +1,176 @@
+#! /usr/bin/env python3 #
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from time import sleep
+import pytest
+from django.urls import reverse
+from selenium.webdriver.support.select import Select
+from selenium.common.exceptions import NoSuchElementException
+from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
+from selenium.webdriver.common.by import By
+
+
+@pytest.mark.django_db
+class TestProjectConfigTab(SeleniumFunctionalTestCase):
+
+    def setUp(self):
+        self.recipe =3D None
+        super().setUp()
+        release =3D '3'
+        project_name =3D 'projectmaster'
+        self._create_test_new_project(
+            project_name,
+            release,
+            False,
+        )
+
+    def _create_test_new_project(
+        self,
+        project_name,
+        release,
+        merge_toaster_settings,
+    ):
+        """ Create/Test new project using:
+          - Project Name: Any string
+          - Release: Any string
+          - Merge Toaster settings: True or False
+        """
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(release)
+
+        # check merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if merge_toaster_settings:
+            if not checkbox.is_selected():
+                checkbox.click()
+        else:
+            if checkbox.is_selected():
+                checkbox.click()
+
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+    @classmethod
+    def _wait_until_build(cls, state):
+        while True:
+            try:
+                last_build_state =3D cls.driver.find_element(
+                    By.XPATH,
+                    '//*[@id=3D"latest-builds"]/div[1]//div[@class=3D"bu=
ild-state"]',
+                )
+                build_state =3D last_build_state.get_attribute(
+                    'data-build-state')
+                state_text =3D state.lower().split()
+                if any(x in str(build_state).lower() for x in state_text=
):
+                    break
+            except NoSuchElementException:
+                continue
+            sleep(1)
+
+    def _create_builds(self):
+        # check search box can be use to build recipes
+        search_box =3D self.find('#build-input')
+        search_box.send_keys('core-image-minimal')
+        self.find('#build-button').click()
+        sleep(1)
+        self.wait_until_visible('#latest-builds')
+        # loop until reach the parsing state
+        self._wait_until_build('parsing starting cloning')
+        lastest_builds =3D self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"latest-builds"]/div',
+        )
+        last_build =3D lastest_builds[0]
+        self.assertTrue(
+            'core-image-minimal' in str(last_build.text)
+        )
+        cancel_button =3D last_build.find_element(
+            By.XPATH,
+            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
+        )
+        cancel_button.click()
+        sleep(1)
+        self._wait_until_build('cancelled')
+
+    def _get_tabs(self):
+        # tabs links list
+        return self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"project-topbar"]//li'
+        )
+
+    def _get_config_nav_item(self, index):
+        config_nav =3D self.find('#config-nav')
+        return config_nav.find_elements(By.TAG_NAME, 'li')[index]
+
+    def test_project_config_nav(self):
+        """ Test project config tab navigation:
+        - Check if the menu is displayed and contains the right elements=
:
+            - Configuration
+            - COMPATIBLE METADATA
+            - Custom images
+            - Image recipes
+            - Software recipes
+            - Machines
+            - Layers
+            - Distro
+            - EXTRA CONFIGURATION
+            - Bitbake variables
+            - Actions
+            - Delete project
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # check if the menu is displayed
+        self.wait_until_visible('#config-nav')
+
+        def _get_config_nav_item(index):
+            config_nav =3D self.find('#config-nav')
+            return config_nav.find_elements(By.TAG_NAME, 'li')[index]
+
+        def check_config_nav_item(index, item_name, url):
+            item =3D _get_config_nav_item(index)
+            self.assertTrue(item_name in item.text)
+            self.assertTrue(item.get_attribute('class') =3D=3D 'active')
+            self.assertTrue(url in self.driver.current_url)
+
+        # check if the menu contains the right elements
+        # COMPATIBLE METADATA
+        compatible_metadata =3D _get_config_nav_item(1)
+        self.assertTrue(
+            "compatible metadata" in compatible_metadata.text.lower()
+        )
+        # EXTRA CONFIGURATION
+        extra_configuration =3D _get_config_nav_item(8)
+        self.assertTrue(
+            "extra configuration" in extra_configuration.text.lower()
+        )
+        # Actions
+        actions =3D _get_config_nav_item(10)
+        self.assertTrue("actions" in str(actions.text).lower())
+
+        conf_nav_list =3D [
+            [0, 'Configuration', f"/toastergui/project/1"],  # config
+            [2, 'Custom images', f"/toastergui/project/1/customimages"],=
  # custom images
+            [3, 'Image recipes', f"/toastergui/project/1/images"],  # im=
age recipes
+            [4, 'Software recipes', f"/toastergui/project/1/softwarereci=
pes"],  # software recipes
+            [5, 'Machines', f"/toastergui/project/1/machines"],  # machi=
nes
+            [6, 'Layers', f"/toastergui/project/1/layers"],  # layers
+            [7, 'Distro', f"/toastergui/project/1/distro"],  # distro
+            [9, 'BitBake variables', f"/toastergui/project/1/configurati=
on"],  # bitbake variables
+        ]
+        for index, item_name, url in conf_nav_list:
+            item =3D _get_config_nav_item(index)
+            if item.get_attribute('class') !=3D 'active':
+                item.click()
+            check_config_nav_item(index, item_name, url)
--=20
2.34.1


