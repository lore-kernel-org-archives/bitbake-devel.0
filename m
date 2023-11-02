Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2BC4167B
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 15:02:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33212.1698937362029724813
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 08:02:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=VKGP7ISo;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6A7F29C339D
	for <bitbake-devel@lists.openembedded.org>; Thu,  2 Nov 2023 11:02:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Xj2tY7O76-n2; Thu,  2 Nov 2023 11:02:36 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ABAB39C33DF;
	Thu,  2 Nov 2023 11:02:36 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ABAB39C33DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698937356; bh=hoj5Z+H1lnrzriSY58HGeJeI91BUA3QSPERLn9+Zrs0=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=VKGP7ISoUfjwIIk+oPhjlOz9m4QootPC2DEUnOrxRmp3++VX+ti4yTFkmxEbFqCWO
	 dNDZRB4+XtPt53lYAEoT37BoWb6bO4/DrTWrPzMGvi4h6BNPvCowFO2uWwXWbvdbIg
	 vjaxzwgk4O9UitEzZ9kJOcKj3LbmkX7y70gC+Fotjh+BjzOKFJkBSnpFUWO3yFA4lg
	 bB27o4276v8SKM2TuFs1Pmqwd9P1I3Los6E/tUGPfc8jg+MtqqRaT0pEPtl9vdCWb0
	 3zyX7jpJQ8lwhjJr9+necLPLSmVvHpiQt0no9nGLArdDjslnCjFU5tJk+wVd4RWyGj
	 gdyeeMdqg4cFg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 191cwDshk-9x; Thu,  2 Nov 2023 11:02:36 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 262BD9C334B;
	Thu,  2 Nov 2023 11:02:36 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 2/4] Toaster: Test documentation link in landing header is displayed
Date: Thu,  2 Nov 2023 16:02:25 +0100
Message-Id: <20231102150227.363289-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102150227.363289-1-alassane.yattara@savoirfairelinux.com>
References: <20231102150227.363289-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 15:02:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15416

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


