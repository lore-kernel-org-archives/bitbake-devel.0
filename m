Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94386C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:37 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web12.11864.1645288836408389321
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KgRUyHrE;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id D36472B000F6;
	Sat, 19 Feb 2022 11:40:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Feb 2022 11:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=znElN8
	UmR7+n4//nfW90F/sQC5mXGpLxbVcoX2PitKU=; b=KgRUyHrEnz7vBwVA9ZnDS4
	yjg0KZPLVUNBoQVWhy42AhIZ84l7Dfb0orZSR+vdLhqYnoppLeI/WbXfxzRMbRHt
	V1/ZevgkovRtK9cQVQWoeyEUDFWQKcppWhfwk+KoFxtx7Mrea+V40s1E8wWVMakX
	VCnB7FeiJvcgMjrQaWGiYbUv3ismyrH/kqYP1zrrvgoh+cxs+QnbPFjJWtJAvWdT
	XqZ573BTFqALn/ZdbgK8fECe/NMKp5N+FnUD5cPmIEpDPFDX3MvF7sL2AtaYxJLF
	ZAUbwIEkffJHv5wm0NJciCQqtWuwqh2uKdcJHoxZV28ut+KiDR257h7NGS0MRqsg
	==
X-ME-Sender: <xms:gx0RYofJa8l0-KZVjnqQfsbgGrhYQUVPMP2GCy86Rn0eYovAlgyvBA>
    <xme:gx0RYqM0XrwCT1czpzPLH1s65GcsM9BoKh9aMm2lM_I9aEdULgLD5xuGTH1oSGHsA
    35i6Cj2sYTVw3fXBg>
X-ME-Received: 
 <xmr:gx0RYpgzC6-9y5zSnGMgEwJcS9RhkfB5xbWO9O8uIByzJrokhX4TnRCBWSPw2lRCisqzyLnPsqgKa5NAqNZ4pIPTFTRMvM-vyzVb60E99ymaT-r109EwwhfU7RHvmLc>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:gx0RYt_zIj1Fcjw8HPp1NbLvNWZoWMRp9OoZ3lWj0Z2bIJ0MvdG91w>
    <xmx:gx0RYkv0097RchT84dKN58q5NmvutyE4gnl6LvezTlc8VdirJAkp0A>
    <xmx:gx0RYkECxQ3WJYqcyn6Xa6FDKNy0NYNjE-dWln5B7J-8kOC3ss_3oQ>
    <xmx:gx0RYt44KRPaA3Sput21z64c36zAGyw0VFBchJrmki7-4OMcbqb7Suzjt-c>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:34 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 06/17] event: Fix typo "occasionally"
Date: Sat, 19 Feb 2022 17:40:10 +0100
Message-Id: <20220219164021.8344-6-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13373

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index c81e79f7..89215e3d 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -40,7 +40,7 @@ class HeartbeatEvent(Event):
     """Triggered at regular time intervals of 10 seconds. Other events can fire much more often
        (runQueueTaskStarted when there are many short tasks) or not at all for long periods
        of time (again runQueueTaskStarted, when there is just one long-running task), so this
-       event is more suitable for doing some task-independent work occassionally."""
+       event is more suitable for doing some task-independent work occasionally."""
     def __init__(self, time):
         Event.__init__(self)
         self.time = time
-- 
2.25.1


