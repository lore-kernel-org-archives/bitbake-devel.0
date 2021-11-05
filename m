Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B254C43217
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 15:32:10 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web09.7206.1636126328445314926
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 08:32:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=l/EDwJ8l;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636126326;
	bh=YsAwmhrgFCN7SQ2qqINnMwLtQsyf5ROvOlXWvA5u8cs=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=l/EDwJ8lNO6ueAHwFJc/95jYlHDJuhJLE9U+AfWA3B+ki2T+CiIuWVb/hdxUhQOBy
	 9DW3zrGjW/jBTlLEjbZikApHrmc5e9ih9/WTWBzngF7okk34qtKFL11Xi07zfe8446
	 6NvhVwC4qEIe97gT0BRdCR7zihXOq/GjTEt5sGpQzHS7f+5cwOO6o4Bf6ZeP6cqAVR
	 SN/JYhhxYTtb7aw5OaAbS3UscmG5vjwkh/DAPQx448Z4Hb+cOhxWHe90W0M96rOXax
	 G9f0PaLYZ9yzIYL65Jz5G0+7WlxaTrmORu6JehaA+r6eBM29JGsJx00sHN4RpKXrxc
	 UrBoTa5+kfzyQ==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH v2 2/2] base.bbclass: Add sysroot deps for repo
 fetcher
Date: Fri,  5 Nov 2021 16:31:35 +0100
Message-Id: <20211105153135.26033-2-jasper@fancydomain.eu>
In-Reply-To: <20211105153135.26033-1-jasper@fancydomain.eu>
References: <20211105153135.26033-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 15:32:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12909

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


