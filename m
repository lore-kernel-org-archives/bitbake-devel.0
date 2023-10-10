Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1720CD6918
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 09:36:46 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
 by mx.groups.io with SMTP id smtpd.web10.87346.1696930598197446769
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 02:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm2 header.b=7FsHMHp/;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Fa6Ogcax;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.19, mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 39D3E3200C00;
	Tue, 10 Oct 2023 05:36:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 10 Oct 2023 05:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1696930596; x=1697016996; bh=+J/nzcMnqt
	qD+wfhkz0d569AgjcrrjixZWAjHb0GgQA=; b=7FsHMHp/gTWpceeNNwDqBSQr2C
	c8SlBvV6iKMQ9amRlfCQ0zgzBtRP1is8x4FELy5CCO8uw3Qtl9QJXaycaULiKlZ/
	6VVYuTW8NGqJ2a36cv5MyJcd0/bsAR7KZhrSBq8Utx9VIZ1GuxkU4v0bGGK8mU6Y
	BFwcZ4vbTKIvS/J7PQwovd/AH4VqvrBUtRw/FbEfDrjsBWzAThPhcF/k7Wubc7QW
	CA2lMg4RqbPdlrb00kXm+LxQWaqWVZXV6yNGVO5/X5oUbXI5MURa46+NVNUfU1xo
	mS76rdrDjc04PcGQ3UE7argM3zt5E9GRrKLv87w0/1FGD9F3ahCHUgmqn0HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696930596; x=1697016996; bh=+J/nzcMnqtqD+
	wfhkz0d569AgjcrrjixZWAjHb0GgQA=; b=Fa6OgcaxN3BHcVce2SnzXu4Ma43I3
	CFpgw/3EIYwogxKtx3pLAgjuoNLb0y5nhhQ3IoE+wwSuJIa3qoBxBNf9/y/A0L+V
	Lu+bG1nujp2/RuJ5BErDG/zPlAZ/w2B+SnSMLreWMxer4i8N6w4l+RuhSbE0eeFe
	62eeR5Te5CBpwq3Ter7hTY0O8UkICzBFBJ2c1OS2G1Qu7GVxQV9SjCQkH/q6URKm
	Qh7rrM+IMwkejwPZRtKdsXFwBDA5ZkgkfDukCy0vtFOgB2ONMKTAbtxKRyDLDyjb
	h3PvQof2sOh4Uzt9KfvqNJjXvN2kZr3rO69p2vzMTdK4si9lDfZHYjeLA==
X-ME-Sender: <xms:JBslZd26PgobPcT19lowCFXH-80jpA9v6Y3qs2T1MLy0DBRxWE7C-Q>
    <xme:JBslZUE6SuoJWokPOOq-iR6-dJTjFtqDFpnUquOO1ubEY5cOEp7f2zBHaMltu_yJE
    3ZH-3dF3t4r_Qkx7wY>
X-ME-Received: <xmr:JBslZd6LPXsLsjFC_ISkpbM0BRnuXfwXYYxig4mvzkWYyYjCiZfBor7VSK2uWZ2vUwl8-eb5R1Td>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhf
    fhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfevueelgeefiedtkeeiuefhkefhtdefvd
    ekvdegjeevjeffiedtgedtfefhfeetnecuffhomhgrihhnpehprhhotggvshhsrdhruhhn
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgrvh
    gvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:JBslZa1taX4tNfddzYeV618WIYT2sCcfBsUjuPedKr6N4wNLf_nbeg>
    <xmx:JBslZQHlLOmk9GGUxiPvvB9uwzOifNGt0M7FRdA5Fkmy6TkgUj2eYQ>
    <xmx:JBslZb8DrxnGvDGyo95TsEao8jy19kf8XFOGAfgK2kixNFss4tQfSQ>
    <xmx:JBslZbMGMV6N1lg5Harn-6-uYbiy09PuQxSjvWAkzDT7NKRYrOpMVQ>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 05:36:35 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH] tests/fetch.py: Add tests to cover multiple branch/name parameters
Date: Tue, 10 Oct 2023 11:36:32 +0200
Message-ID: <20231010093631.39912-2-pavel@zhukoff.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 09:36:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15201

Create repository with few branches and test if fetcher can work
with such repository as PREMIRROR

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/tests/fetch.py | 71 ++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index eeb7a31471..5ba71265ae 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -3042,9 +3042,11 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
+        self.mirrorname = "git2_git.fake.repo.bitbake.tar.gz"
+        self.mirrorfile = os.path.join(self.mirrordir, self.mirrorname)
+        self.testfilename = "bitbake-fetch.test"
 
     def make_git_repo(self):
-        self.mirrorname = "git2_git.fake.repo.bitbake.tar.gz"
         recipeurl = "git:/git.fake.repo/bitbake"
         os.makedirs(self.gitdir)
         self.git_init(cwd=self.gitdir)
@@ -3054,15 +3056,23 @@ class FetchPremirroronlyLocalTest(FetcherTest):
 
     def git_new_commit(self):
         import random
-        testfilename = "bibake-fetch.test"
         os.unlink(os.path.join(self.mirrordir, self.mirrorname))
-        with open(os.path.join(self.gitdir, testfilename), "w") as testfile:
-            testfile.write("Useless random data {}".format(random.random()))
-        self.git("add {}".format(testfilename), self.gitdir)
-        self.git("commit -a -m \"This random commit {}. I'm useless.\"".format(random.random()), self.gitdir)
+        branch = self.git("branch --show-current", self.gitdir).split()
+        with open(os.path.join(self.gitdir, self.testfilename), "w") as testfile:
+            testfile.write("File {} from branch {}; Useless random data {}".format(self.testfilename, branch, random.random()))
+        self.git("add {}".format(self.testfilename), self.gitdir)
+        self.git("commit -a -m \"This random commit {} in branch {}. I'm useless.\"".format(random.random(), branch), self.gitdir)
         bb.process.run('tar -czvf {} .'.format(os.path.join(self.mirrordir, self.mirrorname)), cwd =  self.gitdir)
         return self.git("rev-parse HEAD", self.gitdir).strip()
 
+    def git_new_branch(self, name):
+        self.git_new_commit()
+        head = self.git("rev-parse HEAD", self.gitdir).strip()
+        self.git("checkout -b {}".format(name), self.gitdir)
+        newrev = self.git_new_commit()
+        self.git("checkout {}".format(head), self.gitdir)
+        return newrev
+
     def test_mirror_commit_nonexistent(self):
         self.make_git_repo()
         self.d.setVar("SRCREV", "0"*40)
@@ -3083,6 +3093,55 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.NetworkAccess):
             fetcher.download()
 
+    def test_mirror_tarball_multiple_branches(self):
+        """
+        test if PREMIRRORS can handle multiple name/branches correctly
+        both branches have required revisions
+        """
+        self.make_git_repo()
+        branch1rev = self.git_new_branch("testbranch1")
+        branch2rev = self.git_new_branch("testbranch2")
+        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1,testbranch2;protocol=https;name=branch1,branch2"
+        self.d.setVar("SRCREV_branch1", branch1rev)
+        self.d.setVar("SRCREV_branch2", branch2rev)
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        self.assertTrue(os.path.exists(self.mirrorfile), "Mirror file doesn't exist")
+        fetcher.download()
+        fetcher.unpack(os.path.join(self.tempdir, "unpacked"))
+        self.assertTrue(os.path.exists(os.path.join(self.tempdir, "unpacked", "git", self.testfilename)),\
+                                                     "Repo has not been unpackaged properly!")
+
+    def test_mirror_tarball_multiple_branches_nobranch(self):
+        """
+        test if PREMIRRORS can handle multiple name/branches correctly
+        Unbalanced name/branches raises ParameterError
+        """
+        self.make_git_repo()
+        branch1rev = self.git_new_branch("testbranch1")
+        branch2rev = self.git_new_branch("testbranch2")
+        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1;protocol=https;name=branch1,branch2"
+        self.d.setVar("SRCREV_branch1", branch1rev)
+        self.d.setVar("SRCREV_branch2", branch2rev)
+        with self.assertRaises(bb.fetch2.ParameterError):
+            fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+
+    def test_mirror_tarball_multiple_branches_norev(self):
+        """
+        test if PREMIRRORS can handle multiple name/branches correctly
+        one of the branches specifies non existing SRCREV
+        """
+        self.make_git_repo()
+        branch1rev = self.git_new_branch("testbranch1")
+        branch2rev = self.git_new_branch("testbranch2")
+        self.recipe_url = "git://git.fake.repo/bitbake;branch=testbranch1,testbranch2;protocol=https;name=branch1,branch2"
+        self.d.setVar("SRCREV_branch1", branch1rev)
+        self.d.setVar("SRCREV_branch2", "0"*40)
+        fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
+        self.assertTrue(os.path.exists(self.mirrorfile), "Mirror file doesn't exist")
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+
+
 class FetchPremirroronlyNetworkTest(FetcherTest):
 
     def setUp(self):
-- 
2.41.0


