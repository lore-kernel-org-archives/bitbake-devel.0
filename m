Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B817C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 07:28:22 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
 by mx.groups.io with SMTP id smtpd.web11.10308.1674026898893564173
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jan 2023 23:28:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm3 header.b=EICg9oSw;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.25, mailfrom: pavel@zhukoff.net)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C4BD73200920;
	Wed, 18 Jan 2023 02:28:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Jan 2023 02:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1674026895; x=1674113295; bh=ZiQu+bcKPnYa21Bi6Fuk5JevL
	wrEqTH8e4z9wKEuMBk=; b=EICg9oSwkz8eFtX2pBevwGXmDQ/1ERvdksESUN7FX
	EL6784Zioc3+7GBZyww8OBJg0T6ZjQ7SHYg1Rqj6+RMtILj+wxybq8/seFR9B4sj
	IfjTfMc0OJ2oAqRJDfsjGLn0DRS7Pr8To/1gDgCdPyscNRK4ScQoBNFdA15b0Mzq
	M0C2NrDdwmhMHa3omTb5kxR2hJYcf45UbYs7BwVFGDeq2RmMw5RFVZUKV9I2SZTR
	xGgV8ulJbp44dtD0BtqJOeukD4/GyfbutzA9VS54AjBmHGOOzJtiI2lJhazQ6k/0
	iMAABSnG896NrWx+Um846pyev0e39Qi30vUfDgSnIdBkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1674026895; x=1674113295; bh=ZiQu+bcKPnYa21Bi6Fuk5JevLwrEqTH8e4z
	9wKEuMBk=; b=osYy8SzmRPc1hCFWEvgdVUeqAGpmPPCd7bMphKmBRkqP5Bh6fPA
	X/sPSiXhCh4V7GNsIfyp7iyUL7klehH3K8p0N3bpFBf3A8t9pEVyH4OgyDe/kXcP
	BGySknEmTQa+sgEHtcGu1g6BFFKt2wvlNWERgn5JDysOMeNZ5XIVY35OZWlpy+IX
	yuIE05bSKMPkeoAqpZRHqWU3AXENqPA1H3hCibjhbIUw1j18CdrxdABORGvPkxqy
	6yFckKVcV1GngtyCliybMonVjUQdxbewmmottvd+BhZsaK5S1ESA4t6TcGzMfU8l
	gjfjumJ41gEmE7/3+UI73H57ePJt0NidfPw==
X-ME-Sender: <xms:j5_HYwS2_6K3ebMBU3LbCFkGicHvzSoIf8qIDP5zCdEy9OBnnqjemg>
    <xme:j5_HY9wzDrAhTqH284Rxqav_yMKXhDQsLfEQ0A1TUWbTcr4vWXLBqWTYwaCGcJaYO
    dv9Q4Ex733LsgM5D20>
X-ME-Received: <xmr:j5_HY90U1EaxhmCusWrSC3yzCCoILzEeEXojn71XqljFK3LrQT2ye0Ev43sQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhk
    ohhffhdrnhgvtheqnecuggftrfgrthhtvghrnhepveefjeekjedugeeltdekjefhtedtfe
    ejueffheeikedvudfgtdffffelvddvfefhnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphgrvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:j5_HY0DcqtmRb10rya4Spe6NvmKX8ozUhwlW02c7PVeCgB1IRvnkhQ>
    <xmx:j5_HY5gL5fbfm1tImiThUDIyBfCGa1DkazZNUCY66oPvbGkfXqcz4A>
    <xmx:j5_HYwoc9-jviPq_A-2J4x0iOIcKCmmEKkIxKt0bsGhqshCIH3uRcQ>
    <xmx:j5_HY5IQikmUas6El6mR1Tl-3K1P2s6loGDcOMUFHbuo0VmFLBhtlQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jan 2023 02:28:14 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH] fetch2/tests: Add parameter to recipe_uri
Date: Wed, 18 Jan 2023 08:28:08 +0100
Message-Id: <20230118072808.5895-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jan 2023 07:28:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14321

While the parameter is not required it allows testing of possible
regression in fetcher code when parameter specified and mirrors are
used.

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index ad3d4dea..4a10b16f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2852,7 +2852,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         os.mkdir(self.mirrordir)
         self.reponame = "bitbake"
         self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
-        self.recipe_url = "git://git.fake.repo/bitbake"
+        self.recipe_url = "git://git.fake.repo/bitbake;branch=master"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
-- 
2.39.0


