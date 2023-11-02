Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABEDC4167D
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 20:21:41 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.42880.1698956496962863773
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 13:21:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Iw7eBqJl;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3F3089C33EF
	for <bitbake-devel@lists.openembedded.org>; Thu,  2 Nov 2023 16:21:36 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 3psihwg643TL; Thu,  2 Nov 2023 16:21:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 377529C3408;
	Thu,  2 Nov 2023 16:21:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 377529C3408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698956491; bh=B67Q3TzN2T4ZmgiDLZ4Q3vzbDKdfs2Fq809ve7xr4DI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Iw7eBqJl7mZMmZooIJ1HBQBU4BM6Y/s+NpZ116oXOWgq8c6r88MIXDenGUWhwJc4E
	 D59Td+7XQteM1SzEBxTMHuGtCddGUG9FM8lb9GmS2nERlkB6Hhm2wVQrUOoBtmbuZu
	 BX0KbEWAhQKW80vRCP49dmYqfZ41BFI/0TWgc/BzQxLD0rJEbLLeE6Y5Zi87zmHi4y
	 PsAcvykDQ1KvVRMsV3fzR3JWEnxn7XT3MG2KnrttrupaNVI2lLfDJjcBhXC123LvUH
	 UW5aGd1YFy5UP15YU+vQL47Xdi5KrnKm9tmJkR8QiIP35hCp7XpAhqrmpqaRDCu7qc
	 HpYqFgKF00Uyw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id mqjsR7XQM-qJ; Thu,  2 Nov 2023 16:21:31 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9E0AE9C33FA;
	Thu,  2 Nov 2023 16:21:30 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2] Toaster: Write UI TestCase > Delete project
Date: Thu,  2 Nov 2023 21:21:27 +0100
Message-Id: <20231102202127.157247-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 20:21:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15420

Test delete project:
    - Check delete modal is visible
    - Check delete modal has right text
    - Confirm delete
    - Check project is deleted

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_delete_project.py      | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 lib/toaster/tests/browser/test_delete_project.py

diff --git a/lib/toaster/tests/browser/test_delete_project.py b/lib/toast=
er/tests/browser/test_delete_project.py
new file mode 100644
index 00000000..1941777c
--- /dev/null
+++ b/lib/toaster/tests/browser/test_delete_project.py
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux Inc
+#
+# SPDX-License-Identifier: GPL-2.0-only
+
+import pytest
+from django.urls import reverse
+from selenium.webdriver.support.ui import Select
+from tests.browser.selenium_helpers import SeleniumTestCase
+from orm.models import BitbakeVersion, Project, Release
+from selenium.webdriver.common.by import By
+
+class TestDeleteProject(SeleniumTestCase):
+
+    def setUp(self):
+        bitbake, _ =3D BitbakeVersion.objects.get_or_create(
+            name=3D"master",
+            giturl=3D"git://master",
+            branch=3D"master",
+            dirpath=3D"master")
+
+        self.release, _ =3D Release.objects.get_or_create(
+            name=3D"master",
+            description=3D"Yocto Project master",
+            branch_name=3D"master",
+            helptext=3D"latest",
+            bitbake_version=3Dbitbake)
+
+        Release.objects.get_or_create(
+            name=3D"foo",
+            description=3D"Yocto Project foo",
+            branch_name=3D"foo",
+            helptext=3D"latest",
+            bitbake_version=3Dbitbake)
+
+    @pytest.mark.django_db
+    def test_delete_project(self):
+        """ Test delete a project
+            - Check delete modal is visible
+            - Check delete modal has right text
+            - Confirm delete
+            - Check project is deleted
+        """
+        project_name =3D "project_to_delete"
+        url =3D reverse('newproject')
+        self.get(url)
+        self.enter_text('#new-project-name', project_name)
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(self.release.pk))
+        self.click("#create-project-button")
+        # We should get redirected to the new project's page with the
+        # notification at the top
+        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        self.assertTrue(project_name in element.text,
+                        "New project name not in new project notificatio=
n")
+        self.assertTrue(Project.objects.filter(name=3Dproject_name).coun=
t(),
+                        "New project not found in database")
+
+        # Delete project
+        delete_project_link =3D self.driver.find_element(
+            By.XPATH, '//a[@href=3D"#delete-project-modal"]')
+        delete_project_link.click()
+       =20
+        # Check delete modal is visible
+        self.wait_until_visible('#delete-project-modal')
+
+        # Check delete modal has right text
+        modal_header_text =3D self.find('#delete-project-modal .modal-he=
ader').text
+        self.assertTrue(
+            "Are you sure you want to delete this project?" in modal_hea=
der_text,
+            "Delete project modal header text is wrong")
+
+        modal_body_text =3D self.find('#delete-project-modal .modal-body=
').text
+        self.assertTrue(
+            "Cancel its builds currently in progress" in modal_body_text=
,
+            "Modal body doesn't contain: Cancel its builds currently in =
progress")
+        self.assertTrue(
+            "Remove its configuration information" in modal_body_text,
+            "Modal body doesn't contain: Remove its configuration inform=
ation")
+        self.assertTrue(
+            "Remove its imported layers" in modal_body_text,
+            "Modal body doesn't contain: Remove its imported layers")
+        self.assertTrue(
+            "Remove its custom images" in modal_body_text,
+            "Modal body doesn't contain: Remove its custom images")
+        self.assertTrue(
+            "Remove all its build information" in modal_body_text,
+            "Modal body doesn't contain: Remove all its build informatio=
n")
+
+        # Confirm delete
+        delete_btn =3D self.find('#delete-project-confirmed')
+        delete_btn.click()
+
+        # Check project is deleted
+        self.wait_until_visible('#change-notification')
+        delete_notification =3D self.find('#change-notification-msg')
+        self.assertTrue("You have deleted 1 project:" in delete_notifica=
tion.text)
+        self.assertTrue(project_name in delete_notification.text)
+        self.assertFalse(Project.objects.filter(name=3Dproject_name).exi=
sts(),
+                        "Project not deleted from database")
--=20
2.34.1


