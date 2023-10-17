Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5288CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 20:49:11 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.266962.1697575743640159315
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 13:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=pN1ipaeD;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6D1AB9C0F4A
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 16:49:02 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1SjXY70zq0i0; Tue, 17 Oct 2023 16:49:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D05AB9C3216;
	Tue, 17 Oct 2023 16:49:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D05AB9C3216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697575741; bh=Fu4CT9GIRotRtktuqL9zBMZu7Bw1zsC2X+xgsVDHyhc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=pN1ipaeDfL6rHaAvmac5f1BYvp8Z3ud/zQDE9Uc4sgfz54XLHsi1lCA8rgXHwv1pN
	 HIasLDuBQKk0Bb7oswXnU6T8g6htmm0ZhywqMyBa0whaRrxuce3AUxldTFH37u1D86
	 fEy7f9gESdh0eX8BmeGHyBia3BlD2a+sw4TQVsuzO66IHaQOsrSncnvX1nU2Fm4o2A
	 hdwkj89xFoe5lm06mGPRhZZKIdYfBtRYJhxbgQOvIXFQf0Hc6m1j423U/RxzqiHqDc
	 ZG9asslgDmdOgdo6zP/PpCipLVfD5ZhbXj+zgiqbrF0osi21py3h0YkRFp1DJ3iJio
	 vQ+3GxuGdxTwA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id cQ1RshLX8ipR; Tue, 17 Oct 2023 16:49:01 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EC3BF9C0F4A;
	Tue, 17 Oct 2023 16:49:00 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Toaster: bug-fix on custom image test cases
Date: Tue, 17 Oct 2023 21:48:53 +0100
Message-Id: <20231017204853.408153-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 20:49:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15255

To test custom image creation, a file for base_recipe should exists other=
wise test fail,
User we need to build a base image first, that will create a file for bas=
e_recipe, which take a while.

To avoid test dependencies between test and run build, i create a tmp fil=
e for base recipe.

Signed-off-by Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_new_custom_image_page.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/li=
b/toaster/tests/browser/test_new_custom_image_page.py
index 6361f403..34d1bd45 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -48,8 +48,12 @@ class TestNewCustomImagePage(SeleniumTestCase):
         self.recipe =3D Recipe.objects.create(
             name=3D'core-image-minimal',
             layer_version=3Dlayer_version,
+            file_path=3D'/tmp/core-image-minimal.bb',
             is_image=3DTrue
         )
+        # create a tmp file for the recipe
+        with open(self.recipe.file_path, 'w') as f:
+            f.write('foo')
=20
         # another project with a custom image already in it
         project2 =3D Project.objects.create(name=3D'whoop', release=3Dre=
lease)
--=20
2.34.1


