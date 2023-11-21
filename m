Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E98CC61D96
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:50 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40881.1700574701574166563
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=lHlp7j4N;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E144A9C366C
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:40 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gqcXY6EXk6WY; Tue, 21 Nov 2023 08:51:40 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 345C19C36BA;
	Tue, 21 Nov 2023 08:51:40 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 345C19C36BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574700; bh=Q3OYKsHc/2r4EYcWZ0ZtKDtExz84bdQgHnQwLANsz1I=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=lHlp7j4NLD+rnQqvz0xGE56Inp++Oia4tneMXd8sZrvPwBW72vV+17vWwBrnHXpP+
	 T1YyGjI8gu1/2J+CncLGY74J936DLEjMVJGhWF4+hCNGSW5qHoXFkmdRfGGF2fVcRP
	 oxBxu3dFDXOGnIEWhCQhCzAkl82M021O+bR8U4msZW+g5A9Dm3pQVwwNC8nj0WPuF3
	 /7kDw5Lre2kjXZOCxGoLkhjDNbnvHKJodF1qCoOdpj7m0T809LWNrB+kxkagohbyFI
	 sV4lzODhBxCBBufXO1uFp5+10ySt05J0Y3IpP/YWBIAS6iR3mQ74DXwZeDWA1YgDZ3
	 SEQJj1gx9tLSw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 9CLSdynzPlRv; Tue, 21 Nov 2023 08:51:40 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2C1379C33E8;
	Tue, 21 Nov 2023 08:51:38 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/7] Toaster: Write UI TestCase -> Test project page tab "New custom image"
Date: Tue, 21 Nov 2023 14:51:28 +0100
Message-Id: <20231121135131.107330-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15555

Test project page tab "New custom image" when no custom image

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 14a859a1..c6d952fd 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -349,3 +349,34 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         self.assertTrue(
             'meta-fake' in str(layers_list_items[-1].text)
         )
+
+    def test_project_page_custom_image_no_image(self):
+        """ Test project page tab "New custom image" when no custom imag=
e """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # navigate to "Custom image" tab
+        custom_image_section =3D self._get_config_nav_item(2)
+        custom_image_section.click()
+        self.wait_until_visible('#empty-state-customimagestable')
+
+        # Check message when no custom image
+        self.assertTrue(
+            "You have not created any custom images yet." in str(
+                self.find('#empty-state-customimagestable').text
+            )
+        )
+        div_empty_msg =3D self.find('#empty-state-customimagestable')
+        link_create_custom_image =3D div_empty_msg.find_element(
+            By.TAG_NAME, 'a')
+        self.assertTrue(
+            f"/toastergui/project/1/newcustomimage" in str(
+                link_create_custom_image.get_attribute('href')
+            )
+        )
+        self.assertTrue(
+            "Create your first custom image" in str(
+                link_create_custom_image.text
+            )
+        )
--=20
2.34.1


