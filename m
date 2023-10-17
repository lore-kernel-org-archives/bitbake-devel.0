Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27948CDB474
	for <webhook@archiver.kernel.org>; Tue, 17 Oct 2023 21:59:12 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.268581.1697579944061959769
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Oct 2023 14:59:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=e/zohqSC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 309579C2AEF
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 17:59:03 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Z09vfA7ngaOU; Tue, 17 Oct 2023 17:59:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9D2F89C2C9C;
	Tue, 17 Oct 2023 17:59:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 9D2F89C2C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697579942; bh=X2mswYSson0xhQeuSDPkGh5W5mVct11mmqCDDN0gJK4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=e/zohqSCF7lDL3hz0q+P/CirHQ4Z9fTI/Vjxslc77FYNe6/1L2g/t7lhFcafE1Lgn
	 PV1p36nuaaaZVaSJJ9yTrTICCxJBJelccpwDVVQIXfIQGCZYAHce79YJUskWoKnphf
	 zLylDDU5jeLV0LeOxiFMuzIpuuSvjjcMkKfvOnOv9rJcevMiH7MPdqrHyIgRzS095L
	 Z/E3rU3xXcibkw90gLYuSt3CSOUOE2GfcE0wR4xWvY4qGP09DKOyoTxVm8uGVVB6AR
	 BuirI6md1eCYpU54cK2HUhd/tNUJjOOX57Qi5jtQut8z6/LDaQBEpzvtSomYcHu3/Y
	 DF1XhjnOIedzA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ADTc8r_0mdXI; Tue, 17 Oct 2023 17:59:02 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EDBE09C2AEF;
	Tue, 17 Oct 2023 17:59:01 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/2] Toaster: bug-fix on tests/views/test_views.py
Date: Tue, 17 Oct 2023 22:58:47 +0100
Message-Id: <20231017215848.514246-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Oct 2023 21:59:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15256

- Create a tmp file for base recipe, otherwise test fail it doesn't exist

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/views/test_views.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/vi=
ews/test_views.py
index f962e762..06bf6c20 100644
--- a/lib/toaster/tests/views/test_views.py
+++ b/lib/toaster/tests/views/test_views.py
@@ -41,7 +41,15 @@ class ViewTests(TestCase):
     def setUp(self):
=20
         self.project =3D Project.objects.first()
+
         self.recipe1 =3D Recipe.objects.get(pk=3D2)
+        # create a file and to recipe1 file_path
+        file_path =3D f"/tmp/{self.recipe1.name.strip().replace(' ', '-'=
)}.bb"
+        with open(file_path, 'w') as f:
+            f.write('foo')
+        self.recipe1.file_path =3D file_path
+        self.recipe1.save()
+
         self.customr =3D CustomImageRecipe.objects.first()
         self.cust_package =3D CustomImagePackage.objects.first()
         self.package =3D Package.objects.first()
--=20
2.34.1


