Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72962C433FE
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:39 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web12.11865.1645288838272231649
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=RzThEtCN;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id B21322B000EA;
	Sat, 19 Feb 2022 11:40:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qSFkkc
	DKfYhGMTEVAie+dAO8rtiAOwsPuEMwAG9+Yko=; b=RzThEtCNncCc+poTfvGkqE
	RHDj6z9hdVOULM5NGSPITmPNvASiXWKmivE/VT9hcWALec7y99M40yT2oQneTz44
	2zNZeuGHwJcIZ/oGW6EIycqHwwZyVbQheEDbAAFFc0wjfRXRCiPPGPZduc920hwD
	T2030PbqaQourAff08W/3y1nYY5+RrFX9MSe1v3IchUsnyerVLnLbSwFJbdgN1ua
	wYtcUFJjlI2+UwyHEe6DB9KGtaxy1HH2k5/ccjnP8aYfbmF/NiuQ5ckJaWnsrO6q
	4x9BebSATRsJr7Sg4d/bzfV1ZRMrERCJJTSQT3gAkr2Ezs8NXcIN6tUkK9uBmdDA
	==
X-ME-Sender: <xms:hR0RYu1pz-FZxZ4V14TNiSbyV9S6RDBJ7Cr0foNuKEGAw7et6R5-wQ>
    <xme:hR0RYhEk7fIup7bKBz2nwB_R6aUMKxNjyhdDuo0y1485SfL9DQZET0naMGR5_THvw
    fmTk0XNnSsqBN7WNw>
X-ME-Received: 
 <xmr:hR0RYm75a3JqC3_60ydfQKBpirvExycuH1XvnaqNtZstGWsVlN4Cn2P-s8d3JZMii93GO3oriXDlaVmMvwPtPvE1cKI6Sr91BZq3F1AAUzRHJ4VedbfNEv0lqBzR5sQ>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:hR0RYv1zXVQX734ftsrMlWjf31_JV50VUnRZaP1RIW_dkMp990RY3g>
    <xmx:hR0RYhF1f3FBM9kBT706FDl2PMyGr8z-e0-yUjVXjr5OmQBTPzPOgQ>
    <xmx:hR0RYo-6BAHYShJZRfIzqyt-SDgrb0Yv6aXAgEKIQElI5iR9SxDNHQ>
    <xmx:hR0RYgxoMc_tlxI2rFVblFsgvr4qJT2Hp64BlgRQLD5B1LWPJJ-NC4ILLPM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:36 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 07/17] fetch2: Fix typo "conform"
Date: Sat, 19 Feb 2022 17:40:11 +0100
Message-Id: <20220219164021.8344-7-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13374

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index d099cd10..18a71a07 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -182,7 +182,7 @@ class URI(object):
     Some notes about relative URIs: while it's specified that
     a URI beginning with <scheme>:// should either be directly
     followed by a hostname or a /, the old URI handling of the
-    fetch2 library did not comform to this. Therefore, this URI
+    fetch2 library did not conform to this. Therefore, this URI
     class has some kludges to make sure that URIs are parsed in
     a way comforming to bitbake's current usage. This URI class
     supports the following:
-- 
2.25.1


