Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D66C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:57 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web09.11837.1645288857015871391
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=bcOX3qwS;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id 778F12B000F4;
	Sat, 19 Feb 2022 11:40:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Feb 2022 11:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mIGxiw
	J8Z6UVZx6qTXyWNT+4Dbr+5CxO5w6+MdH3D2Q=; b=bcOX3qwSIdQ294zvV69bRg
	sutzKeXgwXPgWDH8b2TLZtdBuR3fKNQwSxskUihezYd8BOruCCcrvGYESHkndSO7
	2iXyy1tKOECje8cE2Rk1U8vBBhb6qQaqAcUyJSclvMZ2OX2JxEDL5FLQhr9NliUw
	YYnjQxVmTIX5Ffj9mN5EJ6glMrhsk/gKgNHMBjJZNA7dpgYzlGbnWiiDv/x+lbWt
	wO3CWpu/cM0kRLwcdZ+rw19sDVAEzDFqZANjNCBZnYdkDH80hWy7gfGRpqZzfZg2
	vyURYrn4gy8ElhFMyxb01fUJzCzFcpqQjqe/VZFD+Y4raLwUoDba0VEvJrXgL1cQ
	==
X-ME-Sender: <xms:lx0RYlr2UF-O3FBT-mKjiuylzNfJwdZ8hPDGKDKDiB2hDBSKk0cy8w>
    <xme:lx0RYnrcu8HSzEgdezhrHTzlfMgHdF3O_ccdVAjFeG37y5gcG6MubR3dzExbL-O3B
    mhQCTJ69e591Fh-sQ>
X-ME-Received: 
 <xmr:lx0RYiPU6kju0ek10TsXQ_ZpjlnM8sCh-yoiP-2xXtC_ymSYTy9ylbcIBbHbAKV_iaGqT_FK-UhJbVsKbrldSdoMrMqsmgKNH7If09rP_xMcVrNXR4wnJPHH1hQcBQE>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpeeiie
    eukeevuedvjedtgfdvvedvtdfgleejleejvedvlefhffefteeludetfeelleenucffohhm
    rghinheprhgvmhhovhgvtghonhhnvggtthhiohhnhhdrhhhoshhtnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiiihghhmuhhnthdrkhhrhihn
    ihgtkhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:lx0RYg4xuzUanCRCeZBH8CExqmchFW7aPTYIu1iJnwGFz4AEN3wCzQ>
    <xmx:lx0RYk478qfkDsOKDsNMHnQ5WovLF4sSM3YI9hRa_ed7pCxztv77Sw>
    <xmx:lx0RYojwOfTNDw8MpWB_-qQ56SU3THWRyE8UJNiiMf76JjyfOYVwBQ>
    <xmx:mB0RYpVkjbqFcD30KHSPFmsI5jhosF_oyTIq_eMHzsm2sEgZ588Z5eqOHlY>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:55 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 17/17] wget: Fix grammar "can happen"
Date: Sat, 19 Feb 2022 17:40:21 +0100
Message-Id: <20220219164021.8344-17-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13384

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 253cabce..767ee405 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -228,7 +228,7 @@ class Wget(FetchMethod):
                         # We let the request fail and expect it to be
                         # tried once more ("try_again" in check_status()),
                         # with the dead connection removed from the cache.
-                        # If it still fails, we give up, which can happend for bad
+                        # If it still fails, we give up, which can happen for bad
                         # HTTP proxy settings.
                         fetch.connection_cache.remove_connection(h.host, h.port)
                     raise urllib.error.URLError(err)
-- 
2.25.1


