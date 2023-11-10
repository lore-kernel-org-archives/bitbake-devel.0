Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6BFC41535
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 17:26:37 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33674.1699637190952090637
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 09:26:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=AniS/OlV;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4D70C9C34F4
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:26:30 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KHR52LiwIz6H; Fri, 10 Nov 2023 12:26:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 682A89C34CC;
	Fri, 10 Nov 2023 12:26:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 682A89C34CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699637189; bh=Z4uYXMJhe7y0p2zC/cWsd+g2rYMbavpSCcRIKlcO6fE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=AniS/OlV9lc0uLcPqKNyTBIp1EYNDKYL7T+L8MnkaBAhEJpcNSkkFpcdI2wlYkAyw
	 31j7g9gcYCw7f9F3UNrAnvuhaeffNCsCiCfefvMKpKaCSjxSz0KREkCtROtrkMtvrB
	 MARtTqzqFC7zKB1DV4GmaZsV2r7mumCAY4V7mrYF6L6+yLS8hTMhF+iELYeRKv61rB
	 wAPzxA+U2bYihw1R2UTdS1Peu9d5GG+04FuwXZhP5a1bfg5c7XjuVoZddVDVl4sOfW
	 pLIOlFqWstelbsClpPI4/XYTP27sSvhzwAzkDpa5Jbolzm6VHxDT2RS7zLwfKK4UgT
	 OnVkNF/RPhO4Q==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mqYV2KEITDYD; Fri, 10 Nov 2023 12:26:29 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9F2279C328E;
	Fri, 10 Nov 2023 12:26:28 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/6] Toaster: Write UI TestCase -> Visualize all builds
Date: Fri, 10 Nov 2023 18:26:18 +0100
Message-Id: <20231110172620.396838-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
References: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 17:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15509

Test the filtering on completed_on column in the builds table on the all =
builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index 81498aa8..90dcdd91 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -11,10 +11,10 @@ import re, time
=20
 from django.urls import reverse
 from django.utils import timezone
-from selenium.webdriver.remote.webdriver import WebElement
+from bldcontrol.models import BuildRequest
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
-from orm.models import BitbakeVersion, Release, Project, Build, Target
+from orm.models import BitbakeVersion, Layer, Layer_Version, Recipe, Rel=
ease, Project, Build, Target, Task
=20
 from selenium.webdriver.common.by import By
=20
@@ -118,17 +118,51 @@ class TestAllBuildsPage(SeleniumTestCase):
             # Create kwargs.get('success') builds with success status wi=
th target
             # and kwargs.get('failure') builds with failure status with =
target
             for i in range(kwargs.get('success', 0)):
+                now =3D timezone.now()
+                self.project1_build_success['started_on'] =3D now
+                self.project1_build_success[
+                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
                 build =3D Build.objects.create(**self.project1_build_suc=
cess)
                 Target.objects.create(build=3Dbuild,
                                       target=3Df'{i}_success_recipe',
                                       task=3Df'{i}_success_task')
+
+                self._set_buildRequest_and_task_on_build(build)
             for i in range(kwargs.get('failure', 0)):
+                now =3D timezone.now()
+                self.project1_build_failure['started_on'] =3D now
+                self.project1_build_failure[
+                    'completed_on'] =3D now - timezone.timedelta(days=3D=
i)
                 build =3D Build.objects.create(**self.project1_build_fai=
lure)
                 Target.objects.create(build=3Dbuild,
                                       target=3Df'{i}_fail_recipe',
                                       task=3Df'{i}_fail_task')
+                self._set_buildRequest_and_task_on_build(build)
         return build1, build2
=20
+    def _create_recipe(self):
+        """ Add a recipe to the database and return it """
+        layer =3D Layer.objects.create()
+        layer_version =3D Layer_Version.objects.create(layer=3Dlayer)
+        return Recipe.objects.create(name=3D'recipe_foo', layer_version=3D=
layer_version)
+
+    def _set_buildRequest_and_task_on_build(self, build):
+        """ Set buildRequest and task on build """
+        build.recipes_parsed =3D 1
+        build.save()
+        buildRequest =3D BuildRequest.objects.create(
+            build=3Dbuild,=20
+            project=3Dself.project1,
+            state=3DBuildRequest.REQ_COMPLETED)
+        build.build_request =3D buildRequest
+        recipe =3D self._create_recipe()
+        task =3D Task.objects.create(build=3Dbuild,
+                                   recipe=3Drecipe,=20
+                                   task_name=3D'task',
+                                   outcome=3DTask.OUTCOME_SUCCESS)
+        task.save()
+        build.save()
+
     def test_show_tasks_with_suffix(self):
         """ Task should be shown as suffix on build name """
         build =3D Build.objects.create(**self.project1_build_success)
@@ -286,3 +320,45 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.wait_until_present('#allbuildstable tbody tr')
         # Check if filter is applied, by checking if failed_tasks_filter=
 has btn-primary class
         self.assertTrue(self.find('#failed_tasks_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
+
+    def test_filtering_on_completedOn_column(self):
+        """ Test the filtering on completed_on column in the builds tabl=
e on the all builds page """
+        self._get_create_builds(success=3D10, failure=3D10)
+
+        url =3D reverse('all-builds')
+        self.get(url)
+
+        # Check filtering on failure tasks column
+        self.wait_until_present('#allbuildstable tbody tr')
+        completed_on_filter =3D self.find('#completed_on_filter')
+        completed_on_filter.click()
+        # Check popup is visible
+        time.sleep(1)
+        self.wait_until_present('#filter-modal-allbuildstable')
+        self.assertTrue(self.find('#filter-modal-allbuildstable').is_dis=
played())
+        # Check that we can filter by failure tasks
+        build_without_failure_tasks =3D self.find('#completed_on_filter\=
\:date_range')
+        build_without_failure_tasks.click()
+        # click on apply button
+        self.find('#filter-modal-allbuildstable .btn-primary').click()
+        self.wait_until_present('#allbuildstable tbody tr')
+        # Check if filter is applied, by checking if completed_on_filter=
 has btn-primary class
+        self.assertTrue(self.find('#completed_on_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
+       =20
+        # Filter by date range
+        self.find('#completed_on_filter').click()
+        self.wait_until_present('#filter-modal-allbuildstable')
+        date_ranges =3D self.driver.find_elements(
+            By.XPATH, '//input[@class=3D"form-control hasDatepicker"]')
+        today =3D timezone.now()
+        yestersday =3D today - timezone.timedelta(days=3D1)
+        time.sleep(1)
+        date_ranges[0].send_keys(yestersday.strftime('%Y-%m-%d'))
+        date_ranges[1].send_keys(today.strftime('%Y-%m-%d'))
+        self.find('#filter-modal-allbuildstable .btn-primary').click()
+        self.wait_until_present('#allbuildstable tbody tr')
+        self.assertTrue(self.find('#completed_on_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
+        # Check if filter is applied, number of builds displayed should =
be 6
+        time.sleep(1)
+        self.assertTrue(len(self.find_all('#allbuildstable tbody tr')) =3D=
=3D 6)
+
--=20
2.34.1


