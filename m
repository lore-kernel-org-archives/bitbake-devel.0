Return-Path: <zygmunt.krynicki@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5013CC433F5
	for <webhook@archiver.kernel.org>; Sat, 19 Feb 2022 20:20:24 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web10.14306.1645302022282141067
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Feb 2022 12:20:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BuwhIU83;
 spf=fail (domain: huawei.com, ip: 66.111.4.224,
 mailfrom: zygmunt.krynicki@huawei.com)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 494AB58055F;
	Sat, 19 Feb 2022 15:20:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 19 Feb 2022 15:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; bh=P8GzF0w6o87FX4YM08H6N4bwpBjtg
	fT1TmsQ/1Xt5oM=; b=BuwhIU838dCs+AADoCobkzGW3m33xAxSRD9fbAN86fJ3X
	3xw7cZmfpznWlPbZncz47/Yht9IhCt7LHwyeUKf0K9nfnR9AxDGuJGs6Isr+HQFj
	/aPpZ1yz2FY0I9IDEn0sevpn3rGiVRobFl6iP2jK5wx6ZvIFHzpdhQ7yeQ+YWmZd
	+o+A5uRH2JK60k1Xl+FrfmseNZZHa0WZkEvQtHGlKzGW0yV3GydjEY6QklGB1j9a
	43QCNG5A7myrALnLTMfxhtzpECt6HhRN3e6ag46kvJgvhdDD8+7gV5FZWnxXOAQ7
	rBQ08cbXZidGRfPOkyX5rPcfGvW/UmB9ONtXAdetA==
X-ME-Sender: <xms:BFERYljlgMqq14aKG6q-n85bhzJ_-8nQ781W4hbjBwhJZCa-jZJ9Ww>
    <xme:BFERYqDSBAxBUqm-FJFeFmu3nzc5mCZXQ243in4_RZHCF6TO15KBtQq8ClVU9bZEJ
    pdeObG-xax9jfotkg>
X-ME-Received: 
 <xmr:BFERYlHGKVZVs2tVgbeixbW9bhQHPx5d1Z9YTxDhQCA1Sc-V5hccO3KnG0t9TiGoYwRdlYiGWTY2VO-sUBPOZJGgfFFaNrgWmsLdw-sCZBxgSTOQtc9qYOcVhGgQo2Q>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrkedvgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepkgihghhmuhhnthcumfhrhihnihgtkhhiuceoiiihghhmuhhnthdr
    khhrhihnihgtkhhisehhuhgrfigvihdrtghomheqnecuggftrfgrthhtvghrnhepiedvhf
    eltdeileeiffeugfehkedvfeffieehvdejtefhlefhffdtheevkeehveehnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiiihghhmuhhnthdrkh
    hrhihnihgtkhhisehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:BFERYqSihY1d4Jn4G6G5net2dJ7vPMLBELUEzCE76UFhHSe8-PHZOg>
    <xmx:BFERYixcebUNWxrB6V-JQ-qf4hrEmLBo5-Iqsej8e_zV9hSXZQ-xlw>
    <xmx:BFERYg5j8u4CMnLXw_WFTX7lSauO4GzXEtv-bv8W3-TZoOdN0D_uwA>
    <xmx:BVERYnu5VMxu7fNDXLuc42Esh7u4jlpTQv_0cDXINihr8ksUjZERXA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Feb 2022 15:20:19 -0500 (EST)
From: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
Subject: [PATCH 1/3] simplediff: Remove redundant parentheses
Date: Sat, 19 Feb 2022 21:19:55 +0100
Message-Id: <20220219201957.8329-1-zygmunt.krynicki@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Feb 2022 20:20:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13389

Signed-off-by: Zygmunt Krynicki <zygmunt.krynicki@huawei.com>
---
 lib/simplediff/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/simplediff/__init__.py b/lib/simplediff/__init__.py
index 57ee3c5c..11eb7e70 100644
--- a/lib/simplediff/__init__.py
+++ b/lib/simplediff/__init__.py
@@ -90,7 +90,7 @@ def diff(old, new):
             # now we are considering all values of iold such that
             # `old[iold] == new[inew]`.
             _overlap[iold] = (iold and overlap.get(iold - 1, 0)) + 1
-            if(_overlap[iold] > sub_length):
+            if _overlap[iold] > sub_length:
                 # this is the largest substring seen so far, so store its
                 # indices
                 sub_length = _overlap[iold]
-- 
2.25.1


