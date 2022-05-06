Return-Path: <pavel@zhukoff.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA69C433F5
	for <webhook@archiver.kernel.org>; Fri,  6 May 2022 09:02:06 +0000 (UTC)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by mx.groups.io with SMTP id smtpd.web08.7473.1651827718746038749
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 May 2022 02:01:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@zhukoff.net header.s=fm1
 header.b=hzpGbgVH;
 spf=pass (domain: zhukoff.net, ip: 66.111.4.224, mailfrom: pavel@zhukoff.net)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 0DBE3580C68;
	Fri,  6 May 2022 05:01:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 06 May 2022 05:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zhukoff.net; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1651827718; x=1651834918; bh=w6Xlbxa2nelIiNjbPRaGWukpL
	QAjI3m4R3bIqZDt9Yw=; b=hzpGbgVHkDT7xyhTHN9QldfQHUq0Evbz8axJtkseq
	EfAhv8MH91UJHC+kG4YbTZfK82g0+ifM/2N12x2p40Xb0kfJ0snCufvbRPjbC7PW
	25xb1IpVwmdYJ5b+h9ZbPSWuM9scWg/dynNc0xG8jBdDyBjvfdiYBw35lmdMqu1b
	eQyVdQlnlm1ll9peTAQ5LjOqsJXEDdPlaEdH54+yJq8IQDUJHxrRMsvGOl/RS1nI
	z+9U3+yWzxy7SQmKzSL6nchWddkgOZKvTBxz6yIub7Izg71Y2QnF/qAk9x19005D
	gAaX4Tm1PBGlhdaVh/+xIHbGAcw962UMqpSziRCOPjVYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1651827718; x=1651834918; bh=w
	6Xlbxa2nelIiNjbPRaGWukpLQAjI3m4R3bIqZDt9Yw=; b=lnjWLUKuYiEl+px8K
	9uTj39HRpgqg6tSUfSlUrzLpCop0uZ0Ngt5RbA8CA0R0tQ+eJyrhQaHRTJaZ5q6t
	/tkv7wiRFBDq3vF5WlMU5V0lwBBw1GV5V3i3W9IudYoiMeCKfH4cVaxO5tKnhBQz
	Dbd3jNiECJKBTx3TZ5qbQCR1VTz97VSHIE8wWxBAsZX9i+4epokFguTe+XjWCnYD
	B/hStjkvc+Ver9/xUSwEb5BlWokrw3oFG+h00YgnrkYaTO/u6SSqRMb82NMs9kwB
	KWpq4VCbbbXLjuJFwdMFjxzsJVOnIX23XHMd2CDmHf+BeZrJPKUnV60+v2/B0+ET
	E6CFw==
X-ME-Sender: <xms:BeR0YtGGXfJEklv28E4641ACeiCXBvLVLM44TPprSC8KIRlxdFrGxQ>
    <xme:BeR0YiVJlAc3jMRZUwhNos9res-BGURGLxDFeFZ7-WSEE_WOn6mVtEmd1keCZZQ1i
    ymS1eX57Niw3iFntMg>
X-ME-Received: 
 <xmr:BeR0YvK6Vu_h49Ec4PaCgUZLP1X-S-zQUyWcuffaeuOp-BiC2OPDJIhkMinFOkEpbLzlbYSrBpiM5zo8sTHjLNg>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogevohgrshhtrghlqdfhgeduvddqtddvucdludehtd
    dmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheprfgrvhgv
    lhcukghhuhhkohhvuceophgrvhgvlhesiihhuhhkohhffhdrnhgvtheqnecuggftrfgrth
    htvghrnhepgfehieeuveetvdeuieevudevgeetudeikeevudeigfegheeiueelvdelffef
    vefhnecuffhomhgrihhnpehuthhilhhsrdhtohdpphhrohgtvghsshdrrhhunhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghvvghlseii
    hhhukhhofhhfrdhnvght
X-ME-Proxy: <xmx:BeR0YjFx3kv0dXmCLiUHckkIOrrtmKxhlikeIEDhm8zUv-vYOnpN9w>
    <xmx:BeR0YjX81zp8M3pExfpwSlqwLZ-IzL6yFdIy-V7p9slHYG4YVBLe8g>
    <xmx:BeR0YuOcUBJmyUpUUdp9ivnSPuOKT8O_sbFVS76uSpy5OjGgAZZt6Q>
    <xmx:BuR0YkeEkTO8-fjGiNXb40ffy0Kk1rKI37X1tu6QRcyzrPZ8yMdh-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 May 2022 05:01:56 -0400 (EDT)
From: Pavel Zhukov <pavel@zhukoff.net>
To: bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
Subject: [PATCH v2] Honour BB_FETCH_PREMIRRORONLY option
Date: Fri,  6 May 2022 10:58:47 +0200
Message-Id: <20220506085845.22974-1-pavel@zhukoff.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 May 2022 09:02:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13672

This should fix [Yocto 13353] and related to [Yocto 13233] as well.
Previously if git repo mirror has been updated in between of two builds
fetcher of the second build didn't try updated mirror but switched to
git clone from upstream instead. This is problem for offline builds.
Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
specified by the mirror doesn't contain SRC_REV.

Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
---
 lib/bb/fetch2/__init__.py |  2 ++
 lib/bb/fetch2/git.py      | 18 +++++------
 lib/bb/tests/fetch.py     | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5dfe5ff3..ce013eb2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1744,6 +1744,8 @@ class Fetch(object):
                             done = False
 
                 if premirroronly:
+                    if not done:
+                        raise FetchError("Failed to download premirror {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREMIRRORS")))
                     self.d.setVar("BB_NO_NETWORK", "1")
 
                 firsterr = None
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4d06a571..0d5f6048 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -335,11 +335,7 @@ class Git(FetchMethod):
     def try_premirror(self, ud, d):
         # If we don't do this, updating an existing checkout with only premirrors
         # is not possible
-        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
-            return True
-        if os.path.exists(ud.clonedir):
-            return False
-        return True
+        return bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")) or not os.path.exists(ud.clonedir)
 
     def download(self, ud, d):
         """Fetch url"""
@@ -350,10 +346,14 @@ class Git(FetchMethod):
         if ud.shallow and os.path.exists(ud.fullshallow) and self.need_update(ud, d):
             ud.localpath = ud.fullshallow
             return
-        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clonedir):
-            bb.utils.mkdirhier(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
-
+        if os.path.exists(ud.fullmirror):
+            if self.try_premirror(ud, d) and self.need_update(ud, d):
+                bb.utils.mkdirhier(ud.clonedir)
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=ud.clonedir)
+                if self.need_update(ud, d) and \
+                   bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
+                    raise bb.fetch2.FetchError("Premirror doesn't contain revisions {} and "\
+                            "upstream cannot be used due to BB_FETCH_PREMIRRORONLY setting".format(ud.revisions))
         repourl = self._get_repo_url(ud)
 
         # If the repo still doesn't exist, fallback to cloning it
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 233ecae7..62c7296e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2800,3 +2800,66 @@ class GitSharedTest(FetcherTest):
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


