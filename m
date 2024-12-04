Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F4E7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 10:19:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.10685.1733307559939941176
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 02:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CFBA1063
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Dec 2024 02:19:47 -0800 (PST)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD5F13F5A1
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Dec 2024 02:19:18 -0800 (PST)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib/bb/tests: use bb.build.listtasks() instead of __BBTASKS
Date: Wed,  4 Dec 2024 10:19:11 +0000
Message-Id: <20241204101911.1218039-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 10:19:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16864

Use the new listtasks() function (introduced in 185c4b) to avoid
accessing a private variable.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/tests/parse.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.p=
y
index 410679d5a1b..c31ece3d75c 100644
--- a/bitbake/lib/bb/tests/parse.py
+++ b/bitbake/lib/bb/tests/parse.py
@@ -201,7 +201,7 @@ deltask ${EMPTYVAR}
         f =3D self.parsehelper(self.addtask_deltask)
         d =3D bb.parse.handle(f.name, self.d)['']
=20
-        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'd=
o_mytask', 'do_mytask2', 'do_mytask5'], d.getVar("__BBTASKS"))
+        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'd=
o_mytask', 'do_mytask2', 'do_mytask5'], bb.build.listtasks(d))
         self.assertEqual(['do_mytask'], d.getVarFlag("do_mytask5", "deps=
"))
=20
     broken_multiline_comment =3D """
--=20
2.34.1


