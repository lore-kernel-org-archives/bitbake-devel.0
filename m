Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF95AC433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:31:05 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web09.5482.1636119063318402270
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=bTU1fHWK;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636119060;
	bh=vduTI7MAf4l9nRnIDp9cjDkYkccq2RzZdSXmej5jyg0=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=bTU1fHWKMyh2PHmxufEQyT9ZbllF/tzhm+ll0W9woJ3v7kE0oT7njQyuL4jkKajoE
	 FiHIHndh9OzHfAuzoWkbKfvFY9WLltzA2PnwArUxzFeAfBhlh08n8pB2F+lqwg3yLH
	 dCQYIVKUuEQtcK2hbC+3MFu345Mq6tq2z6LJ0lNIc6lnbePE71NQtniNmJ3IQBuX6p
	 DpHh6mFxXr2uHUDC6uFMF1e+1HwjYK3fJyMWfArGQ62WLbrSrSO0PqOyzEdwxzPIEx
	 AJAMaGzPSoLvnTFQZAn2dNR5jDRh3deWhUKwUDVJ0pEpBA7N+SfoXQQuqksbpjI8mB
	 xVVEDxv7mcSag==
To: bitbake-devel@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	openembedded-core@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [PATCH 2/2] fetch2: Fix race condition in latest_revision
Date: Fri,  5 Nov 2021 14:30:48 +0100
Message-Id: <20211105133048.19879-2-jasper@fancydomain.eu>
In-Reply-To: <20211105133048.19879-1-jasper@fancydomain.eu>
References: <20211105133048.19879-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:31:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12892

From: Martin Koppehel <martin@mko.dev>

Setting latest_revision contained a race condition, where it would be
set to an empty string, if the hash calculation function would take to
long.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6a38cb09..9dc23d05 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1602,7 +1602,9 @@ class FetchMethod(object):
         try:
             return revs[key]
         except KeyError:
-            revs[key] =3D rev =3D self._latest_revision(ud, d, name)
+            rev =3D self._latest_revision(ud, d, name)
+            if rev !=3D '':
+                revs[key] =3D rev
             return rev
=20
     def sortable_revision(self, ud, d, name):
--=20
2.33.1


