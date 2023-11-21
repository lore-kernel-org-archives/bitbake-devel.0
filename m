Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB81C61D96
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:48:19 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40784.1700574494008005738
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:48:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HP9T8V3Y;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 43B719C3500
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:48:13 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5RuBn4obBZjU; Tue, 21 Nov 2023 08:48:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8A8A89C36C5;
	Tue, 21 Nov 2023 08:48:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8A8A89C36C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574492; bh=djfVLsXamiYxkxnSgTlSvpB11XtKkDD8DQe77RnLLgs=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HP9T8V3Yv5CgwRrfuHSVIROmeosq3TWbdEEYV3tPVPFMOB4Swd8+zoMw4q5D7FO1C
	 xYwSJK6eTAeG5KcMeuJlb8TY+QhevY5qQrOM4HsQ/jpElK3dAkITuERSc7qlqy4m8T
	 GeOx9PbPdZ5eC3tsJ2t3zzaslpOrgc0oE3DIpIITfLpA+SUwMvnDY3rh0zYP3z2x2l
	 S9UCSUw8AgvbjR6BK1dEzyH3J5lekReZWs+mF42dMsgRNO+6mqWj/77dkB5NUrcPEX
	 AWIe+UY818+G1n0xRxAMZiOvVqv6WuT1bYgjmkmjQM6ZNlNNC6dJufZG+1H7UcFNKS
	 PLgIuRGIwD6vQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3mZhmvYDfpHW; Tue, 21 Nov 2023 08:48:12 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AA51D9C36BF;
	Tue, 21 Nov 2023 08:48:11 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/3] Toaster: Toaster: Write UI TestCase -> Visualize all projects
Date: Tue, 21 Nov 2023 14:47:59 +0100
Message-Id: <20231121134801.97718-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15545

Test the search box in the all project table on the all projects page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_projects_page.py   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/toaster/tests/browser/test_all_projects_page.py b/lib/to=
aster/tests/browser/test_all_projects_page.py
index 3389d323..db25e723 100644
--- a/lib/toaster/tests/browser/test_all_projects_page.py
+++ b/lib/toaster/tests/browser/test_all_projects_page.py
@@ -8,9 +8,11 @@
 #
=20
 import re
+import time
=20
 from django.urls import reverse
 from django.utils import timezone
+from selenium.webdriver.support.select import Select
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import BitbakeVersion, Release, Project, Build
@@ -37,6 +39,17 @@ class TestAllProjectsPage(SeleniumTestCase):
=20
         self.release =3D None
=20
+    def _create_projects(self, nb_project=3D10):
+        projects =3D []
+        for i in range(1, nb_project + 1):
+            projects.append(
+                Project(
+                    name=3D'test project {}'.format(i),
+                    release=3Dself.release,
+                )
+            )
+        Project.objects.bulk_create(projects)
+
     def _add_build_to_default_project(self):
         """ Add a build to the default project (not used in all tests) "=
""
         now =3D timezone.now()
@@ -205,3 +218,24 @@ class TestAllProjectsPage(SeleniumTestCase):
         expected_url =3D reverse('project', args=3D(self.project.id,))
         msg =3D 'link on project name should point to configuration but =
was %s' % link_url
         self.assertTrue(link_url.endswith(expected_url), msg)
+
+    def test_allProject_table_search_box(self):
+        """ Test the search box in the all project table on the all proj=
ects page """
+        self._create_projects()
+
+        url =3D reverse('all-projects')
+        self.get(url)
+
+        # Chseck search box is present and works
+        self.wait_until_present('#projectstable tbody tr')
+        search_box =3D self.find('#search-input-projectstable')
+        self.assertTrue(search_box.is_displayed())
+
+        # Check that we can search for a project by project name
+        search_box.send_keys('test project 10')
+        search_btn =3D self.find('#search-submit-projectstable')
+        search_btn.click()
+        self.wait_until_present('#projectstable tbody tr')
+        time.sleep(1)
+        rows =3D self.find_all('#projectstable tbody tr')
+        self.assertTrue(len(rows) =3D=3D 1)
--=20
2.34.1


