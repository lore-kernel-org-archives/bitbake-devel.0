Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BADCC433EF
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 15:53:53 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web08.2.1636559631198335749
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 07:53:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=O0E97qS1;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636559629;
	bh=YsAwmhrgFCN7SQ2qqINnMwLtQsyf5ROvOlXWvA5u8cs=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=O0E97qS189K3Xcc5wKI+G6HPWiZOfRANeh0P8LymtvEdoxZEutMl1vgGKCKq8TOjg
	 mrMhDm+iFlGOGxXmnDqWkkjHqU1NA5+CrVG5HqJT4Degl1HJbQvcQU20nY+oJ+Z5Gl
	 AdWTjpGaqicDXK1gnalE1PbEkNGea6+kTvUzxqfpLkdctmi4KOCZG04IriAtHfqsV/
	 bob8Fo6uDS7QVn23EptS+dxC+DPLp+9Xn1N4+Rm9NGoBPji++EOM4C7iB7JYSlruDN
	 bU926aY35wCmJNIKZzNRDM9CZXQIBvFDjKgS6ZVJExE4bg/3QCRTV3d+fojr3/aAcr
	 firsc07nId6ow==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH v4 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Date: Wed, 10 Nov 2021 16:53:32 +0100
Message-Id: <20211110155332.578088-2-jasper@fancydomain.eu>
In-Reply-To: <20211110155332.578088-1-jasper@fancydomain.eu>
References: <20211110155332.578088-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 15:53:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12991

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


