Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D66C4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1273.1698876813439948840
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=eL5vBeDY;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7FB9F9C33C5
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:29 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YIHXkRGpL2D1; Wed,  1 Nov 2023 18:13:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 626F49C3369;
	Wed,  1 Nov 2023 18:13:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 626F49C3369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876804; bh=NoK4hE1FLfEI7njH+YDpHmOAuL+kStL1Imfptcwm9m4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=eL5vBeDYeVMVZ90fLCNiyQhpfUuvF5ziJXiLDKyBaqroTulMGURqjOQ9hAyugV+bl
	 ZSAYXJRcz8jP/ZZogE9K6G5pa3GAWgTgC03McpZ8ndrsvL7tmaVfRDFL85ajHrIoN/
	 1X2QvAe/Zf7e3t78wwsloKOh/XRdEOHPpl5EaJXWmlrDBo/2X0GZQQYwYHWlOzUDaE
	 gyh9YwX22bwhABGVPjSfGBWe8l+XULRp9LMDQeUczoq8PbRkOxeDTa6QfY2c4rZpha
	 jED2V2RAypqzH4gV3APvEbUsDDviiHT8ptgPQ0IrOW+aIV/J6+EZp+l+gm3kK5Iusf
	 An56Q6w5YozxA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id gWAGSc5K0yTL; Wed,  1 Nov 2023 18:13:24 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C3A9B9C314F;
	Wed,  1 Nov 2023 18:13:22 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/8] Toaster: Write UI TestCase create new Master project
Date: Wed,  1 Nov 2023 23:13:07 +0100
Message-Id: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15405

Test create new project using:
- Project Name: Any string
- Release: Yocto Project master (option value: 3)
- Merge Toaster settings: False

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 lib/toaster/tests/functional/test_create_new_project.=
py

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
new file mode 100644
index 00000000..2b3c98ac
--- /dev/null
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -0,0 +1,57 @@
+#! /usr/bin/env python3
+#
+# BitBake Toaster UI tests implementation
+#
+# Copyright (C) 2023 Savoir-faire Linux Inc
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
+    def test_create_new_project_master(self):
+        """ Test create new project using:
+          - Project Name: Any string
+          - Release: Yocto Project master (option value: 3)
+          - Merge Toaster settings: False
+        """
+        release =3D 'Yocto Project master'
+        project_name =3D 'projectmaster'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+
+        select =3D Select(self.find('#projectversion'))
+        select.select_by_value(str(3))
+
+        # uncheck merge toaster settings
+        checkbox =3D self.find('.checkbox-mergeattr')
+        if checkbox.is_selected():
+            checkbox.click()
+
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+        element =3D self.wait_until_visible('#project-created-notificati=
on')
+        self.assertTrue(self.element_exists('#project-created-notificati=
on'),
+                        'Project creation notification not shown')
+        self.assertTrue(project_name in element.text,
+                        "New project name not in new project notificatio=
n")
+        self.assertTrue(Project.objects.filter(name=3Dproject_name).coun=
t(),
+                        "New project not found in database")
+
+        # check release
+        self.assertTrue(re.search(
+            release,
+            self.driver.find_element(By.XPATH,
+                                     "//span[@id=3D'project-release-titl=
e']"
+                                     ).text),
+                        'The project release is not defined')
--=20
2.34.1


