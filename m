Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EFAC61D96
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:49:39 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.40810.1700574572898984384
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:49:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=B6yyJFuQ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3DDD89C36BF
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:49:32 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id PeiIXsBpgxpd; Tue, 21 Nov 2023 08:49:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ADA719C36C1;
	Tue, 21 Nov 2023 08:49:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ADA719C36C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574571; bh=10jhvho+Il+JZMtpYceJTQA5sSoSxGIIaMomFyVHKz4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=B6yyJFuQeMUt5b6XDMu2HEtnVc50bPtJsAYSbKAqzJLhTcD4d7hKZ4O9l6zHAS3eR
	 /S7PNIrudrtQGlsejLV/VQaKYK6JKr2M/07o1QpGh1QrvgreoGEOphEXpBYxl9J9NA
	 8l7DeuSAbvuwZFuZafvpMCsjmCX7RLYfw02jzrelG3SkoX3PY5JmERnvIoBgXwy6gY
	 DpgcFRmEcigLmksyg8diuoE239E4/rXCYu2JwwamfdBDKwudN0VgA2Z0rOIqsrup9P
	 NbuXlHKUTS7locG7JQqMVgzZELsrziU8bUF/kt2CwaA6DO4MGgOFQKvQZ8m+V//8pA
	 jvq76JwNK/iHg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7ZFfxy_wxGrL; Tue, 21 Nov 2023 08:49:31 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CEB539C3500;
	Tue, 21 Nov 2023 08:49:30 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 4/4] Toaster: Write UI TestCase -> Test project page has right tabs displayed
Date: Tue, 21 Nov 2023 14:49:18 +0100
Message-Id: <20231121134918.101006-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
References: <20231121134918.101006-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:49:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15551

Test project tabs:
  - "configuration" tab
  - "Builds" tab
  - "Import layers" tab
  - "New custom image" tab
  Check search box used to build recipes

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index a83a994b..3edf967a 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -167,3 +167,81 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue(
             'New Name' in str(self.find('#project-name-container').text)
         )
+
+    def test_project_page_tabs(self):
+        """ Test project tabs:
+          - "configuration" tab
+          - "Builds" tab
+          - "Import layers" tab
+          - "New custom image" tab
+          Check search box used to build recipes
+        """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # check "configuration" tab
+        self.wait_until_visible('#topbar-configuration-tab')
+        config_tab =3D self.find('#topbar-configuration-tab')
+        self.assertTrue(config_tab.get_attribute('class') =3D=3D 'active=
')
+        self.assertTrue('Configuration' in config_tab.text)
+        config_tab_link =3D config_tab.find_element(By.TAG_NAME, 'a')
+        self.assertTrue(
+            f"/toastergui/project/1" in str(config_tab_link.get_attribut=
e(
+                'href'))
+        )
+
+        def get_tabs():
+            # tabs links list
+            return self.driver.find_elements(
+                By.XPATH,
+                '//div[@id=3D"project-topbar"]//li'
+            )
+
+        def check_tab_link(tab_index, tab_name, url):
+            tab =3D get_tabs()[tab_index]
+            tab_link =3D tab.find_element(By.TAG_NAME, 'a')
+            self.assertTrue(url in tab_link.get_attribute('href'))
+            self.assertTrue(tab_name in tab_link.text)
+            self.assertTrue(tab.get_attribute('class') =3D=3D 'active')
+
+        # check "Builds" tab
+        builds_tab =3D get_tabs()[1]
+        builds_tab.find_element(By.TAG_NAME, 'a').click()
+        check_tab_link(
+            1,
+            'Builds',
+            f"/toastergui/project/1/builds"
+        )
+
+        # check "Import layers" tab
+        import_layers_tab =3D get_tabs()[2]
+        import_layers_tab.find_element(By.TAG_NAME, 'a').click()
+        check_tab_link(
+            2,
+            'Import layer',
+            f"/toastergui/project/1/importlayer"
+        )
+
+        # check "New custom image" tab
+        new_custom_image_tab =3D get_tabs()[3]
+        new_custom_image_tab.find_element(By.TAG_NAME, 'a').click()
+        check_tab_link(
+            3,
+            'New custom image',
+            f"/toastergui/project/1/newcustomimage"
+        )
+
+        # check search box can be use to build recipes
+        search_box =3D self.find('#build-input')
+        search_box.send_keys('core-image-minimal')
+        self.find('#build-button').click()
+        self.wait_until_visible('#latest-builds')
+        lastest_builds =3D self.driver.find_elements(
+            By.XPATH,
+            '//div[@id=3D"latest-builds"]',
+        )
+        last_build =3D lastest_builds[0]
+        self.assertTrue(
+            'core-image-minimal' in str(last_build.text)
+        )
--=20
2.34.1


