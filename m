Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E23AC433F5
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 18:36:18 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web11.2047.1637778977213837861
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 10:36:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=I8FHsooS;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1637778973;
	bh=UCHZaJuxFw+PJISigau4cNc/BIjVaeL0gFLCi9eWNsk=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=I8FHsooSVD0ghAGZ8g6LLtRnkGWAX1GeSa2BtJ5n2XlG9dhngp+gOiZrmYRSUduuA
	 XLxLt1vsPyxOSkyzoueFdM6w4Nzo1Hr+ZCTysUtuGiP9EldRIVb2FTlLp721BXDBlc
	 dEuH7OV1ypd6bwU3JPmvU161Ct//GAfV4lpXqUM3r4iXJqp9eVsNNyDvexjoV7EkOk
	 Okp38lugTcQ9odtUtcPCA6PkVrrIb9Lesra6xjQPBvoVXgnyPmIBmHrn8RnvC3gTiC
	 bX5/41t/2qSbGSlsGlA6T1rzJwwzpSEl/QTuZ65gj7q3aS+bTXh+M4oDGMUvp7A0D+
	 QkDp7BI9p11kA==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [eo-core][PATCH v6 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Date: Wed, 24 Nov 2021 19:35:40 +0100
Message-Id: <20211124183540.39312-2-jasper@fancydomain.eu>
In-Reply-To: <20211124183540.39312-1-jasper@fancydomain.eu>
References: <20211124183540.39312-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Nov 2021 18:36:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13100

From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>

Add repo-native as prerequisite for the repo fetcher.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 meta/classes/base.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
index a65fcc6c1d..b709777f24 100644
--- a/meta/classes/base.bbclass
+++ b/meta/classes/base.bbclass
@@ -665,6 +665,10 @@ python () {
         elif uri.scheme =3D=3D "npm":
             d.appendVarFlag('do_fetch', 'depends', ' nodejs-native:do_po=
pulate_sysroot')
=20
+        elif uri.scheme =3D=3D "repo":
+            needsrcrev =3D True
+            d.appendVarFlag('do_fetch', 'depends', ' repo-native:do_popu=
late_sysroot')
+
         # *.lz4 should DEPEND on lz4-native for unpacking
         if path.endswith('.lz4'):
             d.appendVarFlag('do_unpack', 'depends', ' lz4-native:do_popu=
late_sysroot')
--=20
2.34.0


