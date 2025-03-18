Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F95C28B28
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 23:35:57 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.914.1742340950037971414
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 16:35:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SvNsSDZT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912c09be7dso4192249f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742340948; x=1742945748; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKHm4mrktoOgDG08AAbxzDORDd1F6xlTPT9JZ9yuUiM=;
        b=SvNsSDZT77wRp1BaqCKwgYkB8vRUIndgjGzf5Jjyd9+SeDbJ3TL6zWzakxs7bC24Kr
         s1kIDASUsDktpA9dSGdzFPo2PTi4TYMJ7yiJvPy0OuKyIq+ZQpzQKeD/qHot3RXgXZZd
         jXIaMFjnnBJb3OnHNGYxCD92Ef9fXdFcsg/XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742340948; x=1742945748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKHm4mrktoOgDG08AAbxzDORDd1F6xlTPT9JZ9yuUiM=;
        b=CcP27SxHDtvYbQ3CFTefdUh6HdJm5aIah+N9xem0OLuejE3wcp7SZmeIXh/LDGnB1w
         pCYZKsXNCIAtQOwE8G73bJHUEOwKjc80nkf7jvrhuA6bdWmlImFDKrLjaZQDBebcMl0B
         km8QTDZAFspFrBXDZUIzgCpCX0fiHRSxJ2d7/iYGX6IrVh2olI+J3gSyFufXdpKp0v2C
         hER1rorWPeE8rH38CRXfyV9TyZM/zNCTVhbm0uUslt49oTcplfiNii8lm2c2jjeXIuZn
         HeSFNoJHnVk2D7b9vgy1L48QElGF1Jz+u9AwFoJyukI3IzY+ulTCXCozu+Y1iFthNYNr
         siYg==
X-Gm-Message-State: AOJu0Yy4X9k1Ta1tlZZazqslnP696uY/tuWXLpXsIqa2uFUeiISfhSdO
	0oS5Rfl152eefIJvo3jF6w6ZMcwBnvK3QCLNKGnIyauj0blgSopj9jno/US14Tf2BSEEUT+yc9N
	n
X-Gm-Gg: ASbGncvzdPQc1ON5RmSsGtp8BXyLG2lWfpp8zEw+Z0xY/1ifg0Ibp/VKcw89baYj7Bt
	crLbDp/Mb0a4Ey5LKSXhNDeY6PCs+PW+rkUHfT51KyTs0Zf3uTBHin5d03CW2hYCUwiNNBVVncM
	52jqh/Qi67RGYMcLIjEqqSChoAy/xZJFMtA+8ornnTW9hoVv6SZXak4u3zhqOQi5L4RDlI7Teqe
	tF4noeP7NDFOsLwnzSCOMBNZTW5W4Ocb9JfIdUkW7MYUKm7mON2FSwugB/B/pHhluCfipA4OqFG
	xnMpmYyybfxFMGzMCI1elRUGp4jKiyNeMS+R2+qyqBO1DyDkduo48UpKGRSFawte3L5s8aFY2Q=
	=
X-Google-Smtp-Source: AGHT+IECWyuRvw1cAzUanrq7ZCVv4b0jRfAudjti2UWFr2RoqL3LqiebGwZCKlTYH71QCJAk9ApQpg==
X-Received: by 2002:a5d:6d0a:0:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-39973b5083fmr557572f8f.40.1742340947988;
        Tue, 18 Mar 2025 16:35:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:686c:8c32:99b8:c349])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c82c258bsm18969677f8f.24.2025.03.18.16.35.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:35:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] tests/fetch: Add missing branch parameter to tests
Date: Tue, 18 Mar 2025 23:35:45 +0000
Message-ID: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 23:35:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17462

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 659a5b8ad7..77c0b99eea 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -474,16 +474,16 @@ class FetcherTest(unittest.TestCase):
 class MirrorUriTest(FetcherTest):
 
     replaceuris = {
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir/")
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/.*", "http://somewhere.org/somedir/")
             : "http://somewhere.org/somedir/git2_git.invalid.infradead.org.mtd-utils.git.tar.gz",
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/\\2;protocol=http")
-            : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
-        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
-            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/\\2;protocol=http")
+            : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
+            : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master",
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
         ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/")
@@ -496,12 +496,12 @@ class MirrorUriTest(FetcherTest):
             : "http://archive.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://.*/.*", "file:///somepath/downloads/")
             : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
-            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
+            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org")
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/")
@@ -517,9 +517,9 @@ class MirrorUriTest(FetcherTest):
             : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz",
         ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz")
             : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz",
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", r"git://(?!internal\.git\.server).*/.*", "http://somewhere.org/somedir/")
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", r"git://(?!internal\.git\.server).*/.*", "http://somewhere.org/somedir/")
             : "http://somewhere.org/somedir/git2_git.invalid.infradead.org.mtd-utils.git.tar.gz",
-        ("git://internal.git.server.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", r"git://(?!internal\.git\.server).*/.*", "http://somewhere.org/somedir/")
+        ("git://internal.git.server.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;branch=master", r"git://(?!internal\.git\.server).*/.*", "http://somewhere.org/somedir/")
             : None,
 
         #Renaming files doesn't work
@@ -705,7 +705,7 @@ class GitShallowTarballNamingTest(FetcherTest):
 class CleanTarballTest(FetcherTest):
     def setUp(self):
         super(CleanTarballTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake;protocol=https"
+        self.recipe_url = "git://git.openembedded.org/bitbake;protocol=https;branch=master"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
@@ -1126,7 +1126,7 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_repository_when_premirror_rewrites_the_recipe_url(self):
         realurl = "https://git.openembedded.org/bitbake"
-        recipeurl = "git://someserver.org/bitbake;protocol=https"
+        recipeurl = "git://someserver.org/bitbake;protocol=https;branch=master"
         self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
         os.chdir(self.tempdir)
         self.git(['clone', realurl, self.sourcedir], cwd=self.tempdir)
@@ -2025,7 +2025,7 @@ class GitShallowTest(FetcherTest):
         self.git('submodule update', cwd=self.srcdir)
         self.git('commit -m submodule -a', cwd=self.srcdir)
 
-        uri = 'gitsm://%s;protocol=file;subdir=${S}' % self.srcdir
+        uri = 'gitsm://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
 
         # Fetch once to generate the shallow tarball
         fetcher, ud = self.fetch(uri)
@@ -3381,7 +3381,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.reponame = "fstests"
         self.clonedir = os.path.join(self.tempdir, "git")
         self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
-        self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https"
+        self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https;branch=master"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "0")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
@@ -3463,7 +3463,7 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
         os.mkdir(self.mirrordir)
         self.reponame = "bitbake"
         self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
-        self.recipe_url = "git://git.fake.repo/bitbake;protocol=https"
+        self.recipe_url = "git://git.fake.repo/bitbake;protocol=https;branch=master"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")

