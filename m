Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6160CC61D97
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:50 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.40853.1700574704768404257
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=nlurBQdh;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1BEF39C36A3
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:44 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id t72skQL_SxTe; Tue, 21 Nov 2023 08:51:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 937F49C3673;
	Tue, 21 Nov 2023 08:51:43 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 937F49C3673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574703; bh=A8MHLGVnvqtQ9Zx2XwD5LNYAiQhk68G8NOHXHI5pMDI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nlurBQdhagQqabh550lrMC3G7mLIWDzDwzjlVcPHkBOyQVptu1hJY3skywwPEAdmF
	 Gm9TDLpI3LiboZSrcNJ2dezQS/1M5xmX3H9ouYUFqMKNMc1SBdP1+3RRDxsDMZ/zyx
	 /l9M4MCq7GWIr2qQhBV/TDkZlm9n8ELzs21xQBvm7QIxQsjBRVNZRS6iwTcLoBMFuT
	 NoWdrXhjhA5+whS/r2kPyvoqfYaYtSYJYVgtb+OEKszz7fKkiMAdjXBYDY4bhblGdj
	 DdvIy/9D+SYsc5pcEavXG3CMpB2+Sy8HQutNTNluFZkpSlavZBDxRGS4ZzHEOQ2yW3
	 8+TYj2SkHP+Eg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 2jn8mDhaOkfK; Tue, 21 Nov 2023 08:51:43 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B4F0F9C3752;
	Tue, 21 Nov 2023 08:51:42 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 7/7] Toaster: Write UI TestCase -> Test the show rows feature in image recipe
Date: Tue, 21 Nov 2023 14:51:31 +0100
Message-Id: <20231121135131.107330-7-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15558

Test the show rows feature in image recipe table on project page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index 2dfc120d..23012d78 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -347,7 +347,10 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
             By.XPATH, '//*[@id=3D"project-page"]/div[1]/div[3]')
         recipe_list =3D most_built_recipes.find_element(By.ID, 'freq-bui=
ld-list')
         recipe_list_items =3D recipe_list.find_elements(By.TAG_NAME, 'li=
')
-        self.assertTrue(len(recipe_list_items) > 0)
+        self.assertTrue(
+            len(recipe_list_items) > 0,
+            msg=3D"No recipes found in the most built recipes list",
+        )
         checkbox =3D recipe_list_items[0].find_element(By.TAG_NAME, 'inp=
ut')
         checkbox.click()
         build_btn =3D self.find('#freq-build-btn')
@@ -465,6 +468,7 @@ class TestProjectConfigTab(SeleniumFunctionalTestCase=
):
         recipe_input =3D self.find('#search-input-imagerecipestable')
         recipe_input.send_keys('core-image-minimal')
         self.find('#search-submit-imagerecipestable').click()
+        self.wait_until_visible('#imagerecipestable tbody tr')
         rows =3D self.find_all('#imagerecipestable tbody tr')
         self.assertTrue(len(rows) > 0)
=20
@@ -542,3 +546,33 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         test_edit_column('checkbox-recipe-file')
         test_edit_column('checkbox-section')
         test_edit_column('checkbox-version')
+
+    def test_image_recipe_show_rows(self):
+        """ Test the show rows feature in image recipe table on project =
page """
+        self._get_create_builds(success=3D100, failure=3D100)
+
+        def test_show_rows(row_to_show, show_row_link):
+            # Check that we can show rows =3D=3D row_to_show
+            show_row_link.select_by_value(str(row_to_show))
+            self.wait_until_present('#imagerecipestable tbody tr')
+            sleep(1)
+            self.assertTrue(
+                len(self.find_all('#imagerecipestable tbody tr')) =3D=3D=
 row_to_show
+            )
+
+        url =3D reverse('projectimagerecipes', args=3D(2,))
+        self.get(url)
+        self.wait_until_present('#imagerecipestable tbody tr')
+
+        show_rows =3D self.driver.find_elements(
+            By.XPATH,
+            '//select[@class=3D"form-control pagesize-imagerecipestable"=
]'
+        )
+        # Check show rows
+        for show_row_link in show_rows:
+            show_row_link =3D Select(show_row_link)
+            test_show_rows(10, show_row_link)
+            test_show_rows(25, show_row_link)
+            test_show_rows(50, show_row_link)
+            test_show_rows(100, show_row_link)
+            test_show_rows(150, show_row_link)
--=20
2.34.1


