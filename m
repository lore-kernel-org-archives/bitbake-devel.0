Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67041C46CC6
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:53:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.10337.1702000412012238816
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:53:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Ue9lbHAC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 614B29C3472
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:53:31 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id qh65rWuGmMsy; Thu,  7 Dec 2023 20:53:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6C7E49C33BA;
	Thu,  7 Dec 2023 20:53:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6C7E49C33BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000410; bh=pJyjScw3mXtyLRKG9WPHEr3Itcgknnb5d0cPWyR7adI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Ue9lbHACEfOPH4zf+Hk2XE8tXKKs6w7Z2ULz6YDTJWafy44GgO46f7BdIqV6qWHUE
	 075oSmR4gcXC4F4p02yx1fxh56C0/aXFiZNAxsSszUGt2hcpvfhCxVP/N0oirzabbf
	 xVoRYI5xpP1uW8KQBbZ82ELdCq8rrNncmlMpQG12Vg3kwyVyRhHjfXOcCjYFhm0DOf
	 yMgzMQTZ8hr8SuJ6/fpZxhuq8/kDnfYirnVLnIXJiA7HWjljh7pe/oLw/IKW0bRjaW
	 bN9qvr84kLuxaDanVRxw+8kP3XNJNb5TpmbLxcBMwbp0fARV9LLUdpwj/ij0sr3Fm1
	 NEuc6fGz8Xh4g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P0qVIYudBQUf; Thu,  7 Dec 2023 20:53:30 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AF4109C3472;
	Thu,  7 Dec 2023 20:53:29 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/4] toaster/test: Bug fixes, functional tests dependent on each other
Date: Fri,  8 Dec 2023 02:53:19 +0100
Message-Id: <20231208015319.677993-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
References: <20231208015319.677993-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:53:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15637

refactor test_create_project and test_project_page to remove their depend=
encies

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     |   1 +
 .../tests/functional/test_project_page.py     | 164 +++++++++---------
 2 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index dc7d1fc2..bbda0cf4 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -16,6 +16,7 @@ from selenium.webdriver.common.by import By
=20
=20
 @pytest.mark.django_db
+@pytest.mark.order("last")
 class TestCreateNewProject(SeleniumFunctionalTestCase):
=20
     def _create_test_new_project(
diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 03f64f8f..077badb0 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -6,88 +6,89 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 import random
 import string
+from unittest import skip
 import pytest
-from time import sleep
 from django.urls import reverse
 from django.utils import timezone
 from selenium.webdriver.common.keys import Keys
 from selenium.webdriver.support.select import Select
-from selenium.common.exceptions import NoSuchElementException, TimeoutEx=
ception
+from selenium.common.exceptions import TimeoutException
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Build, Project, Target
 from selenium.webdriver.common.by import By
=20
+from .utils import get_projectId_from_url, wait_until_build, wait_until_=
build_cancelled
+
=20
 @pytest.mark.django_db
+@pytest.mark.order("last")
 class TestProjectPage(SeleniumFunctionalTestCase):
+    project_id =3D None
+    PROJECT_NAME =3D 'TestProjectPage'
=20
-    def setUp(self):
-        super().setUp()
-        release =3D '3'
-        project_name =3D 'project_' + self.generate_random_string()
-        self._create_test_new_project(
-            project_name,
-            release,
-            False,
-        )
-
-    def generate_random_string(self, length=3D10):
-        characters =3D string.ascii_letters + string.digits  # alphabeti=
c and numerical characters
-        random_string =3D ''.join(random.choice(characters) for _ in ran=
ge(length))
-        return random_string
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
+        if self.PROJECT_NAME !=3D 'TestProjectPage':
+            # Reset project name if it's not the default one
+            self.PROJECT_NAME =3D 'TestProjectPage'
+
+        self.find("#create-project-button").click()
+
+        try:
+            self.wait_until_visible('#hint-error-project-name')
+            url =3D reverse('project', args=3D(TestProjectPage.project_i=
d, ))
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
+        if TestProjectPage.project_id is None:
+            self._create_project(project_name=3Dself._random_string(10))
+            current_url =3D self.driver.current_url
+            TestProjectPage.project_id =3D get_projectId_from_url(curren=
t_url)
         else:
-            if checkbox.is_selected():
-                checkbox.click()
-
-        self.driver.find_element(By.ID, "create-project-button").click()
+            url =3D reverse('project', args=3D(TestProjectPage.project_i=
d,))
+            self.get(url)
+        self.wait_until_visible('#config-nav')
=20
     def _get_create_builds(self, **kwargs):
         """ Create a build and return the build object """
         # parameters for builds to associate with the projects
         now =3D timezone.now()
-        release =3D '3'
-        project_name =3D 'projectmaster'
-        self._create_test_new_project(
-            project_name+"2",
-            release,
-            False,
-        )
-
         self.project1_build_success =3D {
-            'project': Project.objects.get(id=3D1),
+            'project': Project.objects.get(id=3DTestProjectPage.project_=
id),
             'started_on': now,
             'completed_on': now,
             'outcome': Build.SUCCEEDED
         }
=20
         self.project1_build_failure =3D {
-            'project': Project.objects.get(id=3D1),
+            'project': Project.objects.get(id=3DTestProjectPage.project_=
id),
             'started_on': now,
             'completed_on': now,
             'outcome': Build.FAILED
@@ -180,9 +181,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
=20
     def _navigate_to_config_nav(self, nav_id, nav_index):
         # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
-        self.wait_until_visible('#config-nav')
+        self._navigate_to_project_page()
         # click on "Software recipe" tab
         soft_recipe =3D self._get_config_nav_item(nav_index)
         soft_recipe.click()
@@ -211,29 +210,6 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 if row_to_show not in to_skip:
                     test_show_rows(row_to_show, show_row_link)
=20
-    def _wait_until_build(self, state):
-        timeout =3D 10
-        start_time =3D 0
-        while True:
-            if start_time > timeout:
-                raise TimeoutException(
-                    f'Build did not reach {state} state within {timeout}=
 seconds'
-                )
-            try:
-                last_build_state =3D self.driver.find_element(
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
-            start_time +=3D 1
-            sleep(1) # take a breath and try again
-
     def _mixin_test_table_search_input(self, **kwargs):
         input_selector, input_text, searchBtn_selector, table_selector, =
*_ =3D kwargs.values()
         # Test search input
@@ -245,11 +221,19 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         rows =3D self.find_all(f'#{table_selector} tbody tr')
         self.assertTrue(len(rows) > 0)
=20
+    def test_create_project(self):
+        """ Create/Test new project using:
+          - Project Name: Any string
+          - Release: Any string
+          - Merge Toaster settings: True or False
+        """
+        self._create_project(project_name=3Dself.PROJECT_NAME)
+
     def test_image_recipe_editColumn(self):
         """ Test the edit column feature in image recipe table on projec=
t page """
         self._get_create_builds(success=3D10, failure=3D10)
=20
-        url =3D reverse('projectimagerecipes', args=3D(1,))
+        url =3D reverse('projectimagerecipes', args=3D(TestProjectPage.p=
roject_id,))
         self.get(url)
         self.wait_until_present('#imagerecipestable tbody tr')
=20
@@ -276,8 +260,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
           - AT RIGHT -> button "New project", displayed, clickable
         """
         # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
+        self._navigate_to_project_page()
=20
         # check page header
         # AT LEFT -> Logo of Yocto project
@@ -360,8 +343,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
           - Check project name is changed
         """
         # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
+        self._navigate_to_project_page()
=20
         # click on "Edit" icon button
         self.wait_until_visible('#project-name-container')
@@ -388,8 +370,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
           Check search box used to build recipes
         """
         # navigate to the project page
-        url =3D reverse("project", args=3D(1,))
-        self.get(url)
+        self._navigate_to_project_page()
=20
         # check "configuration" tab
         self.wait_until_visible('#topbar-configuration-tab')
@@ -397,7 +378,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue(config_tab.get_attribute('class') =3D=3D 'active=
')
         self.assertTrue('Configuration' in str(config_tab.text))
         self.assertTrue(
-            f"/toastergui/project/1" in str(self.driver.current_url)
+            f"/toastergui/project/{TestProjectPage.project_id}" in str(s=
elf.driver.current_url)
         )
=20
         def get_tabs():
@@ -420,7 +401,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             1,
             'Builds',
-            f"/toastergui/project/1/builds"
+            f"/toastergui/project/{TestProjectPage.project_id}/builds"
         )
=20
         # check "Import layers" tab
@@ -429,7 +410,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             2,
             'Import layer',
-            f"/toastergui/project/1/importlayer"
+            f"/toastergui/project/{TestProjectPage.project_id}/importlay=
er"
         )
=20
         # check "New custom image" tab
@@ -438,7 +419,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         check_tab_link(
             3,
             'New custom image',
-            f"/toastergui/project/1/newcustomimage"
+            f"/toastergui/project/{TestProjectPage.project_id}/newcustom=
image"
         )
=20
         # check search box can be use to build recipes
@@ -480,12 +461,20 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             '//td[@class=3D"add-del-layers"]//a[1]'
         )
         build_btn.click()
-        self._wait_until_build('parsing starting cloning queued')
+        build_state =3D wait_until_build(self, 'parsing starting cloning=
 queued')
         lastest_builds =3D self.driver.find_elements(
             By.XPATH,
             '//div[@id=3D"latest-builds"]/div'
         )
         self.assertTrue(len(lastest_builds) > 0)
+        last_build =3D lastest_builds[0]
+        cancel_button =3D last_build.find_element(
+            By.XPATH,
+            '//span[@class=3D"cancel-build-btn pull-right alert-link"]',
+        )
+        cancel_button.click()
+        if 'starting' not in build_state:  # change build state when can=
celled in starting state
+            wait_until_build_cancelled(self)
=20
         # check software recipe table feature(show/hide column, paginati=
on)
         self._navigate_to_config_nav('softwarerecipestable', 4)
@@ -547,6 +536,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             searchBtn_selector=3D'search-submit-machinestable',
             table_selector=3D'machinestable'
         )
+        self.wait_until_visible('#machinestable tbody tr', poll=3D3)
         rows =3D self.find_all('#machinestable tbody tr')
         machine_to_add =3D rows[0]
         add_btn =3D machine_to_add.find_element(By.XPATH, '//td[@class=3D=
"add-del-layers"]')
@@ -593,6 +583,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             table_selector=3D'layerstable'
         )
         # check "Add layer" button works
+        self.wait_until_visible('#layerstable tbody tr', poll=3D3)
         rows =3D self.find_all('#layerstable tbody tr')
         layer_to_add =3D rows[0]
         add_btn =3D layer_to_add.find_element(
@@ -601,7 +592,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         )
         add_btn.click()
         # check modal is displayed
-        self.wait_until_visible('#dependencies-modal', poll=3D2)
+        self.wait_until_visible('#dependencies-modal', poll=3D3)
         list_dependencies =3D self.find_all('#dependencies-list li')
         # click on add-layers button
         add_layers_btn =3D self.driver.find_element(
@@ -615,6 +606,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             f'You have added {len(list_dependencies)+1} layers to your p=
roject: {input_text} and its dependencies' in str(change_notification.tex=
t)
         )
         # check "Remove layer" button works
+        self.wait_until_visible('#layerstable tbody tr', poll=3D3)
         rows =3D self.find_all('#layerstable tbody tr')
         layer_to_remove =3D rows[0]
         remove_btn =3D layer_to_remove.find_element(
@@ -706,7 +698,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 - Check layer summary
                 - Check layer description
         """
-        url =3D reverse("layerdetails", args=3D(1, 8))
+        url =3D reverse("layerdetails", args=3D(TestProjectPage.project_=
id, 8))
         self.get(url)
         self.wait_until_visible('.page-header')
         # check title is displayed
@@ -765,7 +757,7 @@ class TestProjectPage(SeleniumFunctionalTestCase):
                 - Check recipe: name, summary, description, Version, Sec=
tion,
                 License, Approx. packages included, Approx. size, Recipe=
 file
         """
-        url =3D reverse("recipedetails", args=3D(1, 53428))
+        url =3D reverse("recipedetails", args=3D(TestProjectPage.project=
_id, 53428))
         self.get(url)
         self.wait_until_visible('.page-header')
         # check title is displayed
--=20
2.34.1


