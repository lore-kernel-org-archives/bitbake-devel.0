Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA1C47DA9
	for <webhook@archiver.kernel.org>; Sat, 27 Jan 2024 12:16:42 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
 by mx.groups.io with SMTP id smtpd.web10.14411.1706357794589289269
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 27 Jan 2024 04:16:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm3 header.b=Z5RNwilT;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=e2PJjxe3;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.20, mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E8CB0320090C;
	Sat, 27 Jan 2024 07:16:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 27 Jan 2024 07:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706357793; x=
	1706444193; bh=Va9CkoZu+ssdsSNhGBx3qWjuE/dlPu0kOaJR3wGE9F0=; b=Z
	5RNwilTwfuVzfU9+kxJiPM/JAkz0jYh8S+duJTdTcS2GbzE+3CQdJDJSZCSdmD6e
	RSfnfrUkUFzRDCK0YydjPT0ISOYEwnvO8JKFolFoQ/kmXtv8bdt+QIC1MpKOh2YY
	4IWVs7cPr1haHALxDt276fURXALGZJ4ctS+TrXY8C4feLUfPS5vD/Jn7NOkemtXU
	N2Ilmg17KH+Txte9fLgeZlOYxwnEeA6eGDose0srC20egfTC8dsqggUCTzkY5LZ4
	69wBgW2+6Oc9fdYRR4nAWvwCic2dHEq1KSgAScpYKZZAfNUy3kwJmiiGKvF5E+Zp
	i5Fx/kZN2s0vuvIKtdoBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706357793; x=
	1706444193; bh=Va9CkoZu+ssdsSNhGBx3qWjuE/dlPu0kOaJR3wGE9F0=; b=e
	2PJjxe3q8o4K8HxIz7LxL6hVC77Uh1634ju2hUHCi1oTd6ni/aP4ubxSju0WY/8u
	5jXPBay53qLO7uHwTgiY65FzVYyi5Tuj1QLh/ISD1xrnF22e64HsGhdnrAm7vZC2
	F1dT3a89MITNiWKstV8Gcf9q/jc9x6dGILklAD+tzQb+ffZGJLUyIZ7SrK1mV00U
	ILAnDA1o4bpi9VfLKztdp+yJkAvUTzYeAz8Fow4j1ue0kLkxgr2Q5t9R4oXfOpZU
	Pyk0lNg9LJwqN3JBhizCdsCJiQtKN1o/A4iGhNc66kn8ZpMCkUSIEirmwNQ3Paz5
	dNFeeGCj1xZydfBZhBzLA==
X-ME-Sender: <xms:IfS0ZftEgL_qBkd8KsjkwdjGLnmvY-18hmc8tVELhg3yCZD3TMt--g>
    <xme:IfS0ZQf98FBLfamJZ3Of5OTPsF8URYY3WiR8lNPl2o9yikSGjSnYO47LybkWm3Efy
    qWF_d2QmXSP80yckQI>
X-ME-Received: <xmr:IfS0ZSxexEV7xL-5aPfuWKh_UWxX1Sh81o3hKps5416fxZw7HYKvR7F_RsU9gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefrrghvvghlucgkhhhukhhovhcuoehprghvvghlseiihhhu
    khhofhhfrdhnvghtqeenucggtffrrghtthgvrhhnpeegieevvdeiieekheekfeeigfdtue
    ejffeugedutdeutdetffdvgfetledtleekveenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:IfS0ZeMMq15YRIGjhPOOJaGEiGdUUWnCFI84nVfT1aqRQH1ExZmyig>
    <xmx:IfS0Zf8y8PMiYOao-t3-rXryKNJAldTja6uI4Q_jmBVa7kyMN5Q8dw>
    <xmx:IfS0ZeVsEVGI5e23UlUQAF0T2He-NRL9ELbAjR_mmaZTtjfcWekz2A>
    <xmx:IfS0ZcGUdg08OE9cKI2Lf2gqYLcDmxXsW1FFa_YgYNlQSXIBbZWAHg>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jan 2024 07:16:32 -0500 (EST)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH 2/2] tests/fetch.py: add multiple fetches test
Date: Sat, 27 Jan 2024 13:15:37 +0100
Message-ID: <20240127121536.2849664-3-pavel@zhukoff.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240127121536.2849664-2-pavel@zhukoff.net>
References: <20240127121536.2849664-2-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 27 Jan 2024 12:16:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15801

Fetch from premirror few times to emulate multiple machines sharing same
clonedir or few rebuilds of the package from (pre)mirror
Regression test for [Yocto #15369]

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/tests/fetch.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index c7a23407c1..a4fb18957d 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -3082,6 +3082,24 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         self.git("checkout {}".format(head), self.gitdir)
         return newrev
 
+    def test_mirror_multiple_fetches(self):
+        self.make_git_repo()
+        self.d.setVar("SRCREV", self.git_new_commit())
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        ## New commit in premirror. it's not in the download_dir
+        self.d.setVar("SRCREV", self.git_new_commit())
+        fetcher2 = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher2.download()
+        fetcher2.unpack(self.unpackdir)
+        ## New commit in premirror. it's not in the download_dir
+        self.d.setVar("SRCREV", self.git_new_commit())
+        fetcher3 = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher3.download()
+        fetcher3.unpack(self.unpackdir)
+
+
     def test_mirror_commit_nonexistent(self):
         self.make_git_repo()
         self.d.setVar("SRCREV", "0"*40)
-- 
2.43.0


