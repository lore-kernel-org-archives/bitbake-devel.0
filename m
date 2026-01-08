Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ADD185EC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 12:23:41 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5267.1767875017609380471
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 04:23:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=MH4ccygB;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=EUr+YtdY;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF4657A008E;
	Thu,  8 Jan 2026 07:23:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 07:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767875016; x=1767961416; bh=Nl
	v7L5zF5knw9Yx1eBMmiF4HvT7u99NQ+yJGPaOBA0E=; b=MH4ccygBCP+0k+wgT+
	DBD52cCxWK6bqjOu95AllOMXThrWXVVS9GwYIuWyhFRh/1vhrcjvVExyWzdtsRm3
	ADsEYVESnf72g3FrWKERF2n6M5q2fU70YtQ7XWhh+gJ8XmPIn2zMYRWp0ubkA4l2
	q1fYIq9vVwfnYK3B0/kFEY7OgXs3gHySrVWD1sxIJkhWyV44nQP6yWeA93TCyp6k
	C+q3UJDpXSUGt/XcOe+8T23bD0uutZmCD4fqT/GnxDB6RTpBk48l3FO3LosZZ0Y1
	uc0hc7ikK+jh+Vgt0m0+SpYbFnZZQS9vpqzFN7hBxW3xKor3hJTB1+vkkx4GMauZ
	Kovg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767875016; x=1767961416; bh=Nlv7L5zF5knw9Yx1eBMmiF4HvT7u
	99NQ+yJGPaOBA0E=; b=EUr+YtdYlr/nkgdl6ZEx7scAklZGeZeDHTeZoaQcEpPR
	5KpGAwhOky61qtDTG/9BmThm0/C/V/lDFY3/ZZDmfasG0jAWVwwuFkUeiB5pV3LZ
	+/vywEGuhbZQmU5AuZIjsXZxwNrCEgScgoGJbLSNW5BPNFOAZinT/tU+Z9uBcPqo
	1+Zj9nqWXRskcfwazgYESHVHyKNQVlJOt/XhWFfa+hoTVJYqODH44AvIch8wyURu
	RvFNyME9MhWB2/OCHfjpT+JlMQBoXhKx5X3sBr2WukEBEnZgur4Kt3khKW69Ptg1
	/bpuSAsuAZOz0uc1WaMpg77ApP+NrC3dJGePgDEnSQ==
X-ME-Sender: <xms:yKFfaWpcwF2B9Lk7Zfci46BbdNJMR5jqLcu_5ZS9fp82V3c2ik8VTg>
    <xme:yKFfaao0OrThhFNM-nVeZSLgEJp3wPFodRZmnX1KDLvRxMmgxrT12Ab3Ymj970dPX
    9xitOXSjUTSoTEJB1NgadpvJPIegYngr23rgrBQWqAYHRQAxGUo>
X-ME-Received: <xmr:yKFfaY0eGjWdxe94_mye7BxSnCc_5-Xex_Ajh5t0672cA_-QIfu7_2l1xgXrtEn5DkbvHugI_jmp9-hm25l8KBh1vm3R9ls>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepfeduvddukedtjeeftdegleejfeffkedvtdeiff
    fgfeffieekjefggffgkedttddtnecuffhomhgrihhnpehphihshhhtrggslhgvshdrphih
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruh
    hlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnh
    gvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehprghulhesphgsrghrkhgvrhdruggv
    vh
X-ME-Proxy: <xmx:yKFfaRD5Z6ux8n3wz9axVbDWzb_KWYqfQre5zCS5cEZBOpqjsxV7pg>
    <xmx:yKFfaYfpj8kPHZp2tcLx3n5_dG-gEKVwE5e973r1DqggrDi3TeBLSA>
    <xmx:yKFfaeijIRYyH4lwJmHrg3g7KHkbfMoH7usn3BE-EDHIgIArzDjVLQ>
    <xmx:yKFfaYrsCcvUpzJqYdFl4dfHn--6RnYUf3IEOfcC1i_sN2Xdwk-dBQ>
    <xmx:yKFfaVOB1Kjcrwq1Vjkm1GEodrBNMrDw5h-lNXEJ9Tj66mchkGPBKAhQ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 07:23:36 -0500 (EST)
From: Paul Barker <paul@pbarker.dev>
Date: Thu, 08 Jan 2026 12:23:33 +0000
Subject: [PATCH] gitignore: Ignore bitbake-builds directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-ignore-bitbake-builds-v1-1-f7a993e9059f@pbarker.dev>
X-B4-Tracking: v=1; b=H4sIAMShX2kC/x2MSwqAMAwFr1KytlAFtXgVcdFPrEGp0qoIxbsbX
 A3D8F6BjIkwwyAKJLwp0x5Z6kqAW0wMKMmzQ6OaTtVKSwpxTygtndaszIs2n6V3miP2VrUWeHs
 knOn5f8fpfT9D+m/QZwAAAA==
X-Change-ID: 20260108-ignore-bitbake-builds-dc8108e7b05b
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=679; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=iFiAq4SrNikVZndt54FnU8YRhtYEAYQfGW8Q+knvR5Y=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTGLzz+9tdMvQec5tsbD68Mcg2YVpg+U96y8Ab/N9afG
 102LGHi6ihlYRDjYpAVU2TZ3PP1/tNeR96MkFsKMHNYmUCGMHBxCsBErFwZGZYerE5/sr02ylJz
 3eFULqMPSpcbip8tZahhT/3bpbL1lRTDP41VJW2FTOH3XNPri34e2Ku9fVv9JdWodXe7St+t2eI
 nwQgA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 12:23:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18708

Running `./bin/bitbake-setup init ...` in the bitbake directory with the
default bitbake-setup configuration creates a bitbake-builds directory.
Add this to .gitignore so it's not tracked.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index fbf9eb2031c8..8152f617e72b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 *~
 pyshtables.py
 /doc/manual/html/
+/bitbake-builds/
 /build/
 /bin/bitbakec
 *.swp

---
base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47
change-id: 20260108-ignore-bitbake-builds-dc8108e7b05b

Best regards,
-- 
Paul Barker


