Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE6EC04FF8
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 14:17:53 +0000 (UTC)
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
 by mx.groups.io with SMTP id smtpd.web10.13245.1713447719398702124
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Apr 2024 06:41:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@svenschwermer.de header.s=mail header.b=NEx8w+Nv;
 spf=pass (domain: svenschwermer.de, ip: 49.12.228.226, mailfrom: sven@svenschwermer.de)
X-Virus-Scanned: Yes
From: "Sven" <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
	s=mail; t=1713447717;
	bh=sBZrPIep4Lo46scxi9v+hOepMbu/zSA41vLCQBByaew=;
	h=From:To:Cc:Subject;
	b=NEx8w+NvI1fiAYP3d9fpVpflCvgDAFmHxdcwGpnm/hxUuvugKE904KA3dJajO6NN1
	 fTxUWEgABwIHWtgFkEVl+Lv+gLZ+gzZGqQYlujxNjVE2XsSoy+hj/M4cmYq4oN7ds3
	 oroCQC5/Vl9k9v+fuU92/yN4ca3BCe03ARPyjXvWDYhbeFI3KSs1Pd65rUw71DOuS+
	 suKpZ4lu60Raq+lVfQ5oeb4bmFYKJ2046cKvUoxkjZ7E4frs9vVRKyggTktomhTYa1
	 tfbGRNTzkWL/ZZW4khlm6h7z4909FJkXYKi7BR7+BbX1nTH8J4w3wdpFZd8/U1Bmls
	 kieWvK4dfWWBg==
To: bitbake-devel@lists.openembedded.org
Cc: charlie.johnston@loftorbital.com,
	eekmecic@snap.com,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Subject: [PATCH] fetch2: Add missing runfetchcmd import
Date: Thu, 18 Apr 2024 15:41:47 +0200
Message-ID: <20240418134147.184430-1-sven@svenschwermer.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Apr 2024 14:17:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16110

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

This adds the missing import. This bug was introduced with 1ab1d36c.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com=
>
---
 lib/bb/fetch2/gcp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index f40ce2eaa..eb3e0c6a6 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -23,6 +23,7 @@ import urllib.parse, urllib.error
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import logger
+from bb.fetch2 import runfetchcmd
=20
 class GCP(FetchMethod):
     """
--=20
2.44.0


