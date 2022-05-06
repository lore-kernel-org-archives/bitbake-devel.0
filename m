Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E6C433F5
	for <webhook@archiver.kernel.org>; Fri,  6 May 2022 14:20:58 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web08.10177.1651846856080568856
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 May 2022 07:20:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=ryLC1Mzb;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.27, mailfrom: pavel@zhukoff.net)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 6943A5C00C7;
	Fri,  6 May 2022 10:20:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 06 May 2022 10:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1651846855; x=1651933255; bh=4T
	egpgSNrK9Vl8QogP6CNGs5dgiQ5KrWf4Q96C+Lm5Q=; b=ryLC1MzbimyJ9OjH7w
	XEqJrojTvptwNxdDIOcHL/f4JJgnZjkTJBBc4AQQac3xIkdJ1k7bHoY8lDdAc4Ra
	isdZGaFeDE2NfYa4WnzYWqkKfmKx/klq1ZlcDwyZ+5yRehRiVNnG03je3S75s/dy
	C7HELeXGPpaRr0+QcL3KpukLGowpwstXJCrc8KdMDkec7VKJqo9v2z4Z+Fv3uNR8
	R2jmLWEbkEewOaLkHAaB0w5EfjaF0iYf5hfd4xI3XeC/zC8kTM2pTaUUmQGHnJJN
	hzJBvxAN3quE/Baaz27WO3TEPb5qzlmPkAUv8F4l3/Mz3zluBZRWQhwTJDidWW6K
	zfWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1651846855; x=1651933255; bh=4TegpgSNrK9Vl8QogP6CNGs5dgiQ5KrWf4Q
	96C+Lm5Q=; b=XiYgGo0dlQR7NBC9u4G8nNWNP9lVXqbrJI+5fhAxg7Rw2TCbFxT
	+rozW4syBOcRla1+oiz3nP4bbTuLaAdUdV9ldA83AlweqfLwpAzrCrYZG2XS8wBf
	EI7CGBMclcLF4NFYJ7aCoAc7NV5JGCOQE8oOl0f4WbofyMvloK85LfeCQDtUrCJf
	3mbfkY+SZcS1cPkqBXrNfpp/hKXF2LrR8NPMGD0J7NMoB5H0YYbFGP6Aao8/ieVO
	Pw4Sw5sOIdL3BwhGC2NpUgQEMnO0Lsvk2AtD3zi+EY6iOGrcK23LTd0p1aAljE7E
	4zmpoLzl1yZ5TSRru6WgY7AAkHNS/EvO7JQ==
X-ME-Sender: <xms:xy51Ysz3Ph9BXeyXKaolEK37YcTH-RG5w-fpqfvEoE0BvtbCQvyBfg>
    <xme:xy51YgTmdoBkyEtry7JbFIEOg5jXTGpt1YAiHZqAcTWV_pCBvdhg-zw9h96RBhapg
    qb79WqO5Y3K2uaewxM>
X-ME-Received: 
 <xmr:xy51YuXfVwAFg1d8vN0me_LYorzI2MC0ASuLtBptBicRmob2lhX3Igab2f4YTzbKxPOv2YeZwm5WDHHVOqJnBUM>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhk
    ohhffhdrnhgvtheqnecuggftrfgrthhtvghrnhepkefgieevhfelkeevudevvddutdelgf
    ffueehffdtgfduleffueekfeegkefgudffnecuffhomhgrihhnpehuthhilhhsrdhtohen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvg
    hlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:xy51Yqh-kVr-bza-Nq2Gerz1o7bQCx26XAEhrQBHD_FZg4rNelXCAw>
    <xmx:xy51YuCh4fYkP7XYx6tbrFPdMMmgvQmJM60zLk_srdnY_K8It89lnw>
    <xmx:xy51YrLI59BLrVCDhXvBxm75G0434b-8TPMGZac3Z--FL4HptRL4yQ>
    <xmx:xy51Yv62CsxN8Mr_7i4myACzXqrUQTz93JHLD43D11YVq4i1RgeFow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 May 2022 10:20:54 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v3 3/3] fetch2: Clear try_premirror
Date: Fri,  6 May 2022 16:17:37 +0200
Message-Id: <20220506141733.3298-3-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506141733.3298-1-pavel@zhukoff.net>
References: <20220506141733.3298-1-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 May 2022 14:20:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13676

This is non-functional change and aim to improve readability of the
function.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/git.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index e556f297..b17703d8 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -338,11 +338,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
-            return True
-        if os.path.exists(ud.clonedir):
-            return False
-        return True
+        return bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")) or not os.path.exists(ud.clonedir)
 
     def download(self, ud, d):
         """Fetch url"""
-- 
2.35.1


