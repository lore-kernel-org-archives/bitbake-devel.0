Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0837C43334
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 16:53:03 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web12.15806.1654793573296967472
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 09:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm2
 header.b=nLGCxFWe;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.29, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A7ACC5C0086;
	Thu,  9 Jun 2022 12:52:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Jun 2022 12:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1654793572; x=1654879972; bh=lGmeM2lqOPZi/IiK9u31uWM6i
	DO7lCV9qMel31TnXTM=; b=nLGCxFWeEiG0CgppaduK29Y+GlEuVY/beP9Dfj5m3
	Cw2kDhzQlbPQt0id5lEawClrVuwIymJKCXWqM1LYlv3wDAZfmZQmDZuWcgkkLsB+
	X1GuBCoA6L/x37NSUdyhQ4rIHRTDV17HSmRoUfyeEyihbn2LlT/fso41q2gZwXbl
	x/ayVaSmWe3JHcAW1L1n4YqUjM9bKrpuLIg4AkbAdQnNjVytBdxts+s2koT0iWTa
	MA6BVDy/+JHTVuo63amFSg7mF8VqwP2jqkghpzCudfxtZ6LkMJC1vw6eTq1GMbVL
	jDOApILBqdPvFaCH3R1b9lninKE4bjrYC3AGVAU97z4NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1654793572; x=1654879972; bh=lGmeM2lqOPZi/IiK9u31uWM6iDO7lCV9qMe
	l31TnXTM=; b=eKWv0f3srskpprmxV7hhNvs9pV18MdKzZz9xvTpFUSDde/Bqz/A
	s6TXlu3SY+cehmrE7+fl9l08qL4jJYwkFPXrIahxqRm7cAlxs4InjK3S/YsvXehp
	AW+xdG/ku7iJfciA56uGDqjzj27jR4xwKyOhPFv28GTiv+o3remTrKb68nRS5SCG
	Ekazcfwf+KSZYUclK/mAOtT6TxwmdeYNSAC97H1XSxFQnbg39ot93eThCRpRyCpq
	dkL82r7PC6GujbTGqIsh25XrhnMyLf5QU/kB7+t8rb1GtaG4N7BkwHr73NWwok75
	6yLVECeuqeUAavLNPbJVgn//gA836apux1A==
X-ME-Sender: <xms:ZCWiYlELOqUtaVZEm1W8rfcej4sZTkUWqjy7WTndLkzBfB3o6vj2IA>
    <xme:ZCWiYqWzg3SQd0Kj66nvNx8vLzZSiLPm02cl8RL3ol60NUuDwd-00nmvhIGSHwfLd
    NQIyyv5-TdgFnak4rI>
X-ME-Received: 
 <xmr:ZCWiYnIT9pgo0YP23GUhcHsQor38avElAShNRXHPpH6Piff6Ck0v4eztlaeftThAkpkI1R8A2T2SYq8rK3Tq5lY>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedruddtledguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhk
    ohhffhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfevueelgeefiedtkeeiuefhkefhtd
    efvdekvdegjeevjeffiedtgedtfefhfeetnecuffhomhgrihhnpehprhhotggvshhsrdhr
    uhhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    grvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:ZCWiYrEfOkQakmWS90Nk-h4yUo3gjZu7LWznNW2pkLAUGSTi4VM2eg>
    <xmx:ZCWiYrVIqDaWtRKB9FnVx-MsGeUDi033sn4UJv_KKNAMg-rulgKQng>
    <xmx:ZCWiYmMvvPTGKiFYkuLlwiSE4zyLPXnrXFHRgQc_tp99aba9K_VE9Q>
    <xmx:ZCWiYicQGYSfFEdlb5ylrMj3IpJpEkHflehgqdv-Rv-Lx5sqyh-gDg>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 12:52:49 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] tests/fetch: Drop unnecessary duplicated function
Date: Thu,  9 Jun 2022 18:52:27 +0200
Message-Id: <20220609165226.17460-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 16:53:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13748

Function "git" is defined in super class FetcherTest already.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/tests/fetch.py | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a09c414a..18e58572 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2806,15 +2806,6 @@ class GitSharedTest(FetcherTest):
 
 class FetchPremirroronlyLocalTest(FetcherTest):
 
-    def git(self, cmd, cwd=None):
-        if isinstance(cmd, str):
-            cmd = 'git ' + cmd
-        else:
-            cmd = ['git'] + cmd
-        if cwd is None:
-            cwd = self.gitdir
-        return bb.process.run(cmd, cwd=cwd)[0]
-
     def setUp(self):
         super(FetchPremirroronlyLocalTest, self).setUp()
         self.mirrordir = os.path.join(self.tempdir, "mirrors")
-- 
2.35.1


