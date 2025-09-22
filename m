Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E375ECAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 08:40:09 +0000 (UTC)
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
 by mx.groups.io with SMTP id smtpd.web10.229.1758570696506009106
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 12:51:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@myspectrum.nl header.s=transip-a header.b=Ua2WoBsL;
 spf=pass (domain: myspectrum.nl, ip: 136.144.136.8, mailfrom: jeroen@myspectrum.nl)
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4cVtzB1nzrzY76XP;
	Mon, 22 Sep 2025 21:51:34 +0200 (CEST)
Received: from yellow.myspectrum.nl (yellow.myspectrum.nl [136.144.146.76])
	by submission4.mail.transip.nl (Postfix) with ESMTPSA id 4cVtz93dCdz2pRDkM;
	Mon, 22 Sep 2025 21:51:33 +0200 (CEST)
Received: from yellow.myspectrum.nl (82-75-103-118.cable.dynamic.v4.ziggo.nl [82.75.103.118])
	(Authenticated sender: sendmail@myspectrum.nl)
	by yellow.myspectrum.nl (Postfix) with ESMTPSA id D377B20293;
	Mon, 22 Sep 2025 19:51:31 +0000 (UTC)
Authentication-Results: yellow.myspectrum.nl;
	auth=pass smtp.auth=sendmail@myspectrum.nl smtp.mailfrom=jeroen@myspectrum.nl
Received: by yellow.myspectrum.nl (sSMTP sendmail emulation); Mon, 22 Sep 2025 21:51:31 +0200
From: "Jeroen Hofstee" <jeroen@myspectrum.nl>
To: bitbake-devel@lists.openembedded.org
Cc: Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [RFC] fetch2: npm: do keep the sha256sum
Date: Mon, 22 Sep 2025 21:50:59 +0200
Message-ID: <20250922195059.1052515-1-jeroen@myspectrum.nl>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=myspectrum.nl; t=1758570693; h=from:subject:to:cc:date:
 mime-version; bh=EEFRyp/Rlnzm4wTeoEkiyktk4juY/PGEP+7GYQFevYs=;
 b=Ua2WoBsLWnmLKDo/ll1rKkNEn6A4bt+qRc6MenlBN6WOL0fJ42UBVd+POhYntM5W5Ir7l1
 LpexG7VBNHXtKWK7U74y2UVW2Otqu4lFU9Nzuq7CQpzrYEJc6FP6ux4zpV0t3lH1tuqasK
 cXRzrSvv9375D/0NqgOqZ892OJoo/gS7BxE5q/2cUQmTp4UdykoGJKzRzg+Ra5y5WEH17L
 v0X7vDqQ7/QmlPxgvf2h7dVNWDD3dHCiVbD6maWidTAM9zSR3VpQYeXoSljLLLM1STvoB6
 W0Fiwiy0crSnpH07E/8hgUR8ZtpKaJ0Qfe5Mp6x9DawcBVKn/Q/nNPiLDcbUAA==
X-Report-Abuse-To: abuse@transip.nl
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Sep 2025 08:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18076

From: Jeroen Hofstee <jhofstee@victronenergy.com>

commit 8d3232152e ("fetch2: read checksum from SRC_URI flag for npm")
added npm to require a checksum. The checksum is also added with the
`npm view` command which relies on downloaded data. Furthermore in
_setup_proxy all the SRC_URI variables are removed, so an explicit
local SRC_URI[sha256sum] is removed and it only checks the online
checksum from npm view.

This removes the data.delVarFlags("SRC_URI"), so the check works again,
but given the comment "Avoid conflicts between the environment data and
the proxy url checksum", there might be reason for that, but I wouldn't
expect tarballs to differ when served directly or via a proxy.

We might consider getting rid of npm_integrity completely and force
having a local checksum and not depend on the npm infrastructure.
---
 lib/bb/fetch2/npm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e469d6676..ad740f832 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -269,7 +269,8 @@ class Npm(FetchMethod):
             # Avoid conflicts between the environment data and:
             # - the proxy url checksum
             data =3D bb.data.createCopy(d)
-            data.delVarFlags("SRC_URI")
+            # XXX: What is the purpose of removing SRC_URI, it also remo=
ves the checksum...
+            #data.delVarFlags("SRC_URI")
             ud.proxy =3D Fetch([url], data)
=20
     def _get_proxy_method(self, ud, d):
--=20
2.43.0


