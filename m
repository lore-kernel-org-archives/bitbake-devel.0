Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7DFC4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 22:26:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.172791.1698704790451230298
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 15:26:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=vY1KszKC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CC6969C332F
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 18:26:29 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id x6VfWc0cKrir; Mon, 30 Oct 2023 18:26:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3FD059C3231;
	Mon, 30 Oct 2023 18:26:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3FD059C3231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698704789; bh=hoj5Z+H1lnrzriSY58HGeJeI91BUA3QSPERLn9+Zrs0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=vY1KszKCyTeQq2LsjLCSNfViMMPRaqk5MIUxRZQ+oGC7SBEsjqJ+65fsn2uOb0UIw
	 q04V2UV1oegVsHSEJGGcBc6m2O+D4xcwm5auULYZ86lqPBvIp7iYW6GfK++5DAJ/F0
	 6TfoEAbekIQRw8ZN/8omtougKifKHl7R8/4oDWzAg99FaMv48SN0dqZEHMD0xq0VKG
	 ju0oA80p58S2OW6Zd1ImmezcegwcjpO7Hf3zllgluGwKBP3PeIKKSoPVztJw7lTPTb
	 Fn9rd5DiY1i9A66UT6NoRGz1Ecv9l6aiX91+jLhF1XXSpANVUBePan6EZBwH7m1+z/
	 L0j71AFKW7bnA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id S2VSr6tVhGdM; Mon, 30 Oct 2023 18:26:29 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 54D069C0C62;
	Mon, 30 Oct 2023 18:26:28 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/3] Toaster: Test documentation link in landing header is displayed
Date: Mon, 30 Oct 2023 23:26:17 +0100
Message-Id: <20231030222618.404081-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com>
References: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 22:26:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15334

- check that the documentation link is visible
- check browser open new tab toaster manual when clicking on the document=
ation link

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 2f092400..e731af22 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -46,6 +46,21 @@ class TestLandingPage(SeleniumTestCase):
         self.assertTrue(info_modal.is_displayed())
         self.assertTrue("Toaster version information" in info_modal.text=
)
=20
+    def test_documentation_link_displayed(self):
+        """ Test that the documentation link is displayed """
+        self.get(reverse('landing'))
+        documentation_link =3D self.find('#navbar-docs > a')
+
+        # check that the documentation link is visible
+        self.assertTrue(documentation_link.is_displayed())
+       =20
+        # check browser open new tab toaster manual when clicking on the=
 documentation link
+        self.assertEqual(documentation_link.get_attribute('target') , '_=
blank')
+        self.assertEqual(
+            documentation_link.get_attribute('href'),=20
+            'http://docs.yoctoproject.org/toaster-manual/index.html#toas=
ter-user-manual')
+        self.assertTrue("Documentation" in documentation_link.text)
+
     def test_only_default_project(self):
         """
         No projects except default
--=20
2.34.1


