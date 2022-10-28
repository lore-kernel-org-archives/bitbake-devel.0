Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14AC38A02
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 17:15:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web12.2058.1666977341037243172
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Oct 2022 10:15:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7F41FB;
	Fri, 28 Oct 2022 10:15:46 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B653F703;
	Fri, 28 Oct 2022 10:15:39 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Cc: nd@arm.com
Subject: [PATCH] fetch2/git: don't set core.fsyncobjectfiles=0
Date: Fri, 28 Oct 2022 18:15:35 +0100
Message-Id: <20221028171535.21518-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Oct 2022 17:15:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14054

This git configuration variable is deprecated in 2.36.0 onwards, so git
warns in the logs for every git call.

Luckily the default value has always been false[1], so we can just remove
this.

[ YOCTO #14939 ]

[1] https://github.com/git/git/commit/aafe9fbaf4f1d1f27a6f6e3eb3e246fff81=
240ef

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 17d4904927d..578edc5914f 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -243,7 +243,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] =3D 'HEAD'
=20
-        ud.basecmd =3D d.getVar("FETCHCMD_git") or "git -c core.fsyncobj=
ectfiles=3D0 -c gc.autoDetach=3Dfalse -c core.pager=3Dcat"
+        ud.basecmd =3D d.getVar("FETCHCMD_git") or "git -c gc.autoDetach=
=3Dfalse -c core.pager=3Dcat"
=20
         write_tarballs =3D d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0=
"
         ud.write_tarballs =3D write_tarballs !=3D "0" or ud.rebaseable
--=20
2.34.1


