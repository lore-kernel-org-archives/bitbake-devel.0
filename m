Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B25AC4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 22:15:30 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.14836.1699568124088414983
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 14:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=k6werMnU;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B78629C34CB
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 17:15:22 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id UrgkQWDxITxI; Thu,  9 Nov 2023 17:15:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0CF509C2D22;
	Thu,  9 Nov 2023 17:15:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0CF509C2D22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699568122; bh=eqbkR8nD5mdfw6OFyTWm9llMg0npwMTZmlZCcxBAXdA=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=k6werMnU5cI5OiDggWFwZQ2BmUwKnx4IfCBq7WgAVi9aqBWxLNKHSSFBpXtv+Ismo
	 npqoShHe/39fXmxq2/kHpyUdVKNvHQuopCJVdm9mCpif+OJor+AdnhEvYiHPRw7g80
	 PXsVL3ax/lNhdW2iX/fwWg0peO0wEpVChrPgyZanQTu9B10DNnfw1OkyTxGDKTlOQQ
	 zRFezWMShSegBQlSa20XfUtQhgzpP7PKe35MBZ3ALUxE5ykd3Xf/jiiQcVcvPJe5jN
	 /06hT//PfvBsISKjD2vzd3GlAemCLKW5Uno2SKWl/fehL92yw5GQbElodT4Dw+MB6w
	 K80rxdVLQCIkA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ciwoefSiCaWU; Thu,  9 Nov 2023 17:15:22 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2E1889C2BAF;
	Thu,  9 Nov 2023 17:15:21 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 1/3] Toaster: Write UI TestCase create new project
Date: Thu,  9 Nov 2023 23:15:15 +0100
Message-Id: <20231109221517.110357-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 22:15:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15487

Test create new project using:
- Project Name: Any string
- Release: Master/Kirkstone/Dunfell/Local
- Merge Toaster settings: False/True

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 lib/toaster/tests/functional/test_create_new_project.=
py

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
new file mode 100644
index 00000000..81355eaf
--- /dev/null
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -0,0 +1,134 @@
+#! /usr/bin/env python3 #
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import re
+import pytest
+from django.urls import reverse
+from selenium.webdriver.support.ui import Select
+from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
+from orm.models import Project
+from selenium.webdriver.common.by import By
+
+@pytest.mark.django_db
+class TestCreateNewProject(SeleniumFunctionalTestCase):
+
+    def _create_test_new_project(
+        self,
+        project_name,
+        release,
+        release_title,
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
+        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        self.assertTrue(
+            self.element_exists('#project-created-notification'),=20
+            f"Project:{project_name} creation notification not shown"
+        )
+        self.assertTrue(
+            project_name in element.text,
+            f"New project name:{project_name} not in new project notific=
ation"
+        )
+        self.assertTrue(
+            Project.objects.filter(name=3Dproject_name).count(),=20
+            f"New project:{project_name} not found in database"
+        )
+
+        # check release
+        self.assertTrue(re.search(
+            release_title,
+            self.driver.find_element(By.XPATH,
+                                     "//span[@id=3D'project-release-titl=
e']"
+                                     ).text),
+                        'The project release is not defined')
+
+    def test_create_new_project_master(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project master (option value: 3)
+          - Merge Toaster settings: False
+        """
+        release =3D '3'
+        release_title =3D 'Yocto Project master'
+        project_name =3D 'projectmaster'
+        self._create_test_new_project(
+            project_name,
+            release,
+            release_title,
+            False,
+        )
+
+    def test_create_new_project_kirkstone(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 4.0 "Kirkstone" (option value: 1)
+          - Merge Toaster settings: True
+        """
+        release =3D '1'
+        release_title =3D 'Yocto Project 4.0 "Kirkstone"'
+        project_name =3D 'projectkirkstone'
+        self._create_test_new_project(
+            project_name,
+            release,
+            release_title,
+            True,
+        )
+
+    def test_create_new_project_dunfull(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project 3.1 "Dunfell" (option value: 5)
+          - Merge Toaster settings: False
+        """
+        release =3D '5'
+        release_title =3D 'Yocto Project 3.1 "Dunfell"'
+        project_name =3D 'projectdunfull'
+        self._create_test_new_project(
+            project_name,
+            release,
+            release_title,
+            False,
+        )
+   =20
+    def test_create_new_project_local(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Local Yocto Project (option value: 2)
+          - Merge Toaster settings: True
+        """
+        release =3D '2'
+        release_title =3D 'Local Yocto Project'
+        project_name =3D 'projectlocal'
+        self._create_test_new_project(
+            project_name,
+            release,
+            release_title,
+            True,
+        )
--=20
2.34.1


