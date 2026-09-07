Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0E6C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 14:06:49 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35644.1788790004728451795
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 07:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Jf1zpcGy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49557167508so43789105e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788790003; x=1789394803; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNvCv4JK8U9rvwbTQmrY8VgFfvyMpetGsHBaOmcg6sw=;
        b=Jf1zpcGyap6HnBzLFw43O/9WuqoAVQA8CT7J+/i5BUjUNsHeLQViwfVvlu6kD+2RNc
         mUGztxz4GlxCQL5bunTTdStUQ1xzdfU5Gt8CEOEpQ7NGoqBLxkuPDq8ow4KgIV6s0T/k
         MZJXx0Zknt+vce5iuiubYafudCn4XEUXYFOEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788790003; x=1789394803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KNvCv4JK8U9rvwbTQmrY8VgFfvyMpetGsHBaOmcg6sw=;
        b=tTa9MMfTlq1YQDw+rwN2VTebqJ1yHb8rcJF03BZv0oZnduIehbe1lOYkXY+Y1WTjNs
         auHerwVVTGPINVmZeIaNkmOlwzefifNxVSTisIDbSzvPgXI6N8XI7oMbFksE28kyITf0
         U6kH3kVGel3jbh32huO+GjOhbjJeBczqrPEyghV4kDG4/BnZ/GhfFcG8D0DRx46PjJLy
         YczCfZXr1IVricF3JNhgoBAvaS7j3x3EbglXHuzK47ehE9YBKWGciFZQboENBd1r+FDK
         s4Pxql7RFz2R/P1P9rbrIpPWK2yA1aCcEhdUnZ53oL0db7E2rBvi/2qU8JFZ4PLbDqZU
         RmEQ==
X-Gm-Message-State: AFuF++khMvqqcKqR2VscTXMjFQtQ4x0LaV+FHwOBHsVGdZK/e880tXhQ
	Ssa+A+unObKncy7vUTquFCBBsc0geVokEKEbWmITes4/wvlYcS13i2N0vWQSreGFQzAvkObSjWq
	8QsoUv9I=
X-Gm-Gg: AYBFou1Sw8OLI5AWDO6jtUt/6aGXRaKidNzh5wmqfSF6kSCnJL2zylMhquj4Uvn+wZX
	qAqnevIl/zCplQoR2S5rLzKccSRw32eDVvQLk6DTLJtYQWkwcv+sRx+3C64q5ndD/y6inBxKT4V
	WvXROZ+thgOQagV2iJZXO8Z5eC/aLRSleEztixZdMTWpQhxPC34PPcg1Ubu9C2LyHMjcNxpRGHV
	+1VqPxfULb296y6HzPGF3wT3VtU5yiSjBTOurQ+oORppGspXDNzuffxOTeTJ/pFoEVcbgy9CzKz
	YL3j8kZzA0GEfh1gWK3KlKIu0b7WhB4AmnrFYmQkdhUyPrAACAQwhS/JJIyUdbnR/Za0HePq/F+
	WUgpeMVoC5kOy0CGCL8D9YtRNxK/GkYBuJVFvgXr6jXGd62nRQffZVcEahhnNHGSJu4QDJbqtz/
	hYfqCszQyQtpWaK4pUFM5Te6QeDy4obMtE2N+ZynGe1u5UK9fuFTKTJQjSnvrJIHpCVu7YXycYp
	G5J7mDSMPOTf5To9EZqHNueVKxm
X-Received: by 2002:a05:600c:8b09:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cf823f57fmr476559365e9.10.1788790002841;
        Mon, 07 Sep 2026 07:06:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485881353e8sm28944564f8f.1.2026.09.07.07.06.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:06:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] tests/fetch: Swap bitbake github mirror for YP one
Date: Mon,  7 Sep 2026 15:06:41 +0100
Message-ID: <20260907140641.4044711-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 14:06:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20164

We need a reliable mirror of the bitbake repo and github is no longer that. Swap
to use the bitbake-contrib repo which carrys enough bitbake data to work for the
tests we need.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4d15a8a235c..e8c1c62175a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -573,8 +573,8 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_dir = "github.com.openembedded.bitbake.git"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_dir = "git.openembedded.org.bitbake-contrib.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
@@ -621,8 +621,8 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "git2_git.openembedded.org.bitbake-contrib.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -655,8 +655,8 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "gitshallow_git.openembedded.org.bitbake-contrib.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
@@ -2461,7 +2461,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git(['remote', 'add', '--mirror=fetch', 'origin', 'https://github.com/openembedded/bitbake'], cwd=self.srcdir)
+        self.git(['remote', 'add', '--mirror=fetch', 'origin', 'https://git.openembedded.org/bitbake-contrib'], cwd=self.srcdir)
         self.git(['config', 'core.bare', 'true'], cwd=self.srcdir)
         self.git(['fetch'], cwd=self.srcdir)
 

