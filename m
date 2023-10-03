Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA7E7542B
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 17:26:34 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.114301.1696353990819912465
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 10:26:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=fb2HreXa;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9A8849C28CB
	for <bitbake-devel@lists.openembedded.org>; Tue,  3 Oct 2023 13:26:29 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8aeteCXOT6_w; Tue,  3 Oct 2023 13:26:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7750E9C2980;
	Tue,  3 Oct 2023 13:26:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7750E9C2980
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1696353986; bh=SqCm0HXg6toSdJeM72ee2fL+hZbfxUmRXFqjJJV45vQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=fb2HreXaV/RD6wFQ8RZe5qvnZgRiWMIPUX47vRZUutdEUzarjjkb/M2s3pY4cCE8h
	 KI+uWOpBlyq2GJxIEPrFuWru3KDGDP0VFI9xN83tlWXMZHeYGlBJaNO08F1qIiqlq+
	 /8N/aT3qnCjq7foZb/834NxVAH+Av5MmQuBDwgJlBIfCSZLXGAR9PM0u9nUINc8Wyd
	 /z8tBZqMrQECqzqoivF3qvdzWiip02clskh6BylFAwu1B8M+vHG+sHnFAUO7BR6KnG
	 DKfoCo5rKGmecTaOy5LnVZZTpQxWWR2eZ7mod+WTT45UpAKXjosEOUuV9f/CQs2WyL
	 atpVKvFVBwqLg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lBGdpGE8pjE2; Tue,  3 Oct 2023 13:26:26 -0400 (EDT)
Received: from savoirfairelinux.hitronhub.home (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 492AB9C28CB;
	Tue,  3 Oct 2023 13:26:26 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH 1/1] toaster:update selenium version and code syntax
Date: Tue,  3 Oct 2023 13:26:23 -0400
Message-Id: <20231003172623.72071-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 17:26:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15177

Updated selenium version to latest 4.13.0, changed selenum specific versi=
on syntax elements to accomplish test success

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/toaster/orm/models.py                     |   2 +-
 .../tests/browser/selenium_helpers_base.py    |   9 +-
 .../tests/browser/test_all_builds_page.py     |  26 ++--
 .../tests/browser/test_all_projects_page.py   |  14 +-
 .../tests/browser/test_builddashboard_page.py |  10 +-
 .../browser/test_most_recent_builds_states.py |  12 +-
 .../browser/test_new_custom_image_page.py     |   4 +
 .../tests/browser/test_new_project_page.py    |  12 +-
 .../tests/browser/test_project_config_page.py |  29 +++--
 .../tests/browser/test_toastertable_ui.py     |   7 +-
 .../tests/builds/test_core_image_min.py       |   1 +
 .../tests/functional/functional_helpers.py    |  21 +--
 .../tests/functional/test_functional_basic.py | 120 +++++++++---------
 .../tests/toaster-tests-requirements.txt      |   2 +-
 lib/toaster/tests/views/test_views.py         |   4 +
 lib/toaster/toastergui/widgets.py             |   1 +
 16 files changed, 156 insertions(+), 118 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f9fcf9e4..0d503a51 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1733,7 +1733,7 @@ class CustomImageRecipe(Recipe):
         packages_conf +=3D "\""
=20
         base_recipe_path =3D self.get_base_recipe_file()
-        if base_recipe_path:
+        if base_recipe_path and os.path.isfile(base_recipe_path):
             base_recipe =3D open(base_recipe_path, 'r').read()
         else:
             # Pass back None to trigger error message to user
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index 644d45fe..9a4e27a3 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -21,6 +21,7 @@ import unittest
=20
 from selenium import webdriver
 from selenium.webdriver.support.ui import WebDriverWait
+from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabi=
lities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException
@@ -32,9 +33,7 @@ def create_selenium_driver(cls,browser=3D'chrome'):
         browser =3D env_browser
=20
     if browser =3D=3D 'chrome':
-        return webdriver.Chrome(
-            service_args=3D["--verbose", "--log-path=3Dselenium.log"]
-        )
+        return webdriver.Chrome()
     elif browser =3D=3D 'firefox':
         return webdriver.Firefox()
     elif browser =3D=3D 'marionette':
@@ -153,11 +152,11 @@ class SeleniumTestCaseBase(unittest.TestCase):
=20
     def find(self, selector):
         """ Find single element by CSS selector """
-        return self.driver.find_element_by_css_selector(selector)
+        return self.driver.find_element(By.CSS_SELECTOR, selector)
=20
     def find_all(self, selector):
         """ Find all elements matching CSS selector """
-        return self.driver.find_elements_by_css_selector(selector)
+        return self.driver.find_elements(By.CSS_SELECTOR, selector)
=20
     def element_exists(self, selector):
         """
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index 8423d3da..d4312bb3 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -7,7 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-import re
+import re, time
=20
 from django.urls import reverse
 from django.utils import timezone
@@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import SeleniumTest=
Case
=20
 from orm.models import BitbakeVersion, Release, Project, Build, Target
=20
+from selenium.webdriver.common.by import By
+
=20
 class TestAllBuildsPage(SeleniumTestCase):
     """ Tests for all builds page /builds/ """
@@ -91,7 +93,7 @@ class TestAllBuildsPage(SeleniumTestCase):
         found_row =3D None
         for row in rows:
=20
-            outcome_links =3D row.find_elements_by_css_selector(selector=
)
+            outcome_links =3D row.find_elements(By.CSS_SELECTOR, selecto=
r)
             if len(outcome_links) =3D=3D 1:
                 found_row =3D row
                 break
@@ -131,17 +133,19 @@ class TestAllBuildsPage(SeleniumTestCase):
         url =3D reverse('all-builds')
         self.get(url)
=20
+        # should see a rebuild button for non-command-line builds
+        selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 % build1.id
+        time.sleep(2)
+        run_again_button =3D self.find_all(selector)
+        self.assertEqual(len(run_again_button), 1,
+                         'should see a rebuild button for non-cli builds=
')
+
         # shouldn't see a rebuild button for command-line builds
         selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 % default_build.id
         run_again_button =3D self.find_all(selector)
         self.assertEqual(len(run_again_button), 0,
                          'should not see a rebuild button for cli builds=
')
=20
-        # should see a rebuild button for non-command-line builds
-        selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 % build1.id
-        run_again_button =3D self.find_all(selector)
-        self.assertEqual(len(run_again_button), 1,
-                         'should see a rebuild button for non-cli builds=
')
=20
     def test_tooltips_on_project_name(self):
         """
@@ -198,24 +202,24 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         # test recent builds area for successful build
         element =3D self._get_build_time_element(build1)
-        links =3D element.find_elements_by_css_selector('a')
+        links =3D element.find_elements(By.CSS_SELECTOR, 'a')
         msg =3D 'should be a link on the build time for a successful rec=
ent build'
         self.assertEquals(len(links), 1, msg)
=20
         # test recent builds area for failed build
         element =3D self._get_build_time_element(build2)
-        links =3D element.find_elements_by_css_selector('a')
+        links =3D element.find_elements(By.CSS_SELECTOR, 'a')
         msg =3D 'should not be a link on the build time for a failed rec=
ent build'
         self.assertEquals(len(links), 0, msg)
=20
         # test the time column for successful build
         build1_row =3D self._get_row_for_build(build1)
-        links =3D build1_row.find_elements_by_css_selector('td.time a')
+        links =3D build1_row.find_elements(By.CSS_SELECTOR, 'td.time a')
         msg =3D 'should be a link on the build time for a successful bui=
ld'
         self.assertEquals(len(links), 1, msg)
=20
         # test the time column for failed build
         build2_row =3D self._get_row_for_build(build2)
-        links =3D build2_row.find_elements_by_css_selector('td.time a')
+        links =3D build2_row.find_elements(By.CSS_SELECTOR, 'td.time a')
         msg =3D 'should not be a link on the build time for a failed bui=
ld'
         self.assertEquals(len(links), 0, msg)
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index 15b03400..3389d323 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -16,6 +16,8 @@ from tests.browser.selenium_helpers import SeleniumTest=
Case
 from orm.models import BitbakeVersion, Release, Project, Build
 from orm.models import ProjectVariable
=20
+from selenium.webdriver.common.by import By
+
 class TestAllProjectsPage(SeleniumTestCase):
     """ Browser tests for projects page /projects/ """
=20
@@ -117,7 +119,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the release text for the default project
         selector =3D 'span[data-project-field=3D"release"] span.text-mut=
ed'
-        element =3D default_project_row.find_element_by_css_selector(sel=
ector)
+        element =3D default_project_row.find_element(By.CSS_SELECTOR, se=
lector)
         text =3D element.text.strip()
         self.assertEqual(text, 'Not applicable',
                          'release should be "not applicable" for default=
 project')
@@ -127,7 +129,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the link in the release cell for the other project
         selector =3D 'span[data-project-field=3D"release"]'
-        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
+        element =3D other_project_row.find_element(By.CSS_SELECTOR, sele=
ctor)
         text =3D element.text.strip()
         self.assertEqual(text, self.release.name,
                          'release name should be shown for non-default p=
roject')
@@ -152,7 +154,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the machine cell for the default project
         selector =3D 'span[data-project-field=3D"machine"] span.text-mut=
ed'
-        element =3D default_project_row.find_element_by_css_selector(sel=
ector)
+        element =3D default_project_row.find_element(By.CSS_SELECTOR, se=
lector)
         text =3D element.text.strip()
         self.assertEqual(text, 'Not applicable',
                          'machine should be not applicable for default p=
roject')
@@ -162,7 +164,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the link in the machine cell for the other project
         selector =3D 'span[data-project-field=3D"machine"]'
-        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
+        element =3D other_project_row.find_element(By.CSS_SELECTOR, sele=
ctor)
         text =3D element.text.strip()
         self.assertEqual(text, self.MACHINE_NAME,
                          'machine name should be shown for non-default p=
roject')
@@ -187,7 +189,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the link on the name field
         selector =3D 'span[data-project-field=3D"name"] a'
-        element =3D default_project_row.find_element_by_css_selector(sel=
ector)
+        element =3D default_project_row.find_element(By.CSS_SELECTOR, se=
lector)
         link_url =3D element.get_attribute('href').strip()
         expected_url =3D reverse('projectbuilds', args=3D(self.default_p=
roject.id,))
         msg =3D 'link on default project name should point to builds but=
 was %s' % link_url
@@ -198,7 +200,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         # check the link for the other project
         selector =3D 'span[data-project-field=3D"name"] a'
-        element =3D other_project_row.find_element_by_css_selector(selec=
tor)
+        element =3D other_project_row.find_element(By.CSS_SELECTOR, sele=
ctor)
         link_url =3D element.get_attribute('href').strip()
         expected_url =3D reverse('project', args=3D(self.project.id,))
         msg =3D 'link on project name should point to configuration but =
was %s' % link_url
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/=
toaster/tests/browser/test_builddashboard_page.py
index efcd89b3..1afa4a4d 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -15,6 +15,8 @@ from tests.browser.selenium_helpers import SeleniumTest=
Case
 from orm.models import Project, Release, BitbakeVersion, Build, LogMessa=
ge
 from orm.models import Layer, Layer_Version, Recipe, CustomImageRecipe, =
Variable
=20
+from selenium.webdriver.common.by import By
+
 class TestBuildDashboardPage(SeleniumTestCase):
     """ Tests for the build dashboard /build/X """
=20
@@ -183,7 +185,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
=20
         found =3D False
         for element in message_elements:
-            log_message_text =3D element.find_element_by_tag_name('pre')=
.text.strip()
+            log_message_text =3D element.find_element(By.TAG_NAME, 'pre'=
).text.strip()
             text_matches =3D (log_message_text =3D=3D expected_text)
=20
             log_message_pk =3D element.get_attribute('data-log-message-i=
d')
@@ -213,7 +215,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
         the WebElement modal match the list of text values in expected
         """
         # labels containing the radio buttons we're testing for
-        labels =3D modal.find_elements_by_css_selector(".radio")
+        labels =3D modal.find_elements(By.CSS_SELECTOR,".radio")
=20
         labels_text =3D [lab.text for lab in labels]
         self.assertEqual(len(labels_text), len(expected))
@@ -248,7 +250,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
         selector =3D '[data-role=3D"edit-custom-image-trigger"]'
         self.click(selector)
=20
-        modal =3D self.driver.find_element_by_id('edit-custom-image-moda=
l')
+        modal =3D self.driver.find_element(By.ID, 'edit-custom-image-mod=
al')
         self.wait_until_visible("#edit-custom-image-modal")
=20
         # recipes we expect to see in the edit custom image modal
@@ -270,7 +272,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
         selector =3D '[data-role=3D"new-custom-image-trigger"]'
         self.click(selector)
=20
-        modal =3D self.driver.find_element_by_id('new-custom-image-modal=
')
+        modal =3D self.driver.find_element(By.ID,'new-custom-image-modal=
')
         self.wait_until_visible("#new-custom-image-modal")
=20
         # recipes we expect to see in the new custom image modal
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py =
b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index 7844aaa3..a34a0928 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -6,7 +6,7 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
-
+import time
 from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
@@ -14,6 +14,8 @@ from tests.browser.selenium_helpers_base import Wait
 from orm.models import Project, Build, Task, Recipe, Layer, Layer_Versio=
n
 from bldcontrol.models import BuildRequest
=20
+from selenium.webdriver.common.by import By
+
 class TestMostRecentBuildsStates(SeleniumTestCase):
     """ Test states update correctly in most recent builds area """
=20
@@ -62,7 +64,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         element =3D self.wait_until_visible(selector)
=20
         bar_selector =3D '#recipes-parsed-percentage-bar-%s' % build.id
-        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
+        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
         self.assertEqual(bar_element.value_of_css_property('width'), '0p=
x',
             'recipe parse progress should be at 0')
=20
@@ -73,7 +75,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         self.get(url)
=20
         element =3D self.wait_until_visible(selector)
-        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
+        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
         recipe_bar_updated =3D lambda driver: \
             bar_element.get_attribute('style') =3D=3D 'width: 50%;'
         msg =3D 'recipe parse progress bar should update to 50%'
@@ -107,7 +109,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         element =3D self.wait_until_visible(selector)
=20
         bar_selector =3D '#build-pc-done-bar-%s' % build.id
-        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
+        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
=20
         task_bar_updated =3D lambda driver: \
             bar_element.get_attribute('style') =3D=3D 'width: 50%;'
@@ -121,7 +123,7 @@ class TestMostRecentBuildsStates(SeleniumTestCase):
         self.get(url)
=20
         element =3D self.wait_until_visible(selector)
-        bar_element =3D element.find_element_by_css_selector(bar_selecto=
r)
+        bar_element =3D element.find_element(By.CSS_SELECTOR, bar_select=
or)
         task_bar_updated =3D lambda driver: \
             bar_element.get_attribute('style') =3D=3D 'width: 100%;'
         msg =3D 'tasks progress bar should update to 100%'
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/li=
b/toaster/tests/browser/test_new_custom_image_page.py
index 9906ae42..6361f403 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -6,6 +6,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
+from bldcontrol.models import BuildEnvironment
=20
 from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
@@ -18,6 +19,9 @@ class TestNewCustomImagePage(SeleniumTestCase):
     CUSTOM_IMAGE_NAME =3D 'roopa-doopa'
=20
     def setUp(self):
+        BuildEnvironment.objects.get_or_create(
+            betype=3DBuildEnvironment.TYPE_LOCAL,
+        )
         release =3D Release.objects.create(
             name=3D'baz',
             bitbake_version=3DBitbakeVersion.objects.create(name=3D'v1')
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toa=
ster/tests/browser/test_new_project_page.py
index e20a1f68..f4b2708f 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -6,11 +6,13 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
+import time
=20
 from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 from selenium.webdriver.support.ui import Select
 from selenium.common.exceptions import InvalidElementStateException
+from selenium.webdriver.common.by import By
=20
 from orm.models import Project, Release, BitbakeVersion
=20
@@ -47,13 +49,14 @@ class TestNewProjectPage(SeleniumTestCase):
=20
         url =3D reverse('newproject')
         self.get(url)
-
         self.enter_text('#new-project-name', project_name)
=20
         select =3D Select(self.find('#projectversion'))
         select.select_by_value(str(self.release.pk))
=20
+        time.sleep(1)
         self.click("#create-project-button")
+        time.sleep(2)
=20
         # We should get redirected to the new project's page with the
         # notification at the top
@@ -84,6 +87,12 @@ class TestNewProjectPage(SeleniumTestCase):
         select =3D Select(self.find('#projectversion'))
         select.select_by_value(str(self.release.pk))
=20
+        radio =3D self.driver.find_element(By.ID, 'type-new')
+        radio.click()
+
+        self.click("#create-project-button")
+        time.sleep(2)
+
         element =3D self.wait_until_visible('#hint-error-project-name')
=20
         self.assertTrue(("Project names must be unique" in element.text)=
,
@@ -96,6 +105,7 @@ class TestNewProjectPage(SeleniumTestCase):
         except InvalidElementStateException:
             pass
=20
+        time.sleep(2)
         self.assertTrue(
             (Project.objects.filter(name=3Dproject_name).count() =3D=3D =
1),
             "New project not found in database")
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/=
toaster/tests/browser/test_project_config_page.py
index 944bcb26..7b21460e 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -11,6 +11,7 @@ from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import BitbakeVersion, Release, Project, ProjectVariable
+from selenium.webdriver.common.by import By
=20
 class TestProjectConfigsPage(SeleniumTestCase):
     """ Test data at /project/X/builds is displayed correctly """
@@ -66,7 +67,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
=20
         self.enter_text('#new-imagefs_types', imagefs_type)
=20
-        checkboxes =3D self.driver.find_elements_by_xpath("//input[@clas=
s=3D'fs-checkbox-fstypes']")
+        checkboxes =3D self.driver.find_elements(By.XPATH, "//input[@cla=
ss=3D'fs-checkbox-fstypes']")
=20
         for checkbox in checkboxes:
             if checkbox.get_attribute("value") =3D=3D "btrfs":
@@ -95,7 +96,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
         for checkbox in checkboxes:
             if checkbox.get_attribute("value") =3D=3D "cpio":
                checkbox.click()
-               element =3D self.driver.find_element_by_id('new-imagefs_t=
ypes')
+               element =3D self.driver.find_element(By.ID, 'new-imagefs_=
types')
=20
                self.wait_until_visible('#new-imagefs_types')
=20
@@ -129,7 +130,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
=20
         # downloads dir path has a space
-        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.driver.find_element(By.ID, 'new-dl_dir').clear()
         self.enter_text('#new-dl_dir', '/foo/bar a')
=20
         element =3D self.wait_until_visible('#hintError-dl_dir')
@@ -137,7 +138,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
=20
         # downloads dir path starts with ${...} but has a space
-        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
         self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
=20
         element =3D self.wait_until_visible('#hintError-dl_dir')
@@ -145,18 +146,18 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
=20
         # downloads dir path starts with /
-        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
         self.enter_text('#new-dl_dir', '/bar/foo')
=20
-        hidden_element =3D self.driver.find_element_by_id('hintError-dl_=
dir')
+        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
         self.assertEqual(hidden_element.is_displayed(), False,
             'downloads directory path valid but treated as invalid')
=20
         # downloads dir path starts with ${...}
-        self.driver.find_element_by_id('new-dl_dir').clear()
+        self.driver.find_element(By.ID,'new-dl_dir').clear()
         self.enter_text('#new-dl_dir', '${TOPDIR}/down')
=20
-        hidden_element =3D self.driver.find_element_by_id('hintError-dl_=
dir')
+        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
         self.assertEqual(hidden_element.is_displayed(), False,
             'downloads directory path valid but treated as invalid')
=20
@@ -184,7 +185,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
=20
         # path has a space
-        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
         self.enter_text('#new-sstate_dir', '/foo/bar a')
=20
         element =3D self.wait_until_visible('#hintError-sstate_dir')
@@ -192,7 +193,7 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
=20
         # path starts with ${...} but has a space
-        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.driver.find_element(By.ID,'new-sstate_dir').clear()
         self.enter_text('#new-sstate_dir', '${TOPDIR}/down foo')
=20
         element =3D self.wait_until_visible('#hintError-sstate_dir')
@@ -200,18 +201,18 @@ class TestProjectConfigsPage(SeleniumTestCase):
         self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
=20
         # path starts with /
-        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.driver.find_element(By.ID,'new-sstate_dir').clear()
         self.enter_text('#new-sstate_dir', '/bar/foo')
=20
-        hidden_element =3D self.driver.find_element_by_id('hintError-sst=
ate_dir')
+        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
         self.assertEqual(hidden_element.is_displayed(), False,
             'sstate directory path valid but treated as invalid')
=20
         # paths starts with ${...}
-        self.driver.find_element_by_id('new-sstate_dir').clear()
+        self.driver.find_element(By.ID, 'new-sstate_dir').clear()
         self.enter_text('#new-sstate_dir', '${TOPDIR}/down')
=20
-        hidden_element =3D self.driver.find_element_by_id('hintError-sst=
ate_dir')
+        hidden_element =3D self.driver.find_element(By.ID, 'hintError-ss=
tate_dir')
         self.assertEqual(hidden_element.is_displayed(), False,
             'sstate directory path valid but treated as invalid')
=20
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toas=
ter/tests/browser/test_toastertable_ui.py
index e82d5ec6..e00c30a8 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -13,6 +13,7 @@ from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
 from orm.models import BitbakeVersion, Release, Project, Build
+from selenium.webdriver.common.by import By
=20
 class TestToasterTableUI(SeleniumTestCase):
     """
@@ -33,7 +34,7 @@ class TestToasterTableUI(SeleniumTestCase):
         table: WebElement for a ToasterTable
         """
         selector =3D 'thead a.sorted'
-        heading =3D table.find_element_by_css_selector(selector)
+        heading =3D table.find_element(By.CSS_SELECTOR, selector)
         return heading.get_attribute('innerHTML').strip()
=20
     def _get_datetime_from_cell(self, row, selector):
@@ -45,7 +46,7 @@ class TestToasterTableUI(SeleniumTestCase):
         selector: CSS selector to use to find the cell containing the da=
te time
         string
         """
-        cell =3D row.find_element_by_css_selector(selector)
+        cell =3D row.find_element(By.CSS_SELECTOR, selector)
         cell_text =3D cell.get_attribute('innerHTML').strip()
         return datetime.strptime(cell_text, '%d/%m/%y %H:%M')
=20
@@ -105,7 +106,7 @@ class TestToasterTableUI(SeleniumTestCase):
         self.click('#checkbox-started_on')
=20
         # sort by started_on column
-        links =3D table.find_elements_by_css_selector('th.started_on a')
+        links =3D table.find_elements(By.CSS_SELECTOR, 'th.started_on a'=
)
         for link in links:
             if link.get_attribute('innerHTML').strip() =3D=3D 'Started o=
n':
                 link.click()
diff --git a/lib/toaster/tests/builds/test_core_image_min.py b/lib/toaste=
r/tests/builds/test_core_image_min.py
index 44b6cbec..9cdaa15f 100644
--- a/lib/toaster/tests/builds/test_core_image_min.py
+++ b/lib/toaster/tests/builds/test_core_image_min.py
@@ -26,6 +26,7 @@ class BuildCoreImageMinimal(BuildTest):
=20
     def setUp(self):
         self.completed_build =3D self.build("core-image-minimal")
+        self.built =3D self.target_already_built("core-image-minimal")
=20
     # Check if build name is unique - tc_id=3D795
     def test_Build_Unique_Name(self):
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toa=
ster/tests/functional/functional_helpers.py
index 5c4ea717..c3191f66 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -16,6 +16,9 @@ import re
=20
 from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
 from tests.builds.buildtest import load_build_environment
+from bldcontrol.models import BuildEnvironment
+from selenium.webdriver.common.by import By
+from selenium.common.exceptions import NoSuchElementException
=20
 logger =3D logging.getLogger("toaster")
=20
@@ -30,6 +33,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             raise RuntimeError("Please initialise django with the tests =
settings:  " \
                 "DJANGO_SETTINGS_MODULE=3D'toastermain.settings_test'")
=20
+        if BuildEnvironment.objects.count() =3D=3D 0:
+            BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
         load_build_environment()
=20
         # start toaster
@@ -74,8 +79,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
         """
         try:
             table_element =3D self.get_table_element(table_id)
-            element =3D table_element.find_element_by_link_text(link_tex=
t)
-        except self.NoSuchElementException:
+            element =3D table_element.find_element(By.LINK_TEXT, link_te=
xt)
+        except NoSuchElementException:
             print('no element found')
             raise
         return element
@@ -85,8 +90,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
 #return whole-table element
             element_xpath =3D "//*[@id=3D'" + table_id + "']"
             try:
-                element =3D self.driver.find_element_by_xpath(element_xp=
ath)
-            except self.NoSuchElementException:
+                element =3D self.driver.find_element(By.XPATH, element_x=
path)
+            except NoSuchElementException:
                 raise
             return element
         row =3D coordinate[0]
@@ -95,8 +100,8 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase)=
:
 #return whole-row element
             element_xpath =3D "//*[@id=3D'" + table_id + "']/tbody/tr[" =
+ str(row) + "]"
             try:
-                element =3D self.driver.find_element_by_xpath(element_xp=
ath)
-            except self.NoSuchElementException:
+                element =3D self.driver.find_element(By.XPATH, element_x=
path)
+            except NoSuchElementException:
                 return False
             return element
 #now we are looking for an element with specified X and Y
@@ -104,7 +109,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase=
):
=20
         element_xpath =3D "//*[@id=3D'" + table_id + "']/tbody/tr[" + st=
r(row) + "]/td[" + str(column) + "]"
         try:
-            element =3D self.driver.find_element_by_xpath(element_xpath)
-        except self.NoSuchElementException:
+            element =3D self.driver.find_element(By.XPATH, element_xpath=
)
+        except NoSuchElementException:
             return False
         return element
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/=
toaster/tests/functional/test_functional_basic.py
index 5683e387..067ad99a 100644
--- a/lib/toaster/tests/functional/test_functional_basic.py
+++ b/lib/toaster/tests/functional/test_functional_basic.py
@@ -10,6 +10,7 @@
 import re
 from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
 from orm.models import Project
+from selenium.webdriver.common.by import By
=20
 class FuntionalTestBasic(SeleniumFunctionalTestCase):
=20
@@ -17,10 +18,10 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
     def test_create_slenium_project(self):
         project_name =3D 'selenium-project'
         self.get('')
-        self.driver.find_element_by_link_text("To start building, create=
 your first Toaster project").click()
-        self.driver.find_element_by_id("new-project-name").send_keys(pro=
ject_name)
-        self.driver.find_element_by_id('projectversion').click()
-        self.driver.find_element_by_id("create-project-button").click()
+        self.driver.find_element(By.LINK_TEXT, "To start building, creat=
e your first Toaster project").click()
+        self.driver.find_element(By.ID, "new-project-name").send_keys(pr=
oject_name)
+        self.driver.find_element(By.ID, 'projectversion').click()
+        self.driver.find_element(By.ID, "create-project-button").click()
         element =3D self.wait_until_visible('#project-created-notificati=
on')
         self.assertTrue(self.element_exists('#project-created-notificati=
on'),'Project creation notification not shown')
         self.assertTrue(project_name in element.text,
@@ -35,77 +36,77 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase):
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         self.assertTrue(self.element_exists('#config-nav'),'Configuratio=
n Tab does not exist')
         project_URL=3Dself.get_URL()
-        self.driver.find_element_by_xpath('//a[@href=3D"'+project_URL+'"=
]').click()
+        self.driver.find_element(By.XPATH, '//a[@href=3D"'+project_URL+'=
"]').click()
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
-            self.assertTrue(re.search("Custom images",self.driver.find_e=
lement_by_xpath("//div[@class=3D'col-md-10']").text),'Custom images infor=
mation is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'customimages/"'+"]").click()
+            self.assertTrue(re.search("Custom images",self.driver.find_e=
lement(By.XPATH, "//div[@class=3D'col-md-10']").text),'Custom images info=
rmation is not loading properly')
         except:
             self.fail(msg=3D'No Custom images tab available')
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element_by_xpath("//div[@class=3D'col-md-10']").text),'The Comp=
atible image recipes information is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
+            self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Com=
patible image recipes information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible image tab available')
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
-            self.assertTrue(re.search("Compatible software recipes",self=
.driver.find_element_by_xpath("//div[@class=3D'col-md-10']").text),'The C=
ompatible software recipe information is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'softwarerecipes/"'+"]").click()
+            self.assertTrue(re.search("Compatible software recipes",self=
.driver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The =
Compatible software recipe information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible software recipe tab available=
')
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'machines/"'+"]").click()
-            self.assertTrue(re.search("Compatible machines",self.driver.=
find_element_by_xpath("//div[@class=3D'col-md-10']").text),'The Compatibl=
e machine information is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'machines/"'+"]").click()
+            self.assertTrue(re.search("Compatible machines",self.driver.=
find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatib=
le machine information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible machines tab available')
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]").click()
-            self.assertTrue(re.search("Compatible layers",self.driver.fi=
nd_element_by_xpath("//div[@class=3D'col-md-10']").text),'The Compatible =
layer information is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'layers/"'+"]").click()
+            self.assertTrue(re.search("Compatible layers",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Compatible=
 layer information is not loading properly')
         except:
             self.fail(msg=3D'No Compatible layers tab available')
=20
         try:
-            self.driver.find_element_by_xpath("//*[@id=3D'config-nav']/u=
l/li/a[@href=3D"+'"'+project_URL+'configuration"'+"]").click()
-            self.assertTrue(re.search("Bitbake variables",self.driver.fi=
nd_element_by_xpath("//div[@class=3D'col-md-10']").text),'The Bitbake var=
iables information is not loading properly')
+            self.driver.find_element(By.XPATH, "//*[@id=3D'config-nav']/=
ul/li/a[@href=3D"+'"'+project_URL+'configuration"'+"]").click()
+            self.assertTrue(re.search("Bitbake variables",self.driver.fi=
nd_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Bitbake va=
riables information is not loading properly')
         except:
             self.fail(msg=3D'No Bitbake variables tab available')
=20
 #   testcase (1516)
     def test_review_configuration_information(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
=20
         try:
            self.assertTrue(self.element_exists('#machine-section'),'Mach=
ine section for the project configuration page does not exist')
-           self.assertTrue(re.search("qemux86",self.driver.find_element_=
by_xpath("//span[@id=3D'project-machine-name']").text),'The machine type =
is not assigned')
-           self.driver.find_element_by_xpath("//span[@id=3D'change-machi=
ne-toggle']").click()
+           self.assertTrue(re.search("qemux86",self.driver.find_element(=
By.XPATH, "//span[@id=3D'project-machine-name']").text),'The machine type=
 is not assigned')
+           self.driver.find_element(By.XPATH, "//span[@id=3D'change-mach=
ine-toggle']").click()
            self.wait_until_visible('#select-machine-form')
            self.wait_until_visible('#cancel-machine-change')
-           self.driver.find_element_by_xpath("//form[@id=3D'select-machi=
ne-form']/a[@id=3D'cancel-machine-change']").click()
+           self.driver.find_element(By.XPATH, "//form[@id=3D'select-mach=
ine-form']/a[@id=3D'cancel-machine-change']").click()
         except:
            self.fail(msg=3D'The machine information is wrong in the conf=
iguration page')
=20
         try:
-           self.driver.find_element_by_id('no-most-built')
+           self.driver.find_element(By.ID, 'no-most-built')
         except:
            self.fail(msg=3D'No Most built information in project detail =
page')
=20
         try:
-           self.assertTrue(re.search("Yocto Project master",self.driver.=
find_element_by_xpath("//span[@id=3D'project-release-title']").text),'The=
 project release is not defined')
+           self.assertTrue(re.search("Yocto Project master",self.driver.=
find_element(By.XPATH, "//span[@id=3D'project-release-title']").text),'Th=
e project release is not defined')
         except:
            self.fail(msg=3D'No project release title information in proj=
ect detail page')
=20
         try:
-           self.driver.find_element_by_xpath("//div[@id=3D'layer-contain=
er']")
-           self.assertTrue(re.search("3",self.driver.find_element_by_id(=
"project-layers-count").text),'There should be 3 layers listed in the lay=
er count')
-           layer_list =3D self.driver.find_element_by_id("layers-in-proj=
ect-list")
-           layers =3D layer_list.find_elements_by_tag_name("li")
+           self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
+           self.assertTrue(re.search("3",self.driver.find_element(By.ID,=
 "project-layers-count").text),'There should be 3 layers listed in the la=
yer count')
+           layer_list =3D self.driver.find_element(By.ID, "layers-in-pro=
ject-list")
+           layers =3D layer_list.find_elements(By.TAG_NAME, "li")
            for layer in layers:
                if re.match ("openembedded-core",layer.text):
                     print ("openembedded-core layer is a default layer i=
n the project configuration")
@@ -121,60 +122,61 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
 #   testcase (1517)
     def test_verify_machine_information(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
=20
         try:
             self.assertTrue(self.element_exists('#machine-section'),'Mac=
hine section for the project configuration page does not exist')
-            self.assertTrue(re.search("qemux86",self.driver.find_element=
_by_id("project-machine-name").text),'The machine type is not assigned')
-            self.driver.find_element_by_id("change-machine-toggle").clic=
k()
+            self.assertTrue(re.search("qemux86",self.driver.find_element=
(By.ID, "project-machine-name").text),'The machine type is not assigned')
+            self.driver.find_element(By.ID, "change-machine-toggle").cli=
ck()
             self.wait_until_visible('#select-machine-form')
             self.wait_until_visible('#cancel-machine-change')
-            self.driver.find_element_by_id("cancel-machine-change").clic=
k()
+            self.driver.find_element(By.ID, "cancel-machine-change").cli=
ck()
         except:
             self.fail(msg=3D'The machine information is wrong in the con=
figuration page')
=20
 #   testcase (1518)
     def test_verify_most_built_recipes_information(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
=20
         try:
-            self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element_by_id("no-most-built").text),'Default message =
of no builds is not present')
-            self.driver.find_element_by_xpath("//div[@id=3D'no-most-buil=
t']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
-            self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element_by_xpath("//div[@class=3D'col-md-10']").text),'The Choo=
se a recipe to build link  is not working  properly')
+            self.assertTrue(re.search("You haven't built any recipes yet=
",self.driver.find_element(By.ID, "no-most-built").text),'Default message=
 of no builds is not present')
+            self.driver.find_element(By.XPATH, "//div[@id=3D'no-most-bui=
lt']/p/a[@href=3D"+'"'+project_URL+'images/"'+"]").click()
+            self.assertTrue(re.search("Compatible image recipes",self.dr=
iver.find_element(By.XPATH, "//div[@class=3D'col-md-10']").text),'The Cho=
ose a recipe to build link  is not working  properly')
         except:
             self.fail(msg=3D'No Most built information in project detail=
 page')
=20
 #   testcase (1519)
     def test_verify_project_release_information(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
=20
         try:
-            self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element_by_id("project-release-title").text),'The project release i=
s not defined')
+            self.assertTrue(re.search("Yocto Project master",self.driver=
.find_element(By.ID, "project-release-title").text),'The project release =
is not defined')
         except:
             self.fail(msg=3D'No project release title information in pro=
ject detail page')
=20
 #   testcase (1520)
     def test_verify_layer_information(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
=20
         try:
-           self.driver.find_element_by_xpath("//div[@id=3D'layer-contain=
er']")
-           self.assertTrue(re.search("3",self.driver.find_element_by_id(=
"project-layers-count").text),'There should be 3 layers listed in the lay=
er count')
-           layer_list =3D self.driver.find_element_by_id("layers-in-proj=
ect-list")
-           layers =3D layer_list.find_elements_by_tag_name("li")
+           self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']")
+           self.assertTrue(re.search("3",self.driver.find_element(By.ID,=
 "project-layers-count").text),'There should be 3 layers listed in the la=
yer count')
+           layer_list =3D self.driver.find_element(By.ID, "layers-in-pro=
ject-list")
+           layers =3D layer_list.find_element(By.TAG_NAME, "li")
=20
            for layer in layers:
                if re.match ("openembedded-core",layer.text):
@@ -186,43 +188,43 @@ class FuntionalTestBasic(SeleniumFunctionalTestCase=
):
                else:
                   self.fail(msg=3D'default layers are missing from the p=
roject configuration')
=20
-           self.driver.find_element_by_xpath("//input[@id=3D'layer-add-i=
nput']")
-           self.driver.find_element_by_xpath("//button[@id=3D'add-layer-=
btn']")
-           self.driver.find_element_by_xpath("//div[@id=3D'layer-contain=
er']/form[@class=3D'form-inline']/p/a[@id=3D'view-compatible-layers']")
-           self.driver.find_element_by_xpath("//div[@id=3D'layer-contain=
er']/form[@class=3D'form-inline']/p/a[@href=3D"+'"'+project_URL+'importla=
yer"'+"]")
+           self.driver.find_element(By.XPATH, "//input[@id=3D'layer-add-=
input']")
+           self.driver.find_element(By.XPATH, "//button[@id=3D'add-layer=
-btn']")
+           self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']/form[@class=3D'form-inline']/p/a[@id=3D'view-compatible-layers']")
+           self.driver.find_element(By.XPATH, "//div[@id=3D'layer-contai=
ner']/form[@class=3D'form-inline']/p/a[@href=3D"+'"'+project_URL+'importl=
ayer"'+"]")
         except:
             self.fail(msg=3D'No Layer information in project detail page=
')
=20
 #   testcase (1521)
     def test_verify_project_detail_links(self):
         self.get('')
-        self.driver.find_element_by_xpath("//div[@id=3D'global-nav']/ul/=
li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
+        self.driver.find_element(By.XPATH, "//div[@id=3D'global-nav']/ul=
/li/a[@href=3D"+'"'+'/toastergui/projects/'+'"'+"]").click()
         self.wait_until_visible('#projectstable')
         self.find_element_by_link_text_in_table('projectstable', 'seleni=
um-project').click()
         project_URL=3Dself.get_URL()
=20
-        self.driver.find_element_by_xpath("//div[@id=3D'project-topbar']=
/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@href=
=3D"+'"'+project_URL+'"'+"]").click()
-        self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt_by_xpath("//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/li=
[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").t=
ext), 'Configuration tab in project topbar is misspelled')
+        self.driver.find_element(By.XPATH, "//div[@id=3D'project-topbar'=
]/ul[@class=3D'nav nav-tabs']/li[@id=3D'topbar-configuration-tab']/a[@hre=
f=3D"+'"'+project_URL+'"'+"]").click()
+        self.assertTrue(re.search("Configuration",self.driver.find_eleme=
nt(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/l=
i[@id=3D'topbar-configuration-tab']/a[@href=3D"+'"'+project_URL+'"'+"]").=
text), 'Configuration tab in project topbar is misspelled')
=20
         try:
-            self.driver.find_element_by_xpath("//div[@id=3D'project-topb=
ar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/"=
'+"]").click()
-            self.assertTrue(re.search("Builds",self.driver.find_element_=
by_xpath("//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/li/a[=
@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project t=
opbar is misspelled')
-            self.driver.find_element_by_xpath("//div[@id=3D'empty-state-=
projectbuildstable']")
+            self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'builds/=
"'+"]").click()
+            self.assertTrue(re.search("Builds",self.driver.find_element(=
By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']/li/a=
[@href=3D"+'"'+project_URL+'builds/"'+"]").text), 'Builds tab in project =
topbar is misspelled')
+            self.driver.find_element(By.XPATH, "//div[@id=3D'empty-state=
-projectbuildstable']")
         except:
             self.fail(msg=3D'Builds tab information is not present')
=20
         try:
-            self.driver.find_element_by_xpath("//div[@id=3D'project-topb=
ar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importla=
yer"'+"]").click()
-            self.assertTrue(re.search("Import layer",self.driver.find_el=
ement_by_xpath("//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs']=
/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Import layer =
tab in project topbar is misspelled')
-            self.driver.find_element_by_xpath("//fieldset[@id=3D'repo-se=
lect']")
-            self.driver.find_element_by_xpath("//fieldset[@id=3D'git-rep=
o']")
+            self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'importl=
ayer"'+"]").click()
+            self.assertTrue(re.search("Import layer",self.driver.find_el=
ement(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-tabs'=
]/li/a[@href=3D"+'"'+project_URL+'importlayer"'+"]").text), 'Import layer=
 tab in project topbar is misspelled')
+            self.driver.find_element(By.XPATH, "//fieldset[@id=3D'repo-s=
elect']")
+            self.driver.find_element(By.XPATH, "//fieldset[@id=3D'git-re=
po']")
         except:
             self.fail(msg=3D'Import layer tab not loading properly')
=20
         try:
-            self.driver.find_element_by_xpath("//div[@id=3D'project-topb=
ar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcusto=
mimage/"'+"]").click()
-            self.assertTrue(re.search("New custom image",self.driver.fin=
d_element_by_xpath("//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-ta=
bs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").text), 'New c=
ustom image tab in project topbar is misspelled')
-            self.assertTrue(re.search("Select the image recipe you want =
to customise",self.driver.find_element_by_xpath("//div[@class=3D'col-md-1=
2']/h2").text),'The new custom image tab is not loading correctly')
+            self.driver.find_element(By.XPATH, "//div[@id=3D'project-top=
bar']/ul[@class=3D'nav nav-tabs']/li/a[@href=3D"+'"'+project_URL+'newcust=
omimage/"'+"]").click()
+            self.assertTrue(re.search("New custom image",self.driver.fin=
d_element(By.XPATH, "//div[@id=3D'project-topbar']/ul[@class=3D'nav nav-t=
abs']/li/a[@href=3D"+'"'+project_URL+'newcustomimage/"'+"]").text), 'New =
custom image tab in project topbar is misspelled')
+            self.assertTrue(re.search("Select the image recipe you want =
to customise",self.driver.find_element(By.XPATH, "//div[@class=3D'col-md-=
12']/h2").text),'The new custom image tab is not loading correctly')
         except:
             self.fail(msg=3D'New custom image tab not loading properly')
=20
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toast=
er/tests/toaster-tests-requirements.txt
index 4f9fcc46..f30ac070 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -1 +1 @@
-selenium=3D=3D2.49.2
+selenium>=3D4.13.0
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index 735d596b..f962e762 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -19,6 +19,7 @@ from orm.models import Layer_Version, Recipe
 from orm.models import CustomImageRecipe
 from orm.models import CustomImagePackage
=20
+from bldcontrol.models import BuildEnvironment
 import inspect
 import toastergui
=20
@@ -45,6 +46,9 @@ class ViewTests(TestCase):
         self.cust_package =3D CustomImagePackage.objects.first()
         self.package =3D Package.objects.first()
         self.lver =3D Layer_Version.objects.first()
+        if BuildEnvironment.objects.count() =3D=3D 0:
+            BuildEnvironment.objects.create(betype=3DBuildEnvironment.TY=
PE_LOCAL)
+
=20
     def test_get_base_call_returns_html(self):
         """Basic test for all-projects view"""
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/w=
idgets.py
index 53696912..6e87285c 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -305,6 +305,7 @@ class ToasterTable(TemplateView):
=20
         self.setup_columns(**kwargs)
=20
+        self.apply_orderby('pk')
         if search:
             self.apply_search(search)
         if filters:
--=20
2.34.1


