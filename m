Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B030C433FE
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 23:37:41 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web11.5619.1637797057076561283
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 15:37:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=p6pW+3oH;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1637797055;
	bh=UCHZaJuxFw+PJISigau4cNc/BIjVaeL0gFLCi9eWNsk=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=p6pW+3oHOQ920+869mq9jsWEKI1uPzNAxGPnT2qdnsBQkfgY8kEpRyKlNDA2ULImF
	 pPPu9cwx61ZhlqXUkkNTmh25Amu9Zpi5P7liH5EKu9JCXVsELiBazX6/9oPqbXb830
	 aZU1QLo1XT2dhUM4QSaRQe0Our0y08wwFXCwaCb6RNsgwgkxbslZd+xQyrr4pYzzYQ
	 qNTODrkWECP+UjG/H2MeZv4yGI8WO2QpHhUmA7DtaU0LepKtTlZHRTQ27SmRB2ABKz
	 eA+Ud5cMtdNLwKhG4k8V6e4MInmoPwkP+xNYavDD8OjXYhMUGlahVttyV0rMNhce5R
	 PLxrSGU0vFkoQ==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH v7 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Date: Thu, 25 Nov 2021 00:37:02 +0100
Message-Id: <20211124233702.74352-2-jasper@fancydomain.eu>
In-Reply-To: <20211124233702.74352-1-jasper@fancydomain.eu>
References: <20211124233702.74352-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Nov 2021 23:37:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13102

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


