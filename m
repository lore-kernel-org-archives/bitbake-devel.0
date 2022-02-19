Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB5C433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 16:40:35 +0000 (UTC)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 by mx.groups.io with SMTP id smtpd.web09.11828.1645288834593000879
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 08:40:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=lAn2l1eg;
 spf=fail (domain: huawei.com, ip: 64.147.123.26,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id 0B2872B000F5;
	Sat, 19 Feb 2022 11:40:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 19 Feb 2022 11:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3lN7OW
	r5ZhdI82WbG+/ZvKF7DsCPhnm4zDbRCjDTC4g=; b=lAn2l1egHIeGSugkSeLdwo
	41m8gMaj2kJ28yIqTi/IDwh1uNA7Ge4DXsvLbWAt/jXBcqIel8bsQtt/Ti6RZqzv
	q8VdURFtDjR/kalwPCbkCeA4qjPVErZMdrIROCMThzYDGkerFnwFw09KfvVnn1ag
	nGf6KFs5QUDK+GAAO6W0rUvrPP/rOAahAeYHoanx7CXww4YI5xRMLphjM7/Z0VJt
	W2KMnjoB8e8SaW6oC1Aaq3V+X8y9AYfB6N3hZ8h7Fz/xt6VeouT6tcG9997R/SoV
	1yz6w+OuZiKFTKVrkJjKkDTB1Vqow6I27I5R6GY0MMRIDDiz3P02X4PC+7eHfJXw
	==
X-ME-Sender: <xms:gR0RYsS4XPZS4WBB2zJWwPmRKt2i7sXCqzbEKpKMqEix7eF7Pf5g5w>
    <xme:gR0RYpzfIMhsZ0FWcMU2CI7O-GbrhRibgJduwJSrmlmkm2sfoL4lgpLsbZLxGanMU
    0Qe6bIpsT8rnX2v-w>
X-ME-Received: 
 <xmr:gR0RYp21FSJJaZuMd_yupBZH89dBb1c9HGND79tVUY3fEltXmURkpmgIUI5tsIRk4sSNEoDxGTyVWAI6yCSHDUarl5_ICFOh_Y87JnmuI-zaePuSOF9CT7n0VZNMfXU>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpegkhihgmhhunhhtucfmrhihnhhitghkihcuoeiihihgmhhunhht
    rdhkrhihnhhitghkiheshhhurgifvghirdgtohhmqeenucggtffrrghtthgvrhhnpefgff
    fgjefffeeifeefheetvdduhfekueetgeeijedvheelhffhhffgleehfeeuheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiihihgmhhunhhtrd
    hkrhihnhhitghkiheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:gR0RYgDOCNzSQ5y-Ekj6ssFf2SCHuWIOSAU4O6klOGF7VpO9Y3LjfA>
    <xmx:gR0RYlh6F720dhdopO9C1vTdOuFPGbgvTMEIQS45r6Z5yoeYIMHj1Q>
    <xmx:gR0RYsrD8DS9u0MUnhC25Fr3Q9KvlOYfLX1Mj20Rgc8MUC6jmD6OzQ>
    <xmx:gR0RYvfpbtyV3uTokiPxFstN0w8UIGq9fNBfQRBsHwwO3kndm_aDeZFNkW4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 11:40:32 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 05/17] event: Fix typo "asynchronous"
Date: Sat, 19 Feb 2022 17:40:09 +0100
Message-Id: <20220219164021.8344-5-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
References: <20220219164021.8344-1-zygmunt.krynicki@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 16:40:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13372

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 0454c753..c81e79f7 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -764,7 +764,7 @@ class LogHandler(logging.Handler):
 class MetadataEvent(Event):
     """
     Generic event that target for OE-Core classes
-    to report information during asynchrous execution
+    to report information during asynchronous execution
     """
     def __init__(self, eventtype, eventdata):
         Event.__init__(self)
-- 
2.25.1


