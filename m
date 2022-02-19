Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D7C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:47 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web11.11883.1645288846099635494
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=TZLMTDdo;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.west.internal (Postfix) with ESMTP id 86C712B000EB;
	Sat, 19 Feb 2022 11:40:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Feb 2022 11:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2JKv2a
	D6picwChHwUy+sA6kZHXba9jHEok8cwN1dAwk=; b=TZLMTDdodRVld9SW0l2ttD
	KUECeYFIpSgqa99fuCpZB0bO4niqV7pp8l1axGVw2J7Cg2SOkJO1viqwV37VeP3U
	W/Yrwa8DyrvMbGwGunNBLsqB52I/KGn0geRbyeRscntdRKKvnH2X0F3wqggHs15y
	4BQsKA/bwqkJVH/QAtiz8atgPwxkCmgeA4GqJZUFawe75xVpeVa493ftP5DpRSfy
	Y99EYddzXPPdQ8zjVMQf/zMZn1LuF9gK6vRn4wBFNhIEgpaunJUSkkX5zgXOn2b+
	VO0/dh2q+E007RpdyqjZMUJdzKL1Mwdj9MNZIGPjJNcuIIx6/GqDLiTYNcrOOxUw
	==
X-ME-Sender: <xms:jB0RYuUYr8928Qs0emrkEXtltq60u7mnVfrhrBfqCVpdRxsIstNtMA>
    <xme:jB0RYqlz_Y4BPHOPOfV0irgUqF-lCB0yZdOmI5-T1uC33uXbkaFmaw5iizpgxG66b
    bwuzvMqX8ySjIxx3w>
X-ME-Received: 
 <xmr:jB0RYiZtAL35eL8fSpEtLKV6bE2U1tVuGpWZf8Tvu-ZsaOoViUm84Z71aOGsPZtRbdAMTxrDRqfL_TbXbtpKCDeB3uVkGM05A-OjQ0HDnmUrWD7x9O0ZnsQCJkKhctA>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:jR0RYlUJKrMGmauzexGmB2yyRB5wZBX5v7qAG1SK8W6_rlIpEkGHqg>
    <xmx:jR0RYokb6Jm2743bu3X1ImFkj7pKP663mUoG1bJk4oFoBeVH6x2HlA>
    <xmx:jR0RYqdrw8Fw7mUXqfO03T_OXIshF_7jUFYf8O6NG6tO9Nhq9GUskg>
    <xmx:jR0RYqQSs_cufghFzNWSvqvtt5EaWMD-3lQpwYuOkwPIxFjngFlfOY8F3CM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:44 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 11/17] process: Fix typo: "process"
Date: Sat, 19 Feb 2022 17:40:15 +0100
Message-Id: <20220219164021.8344-11-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13378

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/process.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/process.py b/lib/bb/process.py
index af5d804a..be2c15a1 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -142,7 +142,7 @@ def _logged_communicate(pipe, log, input, extrafiles):
         while pipe.poll() is None:
             read_all_pipes(log, rin, outdata, errdata)
 
-        # Pocess closed, drain all pipes...
+        # Process closed, drain all pipes...
         read_all_pipes(log, rin, outdata, errdata)
     finally:
         log.flush()
-- 
2.25.1


