Return-Path: <o.mandel@menlosystems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95C0C35295
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:35 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by mx.groups.io with SMTP id smtpd.web10.6836.1649429423361870914
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Apr 2022 07:50:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=none, err=permanent DNS error (domain: menlosystems.com, ip: 212.18.0.9,
 mailfrom: o.mandel@menlosystems.com)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4KZh4X6XT6z1qy4Y;
	Fri,  8 Apr 2022 16:50:20 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
	by mail.m-online.net (Postfix) with ESMTP id 4KZh4X60HZz1qqkH;
	Fri,  8 Apr 2022 16:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
	with ESMTP id sOkD3mKz3JT4; Fri,  8 Apr 2022 16:50:20 +0200 (CEST)
X-Auth-Info: Ft3J5EUAuCC6K9sheywh+maehJZwLm2HwzGSeDs4gtE7/49WDZNtmJmaV0YSSOCV
Received: from menlobuildserver.MenloSystems.local
 (host-82-135-125-165.customer.m-online.net [82.135.125.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri,  8 Apr 2022 16:50:20 +0200 (CEST)
From: Olaf Mandel <o.mandel@menlosystems.com>
To: bitbake-devel@lists.openembedded.org
Cc: Olaf Mandel <o.mandel@menlosystems.com>,
	Marek Vasut <marex@denx.de>
Subject: [PATCH] fetch2/git: canonicalize ids in generated tarballs
Date: Fri,  8 Apr 2022 16:50:12 +0200
Message-Id: <20220408145012.2847490-1-o.mandel@menlosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328173618.960965-1-o.mandel@menlosystems.com>
References: <20220328173618.960965-1-o.mandel@menlosystems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Apr 2022 17:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13597

Change the owner information in the mirror tarballs generated using
BB_GENERATE_MIRROR_TARBALLS=3D"1". This is an extension of commit
0178ab83, which used the original pokybuild:user information, but failed
to clean up the numerical user and group ids. Now set the more canonical
values of oe:oe and 0:0.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
CC: Marek Vasut <marex@denx.de>
---
 lib/bb/fetch2/git.py  | 2 +-
 lib/bb/tests/fetch.py | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4d06a571..b3eb8248 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -464,7 +464,7 @@ class Git(FetchMethod):
             with create_atomic(ud.fullmirror) as tfile:
                 mtime =3D runfetchcmd("git log --all -1 --format=3D%cD",=
 d,
                         quiet=3DTrue, workdir=3Dud.clonedir)
-                runfetchcmd("tar -czf %s --owner pokybuild --group users=
 --mtime \"%s\" ."
+                runfetchcmd("tar -czf %s --owner oe:0 --group oe:0 --mti=
me \"%s\" ."
                         % (tfile, mtime), d, workdir=3Dud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
=20
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 233ecae7..1152e89c 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -653,8 +653,10 @@ class CleanTarballTest(FetcherTest):
         archive =3D tarfile.open(os.path.join(self.dldir, self.recipe_ta=
rball))
         self.assertNotEqual(len(archive.members), 0)
         for member in archive.members:
-            self.assertEqual(member.uname, 'pokybuild')
-            self.assertEqual(member.gname, 'users')
+            self.assertEqual(member.uname, 'oe')
+            self.assertEqual(member.uid, 0)
+            self.assertEqual(member.gname, 'oe')
+            self.assertEqual(member.gid, 0)
             self.assertEqual(member.mtime, mtime)
=20
=20
--=20
2.25.1


