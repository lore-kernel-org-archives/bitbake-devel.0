Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8101C61D94
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:49:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40821.1700574571696304169
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:49:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=B7RjGkKS;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0B2579C3752
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:49:31 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 7EUrTlQsVrna; Tue, 21 Nov 2023 08:49:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 833439C36BF;
	Tue, 21 Nov 2023 08:49:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 833439C36BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574570; bh=OeHbi7YpXhHR12AZ8dOnZsWcH0pEGtKdbkvaDGMJO2c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=B7RjGkKSzB4LJQ9lZwJsZr4WTZ/cky273zfJ8t0gXAbJ/1rtGXGdpAUqnASZPL7sZ
	 WqrI2d+IQTJYAHnAfomraWcOjXGtxf82JS5nD2MhW+LzN6k1NWUr3X/RhEHXFPQDID
	 p1COBU6HdcWMeW2QW6XDi0FgkDWiMi9QlGH554uZ6wLj4ItvzUytLZixi/bq95zWcT
	 uI/8dUIH7OHL66oIMtbu4egGEsARW7xewVRUlLEH/BkYDYm9EcJPGnu97JNqPP4k7R
	 P8OeY3g47h4ZlgHfpuUdgZ//DgxPH2J6A4+TFcT+DIhObw7uIsSa+EcbaTmjkSOIq5
	 1U8Zl4E1GvGRg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id a0V7Vm0SrWzH; Tue, 21 Nov 2023 08:49:30 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AFEBD9C3500;
	Tue, 21 Nov 2023 08:49:29 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/4] Toaster: Write UI TestCase -> Test edit project name on project page
Date: Tue, 21 Nov 2023 14:49:17 +0100
Message-Id: <20231121134918.101006-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:49:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15550

Test edit project name:
  - Click on "Edit" icon button
  - Change project name
  - Click on "Save" button
  - Check project name is changed

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index f77437f0..a83a994b 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -140,3 +140,30 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue(
             '/toastergui/newproject/' in str(self.driver.current_url)
         )
+
+    def test_edit_project_name(self):
+        """ Test edit project name:
+          - Click on "Edit" icon button
+          - Change project name
+          - Click on "Save" button
+          - Check project name is changed
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # click on "Edit" icon button
+        self.wait_until_visible('#project-name-container')
+        edit_button =3D self.find('#project-change-form-toggle')
+        edit_button.click()
+        project_name_input =3D self.find('#project-name-change-input')
+        self.assertTrue(project_name_input.is_displayed())
+        project_name_input.clear()
+        project_name_input.send_keys('New Name')
+        self.find('#project-name-change-btn').click()
+
+        # check project name is changed
+        self.wait_until_visible('#project-name-container')
+        self.assertTrue(
+            'New Name' in str(self.find('#project-name-container').text)
+        )
--=20
2.34.1


