Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E29C53210
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 17:59:27 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.419.1672768764624363672
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jan 2023 09:59:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: theobroma-systems.com, ip: 217.70.183.200, mailfrom: quentin.schulz@theobroma-systems.com)
Received: (Authenticated sender: foss@0leil.net)
	by mail.gandi.net (Postfix) with ESMTPSA id AD94120003;
	Tue,  3 Jan 2023 17:59:20 +0000 (UTC)
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: docs@lists.yoctoproject.org,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	than.matos+bitbake@gmail.com,
	bitbake-devel@lists.openembedded.org,
	Quentin Schulz <foss+yocto@0leil.net>,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] doc: user-manual: intro: reword a sentence
Date: Tue,  3 Jan 2023 18:59:04 +0100
Message-Id: <20230103-typo-202301-v1-0-bb5014c684d0@theobroma-systems.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 17:59:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14283

It's been reported this sentence is a bit odd, so let's reword it.=0D
=0D
Reported-by: than.matos+bitbake@gmail.com=0D
Suggested-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>=0D
Cc: Quentin Schulz <foss+yocto@0leil.net>=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
reword odd sentence=0D
=0D
Cc: docs@lists.yoctoproject.org=0D
Cc: bitbake-devel@lists.openembedded.org=0D
---=0D
 doc/bitbake-user-manual/bitbake-user-manual-intro.rst | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/bi=
tbake-user-manual/bitbake-user-manual-intro.rst=0D
index 35ffb88b0..797feb516 100644=0D
--- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst=0D
+++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst=0D
@@ -275,7 +275,7 @@ simple as ``busybox_%.bbappend`` to be entirely version=
 independent.=0D
 Obtaining BitBake=0D
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
 =0D
-You can obtain BitBake several different ways:=0D
+There are several different ways that BitBake can be obtained:=0D
 =0D
 -  **Cloning BitBake:** Using Git to clone the BitBake source code=0D
    repository is the recommended method for obtaining BitBake. Cloning=0D
=0D
---=0D
base-commit: 367a83ed46c7fbcdd06579b6cc3a6e48a89ca7fb=0D
change-id: 20230103-typo-202301-c5f8f3571209=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D

