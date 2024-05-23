Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3DC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 14:55:57 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.662.1716476153088846420
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 May 2024 07:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=e8vLGLdb;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 157C99C41A0;
	Thu, 23 May 2024 10:55:52 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Uq3rKGcxhlcV; Thu, 23 May 2024 10:55:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7406E9C5647;
	Thu, 23 May 2024 10:55:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7406E9C5647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1716476151; bh=U9WVJFh93y0+S9MQfsAmsdC6pxsUoPDZ0Ame28xi72c=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=e8vLGLdbQtod6Bi/7YXWcJ6oHjDyGvh0pwZXF0YZ+no7WzN1mIxd2c0m9yK3a+jln
	 4iAiNlr51vGEQ5RQe9uNd5Vvw+Q7vu5dO4okilcir1ZnYaR+qk+JzEVm8xiFT2DuIs
	 iftA1z/CjY16BvOrnBpaBQl58dgMsJ4Q9ZjtZ4629M2cGna26JXlKAtrff+QojG+d0
	 OLOaBmYUmf5cRBzznugCgwguc0N5MOfwt+gpY0FQW8a3GwncPA1YjCL4JnAJCHjGDm
	 AzfL+Ysp0E1Ux3QqBFciBfb+QYLsuXnjJ5dLDHF9VDYC6gtxWstc6v4Tuwu/dwNERX
	 PiXPJix+0L64A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Sl05JMCQIXUC; Thu, 23 May 2024 10:55:51 -0400 (EDT)
Received: from savoirfairelinux.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 521CA9C41A0;
	Thu, 23 May 2024 10:55:51 -0400 (EDT)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] Add exception treatment to fix missing target_file
Date: Thu, 23 May 2024 10:55:41 -0400
Message-Id: <20240523145541.198353-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 14:55:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16245

Based on the discution on  https://lists.yoctoproject.org/g/toaster/messa=
ge/6157 in some cases the value for Target_file could be missing and is n=
eeded to bypass it to finish build

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfai=
relinux.com>
---
 lib/bb/ui/buildinfohelper.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8b212b780..4ee45d67a 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -559,7 +559,10 @@ class ORMWrapper(object):
                 # we might have an invalid link; no way to detect this. =
just set it to None
                 filetarget_obj =3D None
=20
-            parent_obj =3D Target_File.objects.get(target =3D target_obj=
, path =3D parent_path, inodetype =3D Target_File.ITYPE_DIRECTORY)
+            try:
+                parent_obj =3D Target_File.objects.get(target =3D target=
_obj, path =3D parent_path, inodetype =3D Target_File.ITYPE_DIRECTORY)
+            except Target_File.DoesNotExist:
+                parent_obj =3D None
=20
             Target_File.objects.create(
                         target =3D target_obj,
--=20
2.34.1


