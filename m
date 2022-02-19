Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752CAC433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:52 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web08.11634.1645288851769604777
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=PrWDjB+3;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id ECA7F2B000F4;
	Sat, 19 Feb 2022 11:40:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 19 Feb 2022 11:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qxsDO/
	PVoWQ9qg5a8rFc2deDo8HJkauY3XpLjGMLg0g=; b=PrWDjB+3R1BBgCr1eAxUq7
	DPWV7JGjRSY3xDPCA4J61Tf1pPfnwzMZLhRppGy97moTAZPRHaqvsGEMOTG65a3P
	GCai2z+oESaN2G1a3UxmKJO6wDm3GZOTqcOPBx6ZMcblJQ3pbKoWTULKVZsvLcqR
	g0qH4TRG0mFmhBScNeIA4WfN2kjcx/wY14Hn8twBkIkrnUHsqW+zOGB1c/2NxVaU
	ZD4kJO2uuZ2cPytyjZXqmeJNCFP2gtvVC7AqqIZTA7KM+z2QZeUwLSMTKYCm5hp3
	ctai7hNsGuMYMkFamo0/ertmxN5GRizlGK39bRxDSTNKP6EK+zHnH2hzZ3ymWvZg
	==
X-ME-Sender: <xms:kh0RYroRlpmOiypSIO0g_2Jx9muHeIYYzKionkPYZhj-EJ7TK5NLvQ>
    <xme:kh0RYlrEQCRjVaDC-kfqUbISmyKYBvabxuP9aWEOUf2y34PFg5q8waRXITjDf5Zg3
    VJxvya5otHxaG2hGQ>
X-ME-Received: 
 <xmr:kh0RYoPOVKbwPn-RvMSMowD1tQ5pEykPocXxREUjr8FJOQmM-Wb3eMWVZu7GJMitSnLdKmJHANhQdVfqm8Dfl60RnVGCY-AvgsI0ZmJFNaALsC9HvCB21OkCdslU3_E>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:kh0RYu4LTUOVSVCuoEPYjJmTZn19JYi0mbIz4X_VgODKHIc3EqBHNQ>
    <xmx:kh0RYq6sMYBDKHyKBtuFp-CvNPgjQgoFvckMnfWiV4dBRfK8PzDmbg>
    <xmx:kh0RYmh2mcsY34iKPgnzesEF8CTsjv8iHrf-dCOlnUuv8-Y44Z20mg>
    <xmx:kh0RYnVoE53Bp7Jm_ZM5C6Pqd2X5DPS2F_sy5I_ujKUvDHMZC_6MchX0SCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:49 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 14/17] tinfoil: Fix typo: "something"
Date: Sat, 19 Feb 2022 17:40:18 +0100
Message-Id: <20220219164021.8344-14-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13381

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index c3ad9211..02c0bab6 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -761,7 +761,7 @@ class Tinfoil:
                                 if parseprogress:
                                     parseprogress.update(event.progress)
                                 else:
-                                    bb.warn("Got ProcessProgress event for someting that never started?")
+                                    bb.warn("Got ProcessProgress event for something that never started?")
                                 continue
                             if isinstance(event, bb.event.ProcessFinished):
                                 if self.quiet > 1:
-- 
2.25.1


