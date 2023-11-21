Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E952C61D94
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:50 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.40882.1700574702451664132
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=syLdapmm;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C14899C3752
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:41 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id thQE6N3gmWVY; Tue, 21 Nov 2023 08:51:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3CC3D9C3676;
	Tue, 21 Nov 2023 08:51:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3CC3D9C3676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574701; bh=BO8FHi+Vs2rnZMyhZTz1/TT9VaYCIEBWFW+FRXpULF8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=syLdapmm73VbYPhsAFTbD+vGqlsWXHXW0B35n0yWqaiDmCBbbGZFsKMlbRTqJo/c7
	 OQDchEAfHsJSUJc9Nxl2797Wf8W3aIzalNHcP7Sg5zPqayFZfkx4fD82O9WunBhdpV
	 f4uWqZhwbAk6dyzD4do/1pTK/58WvunRx/5D2rLK8CaxmFhDTgV2OcfABtXCFMfsmp
	 j4Zw3pz0UPd+smijbY/IKsSVXRin8up+3NVmxwTAGr/Yk7wA6erWXnROekrjhRKej1
	 /gbMID+IgguIZjeM/ZAjPUirwjYf7DFw/XwvdHrFp2Df7+am+LKXAiK9f3unNzkWeV
	 zmUDn1Wynks0g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6fhBUkPLXuCp; Tue, 21 Nov 2023 08:51:41 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 63D459C3753;
	Tue, 21 Nov 2023 08:51:40 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 5/7] Toaster: Write UI TestCase -> Test project page section images
Date: Tue, 21 Nov 2023 14:51:29 +0100
Message-Id: <20231121135131.107330-5-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15556

BUILD IMAGE RECIPES: toastergui/project/{id}/images/
Test project page section images
    - Check image recipes are displayed
    - Check search input
    - Check image recipe build button works
    - Check image recipe table features(show/hide column, pagination)

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index c6d952fd..598a8055 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -380,3 +380,44 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
                 link_create_custom_image.text
             )
         )
+
+    def test_project_page_image_recipe(self):
+        """ Test project page section images
+            - Check image recipes are displayed
+            - Check search input
+            - Check image recipe build button works
+            - Check image recipe table features(show/hide column, pagina=
tion)
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+        self.wait_until_visible('#config-nav')
+
+        # navigate to "Images section"
+        images_section =3D self._get_config_nav_item(3)
+        images_section.click()
+        self.wait_until_visible('#imagerecipestable')
+        rows =3D self.find_all('#imagerecipestable tbody tr')
+        self.assertTrue(len(rows) > 0)
+
+        # Test search input
+        self.wait_until_visible('#search-input-imagerecipestable')
+        recipe_input =3D self.find('#search-input-imagerecipestable')
+        recipe_input.send_keys('core-image-minimal')
+        self.find('#search-submit-imagerecipestable').click()
+        rows =3D self.find_all('#imagerecipestable tbody tr')
+        self.assertTrue(len(rows) > 0)
+
+        # Test build button
+        image_to_build =3D rows[0]
+        build_btn =3D image_to_build.find_element(
+            By.XPATH,
+            '//td[@class=3D"add-del-layers"]'
+        )
+        build_btn.click()
+        self._wait_until_build('parsing starting cloning')
+        lastest_builds =3D self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"latest-builds"]/div'
+        )
+        self.assertTrue(len(lastest_builds) > 0)
--=20
2.34.1


