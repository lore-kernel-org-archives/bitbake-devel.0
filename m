Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738DBC433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:54 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web09.11833.1645288853362469812
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=LzzcPc+N;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id C266D2B000FB;
	Sat, 19 Feb 2022 11:40:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Feb 2022 11:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3y+KjP
	SZxPZIt+U2IS4LrgD0vCKlBrszuFlIzVLctyM=; b=LzzcPc+NY/01Ee/G2pYPMm
	8AYiB3x6XU01u9w6mR+b9DH2pjxYLEsdISdaRxa5KXGwd9slr0fgSjkriockIRle
	Oum8xuvayyvscp4gcbX/9odooRQ2aT/81Vzy54neAxBA7wA21T2g2xUubyJykqWz
	6N6RDyyEiDNffY1KPMNISB8mnVrIus2WTp9+zminH3nWaGYhQpJcB+dQnMWFWfwn
	Yb/MDRemIYHACKWExQ5aGTAVopmIFV8NNka3i2zty0g83bJwPdAFa1h/flRg1Hv8
	SdCIuG5sPWiZjcwOB/MiL60xZ7uQwdxMNG8Noq62y8qsG0+LBUPQio4riXL3i4yA
	==
X-ME-Sender: <xms:lB0RYi1OVXCd1SOxCH2bwy6ccEfZ5kTjEMbXbxDtLZZx3o45BFhfXg>
    <xme:lB0RYlHTANiKShLosVYSfFfb3GI3rJFz6GV3dEbcepQAA99d9QNIx5JYcY3S5Li65
    dOvDxkfhRcQxdu-hQ>
X-ME-Received: 
 <xmr:lB0RYq4XQbp6GotGwG2eSLKJ6Z3eEruXNNLtdG3caQOdxcVoJoW-I8Iasq2c5IcTRZAghpFt10nO1pAyMLaaaqsgDn5GhUJMixBS_T5TM97VKVbmBTVDNSjEj9ChhUU>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:lB0RYj3VSMYKeRjXZIqosGyT6rpjx-xzq4YQNg13FI2WZi058BAXZg>
    <xmx:lB0RYlFdF5PxhFaKU_QP321NamyGk1uD7l3wSjhE8PRXmXQuJ6KoRQ>
    <xmx:lB0RYs8dXGQbJVtv9MZT6-cbfS-4zFa9pW_qaFmdOqHLnlITO53wPA>
    <xmx:lB0RYky_06QZOdwKnp3A0zIQhN78cEYkG7W7Mm1BI2-J9j5CRdz-Z16Xxcc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:51 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 15/17] utils: Fix typo "dependency"
Date: Sat, 19 Feb 2022 17:40:19 +0100
Message-Id: <20220219164021.8344-15-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13382

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 128b3ab5..12e65b9f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -253,7 +253,7 @@ def explode_dep_versions(s):
     """
     Take an RDEPENDS style string of format:
     "DEPEND1 (optional version) DEPEND2 (optional version) ..."
-    skip null value and items appeared in dependancy string multiple times
+    skip null value and items appeared in dependency string multiple times
     and return a dictionary of dependencies and versions.
     """
     r = explode_dep_versions2(s)
-- 
2.25.1


