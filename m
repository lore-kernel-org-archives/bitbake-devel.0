Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E4C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:17:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.124283.1699543053795949947
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:17:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=qDiGLjDT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 72F0F9C321E
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:17:32 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id YFpXDi9Nq8s8; Thu,  9 Nov 2023 10:17:31 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 693F79C34BE;
	Thu,  9 Nov 2023 10:17:31 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 693F79C34BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699543051; bh=Zcva81Llxl/g4Sx24blsRVqhZY5NYzWfAqCPWU8lH7o=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qDiGLjDTrbvN291cLMw9yyOZakmKi5uyh5fef33Ey1t+QZKVXvo4GSZira1XwLxkF
	 zoBXHiJBGmUCGCVNuPsW9jloLwmLP4+tOr2N1FeSozLRoZJKsglwtOaKXtSzFkfWbj
	 tAT2fYxhPYz46D5XReC+xWlreCzO7xSK7aVMGQsP5A1HVngkDNJKVHjjQ/eWg5ladM
	 mpONp5zE8gNesotBuFVIiEbqppM3EpDxHhSeMTNFLwXVw8Uhe8ZgzZbmHthAG1nCq+
	 cTtRfccRCxKApPvXSmH8J9dW3bQ0KeiWGdFH09LHmtHG5wyNiumxNIz3iMAtDfYhdw
	 fDYNG27zSn89g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wDhZmLBGwk8K; Thu,  9 Nov 2023 10:17:31 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 70E8D9C34BD;
	Thu,  9 Nov 2023 10:17:27 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 2/3] Toaster: Test documentation link in landing header is displayed
Date: Thu,  9 Nov 2023 16:16:56 +0100
Message-Id: <20231109151657.53358-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109151657.53358-1-alassane.yattara@savoirfairelinux.com>
References: <20231109151657.53358-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:17:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15461

- check that the documentation link is visible
- check browser open new tab toaster manual when clicking on the document=
ation link

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index a3aa2f93..771e627a 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -45,6 +45,21 @@ class TestLandingPage(SeleniumTestCase):
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


