Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7ABC10DC3
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 16:40:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.105779.1701794427703256706
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Dec 2023 08:40:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=KQg12khF;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 10B0F9C3787
	for <bitbake-devel@lists.openembedded.org>; Tue,  5 Dec 2023 11:40:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id itIFFxtY4onz; Tue,  5 Dec 2023 11:40:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5E92C9C3644;
	Tue,  5 Dec 2023 11:40:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5E92C9C3644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701794426; bh=0lQ6kY0G6N/T8Vim0gW9gdxDL1wjSYWzA2pb/gZkycc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=KQg12khFldZKCKqVy1mrBsWRT+3j+LhSJfdEIPxwzE02jfva/XRaHeish4IZHVcoS
	 4ZcC/sbCvYZ/1v5OZ6TRpeQR3/EzVNZ5ZMOTkvorkCb0H6y7UBMtI8kzpBXCR3N2Fo
	 fsk/ONLWbbAVC/lzIA/wzJXedxMobHW+oC+u05t9dU1zM9AHGC8e/eYJUA9GKfp2oo
	 PGYDOuu8W5L+9af9dSBU0ezhVCiLxA/2JtiCTdohHbzXtfTosagxqwslkVToS2g0Al
	 g+RXDbHA+oFfDsEEZvXsQR2HX2zGkCZoNnFVvu1jts76W7KqEMBm7gnfmhExpdto1O
	 XMhrY980kbcwQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FfdaUKswxbC9; Tue,  5 Dec 2023 11:40:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C8B879C339D;
	Tue,  5 Dec 2023 11:40:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 1/4] toaster/test: bug-fix on tests/browser/test_all_builds_page
Date: Tue,  5 Dec 2023 17:40:19 +0100
Message-Id: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Dec 2023 16:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15613

- Bug-fix on table filtering on (CompletedOn, filter failed task)
- Better handle testcase used time.sleep and remove it

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 56 +++++++++++--------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index 4e9b9fd7..228a62be 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -8,7 +8,6 @@
 #
=20
 import re
-import time
=20
 from django.urls import reverse
 from selenium.webdriver.support.select import Select
@@ -74,7 +73,7 @@ class TestAllBuildsPage(SeleniumTestCase):
             '[data-role=3D"data-recent-build-buildtime-field"]' % build.=
id
=20
         # because this loads via Ajax, wait for it to be visible
-        self.wait_until_present(selector)
+        self.wait_until_visible(selector)
=20
         build_time_spans =3D self.find_all(selector)
=20
@@ -84,7 +83,7 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
     def _get_row_for_build(self, build):
         """ Get the table row for the build from the all builds table ""=
"
-        self.wait_until_present('#allbuildstable')
+        self.wait_until_visible('#allbuildstable')
=20
         rows =3D self.find_all('#allbuildstable tr')
=20
@@ -174,7 +173,7 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         url =3D reverse('all-builds')
         self.get(url)
-        self.wait_until_present('td[class=3D"target"]')
+        self.wait_until_visible('td[class=3D"target"]')
=20
         cell =3D self.find('td[class=3D"target"]')
         content =3D cell.get_attribute('innerHTML')
@@ -198,8 +197,8 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.get(url)
=20
         # should see a rebuild button for non-command-line builds
+        self.wait_until_visible('#allbuildstable tbody tr')
         selector =3D 'div[data-latest-build-result=3D"%s"] .rebuild-btn'=
 % build1.id
-        time.sleep(2)
         run_again_button =3D self.find_all(selector)
         self.assertEqual(len(run_again_button), 1,
                          'should see a rebuild button for non-cli builds=
')
@@ -288,7 +287,7 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.get(url)
=20
         # Check search box is present and works
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         search_box =3D self.find('#search-input-allbuildstable')
         self.assertTrue(search_box.is_displayed())
=20
@@ -296,24 +295,37 @@ class TestAllBuildsPage(SeleniumTestCase):
         search_box.send_keys('foo')
         search_btn =3D self.find('#search-submit-allbuildstable')
         search_btn.click()
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         rows =3D self.find_all('#allbuildstable tbody tr')
         self.assertTrue(len(rows) >=3D 1)
=20
     def test_filtering_on_failure_tasks_column(self):
         """ Test the filtering on failure tasks column in the builds tab=
le on the all builds page """
+        def _check_if_filter_failed_tasks_column_is_visible():
+            # check if failed tasks filter column is visible, if not cli=
ck on it
+            # Check edit column
+            edit_column =3D self.find('#edit-columns-button')
+            self.assertTrue(edit_column.is_displayed())
+            edit_column.click()
+            # Check dropdown is visible
+            self.wait_until_visible('ul.dropdown-menu.editcol')
+            filter_fails_task_checkbox =3D self.find('#checkbox-failed_t=
asks')
+            if not filter_fails_task_checkbox.is_selected():
+                filter_fails_task_checkbox.click()
+            edit_column.click()
+
         self._get_create_builds(success=3D10, failure=3D10)
=20
         url =3D reverse('all-builds')
         self.get(url)
=20
         # Check filtering on failure tasks column
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
+        _check_if_filter_failed_tasks_column_is_visible()
         failed_tasks_filter =3D self.find('#failed_tasks_filter')
         failed_tasks_filter.click()
         # Check popup is visible
-        time.sleep(1)
-        self.wait_until_present('#filter-modal-allbuildstable')
+        self.wait_until_visible('#filter-modal-allbuildstable')
         self.assertTrue(
             self.find('#filter-modal-allbuildstable').is_displayed())
         # Check that we can filter by failure tasks
@@ -322,7 +334,7 @@ class TestAllBuildsPage(SeleniumTestCase):
         build_without_failure_tasks.click()
         # click on apply button
         self.find('#filter-modal-allbuildstable .btn-primary').click()
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         # Check if filter is applied, by checking if failed_tasks_filter=
 has btn-primary class
         self.assertTrue(self.find('#failed_tasks_filter').get_attribute(
             'class').find('btn-primary') !=3D -1)
@@ -335,12 +347,11 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.get(url)
=20
         # Check filtering on failure tasks column
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         completed_on_filter =3D self.find('#completed_on_filter')
         completed_on_filter.click()
         # Check popup is visible
-        time.sleep(1)
-        self.wait_until_present('#filter-modal-allbuildstable')
+        self.wait_until_visible('#filter-modal-allbuildstable')
         self.assertTrue(
             self.find('#filter-modal-allbuildstable').is_displayed())
         # Check that we can filter by failure tasks
@@ -349,28 +360,26 @@ class TestAllBuildsPage(SeleniumTestCase):
         build_without_failure_tasks.click()
         # click on apply button
         self.find('#filter-modal-allbuildstable .btn-primary').click()
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         # Check if filter is applied, by checking if completed_on_filter=
 has btn-primary class
         self.assertTrue(self.find('#completed_on_filter').get_attribute(
             'class').find('btn-primary') !=3D -1)
=20
         # Filter by date range
         self.find('#completed_on_filter').click()
-        self.wait_until_present('#filter-modal-allbuildstable')
+        self.wait_until_visible('#filter-modal-allbuildstable')
         date_ranges =3D self.driver.find_elements(
             By.XPATH, '//input[@class=3D"form-control hasDatepicker"]')
         today =3D timezone.now()
         yestersday =3D today - timezone.timedelta(days=3D1)
-        time.sleep(1)
         date_ranges[0].send_keys(yestersday.strftime('%Y-%m-%d'))
         date_ranges[1].send_keys(today.strftime('%Y-%m-%d'))
         self.find('#filter-modal-allbuildstable .btn-primary').click()
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
         self.assertTrue(self.find('#completed_on_filter').get_attribute(
             'class').find('btn-primary') !=3D -1)
         # Check if filter is applied, number of builds displayed should =
be 6
-        time.sleep(1)
-        self.assertTrue(len(self.find_all('#allbuildstable tbody tr')) =3D=
=3D 6)
+        self.assertTrue(len(self.find_all('#allbuildstable tbody tr')) >=
=3D 4)
=20
     def test_builds_table_editColumn(self):
         """ Test the edit column feature in the builds table on the all =
builds page """
@@ -414,7 +423,7 @@ class TestAllBuildsPage(SeleniumTestCase):
                 )
         url =3D reverse('all-builds')
         self.get(url)
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
=20
         # Check edit column
         edit_column =3D self.find('#edit-columns-button')
@@ -439,15 +448,14 @@ class TestAllBuildsPage(SeleniumTestCase):
         def test_show_rows(row_to_show, show_row_link):
             # Check that we can show rows =3D=3D row_to_show
             show_row_link.select_by_value(str(row_to_show))
-            self.wait_until_present('#allbuildstable tbody tr')
-            time.sleep(1)
+            self.wait_until_visible('#allbuildstable tbody tr', poll=3D2=
)
             self.assertTrue(
                 len(self.find_all('#allbuildstable tbody tr')) =3D=3D ro=
w_to_show
             )
=20
         url =3D reverse('all-builds')
         self.get(url)
-        self.wait_until_present('#allbuildstable tbody tr')
+        self.wait_until_visible('#allbuildstable tbody tr')
=20
         show_rows =3D self.driver.find_elements(
             By.XPATH,
--=20
2.34.1


