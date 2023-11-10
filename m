Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF0C04A95
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 17:26:37 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.33405.1699637193139221772
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 09:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=kX+Jkq6A;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7A5319C328E
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:26:32 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5QUnZO6mqRfj; Fri, 10 Nov 2023 12:26:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B5339C34EB;
	Fri, 10 Nov 2023 12:26:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9B5339C34EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699637191; bh=k8xUK/W/cCZzp+uGrQYcUx1+24rxNatPO2UsIeBji2o=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=kX+Jkq6An166PeccjDI/xvq/+jiDe40QbLTPrYwhMEQbPzclj46onSQ+qgKHaY2IE
	 8+mhKDYyjW4f4itkMUNFMzbWBfA1GqjY2YJDx19p2W3TMnjxcPtm00rshX+W6CY9Cz
	 D4eB23/eRQ+a6hPBt+rhz0R/qrmB739Vym6JX2l2Ao+ZyjAdYAaGL2q6V+wN+9XJ8k
	 IipFBAYnXjY3wHFd7gmZ5+EauALXuj/Rb5/i6/LnBZfECwNY7XFW8RFd/48rEeBA+P
	 WkQemTwkO0LcMxhFQwJu0PMfZiKBKORsakVgVTmVakHRtV0OiS+P1wIXV/Hs2CS6wx
	 MbNCFN6lh+poQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id S0bPso70Miss; Fri, 10 Nov 2023 12:26:31 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id BCFB89C34CA;
	Fri, 10 Nov 2023 12:26:30 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 6/6] Toaster: Toaster: Write UI TestCase -> Visualize all builds
Date: Fri, 10 Nov 2023 18:26:20 +0100
Message-Id: <20231110172620.396838-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
References: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 17:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15511

Test the "show rows" feature in the builds table, on the all builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 64 +++++++++++++++----
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index bd2b4799..4e9b9fd7 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -7,9 +7,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
=20
-import re, time
+import re
+import time
=20
 from django.urls import reverse
+from selenium.webdriver.support.select import Select
 from django.utils import timezone
 from bldcontrol.models import BuildRequest
 from tests.browser.selenium_helpers import SeleniumTestCase
@@ -151,13 +153,13 @@ class TestAllBuildsPage(SeleniumTestCase):
         build.recipes_parsed =3D 1
         build.save()
         buildRequest =3D BuildRequest.objects.create(
-            build=3Dbuild,=20
+            build=3Dbuild,
             project=3Dself.project1,
             state=3DBuildRequest.REQ_COMPLETED)
         build.build_request =3D buildRequest
         recipe =3D self._create_recipe()
         task =3D Task.objects.create(build=3Dbuild,
-                                   recipe=3Drecipe,=20
+                                   recipe=3Drecipe,
                                    task_name=3D'task',
                                    outcome=3DTask.OUTCOME_SUCCESS)
         task.save()
@@ -189,7 +191,8 @@ class TestAllBuildsPage(SeleniumTestCase):
         but should be shown for other builds
         """
         build1 =3D Build.objects.create(**self.project1_build_success)
-        default_build =3D Build.objects.create(**self.default_project_bu=
ild_success)
+        default_build =3D Build.objects.create(
+            **self.default_project_build_success)
=20
         url =3D reverse('all-builds')
         self.get(url)
@@ -311,15 +314,18 @@ class TestAllBuildsPage(SeleniumTestCase):
         # Check popup is visible
         time.sleep(1)
         self.wait_until_present('#filter-modal-allbuildstable')
-        self.assertTrue(self.find('#filter-modal-allbuildstable').is_dis=
played())
+        self.assertTrue(
+            self.find('#filter-modal-allbuildstable').is_displayed())
         # Check that we can filter by failure tasks
-        build_without_failure_tasks =3D self.find('#failed_tasks_filter\=
\:without_failed_tasks')
+        build_without_failure_tasks =3D self.find(
+            '#failed_tasks_filter\\:without_failed_tasks')
         build_without_failure_tasks.click()
         # click on apply button
         self.find('#filter-modal-allbuildstable .btn-primary').click()
         self.wait_until_present('#allbuildstable tbody tr')
         # Check if filter is applied, by checking if failed_tasks_filter=
 has btn-primary class
-        self.assertTrue(self.find('#failed_tasks_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
+        self.assertTrue(self.find('#failed_tasks_filter').get_attribute(
+            'class').find('btn-primary') !=3D -1)
=20
     def test_filtering_on_completedOn_column(self):
         """ Test the filtering on completed_on column in the builds tabl=
e on the all builds page """
@@ -335,16 +341,19 @@ class TestAllBuildsPage(SeleniumTestCase):
         # Check popup is visible
         time.sleep(1)
         self.wait_until_present('#filter-modal-allbuildstable')
-        self.assertTrue(self.find('#filter-modal-allbuildstable').is_dis=
played())
+        self.assertTrue(
+            self.find('#filter-modal-allbuildstable').is_displayed())
         # Check that we can filter by failure tasks
-        build_without_failure_tasks =3D self.find('#completed_on_filter\=
\:date_range')
+        build_without_failure_tasks =3D self.find(
+            '#completed_on_filter\\:date_range')
         build_without_failure_tasks.click()
         # click on apply button
         self.find('#filter-modal-allbuildstable .btn-primary').click()
         self.wait_until_present('#allbuildstable tbody tr')
         # Check if filter is applied, by checking if completed_on_filter=
 has btn-primary class
-        self.assertTrue(self.find('#completed_on_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
-       =20
+        self.assertTrue(self.find('#completed_on_filter').get_attribute(
+            'class').find('btn-primary') !=3D -1)
+
         # Filter by date range
         self.find('#completed_on_filter').click()
         self.wait_until_present('#filter-modal-allbuildstable')
@@ -357,7 +366,8 @@ class TestAllBuildsPage(SeleniumTestCase):
         date_ranges[1].send_keys(today.strftime('%Y-%m-%d'))
         self.find('#filter-modal-allbuildstable .btn-primary').click()
         self.wait_until_present('#allbuildstable tbody tr')
-        self.assertTrue(self.find('#completed_on_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
+        self.assertTrue(self.find('#completed_on_filter').get_attribute(
+            'class').find('btn-primary') !=3D -1)
         # Check if filter is applied, number of builds displayed should =
be 6
         time.sleep(1)
         self.assertTrue(len(self.find_all('#allbuildstable tbody tr')) =3D=
=3D 6)
@@ -421,3 +431,33 @@ class TestAllBuildsPage(SeleniumTestCase):
         test_edit_column('checkbox-started_on')
         test_edit_column('checkbox-time')
         test_edit_column('checkbox-warnings_no')
+
+    def test_builds_table_show_rows(self):
+        """ Test the show rows feature in the builds table on the all bu=
ilds page """
+        self._get_create_builds(success=3D100, failure=3D100)
+
+        def test_show_rows(row_to_show, show_row_link):
+            # Check that we can show rows =3D=3D row_to_show
+            show_row_link.select_by_value(str(row_to_show))
+            self.wait_until_present('#allbuildstable tbody tr')
+            time.sleep(1)
+            self.assertTrue(
+                len(self.find_all('#allbuildstable tbody tr')) =3D=3D ro=
w_to_show
+            )
+
+        url =3D reverse('all-builds')
+        self.get(url)
+        self.wait_until_present('#allbuildstable tbody tr')
+
+        show_rows =3D self.driver.find_elements(
+            By.XPATH,
+            '//select[@class=3D"form-control pagesize-allbuildstable"]'
+        )
+        # Check show rows
+        for show_row_link in show_rows:
+            show_row_link =3D Select(show_row_link)
+            test_show_rows(10, show_row_link)
+            test_show_rows(25, show_row_link)
+            test_show_rows(50, show_row_link)
+            test_show_rows(100, show_row_link)
+            test_show_rows(150, show_row_link)
--=20
2.34.1


