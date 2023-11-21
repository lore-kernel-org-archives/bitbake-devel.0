Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A3BC61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:49:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40820.1700574570828803925
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:49:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=pGXYpRbH;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 289619C36C5
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:49:30 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id do3BkO-UUsGo; Tue, 21 Nov 2023 08:49:29 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 57A269C36BF;
	Tue, 21 Nov 2023 08:49:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 57A269C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574569; bh=Wk62GNpVUpUQQt+o7mbmw2L5cAI/0JJJDkEv2MFP92Q=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=pGXYpRbHL5Mwi12KepSL9rELbNm4O1jmSYlp7pKIBayGD8kpIbqlsxNM7S/KX4v1Y
	 3WgKwIy/PZQ/PwGKkptkbUBayaRtIN2s/e+LPdaiSjmFKTn+hZGMHDoLZj3qFqQFu/
	 KYwMAnTBewEi4jGsyyaOl9smcPfDYAk/erIvgrIbgrOc8UeoB7mVCsAkiL2OlJUbrC
	 QkzvbmOS/F/KS+pVVZ3BeZQMOq0p4MxxqlmCtg1kQnpk0ZAJaajukcGGWyHL/PaJHv
	 TMMS/EgsKurznX8lQQQPiD/GBMVL/V6AhBlQjEr9w/gXPV9pEmo5BPtaDXsesmddGQ
	 89BV16rZhQc3A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5fecS5aAawBo; Tue, 21 Nov 2023 08:49:29 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5F20E9C3500;
	Tue, 21 Nov 2023 08:49:28 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/4] Toaster: Write UI TestCase -> Check project header contains right items
Date: Tue, 21 Nov 2023 14:49:16 +0100
Message-Id: <20231121134918.101006-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:49:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15549

Check page header in project page:
  - AT LEFT -> Logo of Yocto project, displayed, clickable
  - "Toaster"+" Information icon", displayed, clickable
  - "Server Icon" + "All builds", displayed, clickable
  - "Directory Icon" + "All projects", displayed, clickable
  - "Book Icon" + "Documentation", displayed, clickable
  - AT RIGHT -> button "New project", displayed, clickable

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 lib/toaster/tests/functional/test_project_page.py

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
new file mode 100644
index 00000000..f77437f0
--- /dev/null
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -0,0 +1,142 @@
+#! /usr/bin/env python3 #
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import pytest
+from django.urls import reverse
+from selenium.webdriver.support.select import Select
+from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
+from selenium.webdriver.common.by import By
+
+
+@pytest.mark.django_db
+class TestProjectPage(SeleniumFunctionalTestCase):
+
+    def setUp(self):
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
+    def test_page_header_on_project_page(self):
+        """ Check page header in project page:
+          - AT LEFT -> Logo of Yocto project, displayed, clickable
+          - "Toaster"+" Information icon", displayed, clickable
+          - "Server Icon" + "All builds", displayed, clickable
+          - "Directory Icon" + "All projects", displayed, clickable
+          - "Book Icon" + "Documentation", displayed, clickable
+          - AT RIGHT -> button "New project", displayed, clickable
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # check page header
+        # AT LEFT -> Logo of Yocto project
+        logo =3D self.driver.find_element(
+            By.XPATH,
+            "//div[@class=3D'toaster-navbar-brand']",
+        )
+        logo_img =3D logo.find_element(By.TAG_NAME, 'img')
+        self.assertTrue(logo_img.is_displayed(),
+                        'Logo of Yocto project not found')
+        self.assertTrue(
+            '/static/img/logo.png' in str(logo_img.get_attribute('src'))=
,
+            'Logo of Yocto project not found'
+        )
+        # "Toaster"+" Information icon", clickable
+        toaster =3D self.driver.find_element(
+            By.XPATH,
+            "//div[@class=3D'toaster-navbar-brand']//a[@class=3D'brand']=
",
+        )
+        self.assertTrue(toaster.is_displayed(), 'Toaster not found')
+        self.assertTrue(toaster.text =3D=3D 'Toaster')
+        info_sign =3D self.find('.glyphicon-info-sign')
+        self.assertTrue(info_sign.is_displayed())
+
+        # "Server Icon" + "All builds"
+        all_builds =3D self.find('#navbar-all-builds')
+        all_builds_link =3D all_builds.find_element(By.TAG_NAME, 'a')
+        self.assertTrue("All builds" in all_builds_link.text)
+        self.assertTrue(
+            '/toastergui/builds/' in str(all_builds_link.get_attribute('=
href'))
+        )
+        server_icon =3D all_builds.find_element(By.TAG_NAME, 'i')
+        self.assertTrue(
+            server_icon.get_attribute('class') =3D=3D 'glyphicon glyphic=
on-tasks'
+        )
+        self.assertTrue(server_icon.is_displayed())
+
+        # "Directory Icon" + "All projects"
+        all_projects =3D self.find('#navbar-all-projects')
+        all_projects_link =3D all_projects.find_element(By.TAG_NAME, 'a'=
)
+        self.assertTrue("All projects" in all_projects_link.text)
+        self.assertTrue(
+            '/toastergui/projects/' in str(all_projects_link.get_attribu=
te(
+                'href'))
+        )
+        dir_icon =3D all_projects.find_element(By.TAG_NAME, 'i')
+        self.assertTrue(
+            dir_icon.get_attribute('class') =3D=3D 'icon-folder-open'
+        )
+        self.assertTrue(dir_icon.is_displayed())
+
+        # "Book Icon" + "Documentation"
+        toaster_docs_link =3D self.find('#navbar-docs')
+        toaster_docs_link_link =3D toaster_docs_link.find_element(By.TAG=
_NAME,
+                                                                'a')
+        self.assertTrue("Documentation" in toaster_docs_link_link.text)
+        self.assertTrue(
+            toaster_docs_link_link.get_attribute('href') =3D=3D 'http://=
docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manual'
+        )
+        book_icon =3D toaster_docs_link.find_element(By.TAG_NAME, 'i')
+        self.assertTrue(
+            book_icon.get_attribute('class') =3D=3D 'glyphicon glyphicon=
-book'
+        )
+        self.assertTrue(book_icon.is_displayed())
+
+        # AT RIGHT -> button "New project"
+        new_project_button =3D self.find('#new-project-button')
+        self.assertTrue(new_project_button.is_displayed())
+        self.assertTrue(new_project_button.text =3D=3D 'New project')
+        new_project_button.click()
+        self.assertTrue(
+            '/toastergui/newproject/' in str(self.driver.current_url)
+        )
--=20
2.34.1


