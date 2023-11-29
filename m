Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EF9C46CA0
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57339.1701298467176113134
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=S8af2QFV;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8656E9C3E05
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:26 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WR-XCF4C6zFy; Wed, 29 Nov 2023 17:54:26 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 066509C3679;
	Wed, 29 Nov 2023 17:54:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 066509C3679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298466; bh=azODbgQMA7T+CLSjhOhu5ZDmq3KKgjjsOx4WWniW9GI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=S8af2QFVeAnvLbeHSfCjhr9JE5RryGeCyIPY0YJnqlB3xz9iaqrjO08nBsegN4rHa
	 rE8iHA+MGxQoLgqVIj1Q4FVnhKCh43QszsOCXPljKQv2w4KlnA9B4Qt5iK+1gg6lCc
	 sLr2L7vrOoWdn9caVLVm1SvIuPMiDHweWsOcInsxVjLXfpNDlQxNH1QABo62NocwMn
	 T/zdS1harKYkOVZIrPqpANvkH8OEmEU4qOadMVSdnrcF3+MtPUOdFqh7EN0SLIuWIb
	 bteSQx4SJJZ/safySzdxaMeBSgE0nw0nIaKevq2o22bm3E2xCKEllrd53FOKz/Zs0r
	 UN+dtJS5teXKA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id SKywybqWQfpo; Wed, 29 Nov 2023 17:54:25 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 236049C3636;
	Wed, 29 Nov 2023 17:54:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 8/9] toaster/test: Test single layer page
Date: Wed, 29 Nov 2023 23:54:15 +0100
Message-Id: <20231129225416.479526-8-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15587

Test layer page
    - Check if title is displayed
    - Check add/remove layer button works
    - Check tabs(layers, recipes, machines) are displayed
    - Check left section is displayed
        - Check layer name
        - Check layer summary
        - Check layer description

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 70829509..771a8484 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -695,3 +695,64 @@ class TestProjectPage(SeleniumFunctionalTestCase):
             table_selector=3D'distrostable',
             to_skip=3D[150]
         )
+
+    def test_single_layer_page(self):
+        """ Test layer page
+            - Check if title is displayed
+            - Check add/remove layer button works
+            - Check tabs(layers, recipes, machines) are displayed
+            - Check left section is displayed
+                - Check layer name
+                - Check layer summary
+                - Check layer description
+        """
+        url =3D reverse("layerdetails", args=3D(1, 8))
+        self.get(url)
+        self.wait_until_visible('.page-header')
+        # check title is displayed
+        self.assertTrue(self.find('.page-header h1').is_displayed())
+
+        # check add layer button works
+        remove_layer_btn =3D self.find('#add-remove-layer-btn')
+        remove_layer_btn.click()
+        self.wait_until_visible('#change-notification', poll=3D2)
+        change_notification =3D self.find('#change-notification')
+        self.assertTrue(
+            f'You have removed 1 layer from your project' in str(change_=
notification.text)
+        )
+        # check add layer button works, 18 is the random layer id
+        add_layer_btn =3D self.find('#add-remove-layer-btn')
+        add_layer_btn.click()
+        self.wait_until_visible('#change-notification')
+        change_notification =3D self.find('#change-notification')
+        self.assertTrue(
+            f'You have added 1 layer to your project' in str(change_noti=
fication.text)
+        )
+        # check tabs(layers, recipes, machines) are displayed
+        tabs =3D self.find_all('.nav-tabs li')
+        self.assertEqual(len(tabs), 3)
+        # Check first tab
+        tabs[0].click()
+        self.assertTrue(
+            'active' in str(self.find('#information').get_attribute('cla=
ss'))
+        )
+        # Check second tab
+        tabs[1].click()
+        self.assertTrue(
+            'active' in str(self.find('#recipes').get_attribute('class')=
)
+        )
+        # Check third tab
+        tabs[2].click()
+        self.assertTrue(
+            'active' in str(self.find('#machines').get_attribute('class'=
))
+        )
+        # Check left section is displayed
+        section =3D self.find('.well')
+        # Check layer name
+        self.assertTrue(
+            section.find_element(By.XPATH, '//h2[1]').is_displayed()
+        )
+        # Check layer summary
+        self.assertTrue("Summary" in section.text)
+        # Check layer description
+        self.assertTrue("Description" in section.text)
--=20
2.34.1


