Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C891C3DA4A
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 12:17:16 +0000 (UTC)
Received: from 8.mo561.mail-out.ovh.net (8.mo561.mail-out.ovh.net [87.98.172.249])
 by mx.groups.io with SMTP id smtpd.web10.14314.1739362625457200017
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 04:17:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=EJ/eUyLU;
 spf=softfail (domain: syslinbit.com, ip: 87.98.172.249, mailfrom: louis.rannou@syslinbit.com)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.109.140.194])
	by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4YtHP747D8z1SjC
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:16:59 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-fb9gf (unknown [10.110.96.146])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 53AC01FEC5;
	Wed, 12 Feb 2025 12:16:58 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.113])
	by ghost-submission-5b5ff79f4f-fb9gf with ESMTPSA
	id n0MkBzqRrGfDjQAAM+UVKg
	(envelope-from <louis.rannou@syslinbit.com>); Wed, 12 Feb 2025 12:16:58 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-113S0078f271664-121a-40f1-ab2b-492e52d41e42,
                    74B36F6499D71BB1255966C6406869B815799905) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Subject: [PATCH 0/2] bitbake: fix ??= operator for getVarFlags and test
Date: Wed, 12 Feb 2025 13:16:17 +0100
Message-Id: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGRrGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0Mj3bLEorScxPRiXfNUU7M0c+NEY0szMyWg8oKi1LTMCrBR0bG1tQD
 hKDF2WgAAAA==
X-Change-ID: 20250212-varflags-7e56f73a3966
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, louis.rannou@non.se.com, 
 pascal.eberhard@se.com, yoann.congal@smile.fr
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739362618; l=738;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=Lqg5Aa+GL7l22Z/yY29fe8X7t3qCiV+xHuUUbY5sGPU=;
 b=QinLCYeJhvUurbG7/o0irYIo/IMLbF5S5EV4qdT6sGrkNEfd4BiaQXX3baRdhhflSzx86GqlN
 Se2gs0Pk0LuAO3pvbAQTUx/3dHVtkbUyB8ELyHS7O+KQqbhURBo5sU5
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 10464958162733686081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeekhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepjeevvdejuefffefggffhfffgvdevteetleelvdekieegvdeiteeuledvgeevheelnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehiedumgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=1B3uBBhXuaSiSsw3/8B88FH0RL/vYBYkrU2Od784OeM=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739362619; v=1;
 b=EJ/eUyLUuElSx5FYZRdlNd02kO9gpDibTzclFj/GtUkcxH4VxInV+iuUIRtXAs7bPVCiz6Kq
 WirQLpaMqvVUYg8YPNLsYysGVSU19E7AOEdLNcPokSs3hiXayJeR3tyz787AIhRiLEJ9+4+7oPn
 mFodVYQuxtSzFNwRu4pdhZ2JZCSlE4YTCr0M3dJ2tBq9Xo89Ja0zeKBX2qzYDy22rGeBLvMu5sm
 /cCmPR6ZjYqGyj2WRR9LBBKcMUOpBLjDwBQ7wAniI0FgexgLedPLV22e6hwgEFTxVxgrfIK92Cw
 +Tyap9CuFL/vZXbYPGC8u9LI82zHAW+oESJJXGUF+LD7A==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17202

Since commit 0329a7e3ac694737f2d2c1861f65492551360663, weak default values are
omitted while they were only incorrect before. The first patch fixes the issue,
the second adds a test for validation.

Fixes [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@syslinbit.com>
---
Louis Rannou (2):
      bitbake: data_smart: fix ??= operator for getVarFlags
      bitbake: tests/parse: add test for getVarFlags

 lib/bb/data_smart.py  | 16 +++++++++++++---
 lib/bb/tests/parse.py | 16 ++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)
---
base-commit: bcf090ed631bbd523a5341baebba0765f1a847f8
change-id: 20250212-varflags-7e56f73a3966

Best regards,
-- 
Louis Rannou <louis.rannou@syslinbit.com>


