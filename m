Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FED4C10DC3
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.57340.1701298468005815594
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=MFww/2kP;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5F9A09C3E61
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id aoxi85GIkm8w; Wed, 29 Nov 2023 17:54:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DEFF39C341E;
	Wed, 29 Nov 2023 17:54:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com DEFF39C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298466; bh=+FWHRGyIGd5wGD4I1oE4xlErYk2U+QkS1w8AFgI2OPQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=MFww/2kPQjlrVhvJuY4ExFa8eZ621jeu+/rfxwMsa/VZcsYMO+UjoHRDL1uihR+w2
	 x9TlmxTw15LzmPRQzVP583uEh6H5PenvaWGhPrW68i7FiUaCYq690DU0BLiZqhXjU4
	 Ikv64qvM9pnCLxr3pu1+t88qhjRFDYbzQD1w+2xAguPKoG2Jg2SceTRzJMXIrZGTie
	 jI0KXciXVwHfiBp/xz2dRHl2rmz4ULvOulRBl6IlCzI3S1pbVRznYJKNYz/5pcz4mN
	 ph+pVqZQ96vN31lDcHdFgg/ZYJZRyJybuU0+v1ihiWH16J6Yn94cTf13kEQIsMpXTu
	 l3cUn8VddoSEA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kgui4KqTQmbi; Wed, 29 Nov 2023 17:54:26 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 426DF9C3636;
	Wed, 29 Nov 2023 17:54:26 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 9/9] toaster/test: Test single recipe page
Date: Wed, 29 Nov 2023 23:54:16 +0100
Message-Id: <20231129225416.479526-9-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
References: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15588

Test recipe page
    - Check if title is displayed
    - Check add recipe layer displayed
    - Check left section is displayed
        - Check recipe: name, summary, description, Version, Section,
        License, Approx. packages included, Approx. size, Recipe file

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/functional/test_project_page.py     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page.py b/lib/toas=
ter/tests/functional/test_project_page.py
index 771a8484..03f64f8f 100644
--- a/lib/toaster/tests/functional/test_project_page.py
+++ b/lib/toaster/tests/functional/test_project_page.py
@@ -756,3 +756,35 @@ class TestProjectPage(SeleniumFunctionalTestCase):
         self.assertTrue("Summary" in section.text)
         # Check layer description
         self.assertTrue("Description" in section.text)
+
+    def test_single_recipe_page(self):
+        """ Test recipe page
+            - Check if title is displayed
+            - Check add recipe layer displayed
+            - Check left section is displayed
+                - Check recipe: name, summary, description, Version, Sec=
tion,
+                License, Approx. packages included, Approx. size, Recipe=
 file
+        """
+        url =3D reverse("recipedetails", args=3D(1, 53428))
+        self.get(url)
+        self.wait_until_visible('.page-header')
+        # check title is displayed
+        self.assertTrue(self.find('.page-header h1').is_displayed())
+        # check add recipe layer displayed
+        add_recipe_layer_btn =3D self.find('#add-layer-btn')
+        self.assertTrue(add_recipe_layer_btn.is_displayed())
+        # check left section is displayed
+        section =3D self.find('.well')
+        # Check recipe name
+        self.assertTrue(
+            section.find_element(By.XPATH, '//h2[1]').is_displayed()
+        )
+        # Check recipe sections details info are displayed
+        self.assertTrue("Summary" in section.text)
+        self.assertTrue("Description" in section.text)
+        self.assertTrue("Version" in section.text)
+        self.assertTrue("Section" in section.text)
+        self.assertTrue("License" in section.text)
+        self.assertTrue("Approx. packages included" in section.text)
+        self.assertTrue("Approx. package size" in section.text)
+        self.assertTrue("Recipe file" in section.text)
--=20
2.34.1


