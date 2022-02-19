Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7962BC433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:29 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web08.11628.1645288828405940616
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Auituatr;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id D38A72B000EA;
	Sat, 19 Feb 2022 11:40:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7z+Tdb
	Yho7i0wpzmRa4m7MROAbxNUGv1oBgVvLqEkFM=; b=AuituatrA36dLwZ5X/pDsH
	0IuQe2o2XASKzQHx39AHSjAm2LHlCvXah2O8CQNFrvngOLZsR138/+uwHuDFy2do
	M9iOSPeb7hvFff6GoGric5yvLyjakR688+Ux7YDQ4Pl1TacpDwFYCqPo20t6YZVB
	9laFOKMyvolivMxIUbl1gQfldijd04d+8H7mmpYMrIUkK2bT55LcEm01/zV0nGfk
	xWOBphs4cvNJs6XlG2UHsOkOHwahTC4HfchUnvZO7gC4+mblqNivK2oqEqYZpg5O
	18GptPgJdh9n2mYjuVI0jtSk3p8puhKAsMeZYLc7OwuP3bOH5C2ie1PR0fGN87nw
	==
X-ME-Sender: <xms:ex0RYpUS5evUVOEId3sN0iz0p-jb7EC5iYBqr0F9KYWbWP_T01S1Gg>
    <xme:ex0RYpnjjN4kpEOOmfkbCMYYFigTaGTk98pME7HBzLyeBhLjhqgyvgwY0-4wbhMIo
    PM_mO_JVlK1wOn2UA>
X-ME-Received: 
 <xmr:ex0RYla25MwK1xoh2iedWS09ck2zgaI90Cttxp7IjzwpTxurkelhPT9jkCATMALLBV573bGu2kQe4ho1q1744NoBSpXhLVgCHoXkBH6SGWDrL00i6O0ZilvN-C8gr30>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:ex0RYsVSXqkIH-u3vY2EhJZTlsuvi6_kjBqu6-uk5qHju0L0n6dDOg>
    <xmx:ex0RYjkAZjtWXHFvGwaHbfJXhMpH5wB7ceW4-d_M3Xj_B4oqUtXElQ>
    <xmx:ex0RYpfqExJ2rURVvoWo7JMw5ppE5Hg9Rltd4qQs4SR8YynYd6IjDw>
    <xmx:ex0RYpSQZo1Gc3Uxx3ss1Pt3FqUVVoLPk1uKRP0M95ch5WynYJWeI0RjXfk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:26 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 02/17] cooker: Fix typo "tuples"
Date: Sat, 19 Feb 2022 17:40:06 +0100
Message-Id: <20220219164021.8344-2-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13369

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d15b0eb8..2ed984d7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1763,7 +1763,7 @@ class CookerCollectFiles(object):
     def __init__(self, priorities, mc=''):
         self.mc = mc
         self.bbappends = []
-        # Priorities is a list of tupples, with the second element as the pattern.
+        # Priorities is a list of tuples, with the second element as the pattern.
         # We need to sort the list with the longest pattern first, and so on to
         # the shortest.  This allows nested layers to be properly evaluated.
         self.bbfile_config_priorities = sorted(priorities, key=lambda tup: tup[1], reverse=True)
-- 
2.25.1


