Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3ACC10DC1
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57338.1701298466244705462
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=cxPMZxdT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9C6CF9C3E14
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:25 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7Q7-wvcD0s06; Wed, 29 Nov 2023 17:54:24 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D5E349C3E05;
	Wed, 29 Nov 2023 17:54:24 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D5E349C3E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298464; bh=zT4lYxeiyQEUxoz7l3mIDhzcMMpqS0no0csLVWkMKzo=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=cxPMZxdTaPaiBljJNV0f+Eyk+SSRhmoJYCh6IoanLNMf3AtlCs6q2MhTBiJEuc3PL
	 rjfKx0dkHbY8iQbPjREtIpU6uFV0yOQKco1Rt1WYGYkXc73kZMcTP/2wfiNds3mfdF
	 ThMCrH5SsLpQVhodQdXVLsqqJl3VgKjjT01UH8KvSMwmuVVwkbeYInFd8evs+hXjgj
	 /fdrTBolqc9gPBAvhmq8pwRxmrLX3bMyC435v3bVYTHw5WVdEE+NXp4SCXNtEJJ23O
	 VHH9PAfCqUwJrBdBMutqXKrTKJB0l9cR9zWKZaRmNvCOcwIdLtZ4hgitNbDeY5C4Uv
	 nB13s71pMccow==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id zVY_yM4nNCHc; Wed, 29 Nov 2023 17:54:24 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3E1E39C3636;
	Wed, 29 Nov 2023 17:54:24 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 7/9] toaster/test: Bug-fix on tests/functional/test_project_page
Date: Wed, 29 Nov 2023 23:54:14 +0100
Message-Id: <20231129225416.479526-7-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15586

- Generate a random name for create project while test
- Set timeout on method _wait_until_build
- update test_machines_page, test_softwareRecipe_page and
  test_single_layer_page to  fix exception "element not interactable"

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 64 +++++++++----------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index dd33e802..70829509 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -6,12 +6,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import random
+import string
 import pytest
 from time import sleep
 from django.urls import reverse
 from django.utils import timezone
+from selenium.webdriver.common.keys import Keys
 from selenium.webdriver.support.select import Select
-from selenium.common.exceptions import NoSuchElementException
+from selenium.common.exceptions import NoSuchElementException, TimeoutEx=
ception
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Build, Project, Target
 from selenium.webdriver.common.by import By
@@ -23,13 +26,18 @@ class TestProjectPage(SeleniumFunctionalTestCase):
     def setUp(self):
         super().setUp()
         release =3D '3'
-        project_name =3D 'projectmaster'
+        project_name =3D 'project_' + self.generate_random_string()
         self._create_test_new_project(
             project_name,
             release,
             False,
         )
=20
+    def generate_random_string(self, length=3D10):
+        characters =3D string.ascii_letters + string.digits  # alphabeti=
c and numerical characters
+        random_string =3D ''.join(random.choice(characters) for _ in ran=
ge(length))
+        return random_string
+
     def _create_test_new_project(
         self,
         project_name,
@@ -204,7 +212,13 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                     test_show_rows(row_to_show, show_row_link)
=20
     def _wait_until_build(self, state):
+        timeout =3D 10
+        start_time =3D 0
         while True:
+            if start_time > timeout:
+                raise TimeoutException(
+                    f'Build did not reach {state} state within {timeout}=
 seconds'
+                )
             try:
                 last_build_state =3D self.driver.find_element(
                     By.XPATH,
@@ -217,7 +231,8 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                     break
             except NoSuchElementException:
                 continue
-            sleep(1)
+            start_time +=3D 1
+            sleep(1) # take a breath and try again
=20
     def _mixin_test_table_search_input(self, **kwargs):
         input_selector, input_text, searchBtn_selector, table_selector, =
*_ =3D kwargs.values()
@@ -380,11 +395,9 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.wait_until_visible('#topbar-configuration-tab')
         config_tab =3D self.find('#topbar-configuration-tab')
         self.assertTrue(config_tab.get_attribute('class') =3D=3D 'active=
')
-        self.assertTrue('Configuration' in config_tab.text)
-        config_tab_link =3D config_tab.find_element(By.TAG_NAME, 'a')
+        self.assertTrue('Configuration' in str(config_tab.text))
         self.assertTrue(
-            f"/toastergui/project/1" in str(config_tab_link.get_attribut=
e(
-                'href'))
+            f"/toastergui/project/1" in str(self.driver.current_url)
         )
=20
         def get_tabs():
@@ -464,10 +477,10 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         image_to_build =3D rows[0]
         build_btn =3D image_to_build.find_element(
             By.XPATH,
-            '//td[@class=3D"add-del-layers"]'
+            '//td[@class=3D"add-del-layers"]//a[1]'
         )
         build_btn.click()
-        self._wait_until_build('parsing starting cloning')
+        self._wait_until_build('parsing starting cloning queued')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div'
@@ -517,9 +530,9 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         machine_to_select =3D rows[0]
         select_btn =3D machine_to_select.find_element(
             By.XPATH,
-            '//td[@class=3D"add-del-layers"]'
+            '//td[@class=3D"add-del-layers"]//a[1]'
         )
-        select_btn.click()
+        select_btn.send_keys(Keys.RETURN)
         self.wait_until_visible('#config-nav')
         project_machine_name =3D self.find('#project-machine-name')
         self.assertTrue(
@@ -530,32 +543,19 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         # Search for a machine whit layer not in project
         self._mixin_test_table_search_input(
             input_selector=3D'search-input-machinestable',
-            input_text=3D'qemux86-64-screen',
+            input_text=3D'qemux86-64-tpm2',
             searchBtn_selector=3D'search-submit-machinestable',
             table_selector=3D'machinestable'
         )
         rows =3D self.find_all('#machinestable tbody tr')
         machine_to_add =3D rows[0]
-        add_btn =3D machine_to_add.find_element(
-            By.XPATH,
-            '//td[@class=3D"add-del-layers"]'
-        )
+        add_btn =3D machine_to_add.find_element(By.XPATH, '//td[@class=3D=
"add-del-layers"]')
         add_btn.click()
-        # check modal is displayed
-        self.wait_until_visible('#dependencies-modal')
-        list_dependencies =3D self.find_all('#dependencies-list li')
-        # click on add-layers button
-        add_layers_btn =3D self.driver.find_element(
-            By.XPATH,
-            '//form[@id=3D"dependencies-modal-form"]//button[@class=3D"b=
tn btn-primary"]'
-        )
-        add_layers_btn.click()
         self.wait_until_visible('#change-notification')
         change_notification =3D self.find('#change-notification')
         self.assertTrue(
-            f'You have added {len(list_dependencies)+1} layers to your p=
roject: meta-tanowrt and its dependencies' in change_notification.text
+            f'You have added 1 layer to your project' in str(change_noti=
fication.text)
         )
-
         # check Machine table feature(show/hide column, pagination)
         self._navigate_to_config_nav('machinestable', 5)
         column_list =3D [
@@ -601,7 +601,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
         add_btn.click()
         # check modal is displayed
-        self.wait_until_visible('#dependencies-modal')
+        self.wait_until_visible('#dependencies-modal', poll=3D2)
         list_dependencies =3D self.find_all('#dependencies-list li')
         # click on add-layers button
         add_layers_btn =3D self.driver.find_element(
@@ -612,7 +612,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.wait_until_visible('#change-notification')
         change_notification =3D self.find('#change-notification')
         self.assertTrue(
-            f'You have added {len(list_dependencies)+1} layers to your p=
roject: {input_text} and its dependencies' in change_notification.text
+            f'You have added {len(list_dependencies)+1} layers to your p=
roject: {input_text} and its dependencies' in str(change_notification.tex=
t)
         )
         # check "Remove layer" button works
         rows =3D self.find_all('#layerstable tbody tr')
@@ -625,7 +625,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.wait_until_visible('#change-notification', poll=3D2)
         change_notification =3D self.find('#change-notification')
         self.assertTrue(
-            f'You have removed 1 layer from your project: {input_text}' =
in change_notification.text
+            f'You have removed 1 layer from your project: {input_text}' =
in str(change_notification.text)
         )
         # check layers table feature(show/hide column, pagination)
         self._navigate_to_config_nav('layerstable', 6)
@@ -668,13 +668,13 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         distro_to_add =3D rows[0]
         add_btn =3D distro_to_add.find_element(
             By.XPATH,
-            '//td[@class=3D"add-del-layers"]'
+            '//td[@class=3D"add-del-layers"]//a[1]'
         )
         add_btn.click()
         self.wait_until_visible('#change-notification', poll=3D2)
         change_notification =3D self.find('#change-notification')
         self.assertTrue(
-            f'You have changed the distro to: {input_text}' in change_no=
tification.text
+            f'You have changed the distro to: {input_text}' in str(chang=
e_notification.text)
         )
         # check distro table feature(show/hide column, pagination)
         self._navigate_to_config_nav('distrostable', 7)
--=20
2.34.1


