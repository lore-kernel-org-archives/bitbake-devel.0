Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE04BC54798
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 06:18:48 +0000 (UTC)
Received: from esa13.hc324-48.eu.iphmx.com (esa13.hc324-48.eu.iphmx.com [207.54.72.35])
 by mx.groups.io with SMTP id smtpd.web10.6882.1709014724577341358
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Feb 2024 22:18:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=PSTGd2JA;
 spf=pass (domain: bmw.de, ip: 207.54.72.35, mailfrom: prvs=780903e03=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1709014724; x=1740550724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOmcdq8wpBamk6BM5PGOr6UzdXTK7qzMJyrDGio5CNQ=;
  b=PSTGd2JAaTwtr12D6lY9xhGg2DpakHvEGszQc1uZnWa4duWoA1wJYPvZ
   COgtOYBS2E/50cmxT8Z5/EDW3OHKSHQMl/9LRKjIUuEnSeqvhWN4KrnTz
   ywzRQtFKIqCga+aFy0XUgdpOieE6Cn1xugC33gXDDuCu6FQUuVH2I2S0a
   0=;
X-CSE-ConnectionGUID: v2j7LEQ+QtOZFclK2Gnjrg==
X-CSE-MsgGUID: 22UEP6sfSXi7z1ElKJ8yLw==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa13.hc324-48.eu.iphmx.com with ESMTP/TLS; 27 Feb 2024 07:18:43 +0100
Received: from esabb4.muc ([160.50.100.33])  by esagw4.muc with ESMTP/TLS;
 27 Feb 2024 07:18:42 +0100
Received: from smucmp10e.bmwgroup.net (HELO SMUCMP10E.europe.bmw.corp) ([10.30.13.87])
 by esabb4.muc with ESMTP/TLS; 27 Feb 2024 07:18:43 +0100
Received: from localhost.localdomain (10.30.85.207) by SMUCMP10E.europe.bmw.corp
 (2a03:1e80:a15:58f::2027) with Microsoft SMTP Server (version=TLS;
 Tue, 27 Feb 2024 07:18:42 +0100
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Paulo Neves <paulo@myneves.com>, Steve Sakoman <steve@sakoman.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>, Philip Lorenz
	<philip.lorenz@bmw.de>
Subject: [kirkstone][PATCH 2/3] tests/fetch: Add real git lfs tests and decorator
Date: Tue, 27 Feb 2024 07:18:07 +0100
Message-ID: <20240227061808.3394661-2-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227061808.3394661-1-philip.lorenz@bmw.de>
References: <20240227061808.3394661-1-philip.lorenz@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCMP04G.europe.bmw.corp (2a03:1e80:a15:58f::217e) To
 SMUCMP10E.europe.bmw.corp (2a03:1e80:a15:58f::2027)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 06:18:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15963

From: Paulo Neves <paulo@myneves.com>

Added tests that verify that git-lfs works with an actual
real git-lfs server. This was not previously the case because
the repo in the test was a simulation of git-lfs but not
a real git lfs repo.

The 2 added tests are almost the same but test that the
git lfs file checkout is successfult with or without the
lfs=1 flag. The lfs=1 URI parameter is a quirk that triggers
2 different code paths for git lfs.

lfs=1, when used on git lfs repositories triggers the git lfs
downloading at the fetch bare stage.

lfs query parameter unset triggers the git lfs downloading only
on checkout as an implicit behavior of git. This leads to possible
network access on the unpack stage and outside the DL_DIR.

lfs=0 actually disables git-lfs functionality even if supported.

(cherry picked from commit d2be7f7f652360f13cd66d0850f3e19ffe2afb0a)

Signed-off-by: Paulo Neves <paulo@myneves.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 743d3e3f..847a3560 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2159,6 +2159,12 @@ class GitShallowTest(FetcherTest):
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
 
@@ -2192,6 +2198,44 @@ class GitLfsTest(FetcherTest):
         ud = fetcher.ud[uri]
         return fetcher, ud
 
+    def get_real_git_lfs_file(self):
+        self.d.setVar('PATH', os.environ.get('PATH'))
+        fetcher, ud = self.fetch()
+        fetcher.unpack(self.d.getVar('WORKDIR'))
+        unpacked_lfs_file = os.path.join(self.d.getVar('WORKDIR'), 'git', "Cat_poster_1.jpg")
+        return unpacked_lfs_file
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds_without_lfs_param(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git;protocol=https;branch=master")
+        f = self.get_real_git_lfs_file()
+        self.assertTrue(os.path.exists(f))
+        self.assertEqual("c0baab607a97839c9a328b4310713307", bb.utils.md5_file(f))
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git;protocol=https;branch=master;lfs=1")
+        f = self.get_real_git_lfs_file()
+        self.assertTrue(os.path.exists(f))
+        self.assertEqual("c0baab607a97839c9a328b4310713307", bb.utils.md5_file(f))
+
+    @skipIfNoGitLFS()
+    @skipIfNoNetwork()
+    def test_real_git_lfs_repo_succeeds(self):
+        self.d.setVar('SRC_URI', "git://gitlab.com/gitlab-examples/lfs.git;protocol=https;branch=master;lfs=0")
+        f = self.get_real_git_lfs_file()
+        # This is the actual non-smudged placeholder file on the repo if git-lfs does not run
+        lfs_file = (
+                   'version https://git-lfs.github.com/spec/v1\n'
+                   'oid sha256:34be66b1a39a1955b46a12588df9d5f6fc1da790e05cf01f3c7422f4bbbdc26b\n'
+                   'size 11423554\n'
+        )
+
+        with open(f) as fh:
+            self.assertEqual(lfs_file, fh.read())
+
     def test_lfs_enabled(self):
         import shutil
 
-- 
2.43.2


