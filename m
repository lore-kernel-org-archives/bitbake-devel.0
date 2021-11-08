Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A9C4332F
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 11:59:06 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web08.43892.1636372744819855536
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 03:59:06 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=q1kBt3vz;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636372742;
	bh=YsAwmhrgFCN7SQ2qqINnMwLtQsyf5ROvOlXWvA5u8cs=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=q1kBt3vzHCsbTAD+B2/Wf1p5f5xuhpocd+XhyRHL47U9G8Wey0ODKaJ9BwpJBicQ6
	 jByW2Cok6eb1bgAQsmvIvsXFOBVzBTwmCVhctautAmXE/8nDIogV8VuUVWAwWSksAK
	 8cL2RGpo/yM5QgF6MzSvrY3wvGbHTo1cN41qwNVEPSxhuBTxwHJG43NdxGLpy7SjeR
	 uiBt5ptysIJMuB9JbhyPw8JRoiWbDbyjMKCVoFxE04k7z5ljzFTPh6eKf6U5TrS9h8
	 0lHwAElPIGLN+iJuMfLfJMLFskbGxHJyaCsMBEqD1H5ARocymTHa8MhoCLbQ/3g/IL
	 hyvEfXV3/Dn7Q==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH v3 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Date: Mon,  8 Nov 2021 12:58:42 +0100
Message-Id: <20211108115842.15164-2-jasper@fancydomain.eu>
In-Reply-To: <20211108115842.15164-1-jasper@fancydomain.eu>
References: <20211108115842.15164-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 11:59:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12937

From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>

Add git-native and repo-native as prerequisite for the repo fetcher.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 meta/classes/base.bbclass | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
index a65fcc6c1d..3298bd1952 100644
--- a/meta/classes/base.bbclass
+++ b/meta/classes/base.bbclass
@@ -665,6 +665,11 @@ python () {
         elif uri.scheme =3D=3D "npm":
             d.appendVarFlag('do_fetch', 'depends', ' nodejs-native:do_po=
pulate_sysroot')
=20
+        elif uri.scheme =3D=3D "repo":
+            needsrcrev =3D True
+            d.appendVarFlag('do_fetch', 'depends', ' repo-native:do_popu=
late_sysroot')
+            d.appendVarFlag('do_fetch', 'depends', ' git-native:do_popul=
ate_sysroot')
+
         # *.lz4 should DEPEND on lz4-native for unpacking
         if path.endswith('.lz4'):
             d.appendVarFlag('do_unpack', 'depends', ' lz4-native:do_popu=
late_sysroot')
--=20
2.33.1


