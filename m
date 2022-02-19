Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7BDC433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:27 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web10.11891.1645288826440853603
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=bgv4TiTU;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id A4CA52B000E8;
	Sat, 19 Feb 2022 11:40:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Feb 2022 11:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=+rmo5y9pzY+6tLWKqX+0HuNqER5OF
	aydKuuCGi9pZBM=; b=bgv4TiTUF79rsGy+4Tle/eTRLc95YWou6+eWhdfjKqlKm
	RrxFh7W875hlqJbDJp8BznwT1NZNfKL/VoR1fsjjj0wFPyWXm6u9ftyToj+oNdJc
	X+TU0y4E7uGBfKkUcci2Bt66F01FG27rk4J27stOqw6/CpVu9N0k2zWamEQdWWeg
	D8ujiW/p9BzHRLLk4D235yuym9N6L3oGEIR/eZyLbcGO4hiviCf+D4BwFPdVYHXP
	N5VQ67nA4K2gR/XPbUsx1kvoFsVUWEuBZfx5FKdsrbA4hnmDm2aj++JzFiCD1SOQ
	wErg7EDxes0LftqOkhGElNd9pJjPbRBOWq1NWYzig==
X-ME-Sender: <xms:eB0RYoizu3owmT8MBOI6e5hL8Ofl2BmWRHJki_P3254wQBIzhc59bg>
    <xme:eB0RYhC9jZ5WA-_-IgpC39orYM_cCZdo9vdTP3pFkHQPt2I5dw1QlnHsP5-5bD-8i
    8idGeh1wMHqmC5L_Q>
X-ME-Received: 
 <xmr:eB0RYgE4VvyjX2DwQjD1mA5dTHJny43kwRGFZWMboWItLSBGSOnLkV86zNYnnf5qFSpVWkU-wan9EXH84xliRB2gC2wOaNER6s4mJIUnaOGWCxJC6OL_b5kFYO2alf8>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhhtrdhk
    rhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpeeivdfhle
    dtieelieffuefgheekvdefffeihedvjeethfelhffftdehveekheevheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrdhkrh
    ihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:eB0RYpQq1qoz3Cjp_XMVeXCpQZws3lnWyOBIIMqVvtqmgg9RjKgHBw>
    <xmx:eB0RYlzdJPyAbK-h1MmQ0eNLQYUKivp8TTwaZqoDuPFcwtW4bNA3XQ>
    <xmx:eB0RYn6ESdQJOu4uilzjlwiSTcntLb10ldpkK7skL_2WaOuE1pEBFQ>
    <xmx:eR0RYuuBxitZ34CWHVKFX_v7xi7PKAwjn-u-a6KnB7JfIb2ec2F8MCeDQQQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:23 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 01/17] cooker: Fix typo "isn't"
Date: Sat, 19 Feb 2022 17:40:05 +0100
Message-Id: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13368

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d1d4e325..d15b0eb8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -607,7 +607,7 @@ class BBCooker:
             data.emit_env(env, envdata, True)
             logger.plain(env.getvalue())
 
-        # emit the metadata which isnt valid shell
+        # emit the metadata which isn't valid shell
         for e in sorted(envdata.keys()):
             if envdata.getVarFlag(e, 'func', False) and envdata.getVarFlag(e, 'python', False):
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, False))
-- 
2.25.1


