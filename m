Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A6FC46CA3
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:12:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41459.1702591932816268560
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:12:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ABsyIjQy;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 322DD9C40FA
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:12:12 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Ic5bjrbNcNNV; Thu, 14 Dec 2023 17:12:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 248E09C36B1;
	Thu, 14 Dec 2023 17:12:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 248E09C36B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591931; bh=8zZGUgXyv3I+GhyhYGfRkmBWkWzuQntx4Quq9pgEfp8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ABsyIjQyjQy6+LJ/D776G/Jzexc9jvZA371YQe+pvH6iPj6Ql2oHUO+EAfIScVtZb
	 Np3JyI5v9osXLa9m1OJ0zbtqofJHDO/N/SfswtIOHvYLz5grv3de0IC5vD3r6K+Vuh
	 pLqLGz4mK/7PHtYyHjuPtIm/HGvzpiGFM1Zw/ydhzhh/oerSfJ4VOI+HAHW8Ja0Jz4
	 oEaVlgAvKRm6uA0zBqIo5uPjfEo+4TAyNwkmA2lbMKj84vIB9Yd0H5ioLcClXkFtIM
	 8abCa1EjeVSP2zOLK9XmmCKnw+LoYSuHKmPQbBOfJR7dEnuZ8Z9KwmGKHEk5G5sKNy
	 ZKIsZmTrwD5WQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2l8S7u00khYc; Thu, 14 Dec 2023 17:12:11 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 536879C40F4;
	Thu, 14 Dec 2023 17:12:10 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 6/6] toaster/test: Bug-Fix testcase bitbake/lib/toaster/tests/functional/test_project_page_tab_config.py
Date: Thu, 14 Dec 2023 23:11:57 +0100
Message-Id: <20231214221157.604253-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
References: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:12:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15681

All issues and failures stemmed from a specific test case:
test_project_config_tab_right_section in the file
bitbake/lib/toaster/tests/functional/test_project_page_tab_config.py.

This test was designed to verify whether the "Most built recipes"
section on the project page correctly displays the latest and oldest
recipes built by the user, irrespective of the build outcome (failed,
        cancelled, succeeded, or errored).

The errors and failures arose because the build process did not
terminate as expected, particularly when attempting to build recipe
images such as "core-image-minimal" or "bash." It was discovered that
building a real recipe/image was unnecessary for the test's purpose.
Instead, building a fake recipe like "foo" provided a reliable way to
ensure the build would fail or be interrupted.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     |   2 +-
 .../test_project_page_tab_config.py           | 186 +++++++++---------
 2 files changed, 95 insertions(+), 93 deletions(-)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 077badb0..82dca442 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -461,7 +461,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             '//td[@class=3D"add-del-layers"]//a[1]'
         )
         build_btn.click()
-        build_state =3D wait_until_build(self, 'parsing starting cloning=
 queued')
+        build_state =3D wait_until_build(self, 'queued cloning starting =
parsing failed')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div'
diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index d911ff00..4dbf5aeb 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -12,7 +12,7 @@ import pytest
 from django.urls import reverse
 from selenium.webdriver import Keys
 from selenium.webdriver.support.select import Select
-from selenium.common.exceptions import TimeoutException
+from selenium.common.exceptions import NoSuchElementException, TimeoutEx=
ception
 from orm.models import Project
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from selenium.webdriver.common.by import By
@@ -26,17 +26,18 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
     PROJECT_NAME =3D 'TestProjectConfigTab'
     project_id =3D None
=20
-    def _create_project(self, project_name):
+    def _create_project(self, project_name, **kwargs):
         """ Create/Test new project using:
           - Project Name: Any string
           - Release: Any string
           - Merge Toaster settings: True or False
         """
+        release =3D kwargs.get('release', '3')
         self.get(reverse('newproject'))
         self.wait_until_visible('#new-project-name')
         self.find("#new-project-name").send_keys(project_name)
         select =3D Select(self.find("#projectversion"))
-        select.select_by_value('3')
+        select.select_by_value(release)
=20
         # check merge toaster settings
         checkbox =3D self.find('.checkbox-mergeattr')
@@ -50,7 +51,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         self.find("#create-project-button").click()
=20
         try:
-            self.wait_until_visible('#hint-error-project-name')
+            self.wait_until_visible('#hint-error-project-name', poll=3D3=
)
             url =3D reverse('project', args=3D(TestProjectConfigTab.proj=
ect_id, ))
             self.get(url)
             self.wait_until_visible('#config-nav', poll=3D3)
@@ -67,7 +68,8 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase):
         if TestProjectConfigTab.project_id is None:
             self._create_project(project_name=3Dself._random_string(10))
             current_url =3D self.driver.current_url
-            TestProjectConfigTab.project_id =3D get_projectId_from_url(c=
urrent_url)
+            TestProjectConfigTab.project_id =3D get_projectId_from_url(
+                current_url)
         else:
             url =3D reverse('project', args=3D(TestProjectConfigTab.proj=
ect_id,))
             self.get(url)
@@ -76,27 +78,30 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
     def _create_builds(self):
         # check search box can be use to build recipes
         search_box =3D self.find('#build-input')
-        search_box.send_keys('core-image-minimal')
+        search_box.send_keys('foo')
         self.find('#build-button').click()
-        self.wait_until_visible('#latest-builds')
+        self.wait_until_present('#latest-builds')
         # loop until reach the parsing state
-        build_state =3D wait_until_build(self, 'parsing starting cloning=
')
+        wait_until_build(self, 'queued cloning starting parsing failed')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div',
         )
         last_build =3D lastest_builds[0]
         self.assertTrue(
-            'core-image-minimal' in str(last_build.text)
+            'foo' in str(last_build.text)
         )
-        cancel_button =3D last_build.find_element(
-            By.XPATH,
-            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
-        )
-        cancel_button.click()
-        if 'starting' not in build_state:  # change build state when can=
celled in starting state
-            wait_until_build_cancelled(self)
-        return build_state
+        last_build =3D lastest_builds[0]
+        try:
+            cancel_button =3D last_build.find_element(
+                By.XPATH,
+                '//span[@class=3D"cancel-build-btn pull-right alert-link=
"]',
+            )
+            cancel_button.click()
+        except NoSuchElementException:
+            # Skip if the build is already cancelled
+            pass
+        wait_until_build_cancelled(self)
=20
     def _get_tabs(self):
         # tabs links list
@@ -126,6 +131,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
             - Delete project
         """
         self._navigate_to_project_page()
+
         def _get_config_nav_item(index):
             config_nav =3D self.find('#config-nav')
             return config_nav.find_elements(By.TAG_NAME, 'li')[index]
@@ -152,13 +158,27 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
         self.assertTrue("actions" in str(actions.text).lower())
=20
         conf_nav_list =3D [
-            [0, 'Configuration', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}"],  # config
-            [2, 'Custom images', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}/customimages"],  # custom images
-            [3, 'Image recipes', f"/toastergui/project/{TestProjectConfi=
gTab.project_id}/images"],  # image recipes
-            [4, 'Software recipes', f"/toastergui/project/{TestProjectCo=
nfigTab.project_id}/softwarerecipes"],  # software recipes
-            [5, 'Machines', f"/toastergui/project/{TestProjectConfigTab.=
project_id}/machines"],  # machines
-            [6, 'Layers', f"/toastergui/project/{TestProjectConfigTab.pr=
oject_id}/layers"],  # layers
-            [7, 'Distros', f"/toastergui/project/{TestProjectConfigTab.p=
roject_id}/distros"],  # distro
+            # config
+            [0, 'Configuration',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}"=
],
+            # custom images
+            [2, 'Custom images',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
customimages"],
+            # image recipes
+            [3, 'Image recipes',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
images"],
+            # software recipes
+            [4, 'Software recipes',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
softwarerecipes"],
+            # machines
+            [5, 'Machines',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
machines"],
+            # layers
+            [6, 'Layers',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
layers"],
+            # distro
+            [7, 'Distros',
+                f"/toastergui/project/{TestProjectConfigTab.project_id}/=
distros"],
             #  [9, 'BitBake variables', f"/toastergui/project/{TestProje=
ctConfigTab.project_id}/configuration"],  # bitbake variables
         ]
         for index, item_name, url in conf_nav_list:
@@ -281,15 +301,10 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
         # Create a new project for this test
         project_name =3D self._random_string(10)
         self._create_project(project_name=3Dproject_name)
-        current_url =3D self.driver.current_url
-        TestProjectConfigTab.project_id =3D get_projectId_from_url(curre=
nt_url)
-        url =3D current_url.split('?')[0]
         # check if the menu is displayed
         self.wait_until_visible('#project-page')
         block_l =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[2]')
-        most_built_recipes =3D self.driver.find_element(
-            By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
         project_release =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[4]')
         layers =3D block_l.find_element(By.ID, 'layer-container')
@@ -315,26 +330,6 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
                 f'You have changed the {item_name} to: {new_item_name}' =
in change_notification.text
             )
=20
-        def rebuild_from_most_build_recipes(recipe_list_items):
-            checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, =
'input')
-            checkbox.click()
-            build_btn =3D self.find('#freq-build-btn')
-            build_btn.click()
-            self.wait_until_visible('#latest-builds')
-            build_state =3D wait_until_build(self, 'parsing starting clo=
ning queued')
-            lastest_builds =3D self.driver.find_elements(
-                By.XPATH,
-                '//div[@id=3D"latest-builds"]/div'
-            )
-            last_build =3D lastest_builds[0]
-            self.assertTrue(len(lastest_builds) >=3D 2)
-            cancel_button =3D last_build.find_element(
-                By.XPATH,
-                '//span[@class=3D"cancel-build-btn pull-right alert-link=
"]',
-            )
-            cancel_button.click()
-            if 'starting' not in build_state:  # change build state when=
 cancelled in starting state
-                wait_until_build_cancelled(self)
         # Machine
         check_machine_distro(self, 'machine', 'qemux86-64', 'machine-sec=
tion')
         # Distro
@@ -374,32 +369,61 @@ class TestProjectConfigTab(SeleniumFunctionalTestCa=
se):
         layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
         self.assertTrue(len(layers_list_items) =3D=3D 4)
=20
-        # Most built recipes
-        title =3D most_built_recipes.find_element(By.TAG_NAME, 'h3')
-        self.assertTrue("Most built recipes" in title.text)
+    def test_most_build_recipes(self):
+        """ Test most build recipes block contains"""
+        def rebuild_from_most_build_recipes(recipe_list_items):
+            checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, =
'input')
+            checkbox.click()
+            build_btn =3D self.find('#freq-build-btn')
+            build_btn.click()
+            self.wait_until_present('#latest-builds')
+            wait_until_build(self, 'queued cloning starting parsing fail=
ed')
+            lastest_builds =3D self.driver.find_elements(
+                By.XPATH,
+                '//div[@id=3D"latest-builds"]/div'
+            )
+            self.assertTrue(len(lastest_builds) >=3D 2)
+            last_build =3D lastest_builds[0]
+            try:
+                cancel_button =3D last_build.find_element(
+                    By.XPATH,
+                    '//span[@class=3D"cancel-build-btn pull-right alert-=
link"]',
+                )
+                cancel_button.click()
+            except NoSuchElementException:
+                # Skip if the build is already cancelled
+                pass
+            wait_until_build_cancelled(self)
+        # Create a new project for remaining asserts
+        project_name =3D self._random_string(10)
+        self._create_project(project_name=3Dproject_name, release=3D'2')
+        current_url =3D self.driver.current_url
+        TestProjectConfigTab.project_id =3D get_projectId_from_url(curre=
nt_url)
+        url =3D current_url.split('?')[0]
+
         # Create a new builds
-        build_state =3D self._create_builds()
+        self._create_builds()
=20
-        # Refresh the page
+        # back to project page
         self.driver.get(url)
=20
         self.wait_until_visible('#project-page', poll=3D3)
-        # check can select a recipe and build it
+
+        # Most built recipes
         most_built_recipes =3D self.driver.find_element(
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
-        recipe_list =3D most_built_recipes.find_element(By.ID, 'freq-bui=
ld-list')
+        title =3D most_built_recipes.find_element(By.TAG_NAME, 'h3')
+        self.assertTrue("Most built recipes" in title.text)
+        # check can select a recipe and build it
+        self.wait_until_visible('#freq-build-list', poll=3D3)
+        recipe_list =3D self.find('#freq-build-list')
         recipe_list_items =3D recipe_list.find_elements(By.TAG_NAME, 'li=
')
-        if 'starting' not in build_state:  # Build will not appear in th=
e list if canceled in starting state
-            self.assertTrue(
-                len(recipe_list_items) > 0,
-                msg=3D"No recipes found in the most built recipes list",
-            )
-            rebuild_from_most_build_recipes(recipe_list_items)
-        else:
-            self.assertTrue(
-                len(recipe_list_items) =3D=3D 0,
-                msg=3D"Recipes found in the most built recipes list",
-            )
+        self.assertTrue(
+            len(recipe_list_items) > 0,
+            msg=3D"Any recipes found in the most built recipes list",
+        )
+        rebuild_from_most_build_recipes(recipe_list_items)
+        TestProjectConfigTab.project_id =3D None  # reset project id
=20
     def test_project_page_tab_importlayer(self):
         """ Test project page tab import layer """
@@ -461,10 +485,9 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         div_empty_msg =3D self.find('#empty-state-customimagestable')
         link_create_custom_image =3D div_empty_msg.find_element(
             By.TAG_NAME, 'a')
-        last_project_id =3D Project.objects.get(name=3Dproject_name).id
-        self.assertTrue(last_project_id is not None)
+        self.assertTrue(TestProjectConfigTab.project_id is not None)
         self.assertTrue(
-            f"/toastergui/project/{last_project_id}/newcustomimage" in s=
tr(
+            f"/toastergui/project/{TestProjectConfigTab.project_id}/newc=
ustomimage" in str(
                 link_create_custom_image.get_attribute('href')
             )
         )
@@ -473,6 +496,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
                 link_create_custom_image.text
             )
         )
+        TestProjectConfigTab.project_id =3D None  # reset project id
=20
     def test_project_page_image_recipe(self):
         """ Test project page section images
@@ -497,25 +521,3 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         self.wait_until_visible('#imagerecipestable tbody tr')
         rows =3D self.find_all('#imagerecipestable tbody tr')
         self.assertTrue(len(rows) > 0)
-
-        # Test build button
-        image_to_build =3D rows[0]
-        build_btn =3D image_to_build.find_element(
-            By.XPATH,
-            '//td[@class=3D"add-del-layers"]'
-        )
-        build_btn.click()
-        build_state =3D wait_until_build(self, 'parsing starting cloning=
 queued')
-        lastest_builds =3D self.driver.find_elements(
-            By.XPATH,
-            '//div[@id=3D"latest-builds"]/div'
-        )
-        self.assertTrue(len(lastest_builds) > 0)
-        last_build =3D lastest_builds[0]
-        cancel_button =3D last_build.find_element(
-            By.XPATH,
-            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
-        )
-        cancel_button.click()
-        if 'starting' not in build_state:  # change build state when can=
celled in starting state
-            wait_until_build_cancelled(self)
--=20
2.34.1


