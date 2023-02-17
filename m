Return-Path: <paulo@myneves.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10586C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 17:00:55 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by mx.groups.io with SMTP id smtpd.web10.11891.1676653248591436865
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 09:00:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@myneves.com header.s=protonmail header.b=Ht0xnLQ+;
 spf=pass (domain: myneves.com, ip: 185.70.40.22, mailfrom: paulo@myneves.com)
Date: Fri, 17 Feb 2023 17:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myneves.com;
	s=protonmail; t=1676653245; x=1676912445;
	bh=n3di+MqqcUMuB5k5EXJZhiiGTgk05JCqwl7gYGdF0Bo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ht0xnLQ+snuyf1+L7dWTKmOPnWEg0mJefYsOF986BS9Cu4i8a3gq3oUrC/pwp0niZ
	 2R+vWpACxlUtAPfUQPwuZvWBtu0++NNzcLhqdWa1CUldtvqgNE7JS46yJ4sIM8URB9
	 bMkKHZ07vOA6x8YZRpIqV3p3//PPFgKSMtUwLY5J9ACJ88p3OlT4nvw05RBImQ7sfq
	 lPSpy6alpjB8iMhjBXgKSmVRT9AJSrV+ZgbOTiqNvuf37GIdjEAbuZJBbkqWYceEW6
	 e4OOpYyLFv+TKu2ppGcExv30WbsBDaNopHvA0jNLzYV24X8E7jXU6kaXxx8ZdXhMMl
	 mW5vV0I6Bsevg==
To: bitbake-devel@lists.openembedded.org
From: Paulo Neves <paulo@myneves.com>
Cc: Paulo Neves <paulo@myneves.com>
Subject: [PATCH 2/5] test: Add real git lfs tests and decorator
Message-ID: <20230217170009.58707-2-paulo@myneves.com>
In-Reply-To: <20230217170009.58707-1-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
Feedback-ID: 59941854:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 17:00:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14461

Added tests that verify that git-lfs works with an actual
real git-lfs server. This was not previously the case because
the repo in the test was a simulation of git-lfs but not
a real git lfs repo.

The 2 added tests are almost the same but test that the
git lfs file checkout is successfult with or without the
lfs=3D1 flag. The lfs=3D1 URI parameter is a quirk that triggers
2 different code paths for git lfs.

lfs=3D1, when used on git lfs repositories triggers the git lfs
downloading at the fetch bare stage.

lfs query parameter unset triggers the git lfs downloading only
on checkout as an implicit behavior of git. This leads to possible
network access on the unpack stage and outside the DL_DIR.

lfs=3D0 actually disables git-lfs functionality even if supported.

Signed-off-by: Paulo Neves <paulo@myneves.com>
---
 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6d16cf59a..54148b3fd 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2199,6 +2199,12 @@ class GitShallowTest(FetcherTest):
         self.assertIn("fstests.doap", dir)

 class GitLfsTest(FetcherTest):
+    def skipIfNoGitLFS():
+        import shutil
+        if not shutil.which('git-lfs'):
+            return unittest.skip('git-lfs not installed')
+        return lambda f: f
+
     def setUp(self):
         FetcherTest.setUp(self)

@@ -2232,6 +2238,44 @@ class GitLfsTest(FetcherTest):
         ud =3D fetcher.ud[uri]
         return fetcher, ud

+    def get_real_git_lfs_file(self):
+        self.d.setVar('PATH', os.environ.get('PATH'))
+        fetcher, ud =3D self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        unpacked_lfs_file =3D os.path.join(self.d.getVar('WORKDIR'), 'git'=
, "Cat_poster_1.jpg")
+        return unpacked_lfs_file
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds_without_lfs_param(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git=
;protocol=3Dhttps;branch=3Dmaster")
+        f =3D self.get_real_git_lfs_file()
+        self.assertTrue(os.path.exists(f))
+        self.assertEqual("c0baab607a97839c9a328b4310713307", bb.utils.md5_=
file(f))
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git=
;protocol=3Dhttps;branch=3Dmaster;lfs=3D1")
+        f =3D self.get_real_git_lfs_file()
+        self.assertTrue(os.path.exists(f))
+        self.assertEqual("c0baab607a97839c9a328b4310713307", bb.utils.md5_=
file(f))
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git=
;protocol=3Dhttps;branch=3Dmaster;lfs=3D0")
+        f =3D self.get_real_git_lfs_file()
+        # This is the actual non-smudged placeholder file on the repo if g=
it-lfs does not run
+        lfs_file =3D (
+                   'version https://git-lfs.github.com/spec/v1\n'
+                   'oid sha256:34be66b1a39a1955b46a12588df9d5f6fc1da790e05=
cf01f3c7422f4bbbdc26b\n'
+                   'size 11423554\n'
+        )
+
+        with open(f) as fh:
+            self.assertEqual(lfs_file, fh.read())
+
     def test_lfs_enabled(self):
         import shutil

--
2.34.1



