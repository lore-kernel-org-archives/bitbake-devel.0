Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300CACD691F
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 09:47:07 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
 by mx.groups.io with SMTP id smtpd.web10.87506.1696931223566000152
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Oct 2023 02:47:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zhukoff.net header.s=fm2 header.b=T/mZ6XU9;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=PLg61znU;
 spf=pass (domain: zhukoff.net, ip: 64.147.123.19, mailfrom: pavel@zhukoff.net)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 64F9B3200A1A;
	Tue, 10 Oct 2023 05:47:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 10 Oct 2023 05:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1696931221; x=1697017621; bh=fp89Rm6dzQ
	T4UCQqXPhBOYCmowE6Sz01kl+nq9nsaBc=; b=T/mZ6XU9UmeNxg3/b7mHu4TJ8L
	eEHxCgqYNF5vAgDt6mjtgWOixZsL5TV/Iiz0OXKjIxXkfEuM0fDVI+UoS98WaQy9
	BY3mLiY2JkrxUF7DqX6UUr2byPsT0LEbzW5hu2HLen345XzLaTwXAwT7AOEAJz3d
	zrd2ggJf17408WyJFWJSOcQJ6UoasTNwKXE/OeVstapJ6wBt0JYNDbGwbCS6OkWj
	Mq0LR9hfTWzKWN6k31j5Ns4xHAa+bWiJe8mH9m1j0tZ8mmANI+zyzI58BARabBbG
	3BMJBfGT1D076/Oe7GurMlZsUM2LKRlQwnfno/FnppBp7RDntfsmV6luvQJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696931221; x=1697017621; bh=fp89Rm6dzQT4U
	CQqXPhBOYCmowE6Sz01kl+nq9nsaBc=; b=PLg61znUeUX9oDLhucqrOq7sHonmJ
	/gROiz8EsettKvzqr1DvaKtLgqkY1RVZ4L3JwTa7YClZ2L27gRVPd+XG8s9qmDTB
	PRw8cu8psBEk3SPQmhm3qISP/Z04Fe7FuF1X9tTWsHzmN9F791iBLsSYU3+8DJON
	NlLt8Q/ohKNJPgPYD6o6Zlfl2+q8QpQrAmM33H9uAt7m/LmxRw8rqqrn4CpJP2vf
	NSsNGywna7hW9xUWY4qVMo/4d0sIzzv7cUY4bpy32JYq8Jx5Tc9dn/83LV+P6+yr
	Wlm/z5eX7Ul+ald3C4yYpWCp6n2WsJKX28QygnOY0Ve4DC31/ErIDd4Hg==
X-ME-Sender: <xms:lR0lZX92KrCT4sNIo8-UQhOGdISqJfb-6rF4_1ViN6fb5u9OMd2fAA>
    <xme:lR0lZTuqlM_6eevMe5cKCbhkbOStjppZqHkeTgC2RlmTEkEPABYU7RkmkaIrUrrmu
    x7ISMiCcquOtfxIS_4>
X-ME-Received: <xmr:lR0lZVDVAQP6yxCFuJuVkh6I2_COYma1L4-ygqsXVGAVrBV-rfK0PGYcjApTfZakZwIkM_dJljUS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheprfgrvhgvlhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhf
    fhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfevueelgeefiedtkeeiuefhkefhtdefvd
    ekvdegjeevjeffiedtgedtfefhfeetnecuffhomhgrihhnpehprhhotggvshhsrdhruhhn
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgrvh
    gvlhesiihhuhhkohhffhdrnhgvth
X-ME-Proxy: <xmx:lR0lZTcfEThfJ2jODnu7om7hv9G6JuNrKR2Nda0BDJtU0Y_-aPpXIw>
    <xmx:lR0lZcN4TfZ3daUJsFsaYxb1MTl1jxX2C9LOFD144ieltenxhhEz8g>
    <xmx:lR0lZVk5JmijW44ese1clySBFE3fqiqeGhQWrECQ9sNOqDFK9fjhhA>
    <xmx:lR0lZWVMljNx1AetGo_Zk2IOrL1hDvNEo71dkhnlwoxpz1uVWGm23Q>
Feedback-ID: ib94946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 05:47:01 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel@zhukoff.net>
Subject: [PATCH v2] tests/fetch.py: Add tests to cover multiple branch/name parameters
Date: Tue, 10 Oct 2023 11:47:01 +0200
Message-ID: <20231010094701.40733-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Oct 2023 09:47:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15202

Create repository with few branches and test if fetcher can work
with such repository as PREMIRROR

Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
---
 bitbake/lib/bb/tests/fetch.py | 75 ++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index eeb7a31471..0e806c0ff7 100644
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
@@ -3083,6 +3093,59 @@ class FetchPremirroronlyLocalTest(FetcherTest):
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
+        unpacked = os.path.join(self.tempdir, "unpacked", "git", self.testfilename)
+        self.assertTrue(os.path.exists(unpacked), "Repo has not been unpackaged properly!")
+        with open(unpacked, 'r') as f:
+            content = f.read()
+            ## We expect to see testbranch1 in the file, not master, not testbranch2
+            self.assertTrue(content.find("testbranch1") != -1, "Wrong branch has been checked out!")
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


