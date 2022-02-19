Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B95C433EF
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:33 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web12.11863.1645288832529870570
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=XMFdK7A7;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id C93872B000F4;
	Sat, 19 Feb 2022 11:40:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Feb 2022 11:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3pRgnt
	cxk4GObuWGcak4iQJwx+n7mF+9d0tNp0NiHmg=; b=XMFdK7A79ROLrWHRt1Baty
	fCDqEGSRF8H/oUsm2ffeGNKL+9TpyGhRYOxrhl5AwfqfPJBHe2dadOujle/PbsE+
	rnxZ61+DXDcl3DC+mk+73qnquyps6+32KZpn/hMxrHrWxzkGnn8YscbsW+wtbjT1
	cLBXYMt54RhyRzHsZ8OBc398P3Ayt+GxqXBTKJ7kZgl8kv0TCGxOJjetEIDVSr/I
	B5CCrSqnTHiw2rUQAQuVgQqWvCRJ+bUQf8RLmSFYF2RPEl6f74bhIs0hAJ4anF+u
	lGZ8wZxe1UQjnOU4KmRjlQncTVizWi1AksHZTP0OhME9DTEo+bn3zMVQ8o5VhO2Q
	==
X-ME-Sender: <xms:fx0RYl4aGxbr-LZQHLR7Z1fQDioXr5NZbTN12lTMfJ09XJmZ94PBKg>
    <xme:fx0RYi7K2N0ASaU0VUjvNbq4bw8-uIPOtrLczSsY_WZr04Z8bBFDPy8MOk04c0T1Z
    oRA8ETePu2-1W1O8A>
X-ME-Received: 
 <xmr:fx0RYsfBu3hqBXbSvdqKlN3so7ImB4mPNdO8kU52ls3CxQYzSbmerW1HiHqcHqyPbx5NFE-gIftiECK3s6WlCnC6qruoPHjaRa9hdqsDeyLPZOedGILf5ENVBDqu5_k>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:fx0RYuK3YZI_DiGrcDOqAf8lFDwR8ZTJG3-z9HgOCyVkrBVihcU1qQ>
    <xmx:fx0RYpIbbNu7blNlQxAMT2awRN26tWkgNcQ8OcPyf5C8wgTDPQi3uw>
    <xmx:fx0RYnyFSxVX7yYthMLkMR-Q5LpluDL2HqVHQqguW8b8nODu-p4GrQ>
    <xmx:fx0RYsnU7ngP9nyXhOQ-lFLGnmgFXziHTC1P3nBM6hM30LeZt9xoLMEJjwc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:30 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 04/17] daemonize: Fix typo "separate"
Date: Sat, 19 Feb 2022 17:40:08 +0100
Message-Id: <20220219164021.8344-4-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13371

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/daemonize.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index 40fabd0c..4957bfd4 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -82,7 +82,7 @@ def createDaemon(function, logfile):
             sys.stdout = so
 
         # Have stdout and stderr be the same so log output matches chronologically
-        # and there aren't two seperate buffers
+        # and there aren't two separate buffers
         sys.stderr = sys.stdout
 
         try:
-- 
2.25.1


