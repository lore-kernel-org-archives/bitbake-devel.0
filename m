Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F93C4167B
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 22:13:42 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.1282.1698876821224103986
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 15:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=yFps+pjx;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9003D9C33C5
	for <bitbake-devel@lists.openembedded.org>; Wed,  1 Nov 2023 18:13:39 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 0an72s6fwaWG; Wed,  1 Nov 2023 18:13:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E26699C3369;
	Wed,  1 Nov 2023 18:13:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E26699C3369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698876814; bh=uKLtkl+Mmj5NAwt4qqoROnPsRex/rl94y2+6yGNaius=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=yFps+pjxikQCFLFemen2J7zdyejcRz2lvLwvc9xpSUSf/LmkX1F66BmZPU3eBBPM1
	 YqtWVGiDyojxdDzID8rMEzQ/gBvih7mrvfpcfvVjR/RBcwWQO9hfmx6A2AFcqVJ+Zr
	 6OpHatUpSbTZPCqaPpD+CjUndCyoHzLW2HvZECmzX5oXGB1QBEmUIeVhRrW8DLYGMr
	 vWgwKB/ZTHtk/aXt2sB0vF7VsM7G5HowhQvvsrPncXso1jzS9M8WUGCMAuikOcHYUM
	 JNE1EZ2lbDVjZUitGNgsiOR/dwJqYWoyPZ7KTdW9r43ql/m/8cfO+oCVNjXg1fjJ4M
	 QCT+unk+r4OjQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P09JJLPxRCgq; Wed,  1 Nov 2023 18:13:34 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C7A819C33BA;
	Wed,  1 Nov 2023 18:13:33 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 8/8] Toaster: Write UI TestCase import new project using
Date: Wed,  1 Nov 2023 23:13:14 +0100
Message-Id: <20231101221314.236173-8-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
References: <20231101221314.236173-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 22:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15412

Test import new project using:
  - Project Name: Any string
  - Project type: select (Import command line project)
  - Import existing project directory: Wrong Path

Update copyright, remove "Inc"

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../functional/test_create_new_project.py     | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/li=
b/toaster/tests/functional/test_create_new_project.py
index 54e6231e..c04440d9 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -2,7 +2,7 @@
 #
 # BitBake Toaster UI tests implementation
 #
-# Copyright (C) 2023 Savoir-faire Linux Inc
+# Copyright (C) 2023 Savoir-faire Linux
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
@@ -225,3 +225,28 @@ class TestCreateNewProject(SeleniumFunctionalTestCas=
e):
         create_btn =3D self.driver.find_element(By.ID, "create-project-b=
utton")
         self.assertIsNotNone(create_btn.get_attribute('disabled'),
                         'Create button is not disabled')
+
+    def test_import_new_project(self):
+        """ Test import new project using:
+          - Project Name: Any string
+          - Project type: select (Import command line project)
+          - Import existing project directory: Wrong Path
+        """
+        project_name =3D 'projectimport'
+        self.get(reverse('newproject'))
+        self.driver.find_element(By.ID,
+                                 "new-project-name").send_keys(project_n=
ame)
+        # select import project
+        self.find('#type-import').click()
+
+        # set wrong path
+        wrong_path =3D '/wrongpath'
+        self.driver.find_element(By.ID,
+                                 "import-project-dir").send_keys(wrong_p=
ath)
+        self.driver.find_element(By.ID, "create-project-button").click()
+
+        # check error message
+        self.assertTrue(self.element_exists('.alert-danger'),
+                        'Allert message not shown')
+        self.assertTrue(wrong_path in self.find('.alert-danger').text,
+                        "Wrong path not in alert message")
--=20
2.34.1


