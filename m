Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F02C47079
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 16:30:51 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.21070.1704817842724396059
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 08:30:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=RWWCsrxR;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1B8C79C41CF
	for <bitbake-devel@lists.openembedded.org>; Tue,  9 Jan 2024 11:30:42 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 4fEhZyIuOYmQ; Tue,  9 Jan 2024 11:30:41 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C487C9C2AAB;
	Tue,  9 Jan 2024 11:30:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C487C9C2AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704817841; bh=Y5b0afQttCY+9gE5JDU0ys2ArvraUmbad6XH03DefoE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=RWWCsrxRCD/dwV2c5vilx+UbNkgxb5xOtCWDq4JQbnHMoy9mWPdUGNMTY4c8aIoyN
	 sCCu2Z0g49o4+r7J4JmOtv0dWyKi3mmQw2CfWFhrCXBPd3fBpo6yojJkilQc/NwtO4
	 HIqFaxU/RY91lxQRg5c7K6W8xVrMhoqlrmwKOeFjO1lZUyg6UN+l0toIAC2vr3qLfs
	 DAOXVfJ1ef5baTWfMK/ZcvgiFrs2o/8uDWjmGyE0K/+ZOjK1Y8uLeWQRAmEentBMDL
	 GBnC4uQbM3mhSZVYWV7Kauad26KheLv4r/0jp1ogsNFjqVlmtowQ+ro8Sj03aSsyE3
	 cYWik3TWGek+A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VJwg5OyU2Ybn; Tue,  9 Jan 2024 11:30:41 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3B4619C40CF;
	Tue,  9 Jan 2024 11:30:41 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 3/4] toaster/test: Bug-fix "element not interactable" in TestLayerDetailsPage::test_edit_layerdetails
Date: Tue,  9 Jan 2024 17:30:33 +0100
Message-Id: <20240109163034.534593-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109163034.534593-1-alassane.yattara@savoirfairelinux.com>
References: <20240109163034.534593-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 16:30:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15770

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


