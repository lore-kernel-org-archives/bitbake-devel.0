Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66186C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 01:56:09 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.10310.1702000564868554340
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 17:56:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=KFzuJHLs;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3D3E89C3645
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 Dec 2023 20:56:04 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id PUytvKUgJowG; Thu,  7 Dec 2023 20:56:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A8FDA9C3472;
	Thu,  7 Dec 2023 20:56:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A8FDA9C3472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702000562; bh=BZoqrlhmhQgYItHqJt2gV1Mjylnp8xiNnhj4p9+a8xg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=KFzuJHLsJIxz1RF/TNlG1NaXc79LZRKdYQCL/FAr/OXtvrRVX8GqVWG6LB4WSEVj7
	 3FB0pot21XvHpiNWuP8rMlopmIJvOLESaWV6vxL+S9AoB9zCeKJsqllOpqBen+O66x
	 g2MLKSxnNR3hFKQeqR3g0vNG/29geQJOV3jBwH62IrrcN7QJdo54AW7+1N/kPhGyIb
	 KeUxWCASXSkEDGlEtZqLV/8yPbVsbkNiZZA83DnrErFoDTLYXMvmoCZsFoI8tsnCwV
	 8YlTMFKIAUrYFW7oo5hWZuvSTx9q7i6uXja+JTW4AkoV5836Fwho1XcYVDkjpM2GVd
	 IvSDDwRHQlgpA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cLwUu5qM3td7; Thu,  7 Dec 2023 20:56:02 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BFA9D9C33BA;
	Thu,  7 Dec 2023 20:56:01 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster/test: bug-fix tests writing files into /tmp on the autobuilders
Date: Fri,  8 Dec 2023 02:55:57 +0100
Message-Id: <20231208015557.684827-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Dec 2023 01:56:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15638

- Use build directory instead of /tmp
- Better handle delay between driver actions

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     |  4 +-
 .../tests/browser/test_all_projects_page.py   | 45 ++++++++++---------
 .../tests/browser/test_builddashboard_page.py |  4 +-
 .../test_builddashboard_page_artifacts.py     |  4 +-
 .../tests/browser/test_landing_page.py        | 33 ++++++++------
 .../tests/browser/test_layerdetails_page.py   |  4 +-
 .../browser/test_most_recent_builds_states.py |  1 -
 .../browser/test_new_custom_image_page.py     |  3 +-
 .../tests/browser/test_new_project_page.py    | 11 ++---
 .../tests/browser/test_project_builds_page.py |  4 +-
 .../tests/browser/test_project_config_page.py |  4 +-
 .../tests/browser/test_toastertable_ui.py     |  4 +-
 lib/toaster/tests/builds/buildtest.py         |  2 +-
 lib/toaster/tests/functional/buffer           |  0
 lib/toaster/tests/views/test_views.py         |  8 ++--
 15 files changed, 75 insertions(+), 56 deletions(-)
 create mode 100644 lib/toaster/tests/functional/buffer

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index bfd8f3a4..7019b3db 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 import re
=20
 from django.urls import reverse
@@ -27,7 +28,8 @@ class TestAllBuildsPage(SeleniumTestCase):
     CLI_BUILDS_PROJECT_NAME =3D 'command line builds'
=20
     def setUp(self):
-        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3D'/=
tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3Df'=
{builldir}/',
                                             branch=3D'master', dirpath=3D=
'')
         release =3D Release.objects.create(name=3D'release1',
                                          bitbake_version=3Dbbv)
diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index a880dbcc..6540dfa9 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -7,8 +7,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 import re
-import time
=20
 from django.urls import reverse
 from django.utils import timezone
@@ -20,6 +20,7 @@ from orm.models import ProjectVariable
=20
 from selenium.webdriver.common.by import By
=20
+
 class TestAllProjectsPage(SeleniumTestCase):
     """ Browser tests for projects page /projects/ """
=20
@@ -29,7 +30,8 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
     def setUp(self):
         """ Add default project manually """
-        project =3D Project.objects.create_project(self.CLI_BUILDS_PROJE=
CT_NAME, None)
+        project =3D Project.objects.create_project(
+            self.CLI_BUILDS_PROJECT_NAME, None)
         self.default_project =3D project
         self.default_project.is_default =3D True
         self.default_project.save()
@@ -60,12 +62,14 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
     def _add_non_default_project(self):
         """ Add another project """
-        bbv =3D BitbakeVersion.objects.create(name=3D'test bbv', giturl=3D=
'/tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'test bbv', giturl=3D=
f'{builldir}/',
                                             branch=3D'master', dirpath=3D=
'')
         self.release =3D Release.objects.create(name=3D'test release',
                                               branch_name=3D'master',
                                               bitbake_version=3Dbbv)
-        self.project =3D Project.objects.create_project(self.PROJECT_NAM=
E, self.release)
+        self.project =3D Project.objects.create_project(
+            self.PROJECT_NAME, self.release)
         self.project.is_default =3D False
         self.project.save()
=20
@@ -77,7 +81,7 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
     def _get_row_for_project(self, project_name):
         """ Get the HTML row for a project, or None if not found """
-        self.wait_until_present('#projectstable tbody tr')
+        self.wait_until_visible('#projectstable tbody tr', poll=3D3)
         rows =3D self.find_all('#projectstable tbody tr')
=20
         # find the row with a project name matching the one supplied
@@ -108,7 +112,8 @@ class TestAllProjectsPage(SeleniumTestCase):
         url =3D reverse('all-projects')
         self.get(url)
=20
-        default_project_row =3D self._get_row_for_project(self.default_p=
roject.name)
+        default_project_row =3D self._get_row_for_project(
+            self.default_project.name)
=20
         self.assertNotEqual(default_project_row, None,
                             'default project "cli builds" should be in p=
age')
@@ -128,7 +133,8 @@ class TestAllProjectsPage(SeleniumTestCase):
         self.wait_until_visible("#projectstable tr")
=20
         # find the row for the default project
-        default_project_row =3D self._get_row_for_project(self.default_p=
roject.name)
+        default_project_row =3D self._get_row_for_project(
+            self.default_project.name)
=20
         # check the release text for the default project
         selector =3D 'span[data-project-field=3D"release"] span.text-mut=
ed'
@@ -163,7 +169,8 @@ class TestAllProjectsPage(SeleniumTestCase):
         self.wait_until_visible("#projectstable tr")
=20
         # find the row for the default project
-        default_project_row =3D self._get_row_for_project(self.default_p=
roject.name)
+        default_project_row =3D self._get_row_for_project(
+            self.default_project.name)
=20
         # check the machine cell for the default project
         selector =3D 'span[data-project-field=3D"machine"] span.text-mut=
ed'
@@ -198,13 +205,15 @@ class TestAllProjectsPage(SeleniumTestCase):
         self.get(reverse('all-projects'))
=20
         # find the row for the default project
-        default_project_row =3D self._get_row_for_project(self.default_p=
roject.name)
+        default_project_row =3D self._get_row_for_project(
+            self.default_project.name)
=20
         # check the link on the name field
         selector =3D 'span[data-project-field=3D"name"] a'
         element =3D default_project_row.find_element(By.CSS_SELECTOR, se=
lector)
         link_url =3D element.get_attribute('href').strip()
-        expected_url =3D reverse('projectbuilds', args=3D(self.default_p=
roject.id,))
+        expected_url =3D reverse(
+            'projectbuilds', args=3D(self.default_project.id,))
         msg =3D 'link on default project name should point to builds but=
 was %s' % link_url
         self.assertTrue(link_url.endswith(expected_url), msg)
=20
@@ -227,7 +236,7 @@ class TestAllProjectsPage(SeleniumTestCase):
         self.get(url)
=20
         # Chseck search box is present and works
-        self.wait_until_present('#projectstable tbody tr')
+        self.wait_until_visible('#projectstable tbody tr', poll=3D3)
         search_box =3D self.find('#search-input-projectstable')
         self.assertTrue(search_box.is_displayed())
=20
@@ -235,8 +244,7 @@ class TestAllProjectsPage(SeleniumTestCase):
         search_box.send_keys('test project 10')
         search_btn =3D self.find('#search-submit-projectstable')
         search_btn.click()
-        self.wait_until_present('#projectstable tbody tr')
-        time.sleep(1)
+        self.wait_until_visible('#projectstable tbody tr', poll=3D3)
         rows =3D self.find_all('#projectstable tbody tr')
         self.assertTrue(len(rows) =3D=3D 1)
=20
@@ -282,7 +290,7 @@ class TestAllProjectsPage(SeleniumTestCase):
                 )
         url =3D reverse('all-projects')
         self.get(url)
-        self.wait_until_present('#projectstable tbody tr')
+        self.wait_until_visible('#projectstable tbody tr', poll=3D3)
=20
         # Check edit column
         edit_column =3D self.find('#edit-columns-button')
@@ -305,19 +313,14 @@ class TestAllProjectsPage(SeleniumTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_present('#projectstable tbody tr')
-            sleep_time =3D 1
-            if row_to_show =3D=3D 150:
-                # wait more time for 150 rows
-                sleep_time =3D 2
-            time.sleep(sleep_time)
+            self.wait_until_visible('#projectstable tbody tr', poll=3D3)
             self.assertTrue(
                 len(self.find_all('#projectstable tbody tr')) =3D=3D row=
_to_show
             )
=20
         url =3D reverse('all-projects')
         self.get(url)
-        self.wait_until_present('#projectstable tbody tr')
+        self.wait_until_visible('#projectstable tbody tr', poll=3D3)
=20
         show_rows =3D self.driver.find_elements(
             By.XPATH,
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/=
toaster/tests/browser/test_builddashboard_page.py
index 1afa4a4d..b713f300 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 from django.urls import reverse
 from django.utils import timezone
=20
@@ -21,7 +22,8 @@ class TestBuildDashboardPage(SeleniumTestCase):
     """ Tests for the build dashboard /build/X """
=20
     def setUp(self):
-        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3D'/=
tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3Df'=
{builldir}/',
                                             branch=3D'master', dirpath=3D=
"")
         release =3D Release.objects.create(name=3D'release1',
                                          bitbake_version=3Dbbv)
diff --git a/lib/toaster/tests/browser/test_builddashboard_page_artifacts=
.py b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
index adea2edb..675825bd 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page_artifacts.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 from django.urls import reverse
 from django.utils import timezone
=20
@@ -20,7 +21,8 @@ class TestBuildDashboardPageArtifacts(SeleniumTestCase)=
:
     """ Tests for artifacts on the build dashboard /build/X """
=20
     def setUp(self):
-        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3D'/=
tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3Df'=
{builldir}/',
                                             branch=3D'master', dirpath=3D=
"")
         release =3D Release.objects.create(name=3D'release1',
                                          bitbake_version=3Dbbv)
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index ca0b2e63..f6649a3d 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -14,6 +14,7 @@ from selenium.webdriver.common.by import By
=20
 from orm.models import Layer, Layer_Version, Project, Build
=20
+
 class TestLandingPage(SeleniumTestCase):
     """ Tests for redirects on the landing page """
=20
@@ -40,7 +41,7 @@ class TestLandingPage(SeleniumTestCase):
=20
         # check that the info sign is clickable
         # and info modal is appearing when clicking on the info sign
-        info_sign.click() # click on the info sign make attribute 'aria-=
describedby' visible
+        info_sign.click()  # click on the info sign make attribute 'aria=
-describedby' visible
         info_model_id =3D info_sign.get_attribute('aria-describedby')
         info_modal =3D self.find(f'#{info_model_id}')
         self.assertTrue(info_modal.is_displayed())
@@ -55,7 +56,7 @@ class TestLandingPage(SeleniumTestCase):
         self.assertTrue(documentation_link.is_displayed())
=20
         # check browser open new tab toaster manual when clicking on the=
 documentation link
-        self.assertEqual(documentation_link.get_attribute('target') , '_=
blank')
+        self.assertEqual(documentation_link.get_attribute('target'), '_b=
lank')
         self.assertEqual(
             documentation_link.get_attribute('href'),
             'http://docs.yoctoproject.org/toaster-manual/index.html#toas=
ter-user-manual')
@@ -81,7 +82,8 @@ class TestLandingPage(SeleniumTestCase):
         bitbake =3D jumbotron.find_element(By.LINK_TEXT, 'BitBake')
         self.assertTrue(bitbake.is_displayed())
         bitbake.click()
-        self.assertTrue("docs.yoctoproject.org/bitbake.html" in self.dri=
ver.current_url)
+        self.assertTrue(
+            "docs.yoctoproject.org/bitbake.html" in self.driver.current_=
url)
=20
     def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
         """ Test Yocto Project link jumbotron is visible and clickable: =
"""
@@ -103,11 +105,12 @@ class TestLandingPage(SeleniumTestCase):
=20
         # check Big magenta button
         big_magenta_button =3D jumbotron.find_element(By.LINK_TEXT,
-            'Toaster is ready to capture your command line builds'
-        )
+                                                    'Toaster is ready to=
 capture your command line builds'
+                                                    )
         self.assertTrue(big_magenta_button.is_displayed())
         big_magenta_button.click()
-        self.assertTrue("docs.yoctoproject.org/toaster-manual/setup-and-=
use.html#setting-up-and-using-toaster" in self.driver.current_url)
+        self.assertTrue(
+            "docs.yoctoproject.org/toaster-manual/setup-and-use.html#set=
ting-up-and-using-toaster" in self.driver.current_url)
=20
     def test_link_create_new_project_in_jumbotron_visible_and_clickable(=
self):
         """ Test big blue button create new project jumbotron if visible=
 and clickable """
@@ -120,8 +123,8 @@ class TestLandingPage(SeleniumTestCase):
=20
         # check Big Blue button
         big_blue_button =3D jumbotron.find_element(By.LINK_TEXT,
-            'Create your first Toaster project to run manage builds'
-        )
+                                                 'Create your first Toas=
ter project to run manage builds'
+                                                 )
         self.assertTrue(big_blue_button.is_displayed())
         big_blue_button.click()
         self.assertTrue("toastergui/newproject/" in self.driver.current_=
url)
@@ -132,10 +135,12 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron =3D self.find('.jumbotron')
=20
         # check Read the Toaster manual
-        toaster_manual =3D jumbotron.find_element(By.LINK_TEXT, 'Read th=
e Toaster manual')
+        toaster_manual =3D jumbotron.find_element(
+            By.LINK_TEXT, 'Read the Toaster manual')
         self.assertTrue(toaster_manual.is_displayed())
         toaster_manual.click()
-        self.assertTrue("https://docs.yoctoproject.org/toaster-manual/in=
dex.html#toaster-user-manual" in self.driver.current_url)
+        self.assertTrue(
+            "https://docs.yoctoproject.org/toaster-manual/index.html#toa=
ster-user-manual" in self.driver.current_url)
=20
     def test_contrib_to_toaster_link_visible_and_clickable(self):
         """ Test Contribute to Toaster link jumbotron is visible and cli=
ckable: """
@@ -143,10 +148,12 @@ class TestLandingPage(SeleniumTestCase):
         jumbotron =3D self.find('.jumbotron')
=20
         # check Contribute to Toaster
-        contribute_to_toaster =3D jumbotron.find_element(By.LINK_TEXT, '=
Contribute to Toaster')
+        contribute_to_toaster =3D jumbotron.find_element(
+            By.LINK_TEXT, 'Contribute to Toaster')
         self.assertTrue(contribute_to_toaster.is_displayed())
         contribute_to_toaster.click()
-        self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaste=
r" in str(self.driver.current_url).lower())
+        self.assertTrue(
+            "wiki.yoctoproject.org/wiki/contribute_to_toaster" in str(se=
lf.driver.current_url).lower())
=20
     def test_only_default_project(self):
         """
@@ -206,7 +213,7 @@ class TestLandingPage(SeleniumTestCase):
=20
         self.get(reverse('landing'))
=20
-        self.wait_until_visible("#latest-builds")
+        self.wait_until_visible("#latest-builds", poll=3D3)
         elements =3D self.find_all('#allbuildstable')
         self.assertEqual(len(elements), 1, 'should redirect to builds')
         content =3D self.get_page_source()
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 27cda0f2..367c6179 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -106,7 +106,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for save_btn in self.find_all(".change-btn"):
             save_btn.click()
=20
-        self.wait_until_visible("#save-changes-for-switch")
+        self.wait_until_visible("#save-changes-for-switch", poll=3D3)
         btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
         btn_save_chg_for_switch.click()
         self.wait_until_visible("#edit-layer-source")
@@ -137,7 +137,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
         new_dir =3D "/home/test/my-meta-dir"
         dir_input.send_keys(new_dir)
=20
-        self.wait_until_visible("#save-changes-for-switch")
+        self.wait_until_visible("#save-changes-for-switch", poll=3D3)
         btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
         btn_save_chg_for_switch.click()
         self.wait_until_visible("#edit-layer-source")
diff --git a/lib/toaster/tests/browser/test_most_recent_builds_states.py =
b/lib/toaster/tests/browser/test_most_recent_builds_states.py
index c13d328e..d7a4c345 100644
--- a/lib/toaster/tests/browser/test_most_recent_builds_states.py
+++ b/lib/toaster/tests/browser/test_most_recent_builds_states.py
@@ -6,7 +6,6 @@
 #
 # Copyright (C) 2013-2016 Intel Corporation
 #
-import time
 from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/li=
b/toaster/tests/browser/test_new_custom_image_page.py
index f4d95b1a..4ad22c7a 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -45,10 +45,11 @@ class TestNewCustomImagePage(SeleniumTestCase):
         )
=20
         # add a fake image recipe to the layer that can be customised
+        builldir =3D os.environ.get('BUILDDIR', './')
         self.recipe =3D Recipe.objects.create(
             name=3D'core-image-minimal',
             layer_version=3Dlayer_version,
-            file_path=3D'/tmp/core-image-minimal.bb',
+            file_path=3Df'{builldir}/core-image-minimal.bb',
             is_image=3DTrue
         )
         # create a tmp file for the recipe
diff --git a/lib/toaster/tests/browser/test_new_project_page.py b/lib/toa=
ster/tests/browser/test_new_project_page.py
index f4b2708f..0c33c44f 100644
--- a/lib/toaster/tests/browser/test_new_project_page.py
+++ b/lib/toaster/tests/browser/test_new_project_page.py
@@ -6,8 +6,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
-import time
-
 from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
 from selenium.webdriver.support.ui import Select
@@ -54,13 +52,12 @@ class TestNewProjectPage(SeleniumTestCase):
         select =3D Select(self.find('#projectversion'))
         select.select_by_value(str(self.release.pk))
=20
-        time.sleep(1)
         self.click("#create-project-button")
-        time.sleep(2)
=20
         # We should get redirected to the new project's page with the
         # notification at the top
-        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        element =3D self.wait_until_visible(
+            '#project-created-notification', poll=3D3)
=20
         self.assertTrue(project_name in element.text,
                         "New project name not in new project notificatio=
n")
@@ -91,9 +88,8 @@ class TestNewProjectPage(SeleniumTestCase):
         radio.click()
=20
         self.click("#create-project-button")
-        time.sleep(2)
=20
-        element =3D self.wait_until_visible('#hint-error-project-name')
+        element =3D self.wait_until_visible('#hint-error-project-name', =
poll=3D3)
=20
         self.assertTrue(("Project names must be unique" in element.text)=
,
                         "Did not find unique project name error message"=
)
@@ -105,7 +101,6 @@ class TestNewProjectPage(SeleniumTestCase):
         except InvalidElementStateException:
             pass
=20
-        time.sleep(2)
         self.assertTrue(
             (Project.objects.filter(name=3Dproject_name).count() =3D=3D =
1),
             "New project not found in database")
diff --git a/lib/toaster/tests/browser/test_project_builds_page.py b/lib/=
toaster/tests/browser/test_project_builds_page.py
index 51717e72..0dba33b9 100644
--- a/lib/toaster/tests/browser/test_project_builds_page.py
+++ b/lib/toaster/tests/browser/test_project_builds_page.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 import re
=20
 from django.urls import reverse
@@ -22,7 +23,8 @@ class TestProjectBuildsPage(SeleniumTestCase):
     CLI_BUILDS_PROJECT_NAME =3D 'command line builds'
=20
     def setUp(self):
-        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3D'/=
tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3Df'=
{builldir}/',
                                             branch=3D'master', dirpath=3D=
'')
         release =3D Release.objects.create(name=3D'release1',
                                          bitbake_version=3Dbbv)
diff --git a/lib/toaster/tests/browser/test_project_config_page.py b/lib/=
toaster/tests/browser/test_project_config_page.py
index 7b21460e..b9de541e 100644
--- a/lib/toaster/tests/browser/test_project_config_page.py
+++ b/lib/toaster/tests/browser/test_project_config_page.py
@@ -7,6 +7,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
+import os
 from django.urls import reverse
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
@@ -22,7 +23,8 @@ class TestProjectConfigsPage(SeleniumTestCase):
         'any of these characters'
=20
     def setUp(self):
-        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3D'/=
tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'bbv1', giturl=3Df'=
{builldir}/',
                                             branch=3D'master', dirpath=3D=
'')
         release =3D Release.objects.create(name=3D'release1',
                                          bitbake_version=3Dbbv)
diff --git a/lib/toaster/tests/browser/test_toastertable_ui.py b/lib/toas=
ter/tests/browser/test_toastertable_ui.py
index e00c30a8..691aca1e 100644
--- a/lib/toaster/tests/browser/test_toastertable_ui.py
+++ b/lib/toaster/tests/browser/test_toastertable_ui.py
@@ -8,6 +8,7 @@
 #
=20
 from datetime import datetime
+import os
=20
 from django.urls import reverse
 from django.utils import timezone
@@ -59,7 +60,8 @@ class TestToasterTableUI(SeleniumTestCase):
         later =3D now + timezone.timedelta(hours=3D1)
         even_later =3D later + timezone.timedelta(hours=3D1)
=20
-        bbv =3D BitbakeVersion.objects.create(name=3D'test bbv', giturl=3D=
'/tmp/',
+        builldir =3D os.environ.get('BUILDDIR', './')
+        bbv =3D BitbakeVersion.objects.create(name=3D'test bbv', giturl=3D=
f'{builldir}/',
                                             branch=3D'master', dirpath=3D=
'')
         release =3D Release.objects.create(name=3D'test release',
                                          branch_name=3D'master',
diff --git a/lib/toaster/tests/builds/buildtest.py b/lib/toaster/tests/bu=
ilds/buildtest.py
index 53cd7a9f..c5596c4d 100644
--- a/lib/toaster/tests/builds/buildtest.py
+++ b/lib/toaster/tests/builds/buildtest.py
@@ -87,8 +87,8 @@ def load_build_environment():
=20
 class BuildTest(unittest.TestCase):
=20
+    BUILDDIR =3D os.environ.get('BUILDDIR', '/.')
     PROJECT_NAME =3D "Testbuild"
-    BUILDDIR =3D "/tmp/build/"
=20
     def build(self, target):
         # So that the buildinfo helper uses the test database'
diff --git a/lib/toaster/tests/functional/buffer b/lib/toaster/tests/func=
tional/buffer
new file mode 100644
index 00000000..e69de29b
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index 349881eb..49a51d02 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -9,6 +9,7 @@
=20
 """Test cases for Toaster GUI and ReST."""
=20
+import os
 import pytest
 from django.test import TestCase
 from django.test.client import RequestFactory
@@ -39,6 +40,7 @@ class ViewTests(TestCase):
     """Tests to verify view APIs."""
=20
     fixtures =3D ['toastergui-unittest-data']
+    builldir =3D os.environ.get('BUILDDIR')
=20
     def setUp(self):
=20
@@ -46,7 +48,7 @@ class ViewTests(TestCase):
=20
         self.recipe1 =3D Recipe.objects.get(pk=3D2)
         # create a file and to recipe1 file_path
-        file_path =3D f"/tmp/{self.recipe1.name.strip().replace(' ', '-'=
)}.bb"
+        file_path =3D f"{self.builldir}/{self.recipe1.name.strip().repla=
ce(' ', '-')}.bb"
         with open(file_path, 'w') as f:
             f.write('foo')
         self.recipe1.file_path =3D file_path
@@ -240,7 +242,7 @@ class ViewTests(TestCase):
         recipe =3D CustomImageRecipe.objects.create(
                      name=3Dname, project=3Dself.project,
                      base_recipe=3Dself.recipe1,
-                     file_path=3D"/tmp/testing",
+                     file_path=3Df"{self.builldir}/testing",
                      layer_version=3Dself.customr.layer_version)
         url =3D reverse('xhr_customrecipe_id', args=3D(recipe.id,))
         response =3D self.client.delete(url)
@@ -311,7 +313,7 @@ class ViewTests(TestCase):
         """Download the recipe file generated for the custom image"""
=20
         # Create a dummy recipe file for the custom image generation to =
read
-        open("/tmp/a_recipe.bb", 'a').close()
+        open(f"{self.builldir}/a_recipe.bb", 'a').close()
         response =3D self.client.get(reverse('customrecipedownload',
                                            args=3D(self.project.id,
                                                  self.customr.id)))
--=20
2.34.1


