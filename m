Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD3C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:43 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web11.11882.1645288842644304042
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=oNwDDL5B;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id E600C2B000F4;
	Sat, 19 Feb 2022 11:40:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 19 Feb 2022 11:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=et5E4g
	lqSp42M+IKoV30RLR1xDg58gyj+LmfQPI4054=; b=oNwDDL5Br94+lGLBYGsvZh
	iPn59g5+sE+G56kxFTP6j6RxYWGPrrDZqYYhywcUZGf0nu6vJlqcRHCrNiq7Mdix
	2YUyqSVJXzoVMWFvPYb/CJCIyD00EOA3/fMl9Z7tEelAwEoTau2epVo5pX88wfF2
	K8YCx/lKhsIZS+nw9MnG/opll1cEEP/sEPalx+As3jftTJFAI0pqep5TlpMklKZr
	/KJmfoSd4U5tPRuk8S7QvV7sSfD7jHvfEJjMeyQhQm5f48UBQZW6OML0CJk9Llgj
	hb6nN6TmSUQEU/bx/T6tXLtXPhhU8VSga7W9kxPSMMBDfZcAtGTu+wOpBbuB8aGw
	==
X-ME-Sender: <xms:iR0RYmeied_0YHs86hkITtvi6TilqbsHOIqaR6m9u2-QERrBKMdiOA>
    <xme:iR0RYgPMnL8gimB-LewbHABIKfHg77c_tL0-rsVO_pySgmPHtO-dO7I5jLuJYIskG
    a56BBWl0Xsk9zxIHg>
X-ME-Received: 
 <xmr:iR0RYnjnMRk8NYDSgwZEpkEb-eEKqFQVHNytNGUPltBgq1li6QGJffe0gzlAtLUDOhThxjMFEPCDvGZDD8F22yO3kM-WxZjYv0GiXokVzb8GbtTismswVieXs68lkdc>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:iR0RYj_KuEeaLJ1qcqdsqdD3Ty8vkiGPtIwmt1Uv0IYCmExCSnWIfw>
    <xmx:iR0RYit7ut-y0UZWPyOJsNeIkgjOSkdGM5GMbrdRIGpIOO5k7gXroA>
    <xmx:iR0RYqGvmSMvDgCXbIlMw58MrUPamzb9rVUiVyLtCdCKXpkDCIql9A>
    <xmx:iR0RYj5cH99J6Z5W5-uGFrs2C8TYDd7qJDw1Z-H8RKMyEm1q2EjTh3jwv7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:40 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 09/17] git: Remove duplicate "the"
Date: Sat, 19 Feb 2022 17:40:13 +0100
Message-Id: <20220219164021.8344-9-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13376

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 836ef1c4..b3c5e6da 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -399,7 +399,7 @@ class Git(FetchMethod):
 
         if self._contains_lfs(ud, d, ud.clonedir) and self._need_lfs(ud):
             # Unpack temporary working copy, use it to run 'git checkout' to force pre-fetching
-            # of all LFS blobs needed at the the srcrev.
+            # of all LFS blobs needed at the srcrev.
             #
             # It would be nice to just do this inline here by running 'git-lfs fetch'
             # on the bare clonedir, but that operation requires a working copy on some
-- 
2.25.1


