Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62618C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 20:11:11 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.42931.1698955866744565256
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 13:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HVToG0P1;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 38A859C32E4
	for <bitbake-devel@lists.openembedded.org>; Thu,  2 Nov 2023 16:11:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id JHtXeipHzBPY; Thu,  2 Nov 2023 16:11:00 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1BC159C33AD;
	Thu,  2 Nov 2023 16:11:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 1BC159C33AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698955860; bh=BHSs2+J3P2EZ6qGCW8DixKVsT/7JPMyK6ImOEt63Z6A=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HVToG0P1tOeA0LB4/nN6yFK/mGaDFmxVciThiLd1Z2EUbWo5Sp85mG0FQRnkKDWGH
	 wpmK5SVlDQEYMGI4tC+P87FyNia9h3kvAuePBAvKcnDE744Wtg6Q+16jqesgIdTVmc
	 PQIIeo+gPRqOV7qq5/SWxUAUmXHuQhfRUmrhUgslB9WDipxWP2fWQjllAbFZuSyMc1
	 PAxRKHnR8kO4hIBOxiLtfODhu6hVtzgFTjLdPsik0iQMs2EEBaB1ECskLE3KKu89BF
	 KoK+f5hDvXyhKzj8hQemSEO1TjXPoq/o43sy3oVk3vOI9xaD/Y6ApFlukeVWbW28us
	 R7vLOEoe0tiqw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id KLci7r2hyhi6; Thu,  2 Nov 2023 16:11:00 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3976A9C32E4;
	Thu,  2 Nov 2023 16:10:59 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Toaster: Write UI TestCase > Delete project
Date: Thu,  2 Nov 2023 21:10:54 +0100
Message-Id: <20231102201054.145745-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 20:11:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15419

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_delete_project.py      | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 lib/toaster/tests/browser/test_delete_project.py

diff --git a/lib/toaster/tests/browser/test_delete_project.py b/lib/toast=
er/tests/browser/test_delete_project.py
new file mode 100644
index 00000000..2f431c5c
--- /dev/null
+++ b/lib/toaster/tests/browser/test_delete_project.py
@@ -0,0 +1,98 @@
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
+        """ Test delete a project with the given name """
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


