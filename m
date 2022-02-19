Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7295FC433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:48 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web11.11884.1645288847942993574
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=aFI1+UA+;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id 5DDE02B000E8;
	Sat, 19 Feb 2022 11:40:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 19 Feb 2022 11:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=f7lLj0
	uphdgIf+SgyjoTuxLcWh5d8+t1PD1gg4oZi9w=; b=aFI1+UA+6xaWQgkDpMslKm
	2cX+GjdNV3K/Pyncf4ztC0vDnZS0jXHfKkY+LrvQ1lZ3ZlYEh+CcpvKhgS1UeVQt
	JvL7saW5cANpQerVF35jG27anY3mDnKDtmjmYAoRQMGWFNLv4cTSAiaWqklBXZhu
	rzbloDWD4d4xJZVPxcsnyIl7n8dzeMHqpN3y6c+dnWtM0jV63bROnIuMGVIMjuoS
	rFDYGvIeXdciwK9vFQ3+4OTSYwoW6iycbhSD1YYDTnvcpnfAAE8UrvbhDnfISIz9
	OdECrnR7ofRJs2ZnnaRTbR4xAP5X31kPYhQ4s4M3SaPoNqn1EUtmNfwlzwa6qZTQ
	==
X-ME-Sender: <xms:jh0RYvYc6M7oESLmw8J7Q9Y3ooGthW0milCAw6R1QM0BCNtZPLxiAQ>
    <xme:jh0RYuZ0l_EMsg08CKCtjl-ya24Br2R-1EIWYNCpMHzGYiCiL0yxBZeIoSdyuSe1S
    z5HaiGx9ed9Uv8uOA>
X-ME-Received: 
 <xmr:jh0RYh_C6x9Z8X1wg0Y7V8ggEHmDv16gFBVTYalGWl1DwAinbbwHSsMUpLbjxgyRycorN-pt2xIttcepvHqfxafW4aC8RA29BUHMCWEIPcy2c6vN9gtAHKiFXpS6V8Y>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:jh0RYlrtQIM2vTzqtCP2Z297jKNFzRlElUvh-W4ah11jAuip2ZSvDA>
    <xmx:jh0RYqqvH09jygOn8vjuJSelk6dHLzAGNohqeEj3Y1aptUWfQ0Ztsw>
    <xmx:jh0RYrQj7wVJH8le32VM9c237d2mYI6nsCMUGtqAejjlt2liYa7gHQ>
    <xmx:jh0RYoEeI2Us4TNwR4-0CwSQRDV8131SLE3YmtVZhJ8eoeLdGxWnDYFMdA8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:46 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 12/17] progress: Fix typo "wherever"
Date: Sat, 19 Feb 2022 17:40:16 +0100
Message-Id: <20220219164021.8344-12-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13379

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/progress.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index 52d704d6..9518be77 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -148,7 +148,7 @@ class MultiStageProgressReporter:
     for tasks made up of python code spread across multiple
     classes / functions - the progress reporter object can
     be passed around or stored at the object level and calls
-    to next_stage() and update() made whereever needed.
+    to next_stage() and update() made wherever needed.
     """
     def __init__(self, d, stage_weights, debug=False):
         """
-- 
2.25.1


