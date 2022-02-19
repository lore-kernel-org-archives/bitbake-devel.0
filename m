Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B0FC433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 20:21:58 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web09.14216.1645302117515831456
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:21:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ASAF/jES;
 spf=fail (domain: huawei.com, ip: 66.111.4.224,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id D271558016A;
	Sat, 19 Feb 2022 15:21:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 15:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=3x70OWrSbpipWcASn9vu9s0IftiWI
	5dkDTN+5ilLDkY=; b=ASAF/jESjATp1GvrNrIJNKARxCRiZrb2OINkZHuTvwLsi
	tzyE2/TfQUy409CiQzMil8xSWFFnKKyY3Wn1rb5EtKnxnKw7uLgzY0ObCLDHrtPW
	+D+Fbixl5QrO/vBqVCQrGaYN5xt01GMUTvRwDqPTRqh9LxZUcbDK17iMyyeEfIsJ
	633sTRRuoCbIlWNaPX0XLkzg+dZn6uuxlzb0Kc3jZDE5zpmylh6pV3Iztj0abti+
	vPRCccPAIFrV8p70lDZYCbxk8VmK3aCcBsfxovoWteD1c6NahZlbY0uGsh7CTwHZ
	A+39svKSpxiriMU38tYA5+RvkadkuvSEMYyAFGNYg==
X-ME-Sender: <xms:ZFERYm9vW7fjs2fPFoPRCZbJR_RzAgyzmOT_CuAe94i2ZMqUXrA_2Q>
    <xme:ZFERYmtIVny1TxNmnpMH1m1zugTpQ54wxhiUXdylxahQVZtzp1vpqCCNsWJ9ei4B7
    O1V-V4c3rAZKJbw1Q>
X-ME-Received: 
 <xmr:ZFERYsBP0fkBVAAZOspKXL-odnHDITxFynR5zDvzsf26sjn5kT5nh-MLmHWLUKK7OWPoxtaHuE_0qXmW-_9DwNb3g4GSG4xpi-PCCPbHLPs8U124h8BjiVAigd0UdHg>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepkgihghhmuhhnthcumfhrhihnihgtkhhiuceoiiihghhmuhhnthdr
    khhrhihnihgtkhhisehhuhgrfigvihdrtghomheqnecuggftrfgrthhtvghrnhepiedvhf
    eltdeileeiffeugfehkedvfeffieehvdejtefhlefhffdtheevkeehveehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiiihghhmuhhnthdrkh
    hrhihnihgtkhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:ZFERYufgqLX7u-00wya7JJ2zf_wsjHn4V6rkMDgLTDlucpcP3G2UzA>
    <xmx:ZFERYrMQL_aMtFwkL1gWLWYUcyDmxe1xA63puIIRoGywypeunYYOgg>
    <xmx:ZFERYomK9TrZhYMhoLtS8-uGF4O20uGNeOlGVEsDZx-TPI6DnsLWYQ>
    <xmx:ZFERYqb9VPqlUhmGCFtB-82AlxPRY_wV9d-hXB3ZN-eILh9sUf-gdA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 15:21:55 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH] bb: Fix typo "priority"
Date: Sat, 19 Feb 2022 21:21:49 +0100
Message-Id: <20220219202149.8441-1-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 20:21:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13392

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 269f65ed..de1ff893 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -150,7 +150,7 @@ def note(*args):
     mainlogger.info(''.join(args))
 
 #
-# A higher prioity note which will show on the console but isn't a warning
+# A higher priority note which will show on the console but isn't a warning
 #
 # Something is happening the user should be aware of but they probably did
 # something to make it happen
-- 
2.25.1


