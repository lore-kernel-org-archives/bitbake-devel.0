Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B2DCCA473
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 16:58:13 +0000 (UTC)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by mx.groups.io with SMTP id smtpd.web08.16192.1654793886600021572
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 09:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm2
 header.b=LM53cHp9;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.221, mailfrom: pavel@zhukoff.net)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 96D75580781;
	Thu,  9 Jun 2022 12:58:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 09 Jun 2022 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm2; t=1654793885; x=1654801085; bh=6S/SdnDgWLB8BGIbIjbLa3om1
	XsWy4rMb4IoKqFXdRU=; b=LM53cHp9ZlEJ1aNMbqQIos0YhQswa59Od9kzmSFO+
	D8Q42ylK+mIm02Fd4RJVFL/Lvf03UeGGqcbi/c4qXIGowHPHO+SwEjmfLRQGdiVP
	D3NxWJ3+8zcVfgujPFWUhgLCHuiNRYcmSAVdANlDGr9fTEZvV/pCOWGvcOiCSPFO
	dvmr6MuB+BwpRL4VxhghZzqQjiBisc7GBs/ehyIWenJ9QcpSjYTlxPBwAw4OZwOc
	3evc+Y5VZpW7hY7tkIuglm910M4lwa0LfY3vnASs+No7ERYU9YwK71t6/Tr9Ktrk
	qpbNb3tILYr86NL/6+lpABQLpFcklAlQGGsgqAXfKYrLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1654793885; x=1654801085; bh=6S/SdnDgWLB8BGIbIjbLa3om1XsWy4rMb4I
	oKqFXdRU=; b=T31O969Mn+7Jdo++VPtWYYvgSe1DULohOItKJt8nwfcsgTR8fsJ
	VXXRWjZe+sZV+YpEdzvJ7f0qROtxUMBnq8sd/FisQEM0BGFrSRdSpQvU8thTJOYP
	G6RyZXsAuRnkvkaXpylm7tryt6lFQU7+K3iUhgDgQ8B9fSWJnbsRUcP/lG/ybEfk
	DCJxR0tpL+wublHWbLZTiPwen2/wEanRlJ2B2epUngtcB71vGwJw8WRKDfR08Uys
	qjmhEXroKwvrbjvCHmndeTFEt1x5H2fq0xMTkip4Qqe2tdGhrFlhIfxLgjClOZXL
	eXnegcDjwe0x1x49H9Vdum0ZYabL9NQZinA==
X-ME-Sender: <xms:nSaiYnuyU_XNua9vaeLtadJIo8s76I-acAyPf7m4MwO9B2io9aY3Ng>
    <xme:nSaiYoecVyJtjHCdzhzrW1ESAmJBOOvHtMEkHuqHWGPYFpaoKWYCoYihuUm5Im_aY
    lzcQ5-D6itkKOZ2Luw>
X-ME-Received: 
 <xmr:nSaiYqxHw6tTWF9WDO0F_4fvsBFX_4rmqECsjGo6j3oW8bHv3Xg9Ush3DdfoRCmwCe8XrwFMsSf-CAVYhfH50zA>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedruddtledguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogevohgrshhtrghlqdfhgeduvddqtddvucdlud
    ehtddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprfgr
    vhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrf
    grthhtvghrnhepfeffueelleegveeiheeijeeggfekffffieeigffhtefgueeghedtuddv
    gfetiedvnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdpphhrohgtvg
    hsshdrrhhunhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehprghvvghlseiihhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:nSaiYmN4_RPR6qJurfDES6pE5QAknOrjBS150Dr2TyrDEsmVIHHJIQ>
    <xmx:nSaiYn_4nE5YX4HL8uRa2nn51x_rvORM45Dogm9c_Mjti3I8X2pTag>
    <xmx:nSaiYmWEEjgYgCxN_I5Xg2kKvmK2RtlDUXYv38HYylb2sY69OECSbA>
    <xmx:nSaiYhkNGACWni7SMDWRRbKaG06EqjWHh0Qhx-wQHIlOAX4vUlnGuQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 12:58:04 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH] tests/fetch: Add ttests for premirror using real project
Date: Thu,  9 Jun 2022 18:57:04 +0200
Message-Id: <20220609165702.17622-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 16:58:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13749

Existing test uses fake local repo for better performance. Adding
test which uses real (but still small) project hosted on
yoctoproject.org.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/tests/fetch.py | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 18e58572..622c46a0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2856,3 +2856,42 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
+
+class FetchPremirroronlyNetworkTest(FetcherTest):
+
+    def setUp(self):
+        super(FetchPremirroronlyNetworkTest, self).setUp()
+        self.mirrordir = os.path.join(self.tempdir, "mirrors")
+        os.mkdir(self.mirrordir)
+        self.reponame = "fstests"
+        self.clonedir = os.path.join(self.tempdir, "git")
+        self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
+        self.recipe_url = "git://git.yoctoproject.org/fstests"
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "0")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
+
+    def make_git_repo(self):
+        import shutil
+        self.mirrorname = "git2_git.yoctoproject.org.fstests.tar.gz"
+        os.makedirs(self.clonedir)
+        self.git("clone --bare --shallow-since=\"01.01.2013\" {}".format(self.recipe_url), self.clonedir)
+        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+        shutil.rmtree(self.clonedir)
+
+    @skipIfNoNetwork()
+    def test_mirror_tarball_updated(self):
+        self.make_git_repo()
+        ## Upstream commit is in the mirror
+        self.d.setVar("SRCREV", "49d65d53c2bf558ae6e9185af0f3af7b79d255ec")
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+
+    @skipIfNoNetwork()
+    def test_mirror_tarball_outdated(self):
+        self.make_git_repo()
+        ## Upstream commit not in the mirror
+        self.d.setVar("SRCREV", "15413486df1f5a5b5af699b6f3ba5f0984e52a9f")
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
-- 
2.35.1


