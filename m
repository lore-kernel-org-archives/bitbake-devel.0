Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7FDC54E51
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:51 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.2224.1709071485817156863
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=IPfSAv8m;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4c359e48aso3100632b3a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071485; x=1709676285; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqKOw1uhQzbEcZlLZczArygnCwYvkY6zV5GdIcqo6do=;
        b=IPfSAv8mlsDz5T5Go7Grr8ViQql1SXQcEspJ5rrGSWX7B1H5HjWeYX8OUxZdc1sWBg
         EiBYLaF2qLtJMJQzv1Ar01s9KPylYO5Uo5bGPbI3X+S44MbkHw4dCCAei+OCB1ZA8l/8
         YalxopZLZCqrpUeLt2VlxQSZNiAkc3YP1R5DzTb2IslrYmMP+C7HegYUzj2C+pCP1zXx
         R78B1+tHeOvHgFQaHSGvpTpRJ94ZngIb0ps1Z760kHV54JG2Ef+HCoHxAEbOQalE/LqF
         rXv/pP37qDLPmA0HbDzV5xwCL/cUrK9C+eARk0y4JlL+6ptH/3mIvowQWX6/tMmVnkvo
         QhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071485; x=1709676285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqKOw1uhQzbEcZlLZczArygnCwYvkY6zV5GdIcqo6do=;
        b=SjMxxC1RxmQRUaOsshi9izeQZ2nJTFUFFxEQHp+S4lBwDcKroDNJdlPTdRXNsqz2iq
         f/jsib8Sb5yQNOcQeS7+KG1J/KFsjgTjEhYncHkVSPb0oBnPPVT1nxs2ePc31gJlfwCF
         hQT2WyaixbGvAOZuVBXOsRsrIBy4siqiIPc56uHODi9cLx4XwvbCdZwTUpNQcD/iM6uR
         67itvr8slBcLgCa7x7Z0hT5Fg2OwHUR+Cdk1BhmWawDAUn+JaviZII2cBB4X8/xgYNgj
         JJh98pfyG2naz0TGoKjVF2U9sq7MRsU9miNFVAvxhbZxBMvnmA4jqJGHPSgLlMOOsIZK
         Kzgw==
X-Gm-Message-State: AOJu0Yw0QurOG30kYIMC8MnXnmUYjzkXnYwOdbG1smrtHvO8LxjjnvAE
	dHlZ9osCybAAiGYBpworXzK55h+XjF5RCW2o/l8eqJ+V0XSwrQFX/poFu/rp5splPPm1BfGyeOl
	qst4=
X-Google-Smtp-Source: AGHT+IGaqIn+///cUz7zVB1GanxFLmqYZdBfu7k8lpwWFmBK7KujJomkknW8vwZgw2ozk/brgPrDpg==
X-Received: by 2002:a05:6a00:13a1:b0:6e5:55b9:b64 with SMTP id t33-20020a056a0013a100b006e555b90b64mr1906298pfg.1.1709071485081;
        Tue, 27 Feb 2024 14:04:45 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:44 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 5/6] tests/fetch: Add real git lfs tests and decorator
Date: Tue, 27 Feb 2024 12:04:24 -1000
Message-Id: <2a6fd774405a58f3ef2953a0dc3eca063e0cf890.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709071317.git.steve@sakoman.com>
References: <cover.1709071317.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15971

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
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 743d3e3ff..847a35602 100644
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
2.34.1


