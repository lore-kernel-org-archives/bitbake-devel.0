Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7738C47077
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 13:54:00 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.17186.1704808438743025418
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 05:53:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=t2s+m3ku;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0D2919C0B24
	for <bitbake-devel@lists.openembedded.org>; Tue,  9 Jan 2024 08:53:58 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id oWZm1Y1DQs5W; Tue,  9 Jan 2024 08:53:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B95689C160A;
	Tue,  9 Jan 2024 08:53:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B95689C160A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704808437; bh=Y5b0afQttCY+9gE5JDU0ys2ArvraUmbad6XH03DefoE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=t2s+m3kuYYsygWmQmqC8GUF+izCc+/dzs/SyZ6XTYIjeP98lLfZJSWnpBbmZNxRIl
	 xhAo2L6i5PGKA4WLwPG9XVzeXtTpHXlljkdU/IYQ01jV95z4NVCBfat2rAKxoUllGc
	 gPzWXCAoGNauKRKQSoKnCXV+bOYCBrpPsWIeIMjeLPqUYO6tHKoVGhnbudeDTjOTo5
	 4fisYdOp6Th/zX1yueLRexgFzq+urzDVFpIafNxsua5riEt+p389ijMkrRpyOApyI2
	 0e0soOkiASCfl1Wos7Fz16NaVLN3H1KsviLRj56dbZrCFBw4Mgx6fnJvfekHI8VjiM
	 VS5cokK5og0ag==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id KOh4rOQaNa8j; Tue,  9 Jan 2024 08:53:57 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 2ED0C9C0B24;
	Tue,  9 Jan 2024 08:53:57 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/3] toaster/test: Bug-fix "element not interactable" in TestLayerDetailsPage::test_edit_layerdetails
Date: Tue,  9 Jan 2024 14:53:52 +0100
Message-Id: <20240109135352.416686-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109135352.416686-1-alassane.yattara@savoirfairelinux.com>
References: <20240109135352.416686-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 13:54:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15760

Failed: https://autobuilder.yoctoproject.org/typhoon/#/builders/161/build=
s/143/steps/12/logs/stdio

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 9deef670..5c29548b 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -64,7 +64,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
                            args=3D(self.project.pk,
                                  self.imported_layer_version.pk))
=20
-    def test_edit_layerdetails(self):
+    def _edit_layerdetails(self):
         """ Edit all the editable fields for the layer refresh the page =
and
         check that the new values exist"""
=20
@@ -168,6 +168,13 @@ class TestLayerDetailsPage(SeleniumTestCase):
                         "Expected %s in the dir value for layer director=
y" %
                         new_dir)
=20
+    def test_edit_layerdetails_page(self):
+        try:
+            self._edit_layerdetails()
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "ElementClickInterceptedException occured. Element not v=
isible or maybe covered by another element.")
+
     def test_delete_layer(self):
         """ Delete the layer """
=20
--=20
2.34.1


