Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9FAC433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:31:20 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web12.5474.1636119079203541913
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:31:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=f95c7eq8;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636119077;
	bh=YsAwmhrgFCN7SQ2qqINnMwLtQsyf5ROvOlXWvA5u8cs=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=f95c7eq81U7x1xKBAEWIRNoAI+a9M1RZ1iG+jZK8RWnIzjwnmJXWQ6pmNG7YAXxVm
	 ooEAG3Vp0Mtvk1HQtHRHkhzYfiPuPsmSxPfkz1wZSk0c2oOxQ+UyEEHwwpJb0tUMXm
	 VJniYTiWaNoqFNhzN/YdDuTqYwuw+F3ak7X+PyMrca3EEnZYrFXoYq2fc+t7hD3eQ5
	 XH7a/FB9+4xqhHqbvo4l7S6S3fNZpnlLjQRHcgiwUn9KKApCYayORsQgNxisohYQJB
	 Y/o7w1+WfSQDnAD+8mWQN6CWQU1M9cmC1KlP+4p/ixWsvLtaeOdKiOp3Rwl7m4wxHM
	 SETlWJa1O/blA==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH 2/2] base.bbclass: Add sysroot deps for repo fetcher
Date: Fri,  5 Nov 2021 14:31:04 +0100
Message-Id: <20211105133104.19895-2-jasper@fancydomain.eu>
In-Reply-To: <20211105133104.19895-1-jasper@fancydomain.eu>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:31:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12894

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


