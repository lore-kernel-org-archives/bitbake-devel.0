Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7111CC433EF
	for <webhook@archiver.kernel.org>; Fri,  6 May 2022 14:20:58 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by mx.groups.io with SMTP id smtpd.web09.10062.1651846850404520328
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 May 2022 07:20:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=H6uv/k7k;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.27, mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id A7D2A5C004A;
	Fri,  6 May 2022 10:20:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 06 May 2022 10:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1651846849; x=1651933249; bh=pu
	LgoYcXLmybXRFPBpVfVoVLjrjRSgu00CEseamKQQw=; b=H6uv/k7kgRhe01aX7O
	IGTzN666DVsdXQ8IL8kPGe2Zqy07W9hmS2u6ZkIoibzF3Oe1QmwkKeR33b4T4i26
	bk4GHtG9HkeiCu8/sJ8xpxbrF1xYbvbyLq6L1vXLw5DSpVliWOG887LXlZx4Y7YF
	fkke56Q3Dty8TRf1VkTFqEn8RtcLRXzGuOg89mh1Bvd4fcAsFjDNJ8n5JRUnCqfW
	/uJuyBb/LGmO6jqQ6mHKsUxD/Vh0dyEUCN1xw/1uHSvKHEcFtzi5aWh0E+GYbqtP
	gkvVNGEYKCozt3VVZUVTDBkelkTmJh42+6pWdOZwya+oC9809dNP0r4Hm0mCB7Uz
	HdEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1651846849; x=1651933249; bh=puLgoYcXLmybXRFPBpVfVoVLjrjRSgu00CE
	seamKQQw=; b=Y8IjOgGifiKnXrZViyv889UlmOUticE7+uuG1u+vknQBM9CjDOX
	9ZY5U8fiUfLjyvBsPTrO5FPehceUin0DS5y6tHYRtaiE7lbz3TDazHrBaOAhbXMg
	BH8wb2xFYS4RRqH2+CIpKRX+VkDWzIxgtV6M8YRSMXYM+GuseSRcRIL7onan2hoG
	TaozFW2cpA7DIupshgSAvUUvjcljvaye8l9vQNFv+gs4+dIkGCx9Jv20VsrbICkg
	w/dytlJf/RWyF8UdZeekeYQa9jX0iXZ0565KDjNDuOVW10/zAQOtpUehwrrVTGhf
	RNP8OhlyHZ4esrcj/TMC0lrJPlft9TSbfLg==
X-ME-Sender: <xms:wS51YvzqQbAfvh67mWAx3CaQGmk9WqQzU78ibHZSXqqKK9WtvvClKA>
    <xme:wS51YnSRdbV1m13qSWXY4XIIEASGy4fwj7gqFOvVkBAOfLvDiQ1ErAQqZ_IFiGebH
    v6n0oQxMXXkImwWkfk>
X-ME-Received: 
 <xmr:wS51YpV-DYoEWANRNtwFZBkaHwxqS_xT-E5g6LLWSx2VFgZxAipxSRLb3texvqZATya733U8vVe49GwJuAeHpoM>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhk
    ohhffhdrnhgvtheqnecuggftrfgrthhtvghrnhepuddvgfeiieevvedtgeefudethfekge
    euieduheegffeiiedvuddugfefjeejffefnecuffhomhgrihhnpehprhhotggvshhsrdhr
    uhhnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    grvhgvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:wS51YpgvuBNJXV6Kcb4jjR5FyS0MIXs3hIV5xYcuqQFoHtKfHnIPog>
    <xmx:wS51YhCYkswdtacDBxOYJyZb5KMitT_BnmDltox0KCARz7mRqFPVew>
    <xmx:wS51YiK7r17Gzb-NKwheZNghu6WhcSC0T0MoGzequ6X5SK5EY8Fm8g>
    <xmx:wS51Yu6VnFTN1uwaacY3ZY1osKBO3yMbpzaswlEXHKYY8Ho2nBuzqA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 May 2022 10:20:48 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: pavel@zhukoff.net,
	Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v3 2/3] Add tests to cover BB_FETCH_PREMIRRORONLY
 functionality
Date: Fri,  6 May 2022 16:17:35 +0200
Message-Id: <20220506141733.3298-2-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506141733.3298-1-pavel@zhukoff.net>
References: <20220506141733.3298-1-pavel@zhukoff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 May 2022 14:20:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13675

Basic test to cover functionality of BB_FETCH_PREMIRRORONLY using
local git repository. Local repository has been chosen to allow easy
manipulation with the repo to simulate behaviour reported in
[Yocto 13233]

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/tests/fetch.py | 63 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1152e89c..0b1dc847 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2802,3 +2802,66 @@ class GitSharedTest(FetcherTest):
         fetcher.unpack(self.unpackdir)
         alt = os.path.join(self.unpackdir, 'git/.git/objects/info/alternates')
         self.assertFalse(os.path.exists(alt))
+
+
+class FetchPremirroronlyLocalTest(FetcherTest):
+
+    def git(self, cmd, cwd=None):
+        if isinstance(cmd, str):
+            cmd = 'git ' + cmd
+        else:
+            cmd = ['git'] + cmd
+        if cwd is None:
+            cwd = self.gitdir
+        return bb.process.run(cmd, cwd=cwd)[0]
+
+    def setUp(self):
+        super(FetchPremirroronlyLocalTest, self).setUp()
+        self.mirrordir = os.path.join(self.tempdir, "mirrors")
+        os.mkdir(self.mirrordir)
+        self.reponame = "bitbake"
+        self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
+        self.recipe_url = "git://git.fake.repo/bitbake"
+        self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
+        self.d.setVar("BB_NO_NETWORK", "1")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
+
+    def make_git_repo(self):
+        self.mirrorname = "git2_git.fake.repo.bitbake.tar.gz"
+        recipeurl = "git:/git.fake.repo/bitbake"
+        os.makedirs(self.gitdir)
+        self.git("init", self.gitdir)
+        for i in range(0):
+            self.git_new_commit()
+        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+
+    def git_new_commit(self):
+        import random
+        testfilename = "bibake-fetch.test"
+        os.unlink(os.path.join(self.mirrordir, self.mirrorname))
+        with open(os.path.join(self.gitdir, testfilename), "w") as testfile:
+            testfile.write("Useless random data {}".format(random.random()))
+        self.git("add {}".format(testfilename), self.gitdir)
+        self.git("commit -a -m \"This random commit {}. I'm useless.\"".format(random.random()), self.gitdir)
+        bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
+        return self.git("rev-parse HEAD", self.gitdir).strip()
+
+    def test_mirror_commit_nonexistent(self):
+        self.make_git_repo()
+        self.d.setVar("SRCREV", "0"*40)
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
+
+    def test_mirror_commit_exists(self):
+        self.make_git_repo()
+        self.d.setVar("SRCREV", self.git_new_commit())
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+
+    def test_mirror_tarball_nonexistent(self):
+        self.d.setVar("SRCREV", "0"*40)
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        with self.assertRaises(bb.fetch2.FetchError):
+            fetcher.download()
-- 
2.35.1


