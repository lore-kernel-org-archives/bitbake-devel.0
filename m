Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF3C4332F
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 18:41:41 +0000 (UTC)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 by mx.groups.io with SMTP id smtpd.web12.197.1649263729915945208
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Apr 2022 09:48:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm1 header.b=YVgj0wt8;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.230, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 18BFC580402;
	Wed,  6 Apr 2022 12:48:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 06 Apr 2022 12:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; bh=A44wTUqAaF55lWeM8tQ7zqGhpL4e2/h7npKHEla1WwE=; b=YVgj0
	wt8lLYRNlszVwLOpr2argoEYDljdgROVMncngpHKnW47YloWCCNBf/w3xPi9kMBT
	o53M2QSpxI8Zhj4SjvOw+hGOWK9blRAWn1c2lRkiD52Qt9z3W+vz8I4FpCNIBRlq
	ev+ePlaotdXTUrsmyBgNP+vPr68qAw2n53P7RhvqoHDDfvFjg/LYUQLffC2YF7BM
	hYCCbzToyoDkeFYjpkpb+5/VnBUYjcwJCIoWL2DIEHbCa0DsDsB4B63rnfWaAlrk
	63ADvm0BI0FvKviRrLQRdB9NKtZ8UazHlTRQWHLHTPAU3emhIRDMQJB9fagZBplG
	ZilyS2lAd0xSsR62A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; bh=A44wTUqAaF55lWeM8tQ7zqGhpL4e2
	/h7npKHEla1WwE=; b=CNV03T2hgDiyq77YG6W1DT5RNjuCsT7CQLOi2rwhvukmQ
	K2eZ6O6UeK1adIcakaXdWLOR0fNcm89NJyVutDg9nRd1Zq4ylIYfDtVtQO3pYcxA
	VOs1dmblhFtPvlfT21UY3cebm36X1FXYQN+OVYYHjU0DYM7z6SXtvw5VloAE9UE+
	DwP6c0ziH59DeMrSyOjSWnjnk/HpvmBu57ioNtYoocpyxm9MQ30JP45ooa11eSbe
	Agh8uo7OMaXOL8l7krz3//FYVwGFtcEbxTpj8LdFr/ebMt3EHHqCMuXauvD3Jn9S
	HK+aWZBzoHBeniel5X6M92ODsfBM2+2ZEs0u5b8Sg==
X-ME-Sender: <xms:cMRNYryB7YSIj9kRufOPDrcV543TnFlN2FEG5F7zJh2uLSMXkMmLeg>
    <xme:cMRNYjRB9eTMie3rgg0Pj9TSfOteIf6_DOhM19_hZcwFl-Kd8mcZh-cfGnn5N-xXD
    b52CJK0qwPUOIK3Dc0>
X-ME-Received: 
 <xmr:cMRNYlXTUQCSg_H5vci-dI47W0oK4KHRso5EQ4Erwp7kCQkOJm9CnVmHp8iw0LnRlCMXeQgTLkDWOTjldzy3FWc>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvvddrudejiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhukhho
    fhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeeguefhgeejjeetiedvfeektdehhfehue
    egleehteegudejudekveejffetjefhueenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:cMRNYljF9HOaNX8GH-XrWgReUqEbrx-Uwi9DHpMbxRowsTahinmreQ>
    <xmx:cMRNYtDa6MFapxXIPioRJENdSp_hK42cZ25qSmKgsJz94sCSiu8OCA>
    <xmx:cMRNYuKmYl3HGccuYU6iUCu0eTWdGCMJ9yVklFOq-mSqtaoXkJu7zg>
    <xmx:cMRNYq4jLkJtbpJG8Ag5-OmWledgbORY7ZAV41nnsME-dPolVv-ZRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 12:48:47 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] fetch2: Add GIT_SSH_COMMAND to the list of exports
Date: Wed,  6 Apr 2022 18:48:04 +0200
Message-Id: <20220406164803.18649-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Apr 2022 18:41:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13593

GIT_SSH_COMMAND is more convinient to use if arguments have to be passed
and the user doesn't want to create a wrapper script around ssh.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5dfe5ff3..ac557176 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -839,6 +839,7 @@ FETCH_EXPORT_VARS = ['HOME', 'PATH',
                      'ALL_PROXY', 'all_proxy',
                      'GIT_PROXY_COMMAND',
                      'GIT_SSH',
+                     'GIT_SSH_COMMAND',
                      'GIT_SSL_CAINFO',
                      'GIT_SMART_HTTP',
                      'SSH_AUTH_SOCK', 'SSH_AGENT_PID',
-- 
2.35.1


