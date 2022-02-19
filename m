Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E2C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:55 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web11.11890.1645288855209081282
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=dSq8274N;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id A03EF2B000EB;
	Sat, 19 Feb 2022 11:40:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 19 Feb 2022 11:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0CgOYp
	8XofUpaWtZDDJ4qChBJq9oBhleyaVMdI0qLHU=; b=dSq8274N/XC7GXPHya3ubn
	SrguMb4DH+PIZ5JREpFeSE6whcpTRIfashEnAClRHvXP2oXEVub4kJjHh+dvMLCM
	pwnhrzeBmLLynXP9CLwj1GpC9fi1s+UnsF4LsmM+s345HzmF6uS8M3pzZg0RjCw7
	337FmlqvjhFaU4c2NKz14SWwxAY92VIz4ujGx+VKiUjOSwXca6LTmNOaFA+zbH0n
	e5GZifwr8VTa5qG+JZj40hjcK2Hatg34Dz/UPrEnQHJLiX+FqmLnZH6gG4c0GAol
	72ngGINNgcPja0N4d0rpPJ6Q20qckUCw+5VGC303+ezTET5PT41zkmnmxfIWX61w
	==
X-ME-Sender: <xms:lh0RYn9WovFiZ4GW7OJFY9Yn_uD2mjIN93nfIZn-cC6WwOjV0J6T2A>
    <xme:lh0RYjsK3-J2WabqiaCTmjMJg2ieCaAdaXsAZ6_fx11PQz-tK-zIsIoeqNeH_TVjq
    gHSwu3DaFZoSK1gXA>
X-ME-Received: 
 <xmr:lh0RYlC17Iv5J05RDdNny-0yAm--V9VUHN5Nk0fY4Oa4elByvLMc-Uo73GskGeGHSYVgdAG2mTRdtH20nz3x6ll4vTqVX6aclT6-Tcziot38RdgL3bj5QTVJ4zXZPWU>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:lh0RYjd_UgmyJdgm3qgu9DYydTCpENpPTAjlGPc-oGgrCq1eMku0sA>
    <xmx:lh0RYsNYY0vkqCiVzo1ADZkV-jeb4_MUtWVeLvNvq-AEs5DbIL8vSA>
    <xmx:lh0RYlmZtslsDyO1X1HVHGnO_CT7BeoJH4ctGXNjr4M096bbUWb7Qw>
    <xmx:lh0RYnYpZlVZmPuqWHBD4PFoZGbAUU8XekJp5TFe50Fwjd-KOeq5c8iEHvs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:53 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 16/17] utils: Fix typo "spawning"
Date: Sat, 19 Feb 2022 17:40:20 +0100
Message-Id: <20220219164021.8344-16-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13383

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 12e65b9f..084ef92c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -381,7 +381,7 @@ def _print_exception(t, value, tb, realfile, text, context):
 
         error.append("Exception: %s" % ''.join(exception))
 
-        # If the exception is from spwaning a task, let's be helpful and display
+        # If the exception is from spawning a task, let's be helpful and display
         # the output (which hopefully includes stderr).
         if isinstance(value, subprocess.CalledProcessError) and value.output:
             error.append("Subprocess output:")
-- 
2.25.1


